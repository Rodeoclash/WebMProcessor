'use strict'

describe 'Service: ResourceEncodingJobs', ->

  # load the service's module
  beforeEach module 'webMprocessorApp'

  # instantiate service
  ResourceEncodingJobs = {}
  beforeEach inject (_ResourceEncodingJobs_) ->
    ResourceEncodingJobs = _ResourceEncodingJobs_

  it 'should do something', ->
    expect(!!ResourceEncodingJobs).toBe true
