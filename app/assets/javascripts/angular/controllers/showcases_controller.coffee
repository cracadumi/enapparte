class ShowcasesController extends @NGController
  @register window.App, 'ShowcasesController'

  @$inject: [
    '$scope'
    '$sce'
    'User'
    'Showcase'
  ]

  init: ->
    @scope.kind_values = [
      {'name':'Dailymotion', 'value':'Dailymotion'},
      {'name':'Youtube', 'value':'Youtube'}
    ]
    @scope.showcase = new @Showcase
    @scope.current_music = new @Showcase
    @scope.current_music.kind = "Soundcloud"
    @scope.current_video = new @Showcase
    @scope.current_video.kind = "Dailymotion"
    @Showcase
      .query()
      .then (showcases)=>
        @scope.showcases = showcases
        @scope.musics = showcases.filter (showcase) -> showcase.kind == 'Soundcloud'
        @scope.music = @scope.musics[0]
        @scope.current_music.url = @scope.music && @scope.music['url']
        @scope.videos = showcases.filter (showcase) -> showcase.kind != 'Soundcloud'
    @scope.newPicture = {}
    user = new @User
    user
      .listPictures()
      .then (pictures)=>
        @scope.pictures = pictures

  trustAsHtml: (htmlCode) =>
    @sce.trustAsHtml htmlCode

  onEditMusicUrl: (event) =>
    if @scope.music && !@scope.current_music.url
      return @scope.removeMusic()

    scope = @scope
    if scope.music
      scope.music.url = scope.current_music.url
    else
      scope.music = scope.current_music
      scope.current_music = new @Showcase
      scope.current_music.url = scope.music.url
      scope.current_music.kind = scope.music.kind
    scope.music
      .save()
      .then (music)=>

  onAddVideoUrl: () =>
    scope = @scope
    if !scope.current_video.url
      return
    kind = scope.current_video.kind
    scope.current_video
      .save()
      .then (video) =>
        scope.videos.push video
        scope.current_video = {}
        scope.current_video = new @Showcase
        scope.current_video.kind = kind

  removeMusic: ()=>
    scope = @scope
    scope.music
      .delete()
      .then (response) ->
        scope.music = null
        scope.current_music.url = ""

  removeVideo: (index)=>
    scope = @scope
    scope.videos[index]
      .delete()
      .then (response) ->
        scope.videos.splice(index, 1)
        
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
