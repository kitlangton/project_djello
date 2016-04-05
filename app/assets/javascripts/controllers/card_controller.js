angular.module('djello')
    .controller('CardCtrl', ['$scope', '$mdDialog', 'Auth', '$window', 'card', function($scope, $mdDialog, Auth, $window, card) {
      $scope.card = card;
      $scope.cancel = function() {
        $mdDialog.cancel();
      }
    }]);
