<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <% String basePath=request.getScheme() + "://" +
request.getServerName() + ":" + request.getServerPort() +
request.getContextPath() + "/"; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<title>历史订单</title>
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
		<!--kim-->
		<script src="js/jquery-2.1.4.min.js" type="text/javascript" ></script>
		<link href="css/test.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/ChangeInfo.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/font-awesome.min.css" rel="stylesheet" />
		<link href="css/personInfo.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
		<link href="news-css/news.css" rel="stylesheet" type="text/css" media="all" />
		<!-- js -->
		<link href="css/orderDetail.css" type="text/css" rel="stylesheet" />
		<link href="css/pageUpAndDown/pageGroup.css" rel="stylesheet" type="text/css" />
		<link href="css/pageUpAndDown/base.css" rel="stylesheet" type="text/css" />
		<script src="js/jquery-1.8.3.min.js" type="text/javascript" ></script>
		<script type="text/javascript">
			var jquery1_8 = $.noConflict();
		</script>
		<!-- <script src="js/pageGroup.js" type="text/javascript" charset="utf-8"></script> -->
		
		<!-- 引入回到最初的button的js -->
		<script src="js/sand.js" type="text/javascript"></script>
		<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event) {
					event.preventDefault();
					$('html,body').animate({
						scrollTop: $(this.hash).offset().top
					}, 1000);
				});
			});
		</script>
		<script type="text/javascript">
			function hiddenOrShown(arrow) {
				if(arrow.id == 'arrowUp') {
					/*alert('up');*/
					arrow.style.display = 'none';
					document.getElementById("arrowDown").style.display = 'inline';
					document.getElementById("contentDetial").style.display = 'table';
					document.getElementById('table_header').style.borderBottom = 0;
				} else if(arrow.id = 'arrowDown') {
					/*alert('down');*/
					arrow.style.display = 'none';
					document.getElementById("arrowUp").style.display = 'inline';
					document.getElementById("contentDetial").style.display = 'none';
					document.getElementById('table_header').style.border = '1px solid black';
				}
			}
		</script>
		<!-- start-smoth-scrolling -->
		<script type="text/javascript">
			function submit(){
				var rowLength = $("#contentDetial tr").length-1;
				var i=0;
				for(;i<rowLength;i++){
					$("#listContent").remove();
				}
				var way = document.getElementById("select_cxfs").value;
				var condition = document.getElementById("form-control").value;
				var start = document.getElementById("CFromDate").value;
					start = start.replace("/","-");
				var end = document.getElementById("CToDate").value;
					end = end.replace("/","-");
				alert(start+end);
				$.ajax({
					type:"POST",
					url:"selectOrder",
					data:{
						type :"historical",
						way :way,
						condition :condition,
						start :start,
						end :end
					},
					dataType :"json",
					/* contentType :"charset=UTF-8", */
					success:function(result){
						console.log(result);
						if(result == null){
							alert("刘宇");
						}else{
							showData(initPage(result));
						}
					}
				})
			}
			function showData(result){
				for(var i=0;i<result.length;i++){
					var newNode = document.createElement("tr");
					newNode.id = "listContent";
					newNode.innerHTML =
						"<td>"+(i+1)+"</td>"+
						"<td>"+result[i].orderId+"</td>"+
						"<td>"+
							"<span id='startTime'>"+result[i].departTime+"</span><br />"+
							"<span id='carInf'>"+result[i].trainName+"</span><br />"+
							"<span id='placeInf'>"+result[i].depature+"-"+result[i].destination+"</span>"+
						"</td>"+
						"<td style='word-break:break-all;' id='seatInf'>"+
							"<span>"+
								result[i].carriage+"<br/>"+result[i].seat+"<br/>"+
							"</span>"+
						"</td>"+
						"<td id='traveler'>"+result[i].userName+"</td>"+
						"<td id='ticket-cost'>"+result[i].ticketType+"<br/>"+result[i].cost+"<br/>"+result[i].payMethod+"</td>"+
						"<td ticket-condition>"+"</td>"+
						"<td action-able>"+result[i].orderTime+"</td>";
					document.getElementById("contentDetial").appendChild(newNode);
				} 
			}
		</script>
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
									<li class="new_subtitle"><a class="my_a"href="<%=basePath %>userweb/NumberSafe">账号安全</a></li>
									<li class="new_title">常用联系人管理</li>
									<li class="new_subtitle">
										<a class="my_a"href="<%=basePath %>userweb/partnerSelect">常用联系人</a>
									</li>
									<li class="new_subtitle"><a class="my_a"href="<%=basePath %>userweb/Suggest">建议与投诉</a></li>
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
							<div id="HistoryList">
								<div id="subTitle">历史订单</div>
								<!--查询组件-->
								<div id="chaxun">
									<ul style="width: 775px;">
										<li>
											<select name="select" id="select_cxfs" class="chaxun">
												<option id="TakeDate" value="2">乘车日期</option>
												<option id="BuyDate" value="1">购票日期</option>
											</select>
										</li>
										<li><input id="CFromDate" class="chaxun" type="date" /></li>
										<li><input id="CToDate" class="chaxun" type="date" /></li>
										<li><input id="form-control" type="text" class="chaxun" placeholder="订单号/车次/乘客姓名" /></li>
										<li><input id="LDDCX" type="button" class="chaxun" value="查 询"  onclick="submit()"/></li>
									</ul>
								</div>
								<!--一条订单信息具体内容-->
								<div id="contentAList">
									<!--设置table样式-->
									<table id="table_header" style="border:1px solid black; border-bottom: 0;">
										<!--一条订单信息头部-->
										<tr class="contentHeadTr">
											<td colspan="7">
												<img id="arrowUp" class="arrow" src="images/arrowup.png" onclick="hiddenOrShown(this)" style="display: none;" />
												<img id="arrowDown" class="arrow" src="images/arrowdown.png" onclick="hiddenOrShown(this)" style="display: inline;" />
												<span>订单详情</span>
											</td>
										</tr>
									</table>
									<table id="contentDetial"  border="0" cellspacing="0" cellpadding="0" style="table-layout:fixed;">
										<!--一条订单的具体列名字-->
										<tr id="name" style="background-color: #121212;color: white;opacity: 0.8;border-radius: 0;">
											<td>序号</td>
											<td>订单号</td>
											<td>车次信息</td>
											<td>席位信息</td>
											<td>旅客信息</td>
											<td>票额金额</td>
											<td>车票状态</td>
											<td>购票日期</td>
										</tr>								
								</table>
							</div>

								<!-------------------------------------------分页----------------------------------------------------------------->
								<!--适用浏览器：IE8、360、FireFox、Chrome、Safari、Opera、傲游、搜狗、世界之窗.-->
								<div id="pageGro" class="cb">
									<div class="pageUp" id="prePage">上一页</div>
									<div class="pageList" >
										<ul>
											<!-- <li>1</li>
											<li>2</li>
											<li>3</li>
											<li>4</li>
											<li>5</li> -->
										</ul>
									</div>
									<div class="pageDown" id="postPage">下一页</div>
								</div>
								<!-------------------------------------------END 分页----------------------------------------------------------------->

							</div>
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
		<script src="js/page.js" type="text/javascript" charset="utf-8"></script>

	</body>

</html>