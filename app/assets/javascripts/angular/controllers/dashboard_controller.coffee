class DashboardController extends @NGController
  @register window.App, 'DashboardController'

  @$inject: [
    '$scope'
    '$rootScope'
    '$state'
    'Show'
    'Auth'
    'Flash'
  ]

  tabs: [
    { heading: 'Dashboard', route: 'dashboard.index' }
    { heading: 'Profile', route: 'dashboard.profile.personal', routeActive: 'dashboard.profile' }
    { heading: 'Messages', route: 'dashboard.messages' }
    { heading: 'My Performances', route: 'dashboard.performances.current', routeActive: 'dashboard.performances' }
    { heading: 'My Reservations', route: 'dashboard.reservations.current', routeActive: 'dashboard.reservations' }
    { heading: 'Account', route: 'dashboard.account.payment', routeActive: 'dashboard.account' }
  ]

  init: ->
    @Show
      .query()
      .then (shows)=>

    tabShow = { heading: 'My Shows', route: 'dashboard.shows' }
    tabPerformer = {heading: 'Calendar', route: "dashboard.calendar", routeActive: 'dashboard.calendar'}

    if @rootScope.currentUser.role == "performer"
      @scope.tabs.push tabShow
      @scope.tabs.push tabPerformer
