angular
  .module 'enapparte'
  .directive 'inputSelectDate', ->
    link: (scope, element, attr) ->
      $(element).datetimepicker
        format: "DD/MM/YYYY"
        defaultDate: new Date()

      $(element).on "dp.change", ->
        $(element).find('input').trigger('input') 
 
  .directive 'inputSelectStartDate', ->
    link: (scope, element, attr) ->
      $(element).datetimepicker
        format: "DD/MM/YYYY"
        defaultDate: new Date()

      $(element).on "dp.change", ->
        $(element).find('input').trigger('input')

      scope.$watch 'startDate', (newValue)->
        if scope.startDate
          $("#endDate").data('DateTimePicker').minDate(newValue)
