'use strict'

angular.module('wpEncodingJob')
	.directive('wpEncodingJobPlayer', (
		EncodingJobsModel
		$sce
	) ->
		templateUrl: "encoding_job/views/directives/player.html"
		restrict: 'E'
		scope: {
			encodingJob: "="
		}
		link: (scope, element, attrs) ->
			
			scope.videoWidth = (model) ->
				EncodingJobsModel.resolution(model)[0]

			scope.videoHeight = (model) ->
				EncodingJobsModel.resolution(model)[1]

			scope.videoSrc = (model) ->
				$sce.trustAsResourceUrl(model.files.movie.transcoded.url)

			scope.videoPoster = (model) ->
				$sce.trustAsResourceUrl(model.files.movie.screenshot.url)
	)