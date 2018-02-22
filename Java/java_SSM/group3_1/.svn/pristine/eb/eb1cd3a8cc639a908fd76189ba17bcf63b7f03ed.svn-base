<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	body{ background:#EEEEEE;margin:0; padding:0; font-family:"微软雅黑", Arial, Helvetica, sans-serif; }
	a{ color:#006600; text-decoration:none;}
	a:hover{color:#990000;}
	.info select{ border:1px initial solid; background:#FFFFFF;float:left;height:21px;}
	.info #show{ color:#3399FF; }
	.bottom{ text-align:right; font-size:12px; color:#CCCCCC; width:1000px;}
</style>
	<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript">
		function register(){
			$.ajax({
				type:"POST",
				url:"userRegister",
				data:{
					id:$("#id").val(),
					password:$("#password").val(),
					userName:$("#userName").val(),
					mail:$("#mail").val(),
					telNum:$("#telNum").val(),
					idtfType:$("#idtfType").val(),
					idtfNum:$("#idtfNum").val(),
					userType:$("#userType").val(),
					address : "",
					gender:$("#gender").val()
				},
				success:function(result){
					console.log(result);
				}
			})
		}
	</script>
</head>
<body>
		用户名<input type="text" id="id"/><br/>
		姓名<input type="text" id="userName"/><br/>
		密码<input type="text" id="password"/><br/>	
		邮箱<input type="text" id="mail"/><br/>
		手机号<input type="text" id="telNum"/><br/>
		证件类型<select id="idtfType">
		          <option value="二代身份证">二代身份证</option>
		          <option selected value="军人">军人证</option>
	       	  </select><br/>
		证件号<input type="text" id="idtfNum"/><br/>
		旅客类型<select id="userType">
				<option value="学生">学生</option>
				<option value="成人">成人</option>
			</select>
		<br/>
		性别<select id="gender">
				<option value="男">男</option>
				<option value="女">女</option>
			</select>
			<br/>
		<input type="submit" value="提交" onclick="register()">	
</body>
</html>