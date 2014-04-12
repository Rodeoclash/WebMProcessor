'use strict';

describe('Service: Encodingjobsresource', function () {

  // load the service's module
  beforeEach(module('webMprocessorApp'));

  // instantiate service
  var Encodingjobsresource;
  beforeEach(inject(function (_Encodingjobsresource_) {
    Encodingjobsresource = _Encodingjobsresource_;
  }));

  it('should do something', function () {
    expect(!!Encodingjobsresource).toBe(true);
  });

});
