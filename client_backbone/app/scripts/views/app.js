/*global define*/

define([
  'jquery',
  'underscore',
  'backbone',
  'templates',
  'collections/deputies',
  'views/deputyCard'
], function ($, _, Backbone, JST, DeputyCollection, DeputyCard) {
  'use strict';

  var AppView = Backbone.View.extend({
    template: JST['app/scripts/templates/app.ejs'],

    el: '#webapp',

    events: {},

    initialize: function () {
      this.$deputyList = this.$('#deputyList');
      this.listenTo(DeputyCollection, 'all', _.debounce(this.render, 0));

      DeputyCollection.fetch();
    },

    render: function () {
      var that = this;

      DeputyCollection.each(function(deputyModel){
          var view = new DeputyCard({model: deputyModel});
          that.$deputyList.append(view.render().$el);
      })

      return this;
    }
  });

  return AppView;
});
