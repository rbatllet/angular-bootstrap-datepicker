var dp;

dp = angular.module('ng-bootstrap-datepicker', []);

dp.directive('ngDatepicker', function() {
  return {
    restrict: 'A',
    replace: true,
    scope: {
      ngOptions: '=',
      ngModel: '='
    },
    template: "<input type=\"text\">",
    link: function(scope, element) {
      scope.inputHasFocus = false;
      element.datepicker(scope.ngOptions).on('changeDate', function(e) {
        var defaultFormat, defaultLanguage, format, language;
        defaultFormat = $.fn.datepicker.defaults.format;
        format = scope.ngOptions.format || defaultFormat;
        defaultLanguage = $.fn.datepicker.defaults.language;
        language = scope.ngOptions.language || defaultLanguage;
        return scope.$apply(function() {
          return scope.ngModel = $.fn.datepicker.DPGlobal.formatDate(e.date, format, language);
        });
      });
      element.find('input').on('focus', function() {
        return scope.inputHasFocus = true;
      }).on('blur', function() {
        return scope.inputHasFocus = false;
      });
      return scope.$watch('ngModel', function(newValue) {
        if (!scope.inputHasFocus) {
          return element.datepicker('update', newValue);
        }
      });
    }
  };
});
