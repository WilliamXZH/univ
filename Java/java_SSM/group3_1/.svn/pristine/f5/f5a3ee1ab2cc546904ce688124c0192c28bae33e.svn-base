<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String basePath=request.getScheme() + "://" +
	request.getServerName() + ":" + request.getServerPort() +
	request.getContextPath() + "/"; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

	<head>
		<title>车次查询</title>
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
		<link href="css/QueryForTrain.css" rel="stylesheet" type="text/css" />
		<link href="css/font-awesome.min.css" rel="stylesheet" />
		<!-- <link href="css/test.css" rel="stylesheet" type="text/css" media="all" /> -->
		<link href="css/bootstrap/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/bootstrap/style.css" rel="stylesheet" type="text/css" media="all" />
		<link href="css/pageUpAndDown/base.css" rel="stylesheet" type="text/css" />
		<link href="css/pageUpAndDown/pageGroup.css" rel="stylesheet" type="text/css" />
		<link href="css/news.css" rel="stylesheet" type="text/css" media="all" />
		<script type="text/javascript" src="js/jquery-1.8.3.min.js"></script>
		<script type="text/javascript">
			var jquery1_8 = $.noConflict();
		</script>
		<script src="js/pageGroup.js" type="text/javascript" charset="utf-8"></script>
		<!-- js -->
		<script type="text/javascript" src="js/jquery-2.1.4.min.js"></script>
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
			window.onload=function(){
				var date = '${param.date}';
				var trainId = '${param.trainId}'
				if(!(date == null || date == "")){
					var formatDate = date.split('/')[2]+"-"+date.split('/')[0]+"-"+date.split('/')[1];
					$(".my_Data").val(formatDate);
				};
				if(!(trainId == null || trainId == "")){
					$(".my_trainNum").val(trainId);
				}
				if($(".my_Data").val()=="" || $(".my_trainNum").val()==""){
					return;
				}
				submit();
			}
			function submit(){
				var rowLength = $("#list tr").length-1;
				var i=0;
				for(;i<rowLength;i++){
					$("#listContent").remove();
				}
				var serialNum = document.getElementById("serialNum").value;
				var dDate = document.getElementById("bdDate").value;
				var deDate = dDate.replace("/","-");
				$.ajax({
					type:"POST",
					url:"queryTrainInfo",
					data:{
						serialNum :serialNum,
						bdDate:deDate
					},
					dataType :"json",
					success:function(result){
						console.log(result);
						var i = 0;
						if(result.resultList == null){
							alert(result.errorInfo);
						}else{
							for(;i<result.resultList.length;i++){
								var newNode = document.createElement("tr");
								newNode.id = "listContent";
								newNode.innerHTML ="<td>"+i+"</td>"
									+"<td>"+result.resultList[i].station.name+"</td>"
									+"<td>"+result.resultList[i].arvTime+"</td>"
									+"<td>"+result.resultList[i].lvTime+"</td>"
									+"<td>"+result.resultList[i].timeDiffer+"</td>"
									+"<td></td>";
								document.getElementById("list").appendChild(newNode);
							}
						}
					},
					error:function(){
						alert("error");
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

						<li class="#">常见问题</li>
					</ol>
				</div>
				<div class="agileinfo-news-top-grids">

					<div id="SearchTrain" class="MySearchTrain">
						<div class="my_layout">
							<span>日期:</span><input type="date" id="bdDate" name="my_data_show" class="my_Data" />
							<span class="name">车次号:</span> <input id="serialNum" type="text" name="train_num" class="my_trainNum" />
							<input onclick="submit()" type="button" id="demandTrainNumberButton" class="my_submit" value="查询">

						</div>
					</div>
					<div class="my_layout2">
						<table  id="list" class="train_table">
							<tr style="background-color: black; color: #FFFFFF;">
								<th>站序</th>
								<th>车站</th>
								<th>入站时间</th>
								<th>出站时间</th>
								<th>停留时间</th>
								<th>其他</th>

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
			<script src="js/bootstrap.min.js"></script>
	</body>

</html>