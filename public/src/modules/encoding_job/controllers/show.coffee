_ = require('lodash')

'use strict'

angular.module('wpEncodingJob')
	.controller 'EndcodingJobShowCtrl', (
		$scope
		$routeParams
		$location
		$firebase
		ResourceEncodingJobs
		settings
	) ->

		ref = new Firebase("#{settings.FIREBASE_URI}/#{$routeParams.uuid}")
		has_fetched_details = false

		$scope.navigation = {}
		$scope.status = $firebase(ref)

		$scope.hasStatus = () ->
			$scope.status? && $scope.status.status?

		$scope.hasEncodingJob = () ->
			$scope.encoding_job?

		$scope.navigation.encodeAnotherVideo = () ->
			$location.path('/encoding_job')

		$scope.$watch('status.ready_for_download', (v) ->
			if v == true && has_fetched_details == false
				has_fetched_details = true
				ResourceEncodingJobs.get({uuid: $routeParams.uuid}).then (response) ->
					$scope.encoding_job = response
		)