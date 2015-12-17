angular.module("AppCollections").factory('Categories', ['Category', 'BaseCollection', function() {
  var Categories = new BaseCollection({
    model: Category,
    url: 'api/categories',
  })
  Categories.fetch();

  return Categories
  
}]);
