#
# Responsible for fetching the application settings from the server.
#

'use strict'

angular.module('wpMain')
	.service 'Settings', (API_ROOT, API_FORMAT, $http, $q) ->

		deferred = $q.defer()
		settings = null

		$http({
			method: 'GET'
			url: "#{API_ROOT}/settings#{API_FORMAT}"
		}).then (response) ->
			settings = response.data
			deferred.resolve(settings)
		
		{
			$promise: deferred.promise
			value: () ->
				settings
		}