'use strict'

angular.module('wpEncodingJob')
	.directive('wpEncodingJobStatus', (
	) ->
		templateUrl: "encoding_job/views/directives/status.html"
		restrict: 'E'
		scope: {
			status: "="
		}
		link: (scope, element, attrs) ->
			
	)