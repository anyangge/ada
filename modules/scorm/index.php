<?php
/**
 * SCORM MODULE.
 *
 * @package        scorm module
 * @author         Giorgio Consorti <g.consorti@lynxlab.com>
 * @copyright      Copyright (c) 2016, Lynx s.r.l.
 * @license        http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2
 * @link           scorm
 * @version		   0.1
 */

ini_set('display_errors', '0'); error_reporting(E_ALL);
/**
 * Base config file
*/
require_once (realpath(dirname(__FILE__)) . '/../../config_path.inc.php');

/**
 * Clear node and layout variable in $_SESSION
*/
$variableToClearAR = array('node', 'layout', 'course', 'user');

/**
 * Users (types) allowed to access this module.
*/
$allowedUsersAr = array ( AMA_TYPE_VISITOR, AMA_TYPE_STUDENT, AMA_TYPE_TUTOR, AMA_TYPE_AUTHOR, AMA_TYPE_SWITCHER, AMA_TYPE_SUPERTUTOR );

/**
 * Get needed objects
 * This is generated from ADA Eclipse Developer Plugin, use it as an example!
 */
$neededObjAr = array (
		AMA_TYPE_VISITOR =>    array ('layout'),
		AMA_TYPE_STUDENT =>    array ('layout'),
		AMA_TYPE_TUTOR =>      array ('layout'),
		AMA_TYPE_AUTHOR =>     array ('layout'),
		AMA_TYPE_SWITCHER =>   array ('layout'),
		AMA_TYPE_SUPERTUTOR => array ('layout')
);
/**
 * Performs basic controls before entering this module
*/
require_once(ROOT_DIR.'/include/module_init.inc.php');
require_once(ROOT_DIR.'/browsing/include/browsing_functions.inc.php');

// MODULE's OWN IMPORTS
require_once MODULES_SCORM_PATH .'/config/config.inc.php';
require_once MODULES_SCORM_PATH.'/include/AMAScormDataHandler.inc.php';

$self = 'scorm';

$GLOBALS['dh'] = AMAScormDataHandler::instance(MultiPort::getDSN($_SESSION['sess_selected_tester']));

/**
 * TODO: Add your own code here
 */

$content_dataAr = array(
		'user_name' => $user_name,
		'user_type' => $user_type,
		'messages' => $user_messages->getHtml(),
		'agenda' => $user_agenda->getHtml(),
		'status' => $status,
		'title' => translateFN('scorm'),
		'data' => $data,
);

$optionsAr['onload_func'] = 'initDoc();';

ARE::render($layout_dataAr, $content_dataAr, NULL, $optionsAr);
?>