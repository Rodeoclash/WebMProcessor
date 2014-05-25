angular.module("templates", []).run(["$templateCache", function($templateCache) {$templateCache.put("encoding_job/views/directives/details.html","<div class=\"directive directive_wp_encoding_job_details\">\n	<div class=\"list-group\">\n		<div class=\"list-group-item\">\n			<h4 class=\"list-group-item-heading\">Framerate</h4>\n			<p class=\"list-group-item-text\">{{encodingJob.frame_rate}}</p>\n		</div>\n		<div class=\"list-group-item\">\n			<h4 class=\"list-group-item-heading\">Resolution</h4>\n			<p class=\"list-group-item-text\">{{encodingJob.resolution}}</p>\n		</div>\n		<div class=\"list-group-item\">\n			<h4 class=\"list-group-item-heading\">Bitrate</h4>\n			<p class=\"list-group-item-text\">{{encodingJob.video_bitrate}}</p>\n		</div>\n		<div class=\"list-group-item\">\n			<h4 class=\"list-group-item-heading\">Bitrate tolerance</h4>\n			<p class=\"list-group-item-text\">{{encodingJob.video_bitrate_tolerance}}</p>\n		</div>\n		<div class=\"list-group-item\">\n			<h4 class=\"list-group-item-heading\">Keyframe interval</h4>\n			<p class=\"list-group-item-text\">{{encodingJob.keyframe_interval}}</p>\n		</div>\n		<div class=\"list-group-item\">\n			<h4 class=\"list-group-item-heading\">Start from (seconds)</h4>\n			<p class=\"list-group-item-text\">{{encodingJob.seek_time}}</p>\n		</div>\n		<div class=\"list-group-item\">\n			<h4 class=\"list-group-item-heading\">Duration (seconds)</h4>\n			<p class=\"list-group-item-text\">{{encodingJob.duration}}</p>\n		</div>\n	</div>\n</div>");
$templateCache.put("encoding_job/views/directives/download.html","<div class=\"directive directive_wp_encoding_job_download\">\n	<p><a class=\"btn btn-primary\" href=\"{{encodingJob.files.movie.transcoded.url}}\">Download video</a></p>\n</div>");
$templateCache.put("encoding_job/views/directives/form.html","<div class=\"directive directive_wp_form directive_wp_encoding_job_form\">\n	<form role=\"form\" name=\"form\">\n\n		<bootstrap:form:group for=\"notification_email_address\" label=\"Notification email address\" help=\"Encoding can sometimes take a pretty long time... if you want to be notified when the encoding is finished, leave your email address. We will never send you spam, just updates about the job.\">\n			<input id=\"notification_email_address\" class=\"form-control\" type=\"email\" ng:model=\"model.notification_email_address\" name=\"notification_email_address\" placeholder=\"you@example.com\">\n		</bootstrap:form:group>\n		\n		<bootstrap:form:group for=\"frame_rate\" label=\"Framerate\" help=\"This should match the original framerate of the video you\'re uploading.\">\n			<input id=\"frame_rate\" class=\"form-control\" type=\"number\" ng:model=\"model.frame_rate\" name=\"frame_rate\" placeholder=\"24, 30, 48, 60 etc (min: {{settings.MIN_FRAME_RATE}}, max: {{settings.MAX_FRAME_RATE}})\" ng-minlength=\"{{settings.MIN_FRAME_RATE}}\" ng-maxlength=\"{{settings.MAX_FRAME_RATE}}\" required>\n		</bootstrap:form:group>\n\n		<bootstrap:form:group for=\"resolution\" label=\"Resolution\" help=\"Scale your video up or down in screen size. Looks best when it matches your original videos resolution.\">\n			<select class=\"form-control\" id=\"resolution\" ng:model=\"model.resolution\" name=\"resolution\" ng:options=\"resolution.value as resolution.name for resolution in settings.RESOLUTIONS\" required>\n				<option value=\"\">-- Please Choose --</option>\n			</select>\n		</bootstrap:form:group>\n\n		<bootstrap:form:group for=\"video_bitrate\" label=\"Bitrate (in kb/s)\" help=\"This is the target bitrate, higher means better quality but larger file sizes. Try starting at the default value already entered and adjusting it up from that.\">\n			<input id=\"video_bitrate\" class=\"form-control\" type=\"number\" ng:model=\"model.video_bitrate\" name=\"video_bitrate\" placeholder=\"(min: {{settings.MIN_BIT_RATE}}, max: {{settings.MAX_BIT_RATE}})\" ng-minlength=\"{{settings.MIN_BIT_RATE}}\" ng-maxlength=\"{{settings.MAX_BIT_RATE}}\" required>\n		</bootstrap:form:group>\n\n		<bootstrap:form:group for=\"video_bitrate_tolerance\" label=\"Bitrate tolerance\" help=\"Specifies how far the encoding can deviate from the variable bitrate specified above. Making this too large can increase the filesize or have an adverse effect on the quality.\">\n			<input id=\"video_bitrate_tolerance\" class=\"form-control\" type=\"number\" ng:model=\"model.video_bitrate_tolerance\" name=\"video_bitrate_tolerance\" placeholder=\"(min: {{settings.MIN_BIT_RATE_TOLERANCE}}, max: {{settings.MAX_BIT_RATE_TOLERANCE}})\" ng-minlength=\"{{settings.MIN_BIT_RATE_TOLERANCE}}\" ng-maxlength=\"{{settings.MAX_BIT_RATE_TOLERANCE}}\" required>\n		</bootstrap:form:group>\n\n		<bootstrap:form:group for=\"keyframe_interval\" label=\"Keyframe interval\" help=\"High values in this will help a small amount with filesize but make seeking in the video harder. Best to leave at the default.\">\n			<input id=\"keyframe_interval\" class=\"form-control\" type=\"number\" ng:model=\"model.keyframe_interval\" name=\"keyframe_interval\" placeholder=\"(min: {{settings.MIN_KEYFRAME_INTERVAL}}, max: {{settings.MAX_KEYFRAME_INTERVAL}})\" ng-minlength=\"{{settings.MIN_KEYFRAME_INTERVAL}}\" ng-maxlength=\"{{settings.MAX_KEYFRAME_INTERVAL}}\" required>\n		</bootstrap:form:group>\n\n		<bootstrap:form:group for=\"seek_time\" label=\"Start from\" help=\"Where to start encoding from, in seconds.\">\n			<input id=\"seek_time\" class=\"form-control\" type=\"number\" ng:model=\"model.seek_time\" name=\"seek_time\" placeholder=\"In seconds\">\n		</bootstrap:form:group>\n\n		<bootstrap:form:group for=\"duration\" label=\"Duration\" help=\"How long the video should be, in seconds (max: {{settings.MAX_DURATION}} seconds)\">\n			<input id=\"duration\" class=\"form-control\" type=\"number\" ng:model=\"model.duration\" name=\"duration\" placeholder=\"In seconds\" ng-minlength=\"{{settings.MIN_DURATION}}\" ng-maxlength=\"{{settings.MAX_DURATION}}\" required>\n		</bootstrap:form:group>\n\n	</form>\n</div>");
$templateCache.put("encoding_job/views/directives/player.html","<div class=\"directive directive_wp_encoding_job_player\">\n	<video controls loop muted width=\"100%\">\n		Sorry, your browser doesn\'t support embedded WebM videos.\n	</video>\n</div>");
$templateCache.put("encoding_job/views/directives/status.html","<div class=\"directive directive_wp_encoding_job_status\">\n	<!--<progressbar class=\"progress-striped\" value=\"firebase.progress_percentage\">{{firebase.progress_percentage}}%</progressbar>-->\n	<p class=\"status\">{{firebase.status}}</p>\n</div>");
$templateCache.put("encoding_job/views/directives/upload_movie.html","<div class=\"directive directive_wp_encoding_job_upload_movie\">\n\n	<!-- if we\'re not uploading and haven\'t uploaded already -->\n	<div ng:show=\"isNotUploaded()\">\n		<div class=\"upload_target\" ng-file-drop=\"onFileSelect($files)\" ng-file-drag-over-class=\"highlight_drop_target\">\n			<div class=\"upload_icon\"><span class=\"glyphicon glyphicon-cloud-upload\"></span></div>\n			<p class=\"instructions\">Drag and drop movie here (sized between {{min_filesize}} and {{max_filesize}})</p>\n		</div>\n	</div>\n\n	<!-- if we\'re in the process of uploading to S3 -->\n	<div ng:show=\"isUploading()\">\n		<div class=\"upload_progress\">\n			<div ng-show=\"percent_uploaded == 0\">\n				<busy-indicator>\n					<p class=\"instructions\">Preparing upload...</p>\n				</busy-indicator>\n			</div>\n			<div ng-show=\"percent_uploaded > 0\">\n				<progressbar class=\"progress-striped\" value=\"percent_uploaded\">{{percent_uploaded}}%</progressbar>\n				<p class=\"instructions\">Uploading now...</p>\n			</div>\n		</div>\n	</div>\n\n	<!-- if the upload is finished -->\n	<div ng:show=\"isUploaded()\">\n		<div class=\"upload_control\">\n			<p>Uploaded!</p>\n			<button class=\"btn btn-danger\" ng-click=\"removeMovie()\">Remove movie</button>\n		</div>\n	</div>\n\n</div>");
$templateCache.put("encoding_job/views/modals/confirm_encoding_job_start.html","<div class=\"modal_window modal_window_confirm_job\">\n	<div class=\"modal-header\">\n		<h3>Confirm Job</h3>\n	</div>\n	<div class=\"modal-body\">\n		<wp-encoding-job-details encoding-job=\"encodingJob\"></wp-encoding-job-details>\n	</div>\n	<div class=\"modal-footer\">\n		<button class=\"btn btn-default\" ng-click=\"cancel()\">Cancel</button>\n		<button class=\"btn btn-primary\" ng-click=\"go()\">Go!</button>\n	</div>\n</div>");
$templateCache.put("encoding_job/views/pages/new.html","<div class=\"page page_encoding_job_new\">\n	<div class=\"content\">\n\n		<!-- page busy -->\n		<div ng-if=\"busy()\">\n			<busy-indicator>Working...</busy-indicator>\n		</div>\n\n		<!-- acknowledged the terms -->\n		<div ng-if=\"!busy()\">\n		\n			<wp-server-sync model=\"encodingJob\"></wp-server-sync>\n			<wp-encoding-job-upload-movie encoding-job=\"encodingJob\"></wp-encoding-job-upload-movie>\n			<wp-encoding-job-form model=\"encodingJob\"></wp-encoding-job-form>\n\n			<div class=\"controls_and_validation\">\n				<button type=\"submit\" class=\"btn btn-default\" ng-click=\"startEncoding()\" ng-disabled=\"formInvalid()\">Start encoding</button>\n				<p>\n					<ul class=\"form_errors\">\n						<li ng-show=\"!encodingJob.s3_response && !encodingJob.uploading_to_server\">Please upload a movie.</li>\n						<li ng-show=\"!form_valid\">Please make sure the form is valid.</li>\n						<li ng-show=\"encodingJob.uploading_to_server && !encodingJob.s3_response\">Please wait for the video upload to finish.</li>\n					</ul>\n				</p>\n			</div>\n\n		</div>\n\n	</div>\n</div>");
$templateCache.put("encoding_job/views/pages/show.html","<div ng:if=\"!hasStatus()\">\n	<busy-indicator>Fetching video encoding status...</busy-indicator>\n</div>\n\n<div ng:if=\"hasStatus()\">\n	<wp-encoding-job-status firebase=\"firebase\"></wp-encoding-job-status>\n</div>\n\n<!-- shown when job is finished -->\n<div ng:if=\"hasEncodingJob()\">\n\n	<h3>Video details</h3>\n	<wp-encoding-job-details encoding-job=\"encodingJob\"></wp-encoding-job-details>\n\n	<h3>Download video</h3>\n	<p>(right click and choose \"save as\")</p>\n	<wp-encoding-job-download encoding-job=\"encodingJob\"></wp-encoding-job-download>\n\n	<h3>Play video</h3>\n	<wp-encoding-job-player encoding-job=\"encodingJob\"></wp-encoding-job-player>\n\n</div>");
$templateCache.put("main/views/directives/bootstrap_form_group.html","<div class=\"form-group directive directive_bootstrap_form_group\" ng:class=\"{\'has-error\': !control.$valid && control.$dirty}\">\n	<label class=\"control-label\" for=\"{{id}}\">{{label}}</label>\n	<div>\n		<div ng:transclude></div ng:transclude>\n		<span class=\"help-block\">{{help}}</span>\n		<span class=\"help-block\" ng:show=\"control.$error.required && control.$dirty\">{{label}} is required</span>\n		<span class=\"help-block\" ng:show=\"control.$error.email && control.$dirty\">{{label}} is not a valid email address</span>\n		<span class=\"help-block\" ng:show=\"control.$error.number && control.$dirty\">{{label}} is not a number</span>\n		<span class=\"help-block\" ng:show=\"control.$error.minlength && control.$dirty\">{{label}} exceeds the maximum value allowed</span>\n		<span class=\"help-block\" ng:show=\"control.$error.maxlength && control.$dirty\">{{label}} is under the minimum value allowed</span>\n	</div>\n</div>");
$templateCache.put("main/views/directives/busy_indicator.html","<div class=\"directive directive_busy_indicator\">\n	<rotating-plane-spinner></rotating-plane-spinner>\n	<p class=\"message\" ng:transclude></p ng:transclude>\n</div>");
$templateCache.put("main/views/directives/notifications.html","<div class=\"directive directive_notifications\">\n	<div flash-alert active-class=\"in alert\" class=\"fade\">\n		<span class=\"alert-message\">{{flash.message}}</span>\n	</div>\n</div>");
$templateCache.put("main/views/pages/index.html","<div class=\"page page_main_index\">\n	<div class=\"content\">\n		<p>Make short WebM format clips of your videos. Upload them to websites.</p>\n		<button type=\"submit\" class=\"btn btn-default\" ng-click=\"startEncodingJob()\">Start encoding job</button>\n	</div>\n</div>");}]);