/*global define*/

define([
  'underscore',
  'backbone',
  'models/Deputies'
], function (_, Backbone, DeputiesModel) {
  'use strict';

  var DeputiesCollection = Backbone.Collection.extend({
    model: DeputiesModel
  });

  return DeputiesCollection;
});
