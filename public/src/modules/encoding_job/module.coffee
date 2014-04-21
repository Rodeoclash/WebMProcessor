require 'angular'

'use strict'

angular.module('wpEncodingJob', [
])
	.config () ->

require './services/resource_encoding_jobs'
require './controllers/index'
require './controllers/show'
require './controllers/modals/confirm_job'
require './directives/form'
require './directives/status'
require './directives/download'
require './directives/upload_movie'