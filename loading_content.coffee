angular.module('MUTDirectives')
  .directive 'loading', ($compile) ->
    scope: true
    link: (scope, element, attrs) ->
      bound = false
      element.contents().addClass('hide')
      element.prepend("<loading><img src='images/icons/loading.gif'></loading>")

      draw_error = ->
        scope.error_variable = attrs.loading
        error_template_html = angular.element(document.getElementById('_error')).html()
        element.html(error_template_html)
        $compile(element.contents())(scope)

      draw_success = ->
        element.find('loading').remove()
        element.contents().removeClass('hide')

      bind_loading = (variable) ->
        if variable
          if variable.$then?
            variable.$then (success) ->
              draw_success()
            , (error) ->
              draw_error()
            bound = true
          if variable.then?
            variable.then (success) ->
              draw_success()
            , (error) ->
              draw_error()
            bound = true
          if !variable.then? and !variable.$then?
            draw_success()

      scope.$watch attrs.loading, (newVal, oldVal) ->
        variable = scope[attrs.loading]
        bind_loading(variable)
        