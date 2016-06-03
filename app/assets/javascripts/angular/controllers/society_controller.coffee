class SocietyController extends @NGController
  @register window.App, 'SocietyController'

  @$inject: [
    '$scope'
    'Flash'
    '$rootScope'
    '$http'
  ]

  init: ->
    @scope.society = {}
    
  save: () ->
    console.log "save"
