_ = require 'lodash'

angular.module('wpEncodingJob')
	.directive('wpServerSync', (
	) ->
		restrict: 'E'
		scope: {
			model: "="
		}
		link: (scope, element, attrs) ->

			scope.syncToServer = (model) ->
				model.$update()

			debouncedSyncedtoServer = _.debounce(scope.syncToServer, 1000)

			# automatically sync changes to the server
			scope.$watch('model', (model) ->
				return if !model
				debouncedSyncedtoServer(model)
			, true)
			
	)