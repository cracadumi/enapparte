class ArtSearchController extends @NGController
  @register window.App, 'ArtSearchController'

  @$inject: [
    '$scope',
    'ArtSelect',
    '$state'
  ]

  init: ->
    @scope.artSelect = @ArtSelect
    @scope.state = @state

  isSearchPage: ->
    @scope.state.current.name == "shows.search" || @scope.state.current.name == "shows.search"

