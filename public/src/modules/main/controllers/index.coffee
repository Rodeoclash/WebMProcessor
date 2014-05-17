require 'angular'
_ = require 'lodash'

angular.module('wpMain')
	.controller 'MainIndexCtrl', (
		$scope
		$location
	) ->

		$scope.controller = $scope

		$scope.startEncodingJob = () ->
			$location.path('/encoding_job/new')