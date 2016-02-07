/*global define*/

define([
  'underscore',
  'backbone'
], function (_, Backbone) {
  'use strict';

  var DeputyModel = Backbone.Model.extend({
    url: '',

    initialize: function() {
    },

    defaults: {
    },

    validate: function(attrs, options) {
      return true;
    },

    parse: function(response, options)  {
      return response;
    }
  });

  return DeputyModel;
});
