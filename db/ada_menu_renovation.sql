-- phpMyAdmin SQL Dump
-- version 4.0.6deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generato il: Set 08, 2014 alle 08:15
-- Versione del server: 5.5.37-0ubuntu0.13.10.1
-- Versione PHP: 5.5.3-1ubuntu2.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `ada_common`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `menu_page`
--

CREATE TABLE IF NOT EXISTS `menu_page` (
  `tree_id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id of the menu tree for the given module, script, user_type and self instruction',
  `module` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `script` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user_type` int(2) NOT NULL,
  `self_instruction` int(1) NOT NULL DEFAULT '0' COMMENT 'nonzero if course is in self instruction mode',
  `isVertical` int(1) NOT NULL DEFAULT '0' COMMENT 'nonzero if it''s a vertical menu',
  `linked_tree_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`tree_id`),
  UNIQUE KEY `module` (`module`,`script`,`user_type`,`self_instruction`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=139 ;

--
-- Dump dei dati per la tabella `menu_page`
--

INSERT INTO `menu_page` (`tree_id`, `module`, `script`, `user_type`, `self_instruction`, `isVertical`, `linked_tree_id`) VALUES
(1, 'browsing', 'view.php', 3, 0, 0, NULL),
(2, 'main', 'default', 5, 0, 0, 105),
(3, 'browsing', 'default', 5, 0, 0, NULL),
(4, 'main', 'info.php', 5, 0, 0, NULL),
(5, 'browsing', 'user.php', 3, 0, 0, NULL),
(6, 'browsing', 'view.php', 3, 1, 0, NULL),
(7, 'modules/test', 'index.php', 1, 0, 0, NULL),
(8, 'modules/test', 'index.php', 3, 0, 0, 77),
(9, 'browsing', 'view.php', 1, 0, 0, NULL),
(10, 'browsing', 'default', 3, 0, 0, NULL),
(11, 'browsing', 'edit_user.php', 3, 0, 0, NULL),
(35, 'comunica', 'default', 4, 0, 0, 13),
(13, 'comunica', 'default', 3, 0, 0, NULL),
(14, 'comunica', 'send_message.php', 3, 0, 0, NULL),
(16, 'comunica', 'list_events.php', 3, 0, 0, NULL),
(17, 'comunica', 'send_event.php', 3, 0, 0, NULL),
(18, 'main', 'default', 3, 0, 0, 105),
(20, 'modules/test', 'default', 3, 0, 0, NULL),
(21, 'comunica', 'list_messages.php?messages=sent', 3, 0, 0, NULL),
(22, 'browsing', 'main_index.php?op=forum', 3, 0, 0, NULL),
(23, 'comunica', 'list_chatrooms.php', 3, 0, 0, 10),
(24, 'comunica', 'chat.php', 3, 0, 0, NULL),
(25, 'services', 'upload.php', 3, 0, 0, 77),
(26, 'services', 'default', 3, 0, 0, 82),
(27, 'services', 'addnode.php?op=preview', 3, 0, 0, 84),
(28, 'browsing', 'search.php', 3, 0, 0, NULL),
(29, 'browsing', 'external_link.php?file=user_it.html', 3, 0, 0, NULL),
(30, 'browsing', 'default', 3, 1, 0, NULL),
(31, 'browsing', 'edit_user.php', 3, 1, 0, 28),
(32, 'modules/test', 'default', 3, 1, 0, 30),
(33, 'browsing', 'search.php', 3, 1, 0, 28),
(34, 'tutor', 'default', 4, 0, 0, NULL),
(36, 'comunica', 'list_events.php', 4, 0, 0, 16),
(37, 'comunica', 'list_messages.php?messages=sent', 4, 0, 0, 21),
(38, 'comunica', 'send_event.php', 4, 0, 0, 17),
(39, 'comunica', 'send_message.php', 4, 0, 0, 14),
(40, 'comunica', 'list_chatrooms.php', 4, 0, 0, NULL),
(41, 'comunica', 'create_chat.php', 4, 0, 0, NULL),
(57, 'comunica', 'edit_chat.php', 4, 0, 0, NULL),
(42, 'browsing', 'external_link.php?file=practitioner_it.html', 4, 0, 0, 29),
(43, 'tutor', 'edit_tutor.php', 4, 0, 0, 11),
(44, 'main', 'default', 4, 0, 0, 105),
(45, 'browsing', 'view.php', 4, 0, 0, NULL),
(46, 'browsing', 'main_index.php?op=forum', 4, 0, 0, 22),
(47, 'browsing', 'search.php', 4, 0, 0, 28),
(48, 'comunica', 'chat.php', 4, 0, 0, 24),
(49, 'browsing', 'default', 4, 0, 0, 10),
(50, 'services', 'upload.php', 4, 0, 0, 25),
(51, 'services', 'default', 4, 0, 0, 82),
(52, 'services', 'addnode.php?op=preview', 4, 0, 0, 84),
(53, 'tutor', 'tutor.php?op=student&mode=update', 4, 0, 0, NULL),
(54, 'browsing', 'main_index.php?order=struct&hide_visits=0&expand=1', 4, 0, 0, 22),
(55, 'browsing', 'main_index.php?op=forum&order=struct&hide_visits=0', 4, 0, 0, 22),
(56, 'comunica', 'report_chat.php?op=index', 4, 0, 0, NULL),
(58, 'comunica', 'report_chat.php', 4, 0, 0, NULL),
(59, 'tutor', 'tutor.php?op=zoom_student', 4, 0, 0, NULL),
(60, 'tutor', 'tutor_history.php', 4, 0, 0, NULL),
(61, 'tutor', 'tutor_exercise.php', 4, 0, 0, NULL),
(62, 'tutor', 'tutor.php?op=student_notes', 4, 0, 0, NULL),
(63, 'tutor', 'tutor_history_details.php', 4, 0, 0, NULL),
(71, 'browsing', 'external_link.php?file=author_it.html', 1, 0, 0, 29),
(69, 'services', 'author.php', 1, 0, 0, NULL),
(70, 'services', 'default', 1, 0, 0, 105),
(68, 'modules/test', 'default', 4, 0, 0, NULL),
(72, 'main', 'default', 1, 0, 0, 105),
(73, 'browsing', 'main_index.php?op=forum', 1, 0, 0, 22),
(74, 'services', 'addnode.php', 1, 0, 0, 82),
(75, 'services', 'addnode.php?op=preview', 1, 0, 0, 84),
(76, 'services', 'add_exercise.php', 1, 0, 0, 77),
(77, 'abstract', 'indietro', 5, 0, 0, NULL),
(78, 'modules/test', 'default', 1, 0, 0, 77),
(79, 'switcher', 'default', 6, 0, 0, NULL),
(80, 'browsing', 'external_link.php?file=switcher_it.html', 6, 0, 0, 29),
(81, 'main', 'default', 6, 0, 0, 105),
(82, 'abstract', 'annulla', 5, 0, 0, NULL),
(83, 'services', 'edit_node.php?op=edit', 3, 0, 0, 82),
(84, 'abstract', 'edit_note', 5, 0, 0, NULL),
(85, 'services', 'edit_node.php?op=preview', 3, 0, 0, 84),
(86, 'services', 'edit_node.php?op=delete', 3, 0, 0, 77),
(87, 'services', 'edit_node.php?op=edit', 4, 0, 0, 82),
(88, 'services', 'edit_node.php?op=preview', 4, 0, 0, 84),
(89, 'services', 'edit_node.php?op=delete', 4, 0, 0, 77),
(90, 'services', 'edit_node.php?op=edit', 1, 0, 0, 82),
(91, 'services', 'edit_node.php?op=preview', 1, 0, 0, 84),
(92, 'services', 'edit_node.php?op=delete', 1, 0, 0, 77),
(93, 'comunica', 'default', 6, 0, 0, 13),
(94, 'comunica', 'list_chatrooms.php', 6, 0, 0, 40),
(95, 'comunica', 'send_message.php', 6, 0, 0, 14),
(96, 'comunica', 'list_events.php', 6, 0, 0, 16),
(97, 'comunica', 'send_event.php', 6, 0, 0, 17),
(99, 'comunica', 'list_messages.php?messages=sent', 6, 0, 0, 21),
(100, 'comunica', 'chat.php', 6, 0, 0, 24),
(101, 'comunica', 'create_chat.php', 6, 0, 0, 41),
(102, 'comunica', 'edit_chat.php', 6, 0, 0, 57),
(103, 'comunica', 'delete_chat.php', 6, 0, 0, 57),
(109, 'switcher', 'edit_user.php', 6, 0, 0, 105),
(105, 'abstract', 'home_help_esc', 5, 0, 0, NULL),
(106, 'switcher', 'translation.php', 6, 0, 0, NULL),
(108, 'switcher', 'edit_switcher.php', 6, 0, 0, 105),
(110, 'switcher', 'view_user.php', 6, 0, 0, 105),
(111, 'switcher', 'delete_user.php', 6, 0, 0, 105),
(112, 'switcher', 'add_user.php', 6, 0, 0, 105),
(113, 'switcher', 'add_course.php', 6, 0, 0, 105),
(114, 'switcher', 'edit_course.php', 6, 0, 0, 105),
(115, 'switcher', 'view_course.php', 6, 0, 0, 105),
(116, 'switcher', 'assign_tutor.php', 6, 0, 0, 105),
(117, 'switcher', 'assign_more_tutors.php', 6, 0, 0, 105),
(118, 'switcher', 'subscriptions.php', 6, 0, 0, 105),
(119, 'switcher', 'subscribe.php', 6, 0, 0, 105),
(120, 'switcher', 'edit_instance.php', 6, 0, 0, 105),
(121, 'switcher', 'delete_instance.php', 6, 0, 0, 105),
(122, 'switcher', 'add_instance.php', 6, 0, 0, 105),
(123, 'switcher', 'delete_course.php', 6, 0, 0, 105),
(124, 'abstract', 'home_help_esc_back', 5, 0, 0, NULL),
(125, 'modules/newsletter', 'edit_newsletter.php', 6, 0, 0, 124),
(126, 'modules/newsletter', 'send_newsletter.php', 6, 0, 0, 124),
(127, 'modules/newsletter', 'details_newsletter.php', 6, 0, 0, 124),
(128, 'modules/service-complete', 'edit_completerule.php', 6, 0, 0, 124),
(129, 'modules/service-complete', 'completerule_link_courses.php', 6, 0, 0, 124),
(130, 'admin', 'admin.php', 2, 0, 0, NULL),
(131, 'admin', 'default', 2, 0, 0, 105),
(132, 'admin', 'tester_profile.php', 2, 0, 0, NULL),
(133, 'admin', 'list_users.php', 2, 0, 0, NULL),
(134, 'browsing', 'external_link.php?file=gpl.txt', 5, 0, 0, 29),
(135, 'browsing', 'view.php', 5, 0, 0, NULL),
(136, 'browsing', 'external_link.php?file=guest_it.html', 5, 0, 0, 29),
(138, 'main', 'index.php', 5, 0, 0, NULL);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


--

-- --------------------------------------------------------

--
-- Struttura della tabella `menu_items`
--

CREATE TABLE IF NOT EXISTS `menu_items` (
  `item_id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `extraHTML` text COLLATE utf8_unicode_ci,
  `icon` text COLLATE utf8_unicode_ci,
  `icon_size` text COLLATE utf8_unicode_ci,
  `href_properties` text COLLATE utf8_unicode_ci,
  `href_prefix` text COLLATE utf8_unicode_ci,
  `href_path` text COLLATE utf8_unicode_ci,
  `href_paramlist` text COLLATE utf8_unicode_ci,
  `extraClass` text COLLATE utf8_unicode_ci,
  `groupRight` int(1) NOT NULL DEFAULT '0',
  `specialItem` int(1) NOT NULL DEFAULT '0',
  `order` int(3) unsigned NOT NULL DEFAULT '0',
  `enabledON` varchar(128) COLLATE utf8_unicode_ci NOT NULL DEFAULT '%ALWAYS%',
  PRIMARY KEY (`item_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=130 ;

--
-- Dump dei dati per la tabella `menu_items`
--

INSERT INTO `menu_items` (`item_id`, `label`, `extraHTML`, `icon`, `icon_size`, `href_properties`, `href_prefix`, `href_path`, `href_paramlist`, `extraClass`, `groupRight`, `specialItem`, `order`, `enabledON`) VALUES
(1, 'home', NULL, 'home', 'large', NULL, '%HTTP_ROOT_DIR%/browsing', 'user.php', NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(2, 'Comunica', '<div class="ui label" id="msglabel" style="display:none;">             <i class="mail small icon"></i><span id="unreadmsgbadge"></span>         </div>', 'comment', 'large', NULL, NULL, NULL, NULL, NULL, 0, 0, 10, '%ALWAYS%'),
(3, 'Messaggeria', NULL, 'mail', NULL, '{"onclick":"openMessenger(''../comunica/list_messages.php'',800,600);"}', NULL, NULL, NULL, NULL, 0, 0, 5, '%ALWAYS%'),
(4, 'Forum', NULL, 'community basic', NULL, NULL, '%HTTP_ROOT_DIR%/browsing', 'main_index.php?op=forum', '', NULL, 0, 0, 10, '%ALWAYS%'),
(9, 'Esci', NULL, 'sign out', 'large', NULL, '%HTTP_ROOT_DIR%', NULL, NULL, NULL, 1, 0, 500, '%ALWAYS%'),
(10, 'cerca', '<div class="ui search small icon input">\r\n<input type="text" placeholder="<i18n>Cerca</i18n>...">\r\n        <i class="search link icon"></i>\r\n</div>', NULL, NULL, NULL, NULL, NULL, NULL, 'searchItem', 1, 1, 0, '%ALWAYS%'),
(11, 'Naviga', NULL, 'globe', 'large', '{"onclick":"javascript: $j(''#menuright'').sidebar({overlay:true}).sidebar(''toggle'');"}', NULL, NULL, NULL, '', 0, 0, 25, '%ALWAYS%'),
(14, 'registrati', NULL, 'sign in', 'large', NULL, '%HTTP_ROOT_DIR%/browsing', 'registration.php', NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(15, 'corsi', NULL, 'book', 'large', NULL, '%HTTP_ROOT_DIR%', 'info.php', NULL, NULL, 0, 0, 20, '%ALWAYS%'),
(16, 'help', NULL, 'question', 'large', NULL, NULL, NULL, NULL, NULL, 1, 0, 0, '%ALWAYS%'),
(17, 'informazioni', NULL, 'info', NULL, '{"target":"_blank"}', '%HTTP_ROOT_DIR%', 'help.php', '', NULL, 0, 0, 0, '%ALWAYS%'),
(18, 'credits', NULL, 'trophy', NULL, NULL, '%HTTP_ROOT_DIR%', 'credits.php', NULL, NULL, 0, 0, 5, '%ALWAYS%'),
(20, 'strumenti', NULL, 'wrench', 'large', NULL, NULL, NULL, NULL, NULL, 0, 0, 10, '%ALWAYS%'),
(21, 'agenda', NULL, 'calendar', NULL, '{"onclick":"openMessenger(''../comunica/list_events.php'',800,600);"}', NULL, NULL, NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(22, 'agisci', NULL, 'pencil', 'large', NULL, NULL, NULL, NULL, NULL, 0, 0, 15, '%ALWAYS%'),
(23, 'modifica profilo', NULL, 'user', NULL, NULL, NULL, '<template_field class="template_field" name="edit_profile">edit_profile</template_field>', 'self_instruction', NULL, 0, 0, 0, '%ALWAYS%'),
(24, '<template_field class="template_field" name="user_name">user_name</template_field>', NULL, 'user', 'large', NULL, NULL, NULL, NULL, 'userpopup', 1, 0, 495, '%ALWAYS%'),
(25, 'chat', NULL, 'chat', NULL, '{"target":"_blank"}', '%HTTP_ROOT_DIR%/comunica', 'chat.php', NULL, NULL, 0, 0, 15, '%ALWAYS%'),
(26, 'video conference', NULL, 'facetime video', NULL, '{"target":"_blank"}', '%HTTP_ROOT_DIR%/comunica', 'videochat.php', NULL, NULL, 0, 0, 20, '%ALWAYS%'),
(27, 'collabora', NULL, 'share', NULL, NULL, '%HTTP_ROOT_DIR%/browsing', 'download.php', NULL, NULL, 0, 0, 25, '%ALWAYS%'),
(28, 'diario', NULL, 'empty calendar', NULL, NULL, '%HTTP_ROOT_DIR%/browsing', 'mylog.php', NULL, NULL, 0, 0, 10, '%ALWAYS%'),
(29, 'cronologia', NULL, 'time basic', NULL, NULL, '%HTTP_ROOT_DIR%/browsing', 'history.php', NULL, NULL, 0, 0, 15, '%ALWAYS%'),
(30, 'storico esercizi', NULL, 'chart basic', NULL, NULL, '%HTTP_ROOT_DIR%/browsing', 'exercise_history.php', 'id_course_instance', NULL, 0, 0, 20, '%ALWAYS%'),
(31, 'storico test', NULL, 'bar chart', NULL, NULL, '%MODULES_TEST_HTTP%', 'history.php', '<template_field class="template_field" name="test_history">test_history</template_field>', NULL, 0, 0, 25, '%ALWAYS%'),
(32, 'storico sondaggi', NULL, 'edit', NULL, NULL, '%MODULES_TEST_HTTP%', 'history.php?op=survey', 'id_course, id_course_instance', NULL, 0, 0, 30, '%ALWAYS%'),
(33, 'stampa', NULL, 'print', NULL, '{"target":"_blank"}', '%HTTP_ROOT_DIR%/browsing', 'print.php', 'id_node', NULL, 0, 0, 35, '%ALWAYS%'),
(34, 'invia un file', NULL, 'upload disk', NULL, NULL, '%HTTP_ROOT_DIR%/services', 'upload.php', NULL, NULL, 0, 0, 10, '%ALWAYS%'),
(102, 'lista tutor', NULL, 'basic users', '', NULL, '%HTTP_ROOT_DIR%/switcher', 'list_users.php?list=tutors', NULL, NULL, 0, 0, 10, '%ALWAYS%'),
(37, 'indietro', NULL, 'circle left', 'large', NULL, NULL, '<template_field class="template_field" name="go_back">go_back</template_field>', NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(38, 'modifica <template_field class="template_field" name="what">what</template_field>', NULL, 'edit', NULL, NULL, '%MODULES_TEST_HTTP%', 'edit_test.php', '<template_field class="template_field" name="edit_test">edit_test</template_field>', NULL, 0, 0, 5, '%ALWAYS%'),
(39, 'cancella <template_field class="template_field" name="what">what</template_field>', NULL, 'trash', NULL, NULL, '%MODULES_TEST_HTTP%', 'edit_test.php', '<template_field class="template_field" name="delete_test">delete_test</template_field>', NULL, 0, 0, 10, '%ALWAYS%'),
(40, 'aggiorna report', NULL, 'refresh', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor.php?op=student&mode=update', 'id_instance, id_course', NULL, 0, 0, 5, '%ALWAYS%'),
(41, 'indice del corso', NULL, 'info letter', NULL, NULL, '%HTTP_ROOT_DIR%/browsing', 'main_index.php?order=struct&hide_visits=0&expand=10', 'id_course_instance,id_course', NULL, 0, 0, 10, '%ALWAYS%'),
(61, 'indice del forum', NULL, 'basic community', NULL, NULL, '%HTTP_ROOT_DIR%/browsing', 'main_index.php?op=forum&order=struct&hide_visits=0&expand=10', 'id_course_instance,id_course', NULL, 0, 0, 15, '%ALWAYS%'),
(42, 'chiudi', NULL, 'off', 'large', '{"onclick":"closeMeAndReloadParent();"}', NULL, NULL, NULL, NULL, 1, 0, 500, '%ALWAYS%'),
(43, 'scrivi', NULL, 'pencil', 'large', '', '%HTTP_ROOT_DIR%/comunica', 'send_message.php', NULL, NULL, 0, 0, 5, '%ALWAYS%'),
(44, 'messaggi inviati', NULL, 'forward mail', 'large', NULL, '%HTTP_ROOT_DIR%/comunica', 'list_messages.php?messages=sent', NULL, NULL, 0, 0, 5, '%ALWAYS%'),
(45, 'messaggi', NULL, 'mail', 'large', NULL, '%HTTP_ROOT_DIR%/comunica', 'list_messages.php', NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(46, 'crea appuntamento', NULL, 'opne folder', 'large', NULL, ' %HTTP_ROOT_DIR%/comunica', 'send_event.php', '', NULL, 0, 0, 0, '%ALWAYS%'),
(47, 'appuntamenti', NULL, 'open folder', 'large', NULL, ' %HTTP_ROOT_DIR%/comunica', 'list_events.php', NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(48, 'chiudi', NULL, 'off', 'large', '{"onclick":"exitChat();"}', NULL, NULL, NULL, NULL, 1, 0, 500, '%ALWAYS%'),
(49, 'Messaggeria\r\n', NULL, 'mail', NULL, '{"onclick":"openMessenger(''../../comunica/list_messages.php'',800,600);"}', NULL, NULL, NULL, NULL, 0, 0, 5, '%ALWAYS%'),
(50, 'chatrooms', NULL, 'chat', NULL, NULL, ' %HTTP_ROOT_DIR%/comunica', 'list_chatrooms.php', NULL, NULL, 0, 0, 10, '%ALWAYS%'),
(51, 'agenda', NULL, 'calendar', NULL, '{"onclick":"openMessenger(''../../comunica/list_events.php'',800,600);"}', NULL, NULL, NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(52, 'messaggi ricevuti', NULL, 'reply mail', 'large', NULL, '%HTTP_ROOT_DIR%/comunica', 'list_messages.php?messages=received', NULL, NULL, 0, 0, 5, '%ALWAYS%'),
(60, 'crea chatroom', NULL, 'chat', NULL, NULL, '%HTTP_ROOT_DIR%/comunica', 'create_chat.php', NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(54, 'chiudi', NULL, 'off', 'large', '{"onclick":"<template_field class=\\"template_field\\" name=\\"onclick\\">onclick</template_field>"}', NULL, NULL, NULL, NULL, 1, 0, 500, '%ALWAYS%'),
(55, 'annulla', NULL, 'remove', 'large', '{"onclick":"<template_field class=\\"template_field\\" name=\\"cancel\\">cancel</template_field>"} ', NULL, NULL, NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(56, 'indietro', NULL, 'circle left', 'large', '{"onclick": "javascript:history.go(-1);"}', NULL, NULL, NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(57, 'modifica', NULL, 'edit', 'large', NULL, '%HTTP_ROOT_DIR%/services', '<template_field class="template_field" name="edit_link">edit_link</template_field>', NULL, NULL, 0, 0, 5, '%ALWAYS%'),
(58, 'salva', '', 'archive', 'large', NULL, '%HTTP_ROOT_DIR%/services', '<template_field class="template_field" name="save_link">save_link</template_field>', '', NULL, 0, 0, 10, '%ALWAYS%'),
(101, 'lista autori', '', 'basic users', NULL, NULL, '%HTTP_ROOT_DIR%/switcher', 'list_users.php?list=authors', NULL, NULL, 0, 0, 5, '%ALWAYS%'),
(62, 'report della chat', NULL, 'basic docs', NULL, NULL, '%HTTP_ROOT_DIR%/comunica', 'report_chat.php?op=index', 'id_instance,id_course', NULL, 0, 0, 20, '%ALWAYS%'),
(63, 'lista chatrooms', NULL, 'chat outline', NULL, NULL, '%HTTP_ROOT_DIR%/comunica', 'list_chatrooms.php', NULL, NULL, 0, 0, 5, '%ALWAYS%'),
(64, 'esporta report (XLS)', NULL, 'download disk', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor.php?op=export&type=xls', 'id_instance,id_course', NULL, 0, 0, 25, '%ALWAYS%'),
(65, 'esporta report (PDF)', NULL, 'download disk', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor.php?op=export&type=pdf', 'id_instance,id_course', NULL, 0, 0, 30, '%ALWAYS%'),
(66, 'esporta testo', NULL, 'download disk', NULL, NULL, '%HTTP_ROOT_DIR%/comunica', 'report_chat.php?op=export', 'id_chatroom', NULL, 0, 0, 20, '%ALWAYS%'),
(67, 'esporta foglio', NULL, 'download disk', NULL, NULL, '%HTTP_ROOT_DIR%/comunica', 'report_chat.php?op=exportTable', 'id_chatroom', NULL, 0, 0, 25, '%ALWAYS%'),
(68, 'elenco studenti', NULL, 'list', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor.php?op=student', 'id_instance', NULL, 0, 0, 5, '%ALWAYS%'),
(69, 'cronologia completa', NULL, 'basic content', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history.php', 'id_course_instance,id_student,id_course', NULL, 0, 0, 15, '%ALWAYS%'),
(70, 'scheda corsista', NULL, 'building', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor.php?op=zoom_student', 'id_student,id_instance', NULL, 0, 0, 0, '%ALWAYS%'),
(71, 'punteggio', NULL, 'flag', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history.php?mode=score', 'id_student,id_course_instance', NULL, 0, 0, 5, '%ALWAYS%'),
(72, 'interazione', NULL, 'users', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history.php?mode=writings', 'id_student,id_course_instance', NULL, 0, 0, 15, '%ALWAYS%'),
(73, 'indice attività', NULL, 'info letter', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history.php?mode=summary', 'id_student,id_course_instance', NULL, 0, 0, 30, '%ALWAYS%'),
(74, 'esporta report corsista', NULL, 'download disk', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history.php?op=export', 'id_student,id_course_instance', NULL, 0, 0, 35, '%ALWAYS%'),
(75, 'Nodi visitati recentemente', '<label>Nodi visitati recentemente :</label>', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 40, '%ALWAYS%'),
(76, '1 giorno', NULL, 'circle', 'small', NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history_details.php?period=1', 'id_student,id_course_instance,id_course', NULL, 0, 0, 45, '%ALWAYS%'),
(77, '5 giorni', NULL, 'circle', 'small', NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history_details.php?period=5', 'id_student,id_course_instance,id_course', NULL, 0, 0, 50, '%ALWAYS%'),
(78, '15 giorni', NULL, 'circle', 'small', NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history_details.php?period=15', 'id_student,id_course_instance,id_course', NULL, 0, 0, 55, '%ALWAYS%'),
(79, '30 giorni', NULL, 'circle', 'small', NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history_details.php?period=30', 'id_student,id_course_instance,id_course', NULL, 0, 0, 60, '%ALWAYS%'),
(80, 'tutto', NULL, 'circle', 'small', NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history_details.php?period=all', 'id_student,id_course_instance,id_course', NULL, 0, 0, 65, '%ALWAYS%'),
(81, 'esercizi svolti', NULL, 'attachment', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_exercise.php', 'id_student,id_course_instance', NULL, 0, 0, 20, '%ALWAYS%'),
(82, 'note', NULL, 'pencil', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor.php?op=student_notes', 'id_student,id_instance', NULL, 0, 0, 20, '%ALWAYS%'),
(83, 'esporta note corsista', NULL, 'download disk', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor.php?op=student_notes_export', 'id_student,id_instance', NULL, 0, 0, 40, '%ALWAYS%'),
(84, 'esporta report corsista (XLS)', NULL, 'download disk', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history_details.php?op=export', 'id_student,id_course_instance,id_course,period', NULL, 0, 0, 10, '%ALWAYS%'),
(85, 'esporta report corsista (PDF)', NULL, 'download disk', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history_details.php?op=export&type=pdf', 'id_student,id_course_instance,id_course,period', NULL, 0, 0, 15, '%ALWAYS%'),
(86, 'riepilogo cronologia', NULL, 'basic book', NULL, NULL, '%HTTP_ROOT_DIR%/tutor', 'tutor_history.php', 'id_course_instance,id_student', NULL, 0, 0, 40, '%ALWAYS%'),
(100, 'aggiungi sondaggio', NULL, 'basic chart', NULL, NULL, '%MODULES_TEST_HTTP%', 'edit_test.php?mode=survey&action=add', 'id_node', NULL, 0, 0, 25, '%ALWAYS%'),
(99, 'aggiungi test', NULL, 'question', NULL, NULL, '%MODULES_TEST_HTTP%', 'edit_test.php?mode=test&action=add', 'id_node', NULL, 0, 0, 20, '%ALWAYS%'),
(97, 'aggiungi termine', NULL, 'basic asterisk', NULL, NULL, '%HTTP_ROOT_DIR%/services', 'addnode.php?type=WORD', 'id_parent,id_course', NULL, 0, 0, 10, '%ALWAYS%'),
(98, 'aggiungi esercizio', NULL, 'basic edit', NULL, NULL, '%HTTP_ROOT_DIR%/services', 'add_exercise.php?', 'id_node', NULL, 0, 0, 10, '%ALWAYS%'),
(95, 'report', NULL, 'basic docs', NULL, NULL, '%HTTP_ROOT_DIR%/services', 'author_report.php', NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(96, 'aggiungi nodo', NULL, 'basic doc', NULL, NULL, '%HTTP_ROOT_DIR%/services', 'addnode.php?type=leaf', 'id_parent,id_course', NULL, 0, 0, 0, '%ALWAYS%'),
(113, 'torna', '\r\n<a id="torna" href="translation.php" class="item"><i class="circle left icon large"></i>\r\n<span  class="menulabel">Indietro</span>\r\n</a>\r\n \r\n\r\n', '', NULL, NULL, NULL, NULL, NULL, NULL, 0, 1, 0, '%ALWAYS%'),
(103, 'lista studenti', NULL, 'basic users', NULL, NULL, '%HTTP_ROOT_DIR%/switcher', 'list_users.php?list=students', NULL, NULL, 0, 0, 15, '%ALWAYS%'),
(104, 'aggiungi utente', NULL, 'basic add user', NULL, NULL, '%HTTP_ROOT_DIR%/switcher', 'add_user.php', NULL, NULL, 0, 0, 20, '%ALWAYS%'),
(105, 'lista corsi', NULL, 'browser', NULL, NULL, '%HTTP_ROOT_DIR%/switcher', 'list_courses.php', NULL, NULL, 0, 0, 25, '%ALWAYS%'),
(106, 'aggiungi corso', NULL, 'book', NULL, NULL, '%HTTP_ROOT_DIR%/switcher', 'add_course.php', NULL, NULL, 0, 0, 30, '%ALWAYS%'),
(107, 'traduci messaggi', NULL, 'edit', NULL, NULL, '%HTTP_ROOT_DIR%/switcher', 'translation.php', NULL, NULL, 0, 0, 30, '%ALWAYS%'),
(108, 'applicazioni', NULL, 'settings', NULL, NULL, '%MODULES_APPS_HTTP%', '', NULL, NULL, 0, 0, 40, '%MODULES_APPS%'),
(109, 'importa corso', NULL, 'download disk', NULL, NULL, '%MODULES_IMPEXPORT_HTTP%', 'import.php', NULL, NULL, 0, 0, 45, '%MODULES_IMPEXPORT%'),
(110, 'esporta corso', NULL, 'upload disk', NULL, NULL, '%MODULES_IMPEXPORT_HTTP%', 'export.php', NULL, NULL, 0, 0, 45, '%MODULES_IMPEXPORT%'),
(111, 'condizioni di completamento', NULL, 'basic pin', NULL, NULL, '%MODULES_SERVICECOMPLETE_HTTP%', 'index.php', NULL, NULL, 0, 0, 45, '%MODULES_SERVICECOMPLETE%'),
(112, 'newsletter', NULL, 'mail outline', '', NULL, '%MODULES_NEWSLETTER_HTTP%', NULL, NULL, NULL, 0, 0, 15, '%MODULES_NEWSLETTER%'),
(114, 'aggiungi provider', NULL, 'archive', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'add_tester.php', NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(115, 'aggiungi servizio', NULL, 'tags', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'add_service.php', NULL, NULL, 0, 0, 0, '%ALWAYS%'),
(116, 'aggiungi utente', NULL, 'basic add user', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'add_user.php', NULL, NULL, 0, 0, 10, '%ALWAYS%'),
(117, 'importa una lingua', NULL, 'download disk', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'import_language.php', NULL, NULL, 0, 0, 15, '%ALWAYS%'),
(118, 'edit news content', NULL, 'edit', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'edit_content.php?type=news', NULL, NULL, 0, 0, 25, '%ALWAYS%'),
(119, 'edit info content', NULL, 'edit', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'edit_content.php?type=info', NULL, NULL, 0, 0, 30, '%ALWAYS%'),
(120, 'edit help content', NULL, 'edit', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'edit_content.php?type=help', NULL, NULL, 0, 0, 30, '%ALWAYS%'),
(121, 'modifica il profilo del provider', NULL, 'pencil', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'edit_tester.php', 'id_tester', NULL, 0, 0, 0, '%ALWAYS%'),
(122, 'gestisci associazione corsi', NULL, 'unlink', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'manage_provider_courses.php', 'id_tester', NULL, 0, 0, 5, '%ALWAYS%'),
(123, 'lista utenti', NULL, 'basic users', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'list_users.php', 'id_tester', NULL, 0, 0, 15, '%ALWAYS%'),
(124, 'admins list', NULL, 'basic users', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'list_users.php?user_type=2', 'id_tester', NULL, 0, 0, 0, '%ALWAYS%'),
(125, 'switcher list', NULL, 'basic users', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'list_users.php?user_type=6', 'id_tester', NULL, 0, 0, 10, '%ALWAYS%'),
(126, 'authors list', NULL, 'basic users', NULL, '', '%HTTP_ROOT_DIR%/admin', 'list_users.php?user_type=1', 'id_tester', NULL, 0, 0, 15, '%ALWAYS%'),
(127, 'tutors list', NULL, 'basic users', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'list_users.php?user_type=4', 'id_tester', NULL, 0, 0, 20, '%ALWAYS%'),
(128, 'students list', NULL, 'basic users', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'list_users.php?user_type=3', 'id_tester', NULL, 0, 0, 25, '%ALWAYS%'),
(129, 'all users list', NULL, 'basic users', NULL, NULL, '%HTTP_ROOT_DIR%/admin', 'list_users.php', 'id_tester', NULL, 0, 0, 30, '%ALWAYS%');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;



-- --------------------------------------------------------

--
-- Struttura della tabella `menu_tree`
--

CREATE TABLE IF NOT EXISTS `menu_tree` (
  `tree_id` int(10) unsigned NOT NULL,
  `parent_id` int(10) unsigned NOT NULL DEFAULT '0',
  `item_id` int(10) unsigned NOT NULL DEFAULT '0',
  `extraClass` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`tree_id`,`parent_id`,`item_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dump dei dati per la tabella `menu_tree`
--

INSERT INTO `menu_tree` (`tree_id`, `parent_id`, `item_id`, `extraClass`) VALUES
(1, 0, 1, 'homeExtraClass'),
(1, 0, 2, 'comunicaExtraClass'),
(1, 2, 3, ''),
(1, 2, 4, ''),
(1, 0, 9, ''),
(1, 0, 10, ''),
(1, 0, 11, ''),
(2, 0, 14, ''),
(2, 0, 15, ''),
(2, 0, 16, ''),
(2, 16, 17, ''),
(2, 16, 18, ''),
(3, 0, 1, ''),
(3, 0, 15, ''),
(3, 0, 16, ''),
(3, 16, 17, ''),
(3, 16, 18, ''),
(4, 0, 1, ''),
(4, 0, 14, ''),
(4, 0, 16, ''),
(4, 16, 17, ''),
(4, 16, 18, ''),
(5, 0, 1, ''),
(5, 0, 2, ''),
(5, 2, 3, ''),
(5, 0, 16, ''),
(5, 16, 17, ''),
(5, 16, 18, ''),
(5, 0, 9, ''),
(5, 0, 20, ''),
(5, 20, 21, ''),
(5, 0, 22, ''),
(5, 22, 23, ''),
(5, 0, 15, ''),
(5, 0, 24, ''),
(1, 0, 24, ''),
(1, 2, 25, ''),
(1, 2, 26, ''),
(1, 2, 27, ''),
(1, 20, 28, ''),
(1, 20, 29, ''),
(1, 20, 30, ''),
(1, 20, 31, ''),
(1, 20, 32, ''),
(1, 20, 33, ''),
(1, 0, 20, ''),
(1, 20, 21, ''),
(1, 0, 22, ''),
(1, 22, 23, ''),
(1, 22, 34, ''),
(79, 20, 21, ''),
(79, 2, 3, ''),
(1, 0, 16, ''),
(1, 16, 17, ''),
(1, 16, 18, ''),
(6, 0, 1, ''),
(6, 0, 20, ''),
(6, 20, 28, ''),
(6, 20, 29, ''),
(6, 20, 31, ''),
(6, 20, 32, ''),
(6, 20, 33, ''),
(6, 0, 22, ''),
(6, 22, 23, ''),
(6, 0, 16, ''),
(6, 16, 17, ''),
(6, 16, 18, ''),
(6, 0, 9, ''),
(6, 0, 24, ''),
(6, 0, 10, ''),
(7, 0, 37, ''),
(7, 0, 22, ''),
(7, 22, 38, ''),
(7, 22, 39, ''),
(7, 0, 24, ''),
(7, 0, 9, ''),
(9, 22, 100, ''),
(9, 0, 11, ''),
(10, 0, 1, ''),
(10, 0, 2, ''),
(10, 2, 3, ''),
(10, 0, 20, ''),
(10, 20, 21, ''),
(10, 0, 15, ''),
(10, 0, 16, ''),
(10, 16, 17, ''),
(10, 16, 18, ''),
(10, 0, 9, ''),
(10, 0, 24, ''),
(10, 0, 22, ''),
(10, 22, 23, ''),
(11, 0, 1, ''),
(11, 0, 2, ''),
(11, 0, 9, ''),
(11, 0, 15, ''),
(11, 0, 16, ''),
(11, 0, 20, ''),
(11, 0, 24, ''),
(11, 2, 3, ''),
(11, 16, 17, ''),
(11, 16, 18, ''),
(11, 20, 21, ''),
(12, 0, 1, ''),
(12, 0, 22, ''),
(12, 22, 23, ''),
(12, 22, 40, ''),
(12, 22, 41, ''),
(13, 0, 42, ''),
(13, 0, 43, ''),
(13, 0, 44, ''),
(13, 0, 24, ''),
(14, 0, 42, ''),
(14, 0, 45, ''),
(14, 0, 24, ''),
(16, 0, 42, ''),
(16, 0, 24, ''),
(16, 0, 46, ''),
(17, 0, 42, ''),
(17, 0, 24, ''),
(17, 0, 47, ''),
(108, 0, 1, ''),
(106, 0, 113, ''),
(106, 16, 18, ''),
(106, 16, 17, ''),
(22, 0, 16, ''),
(22, 0, 1, ''),
(20, 0, 1, ''),
(20, 0, 2, ''),
(20, 2, 49, ''),
(20, 2, 50, ''),
(20, 0, 20, ''),
(20, 0, 22, ''),
(20, 20, 51, ''),
(20, 22, 23, ''),
(20, 0, 24, ''),
(20, 0, 16, ''),
(20, 0, 9, ''),
(20, 16, 17, ''),
(20, 16, 18, ''),
(21, 0, 42, ''),
(21, 0, 43, ''),
(21, 0, 52, ''),
(21, 0, 24, ''),
(22, 0, 9, ''),
(22, 16, 17, ''),
(22, 16, 18, ''),
(22, 0, 10, ''),
(22, 0, 24, ''),
(23, 0, 48, ''),
(24, 0, 54, ''),
(24, 0, 24, ''),
(9, 22, 99, ''),
(82, 0, 24, ''),
(82, 0, 55, ''),
(84, 0, 56, ''),
(84, 0, 57, ''),
(84, 0, 58, ''),
(28, 0, 24, ''),
(28, 0, 1, ''),
(28, 0, 15, ''),
(28, 0, 16, ''),
(28, 16, 17, ''),
(28, 16, 18, ''),
(28, 0, 9, ''),
(29, 0, 42, ''),
(29, 0, 24, ''),
(30, 0, 1, ''),
(30, 0, 22, ''),
(30, 22, 23, ''),
(30, 0, 15, ''),
(30, 0, 16, ''),
(30, 16, 17, ''),
(30, 16, 18, ''),
(30, 0, 24, ''),
(30, 0, 9, ''),
(6, 0, 11, ''),
(34, 0, 1, ''),
(34, 0, 2, ''),
(34, 0, 20, ''),
(34, 2, 3, ''),
(34, 2, 50, ''),
(40, 0, 1, ''),
(40, 0, 2, ''),
(40, 2, 3, ''),
(40, 0, 20, ''),
(40, 20, 21, ''),
(40, 0, 22, ''),
(40, 22, 60, ''),
(40, 0, 24, ''),
(40, 0, 16, ''),
(40, 16, 17, ''),
(40, 16, 18, ''),
(40, 0, 9, ''),
(34, 20, 21, ''),
(34, 0, 22, ''),
(34, 22, 23, ''),
(34, 0, 15, ''),
(34, 0, 24, ''),
(34, 0, 16, ''),
(34, 16, 17, ''),
(34, 16, 18, ''),
(34, 0, 9, ''),
(45, 0, 2, ''),
(45, 2, 3, ''),
(45, 2, 4, ''),
(45, 2, 25, ''),
(45, 2, 26, ''),
(45, 2, 27, ''),
(45, 0, 16, ''),
(45, 16, 17, ''),
(45, 16, 18, ''),
(45, 0, 1, ''),
(45, 0, 9, ''),
(45, 0, 10, ''),
(45, 0, 11, ''),
(45, 0, 20, ''),
(45, 0, 22, ''),
(45, 0, 24, ''),
(45, 20, 21, ''),
(45, 20, 28, ''),
(45, 20, 29, ''),
(53, 2, 3, ''),
(53, 0, 2, ''),
(53, 0, 1, ''),
(45, 20, 33, ''),
(45, 22, 23, ''),
(45, 22, 34, ''),
(79, 2, 63, ''),
(84, 0, 24, ''),
(53, 2, 50, ''),
(53, 0, 20, ''),
(53, 20, 21, ''),
(53, 0, 22, ''),
(53, 22, 23, ''),
(53, 22, 40, ''),
(53, 22, 41, ''),
(53, 22, 61, ''),
(53, 22, 62, ''),
(56, 0, 1, ''),
(56, 0, 2, ''),
(56, 0, 24, ''),
(56, 0, 9, ''),
(56, 0, 16, ''),
(56, 16, 17, ''),
(56, 16, 18, ''),
(56, 2, 3, ''),
(56, 2, 63, ''),
(56, 0, 20, ''),
(56, 20, 21, ''),
(56, 0, 22, ''),
(56, 22, 25, ''),
(53, 22, 64, ''),
(53, 22, 65, ''),
(53, 0, 24, ''),
(53, 0, 9, ''),
(53, 0, 16, ''),
(53, 16, 17, ''),
(53, 16, 18, ''),
(41, 0, 1, ''),
(41, 0, 2, ''),
(41, 2, 3, ''),
(42, 0, 63, ''),
(41, 2, 63, ''),
(41, 0, 20, ''),
(41, 20, 21, ''),
(41, 0, 24, ''),
(41, 0, 9, ''),
(41, 0, 16, ''),
(41, 16, 17, ''),
(41, 16, 18, ''),
(57, 0, 1, ''),
(57, 0, 2, ''),
(57, 0, 9, ''),
(57, 0, 16, ''),
(57, 0, 20, ''),
(57, 0, 22, ''),
(57, 0, 24, ''),
(57, 2, 3, ''),
(57, 16, 17, ''),
(57, 16, 18, ''),
(57, 20, 21, ''),
(57, 22, 60, ''),
(57, 2, 63, ''),
(58, 0, 1, ''),
(58, 0, 2, ''),
(58, 0, 9, ''),
(58, 0, 16, ''),
(58, 0, 20, ''),
(58, 0, 22, ''),
(58, 0, 24, ''),
(58, 2, 3, ''),
(58, 2, 63, ''),
(58, 16, 17, ''),
(58, 16, 18, ''),
(58, 20, 21, ''),
(58, 22, 25, ''),
(58, 22, 66, ''),
(58, 22, 67, ''),
(59, 0, 1, ''),
(59, 0, 2, ''),
(59, 2, 50, ''),
(59, 2, 3, ''),
(59, 0, 20, ''),
(59, 20, 21, ''),
(59, 0, 22, ''),
(59, 22, 23, ''),
(59, 22, 68, ''),
(59, 22, 69, ''),
(60, 0, 1, ''),
(60, 0, 2, ''),
(60, 2, 3, ''),
(60, 2, 4, ''),
(60, 0, 20, ''),
(60, 20, 21, ''),
(60, 0, 22, ''),
(60, 22, 70, ''),
(60, 22, 71, ''),
(60, 22, 72, ''),
(60, 22, 73, ''),
(60, 22, 74, ''),
(60, 22, 68, ''),
(60, 22, 75, ''),
(60, 22, 76, ''),
(60, 22, 77, ''),
(60, 22, 78, ''),
(60, 22, 79, ''),
(60, 22, 80, ''),
(60, 0, 24, ''),
(60, 0, 9, ''),
(60, 0, 16, ''),
(60, 16, 17, ''),
(60, 16, 18, ''),
(59, 22, 81, ''),
(59, 22, 82, ''),
(59, 0, 24, ''),
(59, 0, 9, ''),
(59, 0, 16, ''),
(59, 16, 17, ''),
(59, 16, 18, ''),
(61, 0, 1, ''),
(61, 0, 2, ''),
(61, 2, 3, ''),
(61, 0, 20, ''),
(61, 20, 21, ''),
(61, 0, 22, ''),
(61, 22, 70, ''),
(61, 22, 68, ''),
(61, 0, 24, ''),
(61, 0, 9, ''),
(61, 0, 16, ''),
(61, 16, 17, ''),
(61, 16, 18, ''),
(62, 0, 1, ''),
(62, 0, 2, ''),
(62, 2, 3, ''),
(62, 2, 50, ''),
(62, 0, 20, ''),
(62, 20, 21, ''),
(62, 0, 22, ''),
(62, 22, 23, ''),
(62, 22, 68, ''),
(62, 22, 69, ''),
(62, 22, 81, ''),
(62, 22, 70, ''),
(62, 22, 83, ''),
(62, 0, 24, ''),
(62, 0, 9, ''),
(62, 0, 16, ''),
(62, 16, 17, ''),
(62, 16, 18, ''),
(63, 0, 1, ''),
(63, 0, 2, ''),
(63, 2, 3, ''),
(63, 0, 20, ''),
(63, 20, 21, ''),
(63, 0, 22, ''),
(63, 22, 70, ''),
(63, 22, 84, ''),
(63, 22, 85, ''),
(63, 22, 68, ''),
(63, 22, 86, ''),
(63, 0, 24, ''),
(63, 0, 9, ''),
(63, 0, 16, ''),
(63, 16, 17, ''),
(63, 16, 18, ''),
(79, 22, 108, ''),
(79, 22, 107, ''),
(79, 22, 106, ''),
(79, 22, 105, ''),
(79, 22, 104, ''),
(79, 22, 103, ''),
(79, 22, 102, ''),
(79, 22, 101, ''),
(79, 22, 23, ''),
(79, 0, 20, ''),
(79, 16, 18, ''),
(79, 16, 17, ''),
(79, 0, 16, ''),
(79, 0, 9, ''),
(79, 0, 24, ''),
(79, 0, 22, ''),
(9, 16, 18, ''),
(9, 16, 17, ''),
(9, 0, 16, ''),
(9, 0, 9, ''),
(9, 0, 24, ''),
(77, 0, 24, ''),
(77, 0, 56, ''),
(77, 0, 9, ''),
(9, 22, 98, ''),
(9, 22, 97, ''),
(9, 22, 96, ''),
(9, 22, 23, ''),
(9, 0, 22, ''),
(9, 20, 33, ''),
(9, 20, 28, ''),
(9, 0, 20, ''),
(9, 0, 10, ''),
(9, 2, 4, ''),
(9, 0, 2, ''),
(9, 0, 1, ''),
(106, 0, 1, ''),
(106, 0, 9, ''),
(106, 0, 16, ''),
(79, 0, 1, ''),
(106, 0, 24, ''),
(69, 16, 18, ''),
(69, 16, 17, ''),
(69, 0, 16, ''),
(69, 0, 9, ''),
(69, 0, 24, ''),
(79, 0, 2, ''),
(69, 22, 23, ''),
(69, 22, 95, ''),
(69, 0, 22, ''),
(69, 0, 1, ''),
(68, 16, 18, ''),
(68, 16, 17, ''),
(68, 0, 16, ''),
(68, 0, 9, ''),
(68, 0, 24, ''),
(68, 20, 51, ''),
(68, 0, 20, ''),
(68, 2, 50, ''),
(68, 2, 49, ''),
(68, 0, 2, ''),
(68, 0, 1, ''),
(79, 22, 109, ''),
(79, 22, 110, ''),
(79, 22, 111, ''),
(79, 2, 112, ''),
(105, 0, 1, ''),
(105, 0, 9, ''),
(105, 0, 16, ''),
(105, 0, 24, ''),
(105, 16, 17, ''),
(105, 16, 18, ''),
(108, 0, 2, ''),
(108, 2, 3, ''),
(102, 2, 112, ''),
(108, 2, 112, ''),
(108, 0, 20, ''),
(108, 20, 21, ''),
(108, 0, 22, ''),
(108, 0, 9, ''),
(108, 0, 16, ''),
(108, 16, 17, ''),
(108, 16, 18, ''),
(108, 22, 101, ''),
(108, 22, 102, ''),
(108, 22, 103, ''),
(108, 22, 104, ''),
(108, 22, 105, ''),
(108, 22, 106, ''),
(108, 22, 107, ''),
(108, 22, 108, ''),
(108, 22, 109, ''),
(108, 22, 110, ''),
(108, 22, 111, ''),
(124, 0, 1, ''),
(124, 0, 9, ''),
(124, 0, 16, ''),
(124, 0, 24, ''),
(124, 16, 17, ''),
(124, 16, 18, ''),
(124, 0, 56, ''),
(130, 0, 1, ''),
(130, 0, 9, ''),
(130, 0, 16, ''),
(130, 16, 17, ''),
(130, 16, 18, ''),
(130, 0, 22, ''),
(130, 22, 114, ''),
(130, 22, 115, ''),
(130, 22, 116, ''),
(130, 22, 117, ''),
(130, 22, 118, ''),
(130, 22, 119, ''),
(130, 22, 120, ''),
(132, 0, 22, ''),
(132, 22, 121, ''),
(132, 0, 1, ''),
(132, 0, 9, ''),
(132, 0, 16, ''),
(132, 16, 17, ''),
(132, 16, 18, ''),
(132, 22, 122, ''),
(132, 22, 123, ''),
(133, 0, 1, ''),
(133, 0, 22, ''),
(133, 0, 9, ''),
(133, 0, 24, ''),
(133, 0, 16, ''),
(133, 16, 17, ''),
(133, 16, 18, ''),
(130, 0, 24, ''),
(132, 0, 24, ''),
(133, 22, 124, ''),
(133, 22, 125, ''),
(132, 0, 0, ''),
(133, 22, 126, ''),
(133, 22, 127, ''),
(133, 22, 128, ''),
(133, 22, 129, ''),
(135, 0, 1, ''),
(135, 0, 16, ''),
(135, 16, 18, ''),
(135, 16, 17, ''),
(135, 0, 9, ''),
(135, 0, 11, ''),
(135, 0, 10, ''),
(138, 0, 16, ''),
(138, 16, 17, ''),
(138, 16, 18, ''),
(138, 0, 15, ''),
(138, 0, 14, '');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
