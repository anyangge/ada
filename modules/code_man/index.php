<?php
/**
 * Code Management
 *
 * @package		code_man
 * @author		giorgio
 * @copyright	Copyright (c) 2009, Lynx s.r.l.
 * @license		http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2
 * @link		code_man
 * @version		0.1
 */

/**
 * Base config file
 */
require_once (realpath(dirname(__FILE__)) . '/../../config_path.inc.php');

/**
 * Clear node and layout variable in $_SESSION
 */
$variableToClearAR = array('layout');
/**
 * Users (types) allowed to access this module.
 */
$allowedUsersAr = array(AMA_TYPE_SWITCHER);

/**
 * Get needed objects
 */
$neededObjAr = array(
    AMA_TYPE_SWITCHER => array('layout'),
);

/**
 * Performs basic controls before entering this module
 */
require_once(ROOT_DIR.'/include/module_init.inc.php');
require_once(CORE_LIBRARY_PATH.'/includes.inc.php');
require_once(ROOT_DIR.'/switcher/include/switcher_functions.inc.php');

require_once(MODULES_CODEMAN_PATH.'/config/config.inc.php');
require_once(MODULES_CODEMAN_PATH.'/include/init.inc.php');

$self = 'code_man';

require_once(MODULES_CODEMAN_PATH.'/include/management/codemanManagement.inc.php');
$management = new codemanManagement();
$form_return = $management->form();

/*
 * Go back link
 */
$back_link = CDOMElement::create('a', 'href:'.HTTP_ROOT_DIR);
$back_link->addChild(new CText(translateFN('Torna')));

$content_dataAr = array(
		'user_name' => $user_name,
		'user_type' => $user_type,
		'status' => $form_return['status'],
		'label' => $label,
		'help' => translateFN('Gestione codici iscrizione studenti'),
		'data' => $form_return['html'],
		'module' => $module,
		'ajax_chat_link' => $chatrooms_link,
		'messages' => $user_messages->getHtml()
);


// $layout_dataAr['JS_filename'] = array(
// 		JQUERY,
// 		MODULES_CODEMAN_PATH.'/js/jquery.maskedinput.min.js',
// 		JQUERY_NO_CONFLICT,
// );


ARE::render($layout_dataAr, $content_dataAr);
