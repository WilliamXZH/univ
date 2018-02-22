$(function() {
	$(".inform").click(function() {
		$(this).prev().focus();
	});
});

//login


//register

function validateForm() {
	if(checkName() && checkPhone() && checkIdentifer()) {
		AddTr(this);
		alert("添加成功！");
		$("#reset").click();
		$("#closeWindow").click();
		return true;
	} else {
		return false;
	}
}

//验证姓名
function checkName() {
	var name = document.getElementById("user_name").value.trim();
	var nameRegex = /^[^@#]{2,5}$/;
	if(!nameRegex.test(name)) {
		document.getElementById("usernameInform").innerHTML = "姓名为2~5个中文字符";
	} else {
		document.getElementById("usernameInform").innerHTML = "";
		return true;
	}

}

//验证电话号码
function checkPhone() {
	var phone = document.getElementById("user_phone").value.trim();
	var phoneRegex = /^1[3|4|5|8][0-9]\d{8}$/;
	if(!phoneRegex.test(phone)) {
		document.getElementById("user_phoneInform").innerHTML = "请输入正确的电话号码";
	} else {
		document.getElementById("user_phoneInform").innerHTML = "";
		return true;
	}

}

//验证证件号码
function checkIdentifer() {
	var identifer = document.getElementById("idetityNum").value.trim();
	var identiferRegex = /^[^@#]{8,17}$/;
	if(!identiferRegex.test(identifer)) {
		document.getElementById("idetityNumInfo").innerHTML = "请输入正确的证件号码";
	} else {
		document.getElementById("idetityNumInfo").innerHTML = "";
		return true;
	}

}
