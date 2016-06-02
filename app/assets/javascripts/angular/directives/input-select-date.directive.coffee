angular
  .module 'enapparte'
  .directive 'inputSelectDate', ->
    link: (scope, element, attr) ->
      $(element).datetimepicker
        format: "DD/MM/YYYY"
        defaultDate: new Date()

      $(element).on "dp.change", ->
        $(element).find('input').trigger('input') 
 
