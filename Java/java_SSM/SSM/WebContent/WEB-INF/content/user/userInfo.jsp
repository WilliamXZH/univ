<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="css/userInfo.css" />
</head>
<body>
	<table>
		<thead>
			<tr>
				<td></td>
				<td>姓名</td>
				<td>性别</td>
				<td>年龄</td>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${list}" var="list" varStatus="status">
				<tr>
					<td>${status.index + 1}</td>
					<td>${list.name}</td>
					<td>${list.sex}</td>
					<td>${list.age}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<%-- <a href="<%=basePath%>user/show?pageNum=${pageInfo.pageNum - 1}"
		style="display:${pageInfo.pageNum == 1?'none':''}">上一页</a> --%>
	<a href="javascript:void(0)"
		style="display:${pageInfo.pageNum == 1?'none':''}"
		onclick="changePage(${pageInfo.pageNum - 1})">上一页</a>
	<c:forEach begin="0" end="1" varStatus="status">
		${(pageInfo.pageNum == pageInfo.pages?pageInfo.pageNum - 1:pageInfo.pageNum) + status.index}
	</c:forEach>
	<%-- <a href="<%=basePath%>user/show?pageNum=${pageInfo.pageNum + 1}"
		style="display:${pageInfo.pageNum == pageInfo.pages?'none':''}">下一页</a> --%>
	<a href="javascript:void(0)"
		style="display:${pageInfo.pageNum == pageInfo.pages?'none':''}"
		onclick="changePage(${pageInfo.pageNum + 1})">下一页</a>
</body>
</body>
</html>