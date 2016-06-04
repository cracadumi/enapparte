class ArtistsController extends @NGController
  @register window.App, 'ArtistsController'

  @$inject: [
    '$scope'
    '$state'
    'User'
  ]

  init: ->
    @scope.user =
      full_name: 'Test User'
