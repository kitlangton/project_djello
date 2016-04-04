angular.module('djello').factory('Boards', ['Restangular', function(Restangular) {
  Restangular.extendCollection('boards', function(collection) {
    collection.create = function(board) {
      collection.post(board).then(function(response) {
        collection.push(response);
      });
    };
    return collection;
  });

  return Restangular.service('boards');
}]);
