<%@page import="java.util.List"%>
<%@page import="bsh.This"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>常用联系人</title>
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
<script type="text/javascript">
	
	function partnerDelete(index) {
		document.getElementById("form" + index).action = "partnerDelete1";
		document.getElementById("form" + index).submit();

	}
	function partnerInfoEdit(index1) {
		document.getElementById("form" + index1).action = "partnerInfoEdit1";
		document.getElementById("form" + index1).submit();

	}
	function add() {
		window.location.href = "AddFriend?mainUserId="
				+ document.getElementById("mainUserId").value;
	}
</script>
<link href="css/commonfriend.css" rel="stylesheet" type="text/css"
	media="all" />
<link rel="stylesheet" href="css/font-awesome.min.css" />
<link href="css/test.css" rel="stylesheet" type="text/css" media="all" />
<!-- //引入了css框架，，引入了一些样式 -->
<link href="css/NomalQuestion.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- news-css -->
<link rel="stylesheet" href="news-css/news.css" type="text/css"
	media="all" />
<!-- js -->
<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
<!-- 引入回到最初的button的js -->
<script type="text/javascript" src="js/sand.js"></script>
<script type="text/javascript">
	jQuery(document).ready(function($) {
		$(".scroll").click(function(event) {
			event.preventDefault();
			$('html,body').animate({
				scrollTop : $(this.hash).offset().top
			}, 1000);
		});
	});
	/* window.onload = function(){
		window.location.href="partnerSelect";
	} */
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
							<li><a href="#" class="">主页</a></li>
							<a href="<%=basePath %>userweb/NomalQuestion" >常见问题</a>
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
						<div class="wthree-news-left-heading">
							<h3>常用联系人</h3>
						</div>
						<div class="com_head">
					
						
							<!-- <img src="images/add.png" id="add" onclick="add()" width="20px" height="20px"
								class="image-fixed" /> <label>增加</label> -->
							<input name="add" class="image-fixed" type="image"
											onclick="add()" src="images/add.png"
											width="20px" height="20px" border="0" /> <label>增加</label>
							<!-- &nbsp;&nbsp;&nbsp;&nbsp; <a href="#"><img
								src="images/del.png" width="20px" height="20px"
								class="image-fixed" /></a> <label>删除</label> -->
						</div id="com_table">
						<!--<div id="">-->

						<table class="table">
							<tr>

								<th>姓名</th>
								<th>证件类型</th>
								<th>证件号码</th>
								<th>手机号码</th>
								<th>旅客类型</th>
								<th>验证状态</th>
								<th>操作</th>
							</tr>


							<c:forEach items="${partner}" var="list" varStatus="status">
								<tr>
									<form action="" id="form${status.index}" method="post">
										<%-- <input type="hidden" id="mainUserId" name="mainUserId"
											value="${list.mainUserId }" /> --%>
											<input type="hidden" id="mainUserId" name="mainUserId"
											value="2" />
											<input type="hidden" id="name" name="name"
											value="${list.name }" />
										<%-- <td><input type="text"name="name" value="${list.name}" style="border: 0px" readonly /></td>
										<td><input type="text" name="idtfType"value="${list.idtfType}" style="border: 0px" readonly /></td>
										<td><input type="text" name="idtfNum" value="${list.idtfNum}"style="border: 0px" readonly /></td>
										<td><input type="text" name="telNum" value="${list.telNum}"style="border: 0px" readonly /></td>
										<td><input type="text" name="userType" value="${list.userType}"style="border: 0px" readonly /></td>
										<td><input type="text" name="gender" value="${list.gender}" style="border: 0px"readonly /></td>
										<td><input type="button" value="编辑"onclick="partnerInfoEdit()"/> 
										<input type="button" value="删除" onclick="partnerDelete()" /></td> --%>
										<td>${list.name}</td>
										<td>${list.idtfType}</td>
										<td>${list.idtfNum}</td>
										<td>${list.telNum}</td>
										<td>${list.userType}</td>
										<td>${list.gender}</td>
										<td><input name="addSth" type="image"
											onclick="partnerInfoEdit(${status.index})" src="images/change.png"
											width="20px" height="20px" border="0" /> 
											<input name="delSth" type="image" onclick="partnerDelete(${status.index})"
											src="images/del.png" width="20px" height="20px" border="0" />
									</form>
								</tr>
							</c:forEach>

							<!-- 
									<td>张三</td>
									<td>身份证</td>
									<td>123456789098765432</td>
									<td>13912345678</td>
									<td>成人</td>
									<td>已通过</td> -->
							<!-- <th><a href="ChangeFriend.html">
								<input name="addSth" type="image" src="images/change.png" width="20px" height="20px" border="0" /></a>
								<a href="#"> <input name="delSth" type="image"src="images/del.png" width="20px" height="20px" border="0" /></a>
								</th> -->

						</table>

						<div class="btn-group1">
							<button type="button" class="btn btn-default">首页</button>
							<button type="button" class="btn btn-default">上一页</button>
							<button type="button" class="btn_mine">1</button>
							<button type="button" class="btn btn-default">下一页</button>
							<button type="button" class="btn btn-default">末页</button>
						</div>
						<!--</div>-->
					</div>
				</div>
			</div>
		</div>
		<!-- //faq-banner -->
		<!-- footer -->
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
		<script src="js/bootstrap.min.js"></script>
</body>

</html>