angular.module('GiftEditor')

.controller('EditorCtrl', ['$scope', 'Parser', function($scope, Parser) {
  $scope.state = {
    input: '',
    questions: [],
    error: null,
    errorLine: null
  };

  $scope.$watch('state.input', function(value) {
    if (value.trim() == '') {
      $scope.state.questions = [];
      $scope.state.error = null;
      $scope.state.errorLine = null;
      return;
    }

    Parser.then(function(parser) {
      var questions;
      try {
        $scope.state.questions = parser.parse(value);
        $scope.state.error = null;
        $scope.state.errorLine = null;
      } catch (e) {
        $scope.state.questions = [];

        $scope.state.error = e.name + ' (line ' + e.location.start.line +
          ', column ' + e.location.start.column + '): ' + e.message;

        $scope.state.errorLine = '';

        var i;
        var lines = $scope.state.input.split(/\r?\n/);
        for (i = Math.max(0, e.location.start.line - 5);
             i < e.location.start.line;
             ++i)
        {
          $scope.state.errorLine += lines[i] + '\n';
        }

        for (i = 1; i < e.location.start.column; ++i) {
          $scope.state.errorLine += ' ';
        }
        $scope.state.errorLine += '^';
      }
    });
  });

}])

;
