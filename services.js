angular.module('GiftEditor')

.factory('Parser', ['$q', '$http', function($q, $http) {
  var parserPromise = $http.get('vendor/gift-grammar/gift.pegjs')
    .then(function(response) {
      return peg.generate(response.data);
    });

  return parserPromise;
}])

;
