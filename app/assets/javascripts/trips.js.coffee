# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#vote").val('0');

  $("#increaseButton").click ->
    newValue = 1 + parseInt($("#vote").val())
    $("#vote").val(newValue)

  $("#decreaseButton").click ->
    newValue = parseInt($("#vote").val()) - 1
    $("#vote").val(newValue)

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


  $('#datetimepicker1').datetimepicker({
      pick12HourFormat: false
  });
  $('#datetimepicker2').datetimepicker({
      pick12HourFormat: false
  });
  $('#datetimepicker3').datetimepicker({
      pick12HourFormat: false
  });
  $("#setMinDate").click( -> $('#datetimepicker3').data("DateTimePicker").setMinDate(new Date("june 12, 2013")))
  $("#setMaxDate").click( -> $('#datetimepicker3').data("DateTimePicker").setMaxDate(new Date("july 4, 2013")))
  $("#show").click( -> $('#datetimepicker3').data("DateTimePicker").show())
  $("#disable").click( -> $('#datetimepicker3').data("DateTimePicker").disable())
  $("#enable").click( -> $('#datetimepicker3').data("DateTimePicker").enable())
  $("#setDate").click( -> $('#datetimepicker3').data("DateTimePicker").setDate("2013-10-23 12:00"))
  $("#getDate").click( -> alert($('#datetimepicker3').data("DateTimePicker").getDate()))

App = angular.module("myApp", ["ngRoute", "ui.bootstrap", "templates"])

App.controller("TripCtrl", ["$scope", "$http", "$timeout", "$filter", ($scope, $http, $timeout, $filter) ->
  $scope.trips = []
  $scope.lunchCount = 0
  $scope.value = 10
  $scope.items = [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

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

App.directive('progressbar', [ ->
    restrict: 'A',
    scope:
        'progress': '=progressbar'
    controller: ($scope, $element, $attrs) ->
      $element.progressbar
        value: $scope.progress

      $scope.$watch ->
        $element.progressbar value: $scope.progress
])

App.config([ '$routeProvider', ($routeProvider)->
  $routeProvider
    .when('/',
      templateUrl: "trip_details.html",
      controller: 'TripCtrl'
    )

  console.log "I AM IN App.config"
])
