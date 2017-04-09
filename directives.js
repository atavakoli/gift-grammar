angular.module('GiftEditor')

.directive('tfQuestion', function() {
  return {
    templateUrl: 'partials/directives/tf_question.html',
    restrict: 'E',
    require: 'ngModel',
    scope: {
      ngModel: '<'
    }
  };
})

.directive('mcQuestion', function() {
  return {
    templateUrl: 'partials/directives/mc_question.html',
    restrict: 'E',
    require: 'ngModel',
    scope: {
      ngModel: '<'
    }
  };
})

.directive('nQuestion', function() {
  return {
    templateUrl: 'partials/directives/n_question.html',
    restrict: 'E',
    require: 'ngModel',
    scope: {
      ngModel: '<'
    }
  };
})

.directive('nmcQuestion', function() {
  return {
    templateUrl: 'partials/directives/nmc_question.html',
    restrict: 'E',
    require: 'ngModel',
    scope: {
      ngModel: '<'
    }
  };
})

.directive('mQuestion', function() {
  return {
    templateUrl: 'partials/directives/m_question.html',
    restrict: 'E',
    require: 'ngModel',
    scope: {
      ngModel: '<'
    }
  };
})

.directive('iQuestion', function() {
  return {
    templateUrl: 'partials/directives/i_question.html',
    restrict: 'E',
    require: 'ngModel',
    scope: {
      ngModel: '<'
    }
  };
})

.directive('eQuestion', function() {
  return {
    templateUrl: 'partials/directives/e_question.html',
    restrict: 'E',
    require: 'ngModel',
    scope: {
      ngModel: '<'
    }
  };
})

;
