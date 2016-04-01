angular.module('djello')
    .controller('BoardsCtrl', ['$scope', '$mdDialog', 'Auth', function($scope, $mdDialog, Auth) {
        Auth.currentUser().then(function(user) {
            console.log(user);
            $scope.currentUser = user;
        });
        $scope.openMenu = function($mdOpenMenu, ev) {
            originatorEv = ev;
            $mdOpenMenu(ev);
        };
        $scope.boards = [{name: 'hi'}, {name: 'okay'}, {name: 'fine'}];
        $scope.showPrompt = function(ev) {
            var confirm = $mdDialog.prompt()
                    .title('New Board')
                    .textContent('Enter the name of your new board.')
                    .placeholder('Projects')
                    .ariaLabel('Board name')
                    .targetEvent(ev)
                    .ok('Okay!')
                    .cancel('Cancel');
            $mdDialog.show(confirm).then(function(result) {
                $scope.status = 'You decided to name your dog ' + result + '.';
            }, function() {
                $scope.status = 'You didn\'t name your dog.';
            });
        };
    }]);
