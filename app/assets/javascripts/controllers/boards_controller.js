angular.module('djello')
    .controller('BoardsCtrl', ['$scope', 'Auth', function($scope, Auth) {
        Auth.currentUser().then(function(user) {
            console.log(user);
            $scope.currentUser = user;
        });
    }]);
