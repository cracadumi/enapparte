class ArtistsController extends @NGController
  @register window.App, 'ArtistsController'

  @$inject: [
    '$scope'
    '$sce'
    '$uibModal'
    '$stateParams'
    'User'
    'Art'
    'Dailymotion'
    'orderByFilter'
  ]

  init: ->

    @scope.booking = {}

    user_id = @stateParams.id
    user = new @User
    user
      .artist(user_id)
      .then (artist)=>
        @scope.user = artist
        @scope.activeSlideIdx = 0
        musics = @scope.user.showcases.filter (showcase) -> showcase.kind == 'Soundcloud'
        @scope.music = musics[0]
        @scope.videos = @scope.user.showcases
          .filter (showcase) -> showcase.kind != 'Soundcloud'

        # If many shows, sort by price ascending
        if @scope.user.shows.length > 3
          @scope.user.shows = @orderByFilter(@scope.user.shows, 'price', false)

        @generateThumbnails()
        if @scope.videos.length > 0
          @scope.previewVideo = @getEmbedUrl @scope.videos[0].url
        @scope.bannerStyle =
          'background-image' : "url(\"" + @scope.user.art.bannerUrl + "\")"

    @scope.trustAsHtml = @sce.trustAsHtml

    @scope.openGallery = (slides, idx) =>
      @scope.slides = slides
      @scope.activeSlideIdx = idx

      modal = @uibModal.open
        templateUrl: 'artists/gallery-modal-tpl.html'
        scope: @scope
        windowTopClass: 'artist-gallery-modal'

  getEmbedUrl: (video_url) =>
    embed_url = @scope.getDailyEmbedUrl(video_url) || @scope.getYoutubeEmbedUrl(video_url)
    if embed_url
      return @sce.trustAsHtml '<iframe frameborder="0" height="270" width="100%" src="'+embed_url+'"></iframe>'
    ''

  getDailyEmbedUrl: (url) =>
    if !url
      return ''
    m = url.match(/^.+(dailymotion.com|dai.ly)\/(video|hub)\/([^_]+)[^#]*(#video=([^_&]+))?/)
    if m != null
      if m[3] != undefined
        return "https://www.dailymotion.com/embed/video/"+m[3]
      return "https://www.dailymotion.com/embed/video/"+m[2]
    null

  getYoutubeEmbedUrl: (url) =>
    if !url
      return ''
    match = url.match(/^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/)
    if match && match[7].length == 11
      return "https://www.youtube.com/embed/#{match[7]}"
    null

  getYoutubeThumb: (url) =>
    return '' unless url
    match = url.match /^.*(?:(?:youtu\.be\/|v\/|vi\/|u\/\w\/|embed\/)|(?:(?:watch)?\?v(?:i)?=|\&v(?:i)?=))([^#\&\?]*).*/
    if match and match[1].length is 11
      return "http://img.youtube.com/vi/#{match[1]}/0.jpg"
    null

  getDailyThumb: (url) =>
    return '' unless url
    m = url.match(/^.+(dailymotion.com|dai.ly)\/(video|hub)\/([^_]+)[^#]*(#video=([^_&]+))?/)
    if m isnt null
      videoId = if m[3] isnt undefined then m[3] else m[2]
      return @Dailymotion.getVideoThumbUrl videoId
    null

  generateThumbnails: =>
    i = @scope.videos.length
    while i > 0
      i--
      if @scope.videos[i].kind is 'Youtube'
        @scope.videos[i].thumbnail = @getYoutubeThumb @scope.videos[i].url
      else
        do (i) =>
          @getDailyThumb @scope.videos[i].url
            .then (
              (response) => @scope.videos[i].thumbnail = response.data.thumbnail_medium_url
              (response) =>
                if response.status is 200
                  # Assign in error callback because dailymotion returns not
                  #  valid JSON which is treated as error.
                  @scope.videos[i].thumbnail = response.data.thumbnail_medium_url
                else
                  console.error response
            )

  setPreviewVideo: (url) =>
    @scope.previewVideo = @getEmbedUrl url
