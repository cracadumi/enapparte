angular
  .module 'enapparte'
  .directive 'appendCalendar', ['$timeout', ($timeout)->
    {
      strict: "A"
      link: (scope, $elm, attrs) ->
        $elm.multiDatesPicker
            dateFormat: 'yy-mm-dd'
            minDate: 1
            firstDay: 1
            altField: listDays
    }
  ]