'use strict'

angular.module('wpMain')
	.directive('bootstrapFormGroup', () ->
		templateUrl: "main/views/directives/bootstrap_form_group.html"
		restrict: 'E'
		require: "^form"
		scope: true
		transclude: true
		link: (scope, element, attrs, form) ->

			scope.control = form[element.find("input").attr('name')]
			attrs.$observe('for', (new_value) -> scope.id = new_value )
			attrs.$observe('label', (new_value) -> scope.label = new_value )
			attrs.$observe('help', (new_value) -> scope.help = new_value )
			
	)