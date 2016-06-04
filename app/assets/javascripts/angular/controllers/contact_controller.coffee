class ContactController extends @NGController
  @register window.App, 'ContactController'

  @$inject: [
    '$scope'
    'Flash'
    '$rootScope'
    '$http'
  ]

  init: ->
    @scope.art = {}
    @rootScope.rootPath = true
    @scope.artSelect = @ArtSelect
    @scope.endDate = null
    @scope.contact = {}

    $('#header')
      .removeClass('not-fixed')
      .addClass('affix-top')
      .affix
        offset:
          top: 490
    $("#content-main-page").addClass("full-main-content")

  submitContact: ()=>
    flash = @Flash
    scope = @scope

    @http(
      method: 'POST'
      url: '/contact'
      data: {contact:scope.contact}).then ((response) ->
      flash.showSuccess scope, 'Contact mail has been sent successfully.'
      scope.contact = {}
      return
    ), (response) ->
      return
