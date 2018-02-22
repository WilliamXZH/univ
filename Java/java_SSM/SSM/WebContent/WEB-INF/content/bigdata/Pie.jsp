<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<title></title>
<script type="text/javascript" src="js/jquery-2.2.3.min.js"></script>
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
	var jquery1_7 = jQuery.noConflict();
</script>
<script>
	var data1 = [];
	var quantity2016 = [];
	var quantity2015 = [];
	var color = [];
	var man = [];
	var woman = [];
	var temp1 = [];
	var temp2 = [];
	var temp3 = [];

	function onload() {

		for (var i = 1; i < 5; i++) {
			load(i);
		}
	}
	function load(index) {
		$ = jquery1_7;
		$("#button1").click();
		/* var pie_value = $("#button1").data("type");
		var line_value = $("#button2").data("type");
		var map_value = $("#button3").data("type");
		var point_value = $("#button4").data("type"); */
		$.ajax({
			type : "post",
			url : "dataStatistics",
			data : "picture=" + $("#button" + index).data("type"),
			async : false,
			//dataType:"json",
			success : function(result) {
				console.log(result);
				if (index == 1) {
					for (var i = 0; i < 5; i++) {
						data1.push({
							name : result[i].name,
							value : result[i].value
						});
					}
					setOption1();
					myChart1.setOption(option1);
				} else if (index == 2) {
					quantity2016[0] = result[0].jan;
					quantity2016[1] = result[0].feb;
					quantity2016[2] = result[0].mar;
					quantity2016[3] = result[0].apr;
					quantity2016[4] = result[0].may;
					quantity2016[5] = result[0].jun;
					quantity2016[6] = result[0].jul;
					quantity2016[7] = result[0].aug;
					quantity2016[8] = result[0].sept;
					quantity2016[9] = result[0].oct;
					quantity2016[10] = result[0].nov;
					quantity2016[11] = result[0].dec;
					quantity2015[0] = result[1].jan;
					quantity2015[1] = result[1].feb;
					quantity2015[2] = result[1].mar;
					quantity2015[3] = result[1].apr;
					quantity2015[4] = result[1].may;
					quantity2015[5] = result[1].jun;
					quantity2015[6] = result[1].jul;
					quantity2015[7] = result[1].aug;
					quantity2015[8] = result[1].sept;
					quantity2015[9] = result[1].oct;
					quantity2015[10] = result[1].nov;
					quantity2015[11] = result[1].dec;
					console.log(quantity2016);
					console.log(quantity2015);
					setOption2();
					myChart2.setOption(option2);

				} else if (index == 3) {
					for (var i = 0; i < result.length; i++) {
						var temp = [];
						var color;
						temp.push({name:result[i].start});
						temp.push({name:result[i].destion});
						/* ALLData.push({
							name : result[i].start,
							name : result[i].destion
						}); */
						if(result[i].value > 5){
							color = 'red';
							temp.push({color:color});
							temp1.push(temp);
						}else if(result[i].value >= 3){
							color = 'yellow';
							temp.push({color:color});
							temp2.push(temp);
						}else {
							color = 'green';
							temp.push({color:color});
							temp3.push(temp);
						}
						
						//ALLData.push(temp);
					}
					setOption3();
					myChart3.setOption(option3); 

				} else if (index == 4) {
					for (var i = 0; i < result.length; i++) {
						if (result[i].sex == '男') {
							man[i] = [result[i].age, result[i].value];
						} else {
							woman[i] = [result[i].age, result[i].value];
						}
						
					}

					setOption4();
					myChart4.setOption(option4);
				}

			},
			error : function() {
				alert("fail");
			}
		})

	}
</script>
<script type="text/javascript" src="js/echarts.js"></script>
<script type="text/javascript" src="js/dark.js"></script>
<script type="text/javascript" src="js/area.js"></script>
<script type="text/javascript" src="js/china.js"></script>
<link rel="stylesheet" href="css/easy-responsive-tabs.css" />
<link rel="stylesheet" href="css/bootstrap.css" />
<link rel="stylesheet" href="css/Pie.css" />
<link href="css/medile.css" rel='stylesheet' type='text/css' />

</head>

<body>
<html>

<head>
<title>diagram</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<link rel="stylesheet" href="css/bootstrap-select.css">
<link href="css/font-awesome.css" rel="stylesheet" type="text/css"
	media="all" />
<script type='text/javascript' src='js/jquery-2.2.3.min.js'></script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
</head>

<body onload="onload()">
	<!--header-->
	<header>
		<div class="container1">
			<!--logo-->

			<div class="clearfix"></div>
			<!-- bootstrap-pop-up -->
			<div class="modal video-modal fade" id="myModal" tabindex="-1"
				role="dialog" aria-labelledby="myModal">
				<div class="modal-dialog" role="document">
					<div class="modal-content">
						<div class="modal-header">
							登录/注册
							<button type="button" class="close" data-dismiss="modal"
								aria-label="Close">
								<span aria-hidden="true">&times;</span>
							</button>
						</div>
						<script type="text/javascript" src="js/LogReg-validation.js"></script>
						<section>
							<div class="modal-body">
								<div class="w3_login_module">
									<div class="module form-module">
										<div class="toggle">
											<i class="fa fa-times fa-pencil"></i>
											<div class="tooltip">点我切换</div>
										</div>
										<div class="form">
											<h3>登录现有账号</h3>
											<form action="#" method="post"
												onsubmit="return validateForm()">
												<input type="text" name="Username1" id="Username1"
													placeholder="用户名">
												<div id="UsernameInfo1" class="info"></div>
												<input type="password" name="Password1" id="Password1"
													placeholder="密码">
												<div id="PasswordInfo1" class="info"></div>
												<input type="submit" value="登录">
											</form>
										</div>
										<div class="form">
											<h3>创建新的账户</h3>
											<form action="#" method="post"
												onsubmit="return validateForm()">
												<input type="text" name="Username" id="Username"
													placeholder="用户名" onkeyup="return checkUserName()"
													maxlength="16">
												<div id="UsernameInfo" class="info"></div>
												<input type="text" name="name" id="name" placeholder="姓名"
													onkeyup="return checkName()" maxlength="5">
												<div id="nameInfo" class="info"></div>
												<input type="password" name="Password" id="Password"
													placeholder="密码" onkeyup="return checkPassword()"
													maxlength="16">
												<div id="PasswordInfo" class="info"></div>
												<input type="password" name="Passwordagain"
													id="Passwordagain" placeholder="密码确认"
													onkeyup="return checkRepassword()" maxlength="16">
												<div id="PasswordagainInfo" class="info"></div>
												<input type="text" name="Email" id="Email"
													placeholder="邮箱地址" onkeyup="return checkEmai()">
												<div id="EmailInfo" class="info"></div>
												<input type="text" name="Phone" id="Phone"
													placeholder="手机号码" onkeyup="return checkPhone()">
												<div id="PhoneInfo" class="info"></div>
												<select class="choice_sth">
													<option value="#" style="text-align: center;">
														<--请选择证件类型--></option>
													<option value="护照">&nbsp;护照</option>
													<option value="身份证">身份证</option>
												</select> <input type="text" name="identifer" id="identifer"
													placeholder="证件号" onkeyup="return checkIdentifer()">
												<div id="identiferInfo" class="info"></div>
												<select class="choice_sth">
													<option value="#" style="text-align: center;">
														<--请选择乘客类型--></option>
													<option value="学生">学生</option>
													<option value="成人">成人</option>
													<option value="军人">军人</option>
												</select> <select class="choice_sth">
													<option value="#" style="text-align: center;">
														<--请选择性别--></option>
													<option value="男">男</option>
													<option value="女">女</option>
												</select>
												<div id="check_sth">
													<div id="check_number">
														<input type="text" name="check" placeholder="验证码">
													</div id="check_button">
													<div>
														<input type="submit" value="发送验证码" />
													</div>

												</div>
												<input type="submit" value="注册"> <input
													type="checkbox" id="I_agree" />我已经阅读并同意遵守 <a href="#">《xxx服务条款》
													<a />
											</form>
										</div>
										<div class="cta">
											<a href="#">忘记密码了？</a>
										</div>
									</div>
								</div>
							</div>
						</section>
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
		</div>
		<div class="tm-header">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-md-4 col-sm-3 tm-site-name-container">
						<a href="NotIndex.html" class="tm-site-name"
							style="position: absolute; left: -350px;">Logo here</a>
					</div>
					<div class="col-lg-6 col-md-8 col-sm-9">
						<div class="mobile-menu-icon">
							<i class="fa fa-bars"></i>
						</div>
						<nav class="tm-nav"
							style="width: 700px; position: absolute; left: -300px;">
							<ul>
								<li><a href="NotIndex.html">主页</a></li>
								<li><a href="#">常见问题</a></li>
								<li><a href="#">铁路常识</a></li>
								<li><a href="#">站车风采</a></li>
								<li><a href="#">温馨服务</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
			<!--//logo-->

			<div class="w3layouts-login">
				<a id="logReg" data-toggle="modal" data-target="#myModal" href="#"><i
					class="glyphicon glyphicon-user"> </i>登录/注册</a>
			</div>
		</div>
		<!--/banner/-->
	</header>
	<!--//header-->

	<!--Vertical Tab-->
	<div class="categories-section main-grid-border" id="mobilew3layouts"
		style="position: relative; top: 50px; left: 20%; width: 60%;">
		<div class="container">
			<div class="category-list">
				<div id="parentVerticalTab">
					<div class="agileits-tab_nav">
						<ul class="resp-tabs-list hor_1"
							style="position: relative; top: 100px; left: -110px;">
							<li id="button1" style="font-family: '微软雅黑';"
								data-type="pie_picture"><i class="icon fa fa-pie-chart"
								aria-hidden="true"></i>各地点售票占比</li>
							<li id="button2" style="font-family: '微软雅黑';"
								data-type="line_picture"><i class="icon fa fa-line-chart"
								aria-hidden="true"></i>各时间点订票量走势</li>
							<li id="button3" style="font-family: '微软雅黑';"
								data-type="map_picture"><i class="icon fa fa-globe"
								aria-hidden="true"></i>各线路压力图</li>
							<li id="button4" style="font-family: '微软雅黑';"
								data-type="point_picture"><i class="icon fa fa-circle"
								aria-hidden="true"></i>用户订票分布图</li>

						</ul>
					</div>
					<div class="resp-tabs-container hor_1">

						<div>
							<div class="tabs-box">

								<div class="tab-grids">
									<div id="tab1" class="tab-grid">
										<div id="Pie" style="height: 700px; width: 800px;"></div>
										<div style="position: relative; top: -660px; left: -50px;">
											<input type="button" id="range11" value="7月"
												class="button_active" /> <input type="button" id="range12"
												value="6月" /> <input type="button" id="range13"
												value="2016年" />
										</div>
										<a id="refresh1"
											style="cursor: pointer; position: relative; top: -650px; left: -25px;">刷新数据</a>
										<script type="text/javascript" src="js/Pie.js"></script>
									</div>
									<div id="tab2" class="tab-grid">
										<div id="Line"
											style="height: 700px; width: 800px; position: relative; left: 70px"></div>
										<div style="position: relative; top: -660px; left: -50px;">
											<input type="button" id="range21" value="2016年"
												class="button_active" /> <input type="button" id="range22"
												value="2015年" />
										</div>
										<a id="refresh2"
											style="cursor: pointer; position: relative; top: -650px; left: -25px;">刷新数据</a>
										<script type="text/javascript" src="js/Line.js"></script>
									</div>
									<div id="tab3" class="tab-grid">
										<div id="map" style="height: 700px; width: 800px;"></div>
										<div style="position: relative; top: -660px; left: -50px;">
											<input type="button" id="range31" value="7月"
												class="button_active" /> <input type="button" id="range32"
												value="6月" />
										</div>
										<a id="refresh3"
											style="cursor: pointer; position: relative; top: -650px; left: -25px;">刷新数据</a>
										<script type="text/javascript" src="js/Map.js"></script>
									</div>
								</div>
								<div id="tab4" class="tab-grid">
									<div id="dot"
										style="height: 700px; width: 800px; position: relative; left: 100px;"></div>
									<div style="position: relative; top: -660px; left: -50px;">
										<input type="button" id="range41" value="7月"
											class="button_active" /> <input type="button" id="range42"
											value="6月" />
									</div>
									<a id="refresh4"
										style="cursor: pointer; position: relative; top: -650px; left: -25px;">刷新数据</a>
									<script type="text/javascript" src="js/Point.js"></script>
								</div>
							</div>
							<!-- script -->
							<script>
								$(document).ready(function() {
									$("#button1").click(function() {
										$("#tab1").show();
										$("#tab2").hide();
										$("#tab3").hide();
										$("#tab4").hide();
									});
									$("#button2").click(function() {
										$("#tab2").show();
										$("#tab1").hide();
										$("#tab3").hide();
										$("#tab4").hide();
									});
									$("#button3").click(function() {
										$("#tab3").show();
										$("#tab2").hide();
										$("#tab1").hide();
										$("#tab4").hide();
									});
									$("#button4").click(function() {
										$("#tab4").show();
										$("#tab2").hide();
										$("#tab3").hide();
										$("#tab1").hide();
									});
								});
							</script>


						</div>

					</div>
				</div>
			</div>
		</div>
		<!--Plug-in Initialisation-->
		<script type="text/javascript">
			$(document).ready(function() {

				//Vertical Tab
				$('#parentVerticalTab').easyResponsiveTabs({
					type : 'vertical', //Types: default, vertical, accordion
					width : 'auto', //auto or any width like 600px
					fit : true, // 100% fit in a container
					closed : 'accordion', // Start closed if in accordion view
					tabidentify : 'hor_1', // The tab groups identifier
					activate : function(event) { // Callback function if tab is switched
						var $tab = $(this);
						var $info = $('#nested-tabInfo2');
						var $name = $('span', $info);
						$name.text($tab.text());
						$info.show();
					}
				});
			});
		</script>
		<!-- //Categories -->

		<!-- for bootstrap working -->
		<script src="js/bootstrap.js"></script>
		<!-- //for bootstrap working -->
		<!-- easy-responsive-tabs -->
		<link rel="stylesheet" type="text/css"
			href="css/easy-responsive-tabs.css " />
		<script src="js/easyResponsiveTabs.js"></script>
		<!-- //easy-responsive-tabs -->
		<!--footer-->
		<footer id="footerContainer" style="position: absolute; top: 600px;">
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
						<p style="color: black;">Copyright &copy; 2017.Company name
							All rights reserved.</p>
					</div>
				</div>
			</div>
			<div id="toTopButton"></div>
		</footer>
		<!--//footer-->
</body>


</html>
<!-- //html -->