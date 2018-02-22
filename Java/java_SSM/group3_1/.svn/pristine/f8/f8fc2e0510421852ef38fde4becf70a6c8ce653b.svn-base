<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>retrievePasswordByMail</title>

		<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
		<script type="text/javascript">
			function getVerificationCode(){
				var mail = document.getElementById("mail").value;
				alert(mail);
				if(mail!=null&&mail!=""){
					//window.location.href="getVerificationCode";
					$.ajax({
						type:"POST",
						url:"getVerificationCodeByMail",
						data:"mail="+mail,
						success:function(result){
							alert(result);
						},
						error:function(result){
							alert("some error occured!");
						} 
					})
				}else{
					alert("邮箱号为空!!!");
				}
			}
		</script>
	</head>
<body>
	<a href="retrievePasswordByCel">手机找回</a>&nbsp;&nbsp;&nbsp;<a href="retrievePasswordByMail">邮箱找回</a>
	<form action="retrievePasswordByMail">
		<label>电子邮箱:</label>
		<input type="text" name="mail" id="mail"/><input type="button" value="发送验证码" onclick="getVerificationCode()"><br />
		<label>证件类型</label>
		<select name="idtfType">
			<option value="身份证">身份证</option>
			<option value="军人证">军人证</option>
		</select><br/>
		<label>证件号码</label><input type="text" name="idtfNum"><br/>
		<input type="submit">
	</form>
</body>
</html>