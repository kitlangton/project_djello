angular.module('djello', ['ngMaterial', 'Devise', 'ui.router', 'restangular'])

.config(['RestangularProvider', function(RestangularProvider){
  RestangularProvider.setBaseUrl('/api/v1');
  RestangularProvider.setRequestSuffix('.json');
}])

.config(['$urlRouterProvider', '$stateProvider',
  function($urlRouterProvider, $stateProvider){
    $urlRouterProvider.otherwise('/boards');

    $stateProvider
      .state('boards', {
        url: '/boards',
        abstract: true,
        controller: 'BoardsCtrl',
        templateUrl: '/templates/boards.html'
      })
      .state('boards.index',{
        url: "",
        templateUrl: '/templates/boards/index.html',
        controller: 'BoardsIndexCtrl'
      })
      .state('boards.show', {
        url: "boards/:id",
        templateUrl: "/templates/boards/show.html",
        controller: 'BoardsShowCtrl'
      });
  }]);
