'use strict'

angular.module('wpEncodingJob')
	.directive('wpEncodingJobDownload', (
	) ->
		templateUrl: "encoding_job/views/directives/download.html"
		restrict: 'E'
		scope: {
			encodingJob: "="
		}
		link: (scope, element, attrs) ->
			
	)