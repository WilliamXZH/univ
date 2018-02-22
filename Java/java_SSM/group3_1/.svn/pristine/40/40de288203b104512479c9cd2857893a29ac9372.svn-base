<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String basePath=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>个人中心  --> 查看个人中心</title>
<script type="text/javascript">
	
	window.onload=function(){
		var result = '<%=request.getAttribute("result")%>';
	    console.log(result);
	}
</script>
</head>
<body>
	userInfo
	<br/>
	姓名：${user.userName}<br/>
	性别：${user.gender}<br/>
	邮箱：${user.mail}<br/>
	电话：${user.telNum}<br/>
	证件类型：${user.idtfType }<br/>
	证件号码：${user.idtfNum}<br/>
	旅客类型：${user.userType}<br/>
	邮寄地址:${user.address}<br/>
	<%session.setAttribute("user", request.getAttribute("user")); %>
	<a href="<%=basePath %>user/modifyUserInfo"><input type="button" value="编辑" ></a>
</html>