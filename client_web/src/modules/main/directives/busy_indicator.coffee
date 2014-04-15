'use strict'

angular.module('wpMain')
	.directive('busyIndicator', (MODULE_ROOT) ->
		templateUrl: "#{MODULE_ROOT}/main/views/directives/busy_indicator.html"
		restrict: 'E'
		scope: true
		transclude: true
		link: (scope, element, attrs, form) ->

			
			
	)