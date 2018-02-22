<%@page import="java.util.List"%>
<%@page import="bsh.This"%>
<% String basePath=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/"; %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function partnerDelete(){
		document.getElementById("form1").action="partnerDelete";
		document.getElementById("form1").submit();
			
	}
	function partnerInfoEdit(){
		document.getElementById("form1").action="partnerInfoEdit";
		document.getElementById("form1").submit();
			
	}
	function add(){
		window.location.href="partnerAdd?mainUserId="+document.getElementById("mainUserId").value;
	}
</script>
</head>
<body>
		<c:forEach items="${partner}" var="list" >
			<form action="" id="form1" method="post">
					<input type="hidden" id="mainUserId" name="mainUserId" value="${list.mainUserId }"/>
					姓名：<input type="text" name="name"  value="${list.name}" style="border:0px" readonly/><br/>
					证件类型：<input type="text" name="idtfType" value="${list.idtfType}"style="border:0px"readonly/><br/>
					证件号：<input type="text" name="idtfNum" value="${list.idtfNum}"style="border:0px"readonly/><br/>
					手机号：<input type="text" name="telNum" value="${list.telNum}"style="border:0px"readonly/><br/>
					旅客类型：<input type="text" name="userType" value="${list.userType}"style="border:0px"readonly/><br/>
					性别：<input type="text" name="gender" value="${list.gender}"style="border:0px"readonly/><br/> 
					<input type="button" value="编辑" onclick="partnerInfoEdit()"><br/>
					<input type="button" value="删除" onclick="partnerDelete()"/>
			</form>
		</c:forEach>	
		<button id="add" onclick="add()">新增</button>
</body>
</html>