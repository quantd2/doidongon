(function () {
'use strict';

angular.module('give2get', ['ui.router', 'templates', 'naif.base64'])
.controller('ItemSearchController', ItemSearchController)
.service('ItemService', ItemService)
.constant('ApiBasePath', "http://localhost:3000");

ItemSearchController.$inject = ['ItemService'];
function ItemSearchController(ItemService) {

  var search = this;

  search.search = function () {
  var promise = ItemService.getItems(search.keywords);

  promise.then(function (response) {
    search.items = response.data;
  })
  .catch(function (error) {
    console.log(error);
  })
};

}


ItemService.$inject = ['$http', 'ApiBasePath'];
function ItemService($http, ApiBasePath) {
  var service = this;

  service.getItems = function (searchTerm) {
    var response = $http({
      method: "GET",
      url: (ApiBasePath + "/home.json"),
      params: {
        keywords: searchTerm
      }
    });

    return response;
  };

}
})();
