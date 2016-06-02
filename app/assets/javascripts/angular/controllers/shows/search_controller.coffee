class UserSearchController extends @NGController
  @register window.App, 'UserSearchController'

  @$inject: [
    '$scope',
    '$rootScope',
    'Show',
    'Picture',
    'Flash',
    '$filter',
    'ShowArt',
    'UserSearch',
    '_'
    'moment'
    'Auth'
    '$state'
    '$stateParams'
    'ArtSelect'
  ]

  users: []
  arts: []
  filter:
    text: ""
    price: "0,100000"
  priceRadii: [
    '< 50 €',
    '50 € - 100 €',
    '100 € - 200 €',
    '200+ €'
  ]

  init: ->
    @scope.startDate = @stateParams.startDate || null
    @scope.endDate = @stateParams.endDate || null
    @scope.artId = @stateParams.id || null
    @scope.artSelect = @ArtSelect

    @scope.priceRadius = 
      selected: null


    @scope.$watch 'artSelect.items', =>
      if @scope.artId
        @scope.artSelect.selected = (@scope.artSelect.items.filter (i) =>
          i.id is + @scope.artId
        )[0]
    
    @scope.style = ''

    @scope.$watch 'filter.price', (newValue, oldValue) =>
      @search()

    @scope.$watch 'artSelect.selected', =>
      @scope.style = 
        if @scope.artSelect.selected && @scope.artSelect.selected.bannerUrl
          'background': "#f2f2f2 url(\"" + @scope.artSelect.selected.bannerUrl + "\") no-repeat"
          'background-size': 'auto 200px'
          'background-position': 'center top' 
        else
          ''
      @search()

    @scope.$watch 'endDate', =>
      @search()

    @scope.$watch 'startDate', =>
      @search()

    @scope.$watch 'priceRadius.selected', =>
      @search()

  artIsChosen: ->
    @scope.artSelect.selected != null            

  search: =>
    q = if  @scope.filter.text then '*' + @scope.filter.text + '*' else ''
    art_ids = @scope.arts
      .filter (art)->
        art.checked == true
      .map (art)->
        art.id

    @UserSearch
      .query
        q: q
        price0: @scope.filter.price.split(',')[0]
        price1: @scope.filter.price.split(',')[1]
        art_id: @scope.artSelect.selected.id if @scope.artSelect.selected
        start_date: @scope.startDate
        end_date: @scope.endDate
      .then (users)=>
        @scope.users = users

  modeDetails: (show)=>
    @state.go 'shows.detail',
      id: show.id
      show: show



