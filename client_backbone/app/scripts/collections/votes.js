/*global define*/

define([
  'underscore',
  'backbone',
  'models/Votes'
], function (_, Backbone, VotesModel) {
  'use strict';

  var VotesCollection = Backbone.Collection.extend({
    model: VotesModel
  });

  return VotesCollection;
});
