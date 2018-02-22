<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String basePath=request.getScheme() + "://" +
request.getServerName() + ":" + request.getServerPort() +
request.getContextPath() + "/"; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>编辑个人信息</title>
<!-- for-mobile-apps -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="One Movies Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyEricsson, Motorola web design" />

<link rel="stylesheet" href="css/ChangeInfo.css" type="text/css"
	media="all" />
<link href="css/personInfo.css" rel="stylesheet" type="text/css"
	media="all" />
<link rel="stylesheet" href="css/font-awesome.min.css" />
<!-- //引入了css框架，，引入了一些样式 -->
<link href="css/test.css" rel="stylesheet" type="text/css" media="all" />
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
</script>
<script type="text/javascript">
	function modifyInfo(){
		var s_province = document.getElementById("s_province").value;
		var s_city = document.getElementById("s_city").value;
		var s_county = document.getElementById("s_county").value;
		var detailAddress = document.getElementById("detailAddress").value;
		var address = s_province+s_city+s_county+detailAddress;
		alert(address);
		var selectType = document.getElementById("selectType").value;
		$.ajax({
			type:"POST",
			url:"modifyOtherInfo",
			data:{
				address:address,
				userType:selectType
			},
			success:function(result){
				console.log(result);
				window.location.href="<%=basePath %>userweb/showUserInfo";
			}
		})
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
	<!-- //header -->
	<!-- bootstrap-pop-up -->

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

	<!-- faq-banner -->
	<div class="faq">
		<div class="container">
			<div class="agileits-news-top">
				<ol class="breadcrumb">
					<li><a href="index.html">主页</a></li>
					<li><a href="#">个人中心</a></li>
					<li class="active">查看个人信息</li>
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
						<form action="#" method="post" class="phone_form">
							<div class="phone_number">
								<label>用 &nbsp; &nbsp;户 &nbsp; &nbsp;名：</label> <label>${user.id}</label>
							</div>
							<div class="phone_number">
								<label>姓&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; 名：</label>
								<label>${user.userName}</label>
							</div>
							<div class="iden">
								<label>证&nbsp;件&nbsp;类&nbsp;型&nbsp;&nbsp;：</label> <label>${user.idtfType }</label>
							</div>
							<div class="phone_number2">
								<label>证&nbsp;件&nbsp;号&nbsp;码&nbsp;&nbsp;：</label> <label>${user.idtfNum}</label>
							</div>
							<div class="phone_number">
								<label>邮&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;箱：</label>
								<label>${user.mail}</label>
							</div>
							<div class="phone_number">
								<label>手&nbsp;机&nbsp;号&nbsp;码&nbsp;&nbsp;：</label> <label>${user.telNum}</label>
							</div>
							<div class="phone_number">
								<label>性&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;别：</label> <label>${user.gender}</label>
							</div>

							<div class="iden">
								<label>旅&nbsp;客&nbsp;类&nbsp;型&nbsp;&nbsp;：</label> <select
									id="selectType" class="choice_sth3" style="display: none;">
									<option value="学生">学生</option>
									<option value="成人">成人</option>
								</select> <label id="myType">${user.userType}</label>
							</div>
							<div class="iden">
								<label>地&nbsp; &nbsp;&nbsp; &nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;址：</label> <label id="myaddress">${user.address}</label>

								<select class="s_province" id="s_province" name="s_province"
									style="display: none;"></select> 
								<select class="s_city"
									id="s_city" name="s_city" style="display: none;"></select>
								<select
									class="s_county" id="s_county" name="s_county"
									style="display: none;"></select>
									
								<script class="resources library" src="js/area.js"
									type="text/javascript"></script>

								<script type="text/javascript">
									_init_area();
								</script>
								<div id="show"></div>
							</div>
							<br />

							<div class="phone_number" id="detiladdress"
								style="display: none;">
								<label>详&nbsp;细&nbsp;地&nbsp;址&nbsp;&nbsp;：</label> <input
									id="detailAddress" type="text" class="phone_sty" name="detail_address"
									value="白塔堡东北大学"/>
							</div>
							<script type="text/javascript">
								var Gid = document.getElementById;
								var showArea = function() {
									Gid('show').innerHTML = "<h3>省"
											+ Gid('s_province').value + " - 市"
											+ Gid('s_city').value + " - 县/区"
											+ Gid('s_county').value + "</h3>"
								}
								//										Gid('s_county').setAttribute('onchange', 'showArea()');
							</script>

							<div class="finnal2">
								<input type="button" id="changeinfo" onclick="Mychangeinfo()"
									value="编辑" />
							</div>
							<div class="finnal2">
								<input type="submit" id="finalsubmit" onclick="modifyInfo()" value="提交"
									style="display: none;" />
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
							<li><i class="fa fa-angle-right"></i> <a href="#">加盟合作</a></li>
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
	<!-- Bootstrap Core JavaScript -->
	<script src="js/bootstrap.min.js"></script>
</body>
<script type="application/x-javascript">
	
		addEventListener("load", function() {
			setTimeout(hideURLbar, 0);
		}, false);

		function hideURLbar() {
			window.scrollTo(0, 1);
		}

		function Mychangeinfo() {
			document.getElementById('selectType').style.display = 'inline';
			document.getElementById('myType').style.display = 'none';
			document.getElementById('myaddress').style.display = 'none';
			document.getElementById('s_city').style.display = 'inline';
			document.getElementById('s_county').style.display = 'inline';
			document.getElementById('s_province').style.display = 'inline';
			document.getElementById('detiladdress').style.display = 'block';
			document.getElementById('changeinfo').style.display = 'none';
			document.getElementById('finalsubmit').style.display = 'inline';
			var pro = $(".s_province").find("option[text='辽宁省']");
			
			pro.attr("selected", true);
			//pro.setAttribute("selected",true);

		}
	
</script>

</html>