<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%String id=request.getParameter("mainUserId"); %>
	请输入联系人信息
	<form action="partnerAdd" method="post">
		<input type="hidden" name="mainUserId" value="${id}"/>
		姓名<input type="text" name="name"/><br/>
		证件类型<input type="text" name="idtfType"/><br/>
		证件号<input type="text" name="idtfNum"/><br/>
		手机号<input type="text" name="telNum"/><br/>
		旅客类型<input type="text" name="userType"/><br/>
		性别<input type="text" name="gender"/><br/>
		<input type="submit" value="確定"/>
	</form>
</body>
</html>