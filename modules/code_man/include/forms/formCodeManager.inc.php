<?php
/**
 * Code Management
 *
 * @package		code_man
 * @author		giorgio
 * @copyright	Copyright (c) 2012, Lynx s.r.l.
 * @license		http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2
 * @version		0.1
 */

require_once(ROOT_DIR.'/include/Forms/lib/classes/FForm.inc.php');

/**
 * class for handling code_man module form
 *
 * @author giorgio
 */

class FormCodeManager extends FForm {

	/**
	 * form data, passed to the constructor
	 *
	 * @var array
	 */

	protected $data;
	
	/**
	 * holds the course list, passed to the constructor
	 *
	 * @var array
	 */
	private $_courseList;

	public function __construct($data=array(), $courseList=array()) {
		parent::__construct();
		
		$this->data = $data;
		$this->_courseList = $courseList;	

		$this->header();
		$this->content();
		$this->footer();
	}

	protected function content() {
	
		$this->setName('codeman');
	
		// generated codes prefix
		$this->addTextInput('prefix', translateFN('Prefisso').':')
			 ->setRequired()
			 ->setAttribute('maxlength', 2)
			 ->setValidator(FormValidator::NOT_EMPTY_STRING_VALIDATOR)
			 ->withData($this->data['prefix']);

		// number of students
		$this->addTextInput('number', translateFN('Numero di Studenti').':')
		     ->setRequired()
		     ->setValidator(FormValidator::POSITIVE_NUMBER_VALIDATOR)
		     ->withData($this->data['number']);
				
		// course list
		$formCourseList = array(''=>translateFN('Selezionare un corso'));
		foreach ($this->_courseList as $aCourse)
		{
			$formCourseList[$aCourse[0]] = $aCourse[1];
		}
		
		$this->addSelect('courseId', translateFN('Corso Selezionato').':', 
							$formCourseList, $this->data['courseId'])
			 ->setRequired()
			 ->setValidator(FormValidator::NOT_EMPTY_STRING_VALIDATOR);

	}	

	protected function header() {
	}

	protected function footer() {
	}
}