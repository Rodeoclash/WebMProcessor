require 'angular'
_ = require('lodash')

'use strict'

angular.module('wpEncodingJob')
	.controller 'EndcodingJobIndexCtrl', (
		$scope
		$modal
		$location
		ResourceEncodingJobs
	) ->

		$scope.encoding_job = null
		$scope.form_valid = false

		# starts the process by creating an encoding job on the server
		$scope.getStarted = () ->

			# setting this to true triggers the loading behaviour
			$scope.encoding_job = true

			# create the job on the server, returned payload will contain defaults
			ResourceEncodingJobs.create().then (response) ->
				$scope.encoding_job = response

		$scope.movieUploaded = () ->
			$scope.encoding_job.s3_response?

		# true when we're in the process of creating the start of encoding job on the server
		$scope.starting = () ->
			$scope.encoding_job == true

		# true when the job template has been created on the server
		$scope.started = () ->
			_.isObject($scope.encoding_job)

		# called when clicking the start encoding button
		$scope.startEncoding = () ->
			return unless $scope.movieUploaded() && $scope.form_valid == true
			
			# show confirmation modal with details about the job
			modal_instance = $modal.open({
				templateUrl: "encoding_job/views/modals/confirm_encoding_job_start.html",
				controller: "EndcodingJobModalConfirmJob"
				resolve: {
					encoding_job: () -> $scope.encoding_job
				}
			})

			# on a successful modal callback, set the processing flag to true, save the job then redirect to the status page
			modal_instance.result.then () ->
				$scope.encoding_job.start_encoding = true
				$scope.encoding_job.$update().then () ->
					$location.path("/encoding_job/#{$scope.encoding_job.uuid}/show")

		$scope.syncToServer = () ->
			$scope.saving = true
			$scope.encoding_job.$update().then( () ->
				$scope.saving = false
			, () ->
				$scope.saving = false
			)

		debouncedSyncedtoServer = _.debounce($scope.syncToServer, 1000)

		# automatically sync changes to the server if the job has started and we haven't triggered processing
		$scope.$watch('encoding_job', () ->
			return if !$scope.started() || $scope.encoding_job.start_encoding == true
			debouncedSyncedtoServer()
		, true)

		# listen for form validity
		unbindFormValidListener = $scope.$on('form-validity', (event, value) ->
			$scope.form_valid = value.is_valid
		)

		# destroy event bindings on scope destruction
		$scope.$on('$destroy', () ->
			unbindFormValidListener()
		)