'use strict'

angular.module('wpEncodingJob')
	.controller 'EndcodingJobShowCtrl', (
		$scope
		$routeParams
		$firebase
		ResourceEncodingJobs
		settings
	) ->

		ref = new Firebase("#{settings.FIREBASE_URI}/#{$routeParams.id}")
		$scope.status = $firebase(ref)