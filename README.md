This is a simple AngularJS directive to make buttons spin while waiting something.

Behavior
-------------
1. Replace button content with a spinner gif (and an optional text).
2. Once the promise is resolved (or the variable set to false), the initial button content is set back.


Usage
-------------

It can be used with **$resource promise**, **$q promises** or **true/false** variable:

    # $resource promise
    $scope.comment_loading = Comments.save(newComment)

    # $q promise
    $scope.comment_deferred = $q.defer()
    $scope.comment_loading = $scope.comment_deferred.promise 

    # true/false variable
    $scope.comment_loading = true # later set to false in any callback


The `loadingButton` directive is called in the HTML with its loading variable" attribute. An optional loading text can be passed with the `loadingText` attribute.

    <button ng-click="addComment(newComment)" loading-button="comment_loading" loading-text="loading...">
        Post comment
    </button>