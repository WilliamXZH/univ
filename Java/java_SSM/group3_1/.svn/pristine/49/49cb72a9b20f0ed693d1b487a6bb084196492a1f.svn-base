<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

</head>
<body>
	<form action="partnerSave">
			<input type="hidden" name="mainUserId" value="${partner.mainUserId }"/>
		姓名：<input type="text" name="name"  style="border:0px" value="${partner.name}" readonly/><br/>
		证件类型：<input type="text" name="idtfType" style="border:0px" value="${partner.idtfType}"readonly/><br/>
		证件号：<input type="text" name="idtfNum" style="border:0px" value="${partner.idtfNum}"readonly/><br/>
		手机号：<input type="text" name="telNum" value="${partner.telNum}"/><br/>
		旅客类型：<select name="userType" id="sel">
		          <option selected value="${partner.userType}">${partner.userType}</option>
		          <option value="成人">成人</option>
		          <option value="学生">学生</option>
	       	  </select><br/>
		性别：<input type="text" name="gender"  style="border:0px" value="${partner.gender}"readonly/><br/> 
		<input type="submit" value="保存"><br/>
	</form>
</body>
</html>