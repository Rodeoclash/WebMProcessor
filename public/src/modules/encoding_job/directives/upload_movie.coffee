require 'angular'
humanize = require('humanize')
_ = require('lodash')

'use strict'

angular.module('wpEncodingJob')
	.directive('wpEncodingJobUploadMovie', (
		$upload
		Settings
	) ->
		templateUrl: "encoding_job/views/directives/upload_movie.html"
		restrict: 'E'
		scope: {
			encoding_job: "=encodingJob"
		}
		link: (scope, element, attrs) ->

			scope.settings = Settings.value()
			scope.percent_uploaded = null

			scope.min_filesize = humanize.filesize(scope.settings.MIN_FILESIZE)
			scope.max_filesize = humanize.filesize(scope.settings.MAX_FILESIZE)

			scope.removeMovie = () ->
				scope.percent_uploaded = null

			scope.onFileSelect = ($files) ->
				scope.percent_uploaded = 0

				scope.encoding_job.uploading_to_server = true

				scope.upload = $upload.upload(
					url: scope.encoding_job.s3_settings.url
					method: 'POST'
					file: $files[0]
					data: {
						'key': scope.encoding_job.s3_settings.key
						'AWSAccessKeyId': scope.encoding_job.s3_settings.aws_access_key_id
						'acl': scope.encoding_job.s3_settings.acl
						'Policy': scope.encoding_job.s3_settings.policy
						'Signature': scope.encoding_job.s3_settings.signature
						'success_action_status': '201'
					}
				).progress( (evt) ->
					scope.percent_uploaded = parseInt(100.0 * evt.loaded / evt.total)

				).success( (data, status, headers, config) ->
					scope.percent_uploaded = 100
					scope.encoding_job.s3_response = data
					scope.encoding_job.uploading_to_server = false

				).error( (data, status, headers, config) ->
					alert('Error trying to upload video! Please try again soon')
					scope.encoding_job.uploading_to_server = false
				)
				
			scope.isNotUploaded = () ->
				_.isNull(scope.percent_uploaded)

			scope.isUploading = () ->
				scope.percent_uploaded >= 0 && scope.percent_uploaded < 100 && !_.isNull(scope.percent_uploaded)

			scope.isUploaded = () ->
				scope.percent_uploaded == 100

	)