angular.module('djello')
.controller('BoardsShowCtrl', ['$scope', '$mdDialog', '$window', 'board', function($scope, $mdDialog, $window, board) {
  $scope.board = board;

  $scope.removeBoard = function(b) {
    $scope.board.remove().then(function() {
      $scope.boards.forEach(function(element, index) {
        if ( element.id == $scope.board.id ) {
          $scope.boards.splice(index, 1);
        }
      });
    });
  };

  $scope.createList = function() {

  };
}]);
