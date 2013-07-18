Loading actions with AngularJS
=============

Those are simple AngularJS directives to show your hamsters spinning wheels while users are waiting for something from your backend.

Loading content
------------
### Behavior
This is to add a spinner in a container that will be later populated (i.e. an ng-repeat of items fetched from the backend).
1. It adds a `loading` DOM element in the container.
2. If the promise is resolved, it removes the loading DOM element. Else, the `_error` template is rendered.

### Usage
It can be used with **$resource promises** or **$q promises**. If the variable does not respond to `$then` ($resource) or `then` ($q), the loading phase is assumed done.

Say, you're loading some comments from the following service:
    
    angular.module("AppServices")
        .factory "Comments", ($resource) ->
            $resource "/api/comments/:id"), {id:"@id"}

And you fetch them in a controller:

    angular.module('AppControllers')
        .controller 'CommentsCtrl', ($scope, Comments) ->
            $scope.comments = Comments.query()

Then, simply bind the `loading` directive to `$scope.comments` from a DOM element containing the `ng-repeat` directive:

    <div ng-controller="CommentsCtrl" loading="comments">
        <div ng-repeat="comment in comments">
            <!-- comment template -->
    </div>
    
In case of failure, the `_error` template is rendered. So you may add it to your page layout to make sure it is available if needed:

    <script id="_error" type="text/ng-template">
        <!-- error template -->
    </script>

Loading button
------------

### Behavior

This is to flip any DOM element to a loading state and flip it back (i.e. a 'Post comment' button).

1. It replaces the DOM element content – read 'button' or something – with a spinner gif (and an optional text).
2. If the promise is resolved (or the variable set to false), the initial button content is set back. Else, the content is temporaryly replaced by "retry?".


### Usage

It can be used with **$resource promises**, **$q promises** or **true/false** variable:

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
    

Contributing
---------
Feel free to send pull requests against a "-wip" branch. The path to "teach HTML new tricks" is still long to make it seamless.
