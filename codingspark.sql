-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 19, 2019 at 09:09 AM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingspark`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(11) NOT NULL,
  `name` text NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp(),
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `phone_num`, `msg`, `date`, `email`) VALUES
(1, 'First Post', '123456789', 'First Post Message', '2019-10-12 22:03:27', 'firstpost@gmail.com'),
(3, 'mera naam', '4545454545', 'Hoja bhai ab.', '2019-10-12 23:50:32', 'meraemail@gmail.com'),
(4, 'hey', '123123123', 'mail nai hoga..', '2019-10-13 19:54:17', 'hey@hey.com'),
(5, 'hey', '123123123', 'mail nai hoga..', '2019-10-13 19:59:06', 'hey@hey.com'),
(6, 'hey', '123123123', 'mail nai hoga..', '2019-10-13 20:01:26', 'hey@hey.com'),
(7, 'hey', '123123123', 'mail nai hoga..', '2019-10-13 20:02:16', 'hey@hey.com'),
(8, 'hey', '123123123', 'mail nai hoga..', '2019-10-13 20:02:58', 'hey@hey.com'),
(9, 'hey', '123123123', 'mail nai hoga..', '2019-10-13 20:04:48', 'hey@hey.com'),
(10, 'hey', '1231231231', 'hoja bhai', '2019-10-13 20:08:39', 'hey@man.com'),
(11, 'hey', '1231231231', 'hoja bhai', '2019-10-13 20:16:29', 'hey@man.com'),
(12, 'hey', '1231231231', 'hoja bhai', '2019-10-13 20:19:27', 'hey@man.com'),
(13, 'hey', '1234567654', 'hello', '2019-10-13 20:21:12', 'hey@mac.c'),
(14, 'hello', '987654345', 'hello man', '2019-10-13 20:24:29', 'hello@m.com'),
(15, 'milind', '81818181815', 'Hello Milind here!', '2019-10-18 12:45:18', 'milind@gmail.com'),
(16, 'milind', '81818181815', 'Hello Milind here!', '2019-10-18 12:47:34', 'milind@gmail.com'),
(17, 'milind', '81818181815', 'Hello Milind here!', '2019-10-18 12:47:54', 'milind@gmail.com'),
(18, 'Milind ', '81818181815', 'Heloo!!!1', '2019-10-18 12:49:58', 'milind@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` text NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` text NOT NULL,
  `img_file` varchar(30) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'Let\'s start learning about stock market', 'This is the first post.', 'first-post', 'The stock (also capital stock) of a corporation is all of the shares into which ownership of the corporation is divided. In American English, the shares are commonly known as \"stocks\". A single share of the stock represents fractional ownership of the corporation in proportion to the total number of shares. This typically entitles the stockholder to that fraction of the company\'s earnings, proceeds from liquidation of assets (after discharge of all senior claims such as secured and unsecured debt), or voting power, often dividing these up in proportion to the amount of money each stockholder has invested. Not all stock is necessarily equal, as certain classes of stock may be issued for example without voting rights, with enhanced voting rights, or with a certain priority to receive profits or liquidation proceeds before or after other classes of shareholders.', 'about-bg.jpg', '2019-10-13 20:49:47'),
(3, 'Blockchain Intro', 'Introduction to blockchain', 'third-post', 'In the recent years, there has been an increasing interest in the Blockchain technology. The Blockchain is a novel disruptive technology based on cryptography. It has been known of the work of \r\nNakamoto in 2008 who showed how this technology can become the core component to support transactions of the digital currency (bitcoin) . With the introduction of Blockchain, many fields such as finance, accounting, and real estate will receive a positive impact using the benefits of this technology. One area in which blockchain technology could play a vital role is real estate and smart cities.\r\n', '', '2019-10-14 23:02:02'),
(4, 'Blockchain working', 'Working of Blockchain in system', 'fourth-post', 'A blockchain is a distributed data structure that is replicated and shared among the members of a network. It was introduced with Bitcoin to solve the double-spending problem. As a result of how the nodes on the Bitcoin network (the so-called miners) append validated, mutually agreed-upon transactions to it, the Bitcoin blockchain houses the authoritative ledger of transactions that establishes who owns what.', '', '2019-10-14 23:03:37'),
(5, 'Smart Contract', 'Concept of Smart contract in Blockchain', 'fifth-post', 'The history of smart contracts can be traced back to the 1990s when Wei Dai, a computer engineer created a post on anonymous credits, which described an anonymous loan scheme with redeemable bonds and lump-sum taxes to be collected at maturity [1]. Szabo et al. [93] later discussed the potential form of smart contracts and proposed to use cryptographic mechanisms to enhance security. Nowadays, with the development of blockchain technology, smart contracts are being constructed as computer programs running on blockchain nodes and can be issued among untrusted, anonymous parties without the involvement of any third party. The first successful implementation of a blockchain-based smart contract was Bitcoin Script,  a purposely not-turing-complete language with a set of simple, pre-defined commands.', '', '2019-10-14 23:06:14'),
(6, 'Blockchain in Real Estate', 'Working of Blockchain in Real Estate', 'sixth-post', 'The blockchain technology will allow for the democratization of real estate properties. It will open up the gates for potential investors from across the world to try their hand in real-estate investment. If executed properly, then this can be hugely beneficial for the crypto-space as well, because it will increase the real-life utility of tokens. The scary part is that we have just scratched the surface of what could be possible via the marriage of blockchain and real-estate. Hopefully, we will see more exciting use-cases soon.', '', '2019-10-14 23:08:51'),
(7, 'Tokenizing real estate', 'Advantages of tokenizing real estate', 'new-post', 'Fractional Ownership decreases barriers to entry by a staggering amount. Real estate doesn’t need to be the playground for the rich anymore. Instead of saving up and taking loans to buy one expensive asset, you can simply buy one-fifth of that asset. A multisignature smart contract will make sure that the joint owners adhere to honest conduct.', 'img.jpg', '2019-10-16 00:40:13'),
(8, 'Ownership', 'Fractional Ownership via Tokenization', 'new-post2', 'One of the most interesting outcomes of tokenization is fractional ownership. This is especially intriguing when it comes to expensive assets like real-estate. Instead of one person owning one property, it can be possible for multiple people to buy tokens of the property and co-own the building.', '', '2019-10-16 00:46:28');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
