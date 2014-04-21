'use strict'

angular.module('wpEncodingJob')
	.directive('wpEncodingJobForm', (
		Settings
	) ->
		templateUrl: "encoding_job/views/directives/form.html"
		restrict: 'E'
		scope: {
			model: "="
		}
		link: (scope, element, attrs) ->
			scope.settings = Settings.value()

			scope.$watch('form.$valid', (new_value, old_value) ->
				scope.$emit('form-validity', { is_valid: new_value })
			)
	)