'use strict'

angular.module('wpEncodingJob')
	.service 'ResourceEncodingJobs', (API_ROOT, $resource) ->

		resource = $resource("#{API_ROOT}/")
		
		{

		}