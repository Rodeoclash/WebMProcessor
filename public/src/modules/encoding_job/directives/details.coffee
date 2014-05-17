'use strict'

angular.module('wpEncodingJob')
	.directive('wpEncodingJobDetails', (
	) ->
		templateUrl: "encoding_job/views/directives/details.html"
		restrict: 'E'
		scope: {
			encodingJob: "="
		}
		link: (scope, element, attrs) ->
			
	)