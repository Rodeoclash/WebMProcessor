

'use strict'

angular.module('wpEncodingJob')
	.controller 'EndcodingJobModalConfirmJob', (
		$scope
		$modalInstance
		encoding_job
	) ->

		$scope.encoding_job = encoding_job

		$scope.cancel = () ->
			$modalInstance.dismiss()

		$scope.go = () ->
			$modalInstance.close()