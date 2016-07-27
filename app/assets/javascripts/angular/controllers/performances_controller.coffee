class PerformancesController extends @NGController
  @register window.App, 'PerformancesController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Flash'
    'Booking'
    '$state'
  ]

  tabsPerformances: [
    { heading: 'Current', route: 'dashboard.performances.current' }
    { heading: 'History', route: 'dashboard.performances.history' }
    { heading: 'Cancelled', route: 'dashboard.performances.cancelled' }
  ]

  bookings: []

  init: ->
    @Booking
      .query()
      .then (bookings)=>
        @scope.bookings = bookings

  filterCurrentBookings: (elem)->
    (elem.status == 'confirmed' || elem.status == 'pending') && moment(elem.date) >= moment()

  filterOldBookings: (elem)->
    (elem.status == 'confirmed' || elem.status == 'pending') && moment(elem.date) < moment()

  filterCancelBookings: (elem)->
    (elem.status == 'canceled' || elem.status == 'expired')

