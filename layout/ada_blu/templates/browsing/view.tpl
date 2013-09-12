<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
    <head>
        <link rel="stylesheet" href="../../css/browsing/default.css" type="text/css">

    </head>
    <body>
        <a name="top"> </a>
		
		
<!-------------- template a due colonne fisse e una liquida L. --------------------->
		
		
<!-- testata 3 colonne -->
<div id="intestazione-template">
		
	<!-- testata loghi -->
	<div id="header">
            <template_field class="microtemplate_field" name="header">header</template_field>
	</div>

	
	<!-- START mainmenu - barra dei menu -->
	<div id="mainmenu">
		
			<!-- menu -->
            	<ul id="menu">
                <li id="home_cons">
                    <a href="user.php">
                        <i class="icon-home icon-large"></i> <i18n>home</i18n>
                    </a>
                </li>
				<li id="profilo">
                    <a href="edit_user.php">
                        <i class="icon-user icon-large"></i> <i18n>profilo</i18n>
                    </a>
                </li>
				<li id="cronologia">
                    <a href="history.php">
                        <i class="icon-time icon-large"></i> <i18n>cronologia</i18n>
                    </a>
                </li>
				
				<!--
                <li id="com" class="unselectedcom" onClick="toggleElementVisibility('submenu_com','up')">
                    <a>
                        <i18n>comunica</i18n>
                    </a>
                </li>
                <li id="tools" class="unselectedtools" onClick="toggleElementVisibility('submenu_tools','up')">
                    <a>
                        <i18n>strumenti</i18n>
                    </a>
                </li>
				
				
                <li id="actions" class="unselectedactions" onClick="toggleElementVisibility('submenu_actions','up')">
                    <a>
                        <i18n>agisci</i18n>
                    </a>
                </li>
				
				
                <li id="ancora_menuright" onClick="toggleElementVisibility('menuright', 'right');">
                    <a>
                        <i18n>Naviga</i18n>
                    </a>
                </li>
				-->
                <li id="question_mark_cons" class="unselectedquestion_mark_cons" onClick="toggleElementVisibility('submenu_question_mark','up'); return false;">
                    <a>
                        <i class="icon-question icon-large"></i> <i18n>Help</i18n>
                    </a>
                </li>
                <li id="esc_cons">
                    <a href="../index.php">
                        <i class="icon-off icon-large"></i> <i18n>esci</i18n>
                    </a>
                </li>
            	</ul>
            <!-- / menu -->

            <!-- notifiche eventi -->
            <template_field class="template_field" name="events">events</template_field>
            <!-- / notifiche eventi -->
            
		<!-- dropdownmenu-tendina -->
		<div id="dropdownmenu">
               
			    <!-- submenu_com-comunica -->
                <div id="submenu_com" class="sottomenu sottomenu_off">
                    
					<!-- comcontent -->
					<div id="_comcontent">
                        <ul>
                            <li>
                                <a href="#" onclick='openMessenger("../comunica/list_messages.php",800,600);'>
                                    <i18n>messaggeria</i18n>
                                </a>
                            </li>
                            <li>
                                <a href="main_index.php?op=forum">
                                    <i18n>forum</i18n>
                                </a>
                            </li>
                            <li>
                            <template_field class="template_field" name="chat">chat</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="video_chat">video_chat</template_field>
                            </li>
                            <li>
                                <a href="download.php">
                                    <i18n>collabora</i18n>
                                </a>
                            </li>
                            
                        </ul>
                    </div>
					<!-- / comcontent -->
					
                    <div class="bottomsubmenu">
                    </div>
                </div>
				<!-- / submenu_com-comunica -->
				
				
                <!-- strumenti-submenu_tools -->
                <div id="submenu_tools" class="sottomenu sottomenu_off">
                    
					 <!-- _toolscontent -->
					<div id="_toolscontent">
                        <ul>
                            <li>
                                <a href="#" onclick='openMessenger("../comunica/list_events.php",800,600);'>
                                    <i18n>agenda</i18n>
                                </a>
                            </li>
                            <li>
                                <a href="mylog.php">
                                    <i18n>diario</i18n>
                                </a>
                            </li>
                            <li>
                                <a href="history.php">
                                    <i18n>cronologia</i18n>
                                </a>
                            </li>
							<li>
                                <template_field class="template_field" name="exercise_history">exercise_history</template_field>
                            </li>
							<li>
                                <template_field class="template_field" name="test_history">test_history</template_field>
                            </li>
							<li>
                                <template_field class="template_field" name="survey_history">survey_history</template_field>
                            </li>
                            <!--
                            <li>
                                <a href="lemming.php">
                                    <i18n>lessico</i18n>
                                </a>
                            </li>
                            -->
                            <li>
                                <a href="search.php">
                                    <i18n>cerca</i18n>
                                </a>
                            </li>
                            <li>
                            <template_field class="template_field" name="go_print">go_print</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="bookmarks">bookmarks</template_field>
                            </li>
                        </ul>
                    </div>
					<!-- / _toolscontent -->
					
					
                    <div class="bottomsubmenu">
                    </div>
					
                </div>
				<!-- / strumenti-submenu_tools -->


                <!-- submenu_actions-azioni -->
                <div id="submenu_actions" class="sottomenu sottomenu_off">
                    
					
					<!-- _actionscontent -->
					<div id="_actionscontent">
                        <ul>
                            <li>
                                <a href="edit_user.php">
                                    <i18n>Modifica il tuo profilo</i18n>
                                </a>
                            </li>
                            <li>
                            <template_field class="template_field" name="send_media">send_media</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="add_bookmark">add_bookmark</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="add_node">add_node</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="add_word">add_word</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="edit_node">edit_node</template_field>
                            </li>
                            <!-- versione con JS di controllo... ma dov'è?
                            <li>
                                <a href="#" onclick="<template_field class="template_field_disabled" name="delete_node">delete_node</template_field>">
                                    <i18n>Elimina nodo</i18n>
                                </a>
                            </li>
                            -->
                            <!-- version direttaa.... -->
                            <li>
                            <template_field class="template_field" name="delete_node">delete_node</template_field>
                            </li>

                            <li>
                            <template_field class="template_field" name="add_exercise">add_exercise</template_field>
                            </li>
							<li>
                            <template_field class="template_field" name="add_test">add_test</template_field>
                            </li>
							<li>
                            <template_field class="template_field" name="add_survey">add_survey</template_field>
							</li>
                            <li>
                            <template_field class="template_field" name="add_note">add_note</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="add_private_note">add_private_note</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="edit_note">edit_note</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="delete_note">delete_note</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="publish_note">publish_note</template_field>
                            </li>
                            <li>
                            <template_field class="template_field" name="go_XML">go_XML</template_field>
                            </li>
                        </ul>
                    </div>
					<!-- _actionscontent -->
					
                    <div class="bottomsubmenu">
                    </div>
					
                </div>
                <!-- / submenu_actions-azioni -->
                
				<!-- puntoint -->
                <div id="submenu_question_mark" class="sottomenu  sottomenu_off">
                    <div id="_question_markcontent">
                        <ul>
                            <li>
                            <template_field class="template_field" name="help">help</template_field>
                            </li>
                            <li>
                                <a href="../help.php" target="_blank">
                                    <i18n>informazioni</i18n>
                                </a>
                            </li>
                            <li>
                                <a href="../credits.php">
                                    <i18n>credits</i18n>
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="bottomsubmenu">
                    </div>
                </div>
                <!-- / puntoint -->
				
				
		</div>
		<!-- / dropdownmenu-tendina -->

	</div>
	<!-- / END mainmenu - barra dei menu -->
	
	<!-- journey - barra del breadcrumb -->
	<div id="journey">
                <i18n>dove sei: </i18n>
                <span>
                    <template_field class="template_field" name="course_title">course_title</template_field>
                </span>
                <span> > </span>
                <span>
                    <template_field class="template_field" name="path">path</template_field>
                </span>
	</div>
	<!-- / journey - barra del breadcrumb -->
		
		
		
</div>
<!-- / testata 3 colonne -->
		






<!-- START 3 colonne -->

<!-- <div id="wrapper"> -->
<div id="corpo">
	<div id="ausiliario">
				
				
				<!-- COLONNA 1 -->
				<div id="colonna-1">
				
				<!-- pannello-sx -->
				<div id="pannello-sx">
				 
				 
				<!-- bottoniera-pannello-sx -->
				<ul id="menu-col-sx">
				
				<li id="utente_cons">
				
				
				<!--dati utente-->
            			<span id="icouser"><i class="icon-user icon-large"></i></span> 
						<div class="dati_utente_cons">
	                		<i18n>utente: </i18n>
	                		<span>
	                    	<template_field class="template_field" name="user_name">user_name</template_field>
	                		</span><br/>
	                		<i18n>tipo: </i18n>
	                		<span>
	                   		<template_field class="template_field" name="user_type">user_type</template_field>
	                		</span><br/>
							<i18n>livello: </i18n>
	                		<span>
	                    	<template_field class="template_field" name="user_level">user_level</template_field>
	                		</span><br/>
	               			<!--   <div class="status"> -->
	                   		<i18n>status: </i18n>
	                   		<span>
	                       	<template_field class="template_field" name="status">status</template_field>
	                   		</span>
                   		</div>
               			<!--  </div> -->
            		
            <!-- / dati utente -->
				
				
                    <!--  <a href="utente_cons.php">
                        <i18n>utente</i18n>
                    </a>  -->
                </li>
                <li id="indice_corso">
                    <a href="main_index.php">
                        <i class="icon-list-alt icon-large"></i> <i18n>indice corso</i18n>
                    </a>
                </li>
				<li id="glossario">
                    <a href="#">
                        <i class="icon-book icon-large"></i> <i18n>glossario</i18n>
                    </a>
                </li>
				<li id="riferimenti_normativa">
                    <a href="view.php?id_node=109_10">
                        <i class="icon-folder-open icon-large"></i> <i18n>riferimenti normativa</i18n>
                    </a>
                </li>
				<li id="print_cons">
					<template_field class="template_field" name="go_print">go_print</template_field>                    
                </li>
				</ul>
				<!-- / bottoniera-pannello-sx -->
				 
				 
				 
				 
				 		
				
				
				
				</div>
				<!-- / pannello-sx -->
				
				</div>
				<!-- / COLONNA 1 -->
				

				<!-- COLONNA 2 -->
				<div id="colonna-2"> 
				<p>
				
			<!-- contenuto -->
            <div id="content_view">
                <div id="contentcontent" class="contentcontent_view">
                    
					<div id="info_nodo">
                        <span>
                            <template_field class="template_field" name="bookmark">bookmark</template_field>
                        </span>
                    </div>
                    
					
					<!-- firstnode -->
					<div class="firstnode">
					
						<!-- video -->
				
				<div id="box-video">
				<table border="0" id="videogrid">
				<tbody>
				<tr>
				<td><div id="freccia-video-sx">
					<template_field class="template_field" name="go_prev">go_prev</template_field>
				</div></td>
				<td><template_field class="template_field" name="text">text</template_field>
				</td>
				<td><div id="freccia-video-dx">
					<template_field class="template_field" name="go_next">go_next</template_field>
				</div></td>
				</tr>
				</tbody>
				</table>
				</div>
			
						<!-- / video -->
					
					<!-- giorgio, commented 09092013 <template_field class="template_field" name="text">text</template_field> -->
                    </div>
					<!-- / firstnode -->
					
					<!-- luca commentate note di classe 
		    			<hr>
		    		
						<div id="index_in_text">
		      			<h3><i18n>note di classe</i18n></h3>
                         <template_field class="template_field" name="notes">notes</template_field>
					-->
			   		<!--h3><i18n>Approfondimenti:</i18n></h3-->
			    	<!--template_field class="template_field" name="index">index</template_field-->
		  			
					<!-- </div> -->
					
					
					<!-- luca commentate note personali
					
		  			<div id="exercises_in_text">
		      		<h3><i18n>note personali</i18n></h3>
		       		<template_field class="template_field" name="personal">personal</template_field>
					-->
					<!--template_field class="template_field" name="exercises">exercises</template_field-->
		  			<!-- </div> -->

			</div>
                <div id="bottomcont">
                </div>
            </div>
            <!--  / contenuto -->
				
				</p>
				</div>
				<!-- / COLONNA 2 -->
		
				<!-- COLONNA 3 -->
				<div id="colonna-3">
				
				
				<!-- pannello-dx -->
				<div id="pannello-dx">
				
				<!--  avatar e balloon -->
				<div id="avatarContainer">
					<div id="avatarimg"></div>
					<div id="balloonArrow"></div>

					 <div id="balloon"><p class='balloonContent'></p>
					
					<p class="keywords">
					<b><i18n>keywords: </i18n></b><br/>
						<template_field class="template_field" name="keywords">keywords</template_field>
			<br/><br/>
					<b><i18n>Contenuti visitati:</i18n></b><br/> <b><template_field class="template_field" name="visited_nodes_count">visited_nodes_count</template_field></b>
					<i18n>su un totale di</i18n> <b><template_field class="template_field" name="nodes_count">nodes_count</template_field></b> 
					(<b><template_field class="template_field" name="visited_percent">visited_percent</template_field></b>)

                    </p>


					</div>

				</div>
				
					<!-- menudestra -->
            		<div id="menuright" class="sottomenu_off menuright_view"> 
                
						<div id="topmenur">
                		</div>
                		
						<div id="menurightcontent">
                    	<ul>
                        <li class="close">
                            <a href="#" onClick="toggleElementVisibility('menuright', 'right');">
                                <i18n>chiudi</i18n>
                            </a>
                        </li>
                        <!--li class="_menu">
                                <template_field class="template_field_disabled" name="main_index">main_index</template_field>
                        </li-->
                        <li class="_menu">
                                <template_field class="template_field" name="main_index_text">main_index_text</template_field>
                        </li>
                        <li class="_menu">
							<template_field class="template_field" name="search_form">search_form</template_field>
                        </li>
                        <!--li class="_menu">
							<template_field class="template_field" name="go_map">go_map</template_field>
                        </li-->
                    	</ul>
                    	
						<ul id="attachment">
                        <li class="_name">
                        <i18n>approfondimenti</i18n>
                        </li>
                        <ul>
                            <li>
                            <template_field class="template_field" name="index">index</template_field>
                            </li>
                        </ul>
                        <li class="_name">
                        <i18n>collegamenti</i18n>
                        </li>
                        <ul>
                            <li>
                            <template_field class="template_field" name="link">link</template_field>
                            </li>
                        </ul>
                        <li class="_name">
                        <i18n>esercizi</i18n>
                        </li>
                        <ul>
                            <li>
                            <template_field class="template_field" name="exercises">exercises</template_field>
                            </li>
                        </ul>
                        <li class="_name">
                        <i18n>risorse</i18n>
                        </li>
                        <ul>
                            <li>
                            <template_field class="template_field" name="media">media</template_field>
                            </li>
                        </ul>
                        <!-- li class="_name">
                        <i18n>media di classe</i18n>
                        </li -->
                        <!-- ul>
                            <li>
                            <template_field class="template_field_disabled" name="user_media">user_media</template_field>
                            </li>
                        </ul -->
                        <!-- "li class="_name">
                        <i18n>note di classe</i18n>
                        </li -->
                        <!-- ul>
                            <li>
                            <template_field class="template_field_disabled" name="notes">notes</template_field>
                            </li>
                        </ul -->
                        <!-- li class="_name">
                        <i18n>note personali</i18n>
                        </li -->
                        <!-- ul>
                            <li>
                            <template_field class="template_field_disabled" name="personal">personal</template_field>
                            </li>
                        </ul -->
                    	</ul>
                		</div>
                		<div id="bottommenur">
                		</div>
            			
					</div>
            		<!-- / menudestra  -->
				
				</div>
				<!-- / pannello-dx -->
				</div>
				<!-- / COLONNA 3 -->
				
	</div>
</div>
<!-- </div>  -->
<!-- END 3 colonne -->
		







<!-- pie-di-pagina -->
<div id="pie-di-pagina">

            <!-- com_tools -->
           		    <div id="com_tools">
                <div id="topcom_t">
                </div>
                <div id="com_toolscontent">
                 <!--
   <template_field class="microtemplate_field" name="com_tools">com_tools</template_field>
   	-->
                </div>
                <div id="bottomcom_t">
                </div>
            </div>
		
            <!-- /com_tools -->

		<!-- piede -->
        <div id="footer">
            <template_field class="microtemplate_field" name="footer">footer</template_field>
        </div>
        <!-- / piede -->



</div>
<!-- / pie-di-pagina -->
		
		


<!-------------- / template a due colonne fisse e una liquida L. --------------------->
		
		


<!-- label e' stato rimosso -->



<!-- pannello video -->
<!--
        <div id="rightpanel" class="sottomenu_off rightpanel_view">
            <div id="toprightpanel">
            </div>
            <div id="rightpanelcontent">
                <ul>
                    <li class="close">
                        <a href="#" onClick="hideElement('rightpanel', 'right');">
                            <i18n>chiudi</i18n>
                        </a>
                    </li>
                    <li id="flvplayer">
                    </li>
                </ul>
            </div>
            <div id="bottomrightpanel">
            </div>
        </div>
-->
<!-- / pannello video -->
		



    
    </body>
</html>