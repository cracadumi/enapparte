class ProfileController extends @NGController
  @register window.App, 'ProfileController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Flash'
    'User'
    '$state'
  ]

  tabs2: [
    { heading: 'Profil', route: 'dashboard.profile.personal' }
    { heading: 'Commentaires', route: 'dashboard.profile.reviews.received', routeActive: 'dashboard.profile.reviews' }
  ]

  tabsReviews: [
    { heading: 'Reçus', route: 'dashboard.profile.reviews.received' }
    { heading: 'Envoyés', route: 'dashboard.profile.reviews.sent' }
  ]

  user: {}
  map: null

  init: =>
    @User
      .get(1)
      .then (user)=>
        @scope.user = user

  userSave: =>
    if @scope.user
      @scope.user.save()
        .then (user)=>
          @scope.user = user
          @Flash.showNotice @scope, 'L'utilisateur a été enregistré avec succès.'
        , (error)->
          # @Flash.showError @scope, 'L'utilisateur a été enregistré avec succès.'

