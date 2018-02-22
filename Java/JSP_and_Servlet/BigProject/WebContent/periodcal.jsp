<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script>
var tm;var oid,obj;
var clklink=0,query;
query="";
function g(id){return document.getElementById(id);}
function w(ct){return document.write(ct);}
if(self.location!=parent.location){
    w("<style>#logo,#copy{display:none}#main{width:100%}#navbar{background:url(/ej/pic/1_b.gif) repeat-x;}#navbar td a{color:black;font-size:13px}#navbar td{padding:3px 4px 0 4px}#hidden{display:none}</style>");
    if(typeof parent.guest!='undefined')w("<style>.fav{display:inline}</style>");
}
</script>
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
            <li class="active"><a href="">电子期刊</a></li>
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

<table style="margin: 0px 20px;width:72%"><tr><td width=78px align=left><b><span class="etitle">外文刊：</span></b><td align=left>
<script>
w("<a href=/neuaz/ej.cgi?lang=2&typ=2&s=0-9"+query+">0-9</a>");
var alb_lt=Array("A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
for(var i=0;i<alb_lt.length;i++)w("<td align=left width=3.6%><a href=/neuaz/ej.cgi?lang=2&typ=2&s="+alb_lt[i]+query+">"+alb_lt[i]+"</a>");
</script>
<td align=left><a href=/neuaz/ej.cgi?lang=2>全部</a>
</table>


</body>
</html>