class RootController extends @NGController
  @register window.App, 'RootController'

  @$inject: [
    '$scope',
    '$rootScope',
    '$state',
    'ArtSelect',
    '$timeout'
  ]

  init: ->
    @scope.art = {
      endDate: null
    }
    @rootScope.rootPath = true
    @scope.artSelect = @ArtSelect

  beginSearch: =>
    artId = if @scope.artSelect.selected then @scope.artSelect.selected.id else nulls    
    @state.go 'shows.search',
      id: artId
      showDate: @scope.endDate || null
