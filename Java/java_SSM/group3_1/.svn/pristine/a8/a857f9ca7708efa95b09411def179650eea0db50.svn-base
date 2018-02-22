<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<head>
<title>退票</title>
<link href="css/bootstrap.css" rel='stylesheet' type='text/css' />

<link href="css/refund.css" rel='stylesheet' type='text/css' />
<!-- Custom Theme files -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
<!-- Custom Theme files -->
<script src="js/jquery.min.js"></script>
<script src="js/bootstrap.min.js"></script>
<!-- Custom Theme files -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords"
	content="My Show Responsive web template, Bootstrap Web Templates, Flat Web Templates, Andriod Compatible web template, 
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
<link href='#css?family=Oxygen:400,700,300' rel='stylesheet'
	type='text/css'>
<link href='#css?family=Open+Sans:400,300,600,700,800' rel='stylesheet'
	type='text/css'>
<!-- start menu -->

<link rel="stylesheet" href="css/style_nav.css" rel="stylesheet"
	type="text/css" media="all" />
<link rel="stylesheet" href="css/news-nav.css" rel="stylesheet"
	type="text/css" media="all" />
<link rel="stylesheet" href="css/passengerInfo_css.css" />
<link rel="stylesheet" href="css/common_css.css" />

<link href="css/megamenu.css" rel="stylesheet" type="text/css"
	media="all" />
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
			type : 'default', //Types: default, vertical, accordion           
			width : 'auto', //auto or any width like 600px
			fit : true
		// 100% fit in a container
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
				scrollTop : $(this.hash).offset().top
			}, 1200);
		});
	});
</script>
<!---- start-smoth-scrolling---->
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
	function submit2() {
		var Train_id = document.getElementById("Train_Num").innerHTML;
		var orderNum_id = document.getElementById("mynum").innerHTML;
		var seat_id = document.getElementById("seatid").innerHTML;
		var start_id = document.getElementById("start").innerHTML;
		var destation_id = document.getElementById("destation").innerHTML;
		$.ajax({
			type : "post",
			url : "refundticket",
			data : "seatid=" + seat_id + "&startid=" + start_id
					+ "&destationid=" + destation_id + "&orderNumid="
					+ orderNum_id + "&Trainid=" + Train_id,
			success : function() {
				alert("succeed!");
			},
			error : function() {
				alert("error!");
			}
		})
	}
</script>
</head>

<body>
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
							<li><a href="#" class="">主页</a></li>
							<li><a href="NomalQuestion.html">常见问题</a></li>
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
			<a data-toggle="modal" data-target="#myModal" href="#"><i
				class="glyphicon glyphicon-user"> </i>个人中心</a>
		</div>
	</div>
	<div class="faq">
		<div class="container">
			<div class="agileits-news-top">
				<ol class="breadcrumb">
					<li><a href="index.html">主页</a></li>
					<li><a href="#">查询</a></li>
					<li><a href="#">个人中心</a></li>
					<li><a href="#">未出行订单</a></li>

					<li class="active">退票成功</li>
				</ol>
			</div>
		</div>
	</div>

	<div class="content" style="min-height: 445px;">
		<!--支付提示 开始-->
		<div class="t-succ tp-over">
			<div class="pay-tips mb40">
				<span class="i-success"></span>
				<div class="greet">
					<strong>退票成功！</strong> 业务流水号： <span class="colorA" id ="mynum"  name="myNum"></span>
				</div>
				<br clear="none">
				<div class="greet">

					<label class="title_sty1">乘车日期：</label>
					<span class="fontcolor1"id="DepartureDate" name="DepartureDate"></span>
					<label class="title_sty">车次：</label>
					<span class="fontcolor"id="Train_Num" name="Train_Num"></span> 
					<label class="title_sty">票款原价：</label>
					<span class="fontcolor" id="original_cos" name="original_cos"></span>
					 <br /> 
					 <label class="title_sty2">退款手续费：</label>
					 <span class="fontcolor" id="Handling_charge" name="Handling_charge"></span>
					 <label class="title_sty">总计退款：</label>
					 <span class="fontcolor" id="total_money" name="total_money"></span>
					<label >出发地：</label>
					<label id ="start"  name="start" ></label>
					<label >目的地：</label>
					<label  id ="destation"  name="destation" ></label>
                    <label >座位id：</label>
                    <label  id ="seatid"  name="seatid" ></label>
				</div>
				<div class="lay-btn">
					<input type="submit"  class="mybutton1" value="确定" onclick="submit2()"/>
					<input type="button" class="mybutton2" value="继续购票"/>
				</div>
				<p class="tips">
					1. 应退款项按银行规定时限退还至购票时所使用的网上支付工具账户，请注意查询，如有疑问请致电12306人工客服查询。<br
						clear="none"> 2.
					如您需要退票费报销凭证，请凭购票所使用的乘车人有效身份证件原件和订单号码在办理退票之日起10日内到车站退票窗口索取。<br
						clear="none"> 3. 退票成功后，将向您注册时提供的邮箱和手机发送退票信息，请稍后查询。
				</p>
			</div>
			<!--支付提示 结束-->
		</div>
		<div class="cuttingLine1">
			<div class="tm-section-header">
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6">
					<h1 class="tm-section-title" style="font-family: 'century gothic';">ABOUT
						US</h1>
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
									<h4 class="footerh">
										<font><font>相关链接</font></font>
									</h4>
									<br>
									<ul>
										<li><i class="fa fa-angle-right"></i> <a href="#"> <font>
													<font>企业差旅索引</font>
											</font>
										</a></li>
										<li><i class="fa fa-angle-right"></i> <a href="#"> <font>
													<font>网络社会征信网</font>
											</font>
										</a></li>
										<li><i class="fa fa-angle-right"></i> <a href="#"> <font>
													<font>加盟合作</font>
											</font>
										</a></li>
									</ul>
								</div>
							</div>
							<div class="col-md-4 col-sm-6 col-xs-12">
								<div class="quickcontact">
									<h4 class="footerh">
										<font><font>联系我们</font></font>
									</h4>
									<br>
									<ul>
										<li><i class="fa fa-phone"></i> <font> <font>
													123456789</font>
										</font></li>
										<li><i class="fa fa-envelope"></i> <font> <font>
													abc@website.com</font>
										</font></li>
										<li><i class="fa fa-map-marker"></i> <font> <font>
													2B Barcelon，纽约-32011</font>
										</font></li>
									</ul>
								</div>
							</div>
							<div class="col-md-4 col-sm-12 col-xs-12">
								<div class="follow">
									<h4 class="footerh">
										<font><font>微信公众号</font></font>
									</h4>
									<br> <img src="images/er_ctrip_wechat.jpg">
								</div>
							</div>
						</div>
					</div>
				</div>

				<div>
					<div class="row" style="background: white;">
						<div class="col-md-12">
							<p style="color: black;">
								<font> <font>版权所有©2017.公司名称保留所有权利。 </font>
								</font>
							</p>
						</div>
					</div>
				</div>
				<div id="toTopButton"></div>
			</footer>
</body>
<script type="text/javascript">
	window.onload=function(){
		getOrder();
	}
	Date.prototype.diff = function(date){
		  return (this.getTime() - date.getTime())/(24 * 60 * 60 * 1000);
		}	
	function getOrder(){
		<%String a = request.getParameter("orderId");%>
		var ordernum = <%=a%>;
		$.ajax({
			type:"post",
			url:"refundticketqqwe",
			dataType:"json",
			data:"orderNum="+ordernum,
			success:function(result){
				var totalmoney=0;
				var handelMoney=0;
				var myData =$("#DepartureDate").text(result.departTime).text();
				var mycos =$("#original_cos").text(result.cost).text();
				var now = new Date();
				var date = new Date(myData);				
				var diff = now.diff(date);	
				//alert(-diff);
				var diff2=-diff;
				if(diff2>15){
					handelMoney=0;
					totalmoney=mycos;
				}else if(2<diff2<=15){
					handelMoney=mycos*0.05;
					totalmoney=mycos-mycos*0.05;
				}else if(1<diff2<=2){
					handelMoney=mycos*0.1;
					totalmoney=mycos-mycos*0.1;
				}else{
					handelMoney=mycos*0.2;
					totalmoney=mycos-mycos*0.2;
				}				
				console.log(result);
				$("#seatnum").text(result.seatNum);
				$("#mynum").text(result.id);
				$("#DepartureDate").text(result.departTime);
				$("#original_cos").text(result.cost);
				$("#Train_Num").text(result.trainId);
				$("#Handling_charge").text(handelMoney);
				$("#total_money").text(totalmoney);
				$("#start").text(result.depatureId);
				$("#destation").text(result.destinationId);
				$("#seatid").text(result.seat_Ids);
			//	alert("succeed!");
			},
			
			error:function(){
				alert("failed!");
			}
		})
	}
	
</script>

</html>