<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.min.css">


<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>东北大学图书馆官网</title>
<style type="text/css">
<!--
body {
	margin-left: 20%;
	margin-right: 20%;
	margin-top: 5%;
}
-->
</style></head>
<body style="background:url(image/back.jpg)fixed center center no-repeat;background-size: cover;">
 <nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="index.jsp">Neu Library</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="index.jsp">文献检索</a></li>
            <li><a href="login.jsp">登录</a></li>
            <li><a href="regist.jsp">注册</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
 </nav>
 
<div class="jumbotron">    
   <h1 align="justify">　Hello, friend!   </h1>
   <p>　　　Welcome to Neu Library. </p>
  <p align="left">　　　<a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
</div>
<form action="search.jsp" method="get" class="" role="search">
<div class="form-group">
<input type="text" class="form-control search clearable" placeholder="搜索书籍，按回车键查找" name="book">
</div> 
</form>


</body>
</html>