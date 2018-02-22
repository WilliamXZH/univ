function NetworkPostsController($scope, $http) {
    $http.jsonp('http://network.neu.edu.cn/api/get_recent_posts/?callback=JSON_CALLBACK').success(function(data) {
        posts = data.posts.slice(0, 7);
        $scope.posts = angular.forEach(posts, function(post) {
			post.title = post.title.substr(0, 29);
			post.date  = post.date.substr(0, post.date.indexOf(" "));
			return post;
		});
    });
}
