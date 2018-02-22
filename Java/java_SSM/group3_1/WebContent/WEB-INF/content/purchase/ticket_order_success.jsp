<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <% String basePath=request.getScheme() + "://" +
request.getServerName() + ":" + request.getServerPort() +
request.getContextPath() + "/"; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<title>Ticket Order Success</title>
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
		<link rel="stylesheet" href="css/passengerInfo_css.css" />
		<link rel="stylesheet" href="css/common_css.css" />

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
								<li>
									<a href="../userweb/NomalQuestion">å¸¸è§é®é¢</a>
								</li>
								<li>
									<a href="tours.html">éè·¯å¸¸è¯</a>
								</li>
								<li>
									<a href="zcfc">ç«è½¦é£é</a>
								</li>
								<li>
									<a href="warmService">æ¸©é¦¨æå¡</a>
								</li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
			<!--//logo-->
			<div class="w3layouts-login">
					<a  href="../userweb/first"><i class="glyphicon glyphicon-user"> </i>个人中心</a>
		</div>
		<div class="faq">
			<div class="container">
				<div class="agileits-news-top">
					<ol class="breadcrumb">
						<li><a href="../main/NotIndex" >主页</a></li>
						<li>
							<a href="../queryInfo/QueryForTrain">æ¥è¯¢</a>
						</li>
						<li>
							<a href="ticketPurchase">è´­ç¥¨</a>
						</li>
						<li>
							<a href="ticketOrderConfirm">è®¢åç¡®è®¤</a>
						</li>
						<li>
							<a href="ticket-payment">æ¯ä»</a>
						</li>
						<li class="active">æ¯ä»æå</li>
					</ol>
				</div>
			</div>
		</div>

		<div class="content" style="min-height: 445px;">
			<!--æ¯ä»æç¤º å¼å§-->
			<div class="t-succ tp-over">
				<div class="pay-tips mb40"><span class="i-success"></span>
					<div class="greet"><strong>è®¢ç¥¨æåï¼</strong> ä¸å¡æµæ°´å·ï¼
						<span class="colorA">2E857296688001001084515293</span>
					</div>
					<br clear="none">
					<div class="greet">
						ä¹è½¦æ¥æï¼<span class="colorA">2017å¹´07æ08æ¥</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; è½¦æ¬¡ï¼
						<span class="colorA">D7741</span>
						<br clear="none"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; æ»éé¢ï¼<span class="colorA">4.0å</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

						<br clear="none"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					</div>
				</div>
				<div class="lay-btn">
					<a href="#" id="continue_pay_ticket" class="btn122" shape="rect">ç»§ç»­è´­ç¥¨</a>
					<a href="#" id="query_my_order" class="btn122s" shape="rect">æ¥è¯¢è®¢åè¯¦æ</a>
				</div>
				<p class="tips">
					1. åºéæ¬¾é¡¹æé¶è¡è§å®æ¶ééè¿è³è´­ç¥¨æ¶æä½¿ç¨çç½ä¸æ¯ä»å·¥å·è´¦æ·ï¼è¯·æ³¨ææ¥è¯¢ï¼å¦æçé®è¯·è´çµ12306äººå·¥å®¢ææ¥è¯¢ã<br clear="none"> 2. å¦æ¨éè¦éç¥¨è´¹æ¥éå­è¯ï¼è¯·å­è´­ç¥¨æä½¿ç¨çä¹è½¦äººææèº«ä»½è¯ä»¶åä»¶åè®¢åå·ç å¨åçéç¥¨ä¹æ¥èµ·10æ¥åå°è½¦ç«éç¥¨çªå£ç´¢åã<br clear="none"> 3. éç¥¨æååï¼å°åæ¨æ³¨åæ¶æä¾çé®ç®±åææºåééç¥¨ä¿¡æ¯ï¼è¯·ç¨åæ¥è¯¢ã
				</p>
			</div>
			<!--æ¯ä»æç¤º ç»æ-->
		</div>
		<div class="cuttingLine1">
			<div class="tm-section-header">
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6">
					<h1 class="tm-section-title"><font><font>å³äºæä»¬</font></font></h1>
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
								<h4 class="footerh"><font><font>ç¸å³é¾æ¥</font></font></h4>
								<br>
								<ul>
									<li><i class="fa fa-angle-right"></i>
										<a href="#">
											<font>
												<font>ä¼ä¸å·®æç´¢å¼</font>
											</font>
										</a>
									</li>
									<li><i class="fa fa-angle-right"></i>
										<a href="#">
											<font>
												<font>ç½ç»ç¤¾ä¼å¾ä¿¡ç½</font>
											</font>
										</a>
									</li>
									<li><i class="fa fa-angle-right"></i>
										<a href="#">
											<font>
												<font>å çåä½</font>
											</font>
										</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="quickcontact">
								<h4 class="footerh"><font><font>èç³»æä»¬</font></font></h4>
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
											<font> 2B Barcelonï¼çº½çº¦-32011</font>
										</font>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-md-4 col-sm-12 col-xs-12">
							<div class="follow">
								<h4 class="footerh"><font><font>å¾®ä¿¡å¬ä¼å·</font></font></h4>
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
								<font>çæææÂ©2017.å¬å¸åç§°ä¿çæææå©ã
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
				/*
							var defaults = {
					  			containerID: 'toTop', // fading element id
								containerHoverID: 'toTopHover', // fading element hover id
								scrollSpeed: 1200,
								easingType: 'linear' 
					 		};
							*/

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