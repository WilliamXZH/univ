<%@page import="book_user.Borrow"%>
<%@page import="java.util.Vector"%>
<%@page import="MysqlManner.MannerBorrow"%>
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
<%!
String name;
%>
<%
if(session.getAttribute("name")!=null){
	 name=(String)session.getAttribute("name");
}
%>
<div>
<nav class="navbar navbar-inverse navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="personindex.jsp">Neu Library</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li><a href="personindex.jsp">首页</a></li>
            <li class="active"><a href="person.jsp"><%=session.getAttribute("name")%></a></li>
            <li><a href="exit.jsp">注销</a></li>
          </ul>
        </div><!--/.nav-collapse -->
      </div>
 </nav>
 </div>
<div class="jumbotron">    
   <h1 align="justify">　Hello, friend!   </h1>
   <p>　　　Welcome to Neu Library. </p>
  <p align="left">　　　<a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a></p>
</div>


 <div class="bs-example" data-example-id="simple-table" style="font-size:20px;font-weight:normal;background-image: url(image/back1.jpg);opacity:0.9;">
    <ul class="nav">
    <li style="font-size:20px;font-weight: bolder;" role="presentation" class="active"><a href="appoiment.jsp" >预约中</a></li>
  	<li style="font-size:20px;font-weight: bolder;background-color: white;" role="presentation" ><a href="lend.jsp" >已借阅</a></li>
	</ul>
    <table class="table" style="height: 150px;">
      <caption>Borrow Book.</caption>
      <thead>
        <tr>
          <th>序号</th>
          <th>书籍编号</th>
          <th>书名</th>
          <th>用户名</th>
		  <th>借书日期</th>
		  <th>归还日期</th>
        </tr>
      </thead>
      <tbody>
         <%
         MannerBorrow mBorrow=new MannerBorrow();
      Vector<Borrow> vector=mBorrow.findBorrow((String)session.getAttribute("name"));
      
      for ( int fontSize = 0; fontSize < vector.size(); fontSize++){ Borrow borrow=vector.get(fontSize) ;%>

      	<tr>
          <th scope="row"><%=fontSize+1%></th>
          <td><%=borrow.getBookId() %></td>
          <td><%=borrow.getName() %></td>
          <td><%=borrow.getUser() %></td>
		  <td><%=borrow.getBorrowDate() %></td>
          <td><%=borrow.getReturnDate() %></td>
        </tr>
      
      
      <%}%>
      </tbody>
    </table>
  </div>


</body>
</html>