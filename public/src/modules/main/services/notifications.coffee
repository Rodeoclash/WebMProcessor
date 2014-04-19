#
# Responsible for fetching the application settings from the server.
#

'use strict'

angular.module('wpMain')
	.service 'Notifications', (flash) ->
		
		{
			info: (msg) ->
				flash.into = msg

			success: (msg) ->
				flash.success = msg

			warn: (msg) ->
				flash.warn = msg

			error: (msg) ->
				flash.error = msg
		}