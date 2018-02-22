<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String basePath=request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + request.getContextPath() + "/"; 
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<!-- head -->

	<head>
		<title>主页</title>
		<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
		<!-- bootstrap-CSS -->
		<link rel="stylesheet" href="css/bootstrap-select.css">
		<!-- bootstrap-select-CSS -->
		<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
		<script type='text/javascript' src='js/jquery-2.2.3.min.js'></script>
		<script type="text/javascript" src="js/bootstrap.js"></script>
		<script type="text/javascript" src="js/bootstrap-select.js"></script>
		<script type="text/javascript" src="js/jquery-ui.js"></script>
		<script type="text/javascript" src="js/easing.js"></script>
		<script type="text/javascript" src="js/easyResponsiveTabs.js"></script>

		<script type="text/javascript" src="js/responsiveslides.min.js"></script>
		<script type="text/javascript" src="js/echarts.min.js"></script>
		<script type="text/javascript" src="js/china.js"></script>
		<script src="js/jquery-1.7.1.min.js"></script>
		<script type="text/javascript">
			var jquery1_7 = jQuery.noConflict();
		</script>
			<script type="text/javascript">
		function register(){
			$.ajax({
				type:"POST",
				url:"userRegister",
				data:{
					id:$("#id").val(),
					password:$("#password").val(),
					userName:$("#userName").val(),
					mail:$("#mail").val(),
					telNum:$("#telNum").val(),
					idtfType:$("#idtfType").val(),
					idtfNum:$("#idtfNum").val(),
					userType:$("#userType").val(),
					address : "",
					gender:$("#gender").val()
				},
				success:function(result){
					console.log(result);
				}
			})
		}
	</script>
		<script type="text/javascript" src="js/custom.js"></script>
		<script src="js/jquery.flexslider-min.js"></script>
		<script src="js/jquery.cycle.all.js"></script>
		<script src="js/jquery-ui.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<!--meta data-->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="keywords" content="" />
		<script type="application/x-javascript">
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);

			function hideURLbar() {
				window.scrollTo(0, 1);
			}
		</script>
		<!--//meta data-->
		<!-- online fonts -->
		<link href="http://fonts.googleapis.com/css?family=Montserrat:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&amp;subset=latin-ext,vietnamese" rel="stylesheet">
		<link href="http://fonts.googleapis.com/css?family=Oxygen:300,400,700&amp;subset=latin-ext" rel="stylesheet">
		<link href="http://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i&amp;subset=cyrillic,cyrillic-ext,greek,greek-ext,latin-ext,vietnamese" rel="stylesheet">
		<!-- /online fonts -->
		<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
		<link rel="stylesheet" href="css/faqstyle.css" type="text/css" media="all" />
		<link href="css/medile.css" rel='stylesheet' type='text/css' />
		<link rel="stylesheet" href="css/bootstrap-select.css" />
		<!-- banner-slider -->
		<link href="css/jquery.slidey.min.css" rel="stylesheet">
		<!-- //banner-slider -->
		<!-- pop-up -->
		<link href="css/popuo-box.css" rel="stylesheet" type="text/css" media="all" />
		<!-- //pop-up -->
		<!-- font-awesome icons -->
		<link rel="stylesheet" href="css/font-awesome.min.css" />
		<!-- //font-awesome icons -->

		<!-- banner-bottom-plugin -->
		<!-- //banner-bottom-plugin -->
		<link href='//fonts.googleapis.com/css?family=Roboto+Condensed:400,700italic,700,400italic,300italic,300' rel='stylesheet' type='text/css'>
		<!-- start-smoth-scrolling -->
		<script type="text/javascript" src="js/sand.js"></script>
		<script type="text/javascript">
		 		
		</script>
	</head>
	<!-- //head -->
	<!-- body -->

	<body>
		<!--header-->
		<header>
			<div class="container">
				<!--logo-->

				<div class="clearfix"></div>
				<!-- bootstrap-pop-up -->
				<div class="modal video-modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModal">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								登录/注册
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							</div>
							<script type="text/javascript" src="js/LogReg-validation.js" ></script>
							<section>
								<div class="modal-body">
									<div class="w3_login_module">
										<div class="module form-module">
											<div class="toggle"><i class="fa fa-times fa-pencil"></i>
												<div class="tooltip">点我切换</div>
											</div>
											<div class="form">
												<h3>登录现有账号</h3>
												<form action="#" method="post" onsubmit="return validateForm()">
													<input type="text" name="Username1" id="Username1" placeholder="用户名" >
													<div id="UsernameInfo1" class="info"></div>
													<input type="password" name="Password1" id="Password1" placeholder="密码" >
													<div id="PasswordInfo1" class="info"></div>
													<input type="submit" value="登录">
												</form>
											</div>
											<div class="form">
												<h3>创建新的账户</h3>
												<form  method="post">
													<input type="text" name="id" id="id" placeholder="用户名" onkeyup="return checkUserName()" maxlength="16">
													<div id="UsernameInfo" class="info"></div>
													<input type="text" name="userName" id="userName" placeholder="姓名"  onkeyup="value=value.replace(/[^\u4E00-\u9FA5]/g,'');return checkName()" onkeyup="value=value.replace(/[ -~]/g,'')"   onkeydown="if(event.keyCode==13)event.keyCode=9"  maxlength="5">
													<div id="nameInfo" class="info"></div>
													<input type="password" name="password" id="password" placeholder="密码" onkeyup="return checkPassword()"  maxlength="16">
													<div id="PasswordInfo" class="info"></div>
													<input type="password" name="Passwordagain" id="Passwordagain" placeholder="密码确认" onkeyup="return checkRepassword()"  maxlength="16">
													<div id="PasswordagainInfo" class="info"></div>
													<input type="text" name="mail" id="mail" placeholder="邮箱地址" onkeyup="return checkEmai()">
													<div id="EmailInfo" class="info"></div>
													<input type="text" name="telNum" id="telNum" placeholder="手机号码"  onkeyup="return checkPhone()">
													<div id="PhoneInfo" class="info"></div>
													<select id="idtfType" name="idtfType" class="choice_sth">
														<option value="#" style="text-align: center;">
															<--请选择证件类型-->
														</option>
														<option value="护照"> &nbsp;护照</option>
														<option value="身份证"> 身份证</option>
													</select>
													<input type="text" name="idtfNum" id="idtfNum" placeholder="证件号" onkeyup="return checkIdentifer()">
													<div id="identiferInfo" class="info"></div>
													<select id="userType" class="choice_sth">
														<option name="userType" value="#" style="text-align: center;">
															<--请选择乘客类型-->
														</option>
														<option value="学生"> 学生</option>
														<option value="成人"> 成人</option>
														<option value="军人"> 军人</option>
													</select>
													<select id="gender" class="choice_sth">
														<option value="#" style="text-align: center;">
															<--请选择性别-->
														</option>
														<option value="男"> 男</option>
														<option value="女"> 女</option>
													</select>
													<div id="check_sth">
														<div id="check_number">
															<input type="text" name="check" placeholder="验证码" >
														</div id="check_button">
														<div>
															<input type="submit" value="发送验证码" />
														</div>

													</div>
													<input type="submit" value="注册" onclick="register()" >
													<input type="checkbox" id="I_agree" />我已经阅读并同意遵守
													<a href="#">《xxx服务条款》
														<a/>
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
							height: "toggle",
							'padding-top': 'toggle',
							'padding-bottom': 'toggle',
							opacity: "toggle"
						}, "slow");
					});
				</script>
				<!-- //bootstrap-pop-up -->
			</div>
			<div class="tm-header">
				<div class="container">
					<div class="row">
						<div class="col-lg-6 col-md-4 col-sm-3 tm-site-name-container">
							<a href="NotIndex.html" class="tm-site-name">Logo here</a>
						</div>
						<div class="col-lg-6 col-md-8 col-sm-9">
							<div class="mobile-menu-icon">
								<i class="fa fa-bars"></i>
							</div>
							<nav class="tm-nav" style="width: 700px;">
								<ul>
									<li>
										<a href="NotIndex.html" class="active">主页</a>
									</li>
									<li>
										<a href="#">常见问题</a>
									</li>
									<li>
										<a href="#">铁路常识</a>
									</li>
									<li>
										<a href="#">站车风采</a>
									</li>
									<li>
										<a href="#">温馨服务</a>
									</li>
								</ul>
							</nav>
						</div>
					</div>
				</div>
				<!--//logo-->

				<div class="w3layouts-login">
					<a data-toggle="modal" data-target="#myModal" href="#"><i class="glyphicon glyphicon-user"> </i>登录/注册</a>
				</div>
			</div>
			<!--/banner/-->
		</header>
		<!--//header-->
		<!--banner-->
		<div class=" header-right">
			<div class="banner">
				<div class="slider">
					<!--<div class="callbacks_container">-->
					<ul class="rslides" id="slider">
						<li>
							<div class="banner1">
								<div class="caption">
									<h3>景点介绍</h3>
									<p>
										<a class="scroll">详细介绍>></a>
									</p>
								</div>
							</div>
						</li>
						<li>
							<div class="banner2">
								<div class="caption">
									<h3>景点简介</h3>
									<p>
										<a>详细介绍>></a>
									</p>
								</div>
							</div>
						</li>
						<li>
							<div class="banner3">
								<div class="caption">
									<h3>景点简介</h3>
									<p>
										<a>详细介绍>></a>
									</p>
								</div>
							</div>
						</li>
						<li>
							<div class="banner4">
								<div class="caption">
									<h3>景点简介</h3>
									<p>
										<a>详细介绍>></a>
									</p>
								</div>
							</div>
						</li>
					</ul>
					<!--</div>-->
				</div>
			</div>
		</div>
		<!--//banner-->

		<div id="slider_tabs">
			<ul class="clearfix">
				<li>
					<a href="#tabs-1" class="one">车票</a>
				</li>
				<li>
					<a href="#tabs-2" class="two">列车时刻表</a>
				</li>
				<li>
					<a href="#tabs-3" class="three">代售点</a>
				</li>
			</ul>
			<div id="tabs-1" class="tab clearfix">
				<div class="detail">
					<form action="#" method="post">
						<div class="trip">
							<input type="radio" name="trip" value="Round-trip"><span>往返票</span>
							<input type="radio" name="trip" value="onw-way"><span>单程票</span>
						</div>

						<div class="location clearfix">
							<div class="pull-left">
								<label>出发地</label>
								<input name="Location" id="citySelect1" value="城市名">
							</div>
							<div class="pull-right">
								<label class="dst">目的地</label>
								<input name="Destination" id="citySelect2" value="城市名">
							</div>
						</div>
						<script type="text/javascript" src="js/cityPicker.js"></script>
						<link rel="stylesheet" href="css/cityPicker.css" />

						<div class="location clearfix">

							<div class="pull-left">
								<div class="date clearfix">
									<div class="Depart-Date">
										<label>出发日期</label>
										<input type="text" name="Location" id="datepicker" readonly="true">
									</div>
									<div>
										<label>返回日期</label>
										<input type="text" name="Location" id="clender" readonly="true"/>
									</div>
								</div>
							</div>
							<div class="pull-right">
								<div class="trains">
									<div id="traintype">
										列车类型：
									</div>
									<select class="train" name="train">
										<option value="NoLimit">
											<---不限--->
										</option>
										<option value="GaoTie">高铁/城际</option>
										<option value="DongChe">动车</option>
										<option value="ZhiDa">直达</option>
										<option value="tekuai">特快</option>
										<option value="kuaisu">快速</option>
									</select>
								</div>
								<div class="seats">
									<div id="seattype">
										座位类型：
									</div>
									<select class="seat" name="seat">
										<option value="select">
											<---不限--->
										</option>
									</select>
									<script type="text/javascript" src="js/seatType.js"></script>
								</div>
							</div>
						</div>

						<div class="search">
							<a href="#"><input type="submit" name="search" value="查询"></a>
						</div>
					</form>
				</div>
			</div>
			<div id="tabs-2" class="tab clearfix">
				<div class="detail">
					<form action="#" method="post">
						<div class="location clearfix">
							<div class="pull-left">
								<div class="date clearfix">
									<div class="Depart-Date">
										<label>日期</label>
										<input type="text" name="Location" value="28.06.2017" id="datepicker1">
									</div>
								</div>
							</div>
							<div id="trainid1">
								车次：
							</div>
							<div id="trainid2">
								<input type="text" name="trainId" placeholder="例如：G8016" />
							</div>
						</div>

						<div class="search">
							<input type="submit" name="search" value="查询">
						</div>
					</form>
				</div>
			</div>
			<div id="tabs-3" class="tab clearfix">
				<div class="detail">
					<form action="#" method="post">
						<div id="agencylocation">
							<div>
								<select id="s_province" name="s_province"></select>
								<select id="s_city" name="s_city"></select>
								<select id="s_county" name="s_county"></select>
								<script class="resources library" src="js/area.js" type="text/javascript"></script>

								<script type="text/javascript">
									_init_area();
								</script>
							</div>
							<div id="show"></div>
							<script type="text/javascript">
								var Gid = document.getElementById;
								var showArea = function() {
									Gid('show').innerHTML = "<h3>省" + Gid('s_province').value + " - 市" +
										Gid('s_city').value + " - 县/区" +
										Gid('s_county').value + "</h3>"
								}
								Gid('s_county').setAttribute('onchange', 'showArea()');
							</script>
						</div>
						<div id="agencySearch">
							<input type="text" name="agencyName" placeholder="精确搜索" />
						</div>

						<div class="search">
							<input type="submit" name="search" value="查询">
						</div>
					</form>
				</div>
			</div>
		</div>

		<!-- Reservation box -->
		<div class="cuttingLine">
			<div class="tm-section-header">
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6">
					<h1 class="tm-section-title">WHAT'S NEW</h1></div>
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
			</div>
		</div>
		<!--body-->

		<div id="main_body">
			<div id="routemap">
				<div id="main" style="height: 1000px;"></div>
				<script type="text/javascript">
					var myChart = echarts.init(document.getElementById('main'));
					var geoCoordMap = {
						'北京': [116.4551, 40.2539],
						'上海': [121.4648, 31.2891],
						'广州': [113.5107, 23.2196],
						'深圳': [114.5435, 22.5439],
						'成都': [103.9526, 30.7617],
						'杭州': [119.5313, 29.8773],
						'南京': [118.8013, 32.0654],
						'武汉': [114.3896, 30.6628],
						'天津': [117.4219, 39.4189],
						'西安': [109.1162, 34.2004],
						'重庆': [107.7539, 30.1904],
						'青岛': [120.4651, 36.3373],
						'沈阳': [123.1238, 42.1216],
						'长沙': [113.0823, 28.2568],
						'大连': [122.2229, 39.4409],
						'厦门': [118.1689, 24.6478],
						'无锡': [120.3442, 31.5527],
						'福州': [119.4543, 25.9222],
						'济南': [117.1582, 36.8701]
					};

					var ALLData = [
						[{
							name: '北京'
						}, {
							name: '上海'
						}],
						[{
							name: '北京'
						}, {
							name: '天津'
						}],
						[{
							name: '北京'
						}, {
							name: '济南'
						}],
						[{
							name: '北京'
						}, {
							name: '沈阳'
						}],
						[{
							name: '北京'
						}, {
							name: '大连'
						}],
						[{
							name: '北京'
						}, {
							name: '青岛'
						}],
						[{
							name: '北京'
						}, {
							name: '西安'
						}],
						[{
							name: '上海'
						}, {
							name: '无锡'
						}],
						[{
							name: '上海'
						}, {
							name: '南京'
						}],
						[{
							name: '上海'
						}, {
							name: '杭州'
						}],
						[{
							name: '上海'
						}, {
							name: '武汉'
						}],
						[{
							name: '上海'
						}, {
							name: '福州'
						}],
						[{
							name: '广州'
						}, {
							name: '深圳'
						}],
						[{
							name: '广州'
						}, {
							name: '厦门'
						}],
						[{
							name: '广州'
						}, {
							name: '长沙'
						}],
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var BJData = [
						[{
							name: '北京'
						}, {
							name: '上海'
						}],
						[{
							name: '北京'
						}, {
							name: '天津'
						}],
						[{
							name: '北京'
						}, {
							name: '济南'
						}],
						[{
							name: '北京'
						}, {
							name: '沈阳'
						}],
						[{
							name: '北京'
						}, {
							name: '大连'
						}],
						[{
							name: '北京'
						}, {
							name: '青岛'
						}],
						[{
							name: '北京'
						}, {
							name: '西安'
						}]
					];

					var SHData = [
						[{
							name: '上海'
						}, {
							name: '无锡'
						}],
						[{
							name: '上海'
						}, {
							name: '南京'
						}],
						[{
							name: '上海'
						}, {
							name: '杭州'
						}],
						[{
							name: '上海'
						}, {
							name: '武汉'
						}],
						[{
							name: '上海'
						}, {
							name: '福州'
						}]
					];

					var GZData = [
						[{
							name: '广州'
						}, {
							name: '深圳'
						}],
						[{
							name: '广州'
						}, {
							name: '厦门'
						}],
						[{
							name: '广州'
						}, {
							name: '长沙'
						}],
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var SZData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var CDData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var HZData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var NJData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var WHData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var TJData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var XAData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var CQData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var QDData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var SYData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var CSData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var DLData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var XMData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var WXData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var FZData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var JNData = [
						[{
							name: '广州'
						}, {
							name: '福州'
						}]
					];

					var planePath = 'path://M1705.06';

					var convertData = function(data) {
						var res = [];
						for(var i = 0; i < data.length; i++) {
							var dataItem = data[i];
							var fromCoord = geoCoordMap[dataItem[0].name];
							var toCoord = geoCoordMap[dataItem[1].name];
							if(fromCoord && toCoord) {
								res.push({
									fromName: dataItem[0].name,
									toName: dataItem[1].name,
									coords: [fromCoord, toCoord]
								});
							}
						}
						return res;
					};

					var color = ['#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366', '#003366'];
					var series = [];
					[
						['概览', ALLData],
						['北京', BJData],
						['上海', SHData],
						['广州', GZData],
						['深圳', SZData],
						['成都', CDData],
						['杭州', HZData],
						['南京', NJData],
						['武汉', WHData],
						['天津', TJData],
						['西安', XAData],
						['重庆', CQData],
						['青岛', QDData],
						['沈阳', SYData],
						['长沙', CSData],
						['大连', DLData],
						['厦门', XMData],
						['无锡', WXData],
						['福州', FZData],
						['济南', JNData]
					].forEach(function(item, i) {
						series.push({
							name: item[0],
							type: 'lines',
							zlevel: 1,
							effect: {
								show: true,
								period: 6,
								trailLength: 0.7,
								color: '#DE5145',
								symbolSize: 3
							},
							lineStyle: {
								normal: {
									color: color[i],
									width: 0,
									curveness: 0.2
								}
							},
							data: convertData(item[1])
						}, {
							name: item[0],
							type: 'lines',
							zlevel: 2,
							symbol: ['none', 'arrow'],
							symbolSize: 10,
							effect: {
								show: true,
								period: 6,
								trailLength: 0,
								symbol: planePath,
								symbolSize: 15
							},
							lineStyle: {
								normal: {
									color: color[i],
									width: 1,
									opacity: 0.6,
									curveness: 0.2
								}
							},
							data: convertData(item[1])
						}, {
							name: item[0],
							type: 'effectScatter',
							coordinateSystem: 'geo',
							zlevel: 2,
							rippleEffect: {
								brushType: 'stroke'
							},
							label: {
								normal: {
									show: true,
									position: 'right',
									formatter: '{b}',
									textStyle: {
										fontSize: 18
									}
								}
							},
							symbolSize: function(val) {
								return val[2] / 8;
							},
							itemStyle: {
								normal: {
									color: color[i]
								}
							},
							data: item[1].map(function(dataItem) {
								return {
									name: dataItem[1].name,
									value: geoCoordMap[dataItem[1].name]
								};
							})
						});
					});

					option = {
						backgroundColor: 'white',
						title: {
							text: '铁路路线分布图',
							left: 'center',
							textStyle: {
								fontSize: '25',
								color: 'black'
							}
						},
						tooltip: {
							trigger: 'item'
						},
						legend: {
							orient: 'horizontal',
							top: 'bottom',
							left: 'right',
							data: ['概览', '北京', '上海', '广州', '深圳', '成都', '杭州', '南京', '武汉', '天津', '西安', '重庆', '青岛', '沈阳', '长沙', '大连', '厦门', '无锡', '福州', '济南'],
							textStyle: {
								color: 'black'
							},
							selectedMode: 'single'
						},
						geo: {
							map: 'china',
							label: {
								emphasis: {
									show: false
								}
							},
							roam: false,
							itemStyle: {
								normal: {
									areaColor: '#FFFAE8',
									borderColor: '#404a59'
								},
								emphasis: {
									areaColor: '#BCD68D'
								}
							}
						},
						series: series
					};
					myChart.setOption(option);
				</script>
			</div>
			<div id="news">
				<!-- news-right-top -->
				<div class="news-right-top">
					<div class="wthree-news-right-heading">
						<h3>最新动态</h3>
					</div>
					<div class="wthree-news-right-top">
						<div class="news-grids-bottom">
							<!-- date -->
							<div id="design" class="date">
								<div id="cycler">
									<div class="date-text">
										<a href="#">2017.3.25</a>
										<p>关于调整互联网、电话订票起售时间的公告</p>
									</div>
									<div class="date-text">
										<a href="#">2017.6.19<span class="blinking"><img src="images/new.png" alt="" /></span></a>
										<p>上海铁路局关于2017年7月7日-8月28日增开部分旅客列车的公告</p>
									</div>
									<div class="date-text">
										<a href="#">2017.2.5</a>
										<p>成都铁路局关于四川盆地暴雨可能引起旅客列车晚点的公告</p>
									</div>
									<div class="date-text">
										<a href="#">2017.7.5<span class="blinking"><img src="images/new.png" alt="" /></span></a>
										<p>南昌铁路局关于增开部分旅客列车信息公告（四）</p>
									</div>
									<div class="date-text">
										<a href="#">2017.4.6</a>
										<p>南昌铁路局关于增开部分旅客列车信息公告（三）</p>
									</div>
									<div class="date-text">
										<a href="#">2017.1.2</a>
										<p>武汉铁路局关于2017年7月5日部分旅客列车恢复开行的公告</p>
									</div>
									<div class="date-text">
										<a href="#">2017.6.29<span class="blinking"><img src="images/new.png" alt="" /></span></a>
										<p>广铁集团公司关于2017年7月8日至7月9日增开深圳北--厦门北D4088次旅客列车的公告</p>
									</div>
									<div class="date-text">
										<a href="#">2017.4.3</a>
										<p>太原铁路局关于7月4日天津开K608次、朔州开2604次列车变更运行区段的公告</p>
									</div>
									<div class="date-text">
										<a href="#">2017.7.2<span class="blinking"><img src="images/new.png" alt="" /></span></a>
										<p>沈阳铁路局关于临时调整列车运行图的公告</p>
									</div>
									<div class="date-text">
										<a href="#">2017.5.2</a>
										<p>沈阳铁路局关于京通、叶赤线部分车站不具备旅客候车、售票条件的公告</p>
									</div>
								</div>
								<script>
									function blinker() {
										$('.blinking').fadeOut(500);
										$('.blinking').fadeIn(500);
									}
									setInterval(blinker, 1000);
								</script>
								<script>
								var timeOut;
									function cycle($item, $cycler) {
										timeOut = setTimeout(cycle, 2000, $item.next(), $cycler);

										$item.slideUp(1000, function() {
											$item.appendTo($cycler).show();
										});
									}
									cycle($('#cycler div:first'), $('#cycler'));
								</script>
								<script>
									$("#cycler a").mouseover(function(){
										
										console.log($(this).parent());
										clearTimeout(timeOut);
										//$(this).parent().stop(true,false);
									});
									$("#cycler a").mouseout(function(){
										timeOut = setTimeout(cycle, 2000, $('#cycler div:first'), $('#cycler'));
									})
								</script>
							</div>
							<!-- //date -->
						</div>
					</div>
				</div>
				<!-- //news-right-top -->
			</div>
		</div>
		<!--//body-->
		<div class="cuttingLine1">
			<div class="tm-section-header">
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6">
					<h1 class="tm-section-title">ABOUT US</h1></div>
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
			</div>
		</div>
		<!--footer-->
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
		<!--//footer-->
		<!-- Reservation box -->
		<!-- Responsive-slider -->
		<!-- Banner-slider -->
		<script>
			$(function() {
				$("#slider").responsiveSlides({
					auto: true,
					speed: 500,
					namespace: "callbacks",
					pager: true,
				});
				$("#datepicker").datepicker({
					minDate: 0,
					maxDate: "+2M",
					/*dateFormat: 'yyyy/MM/dd',*/
					onClose: function(selectedDate) {
						$("#clender").val($("#datepicker").val());
						$("#datepicker").datepicker("option", "setDate", new Date($("#datepicker").val()));
					}
				});

				Date.prototype.format = function(fmt) {
					var o = {
						"M+": this.getMonth() + 1, //月份 
						"d+": this.getDate(), //日 
						"h+": this.getHours(), //小时 
						"m+": this.getMinutes(), //分 
						"s+": this.getSeconds(), //秒 
						"q+": Math.floor((this.getMonth() + 3) / 3), //季度 
						"S": this.getMilliseconds() //毫秒 
					};
					if(/(y+)/.test(fmt)) {
						fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
					}
					for(var k in o) {
						if(new RegExp("(" + k + ")").test(fmt)) {
							fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
						}
					}
					return fmt;
				}
				$("#datepicker").val(new Date().format("MM/dd/yyyy"));
				$("#clender").val(new Date().format("MM/dd/yyyy"));

				function nationalDays(date) {
					var startTime = $("#datepicker").val();
					var formatTime = $("#datepicker").val().split("/")[2] + "-" + $("#datepicker").val().split("/")[0] + "-" + $("#datepicker").val().split("/")[1];
					if(new Date(new Date(date).format("yyyy-MM-dd")) < new Date(new Date(formatTime).format("yyyy-MM-dd"))) {
						return [false, ''];
					}
					return [true, ''];
				}
				$("#clender").datepicker({
					beforeShowDay: nationalDays
						/*dateFormat: 'yyyy/MM/dd',*/
						/*onClose: function(selectedDate) {
							$("#datepicker").datepicker("option", "maxDate", selectedDate);
						}*/
				});
				$("#datepicker1").datepicker();
			});
		</script>

		<!-- //Banner-slider -->

	</body>
	<!-- //body -->

</html>
<!-- //html -->