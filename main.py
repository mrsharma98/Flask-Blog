from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
from werkzeug import secure_filename

from datetime import datetime
import json
import os
import math


#************
#  Variables in python is different and name/id are different in HTML
#  we can give different variable names.
# ****************


# reading config.json and retriving the params of json and assinging it to params. 
with open('config.json', 'r') as c:
    params = json.load(c)['params']

local_server = True

app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config['UPLOAD_FOLDER']  = params['upload_location']# used in uploading a file


app.config.update(         # For sending a mail to our account whenever a user registered to our website.
    MAIL_SERVER = 'smtp.gmail.com',
    MAIL_PORT = '465',
    MAIL_USE_SSL = True,
    MAIL_USERNAME = params['gmail-user'],
    MAIL_PASSWORD = params['gmail-password']
)
mail = Mail(app)

if local_server:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_uri']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['prod_uri']

#app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root:@localhost/codingspark'
# syntax:   'mysql://username:password@localhost/db_name'
db = SQLAlchemy(app)


@app.route('/')
def home():
    posts = Posts.query.filter_by().all()
    last = math.ceil(len(posts)/int(params['no_of_posts']))
    # [0:params['no_of_posts']]

    page = request.args.get('page') # to get the page
    if (not str(page).isnumeric()):  # is page not numeric
        page = 1

    page = int(page)

    posts = posts[(page-1)*int(params['no_of_posts']) : (page-1)*int(params['no_of_posts']) + int(params['no_of_posts'])]
    
    # *** pagination logic ***

    # case1: If on first page
        # prev = None
        #next = page + 1
    if page == 1:
        prev = "#"
        next = "/?page=" + str(page+1)

    # case3: if on last page
    # prev = page - 1
    # next = None
    elif (page == last):
        next = "#"
        prev = "/?page=" + str(page-1)

    # case2: if on middle page
        # prev = page - 1
        # next = page + 1
    else:
        prev = "/?page=" + str(page-1)
        next = "/?page=" + str(page+1)

    return render_template('index.html', params=params, posts=posts, prev=prev, next=next)
    # posts=posts -> to use the post in the index.html 
    # to display the posts on the home page


@app.route('/post/<string:post_slug>', methods=['GET'])     
def post_route(post_slug):
# <string:post_slug> is a string that we have to pass inside the function
# this is the rule of the flask that if we use a anything in the route then, we have to use it in the function.

    post = Posts.query.filter_by(slug=post_slug).first()   # -> go to the Posts an query it and filter it where slug is equal to post_slug
    # there exist multiple post with same slug then Posts.query.filter_by(slug=post).first() -> to get the first one

    return render_template('post.html', params=params, post=post)
    # post=post -> post goes to html page


@app.route('/about')
def about():
    return render_template('about.html', params=params)  


class Contacts(db.Model):
    # sno, name, phone_num, msg, date, email
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    phone_num = db.Column(db.String(12), nullable=False)
    msg = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    email = db.Column(db.String(20), nullable=False)

class Posts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(21), nullable=False)
    content = db.Column(db.String(120), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)
    img_file = db.Column(db.String(20), nullable=True)
    

@app.route('/contact', methods = ['GET', 'POST'])
def contact():
    if request.method == 'POST':
        #Add entry to the database
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        message = request.form.get('message')

        entry = Contacts(name=name, phone_num=phone, msg=message, date=datetime.now(), email=email)
    # the above line will assign value to model Model_name(variable_name_in_model = variable_name_in_request)

        db.session.add(entry)   # this will add a new tutple to the contact table.
        db.session.commit()      # this will commit the chances in database.

        # mail that we will receive after the data gets feeded to database
        mail.send_message("New message from " + name,
                          sender=email, 
                          recipients=[params['gmail-user']],
                          body = message + "\n" +phone
                          )

    return render_template('contact.html', params=params)  


# **** for admin, to manage the post and login logout *****
@app.route('/dashboard', methods=['GET', 'POST'])
def dashboard():

    # session is provided by the flask.

    # if the user is already logged in.
    if ('user' in session and session['user'] == params['admin_user']):
        posts = Posts.query.all()   # to fetch all the post from database

        return render_template('dashboard.html', params=params, posts=posts)

    # if the request is POST then..
    if request.method == 'POST':
        # retrieving uname and pass from the form entered by the user.
        username = request.form.get('uname')
        userpass = request.form.get('pass')

        if  (username == params['admin_user'] and userpass == params['admin_password']):
            # set the session variable
            session['user'] = username   # we are telling to flask that this user is logged in just by creating a session for it.

            posts = Posts.query.all()   # to fetch all the post from database

            return render_template('dashboard.html', params=params, posts=posts)

    return render_template('login.html', params=params)


# **** for editing a post ***
@app.route("/edit/<string:sno>", methods = ['GET', 'POST'])
def edit(sno):

    if ('user' in session and session['user'] == params['admin_user']):  # checking if user is logged in
        if request.method == 'POST':
            # if the request id POST then, take all the parameters of that post request
            box_title = request.form.get('title')
            tline = request.form.get('tline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img_file = request.form.get('img_file')
            date = datetime.now()

            if sno == '0':
                post = Posts(title=box_title, tagline=tline, slug=slug, content=content, img_file=img_file, date=date)
                db.session.add(post)
                db.session.commit()

            else:
                post = Posts.query.filter_by(sno=sno).first()
                post.title = box_title
                post.slug = slug
                post.content = content
                post.tagline = tline
                post.img_file = img_file
                post.data = date

                db.session.commit()

                return redirect('/edit/'+sno)
                # after redirecting to edit/sno page, it's request will not be post and that's why it will
                # return the rendered template given below
    
    post = Posts.query.filter_by(sno=sno).first()  # this will give the post to the post variable 
    return render_template('edit.html', params=params, post=post)


# **** File Uploader ****
@app.route('/uploader', methods = ['GET', 'POST'])
def uploader():
    if ('user' in session and session['user'] == params['admin_user']):
        if request.method == 'POST':
            f = request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'], secure_filename(f.filename)))    # it joins the upload folder to any of our file
            # secure_filename(f.filename) -> this will restrict people to change the file            
            
            return "Uploaded successfully"


@app.route('/delete/<string:sno>')
def delete(sno):
    if ('user' in session and session['user'] == params['admin_user']):
        post = Posts.query.filter_by(sno=sno).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


# *** For Logout ***
@app.route('/logout')
def logout():
    session.pop('user')   # this will kill user's session
    return redirect('/dashboard')

app.run(debug=True)