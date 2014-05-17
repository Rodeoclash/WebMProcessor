'use strict'

angular.module('wpEncodingJob')
	.service 'EncodingJobsModel', (
		API_ROOT
		API_FORMAT
		$resource
	) ->

		resource = $resource("#{API_ROOT}/encoding_jobs/:uuid#{API_FORMAT}", {uuid: '@uuid'}, {update: {method: "PUT"}})
		
		{
			create: (payload) ->
				resource.save(payload).$promise

			get: (options) ->
				resource.get({uuid: options.uuid}).$promise

			resolution: (model) ->
				model.resolution.split('x')
		}