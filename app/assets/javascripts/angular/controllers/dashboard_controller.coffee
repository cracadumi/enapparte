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
    @scope.activeTab = undefined

    @scope.tabs = [
      {
        heading: 'Dashboard'
        route: 'dashboard.index'
        banner: '/assets/dashboard-banners/dashboard.jpg'
      }
      {
        heading: 'Profil'
        route: 'dashboard.profile.personal'
        isActive: @state.includes.bind(@state, 'dashboard.profile')
        banner: '/assets/dashboard-banners/profil.jpg'
      }
      {
        heading: 'Messages'
        route: 'dashboard.messages'
        banner: '/assets/dashboard-banners/messages.jpg'
      }
      {
        heading: 'Mes réservations'
        route: 'dashboard.reservations.current'
        isActive: @state.includes.bind(@state, 'dashboard.reservations')
        banner: '/assets/dashboard-banners/mes-reservations.jpg'
      }
      {
        heading: 'Compte'
        route: 'dashboard.account.payment'
        isActive: @state.includes.bind(@state, 'dashboard.account')
        banner: '/assets/dashboard-banners/compte.jpg'
      }
    ]

    tabShow =
      heading: 'Mes performances'
      route: 'dashboard.shows'
      banner: '/assets/dashboard-banners/mes-performances.jpg'

    tabPerformer =
      heading: 'Calendrier'
      route: "dashboard.calendar"
      banner: '/assets/dashboard-banners/calendrier.jpg'

    tabGallery =
      heading: 'Gallery'
      route: "dashboard.gallery"
      banner: '/assets/dashboard-banners/galerie.jpg'

    if @isPerformer()
      @scope.tabs.push tabShow
      @scope.tabs.push tabPerformer
      @scope.tabs.push tabGallery


    @Show
      .query()
      .then (shows)=>

    @scope.setActiveTab = (tab) =>
      @scope.activeTab = tab

  isPerformer: ->
    @Auth._currentUser.role in ["performer"]
