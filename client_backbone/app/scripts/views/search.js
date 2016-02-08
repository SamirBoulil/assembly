/*global define*/

define([
  'jquery',
  'underscore',
  'backbone',
  'templates',
  'collections/deputies'
], function ($, _, Backbone, JST, DeputyCollection) {
  'use strict';

  var SearchView = Backbone.View.extend({
    template: JST['app/scripts/templates/search.ejs'],

    el: '#search',

    events: {
    },

    initialize: function (options) {
      options = options || {};
      this.collection = options.deputyCollection;
      this.render();
    },

    render: function () {
      this.$el.html(this.template());
    }
  });

  return SearchView;
});
