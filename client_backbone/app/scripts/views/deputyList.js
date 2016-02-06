/*global define*/

define([
  'jquery',
  'underscore',
  'backbone',
  'templates'
], function ($, _, Backbone, JST) {
  'use strict';

  var DeputyListView = Backbone.View.extend({
    template: JST['app/scripts/templates/deputyList.ejs'],

    tagName: 'div',

    id: 'web-app',

    className: '',

    events: {},

    initialize: function () {
      this.listenTo(this.model, 'change', this.render);
    },

    render: function () {
      this.$el.html(this.template(this.model.toJSON()));
    }
  });

  return DeputyListView;
});
