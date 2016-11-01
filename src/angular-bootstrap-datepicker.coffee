dp = angular.module('ng-bootstrap-datepicker', [])

dp.directive 'ngDatepicker', ->
    restrict: 'A'
    replace: true
    scope:
        dateOptions: '='
        model: '='
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
                scope.model = if e != undefined then e.target.value else ''
        )

        element.find('input').on('focus', ->
            scope.inputHasFocus = true
        ).on('blur', ->
            scope.inputHasFocus = false
        )

        element.bind('blur', (e)->
          currentValue = element.val()
          if moment(currentValue).isValid() or currentValue == ''
            scope.$apply ->
              scope.model = if e != undefined then currentValue else ''
          else
            element.val('')
            scope.$apply ->
              scope.model = ''
        )

        scope.$watch 'model', (newValue)->
            if not scope.inputHasFocus
                element.datepicker('update', newValue)
