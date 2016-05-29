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

  init: ->

    @scope.tabs = [
      { heading: 'Dashboard', route: 'dashboard.index' }
      { heading: 'Profil', route: 'dashboard.profile.personal', routeActive: 'dashboard.profile' }
      { heading: 'Messages', route: 'dashboard.messages' }
      { heading: 'Mes performances', route: 'dashboard.performances.current', routeActive: 'dashboard.performances' }
      { heading: 'Mes réservations', route: 'dashboard.reservations.current', routeActive: 'dashboard.reservations' }
      { heading: 'Compte', route: 'dashboard.account.payment', routeActive: 'dashboard.account' }
    ]

    tabShow = { heading: 'Mes performances', route: 'dashboard.shows' }
    tabPerformer = {heading: 'Calendrier', route: "dashboard.calendar", routeActive: 'dashboard.calendar'}
    tabGallery = {heading: 'Gallery', route: "dashboard.gallery", routeActive: 'dashboard.gallery'}

    if @isPerformer()
      @scope.tabs.push tabShow
      @scope.tabs.push tabPerformer
      @scope.tabs.push tabGallery


    @Show
      .query()
      .then (shows)=>

  isPerformer: ->
    @Auth._currentUser.role in ["performer"]
