<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String basePath=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>账号安全-->修改绑定手机或邮箱</title>
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
	window.onload=function(){
	    var type = <%=request.getParameter("type") %>;
	    if(type=='mail'){
	    	document.getElementById("type").options[1].selected=true;
	    	document.getElementById("tel").style.display="none";
			document.getElementById("mail").style.display="inline";
	    }
	}
	function change(value){  
	    var selectedOption=value.options[value.selectedIndex];    
	    //alert(selectedOption.value);  
	    if(selectedOption.value=="0"){  
			document.getElementById("tel").style.display="inline";
			document.getElementById("mail").style.display="none";
	    }else if(selectedOption.value=="1"){  
	    	document.getElementById("tel").style.display="none";
			document.getElementById("mail").style.display="inline";
	    }
	}
	function sendVerificationCodeToTel(){
		var telNum = document.getElementById("telNum").value;
		alert(telNum+" sended");
		$.ajax({
			type:"POST",
			url:"sendVerificationCodeToTel",
			data:"telNum="+telNum,
			success:function(result){
				console.log(result);
			}
		})
		<%-- window.location.href("<%=basePath %>user/sendVerificationCodeToTel"); --%>
	}
	function submitAllMessageOfModifyTel(){
		var password = document.getElementById("password").value;
		var telNum = document.getElementById("telNum").value;
		var telVerifyCode = document.getElementById("telVerifyCode").value;
		alert("submitted");
		$.ajax({
			type:"POST",
			url:"modifyTelNum",
			data:{
				primaryPassword:password,
				telNum:telNum,
				verifyCode:telVerifyCode
			},
			dataType:'json',
			success:function(result){
				console.log(result);
			}
		})
	}
	function sendVerificationCodeToMailBox(){
		var mail = document.getElementById("mail2").value;
		alert(mail+" sended");
		$.ajax({
			type:"POST",
			url:"sendVerificationCodeToMailBox",
			data:"mail="+mail,
			success:function(result){
				console.log(result);
			}
		})
	}
	function submitAllMessageOfModifyMail(){
		var password = document.getElementById("password2").value;
		var mail = document.getElementById("mail2").value;
		var mailVerifyCode = document.getElementById("mailVerifyCode").value;
		alert("submitted");
		$.ajax({
			type:"POST",
			url:"modifyMail",
			data:{
				primaryPassword:password,
				mail:mail,
				verifyCode:mailVerifyCode
			},
			dataType:'json',
			success:function(result){
				console.log(result);
			}
		})
	}
</script>
</head>
<body>
	修改类型：
	<select id="type" onclick="change(this)"> 
		<option value="0" selected>手机</option> 
		<option value="1">邮箱</option> 
	</select>
	<br/>
	<form id="tel" style="display:inline;">
	    <label>密码：</label><input type="text" id="password">
		<label>手机号：</label><input type="text" id="telNum">
		<input type="button" value="发送手机验证码" onclick="sendVerificationCodeToTel()"><br/>
		<label>验证码：</label><input type="text" id="telVerifyCode"><br/>
		<input type="button" value="提交" onclick="submitAllMessageOfModifyTel()">
	</form>
	<form id="mail" style="display:none;">
	    <label>密码：</label><input type="text" id="password2">
		<label>邮箱号：</label><input type="text" id="mail2">
		<input type="button" value="发送邮箱验证码" onclick="sendVerificationCodeToMailBox()"><br/>
		<label>验证码：</label><input type="text" id="mailVerifyCode"><br/>
		<input type="submit" value="提交"  onclick="submitAllMessageOfModifyMail()">
	</form>
</body>
</html>