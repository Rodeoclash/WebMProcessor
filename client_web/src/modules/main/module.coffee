require 'angular-file-upload-shim'
require 'angular'
require 'angular-resource'
require 'angular-route'
require 'angular-file-upload'
require 'angular-ui'
require 'angular-spinkit'

'use strict'

angular.module('wpMain', [
	'ngResource',
	'ngRoute'
	'angularFileUpload'
	'wpEncodingJob',
	'ui.bootstrap',
	'angularSpinkit',
	'templates'
])

	.constant('API_ROOT', 'http://localhost:3000/api/v1')
	.constant('API_FORMAT', '.json')

	.config (
		$routeProvider
		$httpProvider
	) ->

		$httpProvider.defaults.withCredentials = true
		$httpProvider.interceptors.push('interceptor_api_error')

		# route configuration
		$routeProvider

			# encoding job home
			.when '/encoding_job',
				templateUrl: "encoding_job/views/pages/index.html"
				controller: "EndcodingJobIndexCtrl"
				resolve: {
					settings: (Settings) ->
						Settings.$promise
				}

			# encoding job show
			.when '/encoding_job/:id/show',
				templateUrl: "encoding_job/views/pages/show.html"
				controller: "EndcodingJobShowCtrl"
				resolve: {
					settings: (Settings) ->
						Settings.$promise
				}


			# redirect to encoding job index
			.otherwise
				redirectTo: '/encoding_job'

require './services/interceptor_api_error'
require './services/settings'
require './directives/bootstrap_form_group'
require './directives/busy_indicator'