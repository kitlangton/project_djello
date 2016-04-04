angular.module('djello').factory('Lists', ['Restangular', function(Restangular){
  Restangular.extendCollection('lists', function(collection) {
    collection.create = function(list) {
      collection.post(list).then(function(response) {
        collection.push(response);
      });
    };
    return collection;
  });

  return Restangular.service('lists');
}]);
