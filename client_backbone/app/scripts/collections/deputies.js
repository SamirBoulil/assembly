/*global define*/

define([
  'underscore',
  'backbone',
  'models/Deputy'
], function (_, Backbone, DeputyModel) {
  'use strict';

  var DeputiesCollection = Backbone.Collection.extend({
    model: DeputyModel,
    url: 'http://127.0.0.1:8001/deputies'
  });

  return new DeputiesCollection();
});
