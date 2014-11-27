# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('.locations').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $('.vote')
    .on('ajax:send', -> $(this).addClass('loading'))
    .on('ajax:complete', -> $(this).removeClass('loading'))
    .on('ajax:error', -> $(this).after('<div class="error">There was an issue.</div>'))
    .on('ajax:success', (data) -> $(this).html(data.count))

  $('#datetimepicker3').datetimepicker({
      pick12HourFormat: false
  });
  $("#setMinDate").click( -> $('#datetimepicker3').data("DateTimePicker").setMinDate(new Date("june 12, 2013")))
  $("#setMaxDate").click( -> $('#datetimepicker3').data("DateTimePicker").setMaxDate(new Date("july 4, 2013")))
  $("#show").click( -> $('#datetimepicker3').data("DateTimePicker").show())
  $("#disable").click( -> $('#datetimepicker3').data("DateTimePicker").disable())
  $("#enable").click( -> $('#datetimepicker3').data("DateTimePicker").enable())
  $("#setDate").click( -> $('#datetimepicker3').data("DateTimePicker").setDate("10/23/2013"))
  $("#getDate").click( -> alert($('#datetimepicker3').data("DateTimePicker").getDate()))

App = angular.module("myApp", ["ngRoute"])

App.controller("TripCtrl", ["$scope", "$http", "$timeout", "$filter", ($scope, $http, $timeout, $filter) ->
  $scope.trips = []
  $scope.lunchCount = 0

  $scope.emailShot = (trip_id, model_name) ->
    jsonObj = { model: model_name }
    $http.post("/email_shot/#{trip_id}.json", jsonObj)
      .success (data) ->
        console.log data

  $scope.deadline = ->
    now = moment();

  $scope.init = (trip) ->
    $http.get('/api/trips/data.json')
      .success (data) ->
        $scope.details = data
        $scope.user = data.user
        $scope.trips = data.trips

  $scope.init()
])

App.config(['$routeProvider', ($routeProvider) ->
  $routeProvider
  .when('/trips/:id', {
    controller: 'TripCtrl',
    resolve: {
      params: ['$route', ($route) ->
        params = {user_id: $route.current.params.user_id}
        debugger
        return params
      ]
    }
  })
])