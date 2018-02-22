<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">

	<head>
		<title>代售点查询</title>
		<!-- for-mobile-apps -->
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="keywords" content="One Movies Responsive web template, Bootstrap Web Templates, Flat Web Templates, Android Compatible web template" />
		<script type="application/x-javascript">
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);

			function hideURLbar() {
				window.scrollTo(0, 1);
			}
			
		</script>
		<!-- //引入了css框架，，引入了一些样式 -->
		<link rel="stylesheet" type="text/css" href="css/Agency.css"/>
		<link rel="stylesheet" href="css/font-awesome.min.css" />
		<link href="css/bootstrap/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/bootstrap/style.css" rel="stylesheet" type="text/css" media="all" />
		<link rel="stylesheet" type="text/css" href="css/pageUpAndDown/base.css" />
		<link rel="stylesheet" type="text/css" href="css/pageUpAndDown/pageGroup.css" />
		<link rel="stylesheet" href="css/news.css" type="text/css" media="all" />
		<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
		<script type="text/javascript">
			var jquery1_8 = $.noConflict();
		</script>
		<script src="js/pageGroup.js" type="text/javascript" charset="utf-8"></script>
		<script src="js/area.js" type="text/javascript" charset="utf-8"></script>
		<!-- js -->
		<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<!-- 引入回到最初的button的js -->
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
			function show(){
				if("${param.s_province}" == null || "${param.s_province}" == ""){
					return;
				}
				$("#s_province").val("${param.s_province}");
				change(1);
				$("#s_city").val("${param.s_city}");
				change(2);
				$("#s_county").val("${param.s_county}");
				queryInfo();
			} 
			function queryInfo() {
				var rowLength = $(".train_table tr").length-1;
				var i=0;
				for(;i<rowLength;i++){
					$("#listContent").remove();
				}
				$.ajax({
					type:"POST",
					url:"agencySelect",
					data:{
						province:$("#s_province").val(),
						city:$("#s_city").val(),
						county:$("#s_county").val()
					},
					dataType:'json',
					success:function(result){
						if(result){
							console.log(result);
							/* alert("成功"); */
						}
						
						if(result != null){
							var i = 0;
							for(;i<result.length;i++){
								var newNode = document.createElement("tr");
								newNode.id = "listContent";
								newNode.innerHTML ="<td>"+i+"</td>"
									+"<td>"+result[i].name+"</td>"
									+"<td>"+result[i].address+"</td>"
									+"<td>"+result[i].workTime+"</td>"
									+"<td>"+result[i].contactInf+"</td>"
									+"<td>"+result[i].detailAddress+"</td>";
								$(".train_table").append(newNode);
							}
						}
					}
				})
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
										<a href="NomalQuestion.html" class="active">常见问题</a>
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
					<a href="first.html"><i class="glyphicon glyphicon-user"> </i>个人中心</a>
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
					height: "toggle",
					'padding-top': 'toggle',
					'padding-bottom': 'toggle',
					opacity: "toggle"
				}, "slow");
			});
		</script>
		<!-- //bootstrap-pop-up -->

		<!-- faq-banner -->
		<div class="faq">
			<div class="container">
				<div class="agileits-news-top">
					<ol class="breadcrumb">
						<li>
							<a href="index.html">主页</a>
						</li>

						<li class="#">代售点查询</li>
					</ol>
				</div>
				<div class="agileinfo-news-top-grids">

					<div id="SearchAgency" class="MySearchAgency">
						<div class="my_layout">
							<label>所在地：</label>
							<select class="s_province" id="s_province" name="s_province"></select>
							<select class="s_city" id="s_city" name="s_city"></select>
							<select class="s_county" id="s_county" name="s_county" ></select>
							<input type="button" id="demandTrainNumberButton" class="my_submit" value="查询" onclick="queryInfo()">
							<script class="resources library" src="js/area.js" type="text/javascript"></script>
							<script type="text/javascript">
								_init_area();
								show();
							</script>
							<div id="show"></div>
						</div> <br/>

						<script type="text/javascript">
							var Gid = document.getElementById;
							var showArea = function() {
								Gid('show').innerHTML = "<h3>省" + Gid('s_province').value + " - 市" +
									Gid('s_city').value + " - 县/区" +
									Gid('s_county').value + "</h3>"
							}
						</script>
						
					</div>
				</div>
				<div class="my_layout2">
					<table class="train_table">
						<tr style="background-color: black; color: #FFFFFF;">
							<th>序号</th>
							<th>代售点名称</th>
							<th>地址</th>
							<th>营业时间</th>
							<th>联系方式</th>
							<th>详细地址</th>

						</tr>
					</table>
				</div>
				<!-------------------------------------------分页----------------------------------------------------------------->
				<!--适用浏览器：IE8、360、FireFox、Chrome、Safari、Opera、傲游、搜狗、世界之窗.-->

				<div id="pageGro" class="cb">
					<div class="pageUp">上一页</div>
					<div class="pageList">
						<ul>
							<li>1</li>
							<li>2</li>
							<li>3</li>
							<li>4</li>
							<li>5</li>
						</ul>
					</div>
					<div class="pageDown">下一页</div>
				</div>

				<!-------------------------------------------END 分页----------------------------------------------------------------->

			</div>
		</div>
		<!-- //faq-banner -->
		<!-- footer -->
		<div class="cuttingLine1">
			<div class="tm-section-header">
				<!--<hr />-->
				<h1 class="tm-section-title">ABOUT US</h1>
			</div>
			<hr style="height:1px;border:none;border-top:1px dashed #0066CC;width: 200px; margin-top: -20PX;" />
			<hr style="height:1px;border:none;border-top:1px dashed #0066CC;width: 200px; margin-top: -20PX; margin-right: -250px;" />

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
		<!-- //footer -->
		<!-- Bootstrap Core JavaScript -->
		
	</body>

</html>