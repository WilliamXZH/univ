<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% String basePath=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
		<title>编辑联系人信息</title>
		<!-- for-mobile-apps -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="keywords" content="One Movies Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />
		<script type="application/x-javascript">
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);

			function hideURLbar() {
				window.scrollTo(0, 1);
			}
		</script>
		<link href="css/test.css" rel="stylesheet" type="text/css" media="all" />
		<link rel="stylesheet" href="css/ChangeInfo.css" type="text/css" media="all" />
		<link rel="stylesheet" href="css/font-awesome.min.css" />
		<link href="css/personInfo.css" rel="stylesheet" type="text/css" media="all" />
		<!-- //引入了css框架，，引入了一些样式 -->
		<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
		<!-- news-css -->
		<link rel="stylesheet" href="news-css/news.css" type="text/css" media="all" />
		<!-- js -->
		<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
		<!-- 引入回到最初的button的js -->
		<script type="text/javascript" src="js/sand.js"></script>
		<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event) {
					event.preventDefault();
					$('html,body').animate({
						scrollTop: $(this.hash).offset().top
					}, 1000);
				});
			});
			
			window.onload = function(){
				var sv = document.getElementById("sel");
				sv.options.add(new Option("成人","成人"));
				sv.options.add(new Option("学生","学生"));
				var index=sv.selectedIndex ; // selectedIndex代表的是你所选中项的index
				var svv = sv.options[index].value;
				for(i=1;i<3;i++){
					var svi = sv.options[i].value;
					if(svi==svv)
						sv.options.remove(i); 
				}
			}
			function save(){
				document.getElementById("save").action = "partnerSave";
				document.getElementById("save").submit();
			}
		</script>
		<!-- start-smoth-scrolling -->
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
									<li>
										<a href="#" class="">主页</a>
									</li>
									<li>
										<a href="<%=basePath %>userweb/NomalQuestion" >常见问题</a>
									</li>
									<li>
										<a href="tours.html">铁路常识</a>
									</li>
									<li>
										<a href="contact.html">站车风采</a>
									</li>
									<li>
										<a href="contact.html">温馨服务</a>
									</li>
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
		<!-- //header -->
		<!-- bootstrap-pop-up -->

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

		<!-- faq-banner -->
		<div class="faq">
			<div class="container">
				<div class="agileits-news-top">
					<ol class="breadcrumb">
						<li>
							<a href="index.html">主页</a>
						</li>
						<li>
							<a href="#">个人中心</a>
						</li>
						<li class="">查看个人信息</li>
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
							<form action=""  id="save" method="post" class="phone_form">
								<input type="hidden" name="mainUserId" value="${partner.mainUserId }"/>
								<div class="phone_number">
									<label>姓&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 名：</label>
									<input type="text" name="name"  style="border:0px" value="${partner.name}" readonly/>
								</div>
								<div class="iden">
									<label>证&nbsp;件&nbsp;类&nbsp;型&nbsp;&nbsp;：</label>
									<input type="text" name="idtfType" style="border:0px" value="${partner.idtfType}"readonly/>
								</div>
								<div class="phone_number2">
									<label>证&nbsp;件&nbsp;号&nbsp;码&nbsp;&nbsp;：</label>
									<input type="text" name="idtfNum" style="border:0px" value="${partner.idtfNum}"readonly/>
								</div>
								<div class="phone_number">
									<label>手&nbsp;机&nbsp;号&nbsp;码&nbsp;&nbsp;：</label>
									<input type="text" name="telNum" style="border:0px" value="${partner.telNum}"readonly/>
								</div>
								<div class="phone_number">
									<label>性&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;&nbsp;别：</label>
									<input type="text" name="gender"  style="border:0px" value="${partner.gender}"readonly/>
								</div>
									
										<div class="iden">
											<label>旅&nbsp;客&nbsp;类&nbsp;型&nbsp;&nbsp;：</label>
											<select name="userType" id="sel">
										          <option selected value="${partner.userType}">${partner.userType}</option>
										          <!-- <option id="adult" value="成人" type="hidden">成人</option>
										          <option id="student"value="学生">学生</option> -->
									       	</select>
										</div>
									
									<div class="finnal2">
									<input type="button" onclick="save()" value="保存" />
								</div>
							</div>
								
							</form>
							<!--</dir>-->
						</div>
					</div>
				</div>
			</div>
			<!-- //faq-banner -->
				<div class="cuttingLine1">
				<div class="tm-section-header">
					<!--<hr />-->
					<h1 class="tm-section-title">ABOUT US</h1>
				</div>
				<hr style="height:1px;border:none;border-top:1px dashed #0066CC;width: 200px; margin-top: -20PX;" />
				<hr style="height:1px;border:none;border-top:1px dashed #0066CC;width: 200px; margin-top: -20PX; margin-right: -250px;"  />

			</div>

			<!-- footer -->
			<footer id="footerContainer">
				<div class="footer">
					<div class="container">
						<div class="row">
							<div class="col-md-4 col-sm-6 col-xs-12">
								<div class="quicklinks">
									<h4 class="footerh">相关链接</h4>
									<br/>
									<ul>
										<li><i class="fa fa-angle-right"></i>
											<a href="#">企业差旅索引</a>
										</li>
										<li><i class="fa fa-angle-right"></i>
											<a href="#">网络社会征信网</a>
										</li>
										<li><i class="fa fa-angle-right"></i>
											<a href="#">加盟合作</a>
										</li>
									</ul>
								</div>
							</div>
							<div class="col-md-4 col-sm-6 col-xs-12">
								<div class="quickcontact">
									<h4 class="footerh">联系我们</h4>
									<br/>
									<ul>
										<li><i class="fa fa-phone"></i> 123456789</li>
										<li><i class="fa fa-envelope"></i> abc@website.com</li>
										<li><i class="fa fa-map-marker"></i> 2B Barcelon, Newyork -32011</li>
									</ul>
								</div>
							</div>
							<div class="col-md-4 col-sm-12 col-xs-12">
								<div class="follow">
									<h4 class="footerh">微信公众号</h4>
									<br/>
									<img src="images/er_ctrip_wechat.jpg" />
								</div>
							</div>
						</div>
					</div>
				</div>

				<div>
					<div class="row" style="background: white;">
						<div class="col-md-12">
							<p style="color: black;">Copyright &copy; 2017.Company name All rights reserved.
							</p>
						</div>
					</div>
				</div>
				<div id="toTopButton"></div>
			</footer>
			<!-- Bootstrap Core JavaScript -->
			<script src="js/bootstrap.min.js"></script>

	</body>

</html>