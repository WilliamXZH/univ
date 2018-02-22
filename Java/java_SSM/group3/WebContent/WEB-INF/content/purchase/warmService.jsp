<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% String basePath=request.getScheme() + "://" +
request.getServerName() + ":" + request.getServerPort() +
request.getContextPath() + "/"; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>


	<head>
		<title>温馨服务t</title>
		<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />
		<!-- Custom Theme files -->
		<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
		<!-- Custom Theme files -->
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<!-- Custom Theme files -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="keywords" content="My Show Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
Smartphone Compatible web template, free webdesigns for Nokia, Samsung, LG, SonyErricsson, Motorola web design" />
		<link rel="stylesheet" href="css/style_footer.css" />
		<script type="application/x-javascript">
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);

			function hideURLbar() {
				window.scrollTo(0, 1);
			}
		</script>
		<!--webfont-->
		<link href='#css?family=Oxygen:400,700,300' rel='stylesheet' type='text/css'>
		<link href='#css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css'>
		<!-- start menu -->

		<link rel="stylesheet" href="css/style_nav.css" rel="stylesheet" type="text/css" media="all" />
		<link rel="stylesheet" href="css/news-nav.css" rel="stylesheet" type="text/css" media="all" />

		<link href="css/megamenu.css" rel="stylesheet" type="text/css" media="all" />
		<script type="text/javascript" src="js/megamenu.js"></script>
		<script>
			$(document).ready(function() {
				$(".megamenu").megamenu();
			});
		</script>
		<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="css/font-awesome.min.css" />
		<link rel="stylesheet" href="css/menu.css" />
		<script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$('#horizontalTab').easyResponsiveTabs({
					type: 'default', //Types: default, vertical, accordion           
					width: 'auto', //auto or any width like 600px
					fit: true // 100% fit in a container
				});
			});
		</script>

		<!---- start-smoth-scrolling---->
		<script type="text/javascript" src="js/move-top.js"></script>
		<script type="text/javascript" src="js/easing.js"></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
		<link rel="stylesheet" href="css/bootstrap.css" />
		<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event) {
					event.preventDefault();
					$('html,body').animate({
						scrollTop: $(this.hash).offset().top
					}, 1200);
				});
			});
		</script>
		<!---- start-smoth-scrolling---->
	</head>

	<body>
		<!-- header-section-starts -->
		<div class="tm-header">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-md-4 col-sm-3 tm-site-name-container">
						<a href="NotIndex.html" class="tm-site-name"><img src="images/logo2.jpg" style="position: relative;top: -15px;"></a>
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
								<li><a class="active" href="../purchase/warmService">温馨服务</a></li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
			<!--//logo-->
			<div class="w3layouts-login">
					<a  href="../userweb/first"><i class="glyphicon glyphicon-user"> </i>个人中心</a>
			</div>
		</div>

		<div class="faq">
			<div class="container">
				<div class="agileits-news-top">
					<ol class="breadcrumb">
						<li><a href="../main/NotIndex" >主页</a></li>
						
						<li class="active">温馨服务</li>
					</ol>
				</div>
			</div>
		</div>

		<div class="container" style="margin-bottom: 100px;">
			<div class="main-content">
				<div class="e-payment-section">
					<div class="col-md-* payment-left">
						<div class="payment-options">
							<h3>温馨服务：</h3>
							<div class="tabs-box">
								<ul class="tabs-menu booking-menu">
									<li>
										<a class="btn-primary" style="text-align: center;font-size: 16px;" href="#tab1">全部服务列表</a>
									</li>
									<li>
										<a class="btn-primary" style="margin-top: 2px;text-align: center;font-size: 16px" href="#tab2">遗失物品查找</a>
									</li>
									<li>
										<a class="btn-primary" style="margin-top: 2px;text-align: center;font-size: 16px" href="#tab3">重点旅客预约</a>
									</li>
								</ul>
								<div class="clearfix"> </div>
								<div class="tab-grids event-tab-grids">
									<div id="tab1" class="tab-grid">
										<p><img src="images/ServiceList.PNG" width="950"></p>

									</div>
									<div id="tab2" class="tab-grid">
										<div class="table-responsive">
											<table class="table">
												<caption><h1>失物列表</h1></caption>
												<br>
												<thead>
													<tr>
														<th>遗失物品</th>
														<th>物品描述</th>
														<th>拾到时间</th>
														<th>拾到地点</th>
														<th>领取地点</th>
														<th>领取状态</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>充电宝</td>
														<th>小米，银色，底部有明显划痕</th>
														<td>23/11/2013</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>未领取</th>
													</tr>
													<tr class="success">
														<td>充电宝</td>
														<th>小米，银色，底部有明显划痕</th>
														<td>23/11/2013</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>已领取</th>
													</tr>
													<tr>
														<td>充电宝</td>
														<th>小米，银色，底部有明显划痕</th>
														<td>23/11/2013</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>未领取</th>
													</tr>
													<tr>
														<td>充电宝</td>
														<th>小米，银色，底部有明显划痕</th>
														<td>23/11/2013</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>未领取</th>
													</tr>
													<tr class="success">
														<td>充电宝</td>
														<th>小米，银色，底部有明显划痕</th>
														<td>23/11/2013</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>已领取</th>
													</tr>
													<tr>
														<td>充电宝</td>
														<th>小米，银色，底部有明显划痕</th>
														<td>23/11/2013</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>未领取</th>
													</tr>
													<tr>
														<td>充电宝</td>
														<th>小米，银色，底部有明显划痕</th>
														<td>01/08/2017</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>未领取</th>
													</tr>
													<tr class="success">
														<td>耳机</td>
														<th>苹果，银色</th>
														<td>23/07/2017</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>已领取</th>
													</tr>
													<tr>
														<td>充电宝</td>
														<th>小米，银色，底部有明显划痕</th>
														<td>23/11/2013</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>未领取</th>
													</tr>
													<tr>
														<td>充电宝</td>
														<th>小米，银色，底部有明显划痕</th>
														<td>23/11/2013</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>未领取</th>
													</tr>
													<tr>
														<td>充电宝</td>
														<th>小米，银色，底部有明显划痕</th>
														<td>23/11/2013</td>
														<td>火车站检票进站处</td>
														<th>售票厅服务台</th>
														<th>未领取</th>
													</tr>
												</tbody>
											</table>

										</div>
										<div style="position: relative;left: 350px;">
											<ul class="pagination">
												<li>
													<a href="#">&laquo;</a>
												</li>
												<li>
													<a href="#">1</a>
												</li>
												<li>
													<a href="#">2</a>
												</li>
												<li>
													<a href="#">3</a>
												</li>
												<li>
													<a href="#">4</a>
												</li>
												<li>
													<a href="#">5</a>
												</li>
												<li>
													<a href="#">&raquo;</a>
												</li>
											</ul>

										</div>

									</div>
									<div id="tab3" class="tab-grid">
										
										<h1 style="text-align: center;">重点旅客预约流程</h1><br>
										<em></em><br>
										<p>1.首先，用户进入到snail官方网站，点击新版售票选项。进入到新版售票的界面。</p>
										<p>2.进入到新版售票界面后，用户点击界面右上角箭头所指处的【登录】选项。</p>
										<p>3.在登录界面上，用户输入自己的用户登录名、登录密码和验证码，完成登录操作。</p>
										<p>4.完成登录操作后，用户进入到【个人中心】选项，之后点击左侧的【重点旅客预约】选项。</p>
										<p>5.用户在使用重点旅客预约】服务的时候，需要认真阅读重点旅客预约可以享受哪些权利和义务，之后点击同意。</p>
										<p>6.点击同意后，用户就可以填写一张重点旅客预约服务单了，提交审核通过后，重点旅客就可以享受提前进、离站，</p>
										<p>	携带导盲犬等特殊服务了。</p>
										<em></em><br>
										<em></em><br>
										<em></em><br>
										
										<p>发布时间：2017.08.01</p>
										<p>发布单位：Snail官方网站</p>
										

									</div>

								</div>
								<div class="clearfix"> </div>
							</div>
							<!--start-carrer-->
							<!----- Comman-js-files ----->
							<script>
								$(document).ready(function() {
									$("#tab2").hide();
									$("#tab3").hide();
									$("#tab4").hide();
									$(".tabs-menu a").click(function(event) {
										event.preventDefault();
										var tab = $(this).attr("href");
										$(".tab-grid").not(tab).css("display", "none");
										$(tab).fadeIn("slow");
									});
								});
							</script>

						</div>
					</div>

					<div class="clearfix"></div>
				</div>
			</div>
			<div class="clearfix"></div>
		</div>

		<div class="cuttingLine1">
			<div class="tm-section-header">
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6">
					<h1 class="tm-section-title" style="font-family:'century gothic';">ABOUT US</h1>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
			</div>
		</div>

		<footer id="footerContainer">
			<div class="footer">
				<div class="container">
					<div class="row">
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="quicklinks">
								<h4 class="footerh"><font><font>相关链接</font></font></h4>
								<br>
								<ul>
									<li><i class="fa fa-angle-right"></i>
										<a href="#">
											<font>
												<font>企业差旅索引</font>
											</font>
										</a>
									</li>
									<li><i class="fa fa-angle-right"></i>
										<a href="#">
											<font>
												<font>网络社会征信网</font>
											</font>
										</a>
									</li>
									<li><i class="fa fa-angle-right"></i>
										<a href="#">
											<font>
												<font>加盟合作</font>
											</font>
										</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="quickcontact">
								<h4 class="footerh"><font><font>联系我们</font></font></h4>
								<br>
								<ul>
									<li><i class="fa fa-phone"></i>
										<font>
											<font> 123456789</font>
										</font>
									</li>
									<li><i class="fa fa-envelope"></i>
										<font>
											<font> abc@website.com</font>
										</font>
									</li>
									<li><i class="fa fa-map-marker"></i>
										<font>
											<font> 2B Barcelon，纽约-32011</font>
										</font>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-md-4 col-sm-12 col-xs-12">
							<div class="follow">
								<h4 class="footerh"><font><font>微信公众号</font></font></h4>
								<br>
								<img src="images/er_ctrip_wechat.jpg">
							</div>
						</div>
					</div>
				</div>
			</div>

			<div>
				<div class="row" style="background: white;">
					<div class="col-md-12">
						<p style="color: black;">
							<font>
								<font>版权所有©2017.公司名称保留所有权利。
								</font>
							</font>
						</p>
					</div>
				</div>
			</div>
			<div id="toTopButton"></div>
		</footer>

		<script src="js/responsive-tabs.js"></script>
		<script type="text/javascript">
			$('#myTab a').click(function(e) {
				e.preventDefault();
				$(this).tab('show');
			});

			$('#moreTabs a').click(function(e) {
				e.preventDefault();
				$(this).tab('show');
			});

			(function($) {
				// Test for making sure event are maintained
				$('.js-alert-test').click(function() {
					alert('Button Clicked: Event was maintained');
				});
				fakewaffle.responsiveTabs(['xs', 'sm']);
			})(jQuery);
		</script>
		<script type="text/javascript">
			$(document).ready(function() {
				$().UItoTop({
					easingType: 'easeOutQuart'
				});
			});
		</script>
		<a href="#home" class="scroll" id="toTop" style="display: block;">
			<span id="toTopHover" style="opacity: 1;"> </span>
		</a>

	</body>

</html>