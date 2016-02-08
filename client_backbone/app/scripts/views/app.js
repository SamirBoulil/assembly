/*global define*/

define([
  'jquery',
  'underscore',
  'backbone',
  'templates',
  'collections/deputies',
  'views/search',
  'views/deputyList',
  'views/deputyDetails'
], function ($, _, Backbone, JST, DeputyCollection, SearchView, DeputyListView, DeputyDetails) {
  'use strict';

  var AppView = Backbone.View.extend({
    template: JST['app/scripts/templates/app.ejs'],

    el: '#webapp',

    events: {},

    initialize: function () {
      var options = {deputyCollection: DeputyCollection};

      this.searchView = new SearchView(options);
      this.DeputyListView = new DeputyListView(options);
      this.deputyDetails = new DeputyDetails();
    },
  });

  return AppView;
});
