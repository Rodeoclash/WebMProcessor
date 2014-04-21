'use strict'

angular.module('wpEncodingJob')
	.directive('wpEncodingJobDownload', (
	) ->
		templateUrl: "encoding_job/views/directives/download.html"
		restrict: 'E'
		scope: {
			encoding_job: "=encodingJob"
		}
		link: (scope, element, attrs) ->
			
	)