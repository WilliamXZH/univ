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
        <script type="text/javascript" src="js/LogReg-validation.js"></script>
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
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="keywords" content="" />
		<script type="application/x-javascript">
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);
			
			function convert(str){
				var strs = new Array();
				strs = str.split("/");
				var res = strs[2]+'-'+strs[0]+'-'+strs[1];
				return res;
			}

			function hideURLbar() {
				window.scrollTo(0, 1);
			}
			
			var loginId = "${id}";
			var userName = "${userName}";
			function testIfLogin(){
				//var loginStat = "${sessionScope.loginStat}";
				console.log(loginId+":"+"${id}"+':'+'${userName}');
				//alert(userName);
				if(loginId==null||loginId==""){
					$("#personInfo").attr("hidden","hidden");
					$("#logReg").removeAttr("hidden");
				}else{
					$("#logReg").attr("hidden","hidden");
					$("#personInfo").removeAttr("hidden");
					document.getElementById("loginUserName").innerHTML="欢迎您,"+userName;
				}
			}
			function login() {
				//console.log(1);
				var message = document
						.getElementById("Username1").value;
				var password = document
						.getElementById("Password1").value;
				console.log(message+":"+password);
				//$(".modal-backdrop").remove();
				//$(".modal").hide();
				//$(".modal").attr("class","modal video-modal fade");
				//$(".modal").attr("style","display: none");										
				//$(".modal").attr("aria-hidden",true);
				//$("body").attr("class","");
				//$("body").attr("style","");
				$.ajax({
					type : "POST",
					url : "userLogin",
					data : "message="
							+ message
							+ "&password="
							+ password,
					success : function(user) {
						console.log(user);
						if (user.id == null) {
							document.getElementById("UsernameInfo1").innerHTML = "用户名或密码不正确,请检查后重新输入";
						} else {
							//console.log("user logined!" + user.userName);
							$(".close").click();
							$(".modal-backdrop").hide();
							//loginStat = user.id;
							//location.reload();
							loginId = user.id;
							userName = user.userName;
							testIfLogin();
							//window.location.reload();
						}
						//$(".modal-dialog").attr("hidden","hidden");
					},
					error : function() {
						alert("error!");
					}
				}) 
			}
			
			function logout123(){
				$.ajax({
					type : "POST",
					url : "userLogout",
					success:function(){
						//loginStat=0;
						//location.reload();
						loginId = "";
						testIfLogin();
					},
					error:function(){
						alert("logout failed:");
					}
				})
			}
			
			function register(){
				$.ajax({
					type:"POST",
					url:"../main/userRegister",
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
					},
					error:function(){
						alert("注册失败！");
					}
				})
			}


			function submitCheckedInfo(){
				
				var ifLogined = loginId;
				if(ifLogined==""){
					alert("please login first!");
					return;
				}
				
				//alert("!!!"+ifLogined);
				var tripInfo;
				var backInfo;
				
				var tripRadios = $("#trip tr td input");
				var backRadios = $("#back tr td input");
				
				for(var i=0;i<tripRadios.length;i++){
					if(tripRadios[i].checked==true){
						tripInfo = tripRadios[i].value;
					}
				}
				
				for(var j=0;j<backRadios.length;j++){
					if(backRadios[j].checked==true){
						backInfo = backRadios[j].value;
					}
				}
				
			/*	var info = "{";
				if(tripInfo!=undefined)info += "\"trip\":"+tripInfo;
				if(backInfo!=undefined)info += ",\"back\":"+backInfo;
				info += "}";
				console.log(JSON.parse(info));
				alert(info);*/
				
				var info = "";
				if(tripInfo==undefined){
					alert("请选择去程车次和座位类型！");
				}else{
					info += tripInfo;
					
					var tripAndBack = document.getElementById("tripAndBack");
					if(tripAndBack.checked==true){
						if(backInfo==undefined){
							alert("请选择返程车次和座位类型！");
						}else{
							info += "#"+backInfo;
						}
					}
				}
				
				window.location.href="../purchase/ticketPurchase?method=post&info="+info;
				
			}
	
	</script>
		
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

		<script type="text/javascript" src="js/sand.js"></script>
	</head>
	<!-- //head -->
	<!-- body -->

	<body>
			<!--header-->
	<header id="header">

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
									<i class="fa fa-times fa-pencil"
										style="position: relative; top: 9px;"></i>
									<div class="tooltip">点我切换</div>
								</div>
								<div class="form">
									<h3>登录现有账号</h3>
									<form action="#" method="post">
										<input type="text" name="Username1" id="Username1"
											placeholder="用户名" onkeyup="checkUserName1()">
										<div id="UsernameInfo1" class="info"></div>
										<input type="password" name="Password1" id="Password1"
											placeholder="密码" onkeyup="checkPassword1()">
										<div id="PasswordInfo1" class="info"></div>
										<input type="button" value="登录" onclick="validateForm1()">
									</form>
								</div>
								<div class="form">
									<h3>创建新的账户</h3>
									<form  method="post" onsubmit="return validateForm()" >
													<input type="text" name="id" id="id" placeholder="用户名" onkeyup="return checkUserName()" maxlength="16">
													<div id="UsernameInfo" class="info"></div>
													<input type="text" name="userName" id="userName" placeholder="姓名"  onkeyup="return checkName()" >
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
															<input type="text" name="check" placeholder="验证码" maxlength=4>
														</div>
														<div  id="check_button">
															<input type="button" value="发送验证码" style="width:120px"/>
														</div>

													</div>
													<input type="button" value="注册" onclick="register()" >
													<input type="checkbox" id="I_agree" />我已经阅读并同意遵守
													<a href="#">《xxx服务条款》
														</a>
												</form>
								</div>
								<div class="cta">
									<a href="../userweb/findMissing">忘记密码了？</a>
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
					<a href="#" class="tm-site-name"><img src="images/logo2.jpg" style="position: relative;top: -25px;left:100px"></a>
				</div>
				<div class="col-lg-6 col-md-8 col-sm-9">
					<div class="mobile-menu-icon">
						<i class="fa fa-bars"></i>
					</div>
					<nav class="tm-nav" style="width: 700px;">
					<ul>
						<li><a class="active" href="../main/NotIndex">主页</a></li>
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

		<div class="w3layouts-login" id="logReg">
			<a data-toggle="modal" data-target="#myModal" href="#"><i class="glyphicon glyphicon-user"> </i>登录/注册</a>

		</div>
		<div class="w3layouts-login" hidden id="personInfo">
			<a href="../userweb/first" id="loginUserName">欢迎您,userName</a> <a href="#"	id="logOut" onclick="logout123()" style="relative;left:-40px;top:-13px"><i> </i>注销</a>
		</div>
	</div>
	<script type="text/javascript">
		testIfLogin();
	</script> <!--/banner/--> <script type="text/javascript">
		//$("#header").load("../head/header");

		/*  			var ajaxobj=new AJAXRequest;    // 创建AJAX对象,类在刚刚那个文件里了
		 ajaxobj.method="GET";   // 设置请求方式为GET
		 ajaxobj.url="../head/header"  // 响应的URL,以后可以改为一些动态处理页,会用Ajax的都知道，这在页里可以有目的返回不同的数据
		 // 设置回调函数，输出响应内容,因为是静态页（这是我的需求嘛）所以所有内容都过来了
		 ajaxobj.callback=function(xmlobj) {
		 document.getElementById('header').innerHTML = xmlobj.responseText;     //可要看好这句话哦
		 }
		 ajaxobj.send();    // 发送请求  */
	</script> </header>
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
		

		<!-- Reservation box -->
		<div class="cuttingLine">
			<div class="tm-section-header">
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
				<div class="col-lg-6 col-md-6 col-sm-6">
					<h1 class="tm-section-title" style="font-family:'century gothic';">WHAT'S NEW</h1></div>
				<div class="col-lg-3 col-md-3 col-sm-3">
					<hr>
				</div>
			</div>
		</div>
		<!--body-->

		<div id="main_body">
			<div id="routemap">
				<div id="map" style="height: 1000px;"></div>
				<script type="text/javascript" src="js/Map.js" ></script>
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
					<h1 class="tm-section-title" style="font-family:'century gothic';">ABOUT US</h1></div>
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

</html>