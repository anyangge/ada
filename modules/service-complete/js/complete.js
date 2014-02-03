/**
 * SERVICE-COMPLETE MODULE.
 *
 * @package        service-complete module
 * @author         Giorgio Consorti <g.consorti@lynxlab.com>         
 * @copyright      Copyright (c) 2013, Lynx s.r.l.
 * @license        http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2
 * @link           service-complete
 * @version		   0.1
 */

function initDoc()
{
	initDataTables();
	initButtons();
	initToolTips();
}

function deleteRule (jqueryObj, id_completeRule, message)
{	
	// the trick below should emulate php's urldecode behaviour
	if (confirm ( decodeURIComponent((message + '').replace(/\+/g, '%20')) ))
	{
		$j.ajax({
			type	:	'POST',
			url		:	'ajax/delete_completeRule.php',
			data	:	{ id: id_completeRule },
			dataType:	'json'
		})
		.done  (function (JSONObj) {
			if (JSONObj)
				{
					if (JSONObj.status=='OK')
					{
						// deletes the corresponding row from the DOM with a fadeout effect
						jqueryObj.parents("tr").fadeOut("slow", function () {
							var pos = datatable.fnGetPosition(this);
							datatable.fnDeleteRow(pos);
							});
					}
				}
		});
	}
}

/**
 * inits jquery buttons
 */
function initButtons()
{
	/**
	 * new button
	 */
	$j('.newButton').button({
		icons : {
			primary : 'ui-icon-document'
		}
	});
	
	/**
	 * actions button
	 */
	
	$j('.editButton').button({
		icons : {
			primary : 'ui-icon-pencil'
		},
		text : false
	});
	
	$j('.applyButton').button({
		icons : {
			primary : 'ui-icon-link'
		},
		text : false
	});
	
	$j('.deleteButton').button({
		icons : {
			primary : 'ui-icon-trash'
		},
		text : false
	});	
}

function initDataTables() {
	datatable = $j('#completeRulesList').dataTable( {
		 		"bJQueryUI": true,
                "bFilter": true,
                "bInfo": false,
                "bSort": true,
                "bAutoWidth": true,
                "bPaginate" : false,
                'aoColumns': [
                              // first empty column generated by ADA HTML engine, let's hide it
                                { "bSearchable": false,
                                  "bVisible":    false },
                                null,
                                { "bSearchable" : false, "bSortable" : false, "sWidth" : "15%"}
                            ]
	}).show();
}
