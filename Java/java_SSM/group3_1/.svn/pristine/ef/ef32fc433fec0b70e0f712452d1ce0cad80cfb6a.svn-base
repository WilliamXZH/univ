<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<% String basePath=request.getScheme() + "://" +
request.getServerName() + ":" + request.getServerPort() +
request.getContextPath() + "/"; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>找回密码</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="One Movies Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
<script type="application/x-javascript">
	addEventListener("load", function() {
		setTimeout(hideURLbar, 0);
	}, false);

	function hideURLbar() {
		window.scrollTo(0, 1);
	}
</script>
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<script src="js/bootstrap.min.js"></script>
<link rel="stylesheet" href="css/font-awesome.min.css" />
<link href="css/test.css" rel="stylesheet" type="text/css" media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="news-css/news.css" type="text/css"
	media="all" />

<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>

<script type="text/javascript">
	function getVerificationCodeByMail() {
		var mail = document.getElementById("mail").value;
		alert(mail);
		if (mail != null && mail != "") {
			//window.location.href="getVerificationCode";
			$.ajax({
				type : "POST",
				url : "getVerificationCodeByMail",
				data : "mail=" + mail,
				success : function(result) {
					alert(result);
				},
				error : function(result) {
					alert("some error occured!");
				}
			})
		} else {
			alert("邮箱号为空!!!");
		}
	}
	function getVerificationCodeByCel() {
		var telNum = document.getElementById("telNum").value;
		alert(telNum);
		if (telNum != null && telNum != "") {
			//window.location.href="getVerificationCode";
			$.ajax({
				type : "POST",
				url : "getVerificationCodeByCel",
				data : "telNum=" + telNum,
				success : function(result) {
					console.log(result.info);
					alert("" + result);
				},
				error : function(result) {
					console.log(result.info);
					alert("some error occured!");
				}
			})
		} else {
			alert("手机号为空!!!");
		}
	}
</script>
<style type="text/css">
label.error {
	color: red;
	font: "微软雅黑";
	font-size: 8px;
}
</style>
<script src="js/jquery.validate.js" type="text/javascript"
	charset="utf-8"></script>
<script src="js/messages_zh.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	var jquery_1_7 = jQuery.noConflict();
</script>
<script type="text/javascript">
	$ = jquery_1_7;
	$(function() {
		//				表一的前端校验
		$("#form_first").validate({
			rules : {
				telNum : {
					required : true,
					rangelength : [ 11, 11 ]
				},
				idtfNum : {
					required : true,
					rangelength : [ 7, 18 ]
				},
				code : {
					required : true
				},
				idenPhone : {
					required : true
				}
			},
			messages : {
				telNum : {
					rangelength : "请输入11位号码"
				},
				idtfNum : {
					rangelength : "请输正确位数证件号码"
				}

			},
			errorPlacement : function(error, element) {
				if (element.attr("name") == "Phone") {
					error.appendTo($(".phone_number"));
				} else {
					error.appendTo(element.parent());
				}
				if (element.attr("name") == "idenNumber") {
					error.appendTo($(".phone_number3"));
				} else {
					error.appendTo(element.parent());
				}
			}
		});
		//表二的前端校验
		$("#form_second").validate({
			rules : {
				mail : {
					required : true,
					email : true
				},
				idtfNum : {
					required : true,
					rangelength : [ 7, 18 ]
				},
				idenNumber2 : {
					required : true
				},
				idenEmail : {
					required : true
				}
			},
			messages : {
				mail : {
					rangelength : "请输入11位号码"
				},
				idtfNum : {
					rangelength : "请输正确位数证件号码"
				}

			},
			errorPlacement : function(error, element) {
				if (element.attr("name") == "mail") {
					//							error.appendTo($(".phone_number"));
				} else {
					error.appendTo(element.parent());
				}
				if (element.attr("name") == "idenNumber2") {
					error.appendTo($(".phone_number3"));
				} else {
					error.appendTo(element.parent());
				}
			}
		});

	});
</script>
<!-- 引入回到最初的button的js -->
<script type="text/javascript" src="js/sand.js"></script>

</head>

<body>
	<!-- header -->
	<div class="header">
		<div class="container">
			<!--logo-->

			<div class="clearfix"></div>
			<!-- //bootstrap-pop-up -->
		</div>
		<div class="tm-header">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-md-4 col-sm-3 tm-site-name-container">
						<a href="#" class="tm-site-name">logo</a>
					</div>
					<div class="col-lg-6 col-md-8 col-sm-9">
						<div class="mobile-menu-icon">
							<i class="fa fa-bars"></i>
						</div>
						<nav class="tm-nav" style="width: 600px;">
						<ul>
							<li><a href="#" class="">主页</a></li>
							<li><a href="NomalQuestion" >常见问题</a></li>
							<li><a href="tours.html">铁路常识</a></li>
							<li><a href="contact.html">站车风采</a></li>
							<li><a href="contact.html">温馨服务</a></li>
						</ul>
						</nav>
					</div>
				</div>
			</div>
			<!--//logo-->
			<div class="w3layouts-login">
				<a  href="first"><i class="glyphicon glyphicon-user"> </i>个人中心</a>
			</div>
		</div>

	</div>
	</div>
	<script>
		$('.toggle').click(function() {
			// Switches the Icon
			$(this).children('i').toggleClass('fa-pencil');
			// Switches the forms  
			$('.form').animate({
				height : "toggle",
				'padding-top' : 'toggle',
				'padding-bottom' : 'toggle',
				opacity : "toggle"
			}, "slow");
		});
	</script>
	<!-- //bootstrap-pop-up -->

	<!-- faq-banner -->
	<div class="faq">
		<div class="container">
			<div class="agileits-news-top">
				<ol class="breadcrumb">
					<li><a href="index.html">主页</a></li>
					<li><a href="#">个人中心</a></li>
					<li class="active">帐号找回</li>
				</ol>
			</div>
			<div class="agileinfo-news-top-grids">
				<div class="col-md-4 wthree-news-right">
					<!-- news-right-top -->
					<div class="news-right-top">
						<div class="wthree-news-left-heading">
							<h3>个人中心</h3>
						</div>
						<div class="wthree-news-right-top">
							<ul>
									<li class="new_title">个人信息</li>
									<li class="new_subtitle"><a class="my_a"href="<%=basePath %>userweb/showUserInfo">查看个人信息</a></li>
									<li class="new_subtitle"><a class="my_a"href="NumberSafe">账号安全</a></li>
									<li class="new_title">常用联系人管理</li>
									<li class="new_subtitle">
										<a class="my_a"href="<%=basePath %>userweb/partnerSelect">常用联系人</a>
									</li>
									<li class="new_subtitle"><a class="my_a"href="Suggest">建议与投诉</a></li>
									<li class="new_title">我的订单</li>
									<li class="new_subtitle"><a class="my_a"href="<%=basePath%>orderWeb/NotPayedOrder">未完成订单</a></li>
									<li class="new_subtitle"><a class="my_a"href="<%=basePath%>orderWeb/ungoOrder">未出行订单</a></li>
									<li class="new_subtitle"><a class="my_a"href="<%=basePath%>orderWeb/historicalOrder">已出行订单</a></li>

								</ul>
						</div>
					</div>
					<!-- //news-right-top -->
				</div>

				<div class="col-md-8 wthree-top-news-left">
					<div class="wthree-news-left">
						<div class="bs-example bs-example-tabs" role="tabpanel"
							data-example-id="togglable-tabs">
							<ul id="myTab" class="nav nav-tabs" role="tablist">
								<li role="presentation" class="active"><a href="#home1"
									id="home1-tab" role="tab" data-toggle="tab"
									aria-controls="home1" aria-expanded="true">手机找回</a></li>
								<li role="presentation"><a href="#w3bsd" role="tab"
									id="w3bsd-tab" data-toggle="tab" aria-controls="w3bsd">邮箱找回</a>
								</li>
							</ul>
							<script>
								function testConditionByCel(){

									/* window.location.href="setNewPasswordPage";
									window.navigate("setNewPasswordPage");
									selt.location="setNewPasswordPage"; */
									
									var telNum = document.getElementById("telNum").value;
									var idtfType =  document.getElementById("idtfType1").value;
									var idtfNum =  document.getElementById("idtfNum1").value;
									var code =  document.getElementById("celCode").value;
									
									alert(telNum+":"+idtfType+":"+idtfNum+":"+code);
									
									$.ajax({
										type:"post",
										url:"retrievePasswordByCel",
										dataType:"text",
										data:{
											"telNum":telNum,
											"idtfType":idtfType,
											"idtfNum":idtfNum,
											"code":code
										},
										success:function(result){
											console.log("result:"+result);
											if(result==1){
												console.log("jump to ...");
												window.location.href="setNewPasswordPage";
												//window.navigate("setNewPasswordPage");
												//selt.location="setNewPasswordPage";
												//top.location="";
												
											}else if(result==2){
												console.log("TEL is dismatch with the info.");
											}else if(result==3){
												console.log("Verification is not correct!");
											}else if(result==0){
												console.log("TEL is not exist!");
											}else{
												console.log("succeed to send but error when receive info.");
											}
										},
										error:function(result){
											console.log("error!"+result);
											alert("Some error occured!");
										}
									})
								}
								
							</script>
							<div id="myTabContent" class="tab-content">
								<!--手机找回-->
								
								
								<div role="tabpanel" class="tab-pane fade in active" id="home1"
									aria-labelledby="home1-tab">
									<form action="#" method="post"
										class="phone_form" id="form_first">
										<div class="phone_number">
											<span>*</span><label>电话号码：</label> <input id="telNum"
												type="text" class="phone_sty" name="telNum" /> <input
												type="button" onclick="getVerificationCodeByCel()"
												class="submit_check" value="获取验证码" />
										</div>
										<div class="iden">
											<span>*</span><label>证件类型：</label> <select
												class="choice_sth2" name="idtfType" id="idtfType1">
												<option value="护照">护照</option>
												<option value="身份证">身份证</option>
											</select>
										</div>
										<div class="phone_number2">
											<span>*</span><label>证件号码：</label> <input type="text"
												name="idtfNum" class="phone_sty" id="idtfNum1" />
										</div>
										<div class="phone_number3">
											<span>*</span><label>验证码：</label> <input type="text"
												name="code2" class="check_sty" /> <img src="images/2.jpg"
												width="100px" height="42px" />
										</div>
										<div class="phone_number4">
											<span>*</span><label>手机验证号码：</label> <input type="text"
												name="code" class="phone_sty" id="celCode" />
										</div>
										<div class="finnal">
											<a href="#"><input type="submit"
												value="提交" class="sub_button" onclick="testConditionByCel()" /></a>
										</div>
									</form>
								</div>

								<!--	邮箱找回-->
								
								
							<script>
								function testConditionByMail(){

									/* window.location.href="setNewPasswordPage";
									window.navigate("setNewPasswordPage");
									selt.location="setNewPasswordPage"; */
									
									var mail = document.getElementById("mail").value;
									var idtfType =  document.getElementById("idtfType2").value;
									var idtfNum =  document.getElementById("idtfNum2").value;
									var code =  document.getElementById("mailCode").value;
									
									alert(mail+":"+idtfType+":"+idtfNum+":"+code);
									
									$.ajax({
										type:"post",
										url:"retrievePasswordByMail",
										dataType:"text",
										data:{
											"mail":mail,
											"idtfType":idtfType,
											"idtfNum":idtfNum,
											"code":code
										},
										success:function(result){
											console.log("result:"+result);
											if(result==1){
												alert("jump to ...");
												window.location.href="setNewPasswordPage";
												//window.navigate("setNewPasswordPage");
												//selt.location="setNewPasswordPage";
												//top.location="";
												
											}else if(result==2){
												console.log("MAIL is dismatch with the info.");
											}else if(result==3){
												console.log("Verification is not correct!");
											}else if(result==0){
												console.log("TEL is not exist!");
											}else{
												console.log("succeed to send but error when receive info.");
											}
										},
										error:function(XMLHttpRequest, textStatus, errorThrown){
											console.log("error!");
											console.log(XMLHttpRequest);
											console.log(textStatus);
											console.log( errorThrown);
											
											alert("Some error occured!");
										}
									})
								}
								
							</script>
								<div role="tabpanel" class="tab-pane fade" id="w3bsd"
									aria-labelledby="w3bsd-tab">
									<div role="tabpanel" class="tab-pane fade in active" id="home1"
										aria-labelledby="home1-tab">
										<form action="#" method="post"
											class="phone_form" id="form_second">
											<div class="phone_number">
												<span>*</span><label>邮箱号码：</label> 
												<input type="text" id="mail" class="phone_sty" name="mail" /> 
												<input type="button" class="varifycodecheck" value="获取验证码" onclick="getVerificationCodeByMail()" />
											</div>
											<div class="iden">
												<span>*</span><label>证件类型：</label> <select
													class="choice_sth2" name="idtfType" id="idtfType2">
													<option value="护照">护照</option>
													<option value="身份证">身份证</option>
												</select>
											</div>
											<div class="phone_number2">
												<span>*</span><label>证件号码：</label> <input type="text"
													name="idtfNum" class="phone_sty" id="idtfNum2" />
											</div>
											<div class="phone_number3">
												<span>*</span><label>验证码：</label> <input type="text"
													name="idenNumber2" class="check_sty" /> <img
													src="images/2.jpg" width="100px" height="42px" />
											</div>
											<div class="phone_number4">
												<span>*</span><label>邮件验证号码：</label> <input type="text"
													name="idenEmail" class="phone_sty" id="mailCode" />
											</div>
											<div class="finnal">
												<a href="#"><input type="button"
													value="提交" onclick="testConditionByMail()" /></a>
											</div>
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="cuttingLine1">
			<div class="tm-section-header">
				<!--<hr />-->
				<h1 class="tm-section-title">ABOUT US</h1>
			</div>
			<hr
				style="height: 1px; border: none; border-top: 1px dashed #0066CC; width: 200px; margin-top: -20PX;" />
			<hr
				style="height: 1px; border: none; border-top: 1px dashed #0066CC; width: 200px; margin-top: -20PX; margin-right: -250px;" />

		</div>

		<!-- footer -->
		<footer id="footerContainer">
		<div class="footer">
			<div class="container">
				<div class="row">
					<div class="col-md-4 col-sm-6 col-xs-12">
						<div class="quicklinks">
							<h4 class="footerh">相关链接</h4>
							<br />
							<ul>
								<li><i class="fa fa-angle-right"></i> <a href="#">企业差旅索引</a>
								</li>
								<li><i class="fa fa-angle-right"></i> <a href="#">网络社会征信网</a>
								</li>
								<li><i class="fa fa-angle-right"></i> <a href="#">加盟合作</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="col-md-4 col-sm-6 col-xs-12">
						<div class="quickcontact">
							<h4 class="footerh">联系我们</h4>
							<br />
							<ul>
								<li><i class="fa fa-phone"></i> 123456789</li>
								<li><i class="fa fa-envelope"></i> abc@website.com</li>
								<li><i class="fa fa-map-marker"></i> 2B Barcelon, Newyork
									-32011</li>
							</ul>
						</div>
					</div>
					<div class="col-md-4 col-sm-12 col-xs-12">
						<div class="follow">
							<h4 class="footerh">微信公众号</h4>
							<br /> <img src="images/er_ctrip_wechat.jpg" />
						</div>
					</div>
				</div>
			</div>
		</div>

		<div>
			<div class="row" style="background: white;">
				<div class="col-md-12">
					<p style="color: black;">Copyright &copy; 2017.Company name All
						rights reserved.</p>
				</div>
			</div>
		</div>
		<div id="toTopButton"></div>
		</footer>
		<!-- //footer -->
		<!-- Bootstrap Core JavaScript -->
	</div>
</body>

</html>