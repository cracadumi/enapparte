angular
  .module 'enapparte'
  .controller 'MainController', ['$rootScope', '$scope', '$sanitize', '$uibModal', 'Auth', '$state', "$interval", ($rootScope, $scope, $sanitize, $uibModal, Auth, $state, $interval)->

    $rootScope.Math = window.Math

    $scope.broadcast = (event)->
      $scope.$broadcast event

    $rootScope.range = (n)->
      new Array(n)

    $rootScope.isAuthenticated = ()->
      Auth.isAuthenticated()

    $rootScope.isPerformer = ()->
      Auth._currentUser.role in ["admin", "performer"]

    $rootScope.logout = ()->
      Auth.logout().then ()->
        $rootScope.currentUser = null
        $state.go 'home'

    $rootScope.$on('$stateChangeSuccess', (event, toState, toParams, fromState, fromParams) ->
      $state.current = toState

    $scope.isSearchPage = () ->
      $state.current.name == "shows.search" || $state.current.name == "artists.show"

    $scope.goPerformer = ->
      $state.go 'performer'

    randomTexts = ["un musicien", "un artiste-peintre", "un magicien", "un œnologue", "un mentaliste", "une troupe de comédiens", "un photographe", "un chef à domicile"]
    randomIndex = 0
    $scope.randomText = randomTexts[randomIndex]

    $scope.randomInterval = $interval ()->
      randomIndex += 1
      randomIndex = 0 if randomIndex >= randomTexts.length
      $scope.randomText = randomTexts[randomIndex]
    , 500

    $scope.$on "$destroy", ()->
      $interval.cancel($scope.randomInterval) if $scope.randomInterval
)
]
