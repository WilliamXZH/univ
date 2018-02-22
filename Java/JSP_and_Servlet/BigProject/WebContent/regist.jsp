<%@page import="MysqlManner.MannerUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
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
            <li><a href="index.jsp">首页</a></li>
            <li ><a href="login.jsp">登录</a></li>
            <li class="active"><a href="regist.jsp">注册</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
</nav>
<div class="jumbotron">    
   <h1 align="justify">　Hello, friend!   </h1>
   <p>　　　Welcome to Neu Library. </p>
  <p align="left">　　　<a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
</div>


<form action="regist.jsp"  method="post">
  <div class="form-group">
    <label for="exampleInputEmail1" style="color:white;">UserName</label>
    <div align="left">
      <input type="text" class="form-control" placeholder="用户名" name="name">
    </div>
  </div>
  <div class="form-group">
    <label for="exampleInputPassword1" style="color:white;">Password</label>
    <input type="password" class="form-control" placeholder="密码" name="password">
  </div>

  <button type="submit" class="btn btn-default">Regist</button>
  <%
  response.setContentType("text/html;charset=utf-8");
	request.setCharacterEncoding("utf-8");
  String name=request.getParameter("name");
  String password=request.getParameter("password");

  MannerUser mUser=new MannerUser();
  int i=0;
  if(name!=null&&password!=null){
  	 i=mUser.Regist(name, password);
  }
  switch(i){
  case 1:
	  out.println("注册成功,即将进入个人主页");
	  response.setHeader("refresh","3;url=person.jsp");
	  session.setAttribute("name", name);
	  break;
  case 2:
	  out.println("注册失败:该用户名已注册");

	  break;

  
  }
  
  %>
</form>

</body>
</html>