class ShowcasesController extends @NGController
  @register window.App, 'ShowcasesController'

  @$inject: [
    '$scope'
    'User'
    'Showcase'
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

    @scope.newPicture = {}
    user = new @User
    user
      .listPictures()
      .then (pictures)=>
        @scope.pictures = pictures

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
    scope = @scope
    showcase
      .delete()
      .then( (response) ->
        scope.showcases.splice(index, 1)
      )

  toggleEditMode: (showcase)=>
    showcase.editMode = !showcase.editMode

  savePicture: ()=>
    scope = @scope
    scope.loading = true
    user = new @User
    user
      .pictures(scope.newPicture.src)
      .then (result) ->
        scope.pictures.push result
        scope.loading = false
        scope.newPicture = {}

  removePicture: (picture, index)=>
    scope = @scope
    user = new @User
    user
      .destroyPicture(picture.id)
      .then( (response) ->
        scope.pictures.splice(index, 1)
      )
