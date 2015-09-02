'use strict'

MainController = ($scope, $http<% if (filters.socketio) { %>, socket<% } %>) ->
  self = this
  @awesomeThings = []
  $http.get('/api/things').then (response) ->
    self.awesomeThings = response.data<% if (filters.socketio) { %>
    socket.syncUpdates 'thing', self.awesomeThings<% } %>
    return
<% if (filters.models) { %>
  @addThing = ->
    if self.newThing == ''
      return
    $http.post '/api/things', name: self.newThing
    self.newThing = ''
    return

  @deleteThing = (thing) ->
    $http.delete '/api/things/' + thing._id
    return<% } %><% if (filters.socketio) { %>

  $scope.$on '$destroy', ->
    socket.unsyncUpdates 'thing'
    return
  return<% } %>

angular.module '<%= scriptAppName %>'
.controller 'MainController', MainController
