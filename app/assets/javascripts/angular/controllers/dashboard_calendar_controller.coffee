class DashboardCalendarController extends @NGController
  @register window.App, 'DashboardCalendarController'

  @$inject: [
    '$scope'
    '$http'
    '$element'
    '$rootScope'
    'Flash'
    '$state'
    'User_availabilities'
    '$stateParams'
  ]

  shows = []
  showId = ""
  events = []

  insert_available_date: ()=>
    availability = {available_at:@scope.available_at}
    scope = @scope
    @http(
        method: 'POST'
        url: '/api/v1/availabilities.json'
        data: {availability:availability}).then ((response) ->
          event = response
          scope.event_param = event
          scope.$broadcast 'insert_success', event
          console.log "insert success controller"
          return
      ), (response) ->
          console.log 'insert error:'+response['status']
          return

  delete_available_date: ()=>
    id = @scope.id
    scope = @scope
    @http(
        method: 'DELETE'
        url: '/api/v1/availabilities/' + @scope.id + '.json'
        ).then ((response) ->
          scope.id = id
          scope.$broadcast 'delete_success'
          console.log "delete success controller"
          return
      ), (response) ->
          console.log 'delete error controller'+response['statusCode']
        return

  weekday_Click : (weekday)->
    switch weekday
      when 'MON' then  @scope.weekday = 1
      when 'TUE' then  @scope.weekday = 2
      when 'WED' then  @scope.weekday = 3
      when 'THU' then  @scope.weekday = 4
    @scope.$broadcast 'weekday_click' 


