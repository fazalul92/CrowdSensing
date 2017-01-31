-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 07, 2016 at 12:06 AM
-- Server version: 5.6.17
-- PHP Version: 5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `crowd_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_type` varchar(10) NOT NULL,
  `pid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `gid` int(11) NOT NULL,
  `description` text NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=18 ;

-- --------------------------------------------------------

--
-- Table structure for table `creativity_questions`
--

CREATE TABLE IF NOT EXISTS `creativity_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

-- --------------------------------------------------------

--
-- Table structure for table `creativity_responses`
--

CREATE TABLE IF NOT EXISTS `creativity_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_creativity_responses_user` (`user_id`),
  KEY `FK_creativity_responses_creativity_question` (`question_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

-- --------------------------------------------------------

--
-- Table structure for table `discpersonality_questions`
--

CREATE TABLE IF NOT EXISTS `discpersonality_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_no` int(11) NOT NULL,
  `item_no` int(11) NOT NULL,
  `description` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=113 ;

-- --------------------------------------------------------

--
-- Table structure for table `discpersonality_responses`
--

CREATE TABLE IF NOT EXISTS `discpersonality_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_no` int(11) NOT NULL,
  `item_no` int(11) NOT NULL,
  `response` varchar(10) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=169 ;

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `message` varchar(25) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=78 ;

-- --------------------------------------------------------

--
-- Table structure for table `mbtipersonality_questions`
--

CREATE TABLE IF NOT EXISTS `mbtipersonality_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_no` int(11) NOT NULL,
  `choice_no` int(11) NOT NULL DEFAULT '0',
  `type` varchar(20) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=211 ;

-- --------------------------------------------------------

--
-- Table structure for table `mbtipersonality_responses`
--

CREATE TABLE IF NOT EXISTS `mbtipersonality_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_no` int(11) NOT NULL,
  `choice_no` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=71 ;

-- --------------------------------------------------------

--
-- Table structure for table `personality_data`
--

CREATE TABLE IF NOT EXISTS `personality_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `mbti_E` int(11) DEFAULT NULL,
  `mbti_I` int(11) DEFAULT NULL,
  `mbti_S` int(11) DEFAULT NULL,
  `mbti_N` int(11) DEFAULT NULL,
  `mbti_T` int(11) DEFAULT NULL,
  `mbti_F` int(11) DEFAULT NULL,
  `mbti_J` int(11) DEFAULT NULL,
  `mbti_P` int(11) DEFAULT NULL,
  `ipip_E` int(11) DEFAULT NULL,
  `ipip_A` int(11) DEFAULT NULL,
  `ipip_C` int(11) DEFAULT NULL,
  `ipip_N` int(11) DEFAULT NULL,
  `ipip_O` int(11) DEFAULT NULL,
  `creativity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `personality_questions`
--

CREATE TABLE IF NOT EXISTS `personality_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Table structure for table `personality_responses`
--

CREATE TABLE IF NOT EXISTS `personality_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_personality_responses_user` (`user_id`),
  KEY `FK_personality_responses_personality_question` (`question_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- Table structure for table `postsurvey_questions`
--

CREATE TABLE IF NOT EXISTS `postsurvey_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_group_type` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `question_type` varchar(50) DEFAULT NULL,
  `answer_choices` varchar(255) DEFAULT NULL,
  `required` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

--
-- Table structure for table `postsurvey_responses`
--

CREATE TABLE IF NOT EXISTS `postsurvey_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_postsurvey_responses_user` (`user_id`),
  KEY `FK_postsurvey_responses_postsurvey_question` (`question_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

-- --------------------------------------------------------

--
-- Table structure for table `presurvey_questions`
--

CREATE TABLE IF NOT EXISTS `presurvey_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `question_type` varchar(50) DEFAULT NULL,
  `answer_choices` varchar(255) DEFAULT NULL,
  `required` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Table structure for table `presurvey_responses`
--

CREATE TABLE IF NOT EXISTS `presurvey_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_presurvey_responses_presurvey_questions` (`question_id`),
  KEY `FK_presurvey_responses_user` (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37 ;

-- --------------------------------------------------------

--
-- Table structure for table `requirements`
--

CREATE TABLE IF NOT EXISTS `requirements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(500) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `statuses`
--

CREATE TABLE IF NOT EXISTS `statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seq_no` int(11) NOT NULL,
  `title` varchar(25) NOT NULL,
  `filename` varchar(20) NOT NULL,
  `next_seq` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

-- --------------------------------------------------------

--
-- Table structure for table `testcase_history`
--

CREATE TABLE IF NOT EXISTS `testcase_history` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pid` int(11) NOT NULL,
  `context` varchar(500) NOT NULL,
  `stimuli` varchar(500) NOT NULL,
  `behavior` varchar(500) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `testcases`
--

CREATE TABLE IF NOT EXISTS `testcases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rid` int(11) NOT NULL,
  `uid` int(11) NOT NULL,
  `gid` int(11) NOT NULL,
  `context` varchar(500) NOT NULL,
  `stimuli` varchar(500) NOT NULL,
  `behavior` varchar(500) NOT NULL,
  `created_at` datetime NOT NULL,
  `published` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

-- --------------------------------------------------------

--
-- Table structure for table `usergroups`
--

CREATE TABLE IF NOT EXISTS `usergroups` (
  `gid` int(11) NOT NULL AUTO_INCREMENT,
  `type` int(11) NOT NULL,
  `uid1` int(11) DEFAULT NULL,
  `uid2` int(11) DEFAULT NULL,
  `uid3` int(11) DEFAULT NULL,
  `uid4` int(11) DEFAULT NULL,
  `description` text NOT NULL,
  `status` int(11) NOT NULL COMMENT '1 = empty, 2 = partial, 3 = full',
  PRIMARY KEY (`gid`),
  KEY `uid1` (`uid1`),
  KEY `uid2` (`uid2`),
  KEY `uid3` (`uid3`),
  KEY `uid4` (`uid4`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=34 ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL DEFAULT '0',
  `group_type` int(11) NOT NULL DEFAULT '1' COMMENT '1 = nominal, 2 = non-interactive, 3 = interacting',
  `mturk_id` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL,
  `completion` tinyint(4) NOT NULL COMMENT '0 = not completed, 1 = completed.',
  `personality` int(11) NOT NULL DEFAULT '0',
  `state` int(11) NOT NULL DEFAULT '1' COMMENT '0 = new user, 1 = presurvey, 2 = personality, 3 = creativity, 10 = prereqs completed.',
  `completion_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=30 ;


--
-- Table for Generic Responses
--
CREATE TABLE IF NOT EXISTS `generic_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `generic_name` varchar(30) NOT NULL,
  `choice_no` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;


--
-- Table for Notifications
--
CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `gid` int(11) NOT NULL,
  `link` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `creativity_responses`
--
ALTER TABLE `creativity_responses`
  ADD CONSTRAINT `creativity_responses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `creativity_responses_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `creativity_questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `personality_responses`
--
ALTER TABLE `personality_responses`
  ADD CONSTRAINT `personality_responses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `personality_responses_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `personality_questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `postsurvey_responses`
--
ALTER TABLE `postsurvey_responses`
  ADD CONSTRAINT `postsurvey_responses_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `postsurvey_responses_ibfk_2` FOREIGN KEY (`question_id`) REFERENCES `postsurvey_questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `presurvey_responses`
--
ALTER TABLE `presurvey_responses`
  ADD CONSTRAINT `presurvey_responses_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `presurvey_questions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `presurvey_responses_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `usergroups`
--
ALTER TABLE `usergroups`
  ADD CONSTRAINT `usergroups_ibfk_1` FOREIGN KEY (`uid1`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `usergroups_ibfk_2` FOREIGN KEY (`uid2`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `usergroups_ibfk_3` FOREIGN KEY (`uid3`) REFERENCES `users` (`id`);
  ADD CONSTRAINT `usergroups_ibfk_4` FOREIGN KEY (`uid4`) REFERENCES `users` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
