'use strict'

angular.module 'enapparte'
  .factory 'Dailymotion', [
    '$http'
    ($http) ->
      Dailymotion = {}

      # Possible sizes: small, medium, large
      Dailymotion.getVideoThumbUrl = (videoId, size = 'medium' ) ->
        api = "https://api.dailymotion.com/video/#{videoId}?fields=thumbnail_#{size}_url"
        $http.get api,
          headers:
            'X-CSRF-Token': undefined

      Dailymotion
  ]

