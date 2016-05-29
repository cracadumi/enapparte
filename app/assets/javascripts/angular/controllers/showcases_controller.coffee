class ShowcasesController extends @NGController
  @register window.App, 'ShowcasesController'

  @$inject: [
    '$scope'
    '$rootScope'
    'Flash'
    'Showcase'
    '$state'
  ]

  init: ->
    @scope.kind_values = [
      {'name':'Dailymotion', 'value':'Dailymotion'},
      {'name':'Youtube', 'value':'Youtube'},
      {'name':'Soundcloud', 'value':'Soundcloud'}
    ]
    @scope.showcase = new @Showcase
    @Showcase
      .query()
      .then (showcases)=>
        @scope.showcases = showcases

  showcaseSave: =>
    kind = @scope.showcase.kind
    @scope.showcase
      .save()
      .then (showcase)=>
        @scope.showcases.push showcase
        @scope.showcase = {}
        @scope.showcase = new @Showcase
        @scope.showcase.kind = kind
        @toggleAddMode()

  showcaseUpdate: (showcase)=>
    showcase
      .save()
      .then (showcase)=>
        @toggleEditMode(showcase)

  toggleAddMode: =>
    @scope.addMode = !@scope.addMode

  removeShowcase: (showcase, index)=>
    console.log index
    console.log showcase
    scope = @scope
    showcase
      .delete()
      .then( (response) ->
        scope.showcases.splice(index, 1)
      )

  toggleEditMode: (showcase)=>
    showcase.editMode = !showcase.editMode
