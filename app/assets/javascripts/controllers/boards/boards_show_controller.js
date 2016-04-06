angular.module('djello')
.controller('BoardsShowCtrl', ['_', '$scope', '$mdDialog', '$window', 'board', function(_, $scope, $mdDialog, $window, board) {
  $scope.board = board;
  $scope.board.getList('lists').then(function(lists) {
    $scope.lists = lists;
    $scope.lists.forEach(function(list) {
      list.cards = list.getList('cards').$object;
    });
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

  $scope.moveCard = function(card, index, list) {
    var originalList = _.find($scope.lists, function(foundList) {
      return foundList.id == card.list_id;
    });
    var originalCardIdx = _.findIndex(originalList.cards, function(foundCard) {
      return foundCard.id == card.id;
    });
    var originalCard = originalList.cards[originalCardIdx];

    originalList.cards.splice(originalCardIdx,1);
    list.cards.splice(index, 0, originalCard);

    originalCard.list_id = list.id;
    originalCard.position = index;
    originalCard.save();
  };

  $scope.moveList = function(list, index) {
    var originalList = _.find($scope.lists, function(foundList) {
      return foundList.id == list.id;
    });
    $scope.lists.splice($scope.lists.indexOf(originalList), 1);
    $scope.lists.splice(index,0,originalList);
    originalList.position = index;
    originalList.save();
  };

  $scope.deleteList = function(list) {
    list.remove();
    $scope.lists.splice($scope.lists.indexOf(list),1);
  };

  $scope.displayCard = function($event, card) {
    $mdDialog.show({
      controller: 'CardCtrl',
      template: "<md-dialog><div class='card-modal'><h2 editable-text='card.body' onaftersave='updateCard()'>{{card.body}}</h2></div></md-dialog>",
      parent: angular.element(document.body),
      targetEvent: $event,
      locals: {
        card: card
      },
      clickOutsideToClose:true
    })
    .then(function(answer) {
      $scope.status = 'You said the information was "' + answer + '".';
    }, function() {
      $scope.status = 'You cancelled the dialog.';
    });
  };

  $scope.createCard = function(list, text) {
    list.addingCard = false;
    list.newCardText = "";
    list.post('cards', {body: text}).then(function(card) {
      list.cards.push(card);
    });
  };
}]);
