'use strict'

angular.module('wpMain', [
	'ngResource',
	'ngRoute'
	'wpEncodingJob'
])

	.constant('MODULE_ROOT', '/scripts/modules')
	.constant('API_ROOT', 'http://localhost:3000/api/v1')
	.constant('API_FORMAT', '.json')

	.config (
		MODULE_ROOT
		$routeProvider
	) ->

		# route configuration
		$routeProvider

			# encoding job index
			.when '/encoding_job',
				templateUrl: "#{MODULE_ROOT}/encoding_job/views/pages/index.html"
				controller: "EndcodingJobIndexCtrl"
				resolve: {
					settings: (Settings) ->
						Settings.$promise
				}


			# redirect to encoding job index
			.otherwise
				redirectTo: '/encoding_job'