/**
 * CLASSAGENDA MODULE.
 *
 * @package        classagenda module
 * @author         Giorgio Consorti <g.consorti@lynxlab.com>         
 * @copyright      Copyright (c) 2014, Lynx s.r.l.
 * @license        http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2
 * @link           classagenda
 * @version		   0.1
 */

/**
 * global vars
 */
var hasVenues = false;
var calendar  = undefined;
var mustSave = false;
var canDelete = false;

function initDoc() {
	// hook instance select change to update number of students
	updateStudentCountOnInstanceChange();
	// hook instance select change to update service (aka course) type
	updateServiceTypeOnInstanceChange();	
	// ask a save confirmation before changing course instance
	askChangeInstanceOrVenueConfirm();
	// hook instance select change to update tutors list
	updateTutorsListOnInstanceChange();
	
	hasVenues = $j('#venuesList').length>0;
	if (hasVenues) {
		// hook venues select change to update classroom list
		updateClassroomsOnVenueChange();
		// trigger onchange event to update classroom list when page loads
		// $j('#venuesList').trigger('change');
	}
	
	if ($j('#filterInstanceState').length>0 || $j('#onlySelectedInstance').length>0) {
		$j('#filterInstanceState, #onlySelectedInstance, #onlySelectedVenue').on('change',function() {
			/**
			 * reload course instances list only when #filterInstanceState changes 
			 */
			if ($j(this).attr('id')=='filterInstanceState') {
				$j.when(loadCourseInstances()).done(function() {
					if (getSelectedCourseInstance()!=0) reloadClassRoomEvents();
				});
			} else reloadClassRoomEvents();
			
		});
		
		$j('#filterInstanceState, label[for="filterInstanceState"],'+
		   '#onlySelectedInstance, label[for="onlySelectedInstance"],'+
		   '#onlySelectedVenue, label[for="onlySelectedVenue"]').on('mousedown',function() {
			if (mustSave) {
				event.preventDefault();
				jQueryConfirm('#confirmDialog', '#filterInstanceStatequestion',
						function() { saveClassRoomEvents(); },
						function() { event.preventDefault(); });
			}
		});
	}
	
	loadCourseInstances();
	initCalendar();
	// for the first load, classroom events are loaded by change
	// events triggered on classroom and/or tutor change
}

/**
 * init facilities tooltip on classroom
 * radio button mouserover
 */
function initFacilitiesTooltips() {
	if ($j('.classroomradio').length>0) {
		$j(document).tooltip({
			items : '#classroomlist label',
			content: function() {
				var classroomID = parseInt($j(this).attr('for').match(/(\d+)$/)[0]);
				return ($j('#facilities'+classroomID).length>0) ? $j('#facilities'+classroomID).html() : null;
			}
		});
	}
}

function initCalendar() {
	if ($j('#classcalendar').length>0) {
		calendar = $j('#classcalendar').fullCalendar({
			// put your options and callbacks here
			theme 	 : true,	// enables jQuery UI theme
			firstDay : 1,		// monday is the first day
			minTime  : "08:00",	// events starts at 08AM ,
			maxTime  : "20:00",	// events ends at 08PM
			weekends : false,	// hide weekends
			defaultEventMinutes: 60,
			height : 564,
			editable : true,
			selectable : true,
			selectHelper : true,
			allDaySlot : false,
			slotEventOverlap : false,
			defaultView : 'agendaWeek',
			/**
			 * selected or deselect the clicked event
			 */
			eventClick: function(calEvent, jsEvent, view) {
				
				if (!calEvent.editable) return;
				
				var doSelection = true;
				
				// get previously selected event
				var selEvent = getSelectedEvent();
				
				// unselect previously selected event
				if (selEvent!=null) {
					doSelection = selEvent._id != calEvent._id;
					selEvent.isSelected = false;
					selEvent.className = '';
					calendar.fullCalendar('updateEvent', selEvent);
				}
				
				// select clicked element if needed
				if (doSelection) {
					calEvent.className = 'selectedClassroomEvent';
					calEvent.isSelected = true;
					setSelectedClassroom(calEvent.classroomID);
					setSelectedTutor(calEvent.tutorID);
					if (!canDelete) setCanDelete(true);
					calendar.fullCalendar('updateEvent', calEvent);
				} else {
					if (canDelete) setCanDelete(false);
					}
			},
			/**
			 * creates a new event
			 */
			select :
				function( startDate, endDate, jsEvent, view ) {
				if (startDate.hasTime() && endDate.hasTime()) {
					
					newEvent = {
						start: startDate.format(),
						end: endDate.format(),
						isSelected : false,
						editable : true,
						instanceID : getSelectedCourseInstance(),
						classroomID : getSelectedClassroom(),
						tutorID : getSelectedTutor()
					};
					
					var placeEvent = function() {
						newEvent.title = buildEventTitle(newEvent);
						calendar.fullCalendar('renderEvent', newEvent, true);
						if(!mustSave) setMustSave(true);
						updateAllocatedHours(moment.duration(endDate.subtract(startDate)).asMilliseconds(), 1);
						calendar.fullCalendar('unselect');
					}
					
					/**
					 * do the checkTutorOverlap only if a tutor is there
					 */
					if (newEvent.tutorID>0) {
						$j.when(checkTutorOverlap(newEvent)).done(function(overlaps) {
							if ('undefined' != typeof overlaps.isOverlap && !overlaps.isOverlap) {
								placeEvent();
							} else {
								jQueryConfirm('#confirmDialog', '#tutorOverlapquestion',
										function() { placeEvent(); },
										function() { calendar.fullCalendar('unselect'); });
							}						
						}).fail(function() {
							console.log ('error while checking overlapping events in select');
							calendar.fullCalendar('unselect');
						});
					} else placeEvent();
				}
			},
			eventRender: function(event, element, view) {
				// allows html to be used inside the title
				var htmlEl = ('month' != view.name) ? 'div' : 'span';
				element.find(htmlEl+'.fc-title').html(element.find(htmlEl+'.fc-title').text());
			},
			eventDrop: function ( event, delta, revertFunc) {
				
				data = {
						start: event.start.format(),
						end  : event.end.format(),
						tutorID: parseInt(event.tutorID),
						eventID : event.id
				};
				
				var placeEvent = function() {
					if (parseInt(delta.as('minutes'))!=0 && !mustSave) setMustSave(true);
				}
				/**
				 * do the checkTutorOverlap only if a tutor is there
				 */
				if (data.tutorID>0) {
					$j.when(checkTutorOverlap(data)).done(function(overlaps) {
						if ('undefined' != typeof overlaps.isOverlap && !overlaps.isOverlap) {
							placeEvent();
						} else {
							jQueryConfirm('#confirmDialog', '#tutorOverlapquestion',
									function() { placeEvent(); },
									function() { revertFunc(); });
						}						
					}).fail(function() {
						console.log ('error while checking overlapping events in eventDrop');
						revertFunc();
					});
				} else placeEvent();
				
			},
			eventResize: function( event, delta, revertFunc, jsEvent, ui, view ) {
				
				data = {
						start: event.start.format(),
						end  : event.end.format(),
						tutorID: parseInt(event.tutorID),
						eventID : event.id
				};
				
				var placeEvent = function() {
					if (parseInt(delta.as('minutes'))!=0 && !mustSave) setMustSave(true);
					updateAllocatedHours(delta.asMilliseconds(), 0);
				}
				
				/**
				 * do the checkTutorOverlap only if a tutor is there
				 */
				if (data.tutorID>0) {
					$j.when(checkTutorOverlap(data)).done(function(overlaps) {
						if ('undefined' != typeof overlaps.isOverlap && !overlaps.isOverlap) {
							placeEvent();
						} else {
							jQueryConfirm('#confirmDialog', '#tutorOverlapquestion',
									function() { placeEvent(); },
									function() { revertFunc(); });
						}						
					}).fail(function() {
						console.log ('error while checking overlapping events in eventResize');
						revertFunc();
					});
				} else placeEvent();
				
			},
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			}
		});
		
		// initialize save button and set must save to false
		setMustSave(false);
		// initialize delete button and set can delete to false
		setCanDelete(false);
		$j('#saveCalendar').on('click', function ( event ) {
			saveClassRoomEvents();
			event.preventDefault();
		});
		// initialize cancel button
		$j('#cancelCalendar').button().on('click', function ( event ) {
			// reloadClassRoomEvents();
			// reload instance details by triggering an instance change
			if ($j('#instancesList').length>0) { $j('#instancesList').trigger('change'); } 
			event.preventDefault();
		});
		
		moveInsideCalendarHeader('onlySelectedInstance');
	}
}

/**
 * checks the selected classroom radio button
 * 
 * @param classroomid the id of the classroom to be checked
 */
function setSelectedClassroom(classroomid) {
	if ($j('input[name="classroomradio"]').length>0) $j('input[name="classroomradio"][value='+classroomid+']').prop('checked',true);
}

/**
 * checks the selected tutor radio button
 * 
 * @param tutorid the id of the tutor to be checked
 */
function setSelectedTutor(tutorid) {
	if ($j('#tutorSelect').length>0) $j('#tutorSelect option[value="'+tutorid+'"]').attr('selected','selected');
}

/**
 * gets the selected venue option value
 * 
 * @returns selected venue id or null
 */
function getSelectedVenue() {
	return ($j('#venuesList').length>0 && $j('input[name="classroomradio"]').length>0
			&& $j('#onlySelectedVenue').is(':checked')) ? $j('#venuesList').val() : null;
}

/**
 * gets the selected course instance option
 * 
 * @returns selected course instance id or null
 */
function getSelectedCourseInstance() {
	return ($j('#instancesList').length>0) ? $j('#instancesList').val() : null;
}

/**
 * gets the selected classroom radio button
 * 
 * @returns selected classroom id or null
 */
function getSelectedClassroom() {
	return ($j('input[name="classroomradio"]').length>0) ? $j('input[name="classroomradio"]:checked').val() : null;
}

/**
 * gets the selected tutor radio button
 * 
 * @returns selected tutor id or null
 */
function getSelectedTutor() {
	return ($j('#tutorSelect').length>0) ? $j('#tutorSelect').val() : null;
}

/**
 * gets the label of the radio button associated to the passed tutor id
 * 
 * @param tutorid
 * 
 * @returns string the retreived label
 */
function getTutorRadioLabel(tutorid)  {
	return ($j('#tutorSelect').length>0) ? $j('#tutorSelect option[value="'+tutorid+'"]').text() : null;
}

/**
 * gets the label of the radio button associated to the passed classroomid
 * 
 * @param classroomid
 * 
 * @returns string the retreived label
 */
function getClassroomRadioLabel(classroomid) {
	return $j('input[name="classroomradio"][value='+classroomid+']+ label').text();
}

/**
 * gets the selected event
 * 
 * @returns event if one is found, or null
 */
function getSelectedEvent() {
	// get selected event
	var selEvent = calendar.fullCalendar('clientEvents', function (clEvent) {
		return (typeof clEvent.isSelected != "undefined" && clEvent.isSelected==true);
		});
	return (selEvent.length > 0) ? selEvent[0] : null;
}

function getFilterInstanceState() {
	return ($j('#filterInstanceState').length>0) ? $j('#filterInstanceState').val() : null;
}

function getShowSelectedInstance() {
	return ($j('#onlySelectedInstance').length>0) ? $j('#onlySelectedInstance').is(':checked') : false;
}

/**
 * sets the selected calendar event
 * 
 * @param event the clicked event to be set as selected
 */
function setSelectedEvent(event) {
	// get selected event
	var selEvent = calendar.fullCalendar('clientEvents', function (clEvent) {
		return (typeof clEvent.isSelected != "undefined" && clEvent.isSelected==true);
		});
	if (selEvent.length > 0) {
		selEvent[0] = event;
		calendar.fullCalendar('updateEvent', event);
	}
}

/**
 * builds the event title to be rendered
 * 
 * @param event to build the title
 * 
 * @returns string, the event title
 */
function buildEventTitle(event) {
	var title = '';
	title += ($j('#instancesList').length>0) ? ($j('#instancesList option[value='+event.instanceID+']').text()) : '';
	
	// add room and tutor name to the event title
	
	if ($j('input[name="classroomradio"]').length>0) {
		// remove (xx seats) from radiobutton label and use it
		var roomName = getClassroomRadioLabel(event.classroomID).replace(/ \(.*\)/,'');
		title += '<span class="roomnameInEvent">' + roomName + '</span>';
	}
	
	if ($j('#tutorSelect').length>0) {
		title += '<span class="tutornameInEvent">'+
				 getTutorRadioLabel(event.tutorID)+'</span>';
	}
	
	return title;
}

/**
 * updates classroom radio buttons on venue change
 */
function updateClassroomsOnVenueChange() {
	if (hasVenues) {
		$j('#venuesList').on('change', function(){
			$j.ajax({
				type	:	'GET',
				url		:	'ajax/getClassrooms.php',
				data	:	{ venueID: $j(this).val() },
				dataType:	'html'
			}).done (function(htmlcode){
				if (htmlcode && htmlcode.length>0) {
					$j('#classroomlist').html(htmlcode);
					initFacilitiesTooltips();
					// reload classroom events for selected venue
					reloadClassRoomEvents();
					// select the first radio button
					if ($j('input[name="classroomradio"]').length>0) {
						$j('input[name="classroomradio"]').first().prop('checked',true);
						$j('input[name="classroomradio"]').on('change', function(userEvent) {
							updateEventOnClassRoomChange();
						});
					}
				}
			});
		});
	}
}

/**
 * set instancesList select dropdown to
 * update service (aka course) type
 */
function updateServiceTypeOnInstanceChange() {
	if ($j('#instancesList').length>0) {
		$j('#instancesList').on('change', function(){
			
			if ($j('#headerInstanceTitle').length >0) {
				$j('#headerInstanceTitle').text($j(this).find('option:selected').text());
			}
			
			if ($j('#servicetype').length>0) {
				$j.ajax({
					type	:	'GET',
					url		:	'ajax/getServiceDetails.php',
					data	:	{ instanceID: $j(this).val() },
					dataType:	'json'
				}).done (function(JSONObj){
					if (JSONObj) {
						$j('#servicetype').html(JSONObj.serviceTypeString);
						if('undefined' != typeof JSONObj.isOnline && JSONObj.isOnline===true) {							
							$j('#classroomlist').html('');
							$j('#classrooms').hide();
							$j('#serviceduration').hide();
						} else if('undefined' != typeof JSONObj.isPresence && JSONObj.isPresence===true) {
							// show classrooms div
							if ($j('#classrooms').length>0 && !$j('#classrooms').is(':visible')) {
								$j('#classrooms').show();
								// trigger venues change to update classroom list
								if (hasVenues) $j('#venuesList').trigger('change');
							}
							if ($j('#serviceduration').length>0 && 'undefined' != typeof JSONObj.duration_hours) {
								$j('#serviceduration').show();
								$j('#duration_hours').text(JSONObj.duration_hours);
								
								if ($j('#allocated_hours').length>0 && 'undefined' != typeof JSONObj.allocated_hours)
									$j('#allocated_hours').text(millisecondsToHourMin(JSONObj.allocated_hours));
								
								if ($j('#lessons_count').length>0 && 'undefined' != typeof JSONObj.lessons_count)
									$j('#lessons_count').text(JSONObj.lessons_count);
							}
						}
					}
				});
			}
		});
	}
}

/**
 * set instancesList select dropdown to
 * update studentcount and calendar events
 */
function updateStudentCountOnInstanceChange() {
	if ($j('#instancesList').length>0) {
		$j('#instancesList').on('change', function(){
			if ($j('#studentcount').length>0) {
				$j.ajax({
					type	:	'GET',
					url		:	'ajax/getStudentsCount.php',
					data	:	{ instanceID: $j(this).val() },
					dataType:	'json'
				}).done (function(JSONObj){
					if (JSONObj) {
						$j('#studentcount').html(JSONObj.value);
					}
				});
			}
		});
	}
}

/**
 * updates selected event on classroom radio button change
 */
function updateEventOnClassRoomChange() {
	var event = getSelectedEvent(), classroomid = getSelectedClassroom();
	if (event!=null && classroomid>0) {
		event.classroomID = classroomid;
		event.title = buildEventTitle(event);
		setSelectedEvent(event);		
		if(!mustSave) setMustSave(true);
	}
}

/**
 * updates selected event on tutor radio button change
 */
function updateEventOnTutorChange() {
	var event = getSelectedEvent(), tutorid = getSelectedTutor();
	if (event!=null && tutorid>0) {
		event.tutorID = tutorid;
		event.title = buildEventTitle(event);
		setSelectedEvent(event);
		if(!mustSave) setMustSave(true);
	}
}

/**
 * if something needs to be saved and the user
 * wants to change course instance or venue, ask to save
 */
function askChangeInstanceOrVenueConfirm() {
	var selector = '';
	if ($j('#instancesList').length>0) selector += '#instancesList';
	if ($j('#venuesList').length>0) selector += ',#venuesList';
	
	if (selector.length>0) {
		$j(selector).on('mousedown', function(event){
			// check if there's something to save here
			if (mustSave) {
				event.preventDefault();
				jQueryConfirm('#confirmDialog', '#'+$j(this).attr('id')+'question',
						function() { saveClassRoomEvents(); }, 
						function() { event.preventDefault(); });
			}
		});
	}
}

/**
 * set instancesList select dropdown to update tutors list
 */
function updateTutorsListOnInstanceChange() {
	if ($j('#instancesList').length>0 && $j('#tutorsListContainer').length>0) {
		$j('#instancesList').on('change', function(){
			$j.ajax({
				type	:	'GET',
				url		:	'ajax/getTutors.php',
				data	:	{ instanceID: $j(this).val() },
				dataType:	'html'
			}).done (function(htmlcode){
				if (htmlcode && htmlcode.length>0) {
					$j('#tutorslist').html(htmlcode);
					// reload classroom events
					if (typeof calendar != 'undefined') reloadClassRoomEvents();
					// select the first radio button
					if ($j('#tutorSelect').length>0) {
						$j("#tutorSelect option:first").attr('selected','selected');
						$j('#tutorSelect').on('change', function() {
							updateEventOnTutorChange();
						});
					}
				}
			});
		});
	}
}

/**
 * saves calendar
 */
function saveClassRoomEvents() {
	
	var calEvents = calendar.fullCalendar('clientEvents');
	var eventsToPass = [];
	var selectedCourseInstance = getSelectedCourseInstance();
	
	for (var i=0, j=0; i<calEvents.length; i++) {
		if (calEvents[i].instanceID==selectedCourseInstance) {
			eventsToPass[j++] = {
					id : (typeof calEvents[i].id == 'undefined' || null == calEvents[i].id) ? null : calEvents[i].id,
					start : calEvents[i].start.format(),
					end : calEvents[i].end.format(),
					classroomID : calEvents[i].classroomID,
					tutorID : calEvents[i].tutorID
			};
		}
	}
	
	return $j.ajax({
				type	:	'POST',
				url		:	'ajax/saveClassroomEvents.php',
				data	:	{
					venueID : getSelectedVenue(),
					instanceID : selectedCourseInstance,
					events : eventsToPass
				},
				dataType:	'json'
			}).done (function(JSONObj){
				if (JSONObj && JSONObj.status.length>0) {
					showHideDiv('',JSONObj.msg, JSONObj.status==='OK');
				} else {
					showHideDiv('','Unknow error', false);
				}
			}).always(function() { reloadClassRoomEvents(); setMustSave(false); });
}

function loadCourseInstances() {
	if ($j('#instancesList').length>0) {
		
		var oldSelectedInstance = getSelectedCourseInstance();
		
		$j('#instancesList').prop('disabled','disabled');
		return $j.ajax({
			type	:	'GET',
			url		:	'ajax/getInstances.php',
			data	:	{ filterInstanceState : getFilterInstanceState() },
			dataType:	'html'
		}).done (function(htmlcode){
			if (htmlcode.length>0){
				$j('#instancesList').html(htmlcode);
				/**
				 * if oldSelectedInstance is still in the returned <select> element,
				 * select id. Else select the first returned <option>
				 */
				if (typeof $j('#instancesList option[value="'+oldSelectedInstance+'"]').val() == 'undefined') {
					// mark the first option as selected
					$j("#instancesList option:first").attr('selected','selected');					
				} else {
					$j('#instancesList option[value="'+oldSelectedInstance+'"]').attr('selected','selected');
				}
				if (getSelectedCourseInstance()!=0) {
					// trigger onchange event to update number of students when page loads
					$j('#instancesList').trigger('change');
				} else {
					$j('#servicetype').text('--');
					$j('#studentcount').text('--');
					$j('#tutorslist').text('--');
					$j('#headerInstanceTitle').text('--');
					$j('#classroomlist').html('');
					$j('#classrooms').hide();
					$j('#serviceduration').hide();
					calendar.fullCalendar('removeEvents');
				}
			}
		}).always(function() {
			$j('#instancesList').prop('disabled',false);
		});
	}
}

/**
 * reloads calendar events for select instance id
 */
function reloadClassRoomEvents() {
	var data = {
			filterInstanceState : getFilterInstanceState() 
		};
	var venueID = getSelectedVenue();
	var selectedInstanceID = getSelectedCourseInstance();
	
	if (getShowSelectedInstance()) {
		$j.extend (data, {
			instanceID: selectedInstanceID
		});
	}
	
	/**
	 * ajax-load events
	 */
	$j.ajax({
		type	:	'GET',
		url		:	'ajax/getCalendarForInstance.php',
		data	:	data,
		dataType:	'json'
	}).done (function(JSONObj){
		/**
		 * remove all events
		 */
		calendar.fullCalendar('removeEvents');
		
		if (JSONObj) {
			/**
			 * add all loaded events to the calendar
			 */
			for (var i=0; i<JSONObj.length; i++) {
				if (venueID==null || (venueID!=null && JSONObj[i].venueID==venueID)) {
					JSONObj[i].title = buildEventTitle(JSONObj[i]);
					
					// set as editable only events of the selected course instance
					JSONObj[i].editable = (JSONObj[i].instanceID==selectedInstanceID);
					JSONObj[i].className = (!JSONObj[i].editable) ? 'noteditableClassroomEvent' : 'editableClassroomEvent';
					
					calendar.fullCalendar('renderEvent', JSONObj[i], true);
					calendar.fullCalendar('unselect');
				}
			}
			
			$j('a.noteditableClassroomEvent').on ('click', function(event){
				event.preventDefault();
				
			});
			
		}
	}).fail(function() {}).always(function() {
		setMustSave(false);
		setCanDelete(false);
	});
}

function millisecondsToHourMin(millis) {
	var minutes = Math.floor (millis/(1000*60));
	var hours = (Math.floor (minutes / 60)) + ''; // converted to string by +''
	var realminutes = (minutes % 60)+ ''; // converted to string by +''
	// zero-pad strings to a fixed length of 2
	hours = (hours.length < 2) ? '0'+hours : hours;
	realminutes = (realminutes.length < 2) ? '0'+realminutes : realminutes;
	
	return hours+':'+realminutes;
}

function updateAllocatedHours(durationDelta, lessonsDelta) {
	if ($j('#allocated_hours').length>0 && $j('#allocated_hours').text().length>0) {
		var allocatedDuration = moment.duration($j('#allocated_hours').text());
		if (lessonsDelta>=0) {
			allocatedDuration.add(durationDelta);
		} else if (lessonsDelta<0) {
			allocatedDuration.subtract(durationDelta);
		}
		$j('#allocated_hours').text(millisecondsToHourMin(allocatedDuration.asMilliseconds()));
	}
	
	if ($j('#lessons_count').length>0) {
		$j('#lessons_count').text(parseInt($j('#lessons_count').text())+lessonsDelta);
	}
}

/**
 * check if the passed events overlaps with some other event of the same tutor
 * 
 * @param event
 * @returns {Boolean}
 */
function checkTutorOverlap(event) {
	return $j.ajax({
				type	:	'GET',
				url		:	'ajax/checkTutorOverlap.php',
				data	:	event,
				dataType:	'json'
			}).done (function(JSONObj){
						
				if ('undefined' != typeof JSONObj.isOverlap) {
					if (JSONObj.isOverlap==true) {
						/**
						 * Set dialog text with overlapping found event data
						 */
						$j('#overlapTutorName').text(getTutorRadioLabel(event.tutorID));
						if ('undefined' != typeof JSONObj.data.instanceName) {
							$j('#overlapInstanceName').html(($j('#instancesList').length>0) ? JSONObj.data.instanceName : '');
						}
						if ('undefined' != JSONObj.data.date)  {
							$j('#overlapDate').text(JSONObj.data.date);
						}
						if ('undefined' != JSONObj.data.start)  {
							$j('#overlapStartTime').text(JSONObj.data.start);
						}
						if ('undefined' != JSONObj.data.end)  {
							$j('#overlapEndTime').text(JSONObj.data.end);
						}
					}
				}
			}).fail(function() {});
}

/**
 * deletes the select calendar event
 */
function deleteSelectedEvent() {
	var selectedDuration = null;
	calendar.fullCalendar('removeEvents', function (clEvent) {
		if (typeof clEvent.isSelected != "undefined" && clEvent.isSelected==true) {
			if (selectedDuration==null) {
				selectedDuration = moment.duration();
				selectedDuration.add(clEvent.end.subtract(clEvent.start));
			}			
			return true;
		} else return false;
		});
	
	setCanDelete(false);
	if (!mustSave) setMustSave(true);
	updateAllocatedHours(selectedDuration, -1);
}

/**
 * sets the mustSave variable
 * 
 * @param status boolean, true to enable save button
 */
function setMustSave (status) {
	mustSave = status;
	$j('#saveCalendar').button({ disabled: !mustSave });	
}

/**
 * sets the canDelete variable
 * 
 * @param status boolean, true to enable delete button
 */
function setCanDelete (status) {
	canDelete = status;
	$j('#deleteButton').button({ disabled: !canDelete });
}

/**
 * sets the text of the modal dialogù
 * 
 * @param windowId id of the div containing the dialog
 * @param spanId id of the span containing the text to set
 */
function setModalDialogText (windowId, spanId) {
	// hides all spans that do not contain a variable
	$j(windowId + ' span').not('[id^="var"]').hide();
	// shows the passed span that holds the message to be shown
	$j(spanId).show();
	$j(spanId).children().show();
}

function moveInsideCalendarHeader (elementID) {
	var targetElement = '#classcalendar > .fc-toolbar';
	var customClass = 'fc-custom';
	
	if ($j(targetElement).length>0 && $j('#'+elementID).length>0) {
		
		/**
		 * add a customClass div to the calendar toolbar before last children
		 */
		if ($j(targetElement + ' > .' + customClass).length<=0) {
			var childCount = $j(targetElement).children().length;
			
			$j(targetElement+' :nth-child('+childCount+')').before('<div class="'+customClass+'"></div>');
		}
		
		/**
		 * clone, inspect and remove passed element
		 */
		var cloned = $j('#'+elementID).clone(true);
		
		if ($j('#'+elementID).is('input')) {
			// if passed ID is an input and has a label, clone and move the label as well
			if ($j('label[for="'+elementID+'"]').length>0) {
				var clonedLabel = $j('label[for="'+elementID+'"]').clone(true);
				$j('label[for="'+elementID+'"]').remove();
			}
		}
				
		$j('#'+elementID).remove();
		
		targetElement += ' > .' + customClass;
		$j(targetElement).html(cloned);
		/**
		 * add the clonedLabel if it's there
		 */
		if ('undefined' != typeof clonedLabel) $j(targetElement).append(clonedLabel);
	}
}

/**
 * shows a confirmation dialog and waits for user action
 * 
 * @param id id of the div containing the dialog
 * @param questionId id of the span containing the text (question)
 * @param OKcallback ok button callback
 * @param CancelCallBack cancel button callback
 */
function jQueryConfirm(id, questionId, OKcallback, CancelCallBack) {
	var okLbl = $j(id + ' .confirmOKLbl').html();
	var cancelLbl = $j(id + ' .confirmCancelLbl').html();

	setModalDialogText(id, questionId);

	$j(id).dialog({
		resizable : false,
		width: "auto",
		modal : true,
		buttons : [ {
			text : okLbl,
			click : function() {
				OKcallback();
				$j(this).dialog("close");
			}
		}, {
			text : cancelLbl,
			click : function() {
				CancelCallBack();
				$j(this).dialog("close");
			}
		} ]
	});
}
