angular.module('djello').factory('Boards', ['Restangular', function(Restangular) {
  Restangular.extendCollection('boards', function(collection) {
    collection.create = function(board) {
      var promise = collection.post(board).then(function(response) {
        collection.push(response);
        return response;
      });
      return promise;
    };
    return collection;
  });

  return Restangular.service('boards');
}]);
