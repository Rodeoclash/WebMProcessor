_ = require 'lodash'

'use strict'

angular.module('wpMain')
	.factory('interceptor_api_error', ($q) ->

		rails_errors = [422]

		request: (config) ->
			config or $q.when(config)

		requestError: (rejection) ->
			$q.reject rejection

		response: (response) ->
			response or $q.when(response)

		responseError: (rejection) ->

			if _.any(rails_errors, (rails_error) -> rails_error == rejection.status )
				first_error = _.pairs(rejection.data)[0]
				console.error("Error with #{first_error[0]} - #{first_error[1][0]}")
			else if rejection.status >= 500
				console.error("#{rejection.status}: #{rejection.data}")

			$q.reject rejection	
)