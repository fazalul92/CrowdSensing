USE crowdsensingdb;

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mturk_id` varchar(20) NOT NULL,
  `created_at` datetime NOT NULL,
  `completion_state` tinyint(4) NOT NULL COMMENT '0 = not completed, 1 = completed.',
  `status_state` int(11) NOT NULL DEFAULT '0' COMMENT '0 = new user, 1 = presurvey, 2 = personality, 3 = creativity, 10 = prereqs completed.',
  `completion_code` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8;users

CREATE TABLE IF NOT EXISTS `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `link` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

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
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `presurvey_responses`
--

CREATE TABLE IF NOT EXISTS `presurvey_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table contents for table 'presurvey_questions'
--

INSERT INTO `presurvey_questions` (`id`, `description`, `question_type`, `answer_choices`, `required`) VALUES
(1, 'What is your gender?', 'multiple_choice_radio', 'Male|Female|Other', 1),
(2, 'Which of the following categories includes your age?', 'multiple_choice_radio', '18 to 24|25 to 34|35 to 45|45 to 54|55 or older', 1),
(3, 'What is the highest level of school you have completed or the highest degree you have received?', 'multiple_choice', 'Less than high school degree|High school degree or equivalent (e.g., GED)|Some college but no degree|Bachelor degree|Graduate degree', 1),
(4, 'How do you rate your proficiency in using smartphones?', 'multiple_choice_radio', 'Very low|Low|Medium|High|Very high', 1),
(5, 'Please use the text box if you need to clarify any of your answers above', 'text', 'Optional clarifications', 0);

-- --------------------------------------------------------

--
-- Table structure for table `postsurvey_questions`
--

CREATE TABLE IF NOT EXISTS `postsurvey_questions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `question_type` varchar(50) DEFAULT NULL,
  `answer_choices` varchar(255) DEFAULT NULL,
  `required` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4 ;

-- --------------------------------------------------------

INSERT INTO `postsurvey_questions` VALUES 
(1,'How long did the main tasks (excluding pre and post surveys) take? Please count only the actual time you spent on the task, not the intermittent time you might have spent on other tasks.','text','duration in hours:minutes, e.g., 00:30 for thirty minutes',1),
(2,'How do you rate the difficulty of main tasks?','multiple_choice','Very easy|Easy|Medium|High|Very high',1),
(3,'Please provide any additional comments you have below','text','Optional comments',0);

--
-- Table structure for table `postsurvey_responses`
--

CREATE TABLE IF NOT EXISTS `postsurvey_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

-- --------------------------------------------------------

--
-- Table  'statuses'
--
CREATE TABLE IF NOT EXISTS `statuses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `seq_no` int(11) NOT NULL,
  `title` varchar(25) NOT NULL,
  `filename` varchar(20) NOT NULL,
  `next_seq` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

INSERT INTO `statuses` VALUES 
(1,1,'Presurvey','presurvey.jsp',2),
(2,2,'Main Instructions','debrief.jsp',4),
(3,2,'Add Routine','routine.jsp',4),
(4,4,'Post-Survey','postsurvey.jsp',5),
(5,5,'Completion','completed.jsp',5);

-- --------------------------------------------------------

--
-- Table 'logs'
--
CREATE TABLE IF NOT EXISTS `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `message` varchar(25) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=78 ;

-- ---------------------------------------------------------

CREATE TABLE IF NOT EXISTS `routine_responses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) DEFAULT NULL,
  `day` varchar(15) DEFAULT NULL,
  `beginTime` varchar(10) DEFAULT NULL,
  `endTime` varchar(10) DEFAULT NULL,
  `location` varchar(45) DEFAULT NULL,
  `activity` varchar(45) DEFAULT NULL,
  `musicPlayerApp` varchar(45) DEFAULT NULL,
  `ringerManagerApp` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=152 DEFAULT CHARSET=latin1;
