/*global define*/

define([
  'jquery',
  'underscore',
  'backbone',
  'templates',
  'views/deputyCard'
], function ($, _, Backbone, JST, DeputCardView) {
  'use strict';

  var DeputyListView = Backbone.View.extend({
    template: JST['app/scripts/templates/deputyList.ejs'],

    el: "#deputyList",

    events: {},

    initialize: function (options) {
      options = options || {};
      this.deputyCollection = options.deputyCollection;

      this.listenTo(this.deputyCollection, 'all', _.debounce(this.render, 0));

      this.deputyCollection.fetch();
    },

    render: function () {
      var that = this;

      this.deputyCollection.each(function(deputyModel){
          var view = new DeputCardView({model: deputyModel});
          that.$el.append(view.render().$el);
      });

      return this;
    }
  });

  return DeputyListView;
});
