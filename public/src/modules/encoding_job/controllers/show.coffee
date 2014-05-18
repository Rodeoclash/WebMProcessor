_ = require('lodash')

'use strict'

angular.module('wpEncodingJob')
	.controller 'EndcodingJobShowCtrl', (
		$scope
		$routeParams
		$location
		$firebase
		EncodingJobsModel
		settings
	) ->

		ref = new Firebase("#{settings.FIREBASE_URI}/#{$routeParams.uuid}")
		has_fetched_details = false

		$scope.navigation = {}
		$scope.firebase = $firebase(ref)

		$scope.hasStatus = () ->
			$scope.firebase? && $scope.firebase.status?

		$scope.hasEncodingJob = () ->
			$scope.encodingJob?

		$scope.$watch('firebase.ready_for_download', (v) ->
			if v == true && has_fetched_details == false
				has_fetched_details = true
				EncodingJobsModel.get({uuid: $routeParams.uuid}).then (response) ->
					$scope.encodingJob = response
		)