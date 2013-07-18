angular.module('MUTDirectives')
  .directive 'loadingButton', ($compile) ->
    link: (scope, element, attrs) ->
      btn_content = element.html()
      loading_img = "<img src='images/icons/loading.gif'>"
      
      start_loading = ->
        loading_text = attrs.loadingText
        button_loading_content = loading_text && "#{loading_text} #{loading_img}" || loading_img
        element.html(button_loading_content)

      stop_loading = ->
        element.html(btn_content)
        $compile(element.contents())(scope)

      error_loading = ->
        element.html("retry?")
        
      scope.$watch attrs.loadingButton, ->
        variable = scope[attrs.loadingButton]
        if variable?.$then?
          start_loading()
          variable.$then ->
            stop_loading()
          , (error) ->
            error_loading()
        if variable?.then?
          start_loading()
          variable.then ->
            stop_loading()
          , (error) ->
            error_loading()
        if variable?
          if variable == true
            start_loading()
          if variable == false
            stop_loading()
