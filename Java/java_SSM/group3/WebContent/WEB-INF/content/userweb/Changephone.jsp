<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String basePath=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<title>修改绑定手机</title>
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
<link rel="stylesheet" href="css/font-awesome.min.css" />
<link href="css/test.css" rel="stylesheet" type="text/css" media="all" />
<script src="js/bootstrap.min.js"></script>
<link href="css/ChangePhone.css" rel="stylesheet" type="text/css"
	media="all" />
<script type="text/javascript" src="js/sand.js"></script>
<link href="css/commonfriend.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/NomalQuestion.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/NumberSafe.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="news-css/news.css" type="text/css"
	media="all" />
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
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
<script type="text/javascript" src="js/md5.js"></script>
<script type="text/javascript">
			$ = jquery_1_7;
			$(function() {
				$("#changeNewPass").validate({
					rules: {
						myOldPass: {
							required: true,
							rangelength: [6, 12]
						},
						myPhone: {
							required: true,
							rangelength: [11, 11]
						},
						identNumber: {
							required: true
						}
					},
					messages: {
						myOldPass: {
							rangelength: "请输入6~12位密码"
						},
						myPhone: {
							rangelength: "输入11位电话号码"
						}

					},
					errorPlacement: function(error, element) {
						if(element.attr("name") == "idenNumber") {
							error.appendTo($(".phone_number3"));
						} else {
							error.appendTo(element.parent());
						}
					}
				});
			});
		</script>
	<script type="text/javascript">
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
					success:function(result){
						if(result == "success"){
							var msg = "手机号修改成功";
							window.location.href="first?message="+msg;
						}
					},
					fail:function(result){
						
					}
				})
			}
		</script>
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
						<a href="#" class="tm-site-name"><img src="images/logo2.jpg" style="position: relative;top: -15px;"></a>
					</div>
					<div class="col-lg-6 col-md-8 col-sm-9">
						<div class="mobile-menu-icon">
							<i class="fa fa-bars"></i>
						</div>
						<nav class="tm-nav" style="width: 600px;">
						<ul>
							<li><a href="../main/NotIndex" >主页</a></li>
							<li><a href="../userweb/NormalQuestion">常见问题</a></li>
							<li><a href="../purchase/CommonSence">铁路常识</a></li>
							<li><a href="../purchase/zcfc">站车风采</a></li>
							<li><a href="../purchase/warmService">温馨服务</a></li>
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
					height: "toggle",
					'padding-top': 'toggle',
					'padding-bottom': 'toggle',
					opacity: "toggle"
				}, "slow");
			});
		</script>
	<!-- //bootstrap-pop-up -->
	<!-- nav -->

	<!-- faq-banner -->
	<div class="faq">
		<div class="container">
			<div class="agileits-news-top">
				<ol class="breadcrumb">
					<li><a href="index.html">主页</a></li>
					<li><a href="index.html">个人中心</a></li>

					<li class="#">常用联系人</li>
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
						<div class="wthree-news-left-heading1">
							<h3>修改绑定的手机</h3>
						</div>
						<div class="change_new_pssword">

							<form id="changeNewPass">
								<div class="My_password">
									<label>登录密码：</label><input id="password" class="pass_style"
										name="myOldPass" type="password" placeholder="请输入登录密码" />
								</div>
								<div class="My_email">
									<label>新手机&nbsp;&nbsp;&nbsp;：</label><input id="telNum"
										class="pass_style2" type="text" name="myPhone"
										placeholder="请输入新手机号码" />
								</div>
								<div class="My_check_number">
									<label>验证码&nbsp;&nbsp;&nbsp;：</label> <input type="text"
										name="identNumber" class="check_number" id="telVerifyCode" />
									<input type="submit" name="my_new_check"
										class="get_checkNumber" value="获得验证码"
										onclick="sendVerificationCodeToTel()" />
								</div>

								<input type="submit" class="new_pass_submit" value="提交"
									onclick="submitAllMessageOfModifyTel()" />
							</form>

						</div>

					</div>
				</div>
			</div>
		</div>
		<!-- //faq-banner -->
		<!-- footer -->
		<!-- footer -->
		<div class="cuttingLine1">
			<div class="tm-section-header">
				<!--<hr />-->
				<h1 class="tm-section-title"style="font-family:'century gothic';">ABOUT US</h1>
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
</body>

</html>