'use strict'

angular.module('wpMain', [
	'ngResource',
	'ngRoute'
	'angularFileUpload'
	'wpEncodingJob',
	'ui.bootstrap',
	'angularSpinkit'
])

	.constant('MODULE_ROOT', '/scripts/modules')
	.constant('API_ROOT', 'http://localhost:3000/api/v1')
	.constant('API_FORMAT', '.json')

	.config (
		MODULE_ROOT
		$routeProvider
		$httpProvider
	) ->

		$httpProvider.defaults.withCredentials = true
		$httpProvider.interceptors.push('interceptor_api_error')

		# route configuration
		$routeProvider

			# encoding job home
			.when '/encoding_job',
				templateUrl: "#{MODULE_ROOT}/encoding_job/views/pages/index.html"
				controller: "EndcodingJobIndexCtrl"
				resolve: {
					settings: (Settings) ->
						Settings.$promise
				}

			# encoding job show
			.when '/encoding_job/:id/show',
				templateUrl: "#{MODULE_ROOT}/encoding_job/views/pages/show.html"
				controller: "EndcodingJobShowCtrl"
				resolve: {
					settings: (Settings) ->
						Settings.$promise
				}


			# redirect to encoding job index
			.otherwise
				redirectTo: '/encoding_job'