class DashboardReservationsController extends @NGController
  @register window.App, 'DashboardReservationsController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Flash'
    'Booking'
    '$state'
  ]

  tabsReservations: [
    { heading: 'Réservations en cours', route: 'dashboard.reservations.current' }
    { heading: 'Historique', route: 'dashboard.reservations.history' }
    { heading: 'Réservations annulées', route: 'dashboard.reservations.cancelled' }
  ]

  bookings: []

  init: ->
    @Booking
      .query( { reservation: true } )
      .then (bookings)=>
        @scope.bookings = bookings

  filterCurrentBookings: (elem)->
    (elem.status == 1 || elem.status == 2) && moment(elem.date) >= moment()

  filterOldBookings: (elem)->
    (elem.status == 1 || elem.status == 2) && moment(elem.date) < moment()

  filterCancelBookings: (elem)->
    (elem.status == 3 || elem.status == 4)

