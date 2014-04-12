'use strict'

angular.module('wpEncodingJob')
	.directive('formEncodingJob', (
		MODULE_ROOT
		Settings
	) ->
		templateUrl: "#{MODULE_ROOT}/encoding_job/views/directives/form.html"
		restrict: 'E'
		scope: {
			model: "="
		}
		link: (scope, element, attrs) ->

			scope.settings = Settings.value()

			console.log(scope.settings)

	)