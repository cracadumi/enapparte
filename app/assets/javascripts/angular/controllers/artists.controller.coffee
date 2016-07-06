class ArtistsController extends @NGController
  @register window.App, 'ArtistsController'

  @$inject: [
    '$scope'
    '$sce'
    '$uibModal'
    '$uibModalStack'
    '$stateParams'
    '$rootScope'
    '$state'
    'User'
    'Auth'
    'Art'
    'orderByFilter'
    'ArtSelect'
    'EmbedVideo'
  ]

  init: ->

    @scope.bookings = []
    @scope.artSelect = @ArtSelect

    user_id = @stateParams.id
    user = new @User
    user
      .artist(user_id)
      .then (artist)=>
        @scope.user = artist

        @scope.bannerStyle =
          'background-image' : "url(\"" + @scope.user.art.bannerUrl + "\")"

        @scope.activeSlideIdx = 0
        musics = @scope.user.showcases.filter (showcase) -> showcase.kind == 'Soundcloud'
        @scope.music = musics[0]
        @scope.videos = @scope.user.showcases
          .filter (showcase) -> showcase.kind != 'Soundcloud'

        # If many shows, sort by price ascending
        if @scope.user.shows.length > 3
          @scope.user.shows = @orderByFilter(@scope.user.shows, 'price', false)
        @scope.bookings = new Array(@scope.user.shows.length)
        @generateThumbnails()
        if @scope.videos.length > 0
          @setPreviewVideo @scope.videos[0]

        @scope.artSelect.selected = (@scope.artSelect.items.filter (i) =>
          i.id is + @scope.user.art.id
        )[0]

    @scope.trustAsHtml = @sce.trustAsHtml

    @scope.openGallery = (slides, idx) =>
      @scope.slides = slides
      @scope.activeSlideIdx = idx

      modal = @uibModal.open
        templateUrl: 'artists/gallery-modal-tpl.html'
        scope: @scope
        windowTopClass: 'artist-gallery-modal'

    @scope.$watch 'artSelect.items', =>
      if @scope.user
        @scope.artSelect.selected = (@scope.artSelect.items.filter (i) =>
          i.id is + @scope.user.art.id
        )[0]

    @scope.$watch 'artSelect.selected', =>
      if @scope.user && @scope.artSelect.selected.id != @scope.user.art.id
        @state.go 'shows.search'

  getEmbedUrl: (video) =>
    @EmbedVideo.getVideoFrame video, "100%", 270

  generateThumbnails: =>
    i = @scope.videos.length
    while i > 0
      i--
      @EmbedVideo.setThumbnail @scope.videos[i]

  setPreviewVideo: (video) =>
    @scope.previewVideo = @getEmbedUrl video

  validateFields: (booking) =>
    if !booking.time || !booking.date || !booking.numberOfGuests || booking.time == '' || booking.date == '' || booking.numberOfGuests == ''
      booking.invalid = true
      booking.valid = false
    else
      booking.invalid = false
      booking.valid = true
    booking.valid

  bookNow: (index, show_id) =>
    if (@scope.bookings[index])
      @scope.bookings[index].submitted = true
      if @validateFields(@scope.bookings[index])
        unless @Auth.isAuthenticated()
          @uibModalStack.dismissAll('closing')
          @uibModal.open
            animation: true
            templateUrl: 'devise/log_in.html'
            controller: 'SignInController'
          .result
          .then ()=>
            @state.go 'shows.payment',
              id: show_id
              date: new Date(@scope.bookings[index].date + " " + @scope.bookings[index].time.getHours() + ':' + @scope.bookings[index].time.getMinutes()).getTime() / 1000
              spectators: @scope.bookings[index].numberOfGuests
        else
          @state.go 'shows.payment',
            id: show_id
            date: new Date(@scope.bookings[index].date + " " + @scope.bookings[index].time.getHours() + ':' + @scope.bookings[index].time.getMinutes()).getTime() / 1000
            spectators: @scope.bookings[index].numberOfGuests
    else
      @scope.bookings[index] = {}
      @scope.bookings[index].invalid = true
      @scope.bookings[index].valid = false
      @scope.bookings[index].submitted = true
