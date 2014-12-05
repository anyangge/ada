<?php
/**
 * Code Management
 *
 * @package 	code_man
 * @author		giorgio
 * @copyright	Copyright (c) 2012, Lynx s.r.l.
 * @license		http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2
 * @version		0.1
 */

/**
 * class for managing the Code Manager Module
 *
 * @author giorgio
 */
		
require_once(ROOT_DIR.'/include/user_class.inc.php');		

class codemanManagement
{
	/**
	 * holds the generated codes
	 *
	 * @var array
	 */
	private  $_codes;
	
	/**
	 * holds the provider pointer (e.g. client1)
	 *
	 * @var string
	 */
	private $_provider;	
	
    /**
     * name constructor
     */
    public function __construct()
    {
//     	global $userObj;
    	$userObj =& $GLOBALS['userObj'];
    	
        $this->_codes = array();
        $this->_provider = $userObj->getTesters();
        // actual value is in the first element of returned array!
        $this->_provider = $this->_provider[0];
    }
    
	/**
	 * generates actual codes.
	 *
	 * @param string $prefix 	prefix to be used when geenrating codes
	 * @param int    $number	how many codes are to be generated
	 * @param int    $courseId course id we're generating codes for	
	 *
	 * @return boolean true on success, false otherwise
	 */
	public function generateCodes($prefix, $number, $courseId)
	{
		/* @var $retavl    boolean value to return: true on success, false otherwise */
		$retval    = false;
		/* @var $writerror boolean indicates if there's been a file write error */
		$writerror = false;
		
	    if (is_file(CODE_FILE_DIR.CODE_FILE_NAME) && is_writable(CODE_FILE_DIR.CODE_FILE_NAME))
	    {
	    	$codesArray = array();
	    	$prefix = strtoupper ($prefix);
	    	
			// Reads all codes from input file into $codesArray	    	 
	    	$codeFileHandle = fopen(CODE_FILE_DIR.CODE_FILE_NAME, "a");
	    	while ($codeFileLine = fscanf($codeFileHandle, "%s\t%s\t%s\n")) {
	    		$codesArray[] = $codeFileLine[0];
	    		// let's just ignore other datas following the code in the line
	    	}	    	
	    	// generate the codes 1 by 1
	    	for ($i=0; $i < $number; $i++)
	    	{
	    		do {
	    			$tempCode = $prefix.codemanManagement::generateCode(CODEMAN_NUMDIGITS, CODEMAN_NUMLETTERS);	    				    				    			
	    		} while (in_array($tempCode, $codesArray));
	    		// if we've made it this far we've found a code that is not listed in the given file. excellent!
	    		array_push($codesArray, $tempCode);
	    		$this->_codes[$i] = $tempCode;

	    		// write generated tempCode in the file
	    		// put courseId and current date before the first item
	    		if ( fprintf ($codeFileHandle,
	    				( ($i==0) ? $courseId." ".date("d/m/Y")."\r\n" : "" ).
	    				"%s %s %s\r\n",$tempCode, $courseId, $this->_provider) <=0 )
	    		{
	    			//oops, we've got a write error here: let's break out of the loop right away
	    			$writerror = true;
	    			break;
	    		}	    			
	    	}
	    	// close the file
	    	fclose($codeFileHandle);
	    	// if everything okay, return true
	    	if (!$writerror) $retval = true;
	    }	    	
	    return $retval;
	}
	
	/**
	 * static function to generate random(?) string.
	 *
	 * @param int $numdigits	number of digits that returned string must have
	 * @param int $numaletters	number of letters that returned string must have
	 *
	 * @return string string containing numdigits digits and numletters letters
	 */
	public static function generateCode ($numdigits, $numletters)
	{
	    $character_set_array = array();
	    $character_set_array[] = array('count' => $numletters,  'characters' => 'abcdefghijklmnopqrstuvwxyz');
	    $character_set_array[] = array('count' => $numdigits,   'characters' => '0123456789');
	    $temp_array = array();
	    foreach ($character_set_array as $character_set) {
	        for ($i = 0; $i < $character_set['count']; $i++) {
	            $temp_array[] = $character_set['characters'][rand(0, strlen($character_set['characters']) - 1)];
	        }
	    }
	    shuffle($temp_array);
	    return strtoupper (implode('', $temp_array));
	}
    
    
    /**
     * generates the form to be rendered
     * 
     * @return array containing html, path and status
     */

	public function form() {
// 		global $dh;
		$dh  =& $GLOBALS['dh'];
				
		/* @var $html string holds html code to be retuned */
		$html = '';
		/* @var $path   string  path var to render */
		$path = translateFN('Generazione codici di iscrizione');
		/* @var $status string status var to render*/
		$status=translateFN('Generazione codici di iscrizione');

		if (isset($_GET['download'])) {
			if (isset($_SESSION["codemanData"]))
			{	
				// build up .txt file into txtContent var
				$txtContent = "";
				foreach ($_SESSION["codemanData"] as $code)
				{
					$txtContent .= $code."\r\n";
				}	
				// unset ($_SESSION["codemanData"]);
				
				// send out appropriate headers and stream txtContent
				$filename = CODE_FILE_NAME."_".date('Y_m_d').".txt";
				header("Content-type: text/plain");
				header("Content-Disposition: attachment; filename=".$filename);
				header("Pragma: no-cache");
				header("Expires: 0");
				echo $txtContent;
				die();					
			}
		}
		else
		{
			require_once(MODULES_CODEMAN_PATH.'/include/forms/formCodeManager.inc.php');
			
			// grab some course and course instance datas to build up the form properly
			$formCourseList = array();

			// first of all, get the coure list
			$courseList = $dh->get_courses_list(array('titolo'));
			// first element of returned array is always the courseId, array is NOT assoc
			
			// for each course in the list...
			foreach ($courseList as $courseItem) {
				// ... get the subscribeable course instance list...
			    $courseInstances = $dh->course_instance_get_list(array('title'), $courseItem[0]);
			    // first element of returned array is always the instanceId, array is NOT assoc
			    
			    // ...and, for each subscribeable instance in the list...
			    foreach ($courseInstances as $courseInstanceItem)
			    {
			    	// ... put its ID and human readble course instance name, course title and course name as an <option> in the <select>
					$formCourseList[] = array ( $courseInstanceItem[0] , $courseItem[1] . " > ".$courseInstanceItem[1] );
			    }
			}
			// done, ready to instantiate form object
			
			$form = new FormCodeManager( $_POST, $formCourseList );
			
			if ($_POST && $form->isValid()) { // there's some post data, let's handle 'em all
				
				$prefix = isset ($_POST['prefix'])  ? trim($_POST['prefix']) : '';
				$number = (isset($_POST['number']) && intval($_POST['number'])) ? intval($_POST['number']) : 0;
				$courseId = isset ($_POST['courseId'])  ? trim($_POST['courseId']) : '';
								
				if ($this->generateCodes($prefix, $number, $courseId))
				{
					// we're showing the generated code list instead of the form if everything is okay
					
					$status = translateFN("Codici Generati");
					
					$codesDOMList = CDOMElement::create("ol");
					foreach ($this->_codes as $aCode)
					{				
						$codesDOMListItem = CDOMElement::create("li");
						$codesDOMListItem->addChild(new CText($aCode)); 
						$codesDOMList->addChild($codesDOMListItem);
					}
					$html .= $codesDOMList->getHtml();
					
					$save_link = CDOMElement::create('a', 'href:'.MODULES_CODEMAN_HTTP.'/?download, style:margin:0 80px 0 80px');
					$save_link->addChild(new CText(translateFN('Download Codici Generati')));
					
					$html .= $save_link->getHtml();

					// save generated codes in a session var for further download
					$_SESSION['codemanData'] = $this->_codes;	
				}
				else 
					$html .= translateFN('Si è verificato un errore durante l\'invio dei dati. Riprovare.');					

			}
			else { // there's no post data, show the form
				$html.= $form->getHtml();
			}
		}

		return array(
			'html'   => $html,
			'path'   => $path,
			'status' => $status,
		);
	}
} // class ends here