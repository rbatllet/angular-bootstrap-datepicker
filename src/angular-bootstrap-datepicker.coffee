dp = angular.module('ng-bootstrap-datepicker', [])

dp.directive 'ngDatepicker', ->
  restrict: 'A'
  replace: true
  scope:
    dateOptions: '='
    ngModel: '='
  template: """
              <input type="text">
            """
  link: (scope, element)->
    scope.inputHasFocus = false

    element.datepicker(scope.dateOptions).on('changeDate', (e)->

      defaultFormat = $.fn.datepicker.defaults.format
      format = scope.dateOptions.format || defaultFormat
      defaultLanguage = $.fn.datepicker.defaults.language
      language = scope.dateOptions.language || defaultLanguage
			
      scope.$apply ->
				e.date.setDate e.date.getDate() + 1
				scope.ngModel = $.fn.datepicker.DPGlobal.formatDate(e.date, format, language)
    )

    element.find('input').on('focus', ->
      scope.inputHasFocus = true
    ).on('blur', ->
      scope.inputHasFocus = false
    )

    scope.$watch 'ngModel', (newValue)->
      if not scope.inputHasFocus
        element.datepicker('update', newValue)
