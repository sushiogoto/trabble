# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.locations').hide()
    event.preventDefault()

$('.vote')
  .on('ajax:send', -> $(this).addClass('loading'))
  .on('ajax:complete', -> $(this).removeClass('loading'))
  .on('ajax:error', -> $(this).after('<div class="error">There was an issue.</div>'))
  .on('ajax:success', (data) -> $(this).html(data.count))


App = angular.module("myApp", [])

App.controller("TripCtrl", ["$scope", "$http", "$timeout", ($scope, $http, $timeout) ->
  $scope.trips = []
  $scope.lunchCount = 0

  $scope.increment = ->
    $scope.lunchCount++

  $scope.updateTripsFromServer = ->
    $http.get('/api/trips.json')
      .success (data) ->
        $scope.trips = data

  $scope.updateTripsFromServer()
])