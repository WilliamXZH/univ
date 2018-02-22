<%@page import="MysqlManner.MannerUser"%>
<%@ page language="java" import="java.util.*" pageEncoding="gbk"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
  <head>
 <link rel="stylesheet" href="css/bootstrap.min.css">
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<meta http-equiv="Content-Type" content="textml; charset=utf-8">
<title>Insert title here</title>
<style type="text/css">
<!--
body {
	margin-left: 20%;
	margin-right: 20%;
	margin-top: 5%;
}
-->
</style>
 
    <base href="<%=basePath%>">
    
    <title>My JSP 'index.jsp' starting page</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script type="text/javascript">
		function reloadCode(){
			var time = new Date().getTime();
			document.getElementById("imagecode").src="<%=request.getContextPath() %>/servlet/ImageServlet?d="+time;
		}
	</script>
  </head>
<body
	style="background: url(image/back.jpg) fixed center center no-repeat; background-size: cover;">
	<nav class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#navbar" aria-expanded="false"
					aria-controls="navbar">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp">Neu Library</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li><a href="index.jsp">首页</a></li>
					<li class="active"><a href="login.jsp">登录</a></li>
					<li><a href="regist.jsp">注册</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</nav>
	<div class="jumbotron">
		<h1 align="justify">Hello, friend!</h1>
		<p>Welcome to Neu Library.</p>
		<p align="left">
			<a class="btn btn-primary btn-lg" href="#" role="button">Learn
				more</a>
		</p>
	</div>


<form action="<%=request.getContextPath() %>/login.jsp" method="post">
		<div class="form-group">
			<label for="exampleInputEmail1" style="color: white;">UserName</label>
			<div align="left">
				<input type="text" class="form-control" placeholder="用户名"
					name="name">
			</div>
		</div>
		<div class="form-group">
			<label for="exampleInputPassword1" style="color: white;">Password</label>
			<input type="password" class="form-control" placeholder="密码"
				name="password">
		</div>

		<div class="form-group">
   验证码：<input type="text" class="form-control" name="checkcode"/>
   <img alt="验证码" id="imagecode" src="<%=request.getContextPath() %>/servlet/ImageServlet"/>
   <a href="javascript: reloadCode();">看不清楚</a><br>
   <input type="submit" value="提交">
 		</div>  
 	
<%

  String name=request.getParameter("name");
  String password=request.getParameter("password");
  String piccode = (String) request.getSession().getAttribute("piccode");
  String checkcode = request.getParameter("checkcode");
		
  MannerUser mUser=new MannerUser();
  int i=0;
  if(name!=null&&password!=null){
  	 i=mUser.login(name, password);
  }
  switch(i){
  case 1:
  	  if(checkcode.equals(piccode)){
		  response.setHeader("refresh","0;url=person.jsp");
		  session.setAttribute("name", name);
	   }
	   else{
		  out.println("验证码错误！");

	   }
	  break;
  case 2:
	  out.println("密码错误");

	  break;
  case 3:
	  out.println("用户不存在");
	  break;
  
  }
  
  %>
    
 </form>
    
</body>
</html>