require 'firebase'
require 'angular-file-upload-shim'
require 'angular'
require 'angular-resource'
require 'angular-route'
require 'angular-file-upload'
require 'angular-ui'
require 'angular-spinkit'
require 'angular-flash'
require 'angular-fire'

'use strict'

angular.module('wpMain', [
	'ngResource',
	'ngRoute'
	'angularFileUpload'
	'wpEncodingJob',
	'ui.bootstrap',
	'angularSpinkit',
	'templates',
	'angular-flash.service',
	'angular-flash.flash-alert-directive'
	'firebase'
])

	.constant('API_ROOT', '/api/v1')
	.constant('API_FORMAT', '.json')

	.config (
		$routeProvider
		$httpProvider
		flashProvider
	) ->

		flashProvider.errorClassnames.push('alert-danger');

		$httpProvider.defaults.withCredentials = true
		$httpProvider.interceptors.push('interceptor_api_error')

		# route configuration
		$routeProvider

			## Main ##

			.when '/',
				templateUrl: "main/views/pages/index.html"
				controller: "MainIndexCtrl"
				resolve: {
					settings: (Settings) ->
						Settings.$promise
				}

			## Encoding jobs ##

			.when '/encoding_job/new',
				templateUrl: "encoding_job/views/pages/new.html"
				controller: "EndcodingJobNewCtrl"
				resolve: {
					settings: (Settings) ->
						Settings.$promise
				}

			.when '/encoding_job/:uuid/show',
				templateUrl: "encoding_job/views/pages/show.html"
				controller: "EndcodingJobShowCtrl"
				resolve: {
					settings: (Settings) ->
						Settings.$promise
				}

require './services/interceptor_api_error'
require './services/settings'
require './services/notifications'
require './controllers/index'
require './directives/bootstrap_form_group'
require './directives/busy_indicator'
require './directives/notifications'
require './directives/server_sync'