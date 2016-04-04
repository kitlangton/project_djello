angular.module('djello')
.controller('BoardsShowCtrl', ['$scope', '$mdDialog', '$window', 'board', function($scope, $mdDialog, $window, board) {
  $scope.board = board;
  $scope.board.getList('lists').then(function(lists) {
    $scope.lists = lists;
    $scope.lists.forEach(function(list) {
      list.getList('cards').then(function(cards) {
        list.cards = cards;
      });
    });
    console.log(lists);
  });


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
    $scope.lists.post({name: $scope.newListName}).then(function(response) {
      response.cards = response.card || [];
      $scope.lists.push(response);
    });
    $scope.newListName = "";
  };

  $scope.nothing = function(event) {
    if ($scope.toggled) {
      event.stopPropagation();
      return false;
    }
  };

  $scope.createCard = function(list, text) {
    console.log(list, text);
    list.addingCard = false;
    list.newCardText = "";
    list.post('cards', {body: text}).then(function(card) {
      list.cards.push(card);
    });
  };
}]);
