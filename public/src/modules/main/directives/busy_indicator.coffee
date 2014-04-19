'use strict'

angular.module('wpMain')
	.directive('busyIndicator', () ->
		templateUrl: "main/views/directives/busy_indicator.html"
		restrict: 'E'
		scope: true
		transclude: true
		link: (scope, element, attrs, form) ->

			
			
	)