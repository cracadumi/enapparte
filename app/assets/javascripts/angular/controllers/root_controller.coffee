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
    @scope.endDate = null
    @rootScope.rootPath = true
    @scope.artSelect = @ArtSelect
  beginSearch: =>
    artId  = if @scope.artSelect.selected then @scope.artSelect.selected.id else null
    showDt = if @scope.endDate then new Date(moment(@scope.endDate, "DD/MM/YYYY").format('MM/DD/YYYY')) else null
    @state.go 'shows.search',
      id: artId
      showDate: new Date(showDt).getTime() / 1000 if showDt
