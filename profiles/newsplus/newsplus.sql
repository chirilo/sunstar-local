-- phpMyAdmin SQL Dump
-- version 4.0.6
-- http://www.phpmyadmin.net
--
-- Φιλοξενητής: localhost
-- Χρόνος δημιουργίας: 03 Ιουλ 2014 στις 15:15:29
-- Έκδοση διακομιστή: 5.5.33
-- Έκδοση PHP: 5.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Βάση: `mt-newsplus7`
--

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `accesslog`
--

DROP TABLE IF EXISTS `accesslog`;
CREATE TABLE `accesslog` (
  `aid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique accesslog ID.',
  `sid` varchar(128) NOT NULL DEFAULT '' COMMENT 'Browser session ID of user that visited page.',
  `title` varchar(255) DEFAULT NULL COMMENT 'Title of page visited.',
  `path` varchar(255) DEFAULT NULL COMMENT 'Internal path to page visited (relative to Drupal root.)',
  `url` text COMMENT 'Referrer URI.',
  `hostname` varchar(128) DEFAULT NULL COMMENT 'Hostname of user that visited the page.',
  `uid` int(10) unsigned DEFAULT '0' COMMENT 'User users.uid that visited the page.',
  `timer` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Time in milliseconds that the page took to load.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Timestamp of when the page was visited.',
  PRIMARY KEY (`aid`),
  KEY `accesslog_timestamp` (`timestamp`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores site access information for statistics.' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `actions`
--

DROP TABLE IF EXISTS `actions`;
CREATE TABLE `actions` (
  `aid` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Primary Key: Unique actions ID.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The object that that action acts on (node, user, comment, system or custom types.)',
  `callback` varchar(255) NOT NULL DEFAULT '' COMMENT 'The callback function that executes when the action runs.',
  `parameters` longblob NOT NULL COMMENT 'Parameters to be passed to the callback function.',
  `label` varchar(255) NOT NULL DEFAULT '0' COMMENT 'Label of the action.',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores action information.';

--
-- Άδειασμα δεδομένων του πίνακα `actions`
--

INSERT INTO `actions` (`aid`, `type`, `callback`, `parameters`, `label`) VALUES
('comment_publish_action', 'comment', 'comment_publish_action', '', 'Publish comment'),
('comment_save_action', 'comment', 'comment_save_action', '', 'Save comment'),
('comment_unpublish_action', 'comment', 'comment_unpublish_action', '', 'Unpublish comment'),
('node_make_sticky_action', 'node', 'node_make_sticky_action', '', 'Make content sticky'),
('node_make_unsticky_action', 'node', 'node_make_unsticky_action', '', 'Make content unsticky'),
('node_promote_action', 'node', 'node_promote_action', '', 'Promote content to front page'),
('node_publish_action', 'node', 'node_publish_action', '', 'Publish content'),
('node_save_action', 'node', 'node_save_action', '', 'Save content'),
('node_unpromote_action', 'node', 'node_unpromote_action', '', 'Remove content from front page'),
('node_unpublish_action', 'node', 'node_unpublish_action', '', 'Unpublish content'),
('system_block_ip_action', 'user', 'system_block_ip_action', '', 'Ban IP address of current user'),
('user_block_user_action', 'user', 'user_block_user_action', '', 'Block current user');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `block`
--

DROP TABLE IF EXISTS `block`;
CREATE TABLE `block` (
  `bid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique block ID.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The module from which the block originates; for example, ’user’ for the Who’s Online block, and ’block’ for any custom blocks.',
  `delta` varchar(32) NOT NULL DEFAULT '0' COMMENT 'Unique ID for block within a module.',
  `theme` varchar(64) NOT NULL DEFAULT '' COMMENT 'The theme under which the block settings apply.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Block enabled status. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Block weight within region.',
  `region` varchar(64) NOT NULL DEFAULT '' COMMENT 'Theme region within which the block is set.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how users may control visibility of the block. (0 = Users cannot control, 1 = On by default, but can be hidden, 2 = Hidden by default, but can be shown)',
  `visibility` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate how to show blocks on pages. (0 = Show on all pages except listed pages, 1 = Show only on listed pages, 2 = Use custom PHP code to determine visibility)',
  `pages` text NOT NULL COMMENT 'Contents of the "Pages" block; contains either a list of paths on which to include/exclude the block or PHP code, depending on "visibility" setting.',
  `title` varchar(64) NOT NULL DEFAULT '' COMMENT 'Custom title for the block. (Empty string will use block default title, <none> will remove the title, text will cause block to use specified title.)',
  `cache` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Binary flag to indicate block cache mode. (-2: Custom cache, -1: Do not cache, 1: Cache per role, 2: Cache per user, 4: Cache per page, 8: Block cache global) See DRUPAL_CACHE_* constants in ../includes/common.inc for more detailed information.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `tmd` (`theme`,`module`,`delta`),
  KEY `list` (`theme`,`status`,`region`,`weight`,`module`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores block settings, such as region and visibility...' AUTO_INCREMENT=157 ;

--
-- Άδειασμα δεδομένων του πίνακα `block`
--

INSERT INTO `block` (`bid`, `module`, `delta`, `theme`, `status`, `weight`, `region`, `custom`, `visibility`, `pages`, `title`, `cache`) VALUES
(1, 'system', 'main', 'bartik', 1, 0, 'content', 0, 0, '', '', -1),
(2, 'search', 'form', 'bartik', 1, -1, 'sidebar_first', 0, 0, 'contact*\r\nnode/16\r\nnode/11\r\n<front>', '', -1),
(3, 'node', 'recent', 'seven', 1, 10, 'dashboard_main', 0, 0, '', '', -1),
(4, 'user', 'login', 'bartik', 1, 0, 'sidebar_first', 0, 0, 'contact*\r\n<front>\r\nnode/16\r\nnode/11', '', -1),
(5, 'system', 'navigation', 'bartik', 1, 0, 'sidebar_first', 0, 0, '', '', -1),
(6, 'system', 'powered-by', 'bartik', 1, 10, 'footer', 0, 0, '', '', -1),
(7, 'system', 'help', 'bartik', 1, 0, 'help', 0, 0, '', '', -1),
(8, 'system', 'main', 'seven', 1, 0, 'content', 0, 0, '', '', -1),
(9, 'system', 'help', 'seven', 1, 0, 'help', 0, 0, '', '', -1),
(10, 'user', 'login', 'seven', 1, 10, 'content', 0, 0, 'contact*\r\n<front>\r\nnode/16\r\nnode/11', '', -1),
(11, 'user', 'new', 'seven', 1, 0, 'dashboard_sidebar', 0, 0, '', '', -1),
(12, 'search', 'form', 'seven', 1, -10, 'dashboard_sidebar', 0, 0, 'contact*\r\nnode/16\r\nnode/11\r\n<front>', '', -1),
(13, 'comment', 'recent', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(14, 'node', 'syndicate', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(15, 'node', 'recent', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(16, 'shortcut', 'shortcuts', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(17, 'system', 'management', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(18, 'system', 'user-menu', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(19, 'system', 'main-menu', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(20, 'user', 'new', 'bartik', 0, 0, '-1', 0, 0, '', '', 1),
(21, 'user', 'online', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(22, 'comment', 'recent', 'seven', 1, 0, 'dashboard_inactive', 0, 0, '', '', 1),
(23, 'node', 'syndicate', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(24, 'shortcut', 'shortcuts', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(25, 'system', 'powered-by', 'seven', 0, 10, '-1', 0, 0, '', '', -1),
(26, 'system', 'navigation', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(27, 'system', 'management', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(28, 'system', 'user-menu', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(29, 'system', 'main-menu', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(30, 'user', 'online', 'seven', 1, 0, 'dashboard_inactive', 0, 0, '', '', -1),
(33, 'superfish', '1', 'bartik', 0, 0, '-1', 0, 0, '', '<none>', -1),
(34, 'superfish', '2', 'bartik', 0, 0, '-1', 0, 0, '', '<none>', -1),
(35, 'superfish', '3', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(36, 'superfish', '4', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(37, 'superfish', '1', 'seven', 0, 0, '-1', 0, 0, '', '<none>', -1),
(38, 'superfish', '2', 'seven', 0, 0, '-1', 0, 0, '', '<none>', -1),
(39, 'superfish', '3', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(40, 'superfish', '4', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(42, 'comment', 'recent', 'newsplus', 0, 0, '-1', 0, 0, '', '', 1),
(43, 'node', 'recent', 'newsplus', 0, 0, '-1', 0, 0, '', '', 1),
(44, 'node', 'syndicate', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(45, 'search', 'form', 'newsplus', 1, -17, 'sidebar_second', 0, 0, 'contact*\r\nnode/16\r\nnode/11\r\n<front>', '', -1),
(46, 'shortcut', 'shortcuts', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(47, 'superfish', '1', 'newsplus', 1, -21, 'navigation', 0, 0, '', '<none>', -1),
(48, 'superfish', '2', 'newsplus', 1, 0, 'pre_header_left', 0, 0, '', '<none>', -1),
(49, 'superfish', '3', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(50, 'superfish', '4', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(51, 'system', 'help', 'newsplus', 1, 0, 'help', 0, 0, '', '', -1),
(52, 'system', 'main', 'newsplus', 1, 0, 'content', 0, 0, '', '', -1),
(53, 'system', 'main-menu', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(54, 'system', 'management', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(55, 'system', 'navigation', 'newsplus', 0, -10, '-1', 0, 0, '', '', -1),
(56, 'system', 'powered-by', 'newsplus', 0, 10, '-1', 0, 0, '', '', -1),
(57, 'system', 'user-menu', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(58, 'user', 'login', 'newsplus', 1, -21, 'sidebar_second', 0, 0, 'contact*\r\n<front>\r\nnode/16\r\nnode/11', '', -1),
(59, 'user', 'new', 'newsplus', 0, 0, '-1', 0, 0, '', '', 1),
(60, 'user', 'online', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(61, 'views', 'comments_recent-block', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(62, 'views', 'archive-block', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(63, 'views', 'comments_recent-block', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(64, 'views', 'archive-block', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(65, 'views', 'comments_recent-block', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(66, 'views', 'archive-block', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(67, 'views', 'mt_hot_posts-block', 'newsplus', 1, -15, 'highlighted', 0, 1, '<front>', '', -1),
(68, 'views', 'mt_hot_posts-block', 'bartik', 0, 0, '-1', 0, 1, '<front>', '', -1),
(69, 'views', 'mt_hot_posts-block', 'seven', 0, 0, '-1', 0, 1, '<front>', '', -1),
(70, 'views', 'mt_latest-block', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(71, 'views', 'mt_latest-block', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(72, 'views', 'mt_latest-block', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(73, 'quicktabs', 'sidebar_tabs', 'seven', 0, 0, '-1', 0, 0, 'contact*\r\nnode/16\r\nnode/11', '<none>', -1),
(74, 'quicktabs', 'sidebar_tabs', 'newsplus', 1, -23, 'sidebar_second', 0, 0, 'contact*\r\nnode/16\r\nnode/11', '<none>', -1),
(75, 'quicktabs', 'sidebar_tabs', 'bartik', 0, 0, '-1', 0, 0, 'contact*\r\nnode/16\r\nnode/11', '<none>', -1),
(76, 'views', 'mt_most_popular-block', 'bartik', 0, 0, '-1', 0, 0, 'contact*\r\nnode/16\r\nnode/11', '', -1),
(77, 'views', 'mt_most_popular-block', 'newsplus', 1, -22, 'sidebar_second', 0, 0, 'contact*\r\nnode/16\r\nnode/11', '', -1),
(78, 'views', 'mt_most_popular-block', 'seven', 0, 0, '-1', 0, 0, 'contact*\r\nnode/16\r\nnode/11', '', -1),
(79, 'views', 'mt_user_latest_posts-block', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(80, 'views', 'mt_user_latest_posts-block', 'newsplus', 1, 0, 'content', 0, 0, '', '', -1),
(81, 'views', 'mt_user_latest_posts-block', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(82, 'views', 'mt_tags_cloud-block', 'newsplus', 1, -17, 'footer_third', 0, 0, '', '', -1),
(83, 'block', '1', 'bartik', 0, 0, '-1', 0, 0, '', 'About', -1),
(84, 'block', '1', 'newsplus', 1, -18, 'footer_first', 0, 0, '', 'About', -1),
(85, 'block', '1', 'seven', 0, 0, '-1', 0, 0, '', 'About', -1),
(89, 'views', 'mt_tags_cloud-block', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(90, 'views', 'mt_tags_cloud-block', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(94, 'block', '4', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(95, 'block', '4', 'newsplus', 1, 0, 'sub_footer_left', 0, 0, '', '', -1),
(96, 'block', '4', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(97, 'views', 'slideshow-block', 'bartik', 0, 0, '-1', 0, 1, '<front>', '<none>', -1),
(98, 'views', 'slideshow-block', 'newsplus', 1, -19, 'banner', 0, 1, '<front>', '<none>', -1),
(99, 'views', 'slideshow-block', 'seven', 0, 0, '-1', 0, 1, '<front>', '<none>', -1),
(100, 'statistics', 'popular', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(101, 'statistics', 'popular', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(102, 'statistics', 'popular', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(103, 'block', '5', 'bartik', 0, 0, '-1', 0, 0, '', 'Stay tuned with us', -1),
(104, 'block', '5', 'newsplus', 1, -16, 'footer_third', 0, 0, '', 'Stay tuned with us', -1),
(105, 'block', '5', 'seven', 0, 0, '-1', 0, 0, '', 'Stay tuned with us', -1),
(106, 'menu', 'menu-subfooter-menu', 'newsplus', 1, 0, 'footer', 0, 0, '', '<none>', -1),
(107, 'menu', 'menu-subfooter-menu', 'bartik', 0, 0, '-1', 0, 0, '', '<none>', -1),
(108, 'menu', 'menu-subfooter-menu', 'seven', 0, 0, '-1', 0, 0, '', '<none>', -1),
(109, 'block', '6', 'bartik', 0, 0, '-1', 0, 1, 'contact*', '<none>', -1),
(110, 'block', '6', 'newsplus', 1, -19, 'sidebar_second', 0, 1, 'contact*', '<none>', -1),
(111, 'block', '6', 'seven', 0, 0, '-1', 0, 1, 'contact*', '<none>', -1),
(112, 'block', '7', 'bartik', 0, 0, '-1', 0, 1, 'contact*', '<none>', -1),
(113, 'block', '7', 'newsplus', 1, -18, 'sidebar_second', 0, 1, 'contact*', '<none>', -1),
(114, 'block', '7', 'seven', 0, 0, '-1', 0, 1, 'contact*', '<none>', -1),
(115, 'menu', 'menu-sidebar-menu', 'bartik', 0, 0, '-1', 0, 0, '<front>\r\ncontact*\r\nnode/16\r\nnode/11', '', -1),
(116, 'menu', 'menu-sidebar-menu', 'newsplus', 1, -20, 'sidebar_second', 0, 0, '<front>\r\ncontact*\r\nnode/16\r\nnode/11', '', -1),
(117, 'menu', 'menu-sidebar-menu', 'seven', 0, 0, '-1', 0, 0, '<front>\r\ncontact*\r\nnode/16\r\nnode/11', '', -1),
(118, 'views', 'mt_news_in_images-block', 'bartik', 0, 0, '-1', 0, 1, '<front>', '', -1),
(119, 'views', 'mt_news_in_images-block', 'newsplus', 1, -19, 'promoted', 0, 1, '<front>', '', -1),
(120, 'views', 'mt_news_in_images-block', 'seven', 0, 0, '-1', 0, 1, '<front>', '', -1),
(121, 'block', '8', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(122, 'block', '8', 'newsplus', 1, 0, 'header', 0, 0, '', '', -1),
(123, 'block', '8', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(124, 'block', '9', 'bartik', 0, 0, '-1', 0, 1, 'node/12', 'Text Block', -1),
(125, 'block', '9', 'newsplus', 1, -23, 'sidebar_first', 0, 1, 'node/12', 'Text Block', -1),
(126, 'block', '9', 'seven', 0, 0, '-1', 0, 1, 'node/12', 'Text Block', -1),
(127, 'views', 'mt_breaking-block', 'newsplus', 1, -20, 'top_content', 0, 1, '<front>', '', -1),
(128, 'views', 'mt_breaking-block', 'bartik', 0, 0, '-1', 0, 1, '<front>', '', -1),
(129, 'views', 'mt_breaking-block', 'seven', 0, 0, '-1', 0, 1, '<front>', '', -1),
(130, 'views', 'mt_latest-block_1', 'newsplus', 1, -20, 'promoted', 0, 1, '<front>', '', -1),
(131, 'views', 'mt_latest-block_1', 'bartik', 0, 0, '-1', 0, 1, '<front>', '', -1),
(132, 'views', 'mt_latest-block_1', 'seven', 0, 0, '-1', 0, 1, '<front>', '', -1),
(133, 'block', '10', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(134, 'block', '10', 'newsplus', 1, -20, 'header_top_right', 0, 0, '', '', -1),
(135, 'block', '10', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(136, 'views', 'mt_most_popular-block_1', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(137, 'views', 'mt_most_popular-block_1', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(138, 'views', 'mt_most_popular-block_1', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(139, 'block', '11', 'bartik', 0, 0, '-1', 0, 1, 'contact*', '<none>', -1),
(140, 'block', '11', 'newsplus', 1, 0, 'banner', 0, 1, 'contact*', '<none>', -1),
(141, 'block', '11', 'seven', 0, 0, '-1', 0, 1, 'contact*', '<none>', -1),
(142, 'menu', 'menu-secondary-menu', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(143, 'menu', 'menu-secondary-menu', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(144, 'menu', 'menu-secondary-menu', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(145, 'views', 'mt_internal_banner-block', 'bartik', 0, 0, '-1', 0, 0, '', '<none>', -1),
(146, 'views', 'mt_internal_banner-block', 'newsplus', 1, -22, 'page_intro', 0, 0, '', '<none>', -1),
(147, 'views', 'mt_internal_banner-block', 'seven', 0, 0, '-1', 0, 0, '', '<none>', -1),
(148, 'views', 'mt_node_navigation-block', 'newsplus', 1, -23, 'page_intro', 0, 0, '', '<none>', -1),
(149, 'views', 'mt_node_navigation-block', 'bartik', 0, 0, '-1', 0, 0, '', '<none>', -1),
(150, 'views', 'mt_node_navigation-block', 'seven', 0, 0, '-1', 0, 0, '', '<none>', -1),
(151, 'views', 'tweets-block', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(152, 'views', 'tweets-block', 'newsplus', 0, 0, '-1', 0, 0, '', '', -1),
(153, 'views', 'tweets-block', 'seven', 0, 0, '-1', 0, 0, '', '', -1),
(154, 'views', 'mt_tweets-block', 'newsplus', 1, -23, 'footer_second', 0, 0, '', '', -1),
(155, 'views', 'mt_tweets-block', 'bartik', 0, 0, '-1', 0, 0, '', '', -1),
(156, 'views', 'mt_tweets-block', 'seven', 0, 0, '-1', 0, 0, '', '', -1);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `block_custom`
--

DROP TABLE IF EXISTS `block_custom`;
CREATE TABLE `block_custom` (
  `bid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The block’s block.bid.',
  `body` longtext COMMENT 'Block contents.',
  `info` varchar(128) NOT NULL DEFAULT '' COMMENT 'Block description.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the block body.',
  PRIMARY KEY (`bid`),
  UNIQUE KEY `info` (`info`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores contents of custom-made blocks.' AUTO_INCREMENT=12 ;

--
-- Άδειασμα δεδομένων του πίνακα `block_custom`
--

INSERT INTO `block_custom` (`bid`, `body`, `info`, `format`) VALUES
(1, '<p>Dramatically expedite functional quality vectors and impactful technologies. Authoritatively productivate <a href="#">next-generation resources</a> via cutting-edge methods of empowerment. Seamlessly predominate wireless markets rather than cutting-edge total linkage.</p>\r\n<p>Phos-fluorescently incentivize <a href="#">adaptive methods of empowerment</a> for bricks-and-clicks supply chains.</p>\r\n<div class="more-link"><?php print l(t(''More ''), ''contact-us''); ?></div>\r\n<br>\r\n<div id="footer-logo" class="logo">\r\n<img src="<?php print base_path() . drupal_get_path(''theme'', ''newsplus'') ;?>/images/footer-logo.png" alt="" />\r\n</div>\r\n<div id="footer-site-name" class="site-name">\r\nNEWS+\r\n</div>\r\n<div id="footer-site-slogan" class="site-slogan">\r\nA news theme for Drupal\r\n</div>', 'About', 'php_code'),
(4, '<p class="copyright">Copyright © 2014 News+. All rights reserved.</p>', 'Copyright', 'full_html'),
(5, '<ul class="social-bookmarks">\r\n<li>\r\n<a href="http://www.facebook.com/morethan.just.themes/"><i class="fa fa-facebook"></i></a>\r\n</li>\r\n<li>\r\n<a href="http://twitter.com/morethanthemes/"><i class="fa fa-twitter"></i></a>\r\n</li>\r\n<li>\r\n<a href="https://plus.google.com/118354321025436191714/posts"><i class="fa fa-google-plus"></i></a>\r\n</li>                        \r\n<li>\r\n<a href="http://www.linkedin.com/company/more-than-themes/"><i class="fa fa-linkedin"></i></a>\r\n</li>\r\n<li>\r\n<a href="http://www.youtube.com/morethanthemes/"><i class="fa fa-youtube-play"></i></a>\r\n</li>\r\n<li>\r\n<a href="http://instagram.com/"><i class="fa fa-instagram"></i></a>\r\n</li>\r\n<!-- \r\n<li>\r\n<a href="http://www.flickr.com/photos/morethanthemes/"><i class="fa fa-flickr"></i></a>\r\n</li>\r\n<li>\r\n<a href="http://vimeo.com/morethanthemes"><i class="fa fa-vimeo-square"></i></a>\r\n</li>\r\n<li>\r\n<a href="http://www.pinterest.com/morethanthemes/"><i class="fa fa-pinterest"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-skype"></i></a>\r\n</li> -->\r\n</ul>\r\n<div class="subscribe-form">\r\n<form action="">\r\n<div>\r\n<div class="form-item form-type-textfield">\r\n<input type="text" class="form-text" name="subscribe" value="Your email address" onfocus="if (this.value == ''Your email address'') {this.value = '''';}" onblur="if (this.value == '''') {this.value = ''Your email address'';}" /></div>\r\n<div class="form-actions">\r\n<input value="" type="submit" id="edit-submit" name="subscribe" class="form-submit">\r\n</div>\r\n</div>\r\n</form>\r\n</div>', 'Stay tuned with us', 'php_code'),
(6, '<h3 class="title">Stay tuned with us</h3>\r\n<p>Don’t forget that you can connect with us through all major social media, by simply clicking on the corresponding logo below.</p>\r\n<ul class="social-bookmarks large">\r\n<li>\r\n<a href="http://www.facebook.com/morethan.just.themes/"><i class="fa fa-facebook"></i></a>\r\n</li>\r\n<li>\r\n<a href="http://twitter.com/morethanthemes/"><i class="fa fa-twitter"></i></a>\r\n</li>\r\n<li>\r\n<a href="https://plus.google.com/118354321025436191714/posts"><i class="fa fa-google-plus"></i></a>\r\n</li>                        \r\n<li>\r\n<a href="http://www.linkedin.com/company/more-than-themes/"><i class="fa fa-linkedin"></i></a>\r\n</li>\r\n<li>\r\n<a href="http://www.youtube.com/morethanthemes/"><i class="fa fa-youtube-play"></i></a>\r\n</li>\r\n<li>\r\n<a href="http://www.pinterest.com/morethanthemes/"><i class="fa fa-pinterest"></i></a>\r\n</li>\r\n</ul>\r\n', 'Stay tuned with us - Contact page', 'full_html'),
(7, '<h3 class="title">Subscribe to our newsletter</h3>\r\n<div class="subscribe-form">\r\n<form action="">\r\n<div>\r\n<div class="form-item form-type-textfield">\r\n<input type="text" class="form-text" name="subscribe" value="Your email address" onfocus="if (this.value == ''Your email address'') {this.value = '''';}" onblur="if (this.value == '''') {this.value = ''Your email address'';}" /></div>\r\n<div class="form-actions">\r\n<input value="" type="submit" id="edit-submit" name="subscribe" class="form-submit">\r\n</div>\r\n</div>\r\n</form>\r\n</div>', 'Subscribe to our newsletter', 'php_code'),
(8, '<div class="navigation-social-bookmarks">\r\n<ul class="social-bookmarks">\r\n<li>\r\n<a href="http://www.facebook.com/morethan.just.themes/"><i class="fa fa-facebook"></i></a>\r\n</li>\r\n<li>\r\n<a href="http://twitter.com/morethanthemes/"><i class="fa fa-twitter"></i></a>\r\n</li>\r\n<li>\r\n<a href="https://plus.google.com/118354321025436191714/posts"><i class="fa fa-google-plus"></i></a>\r\n</li>                        \r\n</ul>\r\n<?php if (module_exists(''search'')): ?>\r\n<div class="dropdown search-bar block-search">\r\n<a data-toggle="dropdown" href="#" class="trigger"></a>\r\n<ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">\r\n<li><?php $block = module_invoke(''search'', ''block_view'', ''search''); print render($block);?></li>\r\n</ul>\r\n</div>\r\n <?php endif; ?>\r\n</div>', 'Navigation Social Bookmarks & Search Box', 'php_code'),
(9, 'Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.\r\n\r\nLorem ipsum dolor sit amet, consectetur adipisicing elit. Sit, esse, quo <a href="#">distinctio dolores magni</a> reprerit id est at fugiat veritatis fugit dignios sed ut facere moles illo impedit. Tempora, iure!', 'Text Block', 'filtered_html'),
(10, '<div class="ad-banner">\r\nAD BANNER\r\n</div>', 'Ad banner', 'full_html'),
(11, '<!-- #map-canvas --> \r\n<div id="map-canvas">\r\n</div>\r\n<!-- EOF:#map-canvas -->', 'Google maps', 'full_html');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `block_node_type`
--

DROP TABLE IF EXISTS `block_node_type`;
CREATE TABLE `block_node_type` (
  `module` varchar(64) NOT NULL COMMENT 'The block’s origin module, from block.module.',
  `delta` varchar(32) NOT NULL COMMENT 'The block’s unique delta within module, from block.delta.',
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type from node_type.type.',
  PRIMARY KEY (`module`,`delta`,`type`),
  KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Sets up display criteria for blocks based on content types';

--
-- Άδειασμα δεδομένων του πίνακα `block_node_type`
--

INSERT INTO `block_node_type` (`module`, `delta`, `type`) VALUES
('views', 'mt_node_navigation-block', 'mt_post');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique comment ID.',
  `pid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid to which this comment is a reply. If set to 0, this comment is not a reply to an existing comment.',
  `nid` int(11) NOT NULL DEFAULT '0' COMMENT 'The node.nid to which this comment is a reply.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid who authored the comment. If set to 0, this comment was created by an anonymous user.',
  `subject` varchar(64) NOT NULL DEFAULT '' COMMENT 'The comment title.',
  `hostname` varchar(128) NOT NULL DEFAULT '' COMMENT 'The author’s host name.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the comment was last edited, as a Unix timestamp.',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The published status of a comment. (0 = Not Published, 1 = Published)',
  `thread` varchar(255) NOT NULL COMMENT 'The vancode representation of the comment’s place in a thread.',
  `name` varchar(60) DEFAULT NULL COMMENT 'The comment author’s name. Uses users.name if the user is logged in, otherwise uses the value typed into the comment form.',
  `mail` varchar(64) DEFAULT NULL COMMENT 'The comment author’s e-mail address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `homepage` varchar(255) DEFAULT NULL COMMENT 'The comment author’s home page address from the comment form, if user is anonymous, and the ’Anonymous users may/must leave their contact information’ setting is turned on.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this comment.',
  PRIMARY KEY (`cid`),
  KEY `comment_status_pid` (`pid`,`status`),
  KEY `comment_num_new` (`nid`,`status`,`created`,`cid`,`thread`),
  KEY `comment_uid` (`uid`),
  KEY `comment_nid_language` (`nid`,`language`),
  KEY `comment_created` (`created`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores comments and associated data.' AUTO_INCREMENT=5 ;

--
-- Άδειασμα δεδομένων του πίνακα `comment`
--

INSERT INTO `comment` (`cid`, `pid`, `nid`, `uid`, `subject`, `hostname`, `created`, `changed`, `status`, `thread`, `name`, `mail`, `homepage`, `language`) VALUES
(1, 0, 2, 1, 'Title of the comment', '127.0.0.1', 1401220326, 1401220324, 1, '01/', 'admin', '', '', 'und'),
(2, 0, 1, 1, 'Title of the comment', '127.0.0.1', 1401220522, 1401220520, 1, '01/', 'admin', '', '', 'und'),
(3, 2, 1, 1, 'Title of the comment', '127.0.0.1', 1401220538, 1401220537, 1, '01.00/', 'admin', '', '', 'und'),
(4, 0, 1, 1, 'Title of the comment', '127.0.0.1', 1401220548, 1401220547, 1, '02/', 'admin', '', '', 'und');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_config`
--

DROP TABLE IF EXISTS `field_config`;
CREATE TABLE `field_config` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field',
  `field_name` varchar(32) NOT NULL COMMENT 'The name of this field. Non-deleted field names are unique, but multiple deleted fields can have the same name.',
  `type` varchar(128) NOT NULL COMMENT 'The type of this field.',
  `module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the field type.',
  `active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the field type is enabled.',
  `storage_type` varchar(128) NOT NULL COMMENT 'The storage backend for the field.',
  `storage_module` varchar(128) NOT NULL DEFAULT '' COMMENT 'The module that implements the storage backend.',
  `storage_active` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the module that implements the storage backend is enabled.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT '@TODO',
  `data` longblob NOT NULL COMMENT 'Serialized data containing the field properties that do not warrant a dedicated column.',
  `cardinality` tinyint(4) NOT NULL DEFAULT '0',
  `translatable` tinyint(4) NOT NULL DEFAULT '0',
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name` (`field_name`),
  KEY `active` (`active`),
  KEY `storage_active` (`storage_active`),
  KEY `deleted` (`deleted`),
  KEY `module` (`module`),
  KEY `storage_module` (`storage_module`),
  KEY `type` (`type`),
  KEY `storage_type` (`storage_type`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24 ;

--
-- Άδειασμα δεδομένων του πίνακα `field_config`
--

INSERT INTO `field_config` (`id`, `field_name`, `type`, `module`, `active`, `storage_type`, `storage_module`, `storage_active`, `locked`, `data`, `cardinality`, `translatable`, `deleted`) VALUES
(1, 'comment_body', 'text_long', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a31323a22656e746974795f7479706573223b613a313a7b693a303b733a373a22636f6d6d656e74223b7d733a31323a227472616e736c617461626c65223b623a303b733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d7d, 1, 0, 0),
(2, 'body', 'text_with_summary', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a363a7b733a31323a22656e746974795f7479706573223b613a313a7b693a303b733a343a226e6f6465223b7d733a31323a227472616e736c617461626c65223b623a303b733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a343a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b693a313b7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d7d, 1, 0, 0),
(3, 'field_tags', 'taxonomy_term_reference', 'taxonomy', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a383a2273657474696e6773223b613a313a7b733a31343a22616c6c6f7765645f76616c756573223b613a313a7b693a303b613a323a7b733a31303a22766f636162756c617279223b733a343a2274616773223b733a363a22706172656e74223b693a303b7d7d7d733a31323a22656e746974795f7479706573223b613a303a7b7d733a31323a227472616e736c617461626c65223b733a313a2230223b733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a32313a226669656c645f646174615f6669656c645f74616773223b613a313a7b733a333a22746964223b733a31343a226669656c645f746167735f746964223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a32353a226669656c645f7265766973696f6e5f6669656c645f74616773223b613a313a7b733a333a22746964223b733a31343a226669656c645f746167735f746964223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a313a7b733a333a22746964223b613a323a7b733a353a227461626c65223b733a31383a227461786f6e6f6d795f7465726d5f64617461223b733a373a22636f6c756d6e73223b613a313a7b733a333a22746964223b733a333a22746964223b7d7d7d733a373a22696e6465786573223b613a313a7b733a333a22746964223b613a313a7b693a303b733a333a22746964223b7d7d733a323a226964223b733a313a2233223b7d, -1, 0, 0),
(4, 'field_image', 'image', 'image', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a373a22696e6465786573223b613a313a7b733a333a22666964223b613a313a7b693a303b733a333a22666964223b7d7d733a383a2273657474696e6773223b613a323a7b733a31303a227572695f736368656d65223b733a363a227075626c6963223b733a31333a2264656661756c745f696d616765223b693a303b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a32323a226669656c645f646174615f6669656c645f696d616765223b613a353a7b733a333a22666964223b733a31353a226669656c645f696d6167655f666964223b733a333a22616c74223b733a31353a226669656c645f696d6167655f616c74223b733a353a227469746c65223b733a31373a226669656c645f696d6167655f7469746c65223b733a353a227769647468223b733a31373a226669656c645f696d6167655f7769647468223b733a363a22686569676874223b733a31383a226669656c645f696d6167655f686569676874223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a32363a226669656c645f7265766973696f6e5f6669656c645f696d616765223b613a353a7b733a333a22666964223b733a31353a226669656c645f696d6167655f666964223b733a333a22616c74223b733a31353a226669656c645f696d6167655f616c74223b733a353a227469746c65223b733a31373a226669656c645f696d6167655f7469746c65223b733a353a227769647468223b733a31373a226669656c645f696d6167655f7769647468223b733a363a22686569676874223b733a31383a226669656c645f696d6167655f686569676874223b7d7d7d7d7d733a31323a22656e746974795f7479706573223b613a303a7b7d733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22666f726569676e206b657973223b613a313a7b733a333a22666964223b613a323a7b733a353a227461626c65223b733a31323a2266696c655f6d616e61676564223b733a373a22636f6c756d6e73223b613a313a7b733a333a22666964223b733a333a22666964223b7d7d7d733a323a226964223b733a313a2234223b7d, -1, 0, 0),
(5, 'field_mt_post_categories', 'taxonomy_term_reference', 'taxonomy', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a313a7b733a31343a22616c6c6f7765645f76616c756573223b613a313a7b693a303b613a323a7b733a31303a22766f636162756c617279223b733a31383a226d745f706f73745f63617465676f72696573223b733a363a22706172656e74223b733a313a2230223b7d7d7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a33353a226669656c645f646174615f6669656c645f6d745f706f73745f63617465676f72696573223b613a313a7b733a333a22746964223b733a32383a226669656c645f6d745f706f73745f63617465676f726965735f746964223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33393a226669656c645f7265766973696f6e5f6669656c645f6d745f706f73745f63617465676f72696573223b613a313a7b733a333a22746964223b733a32383a226669656c645f6d745f706f73745f63617465676f726965735f746964223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a313a7b733a333a22746964223b613a323a7b733a353a227461626c65223b733a31383a227461786f6e6f6d795f7465726d5f64617461223b733a373a22636f6c756d6e73223b613a313a7b733a333a22746964223b733a333a22746964223b7d7d7d733a373a22696e6465786573223b613a313a7b733a333a22746964223b613a313a7b693a303b733a333a22746964223b7d7d733a323a226964223b733a313a2235223b7d, 1, 0, 0),
(6, 'field_mt_subheader_body', 'text_with_summary', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a33343a226669656c645f646174615f6669656c645f6d745f7375626865616465725f626f6479223b613a333a7b733a353a2276616c7565223b733a32393a226669656c645f6d745f7375626865616465725f626f64795f76616c7565223b733a373a2273756d6d617279223b733a33313a226669656c645f6d745f7375626865616465725f626f64795f73756d6d617279223b733a363a22666f726d6174223b733a33303a226669656c645f6d745f7375626865616465725f626f64795f666f726d6174223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33383a226669656c645f7265766973696f6e5f6669656c645f6d745f7375626865616465725f626f6479223b613a333a7b733a353a2276616c7565223b733a32393a226669656c645f6d745f7375626865616465725f626f64795f76616c7565223b733a373a2273756d6d617279223b733a33313a226669656c645f6d745f7375626865616465725f626f64795f73756d6d617279223b733a363a22666f726d6174223b733a33303a226669656c645f6d745f7375626865616465725f626f64795f666f726d6174223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d733a323a226964223b733a313a2236223b7d, 1, 0, 0),
(7, 'field_mt_about', 'text_with_summary', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a303a7b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a32353a226669656c645f646174615f6669656c645f6d745f61626f7574223b613a333a7b733a353a2276616c7565223b733a32303a226669656c645f6d745f61626f75745f76616c7565223b733a373a2273756d6d617279223b733a32323a226669656c645f6d745f61626f75745f73756d6d617279223b733a363a22666f726d6174223b733a32313a226669656c645f6d745f61626f75745f666f726d6174223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a32393a226669656c645f7265766973696f6e5f6669656c645f6d745f61626f7574223b613a333a7b733a353a2276616c7565223b733a32303a226669656c645f6d745f61626f75745f76616c7565223b733a373a2273756d6d617279223b733a32323a226669656c645f6d745f61626f75745f73756d6d617279223b733a363a22666f726d6174223b733a32313a226669656c645f6d745f61626f75745f666f726d6174223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d733a323a226964223b733a313a2237223b7d, 1, 0, 0),
(13, 'field_mt_breaking', 'list_boolean', 'list', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a323a7b733a31343a22616c6c6f7765645f76616c756573223b613a323a7b693a303b733a333a226f6666223b693a313b733a323a226f6e223b7d733a32333a22616c6c6f7765645f76616c7565735f66756e6374696f6e223b733a303a22223b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a32383a226669656c645f646174615f6669656c645f6d745f627265616b696e67223b613a313a7b733a353a2276616c7565223b733a32333a226669656c645f6d745f627265616b696e675f76616c7565223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33323a226669656c645f7265766973696f6e5f6669656c645f6d745f627265616b696e67223b613a313a7b733a353a2276616c7565223b733a32333a226669656c645f6d745f627265616b696e675f76616c7565223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a303a7b7d733a373a22696e6465786573223b613a313a7b733a353a2276616c7565223b613a313a7b693a303b733a353a2276616c7565223b7d7d733a323a226964223b733a323a223133223b7d, 1, 0, 0),
(17, 'field_mt_facebook', 'text', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a313a7b733a31303a226d61785f6c656e677468223b733a333a22323535223b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a32383a226669656c645f646174615f6669656c645f6d745f66616365626f6f6b223b613a323a7b733a353a2276616c7565223b733a32333a226669656c645f6d745f66616365626f6f6b5f76616c7565223b733a363a22666f726d6174223b733a32343a226669656c645f6d745f66616365626f6f6b5f666f726d6174223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33323a226669656c645f7265766973696f6e5f6669656c645f6d745f66616365626f6f6b223b613a323a7b733a353a2276616c7565223b733a32333a226669656c645f6d745f66616365626f6f6b5f76616c7565223b733a363a22666f726d6174223b733a32343a226669656c645f6d745f66616365626f6f6b5f666f726d6174223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d733a323a226964223b733a323a223137223b7d, 1, 0, 0),
(18, 'field_mt_twitter', 'text', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a313a7b733a31303a226d61785f6c656e677468223b733a333a22323535223b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a32373a226669656c645f646174615f6669656c645f6d745f74776974746572223b613a323a7b733a353a2276616c7565223b733a32323a226669656c645f6d745f747769747465725f76616c7565223b733a363a22666f726d6174223b733a32333a226669656c645f6d745f747769747465725f666f726d6174223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33313a226669656c645f7265766973696f6e5f6669656c645f6d745f74776974746572223b613a323a7b733a353a2276616c7565223b733a32323a226669656c645f6d745f747769747465725f76616c7565223b733a363a22666f726d6174223b733a32333a226669656c645f6d745f747769747465725f666f726d6174223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d733a323a226964223b733a323a223138223b7d, 1, 0, 0),
(19, 'field_mt_google_plus', 'text', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a313a7b733a31303a226d61785f6c656e677468223b733a333a22323535223b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a33313a226669656c645f646174615f6669656c645f6d745f676f6f676c655f706c7573223b613a323a7b733a353a2276616c7565223b733a32363a226669656c645f6d745f676f6f676c655f706c75735f76616c7565223b733a363a22666f726d6174223b733a32373a226669656c645f6d745f676f6f676c655f706c75735f666f726d6174223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33353a226669656c645f7265766973696f6e5f6669656c645f6d745f676f6f676c655f706c7573223b613a323a7b733a353a2276616c7565223b733a32363a226669656c645f6d745f676f6f676c655f706c75735f76616c7565223b733a363a22666f726d6174223b733a32373a226669656c645f6d745f676f6f676c655f706c75735f666f726d6174223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d733a323a226964223b733a323a223139223b7d, 1, 0, 0),
(20, 'field_mt_teaser_image', 'image', 'image', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a323a7b733a31303a227572695f736368656d65223b733a363a227075626c6963223b733a31333a2264656661756c745f696d616765223b693a303b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a33323a226669656c645f646174615f6669656c645f6d745f7465617365725f696d616765223b613a353a7b733a333a22666964223b733a32353a226669656c645f6d745f7465617365725f696d6167655f666964223b733a333a22616c74223b733a32353a226669656c645f6d745f7465617365725f696d6167655f616c74223b733a353a227469746c65223b733a32373a226669656c645f6d745f7465617365725f696d6167655f7469746c65223b733a353a227769647468223b733a32373a226669656c645f6d745f7465617365725f696d6167655f7769647468223b733a363a22686569676874223b733a32383a226669656c645f6d745f7465617365725f696d6167655f686569676874223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33363a226669656c645f7265766973696f6e5f6669656c645f6d745f7465617365725f696d616765223b613a353a7b733a333a22666964223b733a32353a226669656c645f6d745f7465617365725f696d6167655f666964223b733a333a22616c74223b733a32353a226669656c645f6d745f7465617365725f696d6167655f616c74223b733a353a227469746c65223b733a32373a226669656c645f6d745f7465617365725f696d6167655f7469746c65223b733a353a227769647468223b733a32373a226669656c645f6d745f7465617365725f696d6167655f7769647468223b733a363a22686569676874223b733a32383a226669656c645f6d745f7465617365725f696d6167655f686569676874223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a313a7b733a333a22666964223b613a323a7b733a353a227461626c65223b733a31323a2266696c655f6d616e61676564223b733a373a22636f6c756d6e73223b613a313a7b733a333a22666964223b733a333a22666964223b7d7d7d733a373a22696e6465786573223b613a313a7b733a333a22666964223b613a313a7b693a303b733a333a22666964223b7d7d733a323a226964223b733a323a223230223b7d, 1, 0, 0),
(21, 'field_mt_slideshow', 'list_boolean', 'list', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a323a7b733a31343a22616c6c6f7765645f76616c756573223b613a323a7b693a303b733a333a226f6666223b693a313b733a323a226f6e223b7d733a32333a22616c6c6f7765645f76616c7565735f66756e6374696f6e223b733a303a22223b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a32393a226669656c645f646174615f6669656c645f6d745f736c69646573686f77223b613a313a7b733a353a2276616c7565223b733a32343a226669656c645f6d745f736c69646573686f775f76616c7565223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33333a226669656c645f7265766973696f6e5f6669656c645f6d745f736c69646573686f77223b613a313a7b733a353a2276616c7565223b733a32343a226669656c645f6d745f736c69646573686f775f76616c7565223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a303a7b7d733a373a22696e6465786573223b613a313a7b733a353a2276616c7565223b613a313a7b693a303b733a353a2276616c7565223b7d7d733a323a226964223b733a323a223231223b7d, 1, 0, 0),
(22, 'field_mt_slideshow_path', 'text', 'text', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a313a7b733a31303a226d61785f6c656e677468223b733a333a22323535223b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a33343a226669656c645f646174615f6669656c645f6d745f736c69646573686f775f70617468223b613a323a7b733a353a2276616c7565223b733a32393a226669656c645f6d745f736c69646573686f775f706174685f76616c7565223b733a363a22666f726d6174223b733a33303a226669656c645f6d745f736c69646573686f775f706174685f666f726d6174223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33383a226669656c645f7265766973696f6e5f6669656c645f6d745f736c69646573686f775f70617468223b613a323a7b733a353a2276616c7565223b733a32393a226669656c645f6d745f736c69646573686f775f706174685f76616c7565223b733a363a22666f726d6174223b733a33303a226669656c645f6d745f736c69646573686f775f706174685f666f726d6174223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a313a7b733a363a22666f726d6174223b613a323a7b733a353a227461626c65223b733a31333a2266696c7465725f666f726d6174223b733a373a22636f6c756d6e73223b613a313a7b733a363a22666f726d6174223b733a363a22666f726d6174223b7d7d7d733a373a22696e6465786573223b613a313a7b733a363a22666f726d6174223b613a313a7b693a303b733a363a22666f726d6174223b7d7d733a323a226964223b733a323a223232223b7d, 1, 0, 0),
(23, 'field_mt_banner_image', 'image', 'image', 1, 'field_sql_storage', 'field_sql_storage', 1, 0, 0x613a373a7b733a31323a227472616e736c617461626c65223b733a313a2230223b733a31323a22656e746974795f7479706573223b613a303a7b7d733a383a2273657474696e6773223b613a323a7b733a31303a227572695f736368656d65223b733a363a227075626c6963223b733a31333a2264656661756c745f696d616765223b693a303b7d733a373a2273746f72616765223b613a353a7b733a343a2274797065223b733a31373a226669656c645f73716c5f73746f72616765223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a31373a226669656c645f73716c5f73746f72616765223b733a363a22616374697665223b733a313a2231223b733a373a2264657461696c73223b613a313a7b733a333a2273716c223b613a323a7b733a31383a224649454c445f4c4f41445f43555252454e54223b613a313a7b733a33323a226669656c645f646174615f6669656c645f6d745f62616e6e65725f696d616765223b613a353a7b733a333a22666964223b733a32353a226669656c645f6d745f62616e6e65725f696d6167655f666964223b733a333a22616c74223b733a32353a226669656c645f6d745f62616e6e65725f696d6167655f616c74223b733a353a227469746c65223b733a32373a226669656c645f6d745f62616e6e65725f696d6167655f7469746c65223b733a353a227769647468223b733a32373a226669656c645f6d745f62616e6e65725f696d6167655f7769647468223b733a363a22686569676874223b733a32383a226669656c645f6d745f62616e6e65725f696d6167655f686569676874223b7d7d733a31393a224649454c445f4c4f41445f5245564953494f4e223b613a313a7b733a33363a226669656c645f7265766973696f6e5f6669656c645f6d745f62616e6e65725f696d616765223b613a353a7b733a333a22666964223b733a32353a226669656c645f6d745f62616e6e65725f696d6167655f666964223b733a333a22616c74223b733a32353a226669656c645f6d745f62616e6e65725f696d6167655f616c74223b733a353a227469746c65223b733a32373a226669656c645f6d745f62616e6e65725f696d6167655f7469746c65223b733a353a227769647468223b733a32373a226669656c645f6d745f62616e6e65725f696d6167655f7769647468223b733a363a22686569676874223b733a32383a226669656c645f6d745f62616e6e65725f696d6167655f686569676874223b7d7d7d7d7d733a31323a22666f726569676e206b657973223b613a313a7b733a333a22666964223b613a323a7b733a353a227461626c65223b733a31323a2266696c655f6d616e61676564223b733a373a22636f6c756d6e73223b613a313a7b733a333a22666964223b733a333a22666964223b7d7d7d733a373a22696e6465786573223b613a313a7b733a333a22666964223b613a313a7b693a303b733a333a22666964223b7d7d733a323a226964223b733a323a223233223b7d, -1, 0, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_config_instance`
--

DROP TABLE IF EXISTS `field_config_instance`;
CREATE TABLE `field_config_instance` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a field instance',
  `field_id` int(11) NOT NULL COMMENT 'The identifier of the field attached by this instance',
  `field_name` varchar(32) NOT NULL DEFAULT '',
  `entity_type` varchar(32) NOT NULL DEFAULT '',
  `bundle` varchar(128) NOT NULL DEFAULT '',
  `data` longblob NOT NULL,
  `deleted` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `field_name_bundle` (`field_name`,`entity_type`,`bundle`),
  KEY `deleted` (`deleted`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=62 ;

--
-- Άδειασμα δεδομένων του πίνακα `field_config_instance`
--

INSERT INTO `field_config_instance` (`id`, `field_id`, `field_name`, `entity_type`, `bundle`, `data`, `deleted`) VALUES
(1, 1, 'comment_body', 'comment', 'comment_node_page', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(2, 2, 'body', 'node', 'page', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b693a2d343b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(3, 1, 'comment_body', 'comment', 'comment_node_article', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(4, 2, 'body', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b733a313a2232223b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b733a313a2232223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(5, 3, 'field_tags', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a343a2254616773223b733a31313a226465736372697074696f6e223b733a36333a22456e746572206120636f6d6d612d736570617261746564206c697374206f6620776f72647320746f20646573637269626520796f757220636f6e74656e742e223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32313a227461786f6e6f6d795f6175746f636f6d706c657465223b733a363a22776569676874223b733a313a2236223b733a383a2273657474696e6773223b613a323a7b733a343a2273697a65223b693a36303b733a31373a226175746f636f6d706c6574655f70617468223b733a32313a227461786f6e6f6d792f6175746f636f6d706c657465223b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b733a313a2233223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b733a323a223130223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a303b7d, 0),
(6, 4, 'field_image', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a31363a22496e2d7061676520696d616765287329223b733a31313a226465736372697074696f6e223b733a39373a2254686520696d61676528732920796f752077696c6c2075736520696e2074686973206669656c642077696c6c206265207573656420696e20746865206d61696e20636f6e74656e7420636f6c756d6e206f6620746865206e6f646520706167652e223b733a383a227265717569726564223b693a303b733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a31313a226669656c642f696d616765223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b693a313b733a31313a227469746c655f6669656c64223b693a313b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2233223b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a363a226d6f64756c65223b733a353a22696d616765223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a363a22776569676874223b733a313a2231223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a353a226c61726765223b733a31303a22696d6167655f6c696e6b223b733a303a22223b7d733a363a226d6f64756c65223b733a353a22696d616765223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a363a22776569676874223b733a323a222d31223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a363a226d656469756d223b733a31303a22696d6167655f6c696e6b223b733a373a22636f6e74656e74223b7d733a363a226d6f64756c65223b733a353a22696d616765223b7d7d7d, 0),
(7, 1, 'comment_body', 'comment', 'comment_node_blog', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(8, 2, 'body', 'node', 'blog', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b733a313a2232223b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b733a313a2232223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a363a22776569676874223b733a313a2231223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(9, 1, 'comment_body', 'comment', 'comment_node_webform', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(10, 2, 'body', 'node', 'webform', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b693a2d343b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b733a363a22776569676874223b693a303b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(11, 1, 'comment_body', 'comment', 'comment_node_mt_post', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(12, 2, 'body', 'node', 'mt_post', 0x613a363a7b733a353a226c6162656c223b733a343a22426f6479223b733a363a22776964676574223b613a343a7b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b693a32303b733a31323a2273756d6d6172795f726f7773223b693a353b7d733a363a22776569676874223b733a313a2232223b733a363a226d6f64756c65223b733a343a2274657874223b7d733a383a2273657474696e6773223b613a333a7b733a31353a22646973706c61795f73756d6d617279223b623a313b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b733a313a2232223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32333a22746578745f73756d6d6172795f6f725f7472696d6d6564223b733a363a22776569676874223b733a313a2231223b733a383a2273657474696e6773223b613a313a7b733a31313a227472696d5f6c656e677468223b693a3630303b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a383a227265717569726564223b623a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(13, 4, 'field_image', 'node', 'mt_post', 0x613a363a7b733a353a226c6162656c223b733a31363a22496e2d7061676520696d616765287329223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2233223b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a363a226d6f64756c65223b733a353a22696d616765223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d7d733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a303a22223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b693a313b733a31313a227469746c655f6669656c64223b693a313b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a363a22776569676874223b733a313a2231223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a353a226c61726765223b733a31303a22696d6167655f6c696e6b223b733a303a22223b7d733a363a226d6f64756c65223b733a353a22696d616765223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a363a226d656469756d223b733a31303a22696d6167655f6c696e6b223b733a373a22636f6e74656e74223b7d733a363a226d6f64756c65223b733a353a22696d616765223b7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a39373a2254686520696d61676528732920796f752077696c6c2075736520696e2074686973206669656c642077696c6c206265207573656420696e20746865206d61696e20636f6e74656e7420636f6c756d6e206f6620746865206e6f646520706167652e223b7d, 0),
(14, 4, 'field_image', 'node', 'blog', 0x613a363a7b733a353a226c6162656c223b733a31363a22496e2d7061676520696d616765287329223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2233223b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a363a226d6f64756c65223b733a353a22696d616765223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d7d733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a303a22223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b693a313b733a31313a227469746c655f6669656c64223b693a313b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a363a22776569676874223b733a313a2231223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a353a226c61726765223b733a31303a22696d6167655f6c696e6b223b733a303a22223b7d733a363a226d6f64756c65223b733a353a22696d616765223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a363a226d656469756d223b733a31303a22696d6167655f6c696e6b223b733a373a22636f6e74656e74223b7d733a363a226d6f64756c65223b733a353a22696d616765223b7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a39373a2254686520696d61676528732920796f752077696c6c2075736520696e2074686973206669656c642077696c6c206265207573656420696e20746865206d61696e20636f6e74656e7420636f6c756d6e206f6620746865206e6f646520706167652e223b7d, 0),
(15, 3, 'field_tags', 'node', 'blog', 0x613a373a7b733a353a226c6162656c223b733a343a2254616773223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2236223b733a343a2274797065223b733a32313a227461786f6e6f6d795f6175746f636f6d706c657465223b733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b733a363a22616374697665223b693a303b733a383a2273657474696e6773223b613a323a7b733a343a2273697a65223b693a36303b733a31373a226175746f636f6d706c6574655f70617468223b733a32313a227461786f6e6f6d792f6175746f636f6d706c657465223b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b733a313a2233223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a363a22746561736572223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2232223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(16, 5, 'field_mt_post_categories', 'node', 'blog', 0x613a373a7b733a353a226c6162656c223b733a31353a22506f73742043617465676f72696573223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2235223b733a343a2274797065223b733a31343a226f7074696f6e735f73656c656374223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a303a7b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b733a313a2234223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b733a313a2233223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(17, 5, 'field_mt_post_categories', 'node', 'article', 0x613a373a7b733a353a226c6162656c223b733a31353a22506f73742043617465676f72696573223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2235223b733a343a2274797065223b733a31343a226f7074696f6e735f73656c656374223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a303a7b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b733a313a2234223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a363a22746561736572223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(18, 5, 'field_mt_post_categories', 'node', 'mt_post', 0x613a373a7b733a353a226c6162656c223b733a31353a22506f73742043617465676f72696573223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2235223b733a343a2274797065223b733a31343a226f7074696f6e735f73656c656374223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a303a7b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b733a313a2234223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a363a22746561736572223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b733a313a2233223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(19, 3, 'field_tags', 'node', 'mt_post', 0x613a373a7b733a353a226c6162656c223b733a343a2254616773223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2236223b733a343a2274797065223b733a32313a227461786f6e6f6d795f6175746f636f6d706c657465223b733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b733a363a22616374697665223b693a303b733a383a2273657474696e6773223b613a323a7b733a343a2273697a65223b693a36303b733a31373a226175746f636f6d706c6574655f70617468223b733a32313a227461786f6e6f6d792f6175746f636f6d706c657465223b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a32383a227461786f6e6f6d795f7465726d5f7265666572656e63655f6c696e6b223b733a363a22776569676874223b733a313a2233223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a383a227461786f6e6f6d79223b7d733a363a22746561736572223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2232223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(20, 6, 'field_mt_subheader_body', 'node', 'mt_post', 0x613a373a7b733a353a226c6162656c223b733a31343a2253756268656164657220626f6479223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2231223b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a363a226d6f64756c65223b733a343a2274657874223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b733a313a2234223b733a31323a2273756d6d6172795f726f7773223b693a353b7d7d733a383a2273657474696e6773223b613a333a7b733a31353a22746578745f70726f63657373696e67223b733a313a2231223b733a31353a22646973706c61795f73756d6d617279223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d733a363a22746561736572223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(21, 6, 'field_mt_subheader_body', 'node', 'blog', 0x613a373a7b733a353a226c6162656c223b733a31343a2253756268656164657220626f6479223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2231223b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a363a226d6f64756c65223b733a343a2274657874223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b733a313a2234223b733a31323a2273756d6d6172795f726f7773223b693a353b7d7d733a383a2273657474696e6773223b613a333a7b733a31353a22746578745f70726f63657373696e67223b733a313a2231223b733a31353a22646973706c61795f73756d6d617279223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d733a363a22746561736572223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(22, 6, 'field_mt_subheader_body', 'node', 'article', 0x613a373a7b733a353a226c6162656c223b733a31343a2253756268656164657220626f6479223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2231223b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a363a226d6f64756c65223b733a343a2274657874223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b733a313a2234223b733a31323a2273756d6d6172795f726f7773223b693a353b7d7d733a383a2273657474696e6773223b613a333a7b733a31353a22746578745f70726f63657373696e67223b733a313a2231223b733a31353a22646973706c61795f73756d6d617279223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d733a363a22746561736572223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(23, 7, 'field_mt_about', 'user', 'user', 0x613a373a7b733a353a226c6162656c223b733a353a2241626f7574223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2237223b733a343a2274797065223b733a32363a22746578745f74657874617265615f776974685f73756d6d617279223b733a363a226d6f64756c65223b733a343a2274657874223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a343a22726f7773223b733a313a2234223b733a31323a2273756d6d6172795f726f7773223b693a353b7d7d733a383a2273657474696e6773223b613a333a7b733a31353a22746578745f70726f63657373696e67223b733a313a2231223b733a31353a22646973706c61795f73756d6d617279223b693a303b733a31383a22757365725f72656769737465725f666f726d223b693a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(24, 1, 'comment_body', 'comment', 'comment_node_mt_slideshow_entry', 0x613a363a7b733a353a226c6162656c223b733a373a22436f6d6d656e74223b733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b693a313b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a383a227265717569726564223b623a313b733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b693a303b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a363a22776964676574223b613a343a7b733a343a2274797065223b733a31333a22746578745f7465787461726561223b733a383a2273657474696e6773223b613a313a7b733a343a22726f7773223b693a353b7d733a363a22776569676874223b693a303b733a363a226d6f64756c65223b733a343a2274657874223b7d733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(37, 13, 'field_mt_breaking', 'node', 'article', 0x613a373a7b733a353a226c6162656c223b733a383a22427265616b696e67223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2239223b733a343a2274797065223b733a31333a226f7074696f6e735f6f6e6f6666223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a31333a22646973706c61795f6c6162656c223b693a313b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2237223b733a383a2273657474696e6773223b613a303a7b7d7d733a363a22746561736572223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a35303a22436865636b207468697320626f7820746f20616464207468697320746f207468652022427265616b696e6722206e6577732e223b733a31333a2264656661756c745f76616c7565223b613a313a7b693a303b613a313a7b733a353a2276616c7565223b693a303b7d7d7d, 0),
(38, 13, 'field_mt_breaking', 'node', 'blog', 0x613a373a7b733a353a226c6162656c223b733a383a22427265616b696e67223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2239223b733a343a2274797065223b733a31333a226f7074696f6e735f6f6e6f6666223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a31333a22646973706c61795f6c6162656c223b693a313b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2238223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a35303a22436865636b207468697320626f7820746f20616464207468697320746f207468652022427265616b696e6722206e6577732e223b733a31333a2264656661756c745f76616c7565223b613a313a7b693a303b613a313a7b733a353a2276616c7565223b693a303b7d7d7d, 0),
(39, 13, 'field_mt_breaking', 'node', 'mt_post', 0x613a373a7b733a353a226c6162656c223b733a383a22427265616b696e67223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2239223b733a343a2274797065223b733a31333a226f7074696f6e735f6f6e6f6666223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a31333a22646973706c61795f6c6162656c223b693a313b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2237223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a35303a22436865636b207468697320626f7820746f20616464207468697320746f207468652022427265616b696e6722206e6577732e223b733a31333a2264656661756c745f76616c7565223b613a313a7b693a303b613a313a7b733a353a2276616c7565223b693a303b7d7d7d, 0),
(47, 17, 'field_mt_facebook', 'user', 'user', 0x613a373a7b733a353a226c6162656c223b733a383a2246616365626f6f6b223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2238223b733a343a2274797065223b733a31343a22746578745f746578746669656c64223b733a363a226d6f64756c65223b733a343a2274657874223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a343a2273697a65223b733a323a223630223b7d7d733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b733a313a2230223b733a31383a22757365725f72656769737465725f666f726d223b693a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b733a313a2231223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a37393a22456e746572207468652055524c206f6620796f75722046616365626f6f6b2070726f66696c652c20652e672e3a2068747470733a2f2f66616365626f6f6b2e636f6d2f796f75722d6163636f756e74223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(48, 18, 'field_mt_twitter', 'user', 'user', 0x613a373a7b733a353a226c6162656c223b733a373a2254776974746572223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2239223b733a343a2274797065223b733a31343a22746578745f746578746669656c64223b733a363a226d6f64756c65223b733a343a2274657874223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a343a2273697a65223b733a323a223630223b7d7d733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b733a313a2230223b733a31383a22757365725f72656769737465725f666f726d223b693a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b733a313a2232223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a37373a22456e746572207468652055524c206f6620796f757220547769747465722070726f66696c652c20652e672e3a2068747470733a2f2f747769747465722e636f6d2f796f75722d6163636f756e74223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(49, 19, 'field_mt_google_plus', 'user', 'user', 0x613a373a7b733a353a226c6162656c223b733a373a22476f6f676c652b223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a323a223130223b733a343a2274797065223b733a31343a22746578745f746578746669656c64223b733a363a226d6f64756c65223b733a343a2274657874223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a343a2273697a65223b733a323a223630223b7d7d733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b733a313a2230223b733a31383a22757365725f72656769737465725f666f726d223b693a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a31323a22746578745f64656661756c74223b733a363a22776569676874223b733a313a2233223b733a383a2273657474696e6773223b613a303a7b7d733a363a226d6f64756c65223b733a343a2274657874223b7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a38323a22456e746572207468652055524c206f6620796f757220476f6f676c652b2070726f66696c652c20652e672e3a2068747470733a2f2f706c75732e676f6f676c652e636f6d2f2f796f75722d6163636f756e74223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(50, 20, 'field_mt_teaser_image', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a31323a2254656173657220696d616765223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2237223b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a363a226d6f64756c65223b733a353a22696d616765223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d7d733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a303a22223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b693a313b733a31313a227469746c655f6669656c64223b693a313b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2239223b733a383a2273657474696e6773223b613a303a7b7d7d733a363a22746561736572223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(51, 21, 'field_mt_slideshow', 'node', 'article', 0x613a373a7b733a353a226c6162656c223b733a32313a2250726f6d6f746564206f6e20736c69646573686f77223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2238223b733a343a2274797065223b733a31333a226f7074696f6e735f6f6e6f6666223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a31333a22646973706c61795f6c6162656c223b693a313b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a323a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a323a223130223b733a383a2273657474696e6773223b613a303a7b7d7d733a363a22746561736572223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b613a313a7b693a303b613a313a7b733a353a2276616c7565223b693a303b7d7d7d, 0),
(52, 20, 'field_mt_teaser_image', 'node', 'blog', 0x613a363a7b733a353a226c6162656c223b733a31323a2254656173657220696d616765223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2237223b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a363a226d6f64756c65223b733a353a22696d616765223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d7d733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a303a22223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b693a313b733a31313a227469746c655f6669656c64223b693a313b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2239223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(53, 21, 'field_mt_slideshow', 'node', 'blog', 0x613a373a7b733a353a226c6162656c223b733a32313a2250726f6d6f746564206f6e20736c69646573686f77223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2238223b733a343a2274797065223b733a31333a226f7074696f6e735f6f6e6f6666223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a31333a22646973706c61795f6c6162656c223b693a313b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a323a223130223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b613a313a7b693a303b613a313a7b733a353a2276616c7565223b693a303b7d7d7d, 0),
(54, 20, 'field_mt_teaser_image', 'node', 'mt_post', 0x613a363a7b733a353a226c6162656c223b733a31323a2254656173657220696d616765223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2237223b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a363a226d6f64756c65223b733a353a22696d616765223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d7d733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a303a22223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b693a313b733a31313a227469746c655f6669656c64223b693a313b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2239223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0),
(55, 21, 'field_mt_slideshow', 'node', 'mt_post', 0x613a373a7b733a353a226c6162656c223b733a32313a2250726f6d6f746564206f6e20736c69646573686f77223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2238223b733a343a2274797065223b733a31333a226f7074696f6e735f6f6e6f6666223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a31333a22646973706c61795f6c6162656c223b693a313b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a323a223130223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b613a313a7b693a303b613a313a7b733a353a2276616c7565223b693a303b7d7d7d, 0),
(56, 20, 'field_mt_teaser_image', 'node', 'mt_slideshow_entry', 0x613a363a7b733a353a226c6162656c223b733a32313a22536c69646573686f7720656e74727920696d616765223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a323a222d33223b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a363a226d6f64756c65223b733a353a22696d616765223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d7d733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a303a22223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b693a313b733a31313a227469746c655f6669656c64223b693a313b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a353a7b733a353a226c6162656c223b733a363a2268696464656e223b733a343a2274797065223b733a353a22696d616765223b733a363a22776569676874223b733a313a2230223b733a383a2273657474696e6773223b613a323a7b733a31313a22696d6167655f7374796c65223b733a353a226c61726765223b733a31303a22696d6167655f6c696e6b223b733a303a22223b7d733a363a226d6f64756c65223b733a353a22696d616765223b7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b7d, 0);
INSERT INTO `field_config_instance` (`id`, `field_id`, `field_name`, `entity_type`, `bundle`, `data`, `deleted`) VALUES
(57, 22, 'field_mt_slideshow_path', 'node', 'mt_slideshow_entry', 0x613a373a7b733a353a226c6162656c223b733a32303a22536c69646573686f7720656e7472792070617468223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a323a222d32223b733a343a2274797065223b733a31343a22746578745f746578746669656c64223b733a363a226d6f64756c65223b733a343a2274657874223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a343a2273697a65223b733a323a223630223b7d7d733a383a2273657474696e6773223b613a323a7b733a31353a22746578745f70726f63657373696e67223b733a313a2230223b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2231223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b4e3b7d, 0),
(58, 21, 'field_mt_slideshow', 'node', 'mt_slideshow_entry', 0x613a373a7b733a353a226c6162656c223b733a32313a2250726f6d6f746564206f6e20736c69646573686f77223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2230223b733a343a2274797065223b733a31333a226f7074696f6e735f6f6e6f6666223b733a363a226d6f64756c65223b733a373a226f7074696f6e73223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a313a7b733a31333a22646973706c61795f6c6162656c223b693a313b7d7d733a383a2273657474696e6773223b613a313a7b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a313a2232223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a303a22223b733a31333a2264656661756c745f76616c7565223b613a313a7b693a303b613a313a7b733a353a2276616c7565223b693a313b7d7d7d, 0),
(59, 23, 'field_mt_banner_image', 'node', 'mt_post', 0x613a363a7b733a353a226c6162656c223b733a32353a22496e7465726e616c2062616e6e657220696d61676528732920223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2234223b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a363a226d6f64756c65223b733a353a22696d616765223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d7d733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a303a22223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b693a313b733a31313a227469746c655f6669656c64223b693a313b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a323a223131223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a3132313a2254686520696d61676528732920796f752077696c6c2075736520696e2074686973206669656c642c2077696c6c2062652075736564206f6e2074686520696e7465726e616c206e6f646520706167652c20696e2074686520736c69646573686f772072696768742062656c6f7720746865206865616465722e223b7d, 0),
(60, 23, 'field_mt_banner_image', 'node', 'blog', 0x613a363a7b733a353a226c6162656c223b733a32353a22496e7465726e616c2062616e6e657220696d61676528732920223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2234223b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a363a226d6f64756c65223b733a353a22696d616765223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d7d733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a303a22223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b693a313b733a31313a227469746c655f6669656c64223b693a313b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a323a223131223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a3132313a2254686520696d61676528732920796f752077696c6c2075736520696e2074686973206669656c642c2077696c6c2062652075736564206f6e2074686520696e7465726e616c206e6f646520706167652c20696e2074686520736c69646573686f772072696768742062656c6f7720746865206865616465722e223b7d, 0),
(61, 23, 'field_mt_banner_image', 'node', 'article', 0x613a363a7b733a353a226c6162656c223b733a32353a22496e7465726e616c2062616e6e657220696d61676528732920223b733a363a22776964676574223b613a353a7b733a363a22776569676874223b733a313a2234223b733a343a2274797065223b733a31313a22696d6167655f696d616765223b733a363a226d6f64756c65223b733a353a22696d616765223b733a363a22616374697665223b693a313b733a383a2273657474696e6773223b613a323a7b733a31383a2270726f67726573735f696e64696361746f72223b733a383a227468726f62626572223b733a31393a22707265766965775f696d6167655f7374796c65223b733a393a227468756d626e61696c223b7d7d733a383a2273657474696e6773223b613a393a7b733a31343a2266696c655f6469726563746f7279223b733a303a22223b733a31353a2266696c655f657874656e73696f6e73223b733a31363a22706e6720676966206a7067206a706567223b733a31323a226d61785f66696c6573697a65223b733a303a22223b733a31343a226d61785f7265736f6c7574696f6e223b733a303a22223b733a31343a226d696e5f7265736f6c7574696f6e223b733a303a22223b733a393a22616c745f6669656c64223b693a313b733a31313a227469746c655f6669656c64223b693a313b733a31333a2264656661756c745f696d616765223b693a303b733a31383a22757365725f72656769737465725f666f726d223b623a303b7d733a373a22646973706c6179223b613a313a7b733a373a2264656661756c74223b613a343a7b733a353a226c6162656c223b733a353a2261626f7665223b733a343a2274797065223b733a363a2268696464656e223b733a363a22776569676874223b733a323a223131223b733a383a2273657474696e6773223b613a303a7b7d7d7d733a383a227265717569726564223b693a303b733a31313a226465736372697074696f6e223b733a3132313a2254686520696d61676528732920796f752077696c6c2075736520696e2074686973206669656c642c2077696c6c2062652075736564206f6e2074686520696e7465726e616c206e6f646520706167652c20696e2074686520736c69646573686f772072696768742062656c6f7720746865206865616465722e223b7d, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_body`
--

DROP TABLE IF EXISTS `field_data_body`;
CREATE TABLE `field_data_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 2 (body)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_body`
--

INSERT INTO `field_data_body` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `body_value`, `body_summary`, `body_format`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 2, 2, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>\r\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris id sapien eu tortor vestibulum venenatis a eget augue. Nam massa nisi, tempor in tortor ut, tincidunt tempus ipsum. Phasellus adipiscing scelerisque sapien, non aliquet massa scelerisque nec. Duis leo arcu, posuere vel purus id, dignissim cursus ante. Nulla nisi lorem, <a href="#">pulvinar non</a> purus sed, molestie faucibus sapien. Donec arcu orci, rhoncus faucibus tempor at, fringilla vitae mauris. Vestibulum laoreet est quis lorem egestas, non ornare sapien blandit. Praesent rutrum aliquam augue et sollicitudin. Proin lobortis pulvinar libero, ac dictum libero blandit eget. Suspendisse pretium, diam sit amet facilisis aliquet, mi augue venenatis nibh, in gravida odio ipsum in nulla.</p>\r\n<p>In quis velit lacus. Suspendisse potenti. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum arcu tellus, semper vitae iaculis id, adipiscing ac est. Curabitur eget laoreet dui. Vestibulum rhoncus vel risus non pharetra. Nulla sagittis nisl vitae nulla facilisis, non imperdiet arcu dignissim. Sed iaculis ligula sed enim rhoncus tincidunt. Sed gravida venenatis lobortis. Praesent porttitor arcu at velit sagittis, id pharetra est tincidunt.</p>\r\n<h3>Interdum et malesuada fames ac ante ipsum</h3>\r\n<p>Suspendisse dapibus rhoncus turpis, vel elementum est vestibulum eget. Nullam luctus non nisi ut tempor. Suspendisse eu pretium tortor, non tristique libero. Quisque vitae mi rutrum, imperdiet neque vel, feugiat orci. Vestibulum cursus rutrum turpis ut facilisis. Proin sed tempus mauris, sit amet facilisis ante. Duis tempus dignissim augue quis sagittis. Vivamus at varius turpis. Proin commodo ante ac velit auctor tincidunt. Praesent euismod lectus ac scelerisque scelerisque. Aliquam suscipit nisi erat, sed posuere lacus scelerisque ac. Praesent lacinia <a href="#">consectetur mi</a>, nec auctor ante blandit ut.</p>\r\n<p>Suspendisse suscipit rutrum leo, ac sodales dolor mattis eu. Vivamus accumsan mattis sem a lacinia. Aliquam erat volutpat. Vivamus volutpat quam sit amet eros gravida, nec fermentum tellus tristique. Suspendisse tincidunt porttitor pulvinar. In pharetra felis quis mauris dapibus sollicitudin. Vestibulum commodo dui ut risus mollis, vel bibendum eros venenatis.</p>\r\n<p>Aenean semper sem vitae libero congue, vel sollicitudin elit porta. Sed massa libero, varius et justo eu, sagittis venenatis libero. Vestibulum adipiscing sit amet risus eu gravida. Duis metus magna, vehicula id arcu ut, suscipit imperdiet dolor. Phasellus consequat urna eros, eu luctus erat rutrum non. Donec ultricies eros sit amet dolor congue, non accumsan risus iaculis. Donec elementum ante vitae sem viverra gravida. Morbi fringilla eget lectus eu lacinia.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 3, 3, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 4, 4, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 5, 5, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 6, 6, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 7, 7, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', 'full_html'),
('node', 'mt_post', 0, 8, 8, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', 'filtered_html'),
('node', 'mt_post', 0, 9, 9, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 10, 10, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'How you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', 'full_html'),
('node', 'mt_post', 0, 11, 11, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 12, 12, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'webform', 0, 13, 13, 'und', 0, 'Send us your stories and story suggestions, or any questions by using the form to contact us. For advertisement-related questions please use our <a href="#">Advertising section<a>.', '', 'filtered_html'),
('node', 'page', 0, 14, 14, 'und', 0, '<p class="large">Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.</p> \r\n<h2>Heading 2</h2>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href="#">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h2><a href="#">Linked Heading 2</a></h2>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href="#">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipisicing elit. Sit, esse, quo distinctio dolores magni reprehenderit id est at fugiat veritatis fugit dignissimos sed ut facere molestias illo impedit. Tempora, iure!\r\n</p>\r\n<h3>Heading 3</h3>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href="#">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h4>Heading 4</h4>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href="#">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h5>Heading 5</h5>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href="#">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested <a href="#">expertise with quote link</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing.</p>\r\n</blockquote>\r\n<h3>Messages</h3>\r\n<div class="messages status">\r\nSample status message. Page <em><strong>Typography</strong></em> has been updated.\r\n</div>\r\n<div class="messages error">\r\nSample error message. There is a security update available for your version of Drupal. To ensure the security of your server, you should update immediately! See the available updates page for more information.\r\n</div>\r\n<div class="messages warning">\r\nSample warning message. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\r\n</div>\r\n<br/>\r\n<h3>Paragraph With Links</h3>\r\n<p>\r\nLorem ipsum dolor sit amet, <a href="#">consectetuer adipiscing</a> elit. Donec odio. Quisque volutpat mattis eros. <a href="#">Nullam malesuada</a> erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede.\r\n</p>\r\n<h3>Ordered List</h3>\r\n<ol>\r\n<li>\r\nThis is a sample Ordered List.\r\n</li>\r\n<li>\r\nLorem ipsum dolor sit amet consectetuer.\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor.\r\n<ol>\r\n<li>\r\nSomething goes here.\r\n</li>\r\n<li>\r\nAnd another here\r\n</li>\r\n</ol>\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor nibh.\r\n</li>\r\n</ol>\r\n\r\n<h3>Unordered List</h3>\r\n<ul>\r\n<li>\r\nThis is a sample <strong>Unordered List</strong>.\r\n</li>\r\n<li>\r\nCondimentum quis.\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor.\r\n<ul>\r\n<li>\r\nSomething goes here.\r\n</li>\r\n<li>\r\nAnd another here\r\n<ul>\r\n<li>\r\nSomething here as well\r\n</li>\r\n<li>\r\nSomething here as well\r\n</li>\r\n<li>\r\nSomething here as well\r\n</li>\r\n</ul>\r\n</li>\r\n<li>\r\nThen one more\r\n</li>\r\n</ul>\r\n</li>\r\n<li>\r\nNunc cursus sem et pretium sapien eget.\r\n</li>\r\n</ul>\r\n\r\n<h3>Fieldset</h3>\r\n<fieldset><legend>Account information</legend></fieldset>\r\n\r\n<h3>Table</h3>\r\n<table>\r\n<tr>\r\n<th>Header 1</th>\r\n<th>Header 2</th>\r\n</tr>\r\n<tr class="odd">\r\n<td>row 1, cell 1</td>\r\n<td>row 1, cell 2</td>\r\n</tr>\r\n<tr class="even">\r\n<td>row 2, cell 1</td>\r\n<td>row 2, cell 2</td>\r\n</tr>\r\n<tr class="odd">\r\n<td>row 3, cell 1</td>\r\n<td>row 3, cell 2</td>\r\n</tr>\r\n</table>', '<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate. Nullam id dolor id nibh ultricies vehicula ut id elit integer.</p> ', 'full_html'),
('node', 'page', 0, 15, 15, 'und', 0, '<h2 id="brands">Brands</h2>\r\n<ul class="brands">\r\n<li>\r\n<a href="#"><i class="fa fa-apple"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-android"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-github"></i></a>\r\n</li>                        \r\n<li>\r\n<a href="#"><i class="fa fa-windows"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-linux"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-skype"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-btc"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-css3"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-html5"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-bitbucket"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-maxcdn"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-dropbox"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-facebook"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-twitter"></i></a>\r\n</li>\r\n</ul>\r\n<pre>\r\n&lt;ul class="brands"&gt;\r\n\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-apple"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-android"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-github"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-windows"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-linux"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-skype"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-btc"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-css3"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-html5"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-bitbucket"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-maxcdn"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-dropbox"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-facebook"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-twitter"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n\r\n&lt;/ul&gt;\r\n</pre>\r\n<hr>\r\n<br>\r\n<h2 id="tabs">Tabs</h2>\r\n<!-- Nav tabs -->\r\n<ul class="nav nav-tabs">\r\n<li class="active"><a href="#home" data-toggle="tab"><i class="fa fa-home"></i>Home</a></li>\r\n<li><a href="#profile" data-toggle="tab"><i class="fa fa-user"></i>Profile</a></li>\r\n<li><a href="#messages" data-toggle="tab"><i class="fa fa-envelope"></i>Messages</a></li>\r\n</ul>\r\n<!-- Tab panes -->\r\n<div class="tab-content">\r\n<div class="tab-pane active" id="home">\r\n<p><strong>Home</strong> ipsum dolor sit amet, consectetur adipisicing elit. Perspiciatis, exercitationem, quaerat veniam repudiandae illo ratione eaque omnis obcaecati quidem distinctio sapiente quo assumenda amet cumque nobis nulla qui dolore autem.</p>\r\n</div>\r\n<div class="tab-pane" id="profile">\r\n<p><strong>Profile</strong> ipsum dolor sit amet, consectetur adipisicing elit. Ut odio facere minima porro quis. Maiores eius quibusdam et in corrupti necessitatibus consequatur debitis laudantium hic.</p>\r\n</div>\r\n<div class="tab-pane" id="messages">\r\n<p><strong>Messages</strong> ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis, optio error consectetur ullam porro eligendi mollitia odio numquam aut cumque. Sed, possimus recusandae itaque laboriosam nesciunt voluptates veniam aspernatur voluptate eaque ratione totam ipsa optio aliquam incidunt dolorum amet illum.</p>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;!-- Nav tabs --&gt;\r\n&lt;ul class="nav nav-tabs"&gt;\r\n\r\n  &lt;li class="active"&gt;&lt;a href="#home" data-toggle="tab"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#profile" data-toggle="tab"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#messages" data-toggle="tab"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n\r\n&lt;/ul&gt;\r\n\r\n&lt;!-- Tab panes --&gt;\r\n&lt;div class="tab-content"&gt;\r\n\r\n  &lt;div class="tab-pane active" id="home"&gt; ...  &lt;/div&gt;\r\n  &lt;div class="tab-pane" id="profile"&gt; ... &lt;/div&gt;\r\n  &lt;div class="tab-pane" id="messages"&gt; ... &lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<h2 id="accordion">Accordion</h2>\r\n<div class="panel-group" id="accordion">\r\n<div class="panel panel-default">\r\n<div class="panel-heading">\r\n<h4 class="panel-title">\r\n<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"><i class="fa fa-home"></i> Home</a>\r\n</h4>\r\n</div>\r\n<div id="collapseOne" class="panel-collapse collapse in">\r\n<div class="panel-body">\r\n<strong>Home</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n<div class="panel panel-default">\r\n<div class="panel-heading">\r\n<h4 class="panel-title">\r\n<a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="collapsed"><i class="fa fa-cog"></i> Configure</a>\r\n</h4>\r\n</div>\r\n<div id="collapseTwo" class="panel-collapse collapse">\r\n<div class="panel-body">\r\n<strong>Configure</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n<div class="panel panel-default">\r\n<div class="panel-heading">\r\n<h4 class="panel-title">\r\n<a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" class="collapsed"><i class="fa fa-cloud-download"></i> Download</a>\r\n</h4>\r\n</div>\r\n<div id="collapseThree" class="panel-collapse collapse">\r\n<div class="panel-body">\r\n<strong>Download</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;div class="panel-group" id="accordion"&gt;\r\n\r\n  &lt;div class="panel panel-default"&gt;\r\n    &lt;div class="panel-heading"&gt;\r\n      &lt;h4 class="panel-title"&gt;\r\n        &lt;a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"&gt;\r\n          &lt;i class="fa fa-home"&gt;&lt;/i&gt; Home\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id="collapseOne" class="panel-collapse collapse in"&gt;\r\n      &lt;div class="panel-body"&gt; ...  &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n  &lt;div class="panel panel-default"&gt;\r\n    &lt;div class="panel-heading"&gt;\r\n      &lt;h4 class="panel-title"&gt;\r\n        &lt;a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"&gt;\r\n          &lt;i class="fa fa-cog"&gt;&lt;/i&gt; Configure\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id="collapseTwo" class="panel-collapse collapse"&gt;\r\n      &lt;div class="panel-body"&gt; ... &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n  &lt;div class="panel panel-default"&gt;\r\n    &lt;div class="panel-heading"&gt;\r\n      &lt;h4 class="panel-title"&gt;\r\n        &lt;a data-toggle="collapse" data-parent="#accordion" href="#collapseThree"&gt;\r\n          &lt;i class="fa fa-cloud-download"&gt;&lt;/i&gt; Download\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id="collapseThree" class="panel-collapse collapse"&gt;\r\n      &lt;div class="panel-body"&gt; ... &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<hr>\r\n<br>\r\n<h2 id="buttons">Buttons</h2>\r\n<div>\r\n<a href="#" class="button">Read more</a>\r\n</div>\r\n<pre>\r\n&lt;a href="#" class="button"&gt;Read more&lt;/a&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<h2 id="progressbars">Progress Bars</h2>\r\n<h5>40% Complete (success)</h5>\r\n<div class="progress">\r\n<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">\r\n<span class="sr-only">40% Complete (success)</span>\r\n</div>\r\n</div>\r\n<h5>20% Complete (info)</h5>\r\n<div class="progress">\r\n<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">\r\n<span class="sr-only">20% Complete</span>\r\n</div>\r\n</div>\r\n<h5>60% Complete (warning)</h5>\r\n<div class="progress">\r\n<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">\r\n<span class="sr-only">60% Complete (warning)</span>\r\n</div>\r\n</div>\r\n<h5>80% Complete (danger)</h5>\r\n<div class="progress">\r\n<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">\r\n<span class="sr-only">80% Complete</span>\r\n</div>\r\n</div>\r\n<h5>Results</h5>\r\n<div class="progress">\r\n<div class="progress-bar progress-bar-success" style="width: 40%">\r\n<span class="sr-only">35% A</span>\r\n</div>\r\n<div class="progress-bar progress-bar-info" style="width: 30%">\r\n<span class="sr-only">20% B</span>\r\n</div>\r\n<div class="progress-bar progress-bar-warning" style="width: 20%">\r\n<span class="sr-only">20% C</span>\r\n</div>\r\n<div class="progress-bar progress-bar-danger" style="width: 10%">\r\n<span class="sr-only">10% D</span>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;h5>40% Complete (success)&lt;/h5&gt;\r\n&lt;div class="progress"&gt;\r\n  &lt;div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%"&gt;\r\n    &lt;span class="sr-only"&gt;40% Complete (success)&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;20% Complete (info)&lt;/h5&gt;\r\n&lt;div class="progress"&gt;\r\n  &lt;div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%"&gt;\r\n    &lt;span class="sr-only"&gt;20% Complete&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;60% Complete (warning)&lt;/h5&gt;\r\n&lt;div class="progress"&gt;\r\n  &lt;div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%"&gt;\r\n    &lt;span class="sr-only"&gt;60% Complete (warning)&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;80% Complete (danger)&lt;/h5&gt;\r\n&lt;div class="progress"&gt;\r\n  &lt;div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%"&gt;\r\n    &lt;span class="sr-only"&gt;80% Complete&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;Results&lt;/h5&gt;\r\n&lt;div class="progress"&gt;\r\n  &lt;div class="progress-bar progress-bar-success" style="width: 40%"&gt;\r\n    &lt;span class="sr-only"&gt;35% A&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class="progress-bar progress-bar-info" style="width: 30%"&gt;\r\n    &lt;span class="sr-only"&gt;20% B&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class="progress-bar progress-bar-warning" style="width: 20%"&gt;\r\n    &lt;span class="sr-only"&gt;20% C&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class="progress-bar progress-bar-danger" style="width: 10%"&gt;\r\n    &lt;span class="sr-only"&gt;10% D&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<div class="alert alert-info"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>Check all available Font Awesome icons at <a  target="_blank" href="http://fortawesome.github.io/Font-Awesome/icons/" class="alert-link">http://fortawesome.github.io/Font-Awesome/icons/</a></div>', 'Shortcodes phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate. Nullam id dolor id nibh ultricies vehicula ut id elit integer.', 'full_html'),
('node', 'page', 0, 16, 16, 'und', 0, '<h2>Columns</h2>\r\n\r\n<div class="row">\r\n<div class="col-md-6">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class="col-md-6"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-6"&gt;\r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-6"&gt; \r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n<div class="row">\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n\r\n<div class="col-md-8"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-8"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-8"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-8"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-9"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-9"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-9"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-9"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>', '<div class="row">\r\n<div class="col-md-6">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class="col-md-6"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>', 'full_html');
INSERT INTO `field_data_body` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `body_value`, `body_summary`, `body_format`) VALUES
('node', 'page', 0, 17, 17, 'und', 0, '<h2>Columns</h2>\r\n\r\n<div class="row">\r\n<div class="col-md-6">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class="col-md-6"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-6"&gt;\r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-6"&gt; \r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n<div class="row">\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n\r\n<div class="col-md-8"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-8"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-8"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-8"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-9"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-9"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-9"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-9"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>', '<div class="row">\r\n<div class="col-md-6">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class="col-md-6"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>', 'full_html');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_comment_body`
--

DROP TABLE IF EXISTS `field_data_comment_body`;
CREATE TABLE `field_data_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 1 (comment_body)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_comment_body`
--

INSERT INTO `field_data_comment_body` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `comment_body_value`, `comment_body_format`) VALUES
('comment', 'comment_node_mt_post', 0, 1, 1, 'und', 0, 'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'filtered_html'),
('comment', 'comment_node_mt_post', 0, 2, 2, 'und', 0, 'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'filtered_html'),
('comment', 'comment_node_mt_post', 0, 3, 3, 'und', 0, 'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'filtered_html'),
('comment', 'comment_node_mt_post', 0, 4, 4, 'und', 0, 'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'filtered_html');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_image`
--

DROP TABLE IF EXISTS `field_data_field_image`;
CREATE TABLE `field_data_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 4 (field_image)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_image`
--

INSERT INTO `field_data_field_image` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_image_fid`, `field_image_alt`, `field_image_title`, `field_image_width`, `field_image_height`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 1, '', 'And this is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 1, 1, 'und', 1, 16, '', 'Title of Image', 750, 499),
('node', 'mt_post', 0, 1, 1, 'und', 2, 17, '', 'Title of Image', 750, 499),
('node', 'mt_post', 0, 1, 1, 'und', 3, 18, '', 'Title of Image', 750, 499),
('node', 'mt_post', 0, 1, 1, 'und', 4, 19, '', 'Title of Image', 750, 499),
('node', 'mt_post', 0, 1, 1, 'und', 5, 20, '', 'Title of Image', 750, 499),
('node', 'mt_post', 0, 2, 2, 'und', 0, 45, '', 'Caption competently expedite standards compliant users and leadership.', 750, 499),
('node', 'mt_post', 0, 3, 3, 'und', 0, 3, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 4, 4, 'und', 0, 4, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 5, 5, 'und', 0, 5, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 6, 6, 'und', 0, 6, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 7, 7, 'und', 0, 7, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 8, 8, 'und', 0, 8, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 9, 9, 'und', 0, 9, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 10, 10, 'und', 0, 10, '', 'Caption. Competently expedite standards compliant users and leadership. ', 750, 499),
('node', 'mt_post', 0, 11, 11, 'und', 0, 44, '', 'Caption. Competently expedite standards compliant users and leadership.', 750, 499),
('node', 'mt_post', 0, 12, 12, 'und', 0, 12, '', 'And this is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_about`
--

DROP TABLE IF EXISTS `field_data_field_mt_about`;
CREATE TABLE `field_data_field_mt_about` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_about_value` longtext,
  `field_mt_about_summary` longtext,
  `field_mt_about_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_about_format` (`field_mt_about_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 7 (field_mt_about)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_mt_about`
--

INSERT INTO `field_data_field_mt_about` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_about_value`, `field_mt_about_summary`, `field_mt_about_format`) VALUES
('user', 'user', 0, 1, 1, 'und', 0, 'Quickly extend top-line opportunities for leveraged bandwidth. Conveniently maximize low-risk high-yield ROI rather than cooperative synergy. Appropriately synthesize cooperative portals without backward-compatible total linkage. Seamlessly plagiarize value-added deliverables with customer directed technologies. ', '', 'filtered_html');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_banner_image`
--

DROP TABLE IF EXISTS `field_data_field_mt_banner_image`;
CREATE TABLE `field_data_field_mt_banner_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_banner_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_mt_banner_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_mt_banner_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_mt_banner_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_mt_banner_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_banner_image_fid` (`field_mt_banner_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 23 (field_mt_banner_image)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_mt_banner_image`
--

INSERT INTO `field_data_field_mt_banner_image` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_banner_image_fid`, `field_mt_banner_image_alt`, `field_mt_banner_image_title`, `field_mt_banner_image_width`, `field_mt_banner_image_height`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 37, 'Synergistically streamline prospective content whereas turnkey web services. Efficiently formulate enabled processes with granular processes.', 'Slide 1 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 1, 38, 'Efficiently formulate enabled processes with granular processes.', 'Slide 2 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 2, 39, 'Synergistically streamline prospective content whereas turnkey web services.', 'Slide 3 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 3, 40, 'Efficiently formulate enabled processes with granular processes. Synergistically streamline prospective content whereas turnkey web services.', 'Slide 4 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 4, 41, 'Collaboratively engage value-added potentialities rather than quality innovation.', 'Slide 5 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 5, 42, 'Collaboratively repurpose resource-leveling scenarios via integrated functionalities', 'Slide 6 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 6, 43, '', 'Slide 7 title', 1170, 610);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_breaking`
--

DROP TABLE IF EXISTS `field_data_field_mt_breaking`;
CREATE TABLE `field_data_field_mt_breaking` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_breaking_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_breaking_value` (`field_mt_breaking_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 13 (field_mt_breaking)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_mt_breaking`
--

INSERT INTO `field_data_field_mt_breaking` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_breaking_value`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 1),
('node', 'mt_post', 0, 2, 2, 'und', 0, 1),
('node', 'mt_post', 0, 3, 3, 'und', 0, 1),
('node', 'mt_post', 0, 4, 4, 'und', 0, 0),
('node', 'mt_post', 0, 5, 5, 'und', 0, 0),
('node', 'mt_post', 0, 6, 6, 'und', 0, 0),
('node', 'mt_post', 0, 7, 7, 'und', 0, 0),
('node', 'mt_post', 0, 8, 8, 'und', 0, 0),
('node', 'mt_post', 0, 9, 9, 'und', 0, 0),
('node', 'mt_post', 0, 10, 10, 'und', 0, 0),
('node', 'mt_post', 0, 11, 11, 'und', 0, 0),
('node', 'mt_post', 0, 12, 12, 'und', 0, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_facebook`
--

DROP TABLE IF EXISTS `field_data_field_mt_facebook`;
CREATE TABLE `field_data_field_mt_facebook` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_facebook_value` varchar(255) DEFAULT NULL,
  `field_mt_facebook_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_facebook_format` (`field_mt_facebook_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 17 (field_mt_facebook)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_mt_facebook`
--

INSERT INTO `field_data_field_mt_facebook` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_facebook_value`, `field_mt_facebook_format`) VALUES
('user', 'user', 0, 1, 1, 'und', 0, 'https://www.facebook.com/morethan.just.themes', NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_google_plus`
--

DROP TABLE IF EXISTS `field_data_field_mt_google_plus`;
CREATE TABLE `field_data_field_mt_google_plus` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_google_plus_value` varchar(255) DEFAULT NULL,
  `field_mt_google_plus_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_google_plus_format` (`field_mt_google_plus_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 19 (field_mt_google_plus)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_mt_google_plus`
--

INSERT INTO `field_data_field_mt_google_plus` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_google_plus_value`, `field_mt_google_plus_format`) VALUES
('user', 'user', 0, 1, 1, 'und', 0, 'https://plus.google.com/+Morethanthemes/posts', NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_post_categories`
--

DROP TABLE IF EXISTS `field_data_field_mt_post_categories`;
CREATE TABLE `field_data_field_mt_post_categories` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_post_categories_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_post_categories_tid` (`field_mt_post_categories_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 5 (field_mt_post_categories)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_mt_post_categories`
--

INSERT INTO `field_data_field_mt_post_categories` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_post_categories_tid`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 2),
('node', 'mt_post', 0, 2, 2, 'und', 0, 3),
('node', 'mt_post', 0, 3, 3, 'und', 0, 5),
('node', 'mt_post', 0, 4, 4, 'und', 0, 6),
('node', 'mt_post', 0, 5, 5, 'und', 0, 4),
('node', 'mt_post', 0, 6, 6, 'und', 0, 1),
('node', 'mt_post', 0, 7, 7, 'und', 0, 2),
('node', 'mt_post', 0, 8, 8, 'und', 0, 3),
('node', 'mt_post', 0, 9, 9, 'und', 0, 5),
('node', 'mt_post', 0, 10, 10, 'und', 0, 6),
('node', 'mt_post', 0, 11, 11, 'und', 0, 4),
('node', 'mt_post', 0, 12, 12, 'und', 0, 1);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_slideshow`
--

DROP TABLE IF EXISTS `field_data_field_mt_slideshow`;
CREATE TABLE `field_data_field_mt_slideshow` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_slideshow_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_slideshow_value` (`field_mt_slideshow_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 21 (field_mt_slideshow)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_mt_slideshow`
--

INSERT INTO `field_data_field_mt_slideshow` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_slideshow_value`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 1),
('node', 'mt_post', 0, 2, 2, 'und', 0, 1),
('node', 'mt_post', 0, 3, 3, 'und', 0, 0),
('node', 'mt_post', 0, 4, 4, 'und', 0, 0),
('node', 'mt_post', 0, 5, 5, 'und', 0, 0),
('node', 'mt_post', 0, 6, 6, 'und', 0, 0),
('node', 'mt_post', 0, 7, 7, 'und', 0, 0),
('node', 'mt_post', 0, 8, 8, 'und', 0, 0),
('node', 'mt_post', 0, 9, 9, 'und', 0, 0),
('node', 'mt_post', 0, 10, 10, 'und', 0, 0),
('node', 'mt_post', 0, 11, 11, 'und', 0, 0),
('node', 'mt_post', 0, 12, 12, 'und', 0, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_slideshow_path`
--

DROP TABLE IF EXISTS `field_data_field_mt_slideshow_path`;
CREATE TABLE `field_data_field_mt_slideshow_path` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_slideshow_path_value` varchar(255) DEFAULT NULL,
  `field_mt_slideshow_path_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_slideshow_path_format` (`field_mt_slideshow_path_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 22 (field_mt_slideshow_path)';

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_subheader_body`
--

DROP TABLE IF EXISTS `field_data_field_mt_subheader_body`;
CREATE TABLE `field_data_field_mt_subheader_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_subheader_body_value` longtext,
  `field_mt_subheader_body_summary` longtext,
  `field_mt_subheader_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_subheader_body_format` (`field_mt_subheader_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 6 (field_mt_subheader_body)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_mt_subheader_body`
--

INSERT INTO `field_data_field_mt_subheader_body` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_subheader_body_value`, `field_mt_subheader_body_summary`, `field_mt_subheader_body_format`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 2, 2, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 3, 3, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly <a href="#">extend top-line opportunities for leveraged</a> bandwidth.', '', 'filtered_html'),
('node', 'mt_post', 0, 4, 4, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 5, 5, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 6, 6, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 7, 7, 'und', 0, 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', '', 'filtered_html'),
('node', 'mt_post', 0, 8, 8, 'und', 0, 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', '', 'filtered_html'),
('node', 'mt_post', 0, 9, 9, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 10, 10, 'und', 0, 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', '', 'filtered_html'),
('node', 'mt_post', 0, 11, 11, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can <a href="#">quickly extend top-line opportunities for leveraged bandwidth</a>. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 12, 12, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_teaser_image`
--

DROP TABLE IF EXISTS `field_data_field_mt_teaser_image`;
CREATE TABLE `field_data_field_mt_teaser_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_teaser_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_mt_teaser_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_mt_teaser_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_mt_teaser_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_mt_teaser_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_teaser_image_fid` (`field_mt_teaser_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 20 (field_mt_teaser_image)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_mt_teaser_image`
--

INSERT INTO `field_data_field_mt_teaser_image` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_teaser_image_fid`, `field_mt_teaser_image_alt`, `field_mt_teaser_image_title`, `field_mt_teaser_image_width`, `field_mt_teaser_image_height`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 35, '', '', 1170, 610),
('node', 'mt_post', 0, 2, 2, 'und', 0, 36, '', '', 1170, 610);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_mt_twitter`
--

DROP TABLE IF EXISTS `field_data_field_mt_twitter`;
CREATE TABLE `field_data_field_mt_twitter` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_twitter_value` varchar(255) DEFAULT NULL,
  `field_mt_twitter_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_twitter_format` (`field_mt_twitter_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 18 (field_mt_twitter)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_mt_twitter`
--

INSERT INTO `field_data_field_mt_twitter` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_twitter_value`, `field_mt_twitter_format`) VALUES
('user', 'user', 0, 1, 1, 'und', 0, 'https://twitter.com/morethanthemes/', NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_data_field_tags`
--

DROP TABLE IF EXISTS `field_data_field_tags`;
CREATE TABLE `field_data_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned DEFAULT NULL COMMENT 'The entity revision id this data is attached to, or NULL if the entity type is not versioned',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Data storage for field 3 (field_tags)';

--
-- Άδειασμα δεδομένων του πίνακα `field_data_field_tags`
--

INSERT INTO `field_data_field_tags` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_tags_tid`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 7),
('node', 'mt_post', 0, 1, 1, 'und', 1, 8),
('node', 'mt_post', 0, 1, 1, 'und', 2, 9),
('node', 'mt_post', 0, 2, 2, 'und', 0, 7),
('node', 'mt_post', 0, 2, 2, 'und', 1, 8),
('node', 'mt_post', 0, 2, 2, 'und', 2, 9),
('node', 'mt_post', 0, 3, 3, 'und', 0, 7),
('node', 'mt_post', 0, 3, 3, 'und', 1, 9),
('node', 'mt_post', 0, 4, 4, 'und', 0, 7),
('node', 'mt_post', 0, 4, 4, 'und', 1, 10),
('node', 'mt_post', 0, 4, 4, 'und', 2, 11),
('node', 'mt_post', 0, 5, 5, 'und', 0, 8),
('node', 'mt_post', 0, 5, 5, 'und', 1, 9),
('node', 'mt_post', 0, 5, 5, 'und', 2, 10),
('node', 'mt_post', 0, 6, 6, 'und', 0, 7),
('node', 'mt_post', 0, 6, 6, 'und', 1, 8),
('node', 'mt_post', 0, 6, 6, 'und', 2, 11),
('node', 'mt_post', 0, 7, 7, 'und', 0, 7),
('node', 'mt_post', 0, 7, 7, 'und', 1, 8),
('node', 'mt_post', 0, 7, 7, 'und', 2, 9),
('node', 'mt_post', 0, 7, 7, 'und', 3, 10),
('node', 'mt_post', 0, 8, 8, 'und', 0, 10),
('node', 'mt_post', 0, 8, 8, 'und', 1, 11),
('node', 'mt_post', 0, 9, 9, 'und', 0, 8),
('node', 'mt_post', 0, 9, 9, 'und', 1, 9),
('node', 'mt_post', 0, 9, 9, 'und', 2, 10),
('node', 'mt_post', 0, 9, 9, 'und', 3, 11),
('node', 'mt_post', 0, 10, 10, 'und', 0, 7),
('node', 'mt_post', 0, 10, 10, 'und', 1, 10),
('node', 'mt_post', 0, 10, 10, 'und', 2, 11),
('node', 'mt_post', 0, 11, 11, 'und', 0, 8),
('node', 'mt_post', 0, 11, 11, 'und', 1, 9),
('node', 'mt_post', 0, 11, 11, 'und', 2, 11),
('node', 'mt_post', 0, 12, 12, 'und', 0, 7),
('node', 'mt_post', 0, 12, 12, 'und', 1, 8),
('node', 'mt_post', 0, 12, 12, 'und', 2, 9),
('node', 'mt_post', 0, 12, 12, 'und', 3, 10),
('node', 'mt_post', 0, 12, 12, 'und', 4, 11);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_body`
--

DROP TABLE IF EXISTS `field_revision_body`;
CREATE TABLE `field_revision_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `body_value` longtext,
  `body_summary` longtext,
  `body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `body_format` (`body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 2 (body)';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_body`
--

INSERT INTO `field_revision_body` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `body_value`, `body_summary`, `body_format`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 2, 2, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>\r\n<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris id sapien eu tortor vestibulum venenatis a eget augue. Nam massa nisi, tempor in tortor ut, tincidunt tempus ipsum. Phasellus adipiscing scelerisque sapien, non aliquet massa scelerisque nec. Duis leo arcu, posuere vel purus id, dignissim cursus ante. Nulla nisi lorem, <a href="#">pulvinar non</a> purus sed, molestie faucibus sapien. Donec arcu orci, rhoncus faucibus tempor at, fringilla vitae mauris. Vestibulum laoreet est quis lorem egestas, non ornare sapien blandit. Praesent rutrum aliquam augue et sollicitudin. Proin lobortis pulvinar libero, ac dictum libero blandit eget. Suspendisse pretium, diam sit amet facilisis aliquet, mi augue venenatis nibh, in gravida odio ipsum in nulla.</p>\r\n<p>In quis velit lacus. Suspendisse potenti. Interdum et malesuada fames ac ante ipsum primis in faucibus. Vestibulum arcu tellus, semper vitae iaculis id, adipiscing ac est. Curabitur eget laoreet dui. Vestibulum rhoncus vel risus non pharetra. Nulla sagittis nisl vitae nulla facilisis, non imperdiet arcu dignissim. Sed iaculis ligula sed enim rhoncus tincidunt. Sed gravida venenatis lobortis. Praesent porttitor arcu at velit sagittis, id pharetra est tincidunt.</p>\r\n<h3>Interdum et malesuada fames ac ante ipsum</h3>\r\n<p>Suspendisse dapibus rhoncus turpis, vel elementum est vestibulum eget. Nullam luctus non nisi ut tempor. Suspendisse eu pretium tortor, non tristique libero. Quisque vitae mi rutrum, imperdiet neque vel, feugiat orci. Vestibulum cursus rutrum turpis ut facilisis. Proin sed tempus mauris, sit amet facilisis ante. Duis tempus dignissim augue quis sagittis. Vivamus at varius turpis. Proin commodo ante ac velit auctor tincidunt. Praesent euismod lectus ac scelerisque scelerisque. Aliquam suscipit nisi erat, sed posuere lacus scelerisque ac. Praesent lacinia <a href="#">consectetur mi</a>, nec auctor ante blandit ut.</p>\r\n<p>Suspendisse suscipit rutrum leo, ac sodales dolor mattis eu. Vivamus accumsan mattis sem a lacinia. Aliquam erat volutpat. Vivamus volutpat quam sit amet eros gravida, nec fermentum tellus tristique. Suspendisse tincidunt porttitor pulvinar. In pharetra felis quis mauris dapibus sollicitudin. Vestibulum commodo dui ut risus mollis, vel bibendum eros venenatis.</p>\r\n<p>Aenean semper sem vitae libero congue, vel sollicitudin elit porta. Sed massa libero, varius et justo eu, sagittis venenatis libero. Vestibulum adipiscing sit amet risus eu gravida. Duis metus magna, vehicula id arcu ut, suscipit imperdiet dolor. Phasellus consequat urna eros, eu luctus erat rutrum non. Donec ultricies eros sit amet dolor congue, non accumsan risus iaculis. Donec elementum ante vitae sem viverra gravida. Morbi fringilla eget lectus eu lacinia.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 3, 3, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 4, 4, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 5, 5, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 6, 6, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 7, 7, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', 'full_html'),
('node', 'mt_post', 0, 8, 8, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', 'filtered_html'),
('node', 'mt_post', 0, 9, 9, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 10, 10, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'How you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', 'full_html'),
('node', 'mt_post', 0, 11, 11, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'mt_post', 0, 12, 12, 'und', 0, '<p>Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.</p>\r\n<h2>Error-free quality vectors for principle  centered models as heading two</h2>\r\n<p>Compellingly iterate diverse channels whereas compelling potentialities. Authoritatively <a href="#">maximize prospective quality vectors with prospective</a> paradigms. Collaboratively mesh real-time niches with leading-edge scenarios.</p>\r\n<blockquote><p>Collaboratively engage value-added potentialities rather than quality innovation.</p></blockquote>\r\n<p>Continually reintermediate fully tested e-markets for B2C portals. Collaboratively repurpose resource-leveling scenarios via integrated functionalities. Energistically maximize tactical supply chains after impactful solutions.</p>', 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', 'full_html'),
('node', 'webform', 0, 13, 13, 'und', 0, 'Send us your stories and story suggestions, or any questions by using the form to contact us. For advertisement-related questions please use our <a href="#">Advertising section<a>.', '', 'filtered_html'),
('node', 'page', 0, 14, 14, 'und', 0, '<p class="large">Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate.</p> \r\n<h2>Heading 2</h2>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href="#">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h2><a href="#">Linked Heading 2</a></h2>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href="#">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<p>\r\nLorem ipsum dolor sit amet, consectetur adipisicing elit. Sit, esse, quo distinctio dolores magni reprehenderit id est at fugiat veritatis fugit dignissimos sed ut facere molestias illo impedit. Tempora, iure!\r\n</p>\r\n<h3>Heading 3</h3>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href="#">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h4>Heading 4</h4>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href="#">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<h5>Heading 5</h5>\r\n<p>\r\nDonec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer <a href="#">posuere erat a ante</a> venenatis dapibus posuere velit aliquet.\r\n</p>\r\n<blockquote>\r\n<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested <a href="#">expertise with quote link</a>. Appropriately communicate adaptive imperatives rather than value-added potentialities. Conveniently harness frictionless outsourcing.</p>\r\n</blockquote>\r\n<h3>Messages</h3>\r\n<div class="messages status">\r\nSample status message. Page <em><strong>Typography</strong></em> has been updated.\r\n</div>\r\n<div class="messages error">\r\nSample error message. There is a security update available for your version of Drupal. To ensure the security of your server, you should update immediately! See the available updates page for more information.\r\n</div>\r\n<div class="messages warning">\r\nSample warning message. Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.\r\n</div>\r\n<br/>\r\n<h3>Paragraph With Links</h3>\r\n<p>\r\nLorem ipsum dolor sit amet, <a href="#">consectetuer adipiscing</a> elit. Donec odio. Quisque volutpat mattis eros. <a href="#">Nullam malesuada</a> erat ut turpis. Suspendisse urna nibh, viverra non, semper suscipit, posuere a, pede.\r\n</p>\r\n<h3>Ordered List</h3>\r\n<ol>\r\n<li>\r\nThis is a sample Ordered List.\r\n</li>\r\n<li>\r\nLorem ipsum dolor sit amet consectetuer.\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor.\r\n<ol>\r\n<li>\r\nSomething goes here.\r\n</li>\r\n<li>\r\nAnd another here\r\n</li>\r\n</ol>\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor nibh.\r\n</li>\r\n</ol>\r\n\r\n<h3>Unordered List</h3>\r\n<ul>\r\n<li>\r\nThis is a sample <strong>Unordered List</strong>.\r\n</li>\r\n<li>\r\nCondimentum quis.\r\n</li>\r\n<li>\r\nCongue Quisque augue elit dolor.\r\n<ul>\r\n<li>\r\nSomething goes here.\r\n</li>\r\n<li>\r\nAnd another here\r\n<ul>\r\n<li>\r\nSomething here as well\r\n</li>\r\n<li>\r\nSomething here as well\r\n</li>\r\n<li>\r\nSomething here as well\r\n</li>\r\n</ul>\r\n</li>\r\n<li>\r\nThen one more\r\n</li>\r\n</ul>\r\n</li>\r\n<li>\r\nNunc cursus sem et pretium sapien eget.\r\n</li>\r\n</ul>\r\n\r\n<h3>Fieldset</h3>\r\n<fieldset><legend>Account information</legend></fieldset>\r\n\r\n<h3>Table</h3>\r\n<table>\r\n<tr>\r\n<th>Header 1</th>\r\n<th>Header 2</th>\r\n</tr>\r\n<tr class="odd">\r\n<td>row 1, cell 1</td>\r\n<td>row 1, cell 2</td>\r\n</tr>\r\n<tr class="even">\r\n<td>row 2, cell 1</td>\r\n<td>row 2, cell 2</td>\r\n</tr>\r\n<tr class="odd">\r\n<td>row 3, cell 1</td>\r\n<td>row 3, cell 2</td>\r\n</tr>\r\n</table>', '<p>Phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate. Nullam id dolor id nibh ultricies vehicula ut id elit integer.</p> ', 'full_html'),
('node', 'page', 0, 15, 15, 'und', 0, '<h2 id="brands">Brands</h2>\r\n<ul class="brands">\r\n<li>\r\n<a href="#"><i class="fa fa-apple"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-android"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-github"></i></a>\r\n</li>                        \r\n<li>\r\n<a href="#"><i class="fa fa-windows"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-linux"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-skype"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-btc"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-css3"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-html5"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-bitbucket"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-maxcdn"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-dropbox"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-facebook"></i></a>\r\n</li>\r\n<li>\r\n<a href="#"><i class="fa fa-twitter"></i></a>\r\n</li>\r\n</ul>\r\n<pre>\r\n&lt;ul class="brands"&gt;\r\n\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-apple"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-android"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-github"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-windows"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-linux"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-skype"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-btc"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-css3"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-html5"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-bitbucket"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-maxcdn"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-dropbox"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-facebook"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#"&gt;&lt;i class="fa fa-twitter"&gt;&lt;/i&gt;&lt;/a&gt;&lt;/li&gt;\r\n\r\n&lt;/ul&gt;\r\n</pre>\r\n<hr>\r\n<br>\r\n<h2 id="tabs">Tabs</h2>\r\n<!-- Nav tabs -->\r\n<ul class="nav nav-tabs">\r\n<li class="active"><a href="#home" data-toggle="tab"><i class="fa fa-home"></i>Home</a></li>\r\n<li><a href="#profile" data-toggle="tab"><i class="fa fa-user"></i>Profile</a></li>\r\n<li><a href="#messages" data-toggle="tab"><i class="fa fa-envelope"></i>Messages</a></li>\r\n</ul>\r\n<!-- Tab panes -->\r\n<div class="tab-content">\r\n<div class="tab-pane active" id="home">\r\n<p><strong>Home</strong> ipsum dolor sit amet, consectetur adipisicing elit. Perspiciatis, exercitationem, quaerat veniam repudiandae illo ratione eaque omnis obcaecati quidem distinctio sapiente quo assumenda amet cumque nobis nulla qui dolore autem.</p>\r\n</div>\r\n<div class="tab-pane" id="profile">\r\n<p><strong>Profile</strong> ipsum dolor sit amet, consectetur adipisicing elit. Ut odio facere minima porro quis. Maiores eius quibusdam et in corrupti necessitatibus consequatur debitis laudantium hic.</p>\r\n</div>\r\n<div class="tab-pane" id="messages">\r\n<p><strong>Messages</strong> ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis, optio error consectetur ullam porro eligendi mollitia odio numquam aut cumque. Sed, possimus recusandae itaque laboriosam nesciunt voluptates veniam aspernatur voluptate eaque ratione totam ipsa optio aliquam incidunt dolorum amet illum.</p>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;!-- Nav tabs --&gt;\r\n&lt;ul class="nav nav-tabs"&gt;\r\n\r\n  &lt;li class="active"&gt;&lt;a href="#home" data-toggle="tab"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#profile" data-toggle="tab"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n  &lt;li&gt;&lt;a href="#messages" data-toggle="tab"&gt; ... &lt;/a&gt;&lt;/li&gt;\r\n\r\n&lt;/ul&gt;\r\n\r\n&lt;!-- Tab panes --&gt;\r\n&lt;div class="tab-content"&gt;\r\n\r\n  &lt;div class="tab-pane active" id="home"&gt; ...  &lt;/div&gt;\r\n  &lt;div class="tab-pane" id="profile"&gt; ... &lt;/div&gt;\r\n  &lt;div class="tab-pane" id="messages"&gt; ... &lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<h2 id="accordion">Accordion</h2>\r\n<div class="panel-group" id="accordion">\r\n<div class="panel panel-default">\r\n<div class="panel-heading">\r\n<h4 class="panel-title">\r\n<a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"><i class="fa fa-home"></i> Home</a>\r\n</h4>\r\n</div>\r\n<div id="collapseOne" class="panel-collapse collapse in">\r\n<div class="panel-body">\r\n<strong>Home</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n<div class="panel panel-default">\r\n<div class="panel-heading">\r\n<h4 class="panel-title">\r\n<a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" class="collapsed"><i class="fa fa-cog"></i> Configure</a>\r\n</h4>\r\n</div>\r\n<div id="collapseTwo" class="panel-collapse collapse">\r\n<div class="panel-body">\r\n<strong>Configure</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n<div class="panel panel-default">\r\n<div class="panel-heading">\r\n<h4 class="panel-title">\r\n<a data-toggle="collapse" data-parent="#accordion" href="#collapseThree" class="collapsed"><i class="fa fa-cloud-download"></i> Download</a>\r\n</h4>\r\n</div>\r\n<div id="collapseThree" class="panel-collapse collapse">\r\n<div class="panel-body">\r\n<strong>Download</strong> Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably haven''t heard of them accusamus labore sustainable VHS.\r\n</div>\r\n</div>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;div class="panel-group" id="accordion"&gt;\r\n\r\n  &lt;div class="panel panel-default"&gt;\r\n    &lt;div class="panel-heading"&gt;\r\n      &lt;h4 class="panel-title"&gt;\r\n        &lt;a data-toggle="collapse" data-parent="#accordion" href="#collapseOne"&gt;\r\n          &lt;i class="fa fa-home"&gt;&lt;/i&gt; Home\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id="collapseOne" class="panel-collapse collapse in"&gt;\r\n      &lt;div class="panel-body"&gt; ...  &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n  &lt;div class="panel panel-default"&gt;\r\n    &lt;div class="panel-heading"&gt;\r\n      &lt;h4 class="panel-title"&gt;\r\n        &lt;a data-toggle="collapse" data-parent="#accordion" href="#collapseTwo"&gt;\r\n          &lt;i class="fa fa-cog"&gt;&lt;/i&gt; Configure\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id="collapseTwo" class="panel-collapse collapse"&gt;\r\n      &lt;div class="panel-body"&gt; ... &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n  &lt;div class="panel panel-default"&gt;\r\n    &lt;div class="panel-heading"&gt;\r\n      &lt;h4 class="panel-title"&gt;\r\n        &lt;a data-toggle="collapse" data-parent="#accordion" href="#collapseThree"&gt;\r\n          &lt;i class="fa fa-cloud-download"&gt;&lt;/i&gt; Download\r\n        &lt;/a&gt;\r\n      &lt;/h4&gt;\r\n    &lt;/div&gt;\r\n    &lt;div id="collapseThree" class="panel-collapse collapse"&gt;\r\n      &lt;div class="panel-body"&gt; ... &lt;/div&gt;\r\n    &lt;/div&gt;\r\n  &lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<hr>\r\n<br>\r\n<h2 id="buttons">Buttons</h2>\r\n<div>\r\n<a href="#" class="button">Read more</a>\r\n</div>\r\n<pre>\r\n&lt;a href="#" class="button"&gt;Read more&lt;/a&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<h2 id="progressbars">Progress Bars</h2>\r\n<h5>40% Complete (success)</h5>\r\n<div class="progress">\r\n<div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">\r\n<span class="sr-only">40% Complete (success)</span>\r\n</div>\r\n</div>\r\n<h5>20% Complete (info)</h5>\r\n<div class="progress">\r\n<div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%">\r\n<span class="sr-only">20% Complete</span>\r\n</div>\r\n</div>\r\n<h5>60% Complete (warning)</h5>\r\n<div class="progress">\r\n<div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%">\r\n<span class="sr-only">60% Complete (warning)</span>\r\n</div>\r\n</div>\r\n<h5>80% Complete (danger)</h5>\r\n<div class="progress">\r\n<div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%">\r\n<span class="sr-only">80% Complete</span>\r\n</div>\r\n</div>\r\n<h5>Results</h5>\r\n<div class="progress">\r\n<div class="progress-bar progress-bar-success" style="width: 40%">\r\n<span class="sr-only">35% A</span>\r\n</div>\r\n<div class="progress-bar progress-bar-info" style="width: 30%">\r\n<span class="sr-only">20% B</span>\r\n</div>\r\n<div class="progress-bar progress-bar-warning" style="width: 20%">\r\n<span class="sr-only">20% C</span>\r\n</div>\r\n<div class="progress-bar progress-bar-danger" style="width: 10%">\r\n<span class="sr-only">10% D</span>\r\n</div>\r\n</div>\r\n\r\n<pre>\r\n&lt;h5>40% Complete (success)&lt;/h5&gt;\r\n&lt;div class="progress"&gt;\r\n  &lt;div class="progress-bar progress-bar-success" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%"&gt;\r\n    &lt;span class="sr-only"&gt;40% Complete (success)&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;20% Complete (info)&lt;/h5&gt;\r\n&lt;div class="progress"&gt;\r\n  &lt;div class="progress-bar progress-bar-info" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100" style="width: 20%"&gt;\r\n    &lt;span class="sr-only"&gt;20% Complete&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;60% Complete (warning)&lt;/h5&gt;\r\n&lt;div class="progress"&gt;\r\n  &lt;div class="progress-bar progress-bar-warning" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%"&gt;\r\n    &lt;span class="sr-only"&gt;60% Complete (warning)&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;80% Complete (danger)&lt;/h5&gt;\r\n&lt;div class="progress"&gt;\r\n  &lt;div class="progress-bar progress-bar-danger" role="progressbar" aria-valuenow="80" aria-valuemin="0" aria-valuemax="100" style="width: 80%"&gt;\r\n    &lt;span class="sr-only"&gt;80% Complete&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;h5&gt;Results&lt;/h5&gt;\r\n&lt;div class="progress"&gt;\r\n  &lt;div class="progress-bar progress-bar-success" style="width: 40%"&gt;\r\n    &lt;span class="sr-only"&gt;35% A&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class="progress-bar progress-bar-info" style="width: 30%"&gt;\r\n    &lt;span class="sr-only"&gt;20% B&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class="progress-bar progress-bar-warning" style="width: 20%"&gt;\r\n    &lt;span class="sr-only"&gt;20% C&lt;/span&gt;\r\n  &lt;/div&gt;\r\n  &lt;div class="progress-bar progress-bar-danger" style="width: 10%"&gt;\r\n    &lt;span class="sr-only"&gt;10% D&lt;/span&gt;\r\n  &lt;/div&gt;\r\n&lt;/div&gt;\r\n</pre>\r\n\r\n<hr>\r\n<br>\r\n<div class="alert alert-info"><button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>Check all available Font Awesome icons at <a  target="_blank" href="http://fortawesome.github.io/Font-Awesome/icons/" class="alert-link">http://fortawesome.github.io/Font-Awesome/icons/</a></div>', 'Shortcodes phosfluorescently e-enable adaptive synergy for strategic quality vectors. Continually transform fully tested expertise with competitive technologies appropriately communicate. Nullam id dolor id nibh ultricies vehicula ut id elit integer.', 'full_html'),
('node', 'page', 0, 16, 16, 'und', 0, '<h2>Columns</h2>\r\n\r\n<div class="row">\r\n<div class="col-md-6">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class="col-md-6"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-6"&gt;\r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-6"&gt; \r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n<div class="row">\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n\r\n<div class="col-md-8"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-8"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-8"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-8"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-9"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-9"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-9"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-9"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>', '<div class="row">\r\n<div class="col-md-6">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class="col-md-6"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>', 'full_html');
INSERT INTO `field_revision_body` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `body_value`, `body_summary`, `body_format`) VALUES
('node', 'page', 0, 17, 17, 'und', 0, '<h2>Columns</h2>\r\n\r\n<div class="row">\r\n<div class="col-md-6">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class="col-md-6"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-6"&gt;\r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-6"&gt; \r\n&lt;h4&gt;One Half&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n<div class="row">\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div>\r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui..&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n\r\n<div class="col-md-8"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-8"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-8"> \r\n<h4>Two Thirds</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class="col-md-4"> \r\n<h4>One Third</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-8"&gt; \r\n&lt;h4&gt;Two Thirds&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-4"&gt; \r\n&lt;h4&gt;One Third/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n\r\n<div class="col-md-9"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;div class="col-md-9"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>\r\n\r\n<div class="row">\r\n<div class="col-md-9"> \r\n<h4>Three Fourths</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sint, doloribus, tempora, numquam repellendus maiores facere a atque reiciendis voluptatibus hic veritatis ratione reprehenderit.</p>\r\n</div> \r\n\r\n<div class="col-md-3"> \r\n<h4>One Fourth</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut.</p>\r\n</div> \r\n</div>\r\n\r\n<pre style="margin-bottom:40px;">\r\n&lt;div class="row"&gt;\r\n\r\n&lt;div class="col-md-9"&gt; \r\n&lt;h4&gt;Three Fourths&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt;\r\n\r\n&lt;div class="col-md-3"&gt; \r\n&lt;h4&gt;One Fourth&lt;/h4&gt;\r\n&lt;p&gt;Donec sed odio dui...&lt;/p&gt;\r\n&lt;/div&gt; \r\n\r\n&lt;/div&gt;\r\n</pre>\r\n<br/>', '<div class="row">\r\n<div class="col-md-6">\r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n\r\n<div class="col-md-6"> \r\n<h4>One Half</h4>\r\n<p>Donec sed odio dui. Nulla vitae elit libero, a pharetra augue. Nullam id dolor id nibh ultricies vehicula ut id elit. Integer posuere erat a ante venenatis dapibus posuere velit aliquet.</p>\r\n</div> \r\n</div>', 'full_html');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_comment_body`
--

DROP TABLE IF EXISTS `field_revision_comment_body`;
CREATE TABLE `field_revision_comment_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `comment_body_value` longtext,
  `comment_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `comment_body_format` (`comment_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 1 (comment_body)';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_comment_body`
--

INSERT INTO `field_revision_comment_body` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `comment_body_value`, `comment_body_format`) VALUES
('comment', 'comment_node_mt_post', 0, 1, 1, 'und', 0, 'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'filtered_html'),
('comment', 'comment_node_mt_post', 0, 2, 2, 'und', 0, 'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'filtered_html'),
('comment', 'comment_node_mt_post', 0, 3, 3, 'und', 0, 'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'filtered_html'),
('comment', 'comment_node_mt_post', 0, 4, 4, 'und', 0, 'Duis egestas convallis elit sit amet tempus. Morbi arcu arcu, commodo sit amet vehicula nec, aliquam ac tellus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.', 'filtered_html');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_image`
--

DROP TABLE IF EXISTS `field_revision_field_image`;
CREATE TABLE `field_revision_field_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_image_fid` (`field_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 4 (field_image)';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_image`
--

INSERT INTO `field_revision_field_image` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_image_fid`, `field_image_alt`, `field_image_title`, `field_image_width`, `field_image_height`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 1, '', 'And this is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 1, 1, 'und', 1, 16, '', 'Title of Image', 750, 499),
('node', 'mt_post', 0, 1, 1, 'und', 2, 17, '', 'Title of Image', 750, 499),
('node', 'mt_post', 0, 1, 1, 'und', 3, 18, '', 'Title of Image', 750, 499),
('node', 'mt_post', 0, 1, 1, 'und', 4, 19, '', 'Title of Image', 750, 499),
('node', 'mt_post', 0, 1, 1, 'und', 5, 20, '', 'Title of Image', 750, 499),
('node', 'mt_post', 0, 2, 2, 'und', 0, 45, '', 'Caption competently expedite standards compliant users and leadership.', 750, 499),
('node', 'mt_post', 0, 3, 3, 'und', 0, 3, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 4, 4, 'und', 0, 4, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 5, 5, 'und', 0, 5, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 6, 6, 'und', 0, 6, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 7, 7, 'und', 0, 7, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 8, 8, 'und', 0, 8, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 9, 9, 'und', 0, 9, '', 'This is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499),
('node', 'mt_post', 0, 10, 10, 'und', 0, 10, '', 'Caption. Competently expedite standards compliant users and leadership. ', 750, 499),
('node', 'mt_post', 0, 11, 11, 'und', 0, 44, '', 'Caption. Competently expedite standards compliant users and leadership.', 750, 499),
('node', 'mt_post', 0, 12, 12, 'und', 0, 12, '', 'And this is the caption of the image which clarifies that quickly extend top-line opportunities for leveraged bandwidth.', 750, 499);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_about`
--

DROP TABLE IF EXISTS `field_revision_field_mt_about`;
CREATE TABLE `field_revision_field_mt_about` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_about_value` longtext,
  `field_mt_about_summary` longtext,
  `field_mt_about_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_about_format` (`field_mt_about_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 7 (field_mt_about)';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_mt_about`
--

INSERT INTO `field_revision_field_mt_about` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_about_value`, `field_mt_about_summary`, `field_mt_about_format`) VALUES
('user', 'user', 0, 1, 1, 'und', 0, 'Quickly extend top-line opportunities for leveraged bandwidth. Conveniently maximize low-risk high-yield ROI rather than cooperative synergy. Appropriately synthesize cooperative portals without backward-compatible total linkage. Seamlessly plagiarize value-added deliverables with customer directed technologies. ', '', 'filtered_html');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_banner_image`
--

DROP TABLE IF EXISTS `field_revision_field_mt_banner_image`;
CREATE TABLE `field_revision_field_mt_banner_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_banner_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_mt_banner_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_mt_banner_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_mt_banner_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_mt_banner_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_banner_image_fid` (`field_mt_banner_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 23 (field_mt_banner...';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_mt_banner_image`
--

INSERT INTO `field_revision_field_mt_banner_image` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_banner_image_fid`, `field_mt_banner_image_alt`, `field_mt_banner_image_title`, `field_mt_banner_image_width`, `field_mt_banner_image_height`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 37, 'Synergistically streamline prospective content whereas turnkey web services. Efficiently formulate enabled processes with granular processes.', 'Slide 1 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 1, 38, 'Efficiently formulate enabled processes with granular processes.', 'Slide 2 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 2, 39, 'Synergistically streamline prospective content whereas turnkey web services.', 'Slide 3 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 3, 40, 'Efficiently formulate enabled processes with granular processes. Synergistically streamline prospective content whereas turnkey web services.', 'Slide 4 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 4, 41, 'Collaboratively engage value-added potentialities rather than quality innovation.', 'Slide 5 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 5, 42, 'Collaboratively repurpose resource-leveling scenarios via integrated functionalities', 'Slide 6 title', 1170, 610),
('node', 'mt_post', 0, 1, 1, 'und', 6, 43, '', 'Slide 7 title', 1170, 610);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_breaking`
--

DROP TABLE IF EXISTS `field_revision_field_mt_breaking`;
CREATE TABLE `field_revision_field_mt_breaking` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_breaking_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_breaking_value` (`field_mt_breaking_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 13 (field_mt_breaking)';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_mt_breaking`
--

INSERT INTO `field_revision_field_mt_breaking` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_breaking_value`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 1),
('node', 'mt_post', 0, 2, 2, 'und', 0, 1),
('node', 'mt_post', 0, 3, 3, 'und', 0, 1),
('node', 'mt_post', 0, 4, 4, 'und', 0, 0),
('node', 'mt_post', 0, 5, 5, 'und', 0, 0),
('node', 'mt_post', 0, 6, 6, 'und', 0, 0),
('node', 'mt_post', 0, 7, 7, 'und', 0, 0),
('node', 'mt_post', 0, 8, 8, 'und', 0, 0),
('node', 'mt_post', 0, 9, 9, 'und', 0, 0),
('node', 'mt_post', 0, 10, 10, 'und', 0, 0),
('node', 'mt_post', 0, 11, 11, 'und', 0, 0),
('node', 'mt_post', 0, 12, 12, 'und', 0, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_facebook`
--

DROP TABLE IF EXISTS `field_revision_field_mt_facebook`;
CREATE TABLE `field_revision_field_mt_facebook` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_facebook_value` varchar(255) DEFAULT NULL,
  `field_mt_facebook_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_facebook_format` (`field_mt_facebook_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 17 (field_mt_facebook)';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_mt_facebook`
--

INSERT INTO `field_revision_field_mt_facebook` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_facebook_value`, `field_mt_facebook_format`) VALUES
('user', 'user', 0, 1, 1, 'und', 0, 'https://www.facebook.com/morethan.just.themes', NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_google_plus`
--

DROP TABLE IF EXISTS `field_revision_field_mt_google_plus`;
CREATE TABLE `field_revision_field_mt_google_plus` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_google_plus_value` varchar(255) DEFAULT NULL,
  `field_mt_google_plus_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_google_plus_format` (`field_mt_google_plus_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 19 (field_mt_google_plus)';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_mt_google_plus`
--

INSERT INTO `field_revision_field_mt_google_plus` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_google_plus_value`, `field_mt_google_plus_format`) VALUES
('user', 'user', 0, 1, 1, 'und', 0, 'https://plus.google.com/+Morethanthemes/posts', NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_post_categories`
--

DROP TABLE IF EXISTS `field_revision_field_mt_post_categories`;
CREATE TABLE `field_revision_field_mt_post_categories` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_post_categories_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_post_categories_tid` (`field_mt_post_categories_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 5 (field_mt_post...';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_mt_post_categories`
--

INSERT INTO `field_revision_field_mt_post_categories` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_post_categories_tid`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 2),
('node', 'mt_post', 0, 2, 2, 'und', 0, 3),
('node', 'mt_post', 0, 3, 3, 'und', 0, 5),
('node', 'mt_post', 0, 4, 4, 'und', 0, 6),
('node', 'mt_post', 0, 5, 5, 'und', 0, 4),
('node', 'mt_post', 0, 6, 6, 'und', 0, 1),
('node', 'mt_post', 0, 7, 7, 'und', 0, 2),
('node', 'mt_post', 0, 8, 8, 'und', 0, 3),
('node', 'mt_post', 0, 9, 9, 'und', 0, 5),
('node', 'mt_post', 0, 10, 10, 'und', 0, 6),
('node', 'mt_post', 0, 11, 11, 'und', 0, 4),
('node', 'mt_post', 0, 12, 12, 'und', 0, 1);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_slideshow`
--

DROP TABLE IF EXISTS `field_revision_field_mt_slideshow`;
CREATE TABLE `field_revision_field_mt_slideshow` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_slideshow_value` int(11) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_slideshow_value` (`field_mt_slideshow_value`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 21 (field_mt_slideshow)';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_mt_slideshow`
--

INSERT INTO `field_revision_field_mt_slideshow` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_slideshow_value`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 1),
('node', 'mt_post', 0, 2, 2, 'und', 0, 1),
('node', 'mt_post', 0, 3, 3, 'und', 0, 0),
('node', 'mt_post', 0, 4, 4, 'und', 0, 0),
('node', 'mt_post', 0, 5, 5, 'und', 0, 0),
('node', 'mt_post', 0, 6, 6, 'und', 0, 0),
('node', 'mt_post', 0, 7, 7, 'und', 0, 0),
('node', 'mt_post', 0, 8, 8, 'und', 0, 0),
('node', 'mt_post', 0, 9, 9, 'und', 0, 0),
('node', 'mt_post', 0, 10, 10, 'und', 0, 0),
('node', 'mt_post', 0, 11, 11, 'und', 0, 0),
('node', 'mt_post', 0, 12, 12, 'und', 0, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_slideshow_path`
--

DROP TABLE IF EXISTS `field_revision_field_mt_slideshow_path`;
CREATE TABLE `field_revision_field_mt_slideshow_path` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_slideshow_path_value` varchar(255) DEFAULT NULL,
  `field_mt_slideshow_path_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_slideshow_path_format` (`field_mt_slideshow_path_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 22 (field_mt_slideshow...';

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_subheader_body`
--

DROP TABLE IF EXISTS `field_revision_field_mt_subheader_body`;
CREATE TABLE `field_revision_field_mt_subheader_body` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_subheader_body_value` longtext,
  `field_mt_subheader_body_summary` longtext,
  `field_mt_subheader_body_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_subheader_body_format` (`field_mt_subheader_body_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 6 (field_mt_subheader...';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_mt_subheader_body`
--

INSERT INTO `field_revision_field_mt_subheader_body` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_subheader_body_value`, `field_mt_subheader_body_summary`, `field_mt_subheader_body_format`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 2, 2, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 3, 3, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly <a href="#">extend top-line opportunities for leveraged</a> bandwidth.', '', 'filtered_html'),
('node', 'mt_post', 0, 4, 4, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 5, 5, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 6, 6, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 7, 7, 'und', 0, 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', '', 'filtered_html'),
('node', 'mt_post', 0, 8, 8, 'und', 0, 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', '', 'filtered_html'),
('node', 'mt_post', 0, 9, 9, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 10, 10, 'und', 0, 'Appropriately benchmark error-free quality vectors for principle-centered models. Energistically provide access to enabled markets without quality resources. Completely leverage existing interoperable technologies after resource sucking solutions.', '', 'filtered_html'),
('node', 'mt_post', 0, 11, 11, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can <a href="#">quickly extend top-line opportunities for leveraged bandwidth</a>. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html'),
('node', 'mt_post', 0, 12, 12, 'und', 0, 'This is the article excerpt, which clarifies in a short fashion how you can quickly extend top-line opportunities for leveraged bandwidth. Appropriately synthesize cooperative portals without backward-compatible total linkag and authoritative information through fully tested expertise.', '', 'filtered_html');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_teaser_image`
--

DROP TABLE IF EXISTS `field_revision_field_mt_teaser_image`;
CREATE TABLE `field_revision_field_mt_teaser_image` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_teaser_image_fid` int(10) unsigned DEFAULT NULL COMMENT 'The file_managed.fid being referenced in this field.',
  `field_mt_teaser_image_alt` varchar(512) DEFAULT NULL COMMENT 'Alternative image text, for the image’s ’alt’ attribute.',
  `field_mt_teaser_image_title` varchar(1024) DEFAULT NULL COMMENT 'Image title text, for the image’s ’title’ attribute.',
  `field_mt_teaser_image_width` int(10) unsigned DEFAULT NULL COMMENT 'The width of the image in pixels.',
  `field_mt_teaser_image_height` int(10) unsigned DEFAULT NULL COMMENT 'The height of the image in pixels.',
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_teaser_image_fid` (`field_mt_teaser_image_fid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 20 (field_mt_teaser...';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_mt_teaser_image`
--

INSERT INTO `field_revision_field_mt_teaser_image` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_teaser_image_fid`, `field_mt_teaser_image_alt`, `field_mt_teaser_image_title`, `field_mt_teaser_image_width`, `field_mt_teaser_image_height`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 35, '', '', 1170, 610),
('node', 'mt_post', 0, 2, 2, 'und', 0, 36, '', '', 1170, 610);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_mt_twitter`
--

DROP TABLE IF EXISTS `field_revision_field_mt_twitter`;
CREATE TABLE `field_revision_field_mt_twitter` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_mt_twitter_value` varchar(255) DEFAULT NULL,
  `field_mt_twitter_format` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_mt_twitter_format` (`field_mt_twitter_format`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 18 (field_mt_twitter)';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_mt_twitter`
--

INSERT INTO `field_revision_field_mt_twitter` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_mt_twitter_value`, `field_mt_twitter_format`) VALUES
('user', 'user', 0, 1, 1, 'und', 0, 'https://twitter.com/morethanthemes/', NULL);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `field_revision_field_tags`
--

DROP TABLE IF EXISTS `field_revision_field_tags`;
CREATE TABLE `field_revision_field_tags` (
  `entity_type` varchar(128) NOT NULL DEFAULT '' COMMENT 'The entity type this data is attached to',
  `bundle` varchar(128) NOT NULL DEFAULT '' COMMENT 'The field instance bundle to which this row belongs, used when deleting a field instance',
  `deleted` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this data item has been deleted',
  `entity_id` int(10) unsigned NOT NULL COMMENT 'The entity id this data is attached to',
  `revision_id` int(10) unsigned NOT NULL COMMENT 'The entity revision id this data is attached to',
  `language` varchar(32) NOT NULL DEFAULT '' COMMENT 'The language for this data item.',
  `delta` int(10) unsigned NOT NULL COMMENT 'The sequence number for this data item, used for multi-value fields',
  `field_tags_tid` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`entity_type`,`entity_id`,`revision_id`,`deleted`,`delta`,`language`),
  KEY `entity_type` (`entity_type`),
  KEY `bundle` (`bundle`),
  KEY `deleted` (`deleted`),
  KEY `entity_id` (`entity_id`),
  KEY `revision_id` (`revision_id`),
  KEY `language` (`language`),
  KEY `field_tags_tid` (`field_tags_tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Revision archive storage for field 3 (field_tags)';

--
-- Άδειασμα δεδομένων του πίνακα `field_revision_field_tags`
--

INSERT INTO `field_revision_field_tags` (`entity_type`, `bundle`, `deleted`, `entity_id`, `revision_id`, `language`, `delta`, `field_tags_tid`) VALUES
('node', 'mt_post', 0, 1, 1, 'und', 0, 7),
('node', 'mt_post', 0, 1, 1, 'und', 1, 8),
('node', 'mt_post', 0, 1, 1, 'und', 2, 9),
('node', 'mt_post', 0, 2, 2, 'und', 0, 7),
('node', 'mt_post', 0, 2, 2, 'und', 1, 8),
('node', 'mt_post', 0, 2, 2, 'und', 2, 9),
('node', 'mt_post', 0, 3, 3, 'und', 0, 7),
('node', 'mt_post', 0, 3, 3, 'und', 1, 9),
('node', 'mt_post', 0, 4, 4, 'und', 0, 7),
('node', 'mt_post', 0, 4, 4, 'und', 1, 10),
('node', 'mt_post', 0, 4, 4, 'und', 2, 11),
('node', 'mt_post', 0, 5, 5, 'und', 0, 8),
('node', 'mt_post', 0, 5, 5, 'und', 1, 9),
('node', 'mt_post', 0, 5, 5, 'und', 2, 10),
('node', 'mt_post', 0, 6, 6, 'und', 0, 7),
('node', 'mt_post', 0, 6, 6, 'und', 1, 8),
('node', 'mt_post', 0, 6, 6, 'und', 2, 11),
('node', 'mt_post', 0, 7, 7, 'und', 0, 7),
('node', 'mt_post', 0, 7, 7, 'und', 1, 8),
('node', 'mt_post', 0, 7, 7, 'und', 2, 9),
('node', 'mt_post', 0, 7, 7, 'und', 3, 10),
('node', 'mt_post', 0, 8, 8, 'und', 0, 10),
('node', 'mt_post', 0, 8, 8, 'und', 1, 11),
('node', 'mt_post', 0, 9, 9, 'und', 0, 8),
('node', 'mt_post', 0, 9, 9, 'und', 1, 9),
('node', 'mt_post', 0, 9, 9, 'und', 2, 10),
('node', 'mt_post', 0, 9, 9, 'und', 3, 11),
('node', 'mt_post', 0, 10, 10, 'und', 0, 7),
('node', 'mt_post', 0, 10, 10, 'und', 1, 10),
('node', 'mt_post', 0, 10, 10, 'und', 2, 11),
('node', 'mt_post', 0, 11, 11, 'und', 0, 8),
('node', 'mt_post', 0, 11, 11, 'und', 1, 9),
('node', 'mt_post', 0, 11, 11, 'und', 2, 11),
('node', 'mt_post', 0, 12, 12, 'und', 0, 7),
('node', 'mt_post', 0, 12, 12, 'und', 1, 8),
('node', 'mt_post', 0, 12, 12, 'und', 2, 9),
('node', 'mt_post', 0, 12, 12, 'und', 3, 10),
('node', 'mt_post', 0, 12, 12, 'und', 4, 11);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `file_managed`
--

DROP TABLE IF EXISTS `file_managed`;
CREATE TABLE `file_managed` (
  `fid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'File ID.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The users.uid of the user who is associated with the file.',
  `filename` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the file with no path components. This may differ from the basename of the URI if the file is renamed to avoid overwriting an existing file.',
  `uri` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL DEFAULT '' COMMENT 'The URI to access the file (either local or remote).',
  `filemime` varchar(255) NOT NULL DEFAULT '' COMMENT 'The file’s MIME type.',
  `filesize` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'The size of the file in bytes.',
  `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A field indicating the status of the file. Two status are defined in core: temporary (0) and permanent (1). Temporary files older than DRUPAL_MAXIMUM_TEMP_FILE_AGE will be removed during a cron run.',
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'UNIX timestamp for when the file was added.',
  PRIMARY KEY (`fid`),
  UNIQUE KEY `uri` (`uri`),
  KEY `uid` (`uid`),
  KEY `status` (`status`),
  KEY `timestamp` (`timestamp`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores information for uploaded files.' AUTO_INCREMENT=46 ;

--
-- Άδειασμα δεδομένων του πίνακα `file_managed`
--

INSERT INTO `file_managed` (`fid`, `uid`, `filename`, `uri`, `filemime`, `filesize`, `status`, `timestamp`) VALUES
(1, 1, 'post-1.jpg', 'public://post-1.jpg', 'image/jpeg', 9878, 1, 1400661966),
(3, 1, 'post-3.jpg', 'public://post-3.jpg', 'image/jpeg', 9878, 1, 1400662489),
(4, 1, 'post-4.jpg', 'public://post-4.jpg', 'image/jpeg', 9878, 1, 1400662688),
(5, 1, 'post-5.jpg', 'public://post-5.jpg', 'image/jpeg', 9878, 1, 1400662828),
(6, 1, 'post-6.jpg', 'public://post-6.jpg', 'image/jpeg', 9878, 1, 1400662950),
(7, 1, 'post-7.jpg', 'public://post-7.jpg', 'image/jpeg', 9878, 1, 1400663182),
(8, 1, 'post-8.jpg', 'public://post-8.jpg', 'image/jpeg', 9878, 1, 1400663373),
(9, 1, 'post-9.jpg', 'public://post-9.jpg', 'image/jpeg', 9878, 1, 1400663471),
(10, 1, 'post-10.jpg', 'public://post-10.jpg', 'image/jpeg', 9878, 1, 1400663582),
(12, 1, 'post-12.jpg', 'public://post-12.jpg', 'image/jpeg', 9878, 1, 1400663842),
(16, 1, 'post-1-1.jpg', 'public://post-1-1.jpg', 'image/jpeg', 9878, 1, 1401439326),
(17, 1, 'post-1-2.jpg', 'public://post-1-2.jpg', 'image/jpeg', 9878, 1, 1401439326),
(18, 1, 'post-1-3.jpg', 'public://post-1-3.jpg', 'image/jpeg', 9878, 1, 1401439326),
(19, 1, 'post-1-4.jpg', 'public://post-1-4.jpg', 'image/jpeg', 9878, 1, 1401439326),
(20, 1, 'post-1-5.jpg', 'public://post-1-5.jpg', 'image/jpeg', 9878, 1, 1401439326),
(35, 1, 'slide-1.png', 'public://slide-1.png', 'image/png', 7127, 1, 1403010554),
(36, 1, 'slide-2.png', 'public://slide-2.png', 'image/png', 7127, 1, 1403010662),
(37, 1, 'post-1-banner-1.png', 'public://post-1-banner-1.png', 'image/png', 7127, 1, 1403012190),
(38, 1, 'post-1-banner-2.png', 'public://post-1-banner-2.png', 'image/png', 7127, 1, 1403012190),
(39, 1, 'post-1-banner-3.png', 'public://post-1-banner-3.png', 'image/png', 7127, 1, 1403012190),
(40, 1, 'post-1-banner-4.png', 'public://post-1-banner-4.png', 'image/png', 7127, 1, 1403012190),
(41, 1, 'post-1-banner-5.png', 'public://post-1-banner-5.png', 'image/png', 7127, 1, 1403012190),
(42, 1, 'post-1-banner-6.png', 'public://post-1-banner-6.png', 'image/png', 7127, 1, 1403012190),
(43, 1, 'post-1-banner-7.png', 'public://post-1-banner-7.png', 'image/png', 7127, 1, 1403012190),
(44, 1, 'post-11.jpg', 'public://post-11.jpg', 'image/jpeg', 9878, 1, 1403797469),
(45, 1, 'post-2.jpg', 'public://post-2.jpg', 'image/jpeg', 9878, 1, 1404317990);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `file_usage`
--

DROP TABLE IF EXISTS `file_usage`;
CREATE TABLE `file_usage` (
  `fid` int(10) unsigned NOT NULL COMMENT 'File ID.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The name of the module that is using the file.',
  `type` varchar(64) NOT NULL DEFAULT '' COMMENT 'The name of the object type in which the file is used.',
  `id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The primary key of the object using the file.',
  `count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The number of times this file is used by this object.',
  PRIMARY KEY (`fid`,`type`,`id`,`module`),
  KEY `type_id` (`type`,`id`),
  KEY `fid_count` (`fid`,`count`),
  KEY `fid_module` (`fid`,`module`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Track where a file is used.';

--
-- Άδειασμα δεδομένων του πίνακα `file_usage`
--

INSERT INTO `file_usage` (`fid`, `module`, `type`, `id`, `count`) VALUES
(1, 'file', 'node', 1, 1),
(3, 'file', 'node', 3, 1),
(4, 'file', 'node', 4, 1),
(5, 'file', 'node', 5, 1),
(6, 'file', 'node', 6, 1),
(7, 'file', 'node', 7, 1),
(8, 'file', 'node', 8, 1),
(9, 'file', 'node', 9, 1),
(10, 'file', 'node', 10, 1),
(12, 'file', 'node', 12, 1),
(16, 'file', 'node', 1, 1),
(17, 'file', 'node', 1, 1),
(18, 'file', 'node', 1, 1),
(19, 'file', 'node', 1, 1),
(20, 'file', 'node', 1, 1),
(35, 'file', 'node', 1, 1),
(36, 'file', 'node', 2, 1),
(37, 'file', 'node', 1, 1),
(38, 'file', 'node', 1, 1),
(39, 'file', 'node', 1, 1),
(40, 'file', 'node', 1, 1),
(41, 'file', 'node', 1, 1),
(42, 'file', 'node', 1, 1),
(43, 'file', 'node', 1, 1),
(44, 'file', 'node', 11, 1),
(45, 'file', 'node', 2, 1);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `filter`
--

DROP TABLE IF EXISTS `filter`;
CREATE TABLE `filter` (
  `format` varchar(255) NOT NULL COMMENT 'Foreign key: The filter_format.format to which this filter is assigned.',
  `module` varchar(64) NOT NULL DEFAULT '' COMMENT 'The origin module of the filter.',
  `name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Name of the filter being referenced.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of filter within format.',
  `status` int(11) NOT NULL DEFAULT '0' COMMENT 'Filter enabled status. (1 = enabled, 0 = disabled)',
  `settings` longblob COMMENT 'A serialized array of name value pairs that store the filter settings for the specific format.',
  PRIMARY KEY (`format`,`name`),
  KEY `list` (`weight`,`module`,`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table that maps filters (HTML corrector) to text formats ...';

--
-- Άδειασμα δεδομένων του πίνακα `filter`
--

INSERT INTO `filter` (`format`, `module`, `name`, `weight`, `status`, `settings`) VALUES
('filtered_html', 'filter', 'filter_autop', 2, 1, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_html', 1, 1, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('filtered_html', 'filter', 'filter_htmlcorrector', 10, 1, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_html_escape', -10, 0, 0x613a303a7b7d),
('filtered_html', 'filter', 'filter_url', 0, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d),
('full_html', 'filter', 'filter_autop', 1, 1, 0x613a303a7b7d),
('full_html', 'filter', 'filter_html', -10, 0, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('full_html', 'filter', 'filter_htmlcorrector', 10, 1, 0x613a303a7b7d),
('full_html', 'filter', 'filter_html_escape', -10, 0, 0x613a303a7b7d),
('full_html', 'filter', 'filter_url', 0, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d),
('php_code', 'filter', 'filter_autop', 0, 0, 0x613a303a7b7d),
('php_code', 'filter', 'filter_html', -10, 0, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('php_code', 'filter', 'filter_htmlcorrector', 10, 0, 0x613a303a7b7d),
('php_code', 'filter', 'filter_html_escape', -10, 0, 0x613a303a7b7d),
('php_code', 'filter', 'filter_url', 0, 0, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d),
('php_code', 'php', 'php_code', 0, 1, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_autop', 2, 1, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_html', -10, 0, 0x613a333a7b733a31323a22616c6c6f7765645f68746d6c223b733a37343a223c613e203c656d3e203c7374726f6e673e203c636974653e203c626c6f636b71756f74653e203c636f64653e203c756c3e203c6f6c3e203c6c693e203c646c3e203c64743e203c64643e223b733a31363a2266696c7465725f68746d6c5f68656c70223b693a313b733a32303a2266696c7465725f68746d6c5f6e6f666f6c6c6f77223b693a303b7d),
('plain_text', 'filter', 'filter_htmlcorrector', 10, 0, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_html_escape', 0, 1, 0x613a303a7b7d),
('plain_text', 'filter', 'filter_url', 1, 1, 0x613a313a7b733a31373a2266696c7465725f75726c5f6c656e677468223b693a37323b7d);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `filter_format`
--

DROP TABLE IF EXISTS `filter_format`;
CREATE TABLE `filter_format` (
  `format` varchar(255) NOT NULL COMMENT 'Primary Key: Unique machine name of the format.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the text format (Filtered HTML).',
  `cache` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Flag to indicate whether format is cacheable. (1 = cacheable, 0 = not cacheable)',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '1' COMMENT 'The status of the text format. (1 = enabled, 0 = disabled)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Weight of text format to use when listing.',
  PRIMARY KEY (`format`),
  UNIQUE KEY `name` (`name`),
  KEY `status_weight` (`status`,`weight`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores text formats: custom groupings of filters, such as...';

--
-- Άδειασμα δεδομένων του πίνακα `filter_format`
--

INSERT INTO `filter_format` (`format`, `name`, `cache`, `status`, `weight`) VALUES
('filtered_html', 'Filtered HTML', 1, 1, 0),
('full_html', 'Full HTML', 1, 1, 1),
('php_code', 'PHP code', 0, 1, 11),
('plain_text', 'Plain text', 1, 1, 10);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `image_effects`
--

DROP TABLE IF EXISTS `image_effects`;
CREATE TABLE `image_effects` (
  `ieid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image effect.',
  `isid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The image_styles.isid for an image style.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of the effect in the style.',
  `name` varchar(255) NOT NULL COMMENT 'The unique name of the effect to be executed.',
  `data` longblob NOT NULL COMMENT 'The configuration data for the effect.',
  PRIMARY KEY (`ieid`),
  KEY `isid` (`isid`),
  KEY `weight` (`weight`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image effects.' AUTO_INCREMENT=7 ;

--
-- Άδειασμα δεδομένων του πίνακα `image_effects`
--

INSERT INTO `image_effects` (`ieid`, `isid`, `weight`, `name`, `data`) VALUES
(2, 1, 1, 'image_scale_and_crop', 0x613a323a7b733a353a227769647468223b733a333a22373530223b733a363a22686569676874223b733a333a22343939223b7d),
(3, 2, 1, 'image_scale_and_crop', 0x613a323a7b733a353a227769647468223b733a343a2231313730223b733a363a22686569676874223b733a333a22363130223b7d),
(4, 3, 1, 'image_scale_and_crop', 0x613a323a7b733a353a227769647468223b733a333a22323330223b733a363a22686569676874223b733a333a22313533223b7d),
(6, 4, 1, 'image_scale_and_crop', 0x613a323a7b733a353a227769647468223b733a333a22343830223b733a363a22686569676874223b733a333a22333139223b7d);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `image_styles`
--

DROP TABLE IF EXISTS `image_styles`;
CREATE TABLE `image_styles` (
  `isid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for an image style.',
  `name` varchar(255) NOT NULL COMMENT 'The style machine name.',
  `label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The style administrative name.',
  PRIMARY KEY (`isid`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores configuration options for image styles.' AUTO_INCREMENT=5 ;

--
-- Άδειασμα δεδομένων του πίνακα `image_styles`
--

INSERT INTO `image_styles` (`isid`, `name`, `label`) VALUES
(1, 'large', 'Large (750x499)'),
(2, 'mt_slideshow', 'Slideshow (1170x610)'),
(3, 'mt_thumbnails', 'Thumbnails (230x153)'),
(4, 'medium', 'Medium (480x319)');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `menu_custom`
--

DROP TABLE IF EXISTS `menu_custom`;
CREATE TABLE `menu_custom` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique key for menu. This is used as a block delta so length is 32.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'Menu title; displayed at top of block.',
  `description` text COMMENT 'Menu description.',
  PRIMARY KEY (`menu_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds definitions for top-level custom menus (for example...';

--
-- Άδειασμα δεδομένων του πίνακα `menu_custom`
--

INSERT INTO `menu_custom` (`menu_name`, `title`, `description`) VALUES
('main-menu', 'Main menu', 'The <em>Main</em> menu is used on many sites to show the major sections of the site, often in a top navigation bar.'),
('management', 'Management', 'The <em>Management</em> menu contains links for administrative tasks.'),
('menu-secondary-menu', 'Secondary menu', 'Secondary menu'),
('menu-sidebar-menu', 'Sidebar Menu', 'Sidebar Menu'),
('menu-subfooter-menu', 'Subfooter menu', 'Subfooter menu'),
('navigation', 'Navigation', 'The <em>Navigation</em> menu contains links intended for site visitors. Links are added to the <em>Navigation</em> menu automatically by some modules.'),
('user-menu', 'User menu', 'The <em>User</em> menu contains links related to the user''s account, as well as the ''Log out'' link.');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `menu_links`
--

DROP TABLE IF EXISTS `menu_links`;
CREATE TABLE `menu_links` (
  `menu_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'The menu name. All links with the same menu name (such as ’navigation’) are part of the same menu.',
  `mlid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The menu link ID (mlid) is the integer primary key.',
  `plid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The parent link ID (plid) is the mlid of the link above in the hierarchy, or zero if the link is at the top level in its menu.',
  `link_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path or external path this link points to.',
  `router_path` varchar(255) NOT NULL DEFAULT '' COMMENT 'For links corresponding to a Drupal path (external = 0), this connects the link to a menu_router.path for joins.',
  `link_title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The text displayed for the link, which may be modified by a title callback stored in menu_router.',
  `options` blob COMMENT 'A serialized array of options to be passed to the url() or l() function, such as a query string or HTML attributes.',
  `module` varchar(255) NOT NULL DEFAULT 'system' COMMENT 'The name of the module that generated this link.',
  `hidden` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag for whether the link should be rendered in menus. (1 = a disabled menu item that may be shown on admin screens, -1 = a menu callback, 0 = a normal, visible link)',
  `external` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate if the link points to a full URL starting with a protocol, like http:// (1 = external, 0 = internal).',
  `has_children` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag indicating whether any links have this link as a parent (1 = children exist, 0 = no children).',
  `expanded` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag for whether this link should be rendered as expanded in menus - expanded links always have their child links displayed, instead of only when the link is in the active trail (1 = expanded, 0 = not expanded)',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'Link weight among links in the same menu at the same depth.',
  `depth` smallint(6) NOT NULL DEFAULT '0' COMMENT 'The depth relative to the top level. A link with plid == 0 will have depth == 1.',
  `customized` smallint(6) NOT NULL DEFAULT '0' COMMENT 'A flag to indicate that the user has manually created or edited the link (1 = customized, 0 = not customized).',
  `p1` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The first mlid in the materialized path. If N = depth, then pN must equal the mlid. If depth > 1 then p(N-1) must equal the plid. All pX where X > depth must equal zero. The columns p1 .. p9 are also called the parents.',
  `p2` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The second mlid in the materialized path. See p1.',
  `p3` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The third mlid in the materialized path. See p1.',
  `p4` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fourth mlid in the materialized path. See p1.',
  `p5` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The fifth mlid in the materialized path. See p1.',
  `p6` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The sixth mlid in the materialized path. See p1.',
  `p7` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The seventh mlid in the materialized path. See p1.',
  `p8` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The eighth mlid in the materialized path. See p1.',
  `p9` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The ninth mlid in the materialized path. See p1.',
  `updated` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Flag that indicates that this link was generated during the update from Drupal 5.',
  PRIMARY KEY (`mlid`),
  KEY `path_menu` (`link_path`(128),`menu_name`),
  KEY `menu_plid_expand_child` (`menu_name`,`plid`,`expanded`,`has_children`),
  KEY `menu_parents` (`menu_name`,`p1`,`p2`,`p3`,`p4`,`p5`,`p6`,`p7`,`p8`,`p9`),
  KEY `router_path` (`router_path`(128))
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Contains the individual links within a menu.' AUTO_INCREMENT=522 ;

--
-- Άδειασμα δεδομένων του πίνακα `menu_links`
--

INSERT INTO `menu_links` (`menu_name`, `mlid`, `plid`, `link_path`, `router_path`, `link_title`, `options`, `module`, `hidden`, `external`, `has_children`, `expanded`, `weight`, `depth`, `customized`, `p1`, `p2`, `p3`, `p4`, `p5`, `p6`, `p7`, `p8`, `p9`, `updated`) VALUES
('management', 1, 0, 'admin', 'admin', 'Administration', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 9, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 2, 0, 'user', 'user', 'User account', 0x613a313a7b733a353a22616c746572223b623a313b7d, 'system', 0, 0, 0, 0, -10, 1, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 3, 0, 'comment/%', 'comment/%', 'Comment permalink', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 4, 0, 'filter/tips', 'filter/tips', 'Compose tips', 0x613a303a7b7d, 'system', 1, 0, 0, 0, 0, 1, 0, 4, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 5, 0, 'node/%', 'node/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 5, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 6, 0, 'node/add', 'node/add', 'Add content', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 6, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 7, 1, 'admin/appearance', 'admin/appearance', 'Appearance', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33333a2253656c65637420616e6420636f6e66696775726520796f7572207468656d65732e223b7d7d, 'system', 0, 0, 0, 0, -6, 2, 0, 1, 7, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 8, 1, 'admin/config', 'admin/config', 'Configuration', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32303a2241646d696e69737465722073657474696e67732e223b7d7d, 'system', 0, 0, 1, 0, 0, 2, 0, 1, 8, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 9, 1, 'admin/content', 'admin/content', 'Content', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33323a2241646d696e697374657220636f6e74656e7420616e6420636f6d6d656e74732e223b7d7d, 'system', 0, 0, 1, 0, -10, 2, 0, 1, 9, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 10, 2, 'user/register', 'user/register', 'Create new account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 10, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 11, 1, 'admin/dashboard', 'admin/dashboard', 'Dashboard', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33343a225669657720616e6420637573746f6d697a6520796f75722064617368626f6172642e223b7d7d, 'system', 0, 0, 0, 0, -15, 2, 0, 1, 11, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 12, 1, 'admin/help', 'admin/help', 'Help', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34383a225265666572656e636520666f722075736167652c20636f6e66696775726174696f6e2c20616e64206d6f64756c65732e223b7d7d, 'system', 0, 0, 0, 0, 9, 2, 0, 1, 12, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 13, 1, 'admin/index', 'admin/index', 'Index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -18, 2, 0, 1, 13, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 14, 2, 'user/login', 'user/login', 'Log in', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 14, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 15, 0, 'user/logout', 'user/logout', 'Log out', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 10, 1, 0, 15, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 16, 1, 'admin/modules', 'admin/modules', 'Modules', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32363a22457874656e6420736974652066756e6374696f6e616c6974792e223b7d7d, 'system', 0, 0, 0, 0, -2, 2, 0, 1, 16, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 17, 0, 'user/%', 'user/%', 'My account', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 1, 0, 17, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 18, 1, 'admin/people', 'admin/people', 'People', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a224d616e6167652075736572206163636f756e74732c20726f6c65732c20616e64207065726d697373696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -4, 2, 0, 1, 18, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 19, 1, 'admin/reports', 'admin/reports', 'Reports', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33343a2256696577207265706f7274732c20757064617465732c20616e64206572726f72732e223b7d7d, 'system', 0, 0, 1, 0, 5, 2, 0, 1, 19, 0, 0, 0, 0, 0, 0, 0, 0),
('user-menu', 20, 2, 'user/password', 'user/password', 'Request new password', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 2, 20, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 21, 1, 'admin/structure', 'admin/structure', 'Structure', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a2241646d696e697374657220626c6f636b732c20636f6e74656e742074797065732c206d656e75732c206574632e223b7d7d, 'system', 0, 0, 1, 0, -8, 2, 0, 1, 21, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 22, 1, 'admin/tasks', 'admin/tasks', 'Tasks', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -20, 2, 0, 1, 22, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 23, 0, 'comment/reply/%', 'comment/reply/%', 'Add new comment', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 23, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 24, 3, 'comment/%/approve', 'comment/%/approve', 'Approve', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 1, 2, 0, 3, 24, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 25, 3, 'comment/%/delete', 'comment/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 2, 0, 3, 25, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 26, 3, 'comment/%/edit', 'comment/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 3, 26, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 27, 0, 'taxonomy/term/%', 'taxonomy/term/%', 'Taxonomy term', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 1, 0, 27, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 28, 3, 'comment/%/view', 'comment/%/view', 'View comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 3, 28, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 29, 18, 'admin/people/create', 'admin/people/create', 'Add user', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 18, 29, 0, 0, 0, 0, 0, 0, 0),
('management', 30, 21, 'admin/structure/block', 'admin/structure/block', 'Blocks', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37393a22436f6e666967757265207768617420626c6f636b20636f6e74656e74206170706561727320696e20796f75722073697465277320736964656261727320616e64206f7468657220726567696f6e732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 30, 0, 0, 0, 0, 0, 0, 0),
('navigation', 31, 17, 'user/%/cancel', 'user/%/cancel', 'Cancel account', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 2, 0, 17, 31, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 32, 9, 'admin/content/comment', 'admin/content/comment', 'Comments', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35393a224c69737420616e642065646974207369746520636f6d6d656e747320616e642074686520636f6d6d656e7420617070726f76616c2071756575652e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 9, 32, 0, 0, 0, 0, 0, 0, 0),
('management', 33, 11, 'admin/dashboard/configure', 'admin/dashboard/configure', 'Configure available dashboard blocks', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35333a22436f6e66696775726520776869636820626c6f636b732063616e2062652073686f776e206f6e207468652064617368626f6172642e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 11, 33, 0, 0, 0, 0, 0, 0, 0),
('management', 34, 9, 'admin/content/node', 'admin/content/node', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 3, 0, 1, 9, 34, 0, 0, 0, 0, 0, 0, 0),
('management', 35, 8, 'admin/config/content', 'admin/config/content', 'Content authoring', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35333a2253657474696e67732072656c6174656420746f20666f726d617474696e6720616e6420617574686f72696e6720636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, -15, 3, 0, 1, 8, 35, 0, 0, 0, 0, 0, 0, 0),
('management', 36, 21, 'admin/structure/types', 'admin/structure/types', 'Content types', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a39323a224d616e61676520636f6e74656e742074797065732c20696e636c7564696e672064656661756c74207374617475732c2066726f6e7420706167652070726f6d6f74696f6e2c20636f6d6d656e742073657474696e67732c206574632e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 36, 0, 0, 0, 0, 0, 0, 0),
('management', 37, 11, 'admin/dashboard/customize', 'admin/dashboard/customize', 'Customize dashboard', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32353a22437573746f6d697a6520796f75722064617368626f6172642e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 11, 37, 0, 0, 0, 0, 0, 0, 0),
('navigation', 38, 5, 'node/%/delete', 'node/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 2, 0, 5, 38, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 39, 8, 'admin/config/development', 'admin/config/development', 'Development', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31383a22446576656c6f706d656e7420746f6f6c732e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 39, 0, 0, 0, 0, 0, 0, 0),
('navigation', 40, 17, 'user/%/edit', 'user/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 17, 40, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 41, 5, 'node/%/edit', 'node/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 5, 41, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 42, 19, 'admin/reports/fields', 'admin/reports/fields', 'Field list', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a224f76657276696577206f66206669656c6473206f6e20616c6c20656e746974792074797065732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 42, 0, 0, 0, 0, 0, 0, 0),
('management', 43, 7, 'admin/appearance/list', 'admin/appearance/list', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33313a2253656c65637420616e6420636f6e66696775726520796f7572207468656d65223b7d7d, 'system', -1, 0, 0, 0, -1, 3, 0, 1, 7, 43, 0, 0, 0, 0, 0, 0, 0),
('management', 44, 16, 'admin/modules/list', 'admin/modules/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 16, 44, 0, 0, 0, 0, 0, 0, 0),
('management', 45, 18, 'admin/people/people', 'admin/people/people', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35303a2246696e6420616e64206d616e6167652070656f706c6520696e746572616374696e67207769746820796f757220736974652e223b7d7d, 'system', -1, 0, 0, 0, -10, 3, 0, 1, 18, 45, 0, 0, 0, 0, 0, 0, 0),
('management', 46, 8, 'admin/config/media', 'admin/config/media', 'Media', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31323a224d6564696120746f6f6c732e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 46, 0, 0, 0, 0, 0, 0, 0),
('management', 47, 21, 'admin/structure/menu', 'admin/structure/menu', 'Menus', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38363a22416464206e6577206d656e757320746f20796f757220736974652c2065646974206578697374696e67206d656e75732c20616e642072656e616d6520616e642072656f7267616e697a65206d656e75206c696e6b732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 47, 0, 0, 0, 0, 0, 0, 0),
('management', 48, 8, 'admin/config/people', 'admin/config/people', 'People', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32343a22436f6e6669677572652075736572206163636f756e74732e223b7d7d, 'system', 0, 0, 1, 0, -20, 3, 0, 1, 8, 48, 0, 0, 0, 0, 0, 0, 0),
('management', 49, 18, 'admin/people/permissions', 'admin/people/permissions', 'Permissions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36343a2244657465726d696e652061636365737320746f2066656174757265732062792073656c656374696e67207065726d697373696f6e7320666f7220726f6c65732e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 18, 49, 0, 0, 0, 0, 0, 0, 0),
('management', 50, 19, 'admin/reports/dblog', 'admin/reports/dblog', 'Recent log messages', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a2256696577206576656e74732074686174206861766520726563656e746c79206265656e206c6f676765642e223b7d7d, 'system', 0, 0, 0, 0, -1, 3, 0, 1, 19, 50, 0, 0, 0, 0, 0, 0, 0),
('management', 51, 8, 'admin/config/regional', 'admin/config/regional', 'Regional and language', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34383a22526567696f6e616c2073657474696e67732c206c6f63616c697a6174696f6e20616e64207472616e736c6174696f6e2e223b7d7d, 'system', 0, 0, 1, 0, -5, 3, 0, 1, 8, 51, 0, 0, 0, 0, 0, 0, 0),
('navigation', 52, 5, 'node/%/revisions', 'node/%/revisions', 'Revisions', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 2, 2, 0, 5, 52, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 53, 8, 'admin/config/search', 'admin/config/search', 'Search and metadata', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33363a224c6f63616c2073697465207365617263682c206d6574616461746120616e642053454f2e223b7d7d, 'system', 0, 0, 1, 0, -10, 3, 0, 1, 8, 53, 0, 0, 0, 0, 0, 0, 0),
('management', 54, 7, 'admin/appearance/settings', 'admin/appearance/settings', 'Settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a22436f6e6669677572652064656661756c7420616e64207468656d652073706563696669632073657474696e67732e223b7d7d, 'system', -1, 0, 0, 0, 20, 3, 0, 1, 7, 54, 0, 0, 0, 0, 0, 0, 0),
('management', 55, 19, 'admin/reports/status', 'admin/reports/status', 'Status report', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37343a22476574206120737461747573207265706f72742061626f757420796f757220736974652773206f7065726174696f6e20616e6420616e792064657465637465642070726f626c656d732e223b7d7d, 'system', 0, 0, 0, 0, -60, 3, 0, 1, 19, 55, 0, 0, 0, 0, 0, 0, 0),
('management', 56, 8, 'admin/config/system', 'admin/config/system', 'System', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33373a2247656e6572616c2073797374656d2072656c6174656420636f6e66696775726174696f6e2e223b7d7d, 'system', 0, 0, 1, 0, -20, 3, 0, 1, 8, 56, 0, 0, 0, 0, 0, 0, 0),
('management', 57, 21, 'admin/structure/taxonomy', 'admin/structure/taxonomy', 'Taxonomy', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36373a224d616e6167652074616767696e672c2063617465676f72697a6174696f6e2c20616e6420636c617373696669636174696f6e206f6620796f757220636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 57, 0, 0, 0, 0, 0, 0, 0),
('management', 58, 19, 'admin/reports/access-denied', 'admin/reports/access-denied', 'Top ''access denied'' errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33353a225669657720276163636573732064656e69656427206572726f7273202834303373292e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 58, 0, 0, 0, 0, 0, 0, 0),
('management', 59, 19, 'admin/reports/page-not-found', 'admin/reports/page-not-found', 'Top ''page not found'' errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33363a2256696577202770616765206e6f7420666f756e6427206572726f7273202834303473292e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 59, 0, 0, 0, 0, 0, 0, 0),
('management', 60, 16, 'admin/modules/uninstall', 'admin/modules/uninstall', 'Uninstall', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 20, 3, 0, 1, 16, 60, 0, 0, 0, 0, 0, 0, 0),
('management', 61, 8, 'admin/config/user-interface', 'admin/config/user-interface', 'User interface', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33383a22546f6f6c73207468617420656e68616e636520746865207573657220696e746572666163652e223b7d7d, 'system', 0, 0, 1, 0, -15, 3, 0, 1, 8, 61, 0, 0, 0, 0, 0, 0, 0),
('navigation', 62, 5, 'node/%/view', 'node/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 5, 62, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 63, 17, 'user/%/view', 'user/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 17, 63, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 64, 8, 'admin/config/services', 'admin/config/services', 'Web services', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33303a22546f6f6c732072656c6174656420746f207765622073657276696365732e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 8, 64, 0, 0, 0, 0, 0, 0, 0),
('management', 65, 8, 'admin/config/workflow', 'admin/config/workflow', 'Workflow', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22436f6e74656e7420776f726b666c6f772c20656469746f7269616c20776f726b666c6f7720746f6f6c732e223b7d7d, 'system', 0, 0, 0, 0, 5, 3, 0, 1, 8, 65, 0, 0, 0, 0, 0, 0, 0),
('management', 66, 12, 'admin/help/block', 'admin/help/block', 'block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 66, 0, 0, 0, 0, 0, 0, 0),
('management', 67, 12, 'admin/help/color', 'admin/help/color', 'color', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 67, 0, 0, 0, 0, 0, 0, 0),
('management', 68, 12, 'admin/help/comment', 'admin/help/comment', 'comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 68, 0, 0, 0, 0, 0, 0, 0),
('management', 69, 12, 'admin/help/contextual', 'admin/help/contextual', 'contextual', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 69, 0, 0, 0, 0, 0, 0, 0),
('management', 70, 12, 'admin/help/dashboard', 'admin/help/dashboard', 'dashboard', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 70, 0, 0, 0, 0, 0, 0, 0),
('management', 71, 12, 'admin/help/dblog', 'admin/help/dblog', 'dblog', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 71, 0, 0, 0, 0, 0, 0, 0),
('management', 72, 12, 'admin/help/field', 'admin/help/field', 'field', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 72, 0, 0, 0, 0, 0, 0, 0),
('management', 73, 12, 'admin/help/field_sql_storage', 'admin/help/field_sql_storage', 'field_sql_storage', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 73, 0, 0, 0, 0, 0, 0, 0),
('management', 74, 12, 'admin/help/field_ui', 'admin/help/field_ui', 'field_ui', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 74, 0, 0, 0, 0, 0, 0, 0),
('management', 75, 12, 'admin/help/file', 'admin/help/file', 'file', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 75, 0, 0, 0, 0, 0, 0, 0),
('management', 76, 12, 'admin/help/filter', 'admin/help/filter', 'filter', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 76, 0, 0, 0, 0, 0, 0, 0),
('management', 77, 12, 'admin/help/help', 'admin/help/help', 'help', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 77, 0, 0, 0, 0, 0, 0, 0),
('management', 78, 12, 'admin/help/image', 'admin/help/image', 'image', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 78, 0, 0, 0, 0, 0, 0, 0),
('management', 79, 12, 'admin/help/list', 'admin/help/list', 'list', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 79, 0, 0, 0, 0, 0, 0, 0),
('management', 80, 12, 'admin/help/menu', 'admin/help/menu', 'menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 80, 0, 0, 0, 0, 0, 0, 0),
('management', 81, 12, 'admin/help/node', 'admin/help/node', 'node', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 81, 0, 0, 0, 0, 0, 0, 0),
('management', 82, 12, 'admin/help/options', 'admin/help/options', 'options', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 82, 0, 0, 0, 0, 0, 0, 0),
('management', 83, 12, 'admin/help/system', 'admin/help/system', 'system', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 83, 0, 0, 0, 0, 0, 0, 0),
('management', 84, 12, 'admin/help/taxonomy', 'admin/help/taxonomy', 'taxonomy', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 84, 0, 0, 0, 0, 0, 0, 0),
('management', 85, 12, 'admin/help/text', 'admin/help/text', 'text', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 85, 0, 0, 0, 0, 0, 0, 0),
('management', 86, 12, 'admin/help/user', 'admin/help/user', 'user', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 86, 0, 0, 0, 0, 0, 0, 0),
('navigation', 87, 27, 'taxonomy/term/%/edit', 'taxonomy/term/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 2, 0, 27, 87, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 88, 27, 'taxonomy/term/%/view', 'taxonomy/term/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 27, 88, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 89, 57, 'admin/structure/taxonomy/%', 'admin/structure/taxonomy/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 57, 89, 0, 0, 0, 0, 0, 0),
('management', 90, 48, 'admin/config/people/accounts', 'admin/config/people/accounts', 'Account settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130393a22436f6e6669677572652064656661756c74206265686176696f72206f662075736572732c20696e636c7564696e6720726567697374726174696f6e20726571756972656d656e74732c20652d6d61696c732c206669656c64732c20616e6420757365722070696374757265732e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 48, 90, 0, 0, 0, 0, 0, 0),
('management', 91, 56, 'admin/config/system/actions', 'admin/config/system/actions', 'Actions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34313a224d616e6167652074686520616374696f6e7320646566696e656420666f7220796f757220736974652e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 56, 91, 0, 0, 0, 0, 0, 0),
('management', 92, 30, 'admin/structure/block/add', 'admin/structure/block/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 30, 92, 0, 0, 0, 0, 0, 0),
('management', 93, 36, 'admin/structure/types/add', 'admin/structure/types/add', 'Add content type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 36, 93, 0, 0, 0, 0, 0, 0),
('management', 94, 47, 'admin/structure/menu/add', 'admin/structure/menu/add', 'Add menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 47, 94, 0, 0, 0, 0, 0, 0),
('management', 95, 57, 'admin/structure/taxonomy/add', 'admin/structure/taxonomy/add', 'Add vocabulary', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 57, 95, 0, 0, 0, 0, 0, 0),
('management', 96, 54, 'admin/appearance/settings/bartik', 'admin/appearance/settings/bartik', 'Bartik', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 54, 96, 0, 0, 0, 0, 0, 0),
('management', 97, 53, 'admin/config/search/clean-urls', 'admin/config/search/clean-urls', 'Clean URLs', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22456e61626c65206f722064697361626c6520636c65616e2055524c7320666f7220796f757220736974652e223b7d7d, 'system', 0, 0, 0, 0, 5, 4, 0, 1, 8, 53, 97, 0, 0, 0, 0, 0, 0),
('management', 98, 56, 'admin/config/system/cron', 'admin/config/system/cron', 'Cron', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34303a224d616e616765206175746f6d617469632073697465206d61696e74656e616e6365207461736b732e223b7d7d, 'system', 0, 0, 0, 0, 20, 4, 0, 1, 8, 56, 98, 0, 0, 0, 0, 0, 0),
('management', 99, 51, 'admin/config/regional/date-time', 'admin/config/regional/date-time', 'Date and time', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34343a22436f6e66696775726520646973706c617920666f726d61747320666f72206461746520616e642074696d652e223b7d7d, 'system', 0, 0, 0, 0, -15, 4, 0, 1, 8, 51, 99, 0, 0, 0, 0, 0, 0),
('management', 100, 19, 'admin/reports/event/%', 'admin/reports/event/%', 'Details', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 100, 0, 0, 0, 0, 0, 0, 0),
('management', 101, 46, 'admin/config/media/file-system', 'admin/config/media/file-system', 'File system', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36383a2254656c6c2044727570616c20776865726520746f2073746f72652075706c6f616465642066696c657320616e6420686f772074686579206172652061636365737365642e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 46, 101, 0, 0, 0, 0, 0, 0),
('management', 102, 54, 'admin/appearance/settings/garland', 'admin/appearance/settings/garland', 'Garland', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 54, 102, 0, 0, 0, 0, 0, 0),
('management', 103, 54, 'admin/appearance/settings/global', 'admin/appearance/settings/global', 'Global settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -1, 4, 0, 1, 7, 54, 103, 0, 0, 0, 0, 0, 0),
('management', 104, 48, 'admin/config/people/ip-blocking', 'admin/config/people/ip-blocking', 'IP address blocking', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32383a224d616e61676520626c6f636b6564204950206164647265737365732e223b7d7d, 'system', 0, 0, 1, 0, 10, 4, 0, 1, 8, 48, 104, 0, 0, 0, 0, 0, 0),
('management', 105, 46, 'admin/config/media/image-styles', 'admin/config/media/image-styles', 'Image styles', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37383a22436f6e666967757265207374796c657320746861742063616e206265207573656420666f7220726573697a696e67206f722061646a757374696e6720696d61676573206f6e20646973706c61792e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 46, 105, 0, 0, 0, 0, 0, 0),
('management', 106, 46, 'admin/config/media/image-toolkit', 'admin/config/media/image-toolkit', 'Image toolkit', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37343a2243686f6f736520776869636820696d61676520746f6f6c6b697420746f2075736520696620796f75206861766520696e7374616c6c6564206f7074696f6e616c20746f6f6c6b6974732e223b7d7d, 'system', 0, 0, 0, 0, 20, 4, 0, 1, 8, 46, 106, 0, 0, 0, 0, 0, 0),
('management', 107, 44, 'admin/modules/list/confirm', 'admin/modules/list/confirm', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 16, 44, 107, 0, 0, 0, 0, 0, 0),
('management', 108, 36, 'admin/structure/types/list', 'admin/structure/types/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 36, 108, 0, 0, 0, 0, 0, 0),
('management', 109, 57, 'admin/structure/taxonomy/list', 'admin/structure/taxonomy/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 57, 109, 0, 0, 0, 0, 0, 0),
('management', 110, 47, 'admin/structure/menu/list', 'admin/structure/menu/list', 'List menus', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 47, 110, 0, 0, 0, 0, 0, 0),
('management', 111, 39, 'admin/config/development/logging', 'admin/config/development/logging', 'Logging and errors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3135343a2253657474696e677320666f72206c6f6767696e6720616e6420616c65727473206d6f64756c65732e20566172696f7573206d6f64756c65732063616e20726f7574652044727570616c27732073797374656d206576656e747320746f20646966666572656e742064657374696e6174696f6e732c2073756368206173207379736c6f672c2064617461626173652c20656d61696c2c206574632e223b7d7d, 'system', 0, 0, 0, 0, -15, 4, 0, 1, 8, 39, 111, 0, 0, 0, 0, 0, 0),
('management', 112, 39, 'admin/config/development/maintenance', 'admin/config/development/maintenance', 'Maintenance mode', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36323a2254616b65207468652073697465206f66666c696e6520666f72206d61696e74656e616e6365206f72206272696e67206974206261636b206f6e6c696e652e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 39, 112, 0, 0, 0, 0, 0, 0),
('management', 113, 39, 'admin/config/development/performance', 'admin/config/development/performance', 'Performance', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130313a22456e61626c65206f722064697361626c6520706167652063616368696e6720666f7220616e6f6e796d6f757320757365727320616e64207365742043535320616e64204a532062616e647769647468206f7074696d697a6174696f6e206f7074696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 39, 113, 0, 0, 0, 0, 0, 0),
('management', 114, 49, 'admin/people/permissions/list', 'admin/people/permissions/list', 'Permissions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36343a2244657465726d696e652061636365737320746f2066656174757265732062792073656c656374696e67207065726d697373696f6e7320666f7220726f6c65732e223b7d7d, 'system', -1, 0, 0, 0, -8, 4, 0, 1, 18, 49, 114, 0, 0, 0, 0, 0, 0),
('management', 115, 32, 'admin/content/comment/new', 'admin/content/comment/new', 'Published comments', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 9, 32, 115, 0, 0, 0, 0, 0, 0),
('management', 116, 64, 'admin/config/services/rss-publishing', 'admin/config/services/rss-publishing', 'RSS publishing', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3131343a22436f6e666967757265207468652073697465206465736372697074696f6e2c20746865206e756d626572206f66206974656d7320706572206665656420616e6420776865746865722066656564732073686f756c64206265207469746c65732f746561736572732f66756c6c2d746578742e223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 64, 116, 0, 0, 0, 0, 0, 0),
('management', 117, 51, 'admin/config/regional/settings', 'admin/config/regional/settings', 'Regional settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35343a2253657474696e677320666f7220746865207369746527732064656661756c742074696d65207a6f6e6520616e6420636f756e7472792e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 51, 117, 0, 0, 0, 0, 0, 0),
('management', 118, 49, 'admin/people/permissions/roles', 'admin/people/permissions/roles', 'Roles', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33303a224c6973742c20656469742c206f7220616464207573657220726f6c65732e223b7d7d, 'system', -1, 0, 1, 0, -5, 4, 0, 1, 18, 49, 118, 0, 0, 0, 0, 0, 0),
('management', 119, 47, 'admin/structure/menu/settings', 'admin/structure/menu/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 5, 4, 0, 1, 21, 47, 119, 0, 0, 0, 0, 0, 0),
('management', 120, 54, 'admin/appearance/settings/seven', 'admin/appearance/settings/seven', 'Seven', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 54, 120, 0, 0, 0, 0, 0, 0),
('management', 121, 56, 'admin/config/system/site-information', 'admin/config/system/site-information', 'Site information', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3130343a224368616e67652073697465206e616d652c20652d6d61696c20616464726573732c20736c6f67616e2c2064656661756c742066726f6e7420706167652c20616e64206e756d626572206f6620706f7374732070657220706167652c206572726f722070616765732e223b7d7d, 'system', 0, 0, 0, 0, -20, 4, 0, 1, 8, 56, 121, 0, 0, 0, 0, 0, 0),
('management', 122, 54, 'admin/appearance/settings/stark', 'admin/appearance/settings/stark', 'Stark', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 54, 122, 0, 0, 0, 0, 0, 0),
('management', 123, 35, 'admin/config/content/formats', 'admin/config/content/formats', 'Text formats', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3132373a22436f6e66696775726520686f7720636f6e74656e7420696e7075742062792075736572732069732066696c74657265642c20696e636c7564696e6720616c6c6f7765642048544d4c20746167732e20416c736f20616c6c6f777320656e61626c696e67206f66206d6f64756c652d70726f76696465642066696c746572732e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 35, 123, 0, 0, 0, 0, 0, 0),
('management', 124, 32, 'admin/content/comment/approval', 'admin/content/comment/approval', 'Unapproved comments', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 9, 32, 124, 0, 0, 0, 0, 0, 0),
('management', 125, 60, 'admin/modules/uninstall/confirm', 'admin/modules/uninstall/confirm', 'Uninstall', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 16, 60, 125, 0, 0, 0, 0, 0, 0),
('navigation', 126, 40, 'user/%/edit/account', 'user/%/edit/account', 'Account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 17, 40, 126, 0, 0, 0, 0, 0, 0, 0),
('management', 127, 123, 'admin/config/content/formats/%', 'admin/config/content/formats/%', '', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 35, 123, 127, 0, 0, 0, 0, 0),
('management', 128, 105, 'admin/config/media/image-styles/add', 'admin/config/media/image-styles/add', 'Add style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a224164642061206e657720696d616765207374796c652e223b7d7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 8, 46, 105, 128, 0, 0, 0, 0, 0),
('management', 129, 89, 'admin/structure/taxonomy/%/add', 'admin/structure/taxonomy/%/add', 'Add term', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 57, 89, 129, 0, 0, 0, 0, 0),
('management', 130, 123, 'admin/config/content/formats/add', 'admin/config/content/formats/add', 'Add text format', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 5, 0, 1, 8, 35, 123, 130, 0, 0, 0, 0, 0),
('management', 131, 30, 'admin/structure/block/list/bartik', 'admin/structure/block/list/bartik', 'Bartik', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 30, 131, 0, 0, 0, 0, 0, 0),
('management', 132, 91, 'admin/config/system/actions/configure', 'admin/config/system/actions/configure', 'Configure an advanced action', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 56, 91, 132, 0, 0, 0, 0, 0),
('management', 133, 47, 'admin/structure/menu/manage/%', 'admin/structure/menu/manage/%', 'Customize menu', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 21, 47, 133, 0, 0, 0, 0, 0, 0),
('management', 134, 89, 'admin/structure/taxonomy/%/edit', 'admin/structure/taxonomy/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 21, 57, 89, 134, 0, 0, 0, 0, 0),
('management', 135, 36, 'admin/structure/types/manage/%', 'admin/structure/types/manage/%', 'Edit content type', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 21, 36, 135, 0, 0, 0, 0, 0, 0),
('management', 136, 99, 'admin/config/regional/date-time/formats', 'admin/config/regional/date-time/formats', 'Formats', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35313a22436f6e66696775726520646973706c617920666f726d617420737472696e677320666f72206461746520616e642074696d652e223b7d7d, 'system', -1, 0, 1, 0, -9, 5, 0, 1, 8, 51, 99, 136, 0, 0, 0, 0, 0),
('management', 137, 30, 'admin/structure/block/list/garland', 'admin/structure/block/list/garland', 'Garland', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 30, 137, 0, 0, 0, 0, 0, 0),
('management', 138, 123, 'admin/config/content/formats/list', 'admin/config/content/formats/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 35, 123, 138, 0, 0, 0, 0, 0),
('management', 139, 89, 'admin/structure/taxonomy/%/list', 'admin/structure/taxonomy/%/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -20, 5, 0, 1, 21, 57, 89, 139, 0, 0, 0, 0, 0),
('management', 140, 105, 'admin/config/media/image-styles/list', 'admin/config/media/image-styles/list', 'List', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34323a224c697374207468652063757272656e7420696d616765207374796c6573206f6e2074686520736974652e223b7d7d, 'system', -1, 0, 0, 0, 1, 5, 0, 1, 8, 46, 105, 140, 0, 0, 0, 0, 0),
('management', 141, 91, 'admin/config/system/actions/manage', 'admin/config/system/actions/manage', 'Manage actions', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34313a224d616e6167652074686520616374696f6e7320646566696e656420666f7220796f757220736974652e223b7d7d, 'system', -1, 0, 0, 0, -2, 5, 0, 1, 8, 56, 91, 141, 0, 0, 0, 0, 0),
('management', 142, 90, 'admin/config/people/accounts/settings', 'admin/config/people/accounts/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 8, 48, 90, 142, 0, 0, 0, 0, 0),
('management', 143, 30, 'admin/structure/block/list/seven', 'admin/structure/block/list/seven', 'Seven', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 30, 143, 0, 0, 0, 0, 0, 0),
('management', 144, 30, 'admin/structure/block/list/stark', 'admin/structure/block/list/stark', 'Stark', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 30, 144, 0, 0, 0, 0, 0, 0),
('management', 145, 99, 'admin/config/regional/date-time/types', 'admin/config/regional/date-time/types', 'Types', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34343a22436f6e66696775726520646973706c617920666f726d61747320666f72206461746520616e642074696d652e223b7d7d, 'system', -1, 0, 1, 0, -10, 5, 0, 1, 8, 51, 99, 145, 0, 0, 0, 0, 0),
('navigation', 146, 52, 'node/%/revisions/%/delete', 'node/%/revisions/%/delete', 'Delete earlier revision', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 52, 146, 0, 0, 0, 0, 0, 0, 0),
('navigation', 147, 52, 'node/%/revisions/%/revert', 'node/%/revisions/%/revert', 'Revert to earlier revision', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 52, 147, 0, 0, 0, 0, 0, 0, 0),
('navigation', 148, 52, 'node/%/revisions/%/view', 'node/%/revisions/%/view', 'Revisions', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 5, 52, 148, 0, 0, 0, 0, 0, 0, 0),
('management', 149, 137, 'admin/structure/block/list/garland/add', 'admin/structure/block/list/garland/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 30, 137, 149, 0, 0, 0, 0, 0),
('management', 150, 143, 'admin/structure/block/list/seven/add', 'admin/structure/block/list/seven/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 30, 143, 150, 0, 0, 0, 0, 0),
('management', 151, 144, 'admin/structure/block/list/stark/add', 'admin/structure/block/list/stark/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 30, 144, 151, 0, 0, 0, 0, 0),
('management', 152, 145, 'admin/config/regional/date-time/types/add', 'admin/config/regional/date-time/types/add', 'Add date type', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31383a22416464206e6577206461746520747970652e223b7d7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 51, 99, 145, 152, 0, 0, 0, 0),
('management', 153, 136, 'admin/config/regional/date-time/formats/add', 'admin/config/regional/date-time/formats/add', 'Add format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22416c6c6f7720757365727320746f20616464206164646974696f6e616c206461746520666f726d6174732e223b7d7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 51, 99, 136, 153, 0, 0, 0, 0),
('management', 154, 133, 'admin/structure/menu/manage/%/add', 'admin/structure/menu/manage/%/add', 'Add link', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 47, 133, 154, 0, 0, 0, 0, 0),
('management', 155, 30, 'admin/structure/block/manage/%/%', 'admin/structure/block/manage/%/%', 'Configure block', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 30, 155, 0, 0, 0, 0, 0, 0),
('navigation', 156, 31, 'user/%/cancel/confirm/%/%', 'user/%/cancel/confirm/%/%', 'Confirm account cancellation', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 3, 0, 17, 31, 156, 0, 0, 0, 0, 0, 0, 0),
('management', 157, 135, 'admin/structure/types/manage/%/delete', 'admin/structure/types/manage/%/delete', 'Delete', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 21, 36, 135, 157, 0, 0, 0, 0, 0),
('management', 158, 104, 'admin/config/people/ip-blocking/delete/%', 'admin/config/people/ip-blocking/delete/%', 'Delete IP address', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 48, 104, 158, 0, 0, 0, 0, 0),
('management', 159, 91, 'admin/config/system/actions/delete/%', 'admin/config/system/actions/delete/%', 'Delete action', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31373a2244656c65746520616e20616374696f6e2e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 56, 91, 159, 0, 0, 0, 0, 0),
('management', 160, 133, 'admin/structure/menu/manage/%/delete', 'admin/structure/menu/manage/%/delete', 'Delete menu', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 21, 47, 133, 160, 0, 0, 0, 0, 0),
('management', 161, 47, 'admin/structure/menu/item/%/delete', 'admin/structure/menu/item/%/delete', 'Delete menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 47, 161, 0, 0, 0, 0, 0, 0),
('management', 162, 118, 'admin/people/permissions/roles/delete/%', 'admin/people/permissions/roles/delete/%', 'Delete role', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 18, 49, 118, 162, 0, 0, 0, 0, 0),
('management', 163, 127, 'admin/config/content/formats/%/disable', 'admin/config/content/formats/%/disable', 'Disable text format', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 35, 123, 127, 163, 0, 0, 0, 0),
('management', 164, 135, 'admin/structure/types/manage/%/edit', 'admin/structure/types/manage/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 36, 135, 164, 0, 0, 0, 0, 0),
('management', 165, 133, 'admin/structure/menu/manage/%/edit', 'admin/structure/menu/manage/%/edit', 'Edit menu', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 47, 133, 165, 0, 0, 0, 0, 0),
('management', 166, 47, 'admin/structure/menu/item/%/edit', 'admin/structure/menu/item/%/edit', 'Edit menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 47, 166, 0, 0, 0, 0, 0, 0),
('management', 167, 118, 'admin/people/permissions/roles/edit/%', 'admin/people/permissions/roles/edit/%', 'Edit role', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 18, 49, 118, 167, 0, 0, 0, 0, 0),
('management', 168, 105, 'admin/config/media/image-styles/edit/%', 'admin/config/media/image-styles/edit/%', 'Edit style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32353a22436f6e66696775726520616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 46, 105, 168, 0, 0, 0, 0, 0),
('management', 169, 133, 'admin/structure/menu/manage/%/list', 'admin/structure/menu/manage/%/list', 'List links', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 21, 47, 133, 169, 0, 0, 0, 0, 0),
('management', 170, 47, 'admin/structure/menu/item/%/reset', 'admin/structure/menu/item/%/reset', 'Reset menu link', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 47, 170, 0, 0, 0, 0, 0, 0),
('management', 171, 105, 'admin/config/media/image-styles/delete/%', 'admin/config/media/image-styles/delete/%', 'Delete style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a2244656c65746520616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 46, 105, 171, 0, 0, 0, 0, 0),
('management', 172, 105, 'admin/config/media/image-styles/revert/%', 'admin/config/media/image-styles/revert/%', 'Revert style', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32323a2252657665727420616e20696d616765207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 46, 105, 172, 0, 0, 0, 0, 0),
('management', 173, 135, 'admin/structure/types/manage/%/comment/display', 'admin/structure/types/manage/%/comment/display', 'Comment display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 4, 5, 0, 1, 21, 36, 135, 173, 0, 0, 0, 0, 0),
('management', 174, 135, 'admin/structure/types/manage/%/comment/fields', 'admin/structure/types/manage/%/comment/fields', 'Comment fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 3, 5, 0, 1, 21, 36, 135, 174, 0, 0, 0, 0, 0),
('management', 175, 155, 'admin/structure/block/manage/%/%/configure', 'admin/structure/block/manage/%/%/configure', 'Configure block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 30, 155, 175, 0, 0, 0, 0, 0),
('management', 176, 155, 'admin/structure/block/manage/%/%/delete', 'admin/structure/block/manage/%/%/delete', 'Delete block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 30, 155, 176, 0, 0, 0, 0, 0),
('management', 177, 136, 'admin/config/regional/date-time/formats/%/delete', 'admin/config/regional/date-time/formats/%/delete', 'Delete date format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34373a22416c6c6f7720757365727320746f2064656c657465206120636f6e66696775726564206461746520666f726d61742e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 51, 99, 136, 177, 0, 0, 0, 0),
('management', 178, 145, 'admin/config/regional/date-time/types/%/delete', 'admin/config/regional/date-time/types/%/delete', 'Delete date type', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a22416c6c6f7720757365727320746f2064656c657465206120636f6e66696775726564206461746520747970652e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 51, 99, 145, 178, 0, 0, 0, 0),
('management', 179, 136, 'admin/config/regional/date-time/formats/%/edit', 'admin/config/regional/date-time/formats/%/edit', 'Edit date format', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34353a22416c6c6f7720757365727320746f2065646974206120636f6e66696775726564206461746520666f726d61742e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 51, 99, 136, 179, 0, 0, 0, 0),
('management', 180, 168, 'admin/config/media/image-styles/edit/%/add/%', 'admin/config/media/image-styles/edit/%/add/%', 'Add image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32383a224164642061206e65772065666665637420746f2061207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 46, 105, 168, 180, 0, 0, 0, 0),
('management', 181, 168, 'admin/config/media/image-styles/edit/%/effects/%', 'admin/config/media/image-styles/edit/%/effects/%', 'Edit image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a224564697420616e206578697374696e67206566666563742077697468696e2061207374796c652e223b7d7d, 'system', 0, 0, 1, 0, 0, 6, 0, 1, 8, 46, 105, 168, 181, 0, 0, 0, 0),
('management', 182, 181, 'admin/config/media/image-styles/edit/%/effects/%/delete', 'admin/config/media/image-styles/edit/%/effects/%/delete', 'Delete image effect', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33393a2244656c65746520616e206578697374696e67206566666563742066726f6d2061207374796c652e223b7d7d, 'system', 0, 0, 0, 0, 0, 7, 0, 1, 8, 46, 105, 168, 181, 182, 0, 0, 0),
('management', 183, 47, 'admin/structure/menu/manage/main-menu', 'admin/structure/menu/manage/%', 'Main menu', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 47, 183, 0, 0, 0, 0, 0, 0),
('management', 184, 47, 'admin/structure/menu/manage/management', 'admin/structure/menu/manage/%', 'Management', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 47, 184, 0, 0, 0, 0, 0, 0),
('management', 185, 47, 'admin/structure/menu/manage/navigation', 'admin/structure/menu/manage/%', 'Navigation', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 47, 185, 0, 0, 0, 0, 0, 0),
('management', 186, 47, 'admin/structure/menu/manage/user-menu', 'admin/structure/menu/manage/%', 'User menu', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 47, 186, 0, 0, 0, 0, 0, 0),
('navigation', 187, 0, 'search', 'search', 'Search', 0x613a303a7b7d, 'system', 1, 0, 0, 0, 0, 1, 0, 187, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 188, 187, 'search/node', 'search/node', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 2, 0, 187, 188, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 189, 187, 'search/user', 'search/user', 'Users', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 187, 189, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 190, 188, 'search/node/%', 'search/node/%', 'Content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 187, 188, 190, 0, 0, 0, 0, 0, 0, 0),
('navigation', 191, 17, 'user/%/shortcuts', 'user/%/shortcuts', 'Shortcuts', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 17, 191, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 192, 19, 'admin/reports/search', 'admin/reports/search', 'Top search phrases', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33333a2256696577206d6f737420706f70756c61722073656172636820706872617365732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 192, 0, 0, 0, 0, 0, 0, 0),
('navigation', 193, 189, 'search/user/%', 'search/user/%', 'Users', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 187, 189, 193, 0, 0, 0, 0, 0, 0, 0),
('management', 194, 12, 'admin/help/number', 'admin/help/number', 'number', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 194, 0, 0, 0, 0, 0, 0, 0),
('management', 195, 12, 'admin/help/overlay', 'admin/help/overlay', 'overlay', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 195, 0, 0, 0, 0, 0, 0, 0),
('management', 196, 12, 'admin/help/path', 'admin/help/path', 'path', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 196, 0, 0, 0, 0, 0, 0, 0),
('management', 197, 12, 'admin/help/rdf', 'admin/help/rdf', 'rdf', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 197, 0, 0, 0, 0, 0, 0, 0),
('management', 198, 12, 'admin/help/search', 'admin/help/search', 'search', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 198, 0, 0, 0, 0, 0, 0, 0),
('management', 199, 12, 'admin/help/shortcut', 'admin/help/shortcut', 'shortcut', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 199, 0, 0, 0, 0, 0, 0, 0),
('management', 200, 53, 'admin/config/search/settings', 'admin/config/search/settings', 'Search settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36373a22436f6e6669677572652072656c6576616e63652073657474696e677320666f722073656172636820616e64206f7468657220696e646578696e67206f7074696f6e732e223b7d7d, 'system', 0, 0, 0, 0, -10, 4, 0, 1, 8, 53, 200, 0, 0, 0, 0, 0, 0),
('management', 201, 61, 'admin/config/user-interface/shortcut', 'admin/config/user-interface/shortcut', 'Shortcuts', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32393a2241646420616e64206d6f646966792073686f727463757420736574732e223b7d7d, 'system', 0, 0, 1, 0, 0, 4, 0, 1, 8, 61, 201, 0, 0, 0, 0, 0, 0),
('management', 202, 53, 'admin/config/search/path', 'admin/config/search/path', 'URL aliases', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a224368616e676520796f7572207369746527732055524c20706174687320627920616c696173696e67207468656d2e223b7d7d, 'system', 0, 0, 1, 0, -5, 4, 0, 1, 8, 53, 202, 0, 0, 0, 0, 0, 0),
('management', 203, 202, 'admin/config/search/path/add', 'admin/config/search/path/add', 'Add alias', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 53, 202, 203, 0, 0, 0, 0, 0),
('management', 204, 201, 'admin/config/user-interface/shortcut/add-set', 'admin/config/user-interface/shortcut/add-set', 'Add shortcut set', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 61, 201, 204, 0, 0, 0, 0, 0);
INSERT INTO `menu_links` (`menu_name`, `mlid`, `plid`, `link_path`, `router_path`, `link_title`, `options`, `module`, `hidden`, `external`, `has_children`, `expanded`, `weight`, `depth`, `customized`, `p1`, `p2`, `p3`, `p4`, `p5`, `p6`, `p7`, `p8`, `p9`, `updated`) VALUES
('management', 205, 200, 'admin/config/search/settings/reindex', 'admin/config/search/settings/reindex', 'Clear index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 53, 200, 205, 0, 0, 0, 0, 0),
('management', 206, 201, 'admin/config/user-interface/shortcut/%', 'admin/config/user-interface/shortcut/%', 'Edit shortcuts', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 61, 201, 206, 0, 0, 0, 0, 0),
('management', 207, 202, 'admin/config/search/path/list', 'admin/config/search/path/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 8, 53, 202, 207, 0, 0, 0, 0, 0),
('management', 208, 206, 'admin/config/user-interface/shortcut/%/add-link', 'admin/config/user-interface/shortcut/%/add-link', 'Add shortcut', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 61, 201, 206, 208, 0, 0, 0, 0),
('management', 209, 202, 'admin/config/search/path/delete/%', 'admin/config/search/path/delete/%', 'Delete alias', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 53, 202, 209, 0, 0, 0, 0, 0),
('management', 210, 206, 'admin/config/user-interface/shortcut/%/delete', 'admin/config/user-interface/shortcut/%/delete', 'Delete shortcut set', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 61, 201, 206, 210, 0, 0, 0, 0),
('management', 211, 202, 'admin/config/search/path/edit/%', 'admin/config/search/path/edit/%', 'Edit alias', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 5, 0, 1, 8, 53, 202, 211, 0, 0, 0, 0, 0),
('management', 212, 206, 'admin/config/user-interface/shortcut/%/edit', 'admin/config/user-interface/shortcut/%/edit', 'Edit set name', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 6, 0, 1, 8, 61, 201, 206, 212, 0, 0, 0, 0),
('management', 213, 201, 'admin/config/user-interface/shortcut/link/%', 'admin/config/user-interface/shortcut/link/%', 'Edit shortcut', 0x613a303a7b7d, 'system', 0, 0, 1, 0, 0, 5, 0, 1, 8, 61, 201, 213, 0, 0, 0, 0, 0),
('management', 214, 206, 'admin/config/user-interface/shortcut/%/links', 'admin/config/user-interface/shortcut/%/links', 'List links', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 61, 201, 206, 214, 0, 0, 0, 0),
('management', 215, 213, 'admin/config/user-interface/shortcut/link/%/delete', 'admin/config/user-interface/shortcut/link/%/delete', 'Delete shortcut', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 61, 201, 213, 215, 0, 0, 0, 0),
('shortcut-set-1', 216, 0, 'node/add', 'node/add', 'Add content', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, -20, 1, 0, 216, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('shortcut-set-1', 217, 0, 'admin/content', 'admin/content', 'Find content', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, -19, 1, 0, 217, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 218, 0, 'taxonomy/term/1', 'taxonomy/term/%', 'World', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -50, 1, 1, 218, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 219, 6, 'node/add/article', 'node/add/article', 'Article', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38393a22557365203c656d3e61727469636c65733c2f656d3e20666f722074696d652d73656e73697469766520636f6e74656e74206c696b65206e6577732c2070726573732072656c6561736573206f7220626c6f6720706f7374732e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 219, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 220, 6, 'node/add/page', 'node/add/page', 'Basic page', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a37373a22557365203c656d3e62617369632070616765733c2f656d3e20666f7220796f75722073746174696320636f6e74656e742c207375636820617320616e202741626f75742075732720706167652e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 220, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 221, 12, 'admin/help/toolbar', 'admin/help/toolbar', 'toolbar', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 221, 0, 0, 0, 0, 0, 0, 0),
('management', 260, 19, 'admin/reports/updates', 'admin/reports/updates', 'Available updates', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38323a22476574206120737461747573207265706f72742061626f757420617661696c61626c65207570646174657320666f7220796f757220696e7374616c6c6564206d6f64756c657320616e64207468656d65732e223b7d7d, 'system', 0, 0, 0, 0, -50, 3, 0, 1, 19, 260, 0, 0, 0, 0, 0, 0, 0),
('management', 261, 7, 'admin/appearance/install', 'admin/appearance/install', 'Install new theme', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 25, 3, 0, 1, 7, 261, 0, 0, 0, 0, 0, 0, 0),
('management', 262, 16, 'admin/modules/update', 'admin/modules/update', 'Update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 3, 0, 1, 16, 262, 0, 0, 0, 0, 0, 0, 0),
('management', 263, 16, 'admin/modules/install', 'admin/modules/install', 'Install new module', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 25, 3, 0, 1, 16, 263, 0, 0, 0, 0, 0, 0, 0),
('management', 264, 7, 'admin/appearance/update', 'admin/appearance/update', 'Update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 3, 0, 1, 7, 264, 0, 0, 0, 0, 0, 0, 0),
('management', 265, 12, 'admin/help/update', 'admin/help/update', 'update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 265, 0, 0, 0, 0, 0, 0, 0),
('management', 266, 260, 'admin/reports/updates/install', 'admin/reports/updates/install', 'Install new module or theme', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 25, 4, 0, 1, 19, 260, 266, 0, 0, 0, 0, 0, 0),
('management', 267, 260, 'admin/reports/updates/update', 'admin/reports/updates/update', 'Update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 4, 0, 1, 19, 260, 267, 0, 0, 0, 0, 0, 0),
('management', 268, 260, 'admin/reports/updates/list', 'admin/reports/updates/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 19, 260, 268, 0, 0, 0, 0, 0, 0),
('management', 269, 260, 'admin/reports/updates/settings', 'admin/reports/updates/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 50, 4, 0, 1, 19, 260, 269, 0, 0, 0, 0, 0, 0),
('management', 308, 21, 'admin/structure/quicktabs', 'admin/structure/quicktabs', 'Quicktabs', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33323a2243726561746520626c6f636b73206f662074616262656420636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 308, 0, 0, 0, 0, 0, 0, 0),
('management', 309, 12, 'admin/help/quicktabs', 'admin/help/quicktabs', 'quicktabs', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 309, 0, 0, 0, 0, 0, 0, 0),
('management', 310, 308, 'admin/structure/quicktabs/add', 'admin/structure/quicktabs/add', 'Add Quicktabs Instance', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 308, 310, 0, 0, 0, 0, 0, 0),
('management', 311, 308, 'admin/structure/quicktabs/list', 'admin/structure/quicktabs/list', 'List quicktabs', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 308, 311, 0, 0, 0, 0, 0, 0),
('management', 312, 308, 'admin/structure/quicktabs/manage/%', 'admin/structure/quicktabs/manage/%', 'Edit quicktab', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 308, 312, 0, 0, 0, 0, 0, 0),
('management', 313, 312, 'admin/structure/quicktabs/manage/%/clone', 'admin/structure/quicktabs/manage/%/clone', 'Clone quicktab', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 308, 312, 313, 0, 0, 0, 0, 0),
('management', 314, 312, 'admin/structure/quicktabs/manage/%/delete', 'admin/structure/quicktabs/manage/%/delete', 'Delete quicktab', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 308, 312, 314, 0, 0, 0, 0, 0),
('management', 315, 312, 'admin/structure/quicktabs/manage/%/edit', 'admin/structure/quicktabs/manage/%/edit', 'Edit quicktab', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 308, 312, 315, 0, 0, 0, 0, 0),
('management', 316, 312, 'admin/structure/quicktabs/manage/%/export', 'admin/structure/quicktabs/manage/%/export', 'Export', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 308, 312, 316, 0, 0, 0, 0, 0),
('navigation', 321, 5, 'node/%/webform-results', 'node/%/webform-results', 'Results', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 2, 0, 5, 321, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 322, 6, 'node/add/webform', 'node/add/webform', 'Webform', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3133383a224372656174652061206e657720666f726d206f72207175657374696f6e6e616972652061636365737369626c6520746f2075736572732e205375626d697373696f6e20726573756c747320616e64207374617469737469637320617265207265636f7264656420616e642061636365737369626c6520746f2070726976696c656765642075736572732e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 322, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 323, 5, 'node/%/webform', 'node/%/webform', 'Webform', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 2, 0, 5, 323, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 324, 9, 'admin/content/webform', 'admin/content/webform', 'Webforms', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35343a225669657720616e64206564697420616c6c2074686520617661696c61626c6520776562666f726d73206f6e20796f757220736974652e223b7d7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 9, 324, 0, 0, 0, 0, 0, 0, 0),
('management', 325, 12, 'admin/help/webform', 'admin/help/webform', 'webform', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 325, 0, 0, 0, 0, 0, 0, 0),
('navigation', 326, 321, 'node/%/webform-results/analysis', 'node/%/webform-results/analysis', 'Analysis', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 5, 3, 0, 5, 321, 326, 0, 0, 0, 0, 0, 0, 0),
('navigation', 327, 321, 'node/%/webform-results/clear', 'node/%/webform-results/clear', 'Clear', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 8, 3, 0, 5, 321, 327, 0, 0, 0, 0, 0, 0, 0),
('navigation', 328, 321, 'node/%/webform-results/download', 'node/%/webform-results/download', 'Download', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 7, 3, 0, 5, 321, 328, 0, 0, 0, 0, 0, 0, 0),
('navigation', 329, 323, 'node/%/webform/emails', 'node/%/webform/emails', 'E-mails', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 3, 0, 5, 323, 329, 0, 0, 0, 0, 0, 0, 0),
('navigation', 330, 323, 'node/%/webform/components', 'node/%/webform/components', 'Form components', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 5, 323, 330, 0, 0, 0, 0, 0, 0, 0),
('navigation', 331, 323, 'node/%/webform/configure', 'node/%/webform/configure', 'Form settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 3, 0, 5, 323, 331, 0, 0, 0, 0, 0, 0, 0),
('navigation', 332, 321, 'node/%/webform-results/submissions', 'node/%/webform-results/submissions', 'Submissions', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 4, 3, 0, 5, 321, 332, 0, 0, 0, 0, 0, 0, 0),
('navigation', 333, 321, 'node/%/webform-results/table', 'node/%/webform-results/table', 'Table', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 6, 3, 0, 5, 321, 333, 0, 0, 0, 0, 0, 0, 0),
('management', 334, 35, 'admin/config/content/webform', 'admin/config/content/webform', 'Webform settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34363a22476c6f62616c20636f6e66696775726174696f6e206f6620776562666f726d2066756e6374696f6e616c6974792e223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 35, 334, 0, 0, 0, 0, 0, 0),
('navigation', 335, 5, 'node/%/submission/%/delete', 'node/%/submission/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 2, 0, 5, 335, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 336, 5, 'node/%/submission/%/edit', 'node/%/submission/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 2, 0, 5, 336, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 337, 329, 'node/%/webform/emails/%', 'node/%/webform/emails/%', 'Edit e-mail settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 5, 323, 329, 337, 0, 0, 0, 0, 0, 0),
('navigation', 338, 5, 'node/%/submission/%/view', 'node/%/submission/%/view', 'View', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 2, 0, 5, 338, 0, 0, 0, 0, 0, 0, 0, 0),
('navigation', 339, 330, 'node/%/webform/components/%', 'node/%/webform/components/%', '', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 5, 323, 330, 339, 0, 0, 0, 0, 0, 0),
('navigation', 340, 337, 'node/%/webform/emails/%/delete', 'node/%/webform/emails/%/delete', 'Delete e-mail settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 5, 323, 329, 337, 340, 0, 0, 0, 0, 0),
('navigation', 341, 339, 'node/%/webform/components/%/delete', 'node/%/webform/components/%/delete', '', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 5, 323, 330, 339, 341, 0, 0, 0, 0, 0),
('navigation', 342, 339, 'node/%/webform/components/%/clone', 'node/%/webform/components/%/clone', '', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 5, 323, 330, 339, 342, 0, 0, 0, 0, 0),
('management', 343, 12, 'admin/help/jquery_update', 'admin/help/jquery_update', 'jquery_update', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 343, 0, 0, 0, 0, 0, 0, 0),
('management', 344, 39, 'admin/config/development/jquery_update', 'admin/config/development/jquery_update', 'jQuery update', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a38333a22436f6e6669677572652073657474696e67732072656c6174656420746f20746865206a517565727920757067726164652c20746865206c696272617279207061746820616e6420636f6d7072657373696f6e2e223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 39, 344, 0, 0, 0, 0, 0, 0),
('management', 345, 12, 'admin/help/superfish', 'admin/help/superfish', 'superfish', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 345, 0, 0, 0, 0, 0, 0, 0),
('management', 346, 61, 'admin/config/user-interface/superfish', 'admin/config/user-interface/superfish', 'Superfish', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a32353a22436f6e66696775726520537570657266697368204d656e7573223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 61, 346, 0, 0, 0, 0, 0, 0),
('management', 347, 54, 'admin/appearance/settings/newsplus', 'admin/appearance/settings/newsplus', 'News+', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 7, 54, 347, 0, 0, 0, 0, 0, 0),
('management', 348, 30, 'admin/structure/block/list/newsplus', 'admin/structure/block/list/newsplus', 'News+', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 30, 348, 0, 0, 0, 0, 0, 0),
('navigation', 351, 6, 'node/add/mt-post', 'node/add/mt-post', 'Post', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3132383a225573652074686520506f737420636f6e74656e74207479706520746f2063726561746520616e64207075626c6973682061727469636c6573206d616b696e6720757365206f6620616c6c20746865207370656369616c2066756e6374696f6e616c697479206275696c7420696e746f20746865204e6577732b207468656d652e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 351, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 352, 19, 'admin/reports/hits', 'admin/reports/hits', 'Recent hits', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34333a22566965772070616765732074686174206861766520726563656e746c79206265656e20766973697465642e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 352, 0, 0, 0, 0, 0, 0, 0),
('management', 353, 19, 'admin/reports/pages', 'admin/reports/pages', 'Top pages', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a34313a225669657720706167657320746861742068617665206265656e20686974206672657175656e746c792e223b7d7d, 'system', 0, 0, 0, 0, 1, 3, 0, 1, 19, 353, 0, 0, 0, 0, 0, 0, 0),
('management', 354, 19, 'admin/reports/referrers', 'admin/reports/referrers', 'Top referrers', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31393a225669657720746f70207265666572726572732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 354, 0, 0, 0, 0, 0, 0, 0),
('management', 355, 19, 'admin/reports/visitors', 'admin/reports/visitors', 'Top visitors', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33343a22566965772076697369746f7273207468617420686974206d616e792070616765732e223b7d7d, 'system', 0, 0, 0, 0, 2, 3, 0, 1, 19, 355, 0, 0, 0, 0, 0, 0, 0),
('navigation', 356, 5, 'node/%/track', 'node/%/track', 'Track', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 2, 0, 5, 356, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 357, 12, 'admin/help/statistics', 'admin/help/statistics', 'statistics', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 357, 0, 0, 0, 0, 0, 0, 0),
('management', 358, 19, 'admin/reports/access/%', 'admin/reports/access/%', 'Details', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31363a225669657720616363657373206c6f672e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 358, 0, 0, 0, 0, 0, 0, 0),
('management', 359, 56, 'admin/config/system/statistics', 'admin/config/system/statistics', 'Statistics', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a36383a22436f6e74726f6c2064657461696c732061626f7574207768617420616e6420686f7720796f75722073697465206c6f67732061636365737320737461746973746963732e223b7d7d, 'system', 0, 0, 0, 0, -15, 4, 0, 1, 8, 56, 359, 0, 0, 0, 0, 0, 0),
('navigation', 360, 17, 'user/%/track/navigation', 'user/%/track/navigation', 'Track page visits', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 2, 0, 17, 360, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 382, 12, 'admin/help/php', 'admin/help/php', 'php', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 3, 0, 1, 12, 382, 0, 0, 0, 0, 0, 0, 0),
('management', 383, 21, 'admin/structure/views', 'admin/structure/views', 'Views', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33353a224d616e61676520637573746f6d697a6564206c69737473206f6620636f6e74656e742e223b7d7d, 'system', 0, 0, 1, 0, 0, 3, 0, 1, 21, 383, 0, 0, 0, 0, 0, 0, 0),
('management', 384, 19, 'admin/reports/views-plugins', 'admin/reports/views-plugins', 'Views plugins', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33383a224f76657276696577206f6620706c7567696e73207573656420696e20616c6c2076696577732e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 19, 384, 0, 0, 0, 0, 0, 0, 0),
('management', 385, 383, 'admin/structure/views/add', 'admin/structure/views/add', 'Add new view', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 383, 385, 0, 0, 0, 0, 0, 0),
('management', 386, 383, 'admin/structure/views/add-template', 'admin/structure/views/add-template', 'Add view from template', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 383, 386, 0, 0, 0, 0, 0, 0),
('management', 387, 383, 'admin/structure/views/import', 'admin/structure/views/import', 'Import', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 383, 387, 0, 0, 0, 0, 0, 0),
('management', 388, 383, 'admin/structure/views/list', 'admin/structure/views/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 21, 383, 388, 0, 0, 0, 0, 0, 0),
('management', 389, 383, 'admin/structure/views/settings', 'admin/structure/views/settings', 'Settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 21, 383, 389, 0, 0, 0, 0, 0, 0),
('management', 390, 42, 'admin/reports/fields/list', 'admin/reports/fields/list', 'List', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 4, 0, 1, 19, 42, 390, 0, 0, 0, 0, 0, 0),
('management', 391, 42, 'admin/reports/fields/views-fields', 'admin/reports/fields/views-fields', 'Used in views', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33373a224f76657276696577206f66206669656c6473207573656420696e20616c6c2076696577732e223b7d7d, 'system', -1, 0, 0, 0, 0, 4, 0, 1, 19, 42, 391, 0, 0, 0, 0, 0, 0),
('management', 392, 389, 'admin/structure/views/settings/advanced', 'admin/structure/views/settings/advanced', 'Advanced', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 5, 0, 1, 21, 383, 389, 392, 0, 0, 0, 0, 0),
('management', 393, 389, 'admin/structure/views/settings/basic', 'admin/structure/views/settings/basic', 'Basic', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 383, 389, 393, 0, 0, 0, 0, 0),
('management', 394, 383, 'admin/structure/views/view/%', 'admin/structure/views/view/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 383, 394, 0, 0, 0, 0, 0, 0),
('management', 395, 394, 'admin/structure/views/view/%/break-lock', 'admin/structure/views/view/%/break-lock', 'Break lock', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 383, 394, 395, 0, 0, 0, 0, 0),
('management', 396, 394, 'admin/structure/views/view/%/edit', 'admin/structure/views/view/%/edit', 'Edit view', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 5, 0, 1, 21, 383, 394, 396, 0, 0, 0, 0, 0),
('management', 397, 394, 'admin/structure/views/view/%/clone', 'admin/structure/views/view/%/clone', 'Clone', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 383, 394, 397, 0, 0, 0, 0, 0),
('management', 398, 394, 'admin/structure/views/view/%/delete', 'admin/structure/views/view/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 383, 394, 398, 0, 0, 0, 0, 0),
('management', 399, 394, 'admin/structure/views/view/%/export', 'admin/structure/views/view/%/export', 'Export', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 383, 394, 399, 0, 0, 0, 0, 0),
('management', 400, 394, 'admin/structure/views/view/%/revert', 'admin/structure/views/view/%/revert', 'Revert', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 383, 394, 400, 0, 0, 0, 0, 0),
('management', 401, 383, 'admin/structure/views/nojs/preview/%/%', 'admin/structure/views/nojs/preview/%/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 383, 401, 0, 0, 0, 0, 0, 0),
('management', 402, 383, 'admin/structure/views/ajax/preview/%/%', 'admin/structure/views/ajax/preview/%/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 21, 383, 402, 0, 0, 0, 0, 0, 0),
('management', 403, 394, 'admin/structure/views/view/%/preview/%', 'admin/structure/views/view/%/preview/%', '', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 383, 394, 403, 0, 0, 0, 0, 0),
('main-menu', 405, 0, 'taxonomy/term/2', 'taxonomy/term/%', 'Finance', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -49, 1, 1, 405, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 406, 0, 'taxonomy/term/3', 'taxonomy/term/%', 'Health', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -48, 1, 1, 406, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 407, 0, 'taxonomy/term/4', 'taxonomy/term/%', 'Tech', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -47, 1, 1, 407, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 408, 0, 'taxonomy/term/5', 'taxonomy/term/%', 'Lifestyle', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, -46, 1, 1, 408, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 409, 0, 'taxonomy/term/6', 'taxonomy/term/%', 'Sports', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -45, 1, 1, 409, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 410, 89, 'admin/structure/taxonomy/%/display', 'admin/structure/taxonomy/%/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 21, 57, 89, 410, 0, 0, 0, 0, 0),
('management', 411, 90, 'admin/config/people/accounts/display', 'admin/config/people/accounts/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 8, 48, 90, 411, 0, 0, 0, 0, 0),
('management', 412, 89, 'admin/structure/taxonomy/%/fields', 'admin/structure/taxonomy/%/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 21, 57, 89, 412, 0, 0, 0, 0, 0),
('management', 413, 90, 'admin/config/people/accounts/fields', 'admin/config/people/accounts/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 8, 48, 90, 413, 0, 0, 0, 0, 0),
('management', 414, 410, 'admin/structure/taxonomy/%/display/default', 'admin/structure/taxonomy/%/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 57, 89, 410, 414, 0, 0, 0, 0),
('management', 415, 411, 'admin/config/people/accounts/display/default', 'admin/config/people/accounts/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 8, 48, 90, 411, 415, 0, 0, 0, 0),
('management', 416, 135, 'admin/structure/types/manage/%/display', 'admin/structure/types/manage/%/display', 'Manage display', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 5, 0, 1, 21, 36, 135, 416, 0, 0, 0, 0, 0),
('management', 417, 135, 'admin/structure/types/manage/%/fields', 'admin/structure/types/manage/%/fields', 'Manage fields', 0x613a303a7b7d, 'system', -1, 0, 1, 0, 1, 5, 0, 1, 21, 36, 135, 417, 0, 0, 0, 0, 0),
('management', 418, 410, 'admin/structure/taxonomy/%/display/full', 'admin/structure/taxonomy/%/display/full', 'Taxonomy term page', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 57, 89, 410, 418, 0, 0, 0, 0),
('management', 419, 411, 'admin/config/people/accounts/display/full', 'admin/config/people/accounts/display/full', 'User account', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 8, 48, 90, 411, 419, 0, 0, 0, 0),
('management', 420, 412, 'admin/structure/taxonomy/%/fields/%', 'admin/structure/taxonomy/%/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 57, 89, 412, 420, 0, 0, 0, 0),
('management', 421, 413, 'admin/config/people/accounts/fields/%', 'admin/config/people/accounts/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 8, 48, 90, 413, 421, 0, 0, 0, 0),
('management', 422, 416, 'admin/structure/types/manage/%/display/default', 'admin/structure/types/manage/%/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 36, 135, 416, 422, 0, 0, 0, 0),
('management', 423, 416, 'admin/structure/types/manage/%/display/full', 'admin/structure/types/manage/%/display/full', 'Full content', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 36, 135, 416, 423, 0, 0, 0, 0),
('management', 424, 416, 'admin/structure/types/manage/%/display/rss', 'admin/structure/types/manage/%/display/rss', 'RSS', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 2, 6, 0, 1, 21, 36, 135, 416, 424, 0, 0, 0, 0),
('management', 425, 416, 'admin/structure/types/manage/%/display/search_index', 'admin/structure/types/manage/%/display/search_index', 'Search index', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 3, 6, 0, 1, 21, 36, 135, 416, 425, 0, 0, 0, 0),
('management', 426, 416, 'admin/structure/types/manage/%/display/search_result', 'admin/structure/types/manage/%/display/search_result', 'Search result', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 4, 6, 0, 1, 21, 36, 135, 416, 426, 0, 0, 0, 0),
('management', 427, 416, 'admin/structure/types/manage/%/display/teaser', 'admin/structure/types/manage/%/display/teaser', 'Teaser', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 1, 6, 0, 1, 21, 36, 135, 416, 427, 0, 0, 0, 0),
('management', 428, 417, 'admin/structure/types/manage/%/fields/%', 'admin/structure/types/manage/%/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 36, 135, 417, 428, 0, 0, 0, 0),
('management', 429, 420, 'admin/structure/taxonomy/%/fields/%/delete', 'admin/structure/taxonomy/%/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 57, 89, 412, 420, 429, 0, 0, 0),
('management', 430, 420, 'admin/structure/taxonomy/%/fields/%/edit', 'admin/structure/taxonomy/%/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 57, 89, 412, 420, 430, 0, 0, 0),
('management', 431, 420, 'admin/structure/taxonomy/%/fields/%/field-settings', 'admin/structure/taxonomy/%/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 57, 89, 412, 420, 431, 0, 0, 0),
('management', 432, 420, 'admin/structure/taxonomy/%/fields/%/widget-type', 'admin/structure/taxonomy/%/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 57, 89, 412, 420, 432, 0, 0, 0),
('management', 433, 421, 'admin/config/people/accounts/fields/%/delete', 'admin/config/people/accounts/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 8, 48, 90, 413, 421, 433, 0, 0, 0),
('management', 434, 421, 'admin/config/people/accounts/fields/%/edit', 'admin/config/people/accounts/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 48, 90, 413, 421, 434, 0, 0, 0),
('management', 435, 421, 'admin/config/people/accounts/fields/%/field-settings', 'admin/config/people/accounts/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 48, 90, 413, 421, 435, 0, 0, 0),
('management', 436, 421, 'admin/config/people/accounts/fields/%/widget-type', 'admin/config/people/accounts/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 8, 48, 90, 413, 421, 436, 0, 0, 0),
('management', 437, 173, 'admin/structure/types/manage/%/comment/display/default', 'admin/structure/types/manage/%/comment/display/default', 'Default', 0x613a303a7b7d, 'system', -1, 0, 0, 0, -10, 6, 0, 1, 21, 36, 135, 173, 437, 0, 0, 0, 0),
('management', 438, 173, 'admin/structure/types/manage/%/comment/display/full', 'admin/structure/types/manage/%/comment/display/full', 'Full comment', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 6, 0, 1, 21, 36, 135, 173, 438, 0, 0, 0, 0),
('management', 439, 428, 'admin/structure/types/manage/%/fields/%/delete', 'admin/structure/types/manage/%/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 36, 135, 417, 428, 439, 0, 0, 0),
('management', 440, 428, 'admin/structure/types/manage/%/fields/%/edit', 'admin/structure/types/manage/%/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 36, 135, 417, 428, 440, 0, 0, 0),
('management', 441, 174, 'admin/structure/types/manage/%/comment/fields/%', 'admin/structure/types/manage/%/comment/fields/%', '', 0x613a303a7b7d, 'system', 0, 0, 0, 0, 0, 6, 0, 1, 21, 36, 135, 174, 441, 0, 0, 0, 0),
('management', 442, 428, 'admin/structure/types/manage/%/fields/%/field-settings', 'admin/structure/types/manage/%/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 36, 135, 417, 428, 442, 0, 0, 0),
('management', 443, 428, 'admin/structure/types/manage/%/fields/%/widget-type', 'admin/structure/types/manage/%/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 36, 135, 417, 428, 443, 0, 0, 0),
('management', 444, 441, 'admin/structure/types/manage/%/comment/fields/%/delete', 'admin/structure/types/manage/%/comment/fields/%/delete', 'Delete', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 7, 0, 1, 21, 36, 135, 174, 441, 444, 0, 0, 0),
('management', 445, 441, 'admin/structure/types/manage/%/comment/fields/%/edit', 'admin/structure/types/manage/%/comment/fields/%/edit', 'Edit', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 36, 135, 174, 441, 445, 0, 0, 0),
('management', 446, 441, 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'admin/structure/types/manage/%/comment/fields/%/field-settings', 'Field settings', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 36, 135, 174, 441, 446, 0, 0, 0),
('management', 447, 441, 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'admin/structure/types/manage/%/comment/fields/%/widget-type', 'Widget type', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 7, 0, 1, 21, 36, 135, 174, 441, 447, 0, 0, 0),
('navigation', 448, 6, 'node/add/mt-slideshow-entry', 'node/add/mt-slideshow-entry', 'Slideshow entry', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a3236383a224120536c69646573686f7720656e74727920697320696465616c20666f72206372656174696e6720636f6d6d65726369616c2062616e6e6572732061732077656c6c206173206d6573736167657320666f7220796f757220776562736974652e2055736520697420746f2070726f6d6f746520616e792070616765206f6620796f75722077656273697465206f722055524c20696e746f207468652066726f6e74207061676520736c6964652073686f772e2049742063616e2063617272792061207469746c652c20612074656173657220616e6420616e20696d616765206c696e6b696e6720746f20616e20696e7465726e616c2070617468206f722065787465726e616c206c696e6b2e223b7d7d, 'system', 0, 0, 0, 0, 0, 2, 0, 6, 448, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 449, 47, 'admin/structure/menu/manage/menu-subfooter-menu', 'admin/structure/menu/manage/%', 'Subfooter menu', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 47, 449, 0, 0, 0, 0, 0, 0),
('menu-subfooter-menu', 450, 0, 'node/13', 'node/%', 'Contact', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -47, 1, 1, 450, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-subfooter-menu', 451, 0, '<front>', '', 'Home', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 1, 0, 0, -50, 1, 1, 451, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-subfooter-menu', 452, 0, '<front>', '', 'Advertise with us', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 1, 0, 0, -49, 1, 1, 452, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-subfooter-menu', 453, 0, '<front>', '', 'Privacy Statement', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 1, 0, 0, -48, 1, 1, 453, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 454, 47, 'admin/structure/menu/manage/menu-sidebar-menu', 'admin/structure/menu/manage/%', 'Sidebar Menu', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 47, 454, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 458, 0, 'taxonomy/term/1', 'taxonomy/term/%', 'World', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, -50, 1, 1, 458, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 459, 0, 'taxonomy/term/2', 'taxonomy/term/%', 'Finance', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, 0, 1, 1, 459, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 460, 0, 'taxonomy/term/3', 'taxonomy/term/%', 'Health', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, 0, 1, 1, 460, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 461, 0, 'taxonomy/term/4', 'taxonomy/term/%', 'Tech', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, 0, 1, 1, 461, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 462, 0, 'taxonomy/term/5', 'taxonomy/term/%', 'Lifestyle', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, 0, 1, 1, 462, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 463, 0, 'taxonomy/term/6', 'taxonomy/term/%', 'Sports', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, 0, 1, 1, 463, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 464, 458, 'node/6', 'node/%', 'Title of the sixth article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, 0, 2, 1, 458, 464, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 465, 458, 'node/12', 'node/%', 'Title of the twelfth article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, 0, 2, 1, 458, 465, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 466, 459, 'node/1', 'node/%', 'Title of the first article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, 0, 2, 1, 459, 466, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 467, 459, 'node/7', 'node/%', 'Title of the seventh article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, 0, 2, 1, 459, 467, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 468, 460, 'node/2', 'node/%', 'Title of the second article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -50, 2, 1, 460, 468, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 469, 460, 'node/8', 'node/%', 'Title of the eighth article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, 0, 2, 1, 460, 469, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 470, 461, 'node/5', 'node/%', 'Title of the fifth article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, 0, 2, 1, 461, 470, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 471, 461, 'node/11', 'node/%', 'Title of the eleventh article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, 0, 2, 1, 461, 471, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 472, 462, 'node/3', 'node/%', 'Title of the third article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -50, 2, 1, 462, 472, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 473, 462, 'node/9', 'node/%', 'Title of the ninth article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -49, 2, 1, 462, 473, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 474, 463, 'node/4', 'node/%', 'Title of the fourth article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -49, 2, 1, 463, 474, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-sidebar-menu', 475, 463, 'node/10', 'node/%', 'Title of the tenth article rendered on the article page and throughout the site', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -50, 2, 1, 463, 475, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 476, 0, 'node/15', 'node/%', 'Features', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, -44, 1, 1, 476, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 477, 476, 'node/14', 'node/%', 'Typography', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -50, 2, 1, 476, 477, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 479, 131, 'admin/structure/block/list/bartik/add', 'admin/structure/block/list/bartik/add', 'Add block', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 21, 30, 131, 479, 0, 0, 0, 0, 0),
('main-menu', 480, 476, 'node/15', 'node/%', 'Shortcodes', 0x613a303a7b7d, 'menu', 0, 0, 1, 0, -47, 2, 1, 476, 480, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 481, 480, 'node/15', 'node/%', 'Brands', 0x613a323a7b733a383a22667261676d656e74223b733a363a226272616e6473223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -50, 3, 1, 476, 480, 481, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 482, 480, 'node/15', 'node/%', 'Tabs', 0x613a323a7b733a383a22667261676d656e74223b733a343a2274616273223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -49, 3, 1, 476, 480, 482, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 483, 480, 'node/15', 'node/%', 'Accordion', 0x613a323a7b733a383a22667261676d656e74223b733a393a226163636f7264696f6e223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -48, 3, 1, 476, 480, 483, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 484, 480, 'node/15', 'node/%', 'Buttons', 0x613a323a7b733a383a22667261676d656e74223b733a373a22627574746f6e73223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -47, 3, 1, 476, 480, 484, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 485, 480, 'node/15', 'node/%', 'Progressbars', 0x613a323a7b733a383a22667261676d656e74223b733a31323a2270726f677265737362617273223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -46, 3, 1, 476, 480, 485, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 486, 476, 'node/16', 'node/%', 'Responsive Grid', 0x613a303a7b7d, 'menu', 0, 0, 1, 0, -48, 2, 1, 476, 486, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 487, 486, 'node/16', 'node/%', 'Grid - No Sidebar', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, 0, 3, 1, 476, 486, 487, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 488, 486, 'node/17', 'node/%', 'Grid - With Sidebar', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 3, 0, 476, 486, 488, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 489, 476, 'node/15', 'node/%', 'Pages', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, -49, 2, 1, 476, 489, 0, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 490, 489, 'node/11', 'node/%', 'Full Width', 0x613a313a7b733a31303a2261747472696275746573223b613a303a7b7d7d, 'menu', 0, 0, 0, 0, -50, 3, 1, 476, 489, 490, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 491, 489, 'node/1', 'node/%', 'One Sidebar', 0x613a313a7b733a31303a2261747472696275746573223b613a303a7b7d7d, 'menu', 0, 0, 0, 0, -49, 3, 1, 476, 489, 491, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 492, 489, 'node/12', 'node/%', 'Two Sidebars', 0x613a313a7b733a31303a2261747472696275746573223b613a303a7b7d7d, 'menu', 0, 0, 0, 0, -48, 3, 1, 476, 489, 492, 0, 0, 0, 0, 0, 0, 0),
('main-menu', 493, 489, 'node/1', 'node/%', 'Page with comments', 0x613a323a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d733a383a22667261676d656e74223b733a383a22636f6d6d656e7473223b7d, 'menu', 0, 0, 0, 0, -47, 3, 1, 476, 489, 493, 0, 0, 0, 0, 0, 0, 0),
('management', 495, 47, 'admin/structure/menu/manage/menu-secondary-menu', 'admin/structure/menu/manage/%', 'Secondary menu', 0x613a303a7b7d, 'menu', 0, 0, 0, 0, 0, 4, 0, 1, 21, 47, 495, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 496, 0, '<front>', '', 'Home', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 1, 0, 0, -50, 1, 1, 496, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 497, 0, 'node/13', 'node/%', 'Contact', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -47, 1, 1, 497, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 498, 0, 'node/15', 'node/%', 'Features', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, -48, 1, 1, 498, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 499, 498, 'node/14', 'node/%', 'Typography', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -50, 2, 1, 498, 499, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 500, 498, 'node/15', 'node/%', 'Pages', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, -49, 2, 1, 498, 500, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 501, 500, 'node/11', 'node/%', 'Full Width', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -50, 3, 1, 498, 500, 501, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 502, 500, 'node/1', 'node/%', 'One Sidebar', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -49, 3, 1, 498, 500, 502, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 503, 500, 'node/12', 'node/%', 'Two Sidebars', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -48, 3, 1, 498, 500, 503, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 504, 500, 'node/1', 'node/%', 'Page with comments', 0x613a323a7b733a383a22667261676d656e74223b733a383a22636f6d6d656e7473223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -47, 3, 1, 498, 500, 504, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 505, 498, 'node/16', 'node/%', 'Responsive Grid', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, -48, 2, 1, 498, 505, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 506, 505, 'node/16', 'node/%', 'Grid - No Sidebar', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -50, 3, 1, 498, 505, 506, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 507, 505, 'node/17', 'node/%', 'Grid - With Sidebar', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -49, 3, 1, 498, 505, 507, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 508, 498, 'node/15', 'node/%', 'Shortcodes', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 1, 0, -47, 2, 1, 498, 508, 0, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 509, 508, 'node/15', 'node/%', 'Brands', 0x613a323a7b733a383a22667261676d656e74223b733a363a226272616e6473223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -50, 3, 1, 498, 508, 509, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 510, 508, 'node/15', 'node/%', 'Tabs', 0x613a323a7b733a383a22667261676d656e74223b733a343a2274616273223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -49, 3, 1, 498, 508, 510, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 511, 508, 'node/15', 'node/%', 'Accordion', 0x613a323a7b733a383a22667261676d656e74223b733a393a226163636f7264696f6e223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -48, 3, 1, 498, 508, 511, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 512, 508, 'node/15', 'node/%', 'Buttons', 0x613a323a7b733a383a22667261676d656e74223b733a373a22627574746f6e73223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -47, 3, 1, 498, 508, 512, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 513, 508, 'node/15', 'node/%', 'Progressbars', 0x613a323a7b733a383a22667261676d656e74223b733a31323a2270726f677265737362617273223b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -46, 3, 1, 498, 508, 513, 0, 0, 0, 0, 0, 0, 0),
('menu-secondary-menu', 514, 0, 'archive', 'archive', 'Archive', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a303a22223b7d7d, 'menu', 0, 0, 0, 0, -49, 1, 1, 514, 0, 0, 0, 0, 0, 0, 0, 0, 0),
('management', 515, 64, 'admin/config/services/oauth', 'admin/config/services/oauth', 'OAuth', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31383a2253657474696e677320666f72204f41757468223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 64, 515, 0, 0, 0, 0, 0, 0),
('management', 516, 64, 'admin/config/services/twitter', 'admin/config/services/twitter', 'Twitter', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a33303a2254776974746572206163636f756e747320616e642073657474696e67732e223b7d7d, 'system', 0, 0, 0, 0, 0, 4, 0, 1, 8, 64, 516, 0, 0, 0, 0, 0, 0),
('navigation', 517, 40, 'user/%/edit/twitter', 'user/%/edit/twitter', 'Twitter accounts', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 10, 3, 0, 17, 40, 517, 0, 0, 0, 0, 0, 0, 0),
('management', 518, 515, 'admin/config/services/oauth/settings', 'admin/config/services/oauth/settings', 'Settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31383a2253657474696e677320666f72204f41757468223b7d7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 64, 515, 518, 0, 0, 0, 0, 0),
('management', 519, 516, 'admin/config/services/twitter/settings', 'admin/config/services/twitter/settings', 'Settings', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a31373a22547769747465722073657474696e67732e223b7d7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 64, 516, 519, 0, 0, 0, 0, 0),
('management', 520, 516, 'admin/config/services/twitter/default', 'admin/config/services/twitter/default', 'Twitter', 0x613a303a7b7d, 'system', -1, 0, 0, 0, 0, 5, 0, 1, 8, 64, 516, 520, 0, 0, 0, 0, 0),
('management', 521, 21, 'admin/structure/bulk-export', 'admin/structure/bulk-export', 'Bulk Exporter', 0x613a313a7b733a31303a2261747472696275746573223b613a313a7b733a353a227469746c65223b733a35373a2242756c6b2d6578706f7274206d756c7469706c652043546f6f6c732d68616e646c65642064617461206f626a6563747320746f20636f64652e223b7d7d, 'system', 0, 0, 0, 0, 0, 3, 0, 1, 21, 521, 0, 0, 0, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `node`
--

DROP TABLE IF EXISTS `node`;
CREATE TABLE `node` (
  `nid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for a node.',
  `vid` int(10) unsigned DEFAULT NULL COMMENT 'The current node_revision.vid version identifier.',
  `type` varchar(32) NOT NULL DEFAULT '' COMMENT 'The node_type.type of this node.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The languages.language of this node.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this node, always treated as non-markup plain text.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that owns this node; initially, this is the user that created it.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node is published (visible to non-administrators).',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was most recently saved.',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node: 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node should be displayed at the top of lists in which it appears.',
  `tnid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The translation set id for this node, which equals the node id of the source post in each set.',
  `translate` int(11) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this translation page needs to be updated.',
  PRIMARY KEY (`nid`),
  UNIQUE KEY `vid` (`vid`),
  KEY `node_changed` (`changed`),
  KEY `node_created` (`created`),
  KEY `node_frontpage` (`promote`,`status`,`sticky`,`created`),
  KEY `node_status_type` (`status`,`type`,`nid`),
  KEY `node_title_type` (`title`,`type`(4)),
  KEY `node_type` (`type`(4)),
  KEY `uid` (`uid`),
  KEY `tnid` (`tnid`),
  KEY `translate` (`translate`),
  KEY `language` (`language`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='The base table for nodes.' AUTO_INCREMENT=18 ;

--
-- Άδειασμα δεδομένων του πίνακα `node`
--

INSERT INTO `node` (`nid`, `vid`, `type`, `language`, `title`, `uid`, `status`, `created`, `changed`, `comment`, `promote`, `sticky`, `tnid`, `translate`) VALUES
(1, 1, 'mt_post', 'und', 'Title of the first article rendered on the article page and throughout the site', 1, 1, 1402994826, 1403341112, 2, 1, 1, 0, 0),
(2, 2, 'mt_post', 'und', 'Title of the second article rendered on the article page and throughout the site', 1, 1, 1402994717, 1404317990, 2, 1, 1, 0, 0),
(3, 3, 'mt_post', 'und', 'Title of the third article rendered on the article page and throughout the site', 1, 1, 1400661889, 1403364807, 2, 1, 1, 0, 0),
(4, 4, 'mt_post', 'und', 'Title of the fourth article rendered on the article page and throughout the site', 1, 1, 1400661788, 1403080649, 2, 1, 1, 0, 0),
(5, 5, 'mt_post', 'und', 'Title of the fifth article rendered on the article page and throughout the site', 1, 1, 1398069748, 1403080665, 2, 1, 0, 0, 0),
(6, 6, 'mt_post', 'und', 'Title of the sixth article rendered on the article page and throughout the site', 1, 1, 1395391290, 1403086341, 2, 1, 0, 0, 0),
(7, 7, 'mt_post', 'und', 'Title of the seventh article rendered on the article page and throughout the site', 1, 1, 1392972022, 1403086293, 2, 1, 0, 0, 0),
(8, 8, 'mt_post', 'und', 'Title of the eighth article rendered on the article page and throughout the site', 1, 1, 1390293573, 1403118839, 2, 1, 0, 0, 0),
(9, 9, 'mt_post', 'und', 'Title of the ninth article rendered on the article page and throughout the site', 1, 1, 1385023091, 1403086231, 2, 1, 0, 0, 0),
(10, 10, 'mt_post', 'und', 'Title of the tenth article rendered on the article page and throughout the site', 1, 1, 1382344622, 1403086217, 2, 1, 0, 0, 0),
(11, 11, 'mt_post', 'und', 'Title of the eleventh article rendered on the article page and throughout the site', 1, 1, 1379752566, 1403797469, 2, 1, 0, 0, 0),
(12, 12, 'mt_post', 'und', 'Title of the twelfth article rendered on the article page and throughout the site', 1, 1, 1377074122, 1403086109, 2, 1, 0, 0, 0),
(13, 13, 'webform', 'und', 'Contact', 1, 1, 1400854849, 1400855778, 1, 0, 0, 0, 0),
(14, 14, 'page', 'und', 'Typography', 1, 1, 1400857796, 1401379699, 1, 0, 0, 0, 0),
(15, 15, 'page', 'und', 'Shortcodes', 1, 1, 1401351693, 1401379733, 1, 0, 0, 0, 0),
(16, 16, 'page', 'und', 'Responsive Grid', 1, 1, 1401360960, 1401379788, 1, 0, 0, 0, 0),
(17, 17, 'page', 'und', 'Responsive Grid', 1, 1, 1401361205, 1401379764, 1, 0, 0, 0, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `node_access`
--

DROP TABLE IF EXISTS `node_access`;
CREATE TABLE `node_access` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record affects.',
  `gid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The grant ID a user must possess in the specified realm to gain this row’s privileges on the node.',
  `realm` varchar(255) NOT NULL DEFAULT '' COMMENT 'The realm in which the user must possess the grant ID. Each node access node can define one or more realms.',
  `grant_view` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can view this node.',
  `grant_update` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can edit this node.',
  `grant_delete` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether a user with the realm/grant pair can delete this node.',
  PRIMARY KEY (`nid`,`gid`,`realm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Identifies which realm/grant pairs a user must possess in...';

--
-- Άδειασμα δεδομένων του πίνακα `node_access`
--

INSERT INTO `node_access` (`nid`, `gid`, `realm`, `grant_view`, `grant_update`, `grant_delete`) VALUES
(0, 0, 'all', 1, 0, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `node_comment_statistics`
--

DROP TABLE IF EXISTS `node_comment_statistics`;
CREATE TABLE `node_comment_statistics` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid for which the statistics are compiled.',
  `cid` int(11) NOT NULL DEFAULT '0' COMMENT 'The comment.cid of the last comment.',
  `last_comment_timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp of the last comment that was posted within this node, from comment.changed.',
  `last_comment_name` varchar(60) DEFAULT NULL COMMENT 'The name of the latest author to post a comment on this node, from comment.name.',
  `last_comment_uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The user ID of the latest author to post a comment on this node, from comment.uid.',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The total number of comments on this node.',
  PRIMARY KEY (`nid`),
  KEY `node_comment_timestamp` (`last_comment_timestamp`),
  KEY `comment_count` (`comment_count`),
  KEY `last_comment_uid` (`last_comment_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains statistics of node and comments posts to show ...';

--
-- Άδειασμα δεδομένων του πίνακα `node_comment_statistics`
--

INSERT INTO `node_comment_statistics` (`nid`, `cid`, `last_comment_timestamp`, `last_comment_name`, `last_comment_uid`, `comment_count`) VALUES
(1, 4, 1401220547, '', 1, 3),
(2, 1, 1401220324, '', 1, 1),
(3, 0, 1400662489, NULL, 1, 0),
(4, 0, 1400662688, NULL, 1, 0),
(5, 0, 1400662828, NULL, 1, 0),
(6, 0, 1400662950, NULL, 1, 0),
(7, 0, 1400663182, NULL, 1, 0),
(8, 0, 1400663373, NULL, 1, 0),
(9, 0, 1400663471, NULL, 1, 0),
(10, 0, 1400663582, NULL, 1, 0),
(11, 0, 1400663706, NULL, 1, 0),
(12, 0, 1400663842, NULL, 1, 0),
(13, 0, 1400854849, NULL, 1, 0),
(14, 0, 1400857796, NULL, 1, 0),
(15, 0, 1401351693, NULL, 1, 0),
(16, 0, 1401360960, NULL, 1, 0),
(17, 0, 1401361205, NULL, 1, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `node_revision`
--

DROP TABLE IF EXISTS `node_revision`;
CREATE TABLE `node_revision` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node this version belongs to.',
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The primary identifier for this version.',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT 'The users.uid that created this version.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of this version.',
  `log` longtext NOT NULL COMMENT 'The log entry explaining the changes in this version.',
  `timestamp` int(11) NOT NULL DEFAULT '0' COMMENT 'A Unix timestamp indicating when this version was created.',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT 'Boolean indicating whether the node (at the time of this revision) is published (visible to non-administrators).',
  `comment` int(11) NOT NULL DEFAULT '0' COMMENT 'Whether comments are allowed on this node (at the time of this revision): 0 = no, 1 = closed (read only), 2 = open (read/write).',
  `promote` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed on the front page.',
  `sticky` int(11) NOT NULL DEFAULT '0' COMMENT 'Boolean indicating whether the node (at the time of this revision) should be displayed at the top of lists in which it appears.',
  PRIMARY KEY (`vid`),
  KEY `nid` (`nid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores information about each saved version of a node.' AUTO_INCREMENT=18 ;

--
-- Άδειασμα δεδομένων του πίνακα `node_revision`
--

INSERT INTO `node_revision` (`nid`, `vid`, `uid`, `title`, `log`, `timestamp`, `status`, `comment`, `promote`, `sticky`) VALUES
(1, 1, 1, 'Title of the first article rendered on the article page and throughout the site', '', 1403341112, 1, 2, 1, 1),
(2, 2, 1, 'Title of the second article rendered on the article page and throughout the site', '', 1404317990, 1, 2, 1, 1),
(3, 3, 1, 'Title of the third article rendered on the article page and throughout the site', '', 1403364807, 1, 2, 1, 1),
(4, 4, 1, 'Title of the fourth article rendered on the article page and throughout the site', '', 1403080649, 1, 2, 1, 1),
(5, 5, 1, 'Title of the fifth article rendered on the article page and throughout the site', '', 1403080665, 1, 2, 1, 0),
(6, 6, 1, 'Title of the sixth article rendered on the article page and throughout the site', '', 1403086341, 1, 2, 1, 0),
(7, 7, 1, 'Title of the seventh article rendered on the article page and throughout the site', '', 1403086293, 1, 2, 1, 0),
(8, 8, 1, 'Title of the eighth article rendered on the article page and throughout the site', '', 1403118839, 1, 2, 1, 0),
(9, 9, 1, 'Title of the ninth article rendered on the article page and throughout the site', '', 1403086231, 1, 2, 1, 0),
(10, 10, 1, 'Title of the tenth article rendered on the article page and throughout the site', '', 1403086217, 1, 2, 1, 0),
(11, 11, 1, 'Title of the eleventh article rendered on the article page and throughout the site', '', 1403797469, 1, 2, 1, 0),
(12, 12, 1, 'Title of the twelfth article rendered on the article page and throughout the site', '', 1403086109, 1, 2, 1, 0),
(13, 13, 1, 'Contact', '', 1400855778, 1, 1, 0, 0),
(14, 14, 1, 'Typography', '', 1401379699, 1, 1, 0, 0),
(15, 15, 1, 'Shortcodes', '', 1401379733, 1, 1, 0, 0),
(16, 16, 1, 'Responsive Grid', '', 1401379788, 1, 1, 0, 0),
(17, 17, 1, 'Responsive Grid', '', 1401379764, 1, 1, 0, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `node_type`
--

DROP TABLE IF EXISTS `node_type`;
CREATE TABLE `node_type` (
  `type` varchar(32) NOT NULL COMMENT 'The machine-readable name of this type.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The human-readable name of this type.',
  `base` varchar(255) NOT NULL COMMENT 'The base string used to construct callbacks corresponding to this node type.',
  `module` varchar(255) NOT NULL COMMENT 'The module defining this node type.',
  `description` mediumtext NOT NULL COMMENT 'A brief description of this type.',
  `help` mediumtext NOT NULL COMMENT 'Help information shown to the user when creating a node of this type.',
  `has_title` tinyint(3) unsigned NOT NULL COMMENT 'Boolean indicating whether this type uses the node.title field.',
  `title_label` varchar(255) NOT NULL DEFAULT '' COMMENT 'The label displayed for the title field on the edit form.',
  `custom` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type is defined by a module (FALSE) or by a user via Add content type (TRUE).',
  `modified` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether this type has been modified by an administrator; currently not used in any way.',
  `locked` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the administrator can change the machine name of this type.',
  `disabled` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'A boolean indicating whether the node type is disabled.',
  `orig_type` varchar(255) NOT NULL DEFAULT '' COMMENT 'The original machine-readable name of this node type. This may be different from the current type name if the locked field is 0.',
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about all defined node types.';

--
-- Άδειασμα δεδομένων του πίνακα `node_type`
--

INSERT INTO `node_type` (`type`, `name`, `base`, `module`, `description`, `help`, `has_title`, `title_label`, `custom`, `modified`, `locked`, `disabled`, `orig_type`) VALUES
('article', 'Article', 'node_content', 'node', 'Use <em>articles</em> for time-sensitive content like news, press releases or blog posts.', '', 1, 'Title', 1, 1, 0, 0, 'article'),
('blog', 'Blog entry', 'blog', 'blog', 'Use for multi-user blogs. Every user gets a personal blog.', '', 1, 'Title', 0, 1, 1, 1, 'blog'),
('mt_post', 'Post', 'node_content', 'node', 'Use the Post content type to create and publish articles making use of all the special functionality built into the News+ theme.', '', 1, 'Title', 1, 1, 0, 0, 'mt_post'),
('mt_slideshow_entry', 'Slideshow entry', 'node_content', 'node', 'A Slideshow entry is ideal for creating commercial banners as well as messages for your website. Use it to promote any page of your website or URL into the front page slide show. It can carry a title, a teaser and an image linking to an internal path or external link.', '', 1, 'Title', 1, 1, 0, 0, 'mt_slideshow_entry'),
('page', 'Basic page', 'node_content', 'node', 'Use <em>basic pages</em> for your static content, such as an ''About us'' page.', '', 1, 'Title', 1, 1, 0, 0, 'page'),
('webform', 'Webform', 'node_content', 'node', 'Create a new form or questionnaire accessible to users. Submission results and statistics are recorded and accessible to privileged users.', '', 1, 'Title', 1, 1, 0, 0, 'webform');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `oauth_common_consumer`
--

DROP TABLE IF EXISTS `oauth_common_consumer`;
CREATE TABLE `oauth_common_consumer` (
  `csid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `key_hash` char(40) NOT NULL COMMENT 'SHA1-hash of consumer_key.',
  `consumer_key` text NOT NULL COMMENT 'Consumer key.',
  `secret` text NOT NULL COMMENT 'Consumer secret.',
  `configuration` longtext NOT NULL COMMENT 'Consumer configuration',
  PRIMARY KEY (`csid`),
  KEY `key_hash` (`key_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Keys and secrets for OAuth consumers, both those provided...' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `oauth_common_context`
--

DROP TABLE IF EXISTS `oauth_common_context`;
CREATE TABLE `oauth_common_context` (
  `cid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `name` varchar(32) NOT NULL COMMENT 'The computer-readable name of the context.',
  `title` varchar(100) NOT NULL COMMENT 'The localizable title of the authorization context.',
  `authorization_options` longtext NOT NULL COMMENT 'Authorization options.',
  `authorization_levels` longtext NOT NULL COMMENT 'Authorization levels for the context.',
  PRIMARY KEY (`cid`),
  UNIQUE KEY `context` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores contexts for OAuth common' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `oauth_common_nonce`
--

DROP TABLE IF EXISTS `oauth_common_nonce`;
CREATE TABLE `oauth_common_nonce` (
  `nonce` varchar(255) NOT NULL COMMENT 'The random string used on each request.',
  `timestamp` int(11) NOT NULL COMMENT 'The timestamp of the request.',
  `token_key` varchar(32) NOT NULL COMMENT 'Token key.',
  PRIMARY KEY (`nonce`),
  KEY `timekey` (`timestamp`,`token_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores timestamp against nonce for repeat attacks.';

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `oauth_common_provider_consumer`
--

DROP TABLE IF EXISTS `oauth_common_provider_consumer`;
CREATE TABLE `oauth_common_provider_consumer` (
  `csid` int(10) unsigned DEFAULT '0' COMMENT 'The oauth_common_consumer.csid this data is related to.',
  `consumer_key` char(32) NOT NULL COMMENT 'Consumer key.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the consumer was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The last time the consumer was edited, as a Unix timestamp.',
  `uid` int(10) unsigned NOT NULL COMMENT 'The application owner.',
  `name` varchar(128) NOT NULL COMMENT 'The application name.',
  `context` varchar(32) NOT NULL DEFAULT '' COMMENT 'The application context.',
  `callback_url` varchar(255) NOT NULL COMMENT 'Callback url.',
  PRIMARY KEY (`consumer_key`),
  UNIQUE KEY `csid` (`csid`),
  KEY `uid` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Additional data for OAuth consumers provided by this site.';

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `oauth_common_provider_token`
--

DROP TABLE IF EXISTS `oauth_common_provider_token`;
CREATE TABLE `oauth_common_provider_token` (
  `tid` int(10) unsigned DEFAULT '0' COMMENT 'The oauth_common_token.tid this data is related to.',
  `token_key` char(32) NOT NULL COMMENT 'Token key.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The time that the token was created, as a Unix timestamp.',
  `changed` int(11) NOT NULL DEFAULT '0' COMMENT 'The last time the token was edited, as a Unix timestamp.',
  `services` text COMMENT 'An array of services that the user allowed the consumer to access.',
  `authorized` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'In case its a request token, it checks if the user already authorized the consumer to get an access token.',
  PRIMARY KEY (`token_key`),
  UNIQUE KEY `tid` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Additional data for OAuth tokens provided by this site.';

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `oauth_common_token`
--

DROP TABLE IF EXISTS `oauth_common_token`;
CREATE TABLE `oauth_common_token` (
  `tid` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary ID field for the table. Not used for anything except internal lookups.',
  `csid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The oauth_common_consumer.csid this token is related to.',
  `key_hash` char(40) NOT NULL COMMENT 'SHA1-hash of token_key.',
  `token_key` text NOT NULL COMMENT 'Token key.',
  `secret` text NOT NULL COMMENT 'Token secret.',
  `expires` int(11) NOT NULL DEFAULT '0' COMMENT 'The expiry time for the token, as a Unix timestamp.',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Token type: request or access.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'User ID from user.uid.',
  PRIMARY KEY (`tid`),
  KEY `key_hash` (`key_hash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Tokens stored on behalf of providers or consumers for...' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `queue`
--

DROP TABLE IF EXISTS `queue`;
CREATE TABLE `queue` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique item ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The queue name.',
  `data` longblob COMMENT 'The arbitrary data for the item.',
  `expire` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the claim lease expires on the item.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp when the item was created.',
  PRIMARY KEY (`item_id`),
  KEY `name_created` (`name`,`created`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores items in queues.' AUTO_INCREMENT=121 ;

--
-- Άδειασμα δεδομένων του πίνακα `queue`
--

INSERT INTO `queue` (`item_id`, `name`, `data`, `expire`, `created`) VALUES
(111, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a363a2264727570616c223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a353a22426c6f636b223b733a373a227061636b616765223b733a343a22436f7265223b733a373a2276657273696f6e223b733a343a22372e3238223b733a373a2270726f6a656374223b733a363a2264727570616c223b733a393a22646174657374616d70223b733a31303a2231333939353232373331223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313430323939323630313b7d733a393a22646174657374616d70223b733a31303a2231333939353232373331223b733a383a22696e636c75646573223b613a33333a7b733a353a22626c6f636b223b733a353a22426c6f636b223b733a353a22636f6c6f72223b733a353a22436f6c6f72223b733a373a22636f6d6d656e74223b733a373a22436f6d6d656e74223b733a31303a22636f6e7465787475616c223b733a31363a22436f6e7465787475616c206c696e6b73223b733a393a2264617368626f617264223b733a393a2244617368626f617264223b733a353a2264626c6f67223b733a31363a224461746162617365206c6f6767696e67223b733a353a226669656c64223b733a353a224669656c64223b733a31373a226669656c645f73716c5f73746f72616765223b733a31373a224669656c642053514c2073746f72616765223b733a383a226669656c645f7569223b733a383a224669656c64205549223b733a343a2266696c65223b733a343a2246696c65223b733a363a2266696c746572223b733a363a2246696c746572223b733a343a2268656c70223b733a343a2248656c70223b733a353a22696d616765223b733a353a22496d616765223b733a343a226c697374223b733a343a224c697374223b733a343a226d656e75223b733a343a224d656e75223b733a343a226e6f6465223b733a343a224e6f6465223b733a363a226e756d626572223b733a363a224e756d626572223b733a373a226f7074696f6e73223b733a373a224f7074696f6e73223b733a373a226f7665726c6179223b733a373a224f7665726c6179223b733a343a2270617468223b733a343a2250617468223b733a333a22706870223b733a31303a225048502066696c746572223b733a333a22726466223b733a333a22524446223b733a363a22736561726368223b733a363a22536561726368223b733a383a2273686f7274637574223b733a383a2253686f7274637574223b733a31303a2273746174697374696373223b733a31303a2253746174697374696373223b733a363a2273797374656d223b733a363a2253797374656d223b733a383a227461786f6e6f6d79223b733a383a225461786f6e6f6d79223b733a343a2274657874223b733a343a2254657874223b733a373a22746f6f6c626172223b733a373a22546f6f6c626172223b733a363a22757064617465223b733a31343a22557064617465206d616e61676572223b733a343a2275736572223b733a343a2255736572223b733a363a2262617274696b223b733a363a2242617274696b223b733a353a22736576656e223b733a353a22536576656e223b7d733a31323a2270726f6a6563745f74797065223b733a343a22636f7265223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1404392651),
(112, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a363a2263746f6f6c73223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a31313a2242756c6b204578706f7274223b733a373a227061636b616765223b733a31363a224368616f7320746f6f6c207375697465223b733a373a2276657273696f6e223b733a373a22372e782d312e34223b733a373a2270726f6a656374223b733a363a2263746f6f6c73223b733a393a22646174657374616d70223b733a31303a2231333932323230373330223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313430323939323630313b7d733a393a22646174657374616d70223b733a31303a2231333932323230373330223b733a383a22696e636c75646573223b613a323a7b733a31313a2262756c6b5f6578706f7274223b733a31313a2242756c6b204578706f7274223b733a363a2263746f6f6c73223b733a31313a224368616f7320746f6f6c73223b7d733a31323a2270726f6a6563745f74797065223b733a363a226d6f64756c65223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1404392651),
(113, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a31333a226a71756572795f757064617465223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a31333a226a517565727920557064617465223b733a373a227061636b616765223b733a31343a225573657220696e74657266616365223b733a373a2276657273696f6e223b733a373a22372e782d322e34223b733a373a2270726f6a656374223b733a31333a226a71756572795f757064617465223b733a393a22646174657374616d70223b733a31303a2231333936343832323436223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313430323939323630313b7d733a393a22646174657374616d70223b733a31303a2231333936343832323436223b733a383a22696e636c75646573223b613a313a7b733a31333a226a71756572795f757064617465223b733a31333a226a517565727920557064617465223b7d733a31323a2270726f6a6563745f74797065223b733a363a226d6f64756c65223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1404392651),
(114, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a393a226c6962726172696573223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a393a224c6962726172696573223b733a373a2276657273696f6e223b733a373a22372e782d322e32223b733a373a2270726f6a656374223b733a393a226c6962726172696573223b733a393a22646174657374616d70223b733a31303a2231333931393635373136223b733a373a227061636b616765223b733a353a224f74686572223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313430323939323630313b7d733a393a22646174657374616d70223b733a31303a2231333931393635373136223b733a383a22696e636c75646573223b613a313a7b733a393a226c6962726172696573223b733a393a224c6962726172696573223b7d733a31323a2270726f6a6563745f74797065223b733a363a226d6f64756c65223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1404392651),
(115, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a353a226f61757468223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a353a224f41757468223b733a373a227061636b616765223b733a353a224f41757468223b733a373a2276657273696f6e223b733a373a22372e782d332e32223b733a373a2270726f6a656374223b733a353a226f61757468223b733a393a22646174657374616d70223b733a31303a2231333930353631343036223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313430323939323630313b7d733a393a22646174657374616d70223b733a31303a2231333930353631343036223b733a383a22696e636c75646573223b613a313a7b733a31323a226f617574685f636f6d6d6f6e223b733a353a224f41757468223b7d733a31323a2270726f6a6563745f74797065223b733a363a226d6f64756c65223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1404392651),
(116, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a393a22717569636b74616273223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a393a22517569636b74616273223b733a373a2276657273696f6e223b733a373a22372e782d332e36223b733a373a2270726f6a656374223b733a393a22717569636b74616273223b733a393a22646174657374616d70223b733a31303a2231333830373331393239223b733a373a227061636b616765223b733a353a224f74686572223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313430323939323630313b7d733a393a22646174657374616d70223b733a31303a2231333830373331393239223b733a383a22696e636c75646573223b613a313a7b733a393a22717569636b74616273223b733a393a22517569636b74616273223b7d733a31323a2270726f6a6563745f74797065223b733a363a226d6f64756c65223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1404392651),
(117, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a393a22737570657266697368223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a393a22537570657266697368223b733a373a227061636b616765223b733a31343a225573657220696e74657266616365223b733a373a2276657273696f6e223b733a373a22372e782d312e39223b733a373a2270726f6a656374223b733a393a22737570657266697368223b733a393a22646174657374616d70223b733a31303a2231333637303534313132223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313430323939323630313b7d733a393a22646174657374616d70223b733a31303a2231333637303534313132223b733a383a22696e636c75646573223b613a313a7b733a393a22737570657266697368223b733a393a22537570657266697368223b7d733a31323a2270726f6a6563745f74797065223b733a363a226d6f64756c65223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1404392651),
(118, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a373a2274776974746572223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a373a2254776974746572223b733a373a2276657273696f6e223b733a373a22372e782d352e38223b733a373a2270726f6a656374223b733a373a2274776974746572223b733a393a22646174657374616d70223b733a31303a2231333730333033343633223b733a373a227061636b616765223b733a353a224f74686572223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313430323939323630313b7d733a393a22646174657374616d70223b733a31303a2231333730333033343633223b733a383a22696e636c75646573223b613a313a7b733a373a2274776974746572223b733a373a2254776974746572223b7d733a31323a2270726f6a6563745f74797065223b733a363a226d6f64756c65223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1404392651),
(119, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a353a227669657773223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a353a225669657773223b733a373a227061636b616765223b733a353a225669657773223b733a373a2276657273696f6e223b733a373a22372e782d332e38223b733a373a2270726f6a656374223b733a353a227669657773223b733a393a22646174657374616d70223b733a31303a2231343030363138393238223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313430323939323630313b7d733a393a22646174657374616d70223b733a31303a2231343030363138393238223b733a383a22696e636c75646573223b613a323a7b733a353a227669657773223b733a353a225669657773223b733a383a2276696577735f7569223b733a383a225669657773205549223b7d733a31323a2270726f6a6563745f74797065223b733a363a226d6f64756c65223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1404392651),
(120, 'update_fetch_tasks', 0x613a383a7b733a343a226e616d65223b733a373a22776562666f726d223b733a343a22696e666f223b613a363a7b733a343a226e616d65223b733a373a22576562666f726d223b733a373a227061636b616765223b733a373a22576562666f726d223b733a373a2276657273696f6e223b733a383a22372e782d332e3230223b733a373a2270726f6a656374223b733a373a22776562666f726d223b733a393a22646174657374616d70223b733a31303a2231333932313832333035223b733a31363a225f696e666f5f66696c655f6374696d65223b693a313430323939323630313b7d733a393a22646174657374616d70223b733a31303a2231333932313832333035223b733a383a22696e636c75646573223b613a313a7b733a373a22776562666f726d223b733a373a22576562666f726d223b7d733a31323a2270726f6a6563745f74797065223b733a363a226d6f64756c65223b733a31343a2270726f6a6563745f737461747573223b623a313b733a31303a227375625f7468656d6573223b613a303a7b7d733a31313a22626173655f7468656d6573223b613a303a7b7d7d, 0, 1404392651);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `quicktabs`
--

DROP TABLE IF EXISTS `quicktabs`;
CREATE TABLE `quicktabs` (
  `machine_name` varchar(255) NOT NULL COMMENT 'The primary identifier for a qt block.',
  `ajax` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Whether this is an ajax views block.',
  `hide_empty_tabs` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Whether this tabset hides empty tabs.',
  `default_tab` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Default tab.',
  `title` varchar(255) NOT NULL COMMENT 'The title of this quicktabs block.',
  `tabs` mediumtext NOT NULL COMMENT 'A serialized array of the contents of this qt block.',
  `renderer` varchar(255) NOT NULL COMMENT 'The rendering mechanism.',
  `style` varchar(255) NOT NULL COMMENT 'The tab style.',
  `options` mediumtext COMMENT 'A serialized array of the options for this qt instance.',
  PRIMARY KEY (`machine_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='The quicktabs table.';

--
-- Άδειασμα δεδομένων του πίνακα `quicktabs`
--

INSERT INTO `quicktabs` (`machine_name`, `ajax`, `hide_empty_tabs`, `default_tab`, `title`, `tabs`, `renderer`, `style`, `options`) VALUES
('sidebar_tabs', 0, 0, 0, 'Sidebar tabs', 'a:3:{i:0;a:5:{s:3:"bid";s:27:"views_delta_mt_latest-block";s:10:"hide_title";i:1;s:5:"title";s:6:"Latest";s:6:"weight";s:4:"-100";s:4:"type";s:5:"block";}i:1;a:5:{s:3:"bid";s:35:"views_delta_mt_most_popular-block_1";s:10:"hide_title";i:1;s:5:"title";s:7:"Popular";s:6:"weight";s:3:"-99";s:4:"type";s:5:"block";}i:2;a:5:{s:3:"bid";s:25:"views_delta_archive-block";s:10:"hide_title";i:1;s:5:"title";s:7:"Archive";s:6:"weight";s:3:"-98";s:4:"type";s:5:"block";}}', 'quicktabs', 'nostyle', 'a:0:{}');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `rdf_mapping`
--

DROP TABLE IF EXISTS `rdf_mapping`;
CREATE TABLE `rdf_mapping` (
  `type` varchar(128) NOT NULL COMMENT 'The name of the entity type a mapping applies to (node, user, comment, etc.).',
  `bundle` varchar(128) NOT NULL COMMENT 'The name of the bundle a mapping applies to.',
  `mapping` longblob COMMENT 'The serialized mapping of the bundle type and fields to RDF terms.',
  PRIMARY KEY (`type`,`bundle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores custom RDF mappings for user defined content types...';

--
-- Άδειασμα δεδομένων του πίνακα `rdf_mapping`
--

INSERT INTO `rdf_mapping` (`type`, `bundle`, `mapping`) VALUES
('node', 'article', 0x613a31313a7b733a31313a226669656c645f696d616765223b613a323a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a383a226f673a696d616765223b693a313b733a31323a22726466733a736565416c736f223b7d733a343a2274797065223b733a333a2272656c223b7d733a31303a226669656c645f74616773223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31303a2264633a7375626a656374223b7d733a343a2274797065223b733a333a2272656c223b7d733a373a2272646674797065223b613a323a7b693a303b733a393a2273696f633a4974656d223b693a313b733a31333a22666f61663a446f63756d656e74223b7d733a353a227469746c65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a383a2264633a7469746c65223b7d7d733a373a2263726561746564223b613a333a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a373a2264633a64617465223b693a313b733a31303a2264633a63726561746564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a373a226368616e676564223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31313a2264633a6d6f646966696564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a343a22626f6479223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31353a22636f6e74656e743a656e636f646564223b7d7d733a333a22756964223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6861735f63726561746f72223b7d733a343a2274797065223b733a333a2272656c223b7d733a343a226e616d65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a393a22666f61663a6e616d65223b7d7d733a31333a22636f6d6d656e745f636f756e74223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6e756d5f7265706c696573223b7d733a383a226461746174797065223b733a31313a227873643a696e7465676572223b7d733a31333a226c6173745f6163746976697479223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a32333a2273696f633a6c6173745f61637469766974795f64617465223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d7d),
('node', 'blog', 0x613a393a7b733a373a2272646674797065223b613a323a7b693a303b733a393a2273696f633a506f7374223b693a313b733a31343a2273696f63743a426c6f67506f7374223b7d733a353a227469746c65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a383a2264633a7469746c65223b7d7d733a373a2263726561746564223b613a333a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a373a2264633a64617465223b693a313b733a31303a2264633a63726561746564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a373a226368616e676564223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31313a2264633a6d6f646966696564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a343a22626f6479223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31353a22636f6e74656e743a656e636f646564223b7d7d733a333a22756964223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6861735f63726561746f72223b7d733a343a2274797065223b733a333a2272656c223b7d733a343a226e616d65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a393a22666f61663a6e616d65223b7d7d733a31333a22636f6d6d656e745f636f756e74223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6e756d5f7265706c696573223b7d733a383a226461746174797065223b733a31313a227873643a696e7465676572223b7d733a31333a226c6173745f6163746976697479223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a32333a2273696f633a6c6173745f61637469766974795f64617465223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d7d),
('node', 'page', 0x613a393a7b733a373a2272646674797065223b613a313a7b693a303b733a31333a22666f61663a446f63756d656e74223b7d733a353a227469746c65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a383a2264633a7469746c65223b7d7d733a373a2263726561746564223b613a333a7b733a31303a2270726564696361746573223b613a323a7b693a303b733a373a2264633a64617465223b693a313b733a31303a2264633a63726561746564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a373a226368616e676564223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31313a2264633a6d6f646966696564223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d733a343a22626f6479223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31353a22636f6e74656e743a656e636f646564223b7d7d733a333a22756964223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6861735f63726561746f72223b7d733a343a2274797065223b733a333a2272656c223b7d733a343a226e616d65223b613a313a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a393a22666f61663a6e616d65223b7d7d733a31333a22636f6d6d656e745f636f756e74223b613a323a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a31363a2273696f633a6e756d5f7265706c696573223b7d733a383a226461746174797065223b733a31313a227873643a696e7465676572223b7d733a31333a226c6173745f6163746976697479223b613a333a7b733a31303a2270726564696361746573223b613a313a7b693a303b733a32333a2273696f633a6c6173745f61637469766974795f64617465223b7d733a383a226461746174797065223b733a31323a227873643a6461746554696d65223b733a383a2263616c6c6261636b223b733a31323a22646174655f69736f38363031223b7d7d);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `role`
--

DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `rid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique role ID.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'Unique role name.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this role in listings and the user interface.',
  PRIMARY KEY (`rid`),
  UNIQUE KEY `name` (`name`),
  KEY `name_weight` (`name`,`weight`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores user roles.' AUTO_INCREMENT=4 ;

--
-- Άδειασμα δεδομένων του πίνακα `role`
--

INSERT INTO `role` (`rid`, `name`, `weight`) VALUES
(3, 'administrator', 2),
(1, 'anonymous user', 0),
(2, 'authenticated user', 1);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `role_permission`
--

DROP TABLE IF EXISTS `role_permission`;
CREATE TABLE `role_permission` (
  `rid` int(10) unsigned NOT NULL COMMENT 'Foreign Key: role.rid.',
  `permission` varchar(128) NOT NULL DEFAULT '' COMMENT 'A single permission granted to the role identified by rid.',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module declaring the permission.',
  PRIMARY KEY (`rid`,`permission`),
  KEY `permission` (`permission`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the permissions assigned to user roles.';

--
-- Άδειασμα δεδομένων του πίνακα `role_permission`
--

INSERT INTO `role_permission` (`rid`, `permission`, `module`) VALUES
(1, 'access comments', 'comment'),
(1, 'access content', 'node'),
(1, 'access user profiles', 'user'),
(1, 'search content', 'search'),
(1, 'use advanced search', 'search'),
(1, 'use text format filtered_html', 'filter'),
(2, 'access comments', 'comment'),
(2, 'access content', 'node'),
(2, 'access overlay', 'overlay'),
(2, 'access toolbar', 'toolbar'),
(2, 'access user profiles', 'user'),
(2, 'post comments', 'comment'),
(2, 'search content', 'search'),
(2, 'skip comment approval', 'comment'),
(2, 'use advanced search', 'search'),
(2, 'use text format filtered_html', 'filter'),
(2, 'view the administration theme', 'system'),
(3, 'access administration pages', 'system'),
(3, 'access all views', 'views'),
(3, 'access all webform results', 'webform'),
(3, 'access comments', 'comment'),
(3, 'access content', 'node'),
(3, 'access content overview', 'node'),
(3, 'access contextual links', 'contextual'),
(3, 'access dashboard', 'dashboard'),
(3, 'access overlay', 'overlay'),
(3, 'access own authorizations', 'oauth_common'),
(3, 'access own consumers', 'oauth_common'),
(3, 'access own webform results', 'webform'),
(3, 'access own webform submissions', 'webform'),
(3, 'access site in maintenance mode', 'system'),
(3, 'access site reports', 'system'),
(3, 'access statistics', 'statistics'),
(3, 'access toolbar', 'toolbar'),
(3, 'access user profiles', 'user'),
(3, 'add authenticated twitter accounts', 'twitter'),
(3, 'add twitter accounts', 'twitter'),
(3, 'administer actions', 'system'),
(3, 'administer blocks', 'block'),
(3, 'administer comments', 'comment'),
(3, 'administer consumers', 'oauth_common'),
(3, 'administer content types', 'node'),
(3, 'administer filters', 'filter'),
(3, 'administer image styles', 'image'),
(3, 'administer menu', 'menu'),
(3, 'administer modules', 'system'),
(3, 'administer nodes', 'node'),
(3, 'administer oauth', 'oauth_common'),
(3, 'administer permissions', 'user'),
(3, 'administer quicktabs', 'quicktabs'),
(3, 'administer search', 'search'),
(3, 'administer shortcuts', 'shortcut'),
(3, 'administer site configuration', 'system'),
(3, 'administer software updates', 'system'),
(3, 'administer statistics', 'statistics'),
(3, 'administer superfish', 'superfish'),
(3, 'administer taxonomy', 'taxonomy'),
(3, 'administer themes', 'system'),
(3, 'administer twitter accounts', 'twitter'),
(3, 'administer url aliases', 'path'),
(3, 'administer users', 'user'),
(3, 'administer views', 'views'),
(3, 'block IP addresses', 'system'),
(3, 'bypass node access', 'node'),
(3, 'cancel account', 'user'),
(3, 'change own username', 'user'),
(3, 'create article content', 'node'),
(3, 'create page content', 'node'),
(3, 'create url aliases', 'path'),
(3, 'customize shortcut links', 'shortcut'),
(3, 'delete all webform submissions', 'webform'),
(3, 'delete any article content', 'node'),
(3, 'delete any page content', 'node'),
(3, 'delete own article content', 'node'),
(3, 'delete own page content', 'node'),
(3, 'delete own webform submissions', 'webform'),
(3, 'delete revisions', 'node'),
(3, 'delete terms in 1', 'taxonomy'),
(3, 'edit all webform submissions', 'webform'),
(3, 'edit any article content', 'node'),
(3, 'edit any page content', 'node'),
(3, 'edit own article content', 'node'),
(3, 'edit own comments', 'comment'),
(3, 'edit own page content', 'node'),
(3, 'edit own webform submissions', 'webform'),
(3, 'edit terms in 1', 'taxonomy'),
(3, 'oauth authorize any consumers', 'oauth_common'),
(3, 'oauth register any consumers', 'oauth_common'),
(3, 'post comments', 'comment'),
(3, 'revert revisions', 'node'),
(3, 'search content', 'search'),
(3, 'select account cancellation method', 'user'),
(3, 'skip comment approval', 'comment'),
(3, 'switch shortcut sets', 'shortcut'),
(3, 'use advanced search', 'search'),
(3, 'use bulk exporter', 'bulk_export'),
(3, 'use PHP for settings', 'php'),
(3, 'use text format filtered_html', 'filter'),
(3, 'use text format full_html', 'filter'),
(3, 'view own unpublished content', 'node'),
(3, 'view post access counter', 'statistics'),
(3, 'view revisions', 'node'),
(3, 'view the administration theme', 'system');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `semaphore`
--

DROP TABLE IF EXISTS `semaphore`;
CREATE TABLE `semaphore` (
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Primary Key: Unique name.',
  `value` varchar(255) NOT NULL DEFAULT '' COMMENT 'A value for the semaphore.',
  `expire` double NOT NULL COMMENT 'A Unix timestamp with microseconds indicating when the semaphore should expire.',
  PRIMARY KEY (`name`),
  KEY `value` (`value`),
  KEY `expire` (`expire`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for holding semaphores, locks, flags, etc. that...';

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `sequences`
--

DROP TABLE IF EXISTS `sequences`;
CREATE TABLE `sequences` (
  `value` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The value of the sequence.',
  PRIMARY KEY (`value`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores IDs.' AUTO_INCREMENT=6 ;

--
-- Άδειασμα δεδομένων του πίνακα `sequences`
--

INSERT INTO `sequences` (`value`) VALUES
(5);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `shortcut_set`
--

DROP TABLE IF EXISTS `shortcut_set`;
CREATE TABLE `shortcut_set` (
  `set_name` varchar(32) NOT NULL DEFAULT '' COMMENT 'Primary Key: The menu_links.menu_name under which the set’s links are stored.',
  `title` varchar(255) NOT NULL DEFAULT '' COMMENT 'The title of the set.',
  PRIMARY KEY (`set_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about sets of shortcuts links.';

--
-- Άδειασμα δεδομένων του πίνακα `shortcut_set`
--

INSERT INTO `shortcut_set` (`set_name`, `title`) VALUES
('shortcut-set-1', 'Default');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `taxonomy_index`
--

DROP TABLE IF EXISTS `taxonomy_index`;
CREATE TABLE `taxonomy_index` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node.nid this record tracks.',
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The term ID.',
  `sticky` tinyint(4) DEFAULT '0' COMMENT 'Boolean indicating whether the node is sticky.',
  `created` int(11) NOT NULL DEFAULT '0' COMMENT 'The Unix timestamp when the node was created.',
  KEY `term_node` (`tid`,`sticky`,`created`),
  KEY `nid` (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Maintains denormalized information about node/term...';

--
-- Άδειασμα δεδομένων του πίνακα `taxonomy_index`
--

INSERT INTO `taxonomy_index` (`nid`, `tid`, `sticky`, `created`) VALUES
(4, 6, 1, 1400661788),
(4, 7, 1, 1400661788),
(4, 10, 1, 1400661788),
(4, 11, 1, 1400661788),
(5, 4, 0, 1398069748),
(5, 8, 0, 1398069748),
(5, 9, 0, 1398069748),
(5, 10, 0, 1398069748),
(12, 1, 0, 1377074122),
(12, 7, 0, 1377074122),
(12, 8, 0, 1377074122),
(12, 9, 0, 1377074122),
(12, 10, 0, 1377074122),
(12, 11, 0, 1377074122),
(10, 6, 0, 1382344622),
(10, 7, 0, 1382344622),
(10, 10, 0, 1382344622),
(10, 11, 0, 1382344622),
(9, 5, 0, 1385023091),
(9, 8, 0, 1385023091),
(9, 9, 0, 1385023091),
(9, 10, 0, 1385023091),
(9, 11, 0, 1385023091),
(7, 2, 0, 1392972022),
(7, 7, 0, 1392972022),
(7, 8, 0, 1392972022),
(7, 9, 0, 1392972022),
(7, 10, 0, 1392972022),
(6, 1, 0, 1395391290),
(6, 7, 0, 1395391290),
(6, 8, 0, 1395391290),
(6, 11, 0, 1395391290),
(8, 3, 0, 1390293573),
(8, 10, 0, 1390293573),
(8, 11, 0, 1390293573),
(1, 2, 1, 1402994826),
(1, 7, 1, 1402994826),
(1, 8, 1, 1402994826),
(1, 9, 1, 1402994826),
(3, 5, 1, 1400661889),
(3, 7, 1, 1400661889),
(3, 9, 1, 1400661889),
(11, 4, 0, 1379752566),
(11, 8, 0, 1379752566),
(11, 9, 0, 1379752566),
(11, 11, 0, 1379752566),
(2, 3, 1, 1402994717),
(2, 7, 1, 1402994717),
(2, 8, 1, 1402994717),
(2, 9, 1, 1402994717);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `taxonomy_term_data`
--

DROP TABLE IF EXISTS `taxonomy_term_data`;
CREATE TABLE `taxonomy_term_data` (
  `tid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique term ID.',
  `vid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The taxonomy_vocabulary.vid of the vocabulary to which the term is assigned.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The term name.',
  `description` longtext COMMENT 'A description of the term.',
  `format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the description.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this term in relation to other terms.',
  PRIMARY KEY (`tid`),
  KEY `taxonomy_tree` (`vid`,`weight`,`name`),
  KEY `vid_name` (`vid`,`name`),
  KEY `name` (`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores term information.' AUTO_INCREMENT=12 ;

--
-- Άδειασμα δεδομένων του πίνακα `taxonomy_term_data`
--

INSERT INTO `taxonomy_term_data` (`tid`, `vid`, `name`, `description`, `format`, `weight`) VALUES
(1, 2, 'World', '', 'filtered_html', 0),
(2, 2, 'Finance', '', 'filtered_html', 0),
(3, 2, 'Health', '', 'filtered_html', 0),
(4, 2, 'Tech', '', 'filtered_html', 0),
(5, 2, 'Lifestyle', '', 'filtered_html', 0),
(6, 2, 'Sports', '', 'filtered_html', 0),
(7, 1, 'Tag1', NULL, NULL, 0),
(8, 1, 'Long Tag2', NULL, NULL, 0),
(9, 1, 'Very Long Tag3', NULL, NULL, 0),
(10, 1, 'Tag4', NULL, NULL, 0),
(11, 1, 'Long Tag5', NULL, NULL, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `taxonomy_term_hierarchy`
--

DROP TABLE IF EXISTS `taxonomy_term_hierarchy`;
CREATE TABLE `taxonomy_term_hierarchy` (
  `tid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term.',
  `parent` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Primary Key: The taxonomy_term_data.tid of the term’s parent. 0 indicates no parent.',
  PRIMARY KEY (`tid`,`parent`),
  KEY `parent` (`parent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores the hierarchical relationship between terms.';

--
-- Άδειασμα δεδομένων του πίνακα `taxonomy_term_hierarchy`
--

INSERT INTO `taxonomy_term_hierarchy` (`tid`, `parent`) VALUES
(1, 0),
(2, 0),
(3, 0),
(4, 0),
(5, 0),
(6, 0),
(7, 0),
(8, 0),
(9, 0),
(10, 0),
(11, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `taxonomy_vocabulary`
--

DROP TABLE IF EXISTS `taxonomy_vocabulary`;
CREATE TABLE `taxonomy_vocabulary` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'Primary Key: Unique vocabulary ID.',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Name of the vocabulary.',
  `machine_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'The vocabulary machine name.',
  `description` longtext COMMENT 'Description of the vocabulary.',
  `hierarchy` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'The type of hierarchy allowed within the vocabulary. (0 = disabled, 1 = single, 2 = multiple)',
  `module` varchar(255) NOT NULL DEFAULT '' COMMENT 'The module which created the vocabulary.',
  `weight` int(11) NOT NULL DEFAULT '0' COMMENT 'The weight of this vocabulary in relation to other vocabularies.',
  PRIMARY KEY (`vid`),
  UNIQUE KEY `machine_name` (`machine_name`),
  KEY `list` (`weight`,`name`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='Stores vocabulary information.' AUTO_INCREMENT=3 ;

--
-- Άδειασμα δεδομένων του πίνακα `taxonomy_vocabulary`
--

INSERT INTO `taxonomy_vocabulary` (`vid`, `name`, `machine_name`, `description`, `hierarchy`, `module`, `weight`) VALUES
(1, 'Tags', 'tags', 'Use tags to group articles on similar topics into categories.', 0, 'taxonomy', 0),
(2, 'Post Categories', 'mt_post_categories', '', 0, 'taxonomy', 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `twitter`
--

DROP TABLE IF EXISTS `twitter`;
CREATE TABLE `twitter` (
  `twitter_id` decimal(20,0) unsigned NOT NULL DEFAULT '0' COMMENT 'Unique identifier for each twitter post.',
  `screen_name` varchar(255) NOT NULL DEFAULT '' COMMENT 'Screen Name of the twitter_account user.',
  `created_at` varchar(64) NOT NULL DEFAULT '' COMMENT 'Date and time the twitter post was created.',
  `created_time` int(11) NOT NULL COMMENT 'A duplicate of twitter.created_at in UNIX timestamp format.',
  `text` varchar(255) DEFAULT NULL COMMENT 'The text of the twitter post.',
  `source` varchar(255) DEFAULT NULL COMMENT 'The application that created the twitter post.',
  `in_reply_to_status_id` decimal(20,0) unsigned DEFAULT NULL COMMENT 'Unique identifier of a status this twitter post was replying to.',
  `in_reply_to_user_id` decimal(20,0) unsigned DEFAULT NULL COMMENT 'Unique identifier for the twitter_account this post was replying to.',
  `in_reply_to_screen_name` varchar(255) DEFAULT NULL COMMENT 'Screen name of the twitter user this post was replying to.',
  `truncated` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating whether the twitter status was cut off to fit in the 140 character limit.',
  PRIMARY KEY (`twitter_id`),
  KEY `screen_name` (`screen_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores individual Twitter posts.';

--
-- Άδειασμα δεδομένων του πίνακα `twitter`
--

INSERT INTO `twitter` (`twitter_id`, `screen_name`, `created_at`, `created_time`, `text`, `source`, `in_reply_to_status_id`, `in_reply_to_user_id`, `in_reply_to_screen_name`, `truncated`) VALUES
(479232308579680256, 'morethanthemes', '', 1403092860, 'An awesome #Drupal #theme should feature great typography http://t.co/Emz5N3ZKFY', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(479307602002980864, 'morethanthemes', '', 1403110812, 'A good #theme is also about good typography. Which is why our #Bootstrap Business for #D8 comes with #Firasans http://t.co/NE4Mbut3TV', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(479594720864534530, 'morethanthemes', '', 1403179266, 'A state-of-the-art responsive #Drupal theme should provide navigation flexibility when on mobile devices - http://t.co/Bs7cIfAc2b', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(479670094578999297, 'morethanthemes', '', 1403197237, 'Why #Drupal? Because It Will Help You Win | Acquia http://t.co/pDuhYZi7U7', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(479956858980282369, 'morethanthemes', '', 1403265607, '50 Extensions and Plugins for Extending #Bootstrap http://t.co/xO3rX6Scnx', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(479970043942666240, 'morethanthemes', '', 1403268750, 'RT @edermiranda: @morethanthemes has the best service support for Drupal ever. Premium Drupal Themes More Than Themes: http://t.co/opW1aQB1…', '<a href="https://about.twitter.com/products/tweetdeck" rel="nofollow">TweetDeck</a>', NULL, 0, NULL, 0),
(480032596471345152, 'morethanthemes', '', 1403283664, 'An awesome selection of Hover Effect Ideas http://t.co/eyTK2XPT7h #webdesign #webdev', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(480319322888212480, 'morethanthemes', '', 1403352025, 'Faster UI Animations With Velocity.js by @smashingmag http://t.co/PUy4FDibTT #webdesign #webdev #js', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(480394943006244865, 'morethanthemes', '', 1403370054, '#CSS Framework Cute Grids: Highly Flexible Grid System for #Responsive Layouts - noupe http://t.co/D7gV7QiNbN #webdev #webdesign', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(481044101790720000, 'morethanthemes', '', 1403524825, 'bounce.js lets you create tasty #CSS3 powered animations in no time. http://t.co/jkkZQhkvFs', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(481119676265934848, 'morethanthemes', '', 1403542844, 'Securing Your #Drupal Site: advice for site builders and coders http://t.co/e3YClyg6lX #webdev', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(481406497155739648, 'morethanthemes', '', 1403611227, 'Using our Best Brand theme for your #Drupal site? A new, as always FREE update is here. :) Get in touch to get it http://t.co/0FTXGk8Wq3.', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(481482211519397888, 'morethanthemes', '', 1403629279, 'Zoomerang.js, a drop-in library that allows users to zoom in on (almost) any element on your existing page http://t.co/z27YYu8Cyu #js', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(481768925035003904, 'morethanthemes', '', 1403697637, 'Scheduling content in #Drupal 7 using the #Scheduler #module - YouTube http://t.co/I60h0YqQmw #webdev', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(481814292610969600, 'morethanthemes', '', 1403708453, '#Drupal for non-profits; Wilderness Society Stewardship and their use of Drupal and our Chique theme http://t.co/znwWNn1n6C', '<a href="http://www.tumblr.com/" rel="nofollow">Tumblr</a>', NULL, 0, NULL, 0),
(481844410184105986, 'morethanthemes', '', 1403715634, 'Prefilling Forms with a Custom Bookmarklet, by @Real_CSS_Tricks http://t.co/B4SMG8ECmY #webdev', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(482131234709991424, 'morethanthemes', '', 1403784018, 'The ultimate guide to email design http://t.co/m2LQ54EVU8', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(482206756844896257, 'morethanthemes', '', 1403802024, 'Get Better Results With User Testing – Why, When, What and How, by @lullabot\n| #DrupalCon Austin 2014 http://t.co/ImduOBG4Et', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(482493614459994113, 'morethanthemes', '', 1403870416, '#Bootstrap responsive utilities http://t.co/mgoFQPpu48 #CSS', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(482569247017553920, 'morethanthemes', '', 1403888448, 'Side Comments - http://t.co/TVUQ7J5U6c style commenting using #js http://t.co/vrAgZlAylG #javascript', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(482856022319833089, 'morethanthemes', '', 1403956821, '(Awesome!) Ideas for Subtle Hover Effects by @Codrops http://t.co/9nTSGiPttt #CSS #webdesign #webdev', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(482931494050988033, 'morethanthemes', '', 1403974815, 'Dynamically change #Bootstrap Progress Bar value when checkboxes are checked - #JSFiddle http://t.co/L3udsmmZrb', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(483218368737337345, 'morethanthemes', '', 1404043211, 'The Eight Most Common Mistakes Made on #UX Design Projects | UX Magazine http://t.co/LDP3ZZN3Sc', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(483293905161818113, 'morethanthemes', '', 1404061220, 'Why is Symfony in #Drupal 8, and how Does that Change Things? - http://t.co/gNm8CXAkr0', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(483580761015353344, 'morethanthemes', '', 1404129612, '#Drupal for non-profits; the case of Wilderness Society Stewardship, their use of #Drupal and our Chique theme - http://t.co/81ZmSKCKnH', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(483656375055052800, 'morethanthemes', '', 1404147640, 'In case you missed it: our free #Drupal #theme #Bootstrap Business for #D8 http://t.co/cIzIku3ufj', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(483943203385536512, 'morethanthemes', '', 1404216025, 'How to deal with product variations and #DrupalCommerce? http://t.co/RnK3nDnGls', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(484018645459550208, 'morethanthemes', '', 1404234012, 'Our #Startup Growth #Drupal #theme, is a feature-packed asset that you will use over and over again http://t.co/7BZv5mDFjg', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(484305686629986304, 'morethanthemes', '', 1404302448, 'A powerful #Drupal #theme to power your #education oriented website http://t.co/fvwRUSNPc5', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(484350922282512384, 'morethanthemes', '', 1404313233, 'How to update the Font Awesome web font in your #Drupal site http://t.co/yMXw6jjfQc', '<a href="http://www.tumblr.com/" rel="nofollow">Tumblr</a>', NULL, 0, NULL, 0),
(484381100937334784, 'morethanthemes', '', 1404320428, '30 Amazing Examples of Loading Bar Designs for Your Inspiration http://t.co/KRWBoar3is #css #js #webdesign', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0),
(484668142279737345, 'morethanthemes', '', 1404388864, 'Using Encapsulation for Semantic Markup, by @Real_CSS_Tricks http://t.co/tEUUOs5xNc #CSS #webdev', '<a href="http://bufferapp.com" rel="nofollow">Buffer</a>', NULL, 0, NULL, 0);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `twitter_account`
--

DROP TABLE IF EXISTS `twitter_account`;
CREATE TABLE `twitter_account` (
  `twitter_uid` decimal(20,0) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier of the twitter_account.',
  `host` varchar(255) DEFAULT NULL COMMENT 'The host for this account can be a laconi.ca instance',
  `screen_name` varchar(255) DEFAULT NULL COMMENT 'The unique login name of the twitter_account user.',
  `oauth_token` varchar(64) DEFAULT NULL COMMENT 'The token_key for oauth-based access.',
  `oauth_token_secret` varchar(64) DEFAULT NULL COMMENT 'The token_secret for oauth-based access.',
  `name` varchar(64) NOT NULL DEFAULT '' COMMENT 'The full name of the twitter_account user.',
  `description` varchar(255) DEFAULT NULL COMMENT 'The description/biography associated with the twitter_account.',
  `location` varchar(255) DEFAULT NULL COMMENT 'The location of the twitter_account’s owner.',
  `followers_count` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of users following this twitter_account.',
  `friends_count` int(11) NOT NULL DEFAULT '0' COMMENT 'The number of users this twitter_account is following.',
  `statuses_count` int(11) NOT NULL DEFAULT '0' COMMENT 'The total number of status updates performed by a user, excluding direct messages sent.',
  `favourites_count` int(11) NOT NULL DEFAULT '0' COMMENT 'The  number of statuses a user has marked as favorite.',
  `url` varchar(255) DEFAULT NULL COMMENT 'The url of the twitter_account’s home page.',
  `profile_image_url` varchar(255) DEFAULT NULL COMMENT 'The url of the twitter_account’s profile image.',
  `protected` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating whether the twitter_account’s posts are publicly accessible.',
  `profile_background_color` varchar(6) NOT NULL DEFAULT '' COMMENT 'hex RGB value for a user’s background color',
  `profile_text_color` varchar(6) NOT NULL DEFAULT '' COMMENT 'hex RGB value for a user’s text color',
  `profile_link_color` varchar(6) NOT NULL DEFAULT '' COMMENT 'hex RGB value for a user’s link color',
  `profile_sidebar_fill_color` varchar(6) NOT NULL DEFAULT '' COMMENT 'hex RGB value for a user’s sidebar color',
  `profile_sidebar_border_color` varchar(6) NOT NULL DEFAULT '' COMMENT 'hex RGB value for a user’s border color',
  `profile_background_image_url` varchar(255) DEFAULT NULL COMMENT 'The url of the twitter_account’s profile image.',
  `profile_background_tile` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Boolean indicating if a user’s background is tiled.',
  `verified` int(10) unsigned NOT NULL DEFAULT '1' COMMENT 'Indicates if a user is verified.',
  `created_at` varchar(64) NOT NULL DEFAULT '' COMMENT 'Date and time the twitter_account was created.',
  `created_time` int(11) NOT NULL COMMENT 'A duplicate of twitter_account.created_at in UNIX timestamp format.',
  `utc_offset` int(11) NOT NULL COMMENT 'A duplicate of twitter_account.created_at in UNIX timestamp format.',
  `import` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating whether the twitter_user’s posts should be pulled in by the site.',
  `mentions` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating whether the twitter_user’s mentions should be pulled in by the site.',
  `last_refresh` int(11) NOT NULL DEFAULT '0' COMMENT 'A UNIX timestamp marking the date Twitter statuses were last fetched on.',
  `is_global` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Boolean flag indicating if this account is available for global use.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The uid of the user who added this Twitter account.',
  PRIMARY KEY (`twitter_uid`),
  KEY `screen_name` (`screen_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information on specific Twitter user accounts.';

--
-- Άδειασμα δεδομένων του πίνακα `twitter_account`
--

INSERT INTO `twitter_account` (`twitter_uid`, `host`, `screen_name`, `oauth_token`, `oauth_token_secret`, `name`, `description`, `location`, `followers_count`, `friends_count`, `statuses_count`, `favourites_count`, `url`, `profile_image_url`, `protected`, `profile_background_color`, `profile_text_color`, `profile_link_color`, `profile_sidebar_fill_color`, `profile_sidebar_border_color`, `profile_background_image_url`, `profile_background_tile`, `verified`, `created_at`, `created_time`, `utc_offset`, `import`, `mentions`, `last_refresh`, `is_global`, `uid`) VALUES
(217204926, NULL, 'morethanthemes', '217204926-yCZR8eZgKX3QnA0KndxvqxqexnnzC3JxGUm8rGZR', '9QWwLKV0OfWCYLm8V7lGk64TGyohv5f6gTWTMAFEJeU', 'morethanthemes', 'Creators of some of the best Premium Drupal themes around. Leads of some of the best Free too. Tweeting about Drupal and all things web design & development.', 'All over the web.', 694, 250, 2513, 40, 'http://t.co/RvYrlMsuhh', 'http://pbs.twimg.com/profile_images/3699201333/0e5f99e9cbb483cba6e6b6cfc843660e_normal.jpeg', 0, 'B2DFDA', '333333', '448CA6', 'F0FAFF', 'EEEEEE', 'http://pbs.twimg.com/profile_background_images/221997761/2011-03-24_16-34-10.png', 1, 0, 'Thu Nov 18 21:38:21 +0000 2010', 1290116301, 10800, 1, 0, 1404391762, 0, 1);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `url_alias`
--

DROP TABLE IF EXISTS `url_alias`;
CREATE TABLE `url_alias` (
  `pid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'A unique path alias identifier.',
  `source` varchar(255) NOT NULL DEFAULT '' COMMENT 'The Drupal path this alias is for; e.g. node/12.',
  `alias` varchar(255) NOT NULL DEFAULT '' COMMENT 'The alias for this path; e.g. title-of-the-story.',
  `language` varchar(12) NOT NULL DEFAULT '' COMMENT 'The language this alias is for; if ’und’, the alias will be used for unknown languages. Each Drupal path can have an alias for each supported language.',
  PRIMARY KEY (`pid`),
  KEY `alias_language_pid` (`alias`,`language`,`pid`),
  KEY `source_language_pid` (`source`,`language`,`pid`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COMMENT='A list of URL aliases for Drupal paths; a user may visit...' AUTO_INCREMENT=2 ;

--
-- Άδειασμα δεδομένων του πίνακα `url_alias`
--

INSERT INTO `url_alias` (`pid`, `source`, `alias`, `language`) VALUES
(1, 'node/13', 'contact-us', 'und');

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `variable`
--

DROP TABLE IF EXISTS `variable`;
CREATE TABLE `variable` (
  `name` varchar(128) NOT NULL DEFAULT '' COMMENT 'The name of the variable.',
  `value` longblob NOT NULL COMMENT 'The value of the variable.',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Named variable/value pairs created by Drupal core or any...';

--
-- Άδειασμα δεδομένων του πίνακα `variable`
--

INSERT INTO `variable` (`name`, `value`) VALUES
('additional_settings__active_tab_blog', 0x733a31323a22656469742d646973706c6179223b),
('additional_settings__active_tab_mt_post', 0x733a31323a22656469742d646973706c6179223b),
('additional_settings__active_tab_mt_slideshow_entry', 0x733a31323a22656469742d636f6d6d656e74223b),
('additional_settings__active_tab_webform', 0x733a31323a22656469742d636f6d6d656e74223b),
('admin_theme', 0x733a353a22736576656e223b),
('anonymous', 0x733a393a22416e6f6e796d6f7573223b),
('clean_url', 0x693a303b),
('comment_anonymous_blog', 0x693a303b),
('comment_anonymous_mt_post', 0x693a303b),
('comment_anonymous_mt_slideshow_entry', 0x693a303b),
('comment_anonymous_webform', 0x693a303b),
('comment_blog', 0x733a313a2232223b),
('comment_default_mode_blog', 0x693a313b),
('comment_default_mode_mt_post', 0x693a313b),
('comment_default_mode_mt_slideshow_entry', 0x693a313b),
('comment_default_mode_webform', 0x693a313b),
('comment_default_per_page_blog', 0x733a323a223530223b),
('comment_default_per_page_mt_post', 0x733a323a223530223b),
('comment_default_per_page_mt_slideshow_entry', 0x733a323a223530223b),
('comment_default_per_page_webform', 0x733a323a223530223b),
('comment_form_location_blog', 0x693a313b),
('comment_form_location_mt_post', 0x693a313b),
('comment_form_location_mt_slideshow_entry', 0x693a313b),
('comment_form_location_webform', 0x693a313b),
('comment_mt_post', 0x733a313a2232223b),
('comment_mt_slideshow_entry', 0x733a313a2231223b),
('comment_page', 0x693a303b),
('comment_preview_blog', 0x733a313a2231223b),
('comment_preview_mt_post', 0x733a313a2231223b),
('comment_preview_mt_slideshow_entry', 0x733a313a2231223b),
('comment_preview_webform', 0x733a313a2231223b),
('comment_subject_field_blog', 0x693a313b),
('comment_subject_field_mt_post', 0x693a313b),
('comment_subject_field_mt_slideshow_entry', 0x693a313b),
('comment_subject_field_webform', 0x693a313b),
('comment_webform', 0x733a313a2231223b),
('cron_key', 0x733a34333a226f57753531572d694c6a313676646a4f6a4959787756325662514a587468516571454161596a3439367641223b),
('cron_last', 0x693a313430343339313736323b),
('css_js_query_string', 0x733a363a226e3835307068223b),
('ctools_last_cron', 0x693a313430343332323438353b),
('date_default_timezone', 0x733a31333a224575726f70652f417468656e73223b),
('default_nodes_main', 0x733a313a2235223b),
('drupal_http_request_fails', 0x623a303b),
('drupal_private_key', 0x733a34333a22556b45414464693133546f6554784b4f397649384c343255556f782d64506f7969305a4847465965443955223b),
('email__active_tab', 0x733a32343a22656469742d656d61696c2d61646d696e2d63726561746564223b),
('field_bundle_settings_node__article', 0x613a323a7b733a31303a22766965775f6d6f646573223b613a353a7b733a363a22746561736572223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a313b7d733a343a2266756c6c223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a333a22727373223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a31323a227365617263685f696e646578223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a31333a227365617263685f726573756c74223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d7d733a31323a2265787472615f6669656c6473223b613a323a7b733a343a22666f726d223b613a313a7b733a353a227469746c65223b613a313a7b733a363a22776569676874223b733a313a2230223b7d7d733a373a22646973706c6179223b613a303a7b7d7d7d),
('field_bundle_settings_node__blog', 0x613a323a7b733a31303a22766965775f6d6f646573223b613a353a7b733a363a22746561736572223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a313b7d733a343a2266756c6c223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a333a22727373223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a31323a227365617263685f696e646578223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a31333a227365617263685f726573756c74223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d7d733a31323a2265787472615f6669656c6473223b613a323a7b733a343a22666f726d223b613a313a7b733a353a227469746c65223b613a313a7b733a363a22776569676874223b733a313a2230223b7d7d733a373a22646973706c6179223b613a303a7b7d7d7d),
('field_bundle_settings_node__mt_post', 0x613a323a7b733a31303a22766965775f6d6f646573223b613a353a7b733a363a22746561736572223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a313b7d733a343a2266756c6c223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a333a22727373223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a31323a227365617263685f696e646578223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a31333a227365617263685f726573756c74223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d7d733a31323a2265787472615f6669656c6473223b613a323a7b733a343a22666f726d223b613a313a7b733a353a227469746c65223b613a313a7b733a363a22776569676874223b733a313a2230223b7d7d733a373a22646973706c6179223b613a303a7b7d7d7d),
('field_bundle_settings_node__mt_slideshow_entry', 0x613a323a7b733a31303a22766965775f6d6f646573223b613a353a7b733a363a22746561736572223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a313b7d733a343a2266756c6c223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a333a22727373223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a31323a227365617263685f696e646578223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d733a31333a227365617263685f726573756c74223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d7d733a31323a2265787472615f6669656c6473223b613a323a7b733a343a22666f726d223b613a313a7b733a353a227469746c65223b613a313a7b733a363a22776569676874223b733a323a222d35223b7d7d733a373a22646973706c6179223b613a303a7b7d7d7d),
('field_bundle_settings_user__user', 0x613a323a7b733a31303a22766965775f6d6f646573223b613a313a7b733a343a2266756c6c223b613a313a7b733a31353a22637573746f6d5f73657474696e6773223b623a303b7d7d733a31323a2265787472615f6669656c6473223b613a323a7b733a343a22666f726d223b613a323a7b733a373a226163636f756e74223b613a313a7b733a363a22776569676874223b733a333a222d3130223b7d733a383a2274696d657a6f6e65223b613a313a7b733a363a22776569676874223b733a313a2236223b7d7d733a373a22646973706c6179223b613a313a7b733a373a2273756d6d617279223b613a313a7b733a373a2264656661756c74223b613a323a7b733a363a22776569676874223b733a313a2235223b733a373a2276697369626c65223b623a303b7d7d7d7d7d),
('file_default_scheme', 0x733a363a227075626c6963223b),
('file_private_path', 0x733a303a22223b),
('file_public_path', 0x733a31393a2273697465732f64656661756c742f66696c6573223b),
('file_temporary_path', 0x733a32333a2273697465732f64656661756c742f66696c65732f746d70223b),
('filter_fallback_format', 0x733a31303a22706c61696e5f74657874223b),
('install_profile', 0x733a383a227374616e64617264223b),
('install_task', 0x733a343a22646f6e65223b),
('install_time', 0x693a313430303538363935313b),
('jquery_update_compression_type', 0x733a333a226d696e223b),
('jquery_update_jquery_admin_version', 0x733a303a22223b),
('jquery_update_jquery_cdn', 0x733a343a226e6f6e65223b),
('jquery_update_jquery_version', 0x733a333a22312e37223b),
('maintenance_mode', 0x693a303b),
('maintenance_mode_message', 0x733a39333a224e4557532b2069732063757272656e746c7920756e646572206d61696e74656e616e63652e2057652073686f756c64206265206261636b2073686f72746c792e205468616e6b20796f7520666f7220796f75722070617469656e63652e223b),
('menu_expanded', 0x613a303a7b7d),
('menu_masks', 0x613a33383a7b693a303b693a3530313b693a313b693a3439333b693a323b693a3235303b693a333b693a3234373b693a343b693a3234363b693a353b693a3234353b693a363b693a3132353b693a373b693a3132343b693a383b693a3132333b693a393b693a3132323b693a31303b693a3132313b693a31313b693a3131373b693a31323b693a36333b693a31333b693a36323b693a31343b693a36313b693a31353b693a36303b693a31363b693a35393b693a31373b693a35383b693a31383b693a34353b693a31393b693a34343b693a32303b693a33313b693a32313b693a33303b693a32323b693a32393b693a32333b693a32383b693a32343b693a32343b693a32353b693a32323b693a32363b693a32313b693a32373b693a31353b693a32383b693a31343b693a32393b693a31333b693a33303b693a31313b693a33313b693a31303b693a33323b693a373b693a33333b693a363b693a33343b693a353b693a33353b693a333b693a33363b693a323b693a33373b693a313b7d),
('menu_options_blog', 0x613a313a7b693a303b733a393a226d61696e2d6d656e75223b7d),
('menu_options_mt_post', 0x613a313a7b693a303b733a393a226d61696e2d6d656e75223b7d),
('menu_options_mt_slideshow_entry', 0x613a313a7b693a303b733a393a226d61696e2d6d656e75223b7d),
('menu_options_webform', 0x613a313a7b693a303b733a393a226d61696e2d6d656e75223b7d),
('menu_parent_blog', 0x733a31313a226d61696e2d6d656e753a30223b),
('menu_parent_mt_post', 0x733a31313a226d61696e2d6d656e753a30223b),
('menu_parent_mt_slideshow_entry', 0x733a31313a226d61696e2d6d656e753a30223b),
('menu_parent_webform', 0x733a31313a226d61696e2d6d656e753a30223b),
('node_admin_theme', 0x693a313b),
('node_cron_last', 0x733a31303a2231343034333137393930223b),
('node_options_blog', 0x613a323a7b693a303b733a363a22737461747573223b693a313b733a373a2270726f6d6f7465223b7d),
('node_options_mt_post', 0x613a323a7b693a303b733a363a22737461747573223b693a313b733a373a2270726f6d6f7465223b7d),
('node_options_mt_slideshow_entry', 0x613a313a7b693a303b733a363a22737461747573223b7d),
('node_options_page', 0x613a313a7b693a303b733a363a22737461747573223b7d),
('node_options_webform', 0x613a313a7b693a303b733a363a22737461747573223b7d),
('node_preview_blog', 0x733a313a2231223b),
('node_preview_mt_post', 0x733a313a2231223b),
('node_preview_mt_slideshow_entry', 0x733a313a2231223b),
('node_preview_webform', 0x733a313a2231223b),
('node_submitted_blog', 0x693a303b),
('node_submitted_mt_post', 0x693a313b),
('node_submitted_mt_slideshow_entry', 0x693a303b),
('node_submitted_page', 0x623a303b),
('node_submitted_webform', 0x693a303b),
('path_alias_whitelist', 0x613a313a7b733a343a226e6f6465223b623a313b7d),
('save_continue_mt_post', 0x733a31393a225361766520616e6420616464206669656c6473223b),
('save_continue_mt_slideshow_entry', 0x733a31393a225361766520616e6420616464206669656c6473223b),
('site_403', 0x733a303a22223b),
('site_404', 0x733a303a22223b),
('site_default_country', 0x733a323a224752223b),
('site_frontpage', 0x733a343a226e6f6465223b),
('site_mail', 0x733a33343a2267656f7267652b6e657773706c7573406d6f72657468616e7468656d65732e636f6d223b),
('site_name', 0x733a353a224e4557532b223b),
('site_slogan', 0x733a34353a2241206e657773207468656d6520666f722044727570616c2c206261736564206f6e20426f6f7473747261702033223b),
('statistics_count_content_views', 0x693a313b),
('statistics_count_content_views_ajax', 0x693a303b),
('statistics_day_timestamp', 0x693a313430343332323438303b),
('statistics_enable_access_log', 0x693a303b),
('statistics_flush_accesslog_timer', 0x733a363a22323539323030223b),
('superfish_arrow_1', 0x693a303b),
('superfish_arrow_2', 0x693a303b),
('superfish_bgf_1', 0x693a303b),
('superfish_bgf_2', 0x693a303b),
('superfish_delay_1', 0x733a333a22383030223b),
('superfish_delay_2', 0x733a333a22383030223b),
('superfish_depth_1', 0x733a323a222d31223b),
('superfish_depth_2', 0x733a323a222d31223b),
('superfish_dfirstlast_1', 0x693a303b),
('superfish_dfirstlast_2', 0x693a303b),
('superfish_dzebra_1', 0x693a303b),
('superfish_dzebra_2', 0x693a303b),
('superfish_expanded_1', 0x693a303b),
('superfish_expanded_2', 0x693a303b),
('superfish_firstlast_1', 0x693a313b),
('superfish_firstlast_2', 0x693a313b),
('superfish_hhldescription_1', 0x693a303b),
('superfish_hhldescription_2', 0x693a303b),
('superfish_hid_1', 0x693a313b),
('superfish_hid_2', 0x693a313b),
('superfish_hlclass_1', 0x733a303a22223b),
('superfish_hlclass_2', 0x733a303a22223b),
('superfish_hldescription_1', 0x693a303b),
('superfish_hldescription_2', 0x693a303b),
('superfish_hldexclude_1', 0x733a303a22223b),
('superfish_hldexclude_2', 0x733a303a22223b),
('superfish_hldmenus_1', 0x733a303a22223b),
('superfish_hldmenus_2', 0x733a303a22223b),
('superfish_itemcounter_1', 0x693a313b),
('superfish_itemcounter_2', 0x693a313b),
('superfish_itemcount_1', 0x693a313b),
('superfish_itemcount_2', 0x693a313b),
('superfish_itemdepth_1', 0x693a313b),
('superfish_itemdepth_2', 0x693a313b),
('superfish_liclass_1', 0x733a303a22223b),
('superfish_liclass_2', 0x733a303a22223b),
('superfish_maxwidth_1', 0x733a323a223237223b),
('superfish_maxwidth_2', 0x733a323a223237223b),
('superfish_mcdepth_1', 0x733a313a2231223b),
('superfish_mcdepth_2', 0x733a313a2231223b),
('superfish_mcexclude_1', 0x733a303a22223b),
('superfish_mcexclude_2', 0x733a303a22223b),
('superfish_mclevels_1', 0x733a313a2231223b),
('superfish_mclevels_2', 0x733a313a2231223b),
('superfish_menu_1', 0x733a31313a226d61696e2d6d656e753a30223b),
('superfish_menu_2', 0x733a32313a226d656e752d7365636f6e646172792d6d656e753a30223b),
('superfish_minwidth_1', 0x733a323a223134223b),
('superfish_minwidth_2', 0x733a323a223134223b),
('superfish_multicolumn_1', 0x693a303b),
('superfish_multicolumn_2', 0x693a303b),
('superfish_name_1', 0x733a31313a225375706572666973682031223b),
('superfish_name_2', 0x733a31313a225375706572666973682032223b),
('superfish_number', 0x733a313a2232223b),
('superfish_pathclass_1', 0x733a31323a226163746976652d747261696c223b),
('superfish_pathclass_2', 0x733a31323a226163746976652d747261696c223b),
('superfish_pathcss_1', 0x733a303a22223b),
('superfish_pathcss_2', 0x733a303a22223b),
('superfish_pathlevels_1', 0x733a313a2231223b),
('superfish_pathlevels_2', 0x733a313a2231223b),
('superfish_shadow_1', 0x693a303b),
('superfish_shadow_2', 0x693a303b),
('superfish_slide_1', 0x733a343a226e6f6e65223b),
('superfish_slide_2', 0x733a343a226e6f6e65223b),
('superfish_slp', 0x733a3334343a2273697465732f616c6c2f6c69627261726965732f7375706572666973682f6a71756572792e686f766572496e74656e742e6d696e69666965642e6a730d0a73697465732f616c6c2f6c69627261726965732f7375706572666973682f6a71756572792e6267696672616d652e6d696e2e6a730d0a73697465732f616c6c2f6c69627261726965732f7375706572666973682f7375706572666973682e6a730d0a73697465732f616c6c2f6c69627261726965732f7375706572666973682f7375706572737562732e6a730d0a73697465732f616c6c2f6c69627261726965732f7375706572666973682f737570706f736974696f6e2e6a730d0a73697465732f616c6c2f6c69627261726965732f7375706572666973682f7366746f75636873637265656e2e6a730d0a73697465732f616c6c2f6c69627261726965732f7375706572666973682f7366736d616c6c73637265656e2e6a73223b),
('superfish_smallasa_1', 0x693a303b),
('superfish_smallasa_2', 0x693a303b),
('superfish_smallbp_1', 0x733a333a22373638223b),
('superfish_smallbp_2', 0x733a333a22373638223b),
('superfish_smallchc_1', 0x693a303b),
('superfish_smallchc_2', 0x693a303b),
('superfish_smallcmc_1', 0x693a303b),
('superfish_smallcmc_2', 0x693a303b),
('superfish_smallech_1', 0x733a303a22223b),
('superfish_smallech_2', 0x733a303a22223b),
('superfish_smallecm_1', 0x733a303a22223b),
('superfish_smallecm_2', 0x733a303a22223b),
('superfish_smallich_1', 0x733a303a22223b),
('superfish_smallich_2', 0x733a303a22223b),
('superfish_smallicm_1', 0x733a303a22223b),
('superfish_smallicm_2', 0x733a303a22223b),
('superfish_smallset_1', 0x733a303a22223b),
('superfish_smallset_2', 0x733a303a22223b),
('superfish_smallual_1', 0x733a303a22223b),
('superfish_smallual_2', 0x733a303a22223b),
('superfish_smalluam_1', 0x733a313a2230223b),
('superfish_smalluam_2', 0x733a313a2230223b),
('superfish_smallua_1', 0x733a313a2230223b),
('superfish_smallua_2', 0x733a313a2230223b),
('superfish_small_1', 0x733a313a2230223b),
('superfish_small_2', 0x733a313a2230223b),
('superfish_speed_1', 0x733a343a2266617374223b),
('superfish_speed_2', 0x733a343a2266617374223b),
('superfish_spp_1', 0x693a313b),
('superfish_spp_2', 0x693a313b),
('superfish_style_1', 0x733a343a226e6f6e65223b),
('superfish_style_2', 0x733a343a226e6f6e65223b),
('superfish_supersubs_1', 0x693a313b),
('superfish_supersubs_2', 0x693a313b),
('superfish_touchbp_1', 0x733a333a22373638223b),
('superfish_touchbp_2', 0x733a333a22373638223b),
('superfish_touchual_1', 0x733a303a22223b),
('superfish_touchual_2', 0x733a303a22223b),
('superfish_touchuam_1', 0x733a313a2230223b),
('superfish_touchuam_2', 0x733a313a2230223b),
('superfish_touchua_1', 0x733a313a2230223b),
('superfish_touchua_2', 0x733a313a2230223b),
('superfish_touch_1', 0x733a313a2230223b),
('superfish_touch_2', 0x733a313a2230223b),
('superfish_type_1', 0x733a31303a22686f72697a6f6e74616c223b),
('superfish_type_2', 0x733a31303a22686f72697a6f6e74616c223b),
('superfish_ulclass_1', 0x733a303a22223b),
('superfish_ulclass_2', 0x733a303a22223b),
('superfish_use_item_theme_1', 0x693a313b),
('superfish_use_item_theme_2', 0x693a313b),
('superfish_use_link_theme_1', 0x693a313b),
('superfish_use_link_theme_2', 0x693a313b),
('superfish_wraphlt_1', 0x733a303a22223b),
('superfish_wraphlt_2', 0x733a303a22223b),
('superfish_wraphl_1', 0x733a303a22223b),
('superfish_wraphl_2', 0x733a303a22223b),
('superfish_wrapmul_1', 0x733a303a22223b),
('superfish_wrapmul_2', 0x733a303a22223b),
('superfish_wrapul_1', 0x733a303a22223b),
('superfish_wrapul_2', 0x733a303a22223b),
('superfish_zebra_1', 0x693a313b),
('superfish_zebra_2', 0x693a313b),
('theme_default', 0x733a383a226e657773706c7573223b),
('theme_newsplus_settings', 0x613a34343a7b733a31313a22746f67676c655f6c6f676f223b693a313b733a31313a22746f67676c655f6e616d65223b693a313b733a31333a22746f67676c655f736c6f67616e223b693a313b733a32343a22746f67676c655f6e6f64655f757365725f70696374757265223b693a313b733a32373a22746f67676c655f636f6d6d656e745f757365725f70696374757265223b693a313b733a33323a22746f67676c655f636f6d6d656e745f757365725f766572696669636174696f6e223b693a313b733a31343a22746f67676c655f66617669636f6e223b693a313b733a31363a22746f67676c655f6d61696e5f6d656e75223b693a313b733a32313a22746f67676c655f7365636f6e646172795f6d656e75223b693a313b733a31323a2264656661756c745f6c6f676f223b693a313b733a393a226c6f676f5f70617468223b733a303a22223b733a31313a226c6f676f5f75706c6f6164223b733a303a22223b733a31353a2264656661756c745f66617669636f6e223b693a313b733a31323a2266617669636f6e5f70617468223b733a303a22223b733a31343a2266617669636f6e5f75706c6f6164223b733a303a22223b733a31383a2262726561646372756d625f646973706c6179223b693a313b733a32303a2262726561646372756d625f736570617261746f72223b733a323a222f20223b733a31323a2266697865645f686561646572223b693a313b733a31373a227363726f6c6c746f705f646973706c6179223b693a313b733a32333a2266726f6e74706167655f636f6e74656e745f7072696e74223b693a303b733a32303a22626f6f7473747261705f6a735f696e636c756465223b693a313b733a32353a2274687265655f636f6c756d6e735f677269645f6c61796f7574223b733a31303a22677269645f335f365f33223b733a31323a22636f6c6f725f736368656d65223b733a373a2264656661756c74223b733a31323a2272656164696e675f74696d65223b693a313b733a31313a2273686172655f6c696e6b73223b693a313b733a31323a227072696e745f627574746f6e223b693a313b733a31313a22666f6e745f726573697a65223b693a313b733a31333a22706f73745f70726f6772657373223b693a313b733a32303a22736974656e616d655f666f6e745f66616d696c79223b733a363a227366662d3332223b733a31383a22736c6f67616e5f666f6e745f66616d696c79223b733a373a22736c66662d3332223b733a32303a2268656164696e67735f666f6e745f66616d696c79223b733a353a226866662d35223b733a32313a227061726167726170685f666f6e745f66616d696c79223b733a353a227066662d35223b733a31363a22736c69646573686f775f656666656374223b733a343a2266616465223b733a32313a22736c69646573686f775f6566666563745f74696d65223b733a323a223130223b733a32323a22696e7465726e616c5f62616e6e65725f656666656374223b733a353a22736c696465223b733a31353a22627265616b696e675f656666656374223b733a343a2266616465223b733a32303a22627265616b696e675f6566666563745f74696d65223b733a313a2235223b733a33313a22726573706f6e736976655f6d756c74696c6576656c6d656e755f7374617465223b693a313b733a31333a22676f6f676c655f6d61705f6a73223b693a313b733a31393a22676f6f676c655f6d61705f6c61746974756465223b733a393a2234302e373236353736223b733a32303a22676f6f676c655f6d61705f6c6f6e676974756465223b733a31303a222d37342e303436383232223b733a31353a22676f6f676c655f6d61705f7a6f6f6d223b733a323a223133223b733a31373a22676f6f676c655f6d61705f63616e766173223b733a31303a226d61702d63616e766173223b733a31363a22746162735f5f6163746976655f746162223b733a393a22656469742d706f7374223b7d),
('twitter_api', 0x733a32333a2268747470733a2f2f6170692e747769747465722e636f6d223b),
('twitter_consumer_key', 0x733a32323a224431615771705863706c55624e7a57636b73554d7141223b),
('twitter_consumer_secret', 0x733a34323a2252695235616e63553677697437746571375369794d6a6f7a446b485847756b67765a4f6d544b45384b51223b),
('twitter_expire', 0x733a373a2232353932303030223b),
('twitter_host', 0x733a31383a22687474703a2f2f747769747465722e636f6d223b),
('twitter_import', 0x693a313b),
('twitter_search', 0x733a32353a22687474703a2f2f7365617263682e747769747465722e636f6d223b),
('twitter_tinyurl', 0x733a31383a22687474703a2f2f74696e7975726c2e636f6d223b),
('update_last_check', 0x693a313430343339313736363b),
('update_last_email_notification', 0x693a313430323630313432333b),
('update_notify_emails', 0x613a313a7b693a303b733a33343a2267656f7267652b6e657773706c7573406d6f72657468616e7468656d65732e636f6d223b7d),
('user_admin_role', 0x733a313a2233223b),
('user_cancel_method', 0x733a31373a22757365725f63616e63656c5f626c6f636b223b),
('user_email_verification', 0x693a313b),
('user_mail_cancel_confirm_body', 0x733a3338313a225b757365723a6e616d655d2c0d0a0d0a41207265717565737420746f2063616e63656c20796f7572206163636f756e7420686173206265656e206d616465206174205b736974653a6e616d655d2e0d0a0d0a596f75206d6179206e6f772063616e63656c20796f7572206163636f756e74206f6e205b736974653a75726c2d62726965665d20627920636c69636b696e672074686973206c696e6b206f7220636f7079696e6720616e642070617374696e6720697420696e746f20796f75722062726f777365723a0d0a0d0a5b757365723a63616e63656c2d75726c5d0d0a0d0a4e4f54453a205468652063616e63656c6c6174696f6e206f6620796f7572206163636f756e74206973206e6f742072657665727369626c652e0d0a0d0a54686973206c696e6b206578706972657320696e206f6e652064617920616e64206e6f7468696e672077696c6c2068617070656e206966206974206973206e6f7420757365642e0d0a0d0a2d2d20205b736974653a6e616d655d207465616d223b),
('user_mail_cancel_confirm_subject', 0x733a35393a224163636f756e742063616e63656c6c6174696f6e207265717565737420666f72205b757365723a6e616d655d206174205b736974653a6e616d655d223b),
('user_mail_password_reset_body', 0x733a3430373a225b757365723a6e616d655d2c0d0a0d0a41207265717565737420746f207265736574207468652070617373776f726420666f7220796f7572206163636f756e7420686173206265656e206d616465206174205b736974653a6e616d655d2e0d0a0d0a596f75206d6179206e6f77206c6f6720696e20627920636c69636b696e672074686973206c696e6b206f7220636f7079696e6720616e642070617374696e6720697420746f20796f75722062726f777365723a0d0a0d0a5b757365723a6f6e652d74696d652d6c6f67696e2d75726c5d0d0a0d0a54686973206c696e6b2063616e206f6e6c792062652075736564206f6e636520746f206c6f6720696e20616e642077696c6c206c65616420796f7520746f2061207061676520776865726520796f752063616e2073657420796f75722070617373776f72642e2049742065787069726573206166746572206f6e652064617920616e64206e6f7468696e672077696c6c2068617070656e2069662069742773206e6f7420757365642e0d0a0d0a2d2d20205b736974653a6e616d655d207465616d223b),
('user_mail_password_reset_subject', 0x733a36303a225265706c6163656d656e74206c6f67696e20696e666f726d6174696f6e20666f72205b757365723a6e616d655d206174205b736974653a6e616d655d223b),
('user_mail_register_admin_created_body', 0x733a3437363a225b757365723a6e616d655d2c0d0a0d0a4120736974652061646d696e6973747261746f72206174205b736974653a6e616d655d20686173206372656174656420616e206163636f756e7420666f7220796f752e20596f75206d6179206e6f77206c6f6720696e20627920636c69636b696e672074686973206c696e6b206f7220636f7079696e6720616e642070617374696e6720697420746f20796f75722062726f777365723a0d0a0d0a5b757365723a6f6e652d74696d652d6c6f67696e2d75726c5d0d0a0d0a54686973206c696e6b2063616e206f6e6c792062652075736564206f6e636520746f206c6f6720696e20616e642077696c6c206c65616420796f7520746f2061207061676520776865726520796f752063616e2073657420796f75722070617373776f72642e0d0a0d0a41667465722073657474696e6720796f75722070617373776f72642c20796f752077696c6c2062652061626c6520746f206c6f6720696e206174205b736974653a6c6f67696e2d75726c5d20696e2074686520667574757265207573696e673a0d0a0d0a757365726e616d653a205b757365723a6e616d655d0d0a70617373776f72643a20596f75722070617373776f72640d0a0d0a2d2d20205b736974653a6e616d655d207465616d223b),
('user_mail_register_admin_created_subject', 0x733a35383a22416e2061646d696e6973747261746f72206372656174656420616e206163636f756e7420666f7220796f75206174205b736974653a6e616d655d223b),
('user_mail_register_no_approval_required_body', 0x733a3435303a225b757365723a6e616d655d2c0d0a0d0a5468616e6b20796f7520666f72207265676973746572696e67206174205b736974653a6e616d655d2e20596f75206d6179206e6f77206c6f6720696e20627920636c69636b696e672074686973206c696e6b206f7220636f7079696e6720616e642070617374696e6720697420746f20796f75722062726f777365723a0d0a0d0a5b757365723a6f6e652d74696d652d6c6f67696e2d75726c5d0d0a0d0a54686973206c696e6b2063616e206f6e6c792062652075736564206f6e636520746f206c6f6720696e20616e642077696c6c206c65616420796f7520746f2061207061676520776865726520796f752063616e2073657420796f75722070617373776f72642e0d0a0d0a41667465722073657474696e6720796f75722070617373776f72642c20796f752077696c6c2062652061626c6520746f206c6f6720696e206174205b736974653a6c6f67696e2d75726c5d20696e2074686520667574757265207573696e673a0d0a0d0a757365726e616d653a205b757365723a6e616d655d0d0a70617373776f72643a20596f75722070617373776f72640d0a0d0a2d2d20205b736974653a6e616d655d207465616d223b),
('user_mail_register_no_approval_required_subject', 0x733a34363a224163636f756e742064657461696c7320666f72205b757365723a6e616d655d206174205b736974653a6e616d655d223b),
('user_mail_register_pending_approval_body', 0x733a3238373a225b757365723a6e616d655d2c0d0a0d0a5468616e6b20796f7520666f72207265676973746572696e67206174205b736974653a6e616d655d2e20596f7572206170706c69636174696f6e20666f7220616e206163636f756e742069732063757272656e746c792070656e64696e6720617070726f76616c2e204f6e636520697420686173206265656e20617070726f7665642c20796f752077696c6c207265636569766520616e6f7468657220652d6d61696c20636f6e7461696e696e6720696e666f726d6174696f6e2061626f757420686f7720746f206c6f6720696e2c2073657420796f75722070617373776f72642c20616e64206f746865722064657461696c732e0d0a0d0a0d0a2d2d20205b736974653a6e616d655d207465616d223b),
('user_mail_register_pending_approval_subject', 0x733a37313a224163636f756e742064657461696c7320666f72205b757365723a6e616d655d206174205b736974653a6e616d655d202870656e64696e672061646d696e20617070726f76616c29223b),
('user_mail_status_activated_body', 0x733a3436313a225b757365723a6e616d655d2c0d0a0d0a596f7572206163636f756e74206174205b736974653a6e616d655d20686173206265656e206163746976617465642e0d0a0d0a596f75206d6179206e6f77206c6f6720696e20627920636c69636b696e672074686973206c696e6b206f7220636f7079696e6720616e642070617374696e6720697420696e746f20796f75722062726f777365723a0d0a0d0a5b757365723a6f6e652d74696d652d6c6f67696e2d75726c5d0d0a0d0a54686973206c696e6b2063616e206f6e6c792062652075736564206f6e636520746f206c6f6720696e20616e642077696c6c206c65616420796f7520746f2061207061676520776865726520796f752063616e2073657420796f75722070617373776f72642e0d0a0d0a41667465722073657474696e6720796f75722070617373776f72642c20796f752077696c6c2062652061626c6520746f206c6f6720696e206174205b736974653a6c6f67696e2d75726c5d20696e2074686520667574757265207573696e673a0d0a0d0a757365726e616d653a205b757365723a6e616d655d0d0a70617373776f72643a20596f75722070617373776f72640d0a0d0a2d2d20205b736974653a6e616d655d207465616d223b),
('user_mail_status_activated_notify', 0x693a313b),
('user_mail_status_activated_subject', 0x733a35373a224163636f756e742064657461696c7320666f72205b757365723a6e616d655d206174205b736974653a6e616d655d2028617070726f76656429223b),
('user_mail_status_blocked_body', 0x733a38353a225b757365723a6e616d655d2c0d0a0d0a596f7572206163636f756e74206f6e205b736974653a6e616d655d20686173206265656e20626c6f636b65642e0d0a0d0a2d2d20205b736974653a6e616d655d207465616d223b),
('user_mail_status_blocked_notify', 0x693a303b),
('user_mail_status_blocked_subject', 0x733a35363a224163636f756e742064657461696c7320666f72205b757365723a6e616d655d206174205b736974653a6e616d655d2028626c6f636b656429223b),
('user_mail_status_canceled_body', 0x733a38363a225b757365723a6e616d655d2c0d0a0d0a596f7572206163636f756e74206f6e205b736974653a6e616d655d20686173206265656e2063616e63656c65642e0d0a0d0a2d2d20205b736974653a6e616d655d207465616d223b),
('user_mail_status_canceled_notify', 0x693a303b),
('user_mail_status_canceled_subject', 0x733a35373a224163636f756e742064657461696c7320666f72205b757365723a6e616d655d206174205b736974653a6e616d655d202863616e63656c656429223b),
('user_pictures', 0x693a313b),
('user_picture_default', 0x733a33393a2273697465732f64656661756c742f66696c65732f70696374757265732f6176617461722e706e67223b),
('user_picture_dimensions', 0x733a393a22313032347831303234223b),
('user_picture_file_size', 0x733a333a22383030223b),
('user_picture_guidelines', 0x733a303a22223b),
('user_picture_path', 0x733a383a227069637475726573223b),
('user_picture_style', 0x733a363a226d656469756d223b),
('user_register', 0x733a313a2230223b),
('user_signatures', 0x693a303b),
('views_defaults', 0x613a333a7b733a373a2261726368697665223b623a303b733a31353a22636f6d6d656e74735f726563656e74223b623a313b733a363a22747765657473223b623a313b7d),
('webform_node_types', 0x613a313a7b693a303b733a373a22776562666f726d223b7d);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `webform`
--

DROP TABLE IF EXISTS `webform`;
CREATE TABLE `webform` (
  `nid` int(10) unsigned NOT NULL COMMENT 'The node identifier of a webform.',
  `confirmation` text NOT NULL COMMENT 'The confirmation message or URL displayed to the user after submitting a form.',
  `confirmation_format` varchar(255) DEFAULT NULL COMMENT 'The filter_format.format of the confirmation message.',
  `redirect_url` varchar(255) DEFAULT '<confirmation>' COMMENT 'The URL a user is redirected to after submitting a form.',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value of a webform for open (1) or closed (0).',
  `block` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether this form be available as a block.',
  `teaser` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether the entire form should be displayed on the teaser.',
  `allow_draft` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether submissions to this form be saved as a draft.',
  `auto_save` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean value for whether submissions to this form should be auto-saved between pages.',
  `submit_notice` tinyint(4) NOT NULL DEFAULT '1' COMMENT 'Boolean value for whether to show or hide the previous submissions notification.',
  `submit_text` varchar(255) DEFAULT NULL COMMENT 'The title of the submit button on the form.',
  `submit_limit` tinyint(4) NOT NULL DEFAULT '-1' COMMENT 'The number of submissions a single user is allowed to submit within an interval. -1 is unlimited.',
  `submit_interval` int(11) NOT NULL DEFAULT '-1' COMMENT 'The amount of time in seconds that must pass before a user can submit another submission within the set limit.',
  `total_submit_limit` int(11) NOT NULL DEFAULT '-1' COMMENT 'The total number of submissions allowed within an interval. -1 is unlimited.',
  `total_submit_interval` int(11) NOT NULL DEFAULT '-1' COMMENT 'The amount of time in seconds that must pass before another submission can be submitted within the set limit.',
  PRIMARY KEY (`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table for storing additional properties for webform nodes.';

--
-- Άδειασμα δεδομένων του πίνακα `webform`
--

INSERT INTO `webform` (`nid`, `confirmation`, `confirmation_format`, `redirect_url`, `status`, `block`, `teaser`, `allow_draft`, `auto_save`, `submit_notice`, `submit_text`, `submit_limit`, `submit_interval`, `total_submit_limit`, `total_submit_interval`) VALUES
(13, '', NULL, '<confirmation>', 1, 0, 0, 0, 0, 1, '', -1, -1, -1, -1);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `webform_component`
--

DROP TABLE IF EXISTS `webform_component`;
CREATE TABLE `webform_component` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `cid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `pid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'If this component has a parent fieldset, the cid of that component.',
  `form_key` varchar(128) DEFAULT NULL COMMENT 'When the form is displayed and processed, this key can be used to reference the results.',
  `name` varchar(255) DEFAULT NULL COMMENT 'The label for this component.',
  `type` varchar(16) DEFAULT NULL COMMENT 'The field type of this component (textfield, select, hidden, etc.).',
  `value` text NOT NULL COMMENT 'The default value of the component when displayed to the end-user.',
  `extra` text NOT NULL COMMENT 'Additional information unique to the display or processing of this component.',
  `mandatory` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Boolean flag for if this component is required.',
  `weight` smallint(6) NOT NULL DEFAULT '0' COMMENT 'Determines the position of this component in the form.',
  PRIMARY KEY (`nid`,`cid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores information about components for webform nodes.';

--
-- Άδειασμα δεδομένων του πίνακα `webform_component`
--

INSERT INTO `webform_component` (`nid`, `cid`, `pid`, `form_key`, `name`, `type`, `value`, `extra`, `mandatory`, `weight`) VALUES
(13, 1, 0, 'name', 'Your name', 'textfield', 'Your Name', 'a:5:{s:13:"title_display";s:4:"none";s:7:"private";i:0;s:8:"disabled";i:0;s:6:"unique";i:0;s:20:"conditional_operator";s:1:"=";}', 1, 5),
(13, 2, 0, 'email', 'Your email', 'email', 'Your e-mail', 'a:5:{s:13:"title_display";s:4:"none";s:7:"private";i:0;s:8:"disabled";i:0;s:6:"unique";i:0;s:20:"conditional_operator";s:1:"=";}', 1, 6),
(13, 3, 0, 'subject', 'Subject', 'textfield', 'Subject', 'a:5:{s:13:"title_display";s:4:"none";s:7:"private";i:0;s:8:"disabled";i:0;s:6:"unique";i:0;s:20:"conditional_operator";s:1:"=";}', 1, 7),
(13, 4, 0, 'message', 'Message', 'textarea', 'Message', 'a:6:{s:13:"title_display";s:4:"none";s:7:"private";i:0;s:4:"rows";s:2:"12";s:9:"resizable";i:1;s:8:"disabled";i:0;s:20:"conditional_operator";s:1:"=";}', 1, 9),
(13, 5, 0, 'about_you', 'Tell us about you', 'markup', '<h4>Tell us about you</h4>', 'a:3:{s:20:"conditional_operator";s:1:"=";s:6:"format";s:9:"full_html";s:7:"private";i:0;}', 0, 4),
(13, 6, 0, 'message_label', 'What are you writing to us about?', 'markup', '<h4>What are you writing to us about?</h4>', 'a:3:{s:20:"conditional_operator";s:1:"=";s:6:"format";s:9:"full_html";s:7:"private";i:0;}', 0, 8);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `webform_emails`
--

DROP TABLE IF EXISTS `webform_emails`;
CREATE TABLE `webform_emails` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `eid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The e-mail identifier for this row’s settings.',
  `email` text COMMENT 'The e-mail address that will be sent to upon submission. This may be an e-mail address, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `subject` varchar(255) DEFAULT NULL COMMENT 'The e-mail subject that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_name` varchar(255) DEFAULT NULL COMMENT 'The e-mail "from" name that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `from_address` varchar(255) DEFAULT NULL COMMENT 'The e-mail "from" e-mail address that will be used. This may be a string, the special key "default" or a numeric value. If a numeric value is used, the value of a component will be substituted on submission.',
  `template` text COMMENT 'A template that will be used for the sent e-mail. This may be a string or the special key "default", which will use the template provided by the theming layer.',
  `excluded_components` text NOT NULL COMMENT 'A list of components that will not be included in the %email_values token. A list of CIDs separated by commas.',
  `html` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will be sent in an HTML format. Requires Mime Mail module.',
  `attachments` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT 'Determines if the e-mail will include file attachments. Requires Mime Mail module.',
  PRIMARY KEY (`nid`,`eid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds information regarding e-mails that should be sent...';

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `webform_last_download`
--

DROP TABLE IF EXISTS `webform_last_download`;
CREATE TABLE `webform_last_download` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The user identifier.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The last downloaded submission number.',
  `requested` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'Timestamp of last download request.',
  PRIMARY KEY (`nid`,`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores last submission number per user download.';

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `webform_roles`
--

DROP TABLE IF EXISTS `webform_roles`;
CREATE TABLE `webform_roles` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `rid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The role identifier.',
  PRIMARY KEY (`nid`,`rid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds access information regarding which roles are...';

--
-- Άδειασμα δεδομένων του πίνακα `webform_roles`
--

INSERT INTO `webform_roles` (`nid`, `rid`) VALUES
(13, 1),
(13, 2);

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `webform_submissions`
--

DROP TABLE IF EXISTS `webform_submissions`;
CREATE TABLE `webform_submissions` (
  `sid` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT 'The unique identifier for this submission.',
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `uid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The id of the user that completed this submission.',
  `is_draft` tinyint(4) NOT NULL DEFAULT '0' COMMENT 'Is this a draft of the submission?',
  `submitted` int(11) NOT NULL DEFAULT '0' COMMENT 'Timestamp of when the form was submitted.',
  `remote_addr` varchar(128) DEFAULT NULL COMMENT 'The IP address of the user that submitted the form.',
  PRIMARY KEY (`sid`),
  UNIQUE KEY `sid_nid` (`sid`,`nid`),
  KEY `nid_uid_sid` (`nid`,`uid`,`sid`),
  KEY `nid_sid` (`nid`,`sid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds general information about submissions outside of...' AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Δομή πίνακα για τον πίνακα `webform_submitted_data`
--

DROP TABLE IF EXISTS `webform_submitted_data`;
CREATE TABLE `webform_submitted_data` (
  `nid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The node identifier of a webform.',
  `sid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT 'The unique identifier for this submission.',
  `cid` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT 'The identifier for this component within this node, starts at 0 for each node.',
  `no` varchar(128) NOT NULL DEFAULT '0' COMMENT 'Usually this value is 0, but if a field has multiple values (such as a time or date), it may require multiple rows in the database.',
  `data` mediumtext NOT NULL COMMENT 'The submitted value of this field, may be serialized for some components.',
  PRIMARY KEY (`nid`,`sid`,`cid`,`no`),
  KEY `nid` (`nid`),
  KEY `sid_nid` (`sid`,`nid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Stores all submitted field data for webform submissions.';

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
