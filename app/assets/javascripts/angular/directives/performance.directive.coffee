angular
  .module 'enapparte'
  .directive 'performance', ['Flash', (Flash)->
    {
      strict: 'E'
      templateUrl: 'performance/list.html'
      scope: {
        booking: '='
      }
      replace: true
      link: (scope, element, attrs, ctrl)->
        # accept
        scope.acceptBooking = (booking, index)->
          booking
            .changeStatus('confirmed')
            .then (result)->
              booking.status = 'confirmed'
              Flash.showNotice('You\'ve accepted the request successfully.')

        # cancel
        scope.cancelBooking = (booking, index)->
          booking
            .changeStatus('canceled')
            .then (result)->
              booking.status = 'canceled'
              Flash.showNotice('You\'ve cancelled the booking request.')
    }
  ]
