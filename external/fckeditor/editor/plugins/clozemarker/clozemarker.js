var oEditor	= window.parent.InnerDialogLoaded() ;
var FCKLang	= oEditor.FCKLang ;
var FCKCloze= oEditor.FCKCloze ;

window.onload = function () {
	// First of all, translate the dialog box texts
	oEditor.FCKLanguageManager.TranslatePage( document );

	var oLink = getoLink();
	var oSelection = oEditor.FCKSelection.GetSelectedHTML();
	oEditor.FCKCloze.hasTable = hasTable;

	// display an alert-message when no selection is made if we want to make a abbr
	// and also the cursor is not placed in a abbr
	if(oSelection.html == '' && !oLink) {
		document.getElementById('message').style.display = 'block';
		if (FCKCloze.title > 1) {
			document.getElementById('checkboxAll').style.display = 'block';
		}
	}
	// the cursor is placed in a abbr, so we have one!
	// we want to display the inputfield and the checknbox to remove the abbr
	else if (oLink) {
		document.getElementById('inputfield').style.display = 'block';
		document.getElementById('checkbox').style.display = 'block';
		oEditor.FCK.Selection.SelectNode( oLink );
		document.getElementById('title').value = oLink.getAttribute('title');
		document.getElementById('title').focus();
		if (hasTable)
		{
			document.getElementById('table').value = oLink.getAttribute('table');
			document.getElementById('selectfield').style.display = 'block';
		}
	}
	// we want to insert a abbr
	else {
		document.getElementById('inputfield').style.display = 'block';
		document.getElementById('title').value = FCKCloze.title;
		if (hasTable)
		{
			document.getElementById('selectfield').style.display = 'block';
			document.getElementById('table').value = FCKCloze.table;
		}
	}

	// Show the "Ok" button?
	if(oSelection.html != '' || oLink) {
		document.getElementById('title').focus();
	}
	window.parent.SetOkButton( true ) ;
};

function Ok() {
	if(document.getElementById('removeAll') && document.getElementById('removeAll').checked) { // remove all CLOZE
		oEditor.FCK.EditorDocument.body.innerHTML = oEditor.FCK.EditorDocument.body.innerHTML.replace(/<\/cloze>/g,'');
		oEditor.FCK.EditorDocument.body.innerHTML = oEditor.FCK.EditorDocument.body.innerHTML.replace(/<cloze[^>]*>/g,'');
		FCKCloze.title = 1;
		return true;
	}
	else if(document.getElementById('remove') && document.getElementById('remove').checked && oLink) { // remove CLOZE
		if( oEditor.FCKBrowserInfo.IsIE) { // IE-only
			oLink.removeNode(false);
		}
		else { // Gecko
			var e = oEditor.FCK.EditorDocument.createElement('SPAN');
			for ( var i = 0 ; i < oLink.childNodes.length ; i++ ) {
				e.appendChild( oLink.childNodes[i].cloneNode(true) );
			}
			oLink.remove();
			oEditor.FCK.InsertHtml( e.innerHTML ) ;
		}
		return true;
	}
	else {
		clozeTags = oEditor.FCK.EditorDocument.getElementsByTagName('cloze');
		
		var value = parseInt(document.getElementById('title').value);
		var table = -1;
		var oldValue = -1;
		
		if (hasTable)
		{
			e = document.getElementById("table");
			table = parseInt(e.options[e.selectedIndex].value);
		}
		
		if (oLink) oldValue = oLink.getAttribute('title');
		
		usedTitles = [];		
		if (clozeTags != null && clozeTags.length > 0) {
			for(var i = 0; i<clozeTags.length; i++) {
				usedTitles[i] = parseInt(clozeTags[i].getAttribute('title'));
			}
		}
		
		if (isNaN(value) || value <= 0 || (hasTable && table < 0)) {
			alert(FCKLang['ClozeDlgError']);
			return false;
		}
		else if (oldValue!=value && usedTitles.indexOf(value)!=-1) {
			alert(FCKLang['ClozeDlgErrorExist']);
			return false;
		}
		else {
			if (oLink && value != '') {// if cloze already exists, insert or replace title
				oLink.setAttribute('title',value);
				if (hasTable) oLink.setAttribute('table',table);
			}
			else {// otherwise, make a new cloze, with or without title
				FCKCloze.Insert(value,table);
				FCKCloze.Redraw();
			}
			return true;
		}
	}	
}

function getoLink() {
	if( oEditor.FCKBrowserInfo.IsIE) {
		oLink = oEditor.FCK.Selection.MoveToAncestorNode('cloze');	// lower-case!!!!!!! I don't know why, but it's working!!!
	}
	else {
		oLink = oEditor.FCK.Selection.MoveToAncestorNode('CLOZE');
	}
	return oLink;
}