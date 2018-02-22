<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
<script src="js/jquery-1.7.1.min.js"></script>

<script type="application/x-javascript">

function login() {
	//alert(qqq);
	var name = document.getElementById("name").value;
	//alert(qqq);
	var password = document.getElementById("password").value;
	console.log(name+":"+password);
	$.ajax({
		type : "POST",
		url : "userLogin",
		data : "name="
				+ name
				+ "&password="
				+ password,
		success : function(user) {
			console.log(user);
			if (user.id == null) {
				console.log(user);
				alert( "用户名或密码不正确,请检查后重新输入");
			} else {
				$(".close").click();
				$(".modal-backdrop").hide();
				loginId = user.id;
				userName = user.userName;
				testIfLogin();
				//window.location.reload();
			}
			//$(".modal-dialog").attr("hidden","hidden");
		},
		
	}) 
}
</script>
</head>
<body>
<input type="text" name="name" id="name" placeholder="Id" >
<input type="text" name="password" id="password" placeholder="password">
<input type="button" value="登录" onclick="login()">

</body>
</html>