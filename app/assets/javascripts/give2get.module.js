(function () {
'use strict';

angular.module('give2get', [])
.controller('ItemSearchController', ItemSearchController)
.service('ItemService', ItemService)
.constant('ApiBasePath', "http://localhost:3000");

ItemSearchController.$inject = ['ItemService'];
function ItemSearchController(ItemService) {

  var search = this;

  // promise.then(function (response) {
  //   item.items = response.data;
  // })
  // .catch(function (error) {
  //   console.log("Something went terribly wrong.");
  // });

  search.search = function () {
  var promise = ItemService.getItems(search.keywords);

  promise.then(function (response) {
    console.log(response.data);
    search.items = response.data;
  })
  .catch(function (error) {
    console.log(error);
  })
};

}

// $scope.search = function(searchTerm) {
//   $http.get("/items.json",
//     { "params": { "keywords": searchTerm } }
//     ).then(function(response) {
//   $scope.items = response.data;
//     },function(response) {
//       alert("There was a problem: " + response.status);
//     }
//   );
// }

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
