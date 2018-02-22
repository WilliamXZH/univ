$(function() {
	$(".info").click(function() {
		$(this).prev().focus();
	});
});

//login
function validateForm1() {
	if(checkUserName1() && checkPassword1()) {
		login()
	} else {
		return false;
	}
}

//验证用户名（为3~16个字符，且不能包含”@”和”#”字符）
function checkUserName1() {
	var username = document.getElementById("Username1").value.trim();
	var usernameRegex = /^[^#_]{5,20}$/;
	if(!usernameRegex.test(username)) {
		document.getElementById("UsernameInfo1").innerHTML = "用户名为5~20个字符，且不能包含”_”和”#”字符";
	} else {
		document.getElementById("UsernameInfo1").innerHTML = "";
		return true;
	}

}

function checkPassword1() {
	var password = document.getElementById("Password1").value.trim();
	//var password=$("#Password").value;
	//$("#PasswordInfo").innerHTML = "";
	//密码长度在8个字符到16个字符，由字母、数字和".""-""_""@""#""$"组成
	var passwordRegex = /^[0-9A-Za-z.\-\_\@\#\$]{8,16}$/;
	//console.log(password);
	//console.log(!passwordRegex.test(password));
	if(!passwordRegex.test(password)) {
		document.getElementById("PasswordInfo1").innerHTML = "密码长度必须在8个字符到16个字符之间";
	} else {
		document.getElementById("PasswordInfo1").innerHTML = "";
		return true;
	}
}
//register

function validateForm() {
	if(checkUserName() && checkPassword() && checkRepassword()) {
		alert("恭喜您！注册成功！");
		return true;
	} else {
		return false;
	}
}
//验证用户名（为3~16个字符，且不能包含”@”和”#”字符）
function checkUserName() {
	var username = document.getElementById("Username").value.trim();
	var usernameRegex = /^[^#_]{5,20}$/;
	if(!usernameRegex.test(username)) {
		document.getElementById("UsernameInfo").innerHTML = "用户名为5~20个字符，且不能包含”_”和”#”字符";
	} else {
		document.getElementById("UsernameInfo").innerHTML = "";
		return true;
	}

}
//验证姓名
function checkName() {
	var name = document.getElementById("name").value.trim();
	var nameRegex = /^[\u4E00-\u9FA5]+$/;
	if(!nameRegex.test(name)) {
		document.getElementById("nameInfo").innerHTML = "姓名只能为中文字符";
	} else {
		document.getElementById("nameInfo").innerHTML = "";
		return true;
	}

}
//验证密码（长度在8个字符到16个字符）
function checkPassword() {
	var password = document.getElementById("Password").value.trim();
	//var password=$("#Password").value;
	//$("#PasswordInfo").innerHTML = "";
	//密码长度在8个字符到16个字符，由字母、数字和".""-""_""@""#""$"组成
	var passwordRegex = /^[0-9A-Za-z.\-\_\@\#\$]{8,16}$/;
	//console.log(password);
	//console.log(!passwordRegex.test(password));
	if(!passwordRegex.test(password)) {
		document.getElementById("PasswordInfo").innerHTML = "密码长度必须在8个字符到16个字符之间";
	} else {
		document.getElementById("PasswordInfo").innerHTML = "";
		return true;
	}
}

//验证校验密码（和上面密码必须一致）
function checkRepassword() {
	var password = document.getElementById("Password").value.trim();
	var repassword = document.getElementById("Passwordagain").value.trim();
	//校验密码和上面密码必须一致
	if(repassword !== password) {
		document.getElementById("PasswordagainInfo").innerHTML = "两次输入的密码不一致";
	} else if(repassword == password) {
		document.getElementById("PasswordagainInfo").innerHTML = "";
		return true;
	}
}

//验证邮箱
function checkEmai() {
	var email = document.getElementById("Email").value.trim();
	var emailRegex = /^[\w\-\.]+@[\w\-\.]+(\.\w+)+$/;
	if(!emailRegex.test(email)) {
		document.getElementById("EmailInfo").innerHTML = "请输入正确的邮箱地址";
	} else {
		document.getElementById("EmailInfo").innerHTML = "";
		return true;
	}

}

//验证电话号码
function checkPhone() {
	var phone = document.getElementById("Phone").value.trim();
	var phoneRegex = /^1[3|4|5|8][0-9]\d{8}$/;
	if(!phoneRegex.test(phone)) {
		document.getElementById("PhoneInfo").innerHTML = "请输入正确的电话号码";
	} else {
		document.getElementById("PhoneInfo").innerHTML = "";
		return true;
	}

}

//验证证件号码
function checkIdentifer() {
	var identifer = document.getElementById("identifer").value.trim();
	var identiferRegex = /^[^@#]{8,17}$/;
	if(!identiferRegex.test(identifer)) {
		document.getElementById("identiferInfo").innerHTML = "请输入正确的证件号码";
	} else {
		document.getElementById("identiferInfo").innerHTML = "";
		return true;
	}

}