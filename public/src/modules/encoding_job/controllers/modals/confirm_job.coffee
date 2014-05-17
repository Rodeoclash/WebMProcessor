

'use strict'

angular.module('wpEncodingJob')
	.controller 'EndcodingJobModalConfirmJob', (
		$scope
		$modalInstance
		encodingJob
	) ->

		$scope.encodingJob = encodingJob

		$scope.cancel = () ->
			$modalInstance.dismiss()

		$scope.go = () ->
			$modalInstance.close()