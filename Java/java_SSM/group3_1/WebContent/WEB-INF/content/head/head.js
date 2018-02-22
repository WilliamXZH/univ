
function testIfLogin(){
	//var loginStat = "${sessionScope.loginStat}";
	//var loginStat = '<%=session.getAttribute("loginStat")%>';
	var loginStat = "${loginStat}";
	console.log("asd:"+loginStat+":"+"${id}");
	if(loginStat==null||loginStat==0||loginStat==""){
		$("#personInfo").attr("hidden","hidden");
		$("#logReg").removeAttr("hidden");
	}else if(loginStat==1){
		$("#logReg").attr("hidden","hidden");
		$("#personInfo").removeAttr("hidden");
	}else{
	} 
}


function login() {
	//console.log(1);
	var message = document
			.getElementById("Username1").value;
	var password = document
			.getElementById("Password1").value;
	console.log(message+":"+password);
	//$(".modal-backdrop").remove();
	//$(".modal").hide();
	//$(".modal").attr("class","modal video-modal fade");
	//$(".modal").attr("style","display: none");										
	//$(".modal").attr("aria-hidden",true);
	//$("body").attr("class","");
	//$("body").attr("style","");
	$.ajax({
		type : "POST",
		url : "userLogin",
		data : "message="
				+ message
				+ "&password="
				+ password,
		success : function(user) {
			console.log(user);
			if (user.id == null) {
				console.log("user is not existed!");
			} else {
				//console.log("user logined!" + user.userName);
				$(".close").click();
				$(".modal-backdrop").hide();
				//loginStat = user.id;
				location.reload();
				//testIfLogin();
				//window.location.reload();
			}
			//$(".modal-dialog").attr("hidden","hidden");
		},
		error : function() {
			alert("error!");
		}
	}) 
}



function logout123(){
	$.ajax({
		type : "POST",
		url : "userLogout",
		success:function(){
			//loginStat=0;
			location.reload();
			//testIfLogin();
		},
		error:function(){
			alert("logout failed:");
		}
	})
}







