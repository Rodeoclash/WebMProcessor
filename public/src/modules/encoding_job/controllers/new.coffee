require 'angular'

angular.module('wpEncodingJob')
	.controller 'EndcodingJobNewCtrl', (
		$scope
		$modal
		$location
		EncodingJobsModel
	) ->

		# create the job on the server, returned payload will contain defaults
		EncodingJobsModel.create().then (response) ->
			$scope.encoding_job = response

		# when the page is busy and interaction is blocked
		$scope.busy = () ->
			!$scope.encoding_job || $scope.encoding_job.start_encoding == true

		# when the form is not allowed to be submitted
		$scope.formInvalid = () ->
			!$scope.encoding_job || !$scope.encoding_job.s3_response || !$scope.form_valid || $scope.encoding_job.uploading_to_server
			
		# called when clicking the start encoding button
		$scope.startEncoding = () ->
			return if $scope.formInvalid()
			
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

		# listen for form validity
		unbindFormValidListener = $scope.$on('form-validity', (event, value) ->
			$scope.form_valid = value.is_valid
		)

		# destroy event bindings on scope destruction
		$scope.$on('$destroy', () ->
			unbindFormValidListener()
		)