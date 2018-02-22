<%@page import="java.util.Vector"%>
<%@page import="MysqlManner.MannerBookMenu"%>
<%@page import="org.eclipse.jdt.internal.compiler.ast.ThisReference"%>
<%@page import="book_user.BookMenu"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="css/bootstrap.min.css">
<script src="js/jquery.min.js">
</script>
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

.STYLE1 {
	color: #FF0000
}
-->
</style>

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
				<a class="navbar-brand" href="personindex.jsp">Neu Library</a>
			</div>
			<div id="navbar" class="collapse navbar-collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="personindex.jsp">首页</a></li>
					<li><a href="person.jsp"><%=session.getAttribute("name")%></a></li>
					<li><a href="exit.jsp">注销</a></li>
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


	<form action="personsearch.jsp" method="get" class="" role="search">
		<div class="form-group">
			<input type="text" class="form-control search clearable"
				placeholder="搜索书籍，按回车键查找" name="bookname">
		</div>
	</form>
	<%
String searchName=request.getParameter("book");
	Vector<BookMenu>bookMenu;
MannerBookMenu mBookMenu;
String userName;
session.setAttribute("book", searchName);
if(searchName==null){
	searchName=request.getParameter("bookname");
}
mBookMenu=new MannerBookMenu();
bookMenu=mBookMenu.SSearch(searchName);
 if (searchName.equals("")) { %>
	<ul style="font-size: medium;">
		<li>搜索内容不能为空！</li>
	</ul>
	<%}
else if(bookMenu!=null){ 
%>


	<ul>
		<li><%=searchName%>的搜索结果</li>
	</ul>
	<div class="bs-example" data-example-id="simple-table"
		style="background-image: url(image/back1.jpg); opacity: 0.9;">
		<table class="table table-condensed" style="opacity: 1;">
			<thead>
				<tr>
					<th width="17%">图片</th>
					<th width="83%">信息</th>
				</tr>
			</thead>
			<tbody>
				<%
				for(int i=0;i<bookMenu.size();i++){
					BookMenu bMenu=bookMenu.get(i);
					System.out.print(bMenu.getPicture());
					String nString="image/"+bMenu.getPicture()+".jpg";
					%>
				<tr>
					<td><img class="img-rounded" src=<%=nString %>></td>
					<td>
						<table class="table table-condensed">
							<tr>
								<td width="41%"><h1><%=bMenu.getName() %></h1></td>
								<td width="59%"></td>
							</tr>
							<tr>
								<td>书籍编号：<%=bMenu.getId() %></td>
								<td></td>
							</tr>
							<tr>
								<td>总数量：<%= bMenu.getTotal() %></td>
								<td>剩余：<%=bMenu.getLeft()%></td>
							</tr>
							<tr>
								<td>已借出：<%=bMenu.getLend() %></td>
								<td>种类：<%=bMenu.getType() %></td>
							</tr>
							<tr>
								<td>作者：<%=bMenu.getAuthorName() %></td>
								<% if (bMenu.getLeft()<=0) { %>
								<td><input type="button" disabled class="btn-danger"
									value="无法预约"></td>
								<% } else { %>
								<td>
									<button type="submit" class="btn-success" value="可以预约"
										onclick="window.location.href='Appoiment?Name=<%=bMenu.getName()%>'">
										<span class="" aria-hidden="true"> </span> 预约
									</button>
								</td>
								<% } %>
							</tr>
						</table>
					</td>
				</tr>

				<%}
				%>
			</tbody>
		</table>

	</div>
	<% }else { %>
	<ul style="font-size: medium;">
		<li><%= searchName %>的搜索结果</li>
	</ul>
	<div class="alert alert-success" role="alert">抱歉没有找到您要的书籍！</div>


	<% } %>
	<%
%>
</body>
</html>

