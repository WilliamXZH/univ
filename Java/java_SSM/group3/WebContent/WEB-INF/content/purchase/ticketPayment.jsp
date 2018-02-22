<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<title>Ticket Payment</title>
		<link href="css/bootstrap.css" rel="stylesheet" type="text/css" />
		<!-- Custom Theme files -->
		<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
		<!-- Custom Theme files -->
		<script src="js/jquery.min.js" type="text/javascript" ></script>
		<script src="js/bootstrap.min.js" type="text/javascript"></script>
		<!-- Custom Theme files -->
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<link rel="stylesheet" href="css/style_footer.css" type="text/css" />
		<script type="application/x-javascript">
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);

			function hideURLbar() {
				window.scrollTo(0, 1);
			}
		</script>

		<link href="css/style_nav.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/news-nav.css" rel="stylesheet" type="text/css" media="all" />
		<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
		<link rel="stylesheet" href="css/font-awesome.min.css" />
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
	</head>

	<body>
		<script>
			setTimeout(function() {
				/* alert("payMethod:"+payMethod+"\nifDeliver:"+"${param.ifDeliver}"); */
				$.ajax({
					type:"POST",
					url:"payForOrder",
					data:{
						payMethod:payMethod,
						ifDeliver:'${param.ifDeliver}'
					},
					dataType:"json",
					success:function(){
						alert("成功");
						<%session.setAttribute("totalCost",request.getParameter("totalCost"));%>
						window.location.href="ticketOrderSuccess";
					},
					error:function(){
						alert("Error!");
					}
				})
			}, 5000);
		</script>
		<!-- header-section-starts -->
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
				<a data-toggle="modal" data-target="#myModal" href="#"><i class="glyphicon glyphicon-user"> </i>个人中心</a>
			</div>
		</div>

		<div class="faq">
			<div class="container">
				<div class="agileits-news-top">
					<ol class="breadcrumb">
						<li>
							<a href="../main/NotIndex">主页</a>
						</li>
						<li>
							<a href="#">查询</a>
						</li>
						<li>
							<a href="#">购票</a>
						</li>
						<li>
							<a href="#">订单确认</a>
						</li>
						<li class="active">支付</li>
					</ol>
				</div>
			</div>
		</div>

		<div class="container">
			<div class="main-content">
				<div class="e-payment-section">
					<div class="col-md-8 payment-left">
						<div class="payment-options">
							<h3>付款方式：</h3>
							<div class="tabs-box">
								<ul class="tabs-menu booking-menu">
									<li>
										<a href="#tab1">微信</a>
									</li>
									<li>
										<a href="#tab2">支付宝</a>
									</li>
								</ul>
								<div class="clearfix"> </div>
								<div class="tab-grids event-tab-grids">
									<div id="tab1" class="tab-grid">

										<p>&nbsp;</p>
										<p><img src="images/WeChat_pacodey.PNG" width="416" height="354" /></p>

									</div>
									<div id="tab2" class="tab-grid">

										<p>&nbsp;</p>
										<p><img src="images/Ali_paycode.png" width="416" height="354" /></p>

									</div>
									
								</div>
								<div class="clearfix"> </div>
							</div>
							<script>
								var payMethod="微信";
								$(document).ready(function() {
									$("#tab2").hide();
									
									$(".tabs-menu a").click(function(event) {
										event.preventDefault();
										var tab = $(this).attr("href");
										payMethod=$(this).text();
										$(".tab-grid").not(tab).css("display", "none");
										$(tab).fadeIn("slow");
										
									});
								});
							
							</script>

						</div>
					</div>
					<div class="col-md-4">
						<div class="ticket-note">
							<h3>热心小贴士:</h3>
							<ol>
								<li>
									<p>因站名相似或口音不同发生车票误售、误购时，在发站换发新票。在中途站、原票到站或列车内补收票款时，换发代用票，补收标价差额。应退还票款时，站、车应编制客运纪录交旅客，作为乘车至正当到站要求退还标价差额的凭证，并以最方便的列车将旅客运送至正当到站，均不收取手续费或退票费。</p>
								</li>
								<li>
									<p>.在列车上因居民身份证丢失、无法确认车票信息的，请先行补票。旅客补票后，又找到居民身份证的，列车长确认后开具客运记录交旅客，旅客持客运记录和居民身份证原件到下车站退票窗口退还后补车票，不收退票</p>
								</li>
								<li>
									<p>.在列车上因居民身份证丢失、无法确认车票信息的，请先行补票。旅客补票后，又找到居民身份证的，列车长确认后开具客运记录交旅客，旅客持客运记录和居民身份证原件到下车站退票窗口退还后补车票，不收退票</p>
								</li>
								<li>
									<p>.在列车上因居民身份证丢失、无法确认车票信息的。</li>
							</ol>
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
					<h1 class="tm-section-title"><font><font>关于我们</font></font></h1>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
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