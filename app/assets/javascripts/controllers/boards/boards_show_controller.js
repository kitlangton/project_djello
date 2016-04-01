angular.module('djello')
.controller('BoardsShowCtrl', ['$scope', '$mdDialog', '$window', 'board', function($scope, $mdDialog, $window, board) {
  $scope.board = board;
}]);
