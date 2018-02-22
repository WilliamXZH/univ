<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String basePath=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript">
	if("${modifyInfo}" == "success"){
		alert("success");
	}else if("${modifyInfo}" == "fail"){
		alert("fail");
	}
</script>
<title>修改密码</title>
</head>
<body>
	<form id="box" action="<%=basePath %>user/modifyPassword">
		旧密码：<input type="text" name="primaryPassword" />
		新密码：<input type="text" name="newPassword"/>
		确认密码：<input type="text" name="verifyNewPassword"/>
		<input type="submit" value="提交"/>
	</form>
	<a id="info" href="<%=basePath %>main/UnloggedMain">重新登录</a>
</body>
</html>