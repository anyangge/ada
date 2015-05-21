<?php
/**
 * MediaViewingHtmlLib.inc.php
 *
 * @package        MediaViewingHtmlLib.inc
 * @author         Giorgio Consorti <g.consorti@lynxlab.com>         
 * @copyright      Copyright (c) 2014, Lynx s.r.l.
 * @license        http://www.gnu.org/licenses/gpl-2.0.html GNU Public License v.2
 * @link           MediaViewingHtmlLib.inc
 * @version		   0.1
 */

class MediaViewingHtmlLib {
	
	private static $count=0;
	
	private static function getNextDivID() {
		return ++self::$count;
	}
	
	private function jplayerCommonJS($format, $divID, $url, $title=null, $width=null, $height=null) {
		$jplayerCode = '<script type="text/javascript">
						var jplayerNoConflict;
				
						$j(document).ready(function(){
				    		jplayerNoConflict = {
    							jQuery: $j
							};
				
							$j("#jquery_jplayer_'.$divID.'").jPlayer({
								ready: function () {
									$j(this).jPlayer("setMedia", {';
		if (isset($title) && strlen ($title)>0)  $jplayerCode .= 'title: "'.$title.'",';
		/**
		 * format is checked against string 'never' to never display a poster
		 * the following line is here just in case you need to enable a poster
		 */
		if ($format=='never') $jplayerCode .= 'poster: "http://www.localada.com/layout/ada_blu/img/header-logo.png",';
		$jplayerCode .= $format.': "'.$url.'"
									});
								},
								play: function() {
									$j(this).jPlayer("pauseOthers");
								},
				    			size: {
                         			width: "'.$width.'px",
                         			height: "'.$height.'px"
                    			},';
		if ($format=='m4v') $jplayerCode .= 'solution: "flash, html",';
		$jplayerCode .='		noConflict: "jplayerNoConflict.jQuery",
								swfPath: "'.HTTP_ROOT_DIR.'/js/include/jquery/jplayer",
								supplied: "'.$format.'",
								cssSelectorAncestor: "#jp_container_'.$divID.'",
								wmode: "window",
								smoothPlayBar: true,
								keyEnabled: true,
								remainingDuration: true,
								toggleDuration: true
							});
						});
					</script>';
		
		return $jplayerCode;
	}
	
	public static function jplayerMp4Viewer($url, $title=null, $width=null, $height=null) {
		
		$divID = self::getNextDivID();
		
		$jplayerCode = self::jplayerCommonJS('m4v', $divID, $url, $title, $width, $height);
		
		$styleHeightWidth = '';
		$styleMarginTop = '';
		
		if (!is_null($width) || !is_null($height)) {
			$styleHeightWidth .= ' style="';
			if (!is_null($width)) $styleHeightWidth .= 'width:'.$width.'px; ';
			// 70px is the needed room for the interface
			if (!is_null($height)) {
				$styleHeightWidth .= 'height:'.($height+70).'px; ';
				$styleMarginTop .= $styleHeightWidth .'height:'.$height.'px; margin-top:-'.$height.'px;"';
			}
			$styleHeightWidth .= '"';
		}
		
		
		
		$jplayerCode .= '<div id="jp_container_'.$divID.'" class="jp-video"';
		$jplayerCode .= $styleHeightWidth;
		$jplayerCode .= '>
			<div class="jp-type-single">
				<div id="jquery_jplayer_'.$divID.'" class="jp-jplayer"></div>
				<div class="jp-gui">
					<div id="outer-video-play-icon" class="jp-video-play"'.$styleMarginTop.'>
  						<div id="middle-video-play-icon">
							<a href="javascript:;" class="jp-video-play-icon" tabindex="1">play</a>
  						</div>
					</div>
					<div class="jp-interface">
						<div class="jp-progress">
							<div class="jp-seek-bar">
								<div class="jp-play-bar"></div>
							</div>
						</div>
						<div class="jp-current-time"></div>
						<div class="jp-duration"></div>
						<div class="jp-controls-holder">
							<ul class="jp-controls">
								<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
								<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
								<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
								<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
								<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
								<li><div class="jp-volume-bar"><div class="jp-volume-bar-value"></div></div></li>
								<li><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max volume</a></li>
							</ul>
							<ul class="jp-toggles">
								<li><a href="javascript:;" class="jp-full-screen" tabindex="1" title="full screen">full screen</a></li>
								<li><a href="javascript:;" class="jp-restore-screen" tabindex="1" title="restore screen">restore screen</a></li>
							</ul>
						</div>
						<div class="jp-details">
							<ul>
								<li><span class="jp-title"></span></li>
							</ul>
						</div>
					</div>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span>
					To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>';
		
		return $jplayerCode;
	}
	
	public static function jplayerMp3Viewer ($url, $title=null) {
		
		$divID = self::getNextDivID();
		
		$jplayerCode = self::jplayerCommonJS('mp3', $divID, $url, $title);
		
		$jplayerCode .= '<div id="jquery_jplayer_'.$divID.'" class="jp-jplayer"></div>		
		<div id="jp_container_'.$divID.'" class="jp-audio">
			<div class="jp-type-single">
				<div class="jp-gui jp-interface">
					<ul class="jp-controls">
						<li><a href="javascript:;" class="jp-play" tabindex="1">play</a></li>
						<li><a href="javascript:;" class="jp-pause" tabindex="1">pause</a></li>
						<li><a href="javascript:;" class="jp-stop" tabindex="1">stop</a></li>
						<li style="width:50%;">
							<div class="jp-progress"><div class="jp-seek-bar"><div class="jp-play-bar"></div></div></div>
							<div class="jp-time-holder"><div class="jp-current-time"></div><div class="jp-duration"></div></div>
						</li>				
						<li><a href="javascript:;" class="jp-mute" tabindex="1" title="mute">mute</a></li>
						<li><a href="javascript:;" class="jp-unmute" tabindex="1" title="unmute">unmute</a></li>
						<li style="width:12%;"><div class="jp-volume-bar"><div class="jp-volume-bar-value"></div></div></li>
						<li style="width:18px;"><a href="javascript:;" class="jp-volume-max" tabindex="1" title="max volume">max volume</a></li>
					</ul>
				</div>
				<div class="jp-details">
					<ul>
						<li><span class="jp-title"></span></li>
					</ul>
				</div>
				<div class="jp-no-solution">
					<span>Update Required</span>
					To play the media you will need to either update your browser to a recent version or update your <a href="http://get.adobe.com/flashplayer/" target="_blank">Flash plugin</a>.
				</div>
			</div>
		</div>';
		
		return $jplayerCode;
	}
	
}