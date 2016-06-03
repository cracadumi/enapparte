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

    $('#header')
      .removeClass('not-fixed')
      .addClass('affix-top')
      .affix
        offset:
          top: 490
    $("#content-main-page").addClass("full-main-content")

  ok: ()=>
    flash = @Flash
    scope = @scope
    if @rootScope.currentUser
      @scope.contact.email = @rootScope.currentUser.email

    @http(
      method: 'POST'
      url: '/contact'
      data: {contact:scope.contact}).then ((response) ->
      flash.showSuccess scope, 'Contact mail has been sent successfully.'
      scope.contact = {}
      return
    ), (response) ->
      return
