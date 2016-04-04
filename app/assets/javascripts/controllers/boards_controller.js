angular.module('djello')
    .controller('BoardsCtrl', ['$scope', '$mdDialog', 'Auth', '$window', 'boards', function($scope, $mdDialog, Auth, $window, boards) {
        $scope.boards = boards;

        var config = {
            headers: {
                'X-HTTP-Method-Override': 'DELETE'
            }
        };

        Auth.currentUser().then(function(user) {
            console.log(user);
            $scope.currentUser = user;
        });

        $scope.openMenu = function($mdOpenMenu, ev) {
            originatorEv = ev;
            $mdOpenMenu(ev);
        };

        $scope.showPrompt = function(ev) {
            var confirm = $mdDialog.prompt()
                    .title('New Board')
                    .textContent('Enter the name of your new board.')
                    .placeholder('Board name')
                    .ariaLabel('Board name')
                    .targetEvent(ev)
                    .ok('Okay!')
                    .cancel('Cancel');
            $mdDialog.show(confirm).then(function(result) {
              $scope.boards.create({name: result, user_id: $scope.currentUser.id });
            }, function() {
            });
        };

        $scope.logout = function() {
          Auth.logout(config).then(function(oldUser) {
            $window.location.href = '/users/sign_in';
          }, function(error) {
            alert('It failed to log you out');
          });
        };
    }]);
