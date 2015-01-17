---
layout: post
title: Hello World! In AngularJS
date: 2014-12-17 08:09:54 -0800
categories: code
---

My coworker recently complained to me how hard it was to find a simple "Hello World" program in
AngularJS. I did a google search and found that indeed, all the simplest examples still asked the
user to set up a bunch of boilerplate, file structure, etc.

Here is the simplest Hello World in AngularJS I could come up with, and it still
shows 2 way binding:

<!--more-->

{% highlight html %}
<!doctype html>
<html ng-app="helloangular">
    <head>
        <title>Hello Angular!</title>
    </head>
    <body ng-controller="HelloCtrl">
        {% raw %}<p>Hello, {{world}}!</p>{% endraw %}
        <input type="text" ng-model="world"/>
    </body>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.3.7/angular.min.js">
    </script>
    <script>
        var app = angular.module("helloangular", []);
        app.controller('HelloCtrl', [ '$scope', function($scope) {
            $scope.world = "world";
        }]);
    </script>
</html>
{% endhighlight %}

<iframe src="http://toxiccode.com/misc/angularhelloworld.html" width="100%"></iframe>
