<?php
/**
 * registration.php file
 *
 * This script is responsible for the user registration process.
 *
 * @package		Default
 * @author		Stefano Penge <steve@lynxlab.com>
 * @author		Maurizio "Graffio" Mazzoneschi <graffio@lynxlab.com>
 * @author		Vito Modena <vito@lynxlab.com>
 * @copyright	Copyright (c) 2009-2010, Lynx s.r.l.
 * @license		http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2
 * @link		registration
 * @version		0.1
 */
/**
 * Base config file
 */
require_once realpath(dirname(__FILE__)).'/../config_path.inc.php';
/**
 * Clear node and layout variable in $_SESSION
 */
$variableToClearAR = array('node', 'layout', 'course');
/**
 * Users (types) allowed to access this module.
 */
$allowedUsersAr = array(AMA_TYPE_VISITOR);
/**
 * Get needed objects
 */

$neededObjAr = array(
  AMA_TYPE_VISITOR      => array('layout')
);
require_once ROOT_DIR.'/include/module_init.inc.php';
require_once ROOT_DIR.'/browsing/include/browsing_functions.inc.php';
require_once ROOT_DIR.'/include/Forms/UserRegistrationForm.inc.php';
include_once ROOT_DIR.'/include/token_classes.inc.php';
require_once ROOT_DIR . '/include/CourseInstance.inc.php';

//require_once ROOT_DIR.'/browsing/include/registration_functions.inc.php';

$self =  'registration';
/**
 * Negotiate login page language
 */

if (!isset($_SESSION['sess_user_language'])) {
  Translator::loadSupportedLanguagesInSession();
  $login_page_language_code = Translator::negotiateLoginPageLanguage();
  $_SESSION['sess_user_language'] = $login_page_language_code;
}
$supported_languages = Translator::getSupportedLanguages();

if (defined('MODULES_CODEMAN') && MODULES_CODEMAN) {
	$codeman = true;
	require_once MODULES_CODEMAN_PATH.'/config/config.inc.php';
} else $codeman = false;

if ($codeman) {
	if(isset($_SERVER['REQUEST_METHOD']) && $_SERVER['REQUEST_METHOD'] == 'POST') {
	    /*
	     * The user is associated by default to the public tester.
	     */
    	$tester = ADA_PUBLIC_TESTER;
	    /*
	     * Validate the user submitted data and proceed to the user registration.
	     */
    	$form = new UserRegistrationForm(TRUE);
    	$form->fillWithPostData();
    	if($form->isValid()) {
        	$user_dataAr = $form->toArray();
        	$user_dataAr['username'] = $_POST['email'];
        
	        $userObj = new ADAUser($user_dataAr);
	        $userObj->setLayout('');
	        $userObj->setType(AMA_TYPE_STUDENT);
	        $userObj->setStatus(ADA_STATUS_PRESUBSCRIBED);
	        // Random password.
	        $userObj->setPassword(sha1(time()));

	        /*
	         * read the code to subscribe student to Instance
	         */
                $code_file = CODE_FILE_DIR.CODE_FILE_NAME;
        	$REG_code = $_POST['codice'];
//	$valid_codesAr = file($code_file);
//	$valid_codesAr = array_map("trim",$valid_codesAr);
//
//         $codeExists = get_cod_subscribed(); 
	       /*
	        * check if code exists in code file
	        * @param file_name (complete path)
	        * @return: id instance_cod
	        * @return: provider (es: client1)
	        */
	        $codeTxt = file_get_contents($code_file);
	        $string_to_search = '#(' . $REG_code .') (\d{1,4}) (\S+)#';
	        preg_match_all($string_to_search, $codeTxt, $stringFound);
	        $code_found = $stringFound[1][0]; //$REG_code;
	        $instance_id_found = $stringFound[2][0];
	        $client_found = $stringFound[3][0];

        	if ($code_found == $REG_code) {
                    
	            $codeUsed = Multiport::get_cod_subscribed_on_tester($code_found,$instance_id_found,$client_found);
	            $instance_data = Multiport::course_instance_data_get_on_tester($instance_id_found,$client_found);
                    $istanceStatus = $instance_data['status'];
	            $instanceStartStudentLevel = $instance_data['start_level_student'];
                    
                    if ($codeUsed == TRUE) {
	                $message = translateFN('Impossibile procedere. CODICE già utilizzato:')
	                         . ' ' . $code_found;
	                header('Location:'.HTTP_ROOT_DIR.'/browsing/registration_cod.php?message='.$message);
	                exit();
	            }
	            if (AMA_DataHandler::isError($instance_data)) {
	//            if((!AMA_DataHandler::isError($instance_exists)) || ($instance_exists >= 0 && $instance_exists < 3)) {
	//            if ($instance_exists) {
	                $message = translateFN('Impossibile procedere. Classe non esistente:')
	                         . ' ' . $instance_id_found;
	                header('Location:'.HTTP_ROOT_DIR.'/browsing/registration_cod.php?message='.$message);
	                exit();
	            } 
	            //$id_user = Multiport::addUser($userObj,array($client_found));
	            $id_user = Multiport::addUser($userObj,array($tester, $client_found));
	            if($id_user < 0) {
	                /*$message = translateFN('Impossibile procedere. Un utente con questi dati esiste?')
	                         . ' ' . $id_user;*/
                        
                       /*se l'utente è registrato ma non è iscritto all'istanza lo iscrivo*/
                        
                       $user_data=Multiport::findUserByUsername($userObj->getUserName());
                       
                       /*registro ,eventualmente, l'utente sul tester dell'istanza*/
                      if(!in_array($client_found,$user_data->getTesters()))
                      {
                        $addUser=Multiport::setUser($user_data, array($client_found));
                      }
                       
                       /*devo ricalcolare il data handler perchè findByUsername lo imposta al provider di default*/
                       $provider_dh=AMA_DataHandler::instance(MultiPort::getDSN($client_found));
                       $id_user=$user_data->id_user;
                       $flag_subscribed=true;
                       $flag_Update_subscription=false;
                       $iscr=$provider_dh->get_subscription($id_user,$instance_id_found);
                       if(AMA_DB::isError($iscr))
                       {
                            $flag_subscribed=false;
                       }
                       else
                       {
                           if(!empty($iscr) && $iscr['tipo']==1)
                           {
                                $livello = $instanceStartStudentLevel;
                                $Result = Multiport::course_instance_subscribe_to_tester($instance_id_found,$id_user,$livello,$client_found,$instance_data['Sponsor']);
                                if (AMA_DataHandler::isError($Result)){
                                    $status = $Result->getMessage();
                                }
                                else
                                {
                                    $flag_Update_subscription=true;
                                }
                           }
                           else
                           {
                               $flag_subscribed=true;
                           }
                       }
                       if(!$flag_subscribed)
                       {
                           $livello = $instanceStartStudentLevel;
                           $Result2 = Multiport::course_instance_presubscribe_to_tester($instance_id_found,$id_user,$livello,$client_found,$code_found,$instance_data['Sponsor']);
                           if (AMA_DataHandler::isError($Result2)){
	                   $status = $Result2->getMessage();
                            } else {
	                    // iscrizione al corso
	                    //$result3 = $dh->course_instance_student_subscribe($instance_id_found, $id_user);
	                    $Result3 = Multiport::course_instance_subscribe_to_tester($instance_id_found,$id_user,$livello,$client_found,$instance_data['Sponsor']);
                            if (AMA_DataHandler::isError($Result3)){
                                $status = $Result3->getMessage();
	                    }
                            }
                       }
                       if(!$flag_subscribed || $flag_Update_subscription)
                       {
                        /**
                         * Create a registration token for this user and send it to the user
                         * with the confirmation request.
                         */
                        $tokenObj = TokenManager::createTokenForUserRegistration($userObj);
                        if($tokenObj == false) {
                            $message = translateFN('An error occurred while performing your request. Pleaser try again later.');
                            header('Location:'.HTTP_ROOT_DIR."/index.php?message=$message");
                            exit();
                        }
                        $token = $tokenObj->getTokenString();

                        $admtypeAr = array(AMA_TYPE_ADMIN);
                        $admList = $common_dh-> get_users_by_type($admtypeAr);
                        if (!AMA_DataHandler::isError($admList)){
                            $adm_uname = $admList[0]['username'];
                        } else {
                            $adm_uname = ''; // ??? FIXME: serve un superadmin nel file di config?
                        }

                        $title = PORTAL_NAME . translateFN(' Notifica iscrizione corso.');

                       
                        $text = sprintf(translateFN('Gentile %s, è stato iscritto al corso %s del Provider %s.'),
                                $userObj->getFullName(),$courseTitle, PORTAL_NAME);
                        $message_ha = array(
                            'titolo' => $title,
                            'testo' => $text,
                            'destinatari' => array($userObj->getUserName()),
                            'data_ora' => 'now',
                            'tipo' => ADA_MSG_SIMPLE,
                            'mittente' => $adm_uname
                        );
                        $mh = MessageHandler::instance(MultiPort::getDSN($tester));
                        /**
                         * Send the message as an internal message
                         */
                        $result = $mh->send_message($message_ha);
                        if(AMA_DataHandler::isError($result)) {
                        }
                        /**
                         * Send the message an email message
                         */
                        $message_ha['tipo'] = ADA_MSG_MAIL;
                        $result = $mh->send_message($message_ha);
                        if(AMA_DataHandler::isError($result)) {
                        }
                            $message="<strong>".translateFN('ATTENZIONE: ').'</strong>'.translateFN('Utente già registrato,prego effettuare il login');
                       }
                       if($flag_subscribed)
                       {
                           $message="<strong>".translateFN('ATTENZIONE: ').'</strong>'.translateFN('Utente già registrato e iscritto al corso,prego effettuare il login');
                       }
                       header('Location:'.HTTP_ROOT_DIR.'/index.php?message='.$message);
	               exit();
	            }
                    
	            $livello = $instanceStartStudentLevel;
//      	      $livello = 1;
                    $result2 = Multiport::course_instance_presubscribe_to_tester($instance_id_found,$id_user,$livello,$client_found,$code_found,$instance_data['Sponsor']);
	            //$result2 = $dh->course_instance_student_presubscribe_add($instance_id_found,$id_user);
	             if (AMA_DataHandler::isError($result2)){
	                      $status = $result2->getMessage();
	             } else {
	                    // iscrizione al corso
	                    //$result3 = $dh->course_instance_student_subscribe($instance_id_found, $id_user);
	                    $result3 = Multiport::course_instance_subscribe_to_tester($instance_id_found,$id_user,$livello,$client_found,$instance_data['Sponsor']);
	                    if (AMA_DataHandler::isError($result3)){
	                        $status = $result3->getMessage();
	                    }
	             }
	            } else {
	                $message = translateFN('Impossibile procedere. Il codice inserito non è valido');
	                header('Location:'.HTTP_ROOT_DIR.'/browsing/registration_cod.php?message='.$message);
                        exit();
				}
	
	        /**
	         * Create a registration token for this user and send it to the user
	         * with the confirmation request.
	         */
	        $tokenObj = TokenManager::createTokenForUserRegistration($userObj);
	        if($tokenObj == false) {
	            $message = translateFN('An error occurred while performing your request. Pleaser try again later.');
	            header('Location:'.HTTP_ROOT_DIR."/index.php?message=$message");
	            exit();
	        }
        	$token = $tokenObj->getTokenString();

        	$admtypeAr = array(AMA_TYPE_ADMIN);
        	$admList = $common_dh-> get_users_by_type($admtypeAr);
	        if (!AMA_DataHandler::isError($admList)){
	            $adm_uname = $admList[0]['username'];
	        } else {
	            $adm_uname = ''; // ??? FIXME: serve un superadmin nel file di config?
	        }

	        $title = PORTAL_NAME . translateFN('ti preghiamo di confermare la tua richiesta di registrazione.');
              
	        $text = sprintf(translateFN('Gentile %s, ti chiediamo di confermare la tua registrazione al Provider %s.'),
	                $userObj->getFullName(), PORTAL_NAME)
	              . PHP_EOL . PHP_EOL
	              . translateFN('Lo username che ti è stato assegnato è il seguente:')
	              . ' ' . $userObj->getUserName()
	              . PHP_EOL . PHP_EOL
	              . sprintf(translateFN('Puoi confermare la tua registrazione al Provider %s seguendo questo link:'), PORTAL_NAME)
	              . PHP_EOL
	              . ' ' . HTTP_ROOT_DIR."/browsing/confirm.php?uid=$id_user&tok=$token ";
              $message_ha = array(
	            'titolo' => $title,
	            'testo' => $text,
	            'destinatari' => array($userObj->getUserName()),
	            'data_ora' => 'now',
	            'tipo' => ADA_MSG_SIMPLE,
	            'mittente' => $adm_uname
	        );
	        $mh = MessageHandler::instance(MultiPort::getDSN($tester));
	        /**
	         * Send the message as an internal message
	         */
	        $result = $mh->send_message($message_ha);
	        if(AMA_DataHandler::isError($result)) {
	        }
	        /**
	         * Send the message an email message
	         */
	        $message_ha['tipo'] = ADA_MSG_MAIL;
	        $result = $mh->send_message($message_ha);
	        if(AMA_DataHandler::isError($result)) {
	        }
	
	        /*
	         * Redirect the user to the "registration succeeded" page.
	         */
	        header('Location: ' . HTTP_ROOT_DIR . '/browsing/registration_cod.php?op=success');
	        exit();
    	} else {
	        header('Location: ' . HTTP_ROOT_DIR . '/browsing/registration_cod.php');
	        exit();
	    }
	} elseif (isset($_GET['op']) && $_GET['op'] == 'success') {
	    /*
	     * The user registration was completed with success.
	     * Generate a feedback message for the user.
	     */
	    $help = '';
	    $data  = translateFN('Richiesta di registrazione completata.')
	              . '<br />'
	              . translateFN('You will receive an email with informations on how to login.');
	} else {
	    /*
	     * Display the registration form.
	     */
	     $welcome_file = ROOT_DIR."/docs/welcome_registrazione_codice.txt";
	     if (@file_exists($welcome_file)){
	         $fp = fopen($welcome_file,'r');
	         $help = fread ($fp, filesize ($welcome_file));
	         fclose ($fp);
	         $help = sprintf($help, PORTAL_NAME);
	         $help = nl2br($help);
	     } else {
	        $help = translateFN('Da questa pagina puoi effettuare la registrazione a').' '.PORTAL_NAME;
	     }
	
	    $error_div = CDOMElement::create('DIV', 'id:error_form');
	    $error_div->setAttribute('class', 'hide_error');
	    $error_div->addChild(new CText(translateFN("ATTENZIONE: Ci sono degli errori nel modulo!")));
	    $help .= $error_div->getHtml();
	
	    $form = new UserRegistrationForm(TRUE);
	    $data = $form->render();
	}

} else {
	$data = new CText(translateFN('Modulo gestione codici di iscrizione non trovato'));
	$data = $data->getHtml();
}

$title = translateFN('Informazioni');

$layout_dataAr['JS_filename'] = array(
		JQUERY,
		JQUERY_MASKEDINPUT,
		JQUERY_NO_CONFLICT		
);

$optionsAr['onload_func'] = 'initDateField();';

$content_dataAr = array(
  'user_name'  => $user_name,
  'home'       => $home,
  'data'       => $data,
  'help'       => $help,
  'menu'       => $menu,
  'message'    => $message,
  'status'     => $status
);

/**
 * Sends data to the rendering engine
 */
ARE::render($layout_dataAr,$content_dataAr,NULL, $optionsAr);
