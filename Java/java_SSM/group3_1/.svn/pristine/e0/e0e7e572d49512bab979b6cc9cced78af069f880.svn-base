<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ request.getContextPath() + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- head -->

<head>
<title>主页</title>
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
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
<script type="text/javascript" src="js/custom.js"></script>
<script src="js/jquery.flexslider-min.js"></script>
<script src="js/jquery.cycle.all.js"></script>
<script src="js/jquery-ui.js"></script>
<script src="js/bootstrap.min.js"></script>
<!--meta data-->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
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
<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
	media="all" />
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<link rel="stylesheet" href="css/faqstyle.css" type="text/css"
	media="all" />
<link href="css/medile.css" rel='stylesheet' type='text/css' />
<link rel="stylesheet" href="css/bootstrap-select.css" />
<!-- banner-slider -->
<link href="css/jquery.slidey.min.css" rel="stylesheet">
<!-- //banner-slider -->
<!-- pop-up -->
<link href="css/popuo-box.css" rel="stylesheet" type="text/css"
	media="all" />
<!-- //pop-up -->
<!-- font-awesome icons -->
<link rel="stylesheet" href="css/font-awesome.min.css" />
<!-- //font-awesome icons -->
<!-- start-smoth-scrolling -->
<script type="text/javascript" src="js/sand.js"></script>

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
									<form action="#" method="post">
										<input type="text" name="Username" placeholder="用户名"
											required=""> <input type="password" name="Password"
											placeholder="密码" required="" maxlength=""> <input
											type="submit" value="登录">
									</form>
								</div>
								<div class="form">
									<h3>创建新的账户</h3>
									<form action="#" method="post">
										<input type="text" name="Username" placeholder="用户名"
											required=""><span id="UsernameInfo"></span></input> <input
											type="text" name="name" placeholder="姓名" required=""
											maxlength="5" onkeyup="checkName()"> <input
											type="password" name="Password" placeholder="密码" required="">
										<input type="password" name="Passwordagain" placeholder="密码确认"
											required=""> <input type="email" name="Email"
											placeholder="邮箱地址" required=""> <input type="text"
											name="Phone" placeholder="电话号码" required=""> <select
											class="choice_sth">
											<option value="#" style="text-align: center;">
												&lt;--请选择证件类型--></option>
											<option value="护照">&nbsp;护照</option>
											<option value="身份证">身份证</option>
										</select> <input type="text" name="identifer" placeholder="证件号"
											required=""> <select class="choice_sth">
											<option value="#" style="text-align: center;">
												&lt;--请选择乘客类型--></option>
											<option value="学生">学生</option>
											<option value="成人">成人</option>
											<option value="军人">军人</option>
										</select> <select class="choice_sth">
											<option value="#" style="text-align: center;">
												&lt;--请选择性别--></option>
											<option value="男">男</option>
											<option value="女">女</option>
										</select>
										<div id="check_sth">
											<div id="check_number">
												<input type="text" name="check" placeholder="验证码"
													required="">
											</div>
											<div id="check_button">
												<input type="submit" value="发送验证码" />
											</div>

										</div>
										<input type="submit" value="注册"> <input
											type="checkbox" id="I_agree" />我已经阅读并同意遵守 <a href="#">《xxx服务条款》</a>
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
					<a href="NotIndex.html" class="tm-site-name">Logo here</a>
				</div>
				<div class="col-lg-6 col-md-8 col-sm-9">
					<div class="mobile-menu-icon">
						<i class="fa fa-bars"></i>
					</div>
					<nav class="tm-nav" style="width: 700px;">
					<ul>
						<li><a href="NotIndex.html" class="active">主页</a></li>
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
			<a data-toggle="modal" data-target="#myModal" href="#"><i
				class="glyphicon glyphicon-user"> </i>登录/注册</a>
		</div>
	</div>
	<!--/banner/--> </header>
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
			<li><a href="#tabs-1" class="one">车票</a></li>
			<li><a href="#tabs-2" class="two">列车时刻表</a></li>
			<li><a href="#tabs-3" class="three">代售点</a></li>
		</ul>
		<div id="tabs-1" class="tab clearfix">
			<div class="detail">
				<form action="<%=basePath%>queryInfo/ticketQuery" method="post">
					<div class="trip">
						<input id="double" type="radio" name="trip" value="roundWay">
						<label style="position: relative; top: -2px;left:-7px;" for="double">往返票</label> 
						<input id="single" type="radio" name="trip" value="oneWay">
						<label style="position: relative; top: -2px;left:-7px;" for="single">单程票</label>
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
									<input type="text" name="leaveDate" id="datepicker">
								</div>
								<div>
									<label>返回日期</label> 
									<input type="text" name="arriveDate" id="clender" />
								</div>
							</div>
						</div>
						<div class="pull-right">
							<div class="trains">
								<div id="traintype">列车类型：</div>
								<select class="train" name="train" style="width: 100px">
									<option value="NoLimit">&lt;-不限-></option>
									<option value="D">普通动车</option>
									<option value="G">高速动车</option>
									<option value="Z">直达快速</option>
									<option value="T">特别快速</option>
									<option value="P">普通快速</option>
									<option value="C">城际列车</option>
									<option value="L">临时列车</option>
									<option value="N">管内快速</option>
								</select>
							</div>
							<div class="seats">
								<div id="seattype">座位类型：</div>
								<select class="seat" name="seat" style="width: 100px">
									<option value="NoLimit">&lt;-不限-></option>
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
				<form action="<%=basePath%>queryInfo/QueryForTrain" method="post">
					<div class="location clearfix">
						<div class="pull-left">
							<div class="date clearfix">
								<div class="Depart-Date">
									<label>日期</label> <input type="text" name="date"
										value="28/06/2017" id="datepicker1">
								</div>
							</div>
						</div>
						<div id="trainid1">车次：</div>
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
				<form action="<%=basePath%>queryInfo/queryForAgency" method="post">
					<div id="agencylocation">
						<div>
							<select id="s_province" name="s_province"></select> <select
								id="s_city" name="s_city"></select> <select id="s_county"
								name="s_county"></select>
							<script class="resources library" src="js/area.js"
								type="text/javascript"></script>

							<script type="text/javascript">
								_init_area();
							</script>
						</div>
						<div id="show"></div>
						<script type="text/javascript">
							var Gid = document.getElementById;
							var showArea = function() {
								Gid('show').innerHTML = "<h3>省"
										+ Gid('s_province').value + " - 市"
										+ Gid('s_city').value + " - 县/区"
										+ Gid('s_county').value + "</h3>"
							}
							Gid('s_county').setAttribute('onchange',
									'showArea()');
						</script>
					</div>
					<div id="agencySearch">
						<input type="text" name="agencyName" placeholder="" />
					</div>

					<div class="search">
						<input type="submit" name="search" value="查询" />
					</div>
				</form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		function submitInfo(current) {
			var infoBox = $(current).parent().parent();
			var InfoTojson = {
				"province" : infoBox.find("#s_province").val(),
				"city" : infoBox.find("#s_city").val(),
				"county" : infoBox.find("#s_county").val()
			};
			alert(JSON.stringify(InfoTojson));
			alert(InfoTojson);
			console.log(InfoTojson);
		}
	</script>
	<!-- Reservation box -->
	<div class="cuttingLine">
		<div class="tm-section-header">
			<div class="col-lg-3 col-md-3 col-sm-3">
				<hr>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-6">
				<h1 class="tm-section-title" style="font-family: 'century gothic';">WHAT'S
					NEW</h1>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-3">
				<hr>
			</div>
		</div>
	</div>
	<!--body-->

	<div id="main_body">
		<div id="routemap">
			<div id="map" style="height: 1000px;"></div>
			<script type="text/javascript" src="js/Map.js"></script>
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
									<a href="#">2017.6.19<span class="blinking"><img
											src="images/new.png" alt="" /></span></a>
									<p>上海铁路局关于2017年7月7日-8月28日增开部分旅客列车的公告</p>
								</div>
								<div class="date-text">
									<a href="#">2017.2.5</a>
									<p>成都铁路局关于四川盆地暴雨可能引起旅客列车晚点的公告</p>
								</div>
								<div class="date-text">
									<a href="#">2017.7.5<span class="blinking"><img
											src="images/new.png" alt="" /></span></a>
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
									<a href="#">2017.6.29<span class="blinking"><img
											src="images/new.png" alt="" /></span></a>
									<p>广铁集团公司关于2017年7月8日至7月9日增开深圳北--厦门北D4088次旅客列车的公告</p>
								</div>
								<div class="date-text">
									<a href="#">2017.4.3</a>
									<p>太原铁路局关于7月4日天津开K608次、朔州开2604次列车变更运行区段的公告</p>
								</div>
								<div class="date-text">
									<a href="#">2017.7.2<span class="blinking"><img
											src="images/new.png" alt="" /></span></a>
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
								function cycle($item, $cycler) {
									setTimeout(cycle, 2000, $item.next(),
											$cycler);

									$item.slideUp(1000, function() {
										$item.appendTo($cycler).show();
									});
								}
								cycle($('#cycler div:first'), $('#cycler'));
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
				<h1 class="tm-section-title" style="font-family: 'century gothic';">ABOUT
					US</h1>
			</div>
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
	<!--//footer-->
	<!-- Reservation box -->
	<!-- Responsive-slider -->
	<!-- Banner-slider -->
	<script>
		$(function() {
			$("#slider").responsiveSlides({
				auto : true,
				speed : 500,
				namespace : "callbacks",
				pager : true,
			});
			$("#datepicker").datepicker(
					{
						minDate : 0,
						maxDate : "+2M",
						/*dateFormat: 'yyyy/MM/dd',*/
						onClose : function(selectedDate) {
							$("#clender").val($("#datepicker").val());
							$("#datepicker").datepicker("option", "setDate",
									new Date($("#datepicker").val()));
						}
					});

			Date.prototype.format = function(fmt) {
				var o = {
					"M+" : this.getMonth() + 1, //月份 
					"d+" : this.getDate(), //日 
					"h+" : this.getHours(), //小时 
					"m+" : this.getMinutes(), //分 
					"s+" : this.getSeconds(), //秒 
					"q+" : Math.floor((this.getMonth() + 3) / 3), //季度 
					"S" : this.getMilliseconds()
				//毫秒 
				};
				if (/(y+)/.test(fmt)) {
					fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "")
							.substr(4 - RegExp.$1.length));
				}
				for ( var k in o) {
					if (new RegExp("(" + k + ")").test(fmt)) {
						fmt = fmt.replace(RegExp.$1,
								(RegExp.$1.length == 1) ? (o[k])
										: (("00" + o[k])
												.substr(("" + o[k]).length)));
					}
				}
				return fmt;
			}
			$("#datepicker").val(new Date().format("MM/dd/yyyy"));
			$("#clender").val(new Date().format("MM/dd/yyyy"));

			function nationalDays(date) {
				var startTime = $("#datepicker").val();
				var formatTime = $("#datepicker").val().split("/")[2] + "-"
						+ $("#datepicker").val().split("/")[0] + "-"
						+ $("#datepicker").val().split("/")[1];
				if (new Date(new Date(date).format("yyyy-MM-dd")) < new Date(
						new Date(formatTime).format("yyyy-MM-dd"))) {
					return [ false, '' ];
				}
				return [ true, '' ];
			}
			$("#clender").datepicker({
				beforeShowDay : nationalDays
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