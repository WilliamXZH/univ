<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- head -->

<head>
	<title>车票查询</title>
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
		media="all" />
	<!-- bootstrap-CSS -->
	<link rel="stylesheet" href="css/bootstrap-select.css">
	<!-- bootstrap-select-CSS -->
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<script type='text/javascript' src='js/jquery-2.2.3.min.js'></script>
	<script type="text/javascript" src="js/bootstrap.js"></script>
	<script type="text/javascript" src="js/sand.js"></script>
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
	<script src="js/ticketQueryRelated.js"></script>
	
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
				if(loginId==null||loginId==""){
					$("#personInfo").attr("hidden","hidden");
					$("#logReg").removeAttr("hidden");
				}else{
					$("#logReg").attr("hidden","hidden");
					$("#personInfo").removeAttr("hidden");
					document.getElementById("userName").innerHTML="欢迎您,"+userName;
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
	<!--//meta data-->
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css"
		media="all" />
	<link href="css/style_ticketQuery.css" rel="stylesheet" type="text/css"
		media="all" />
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
</head>
<!-- //head -->

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
									<form action="#" method="post" onsubmit="return validateForm()">
										<input type="text" name="Username" id="Username"
											placeholder="用户名" onkeyup="return checkUserName()"
											maxlength="16">
										<div id="UsernameInfo" class="info"></div>
										<input type="text" name="name" id="name" placeholder="姓名"
											onkeyup="return checkName()" maxlength="5">
										<div id="nameInfo" class="info"></div>
										<input type="password" name="Password" id="Password"
											placeholder="密码" onkeyup="return checkPassword()"
											maxlength="16">
										<div id="PasswordInfo" class="info"></div>
										<input type="password" name="Passwordagain" id="Passwordagain"
											placeholder="密码确认" onkeyup="return checkRepassword()"
											maxlength="16">
										<div id="PasswordagainInfo" class="info"></div>
										<input type="text" name="Email" id="Email" placeholder="邮箱地址"
											onkeyup="return checkEmai()">
										<div id="EmailInfo" class="info"></div>
										<input type="text" name="Phone" id="Phone" placeholder="手机号码"
											onkeyup="return checkPhone()">
										<div id="PhoneInfo" class="info"></div>
										<select class="choice_sth">
											<option value="#" style="text-align: center;">
												<--请选择证件类型--></option>
											<option value="护照">&nbsp;护照</option>
											<option value="身份证">身份证</option>
										</select> <input type="text" name="identifer" id="identifer"
											placeholder="证件号" onkeyup="return checkIdentifer()">
										<div id="identiferInfo" class="info"></div>
										<select class="choice_sth">
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
												<input type="text" name="check" placeholder="验证码">
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
					<a href="NotIndex.html" class="tm-site-name">Logo here</a>
				</div>
				<div class="col-lg-6 col-md-8 col-sm-9">
					<div class="mobile-menu-icon">
						<i class="fa fa-bars"></i>
					</div>
					<nav class="tm-nav" style="width: 700px;">
					<ul>
						<li><a href="NotIndex">主页</a></li>
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

		<div class="w3layouts-login" id="logReg">
			<a data-toggle="modal" data-target="#myModal" href="#"><i class="glyphicon glyphicon-user"> </i>登录/注册</a>

		</div>
		<div class="w3layouts-login" hidden id="personInfo">
			<a href="../userweb/first" id="userName">欢迎您,userName</a> <a href="#"
				id="logOut" onclick="logout123()"><i> </i>注销</a>
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
	<!--mainbody-->
	<div id="presentPath">
		<a href="NotIndex.html">主页</a> <span>/</span> <a href="#">车票查询</a>
	</div>
	<div id="condition">
		<div id="ifBack">
			<input type="radio" name="ifBack" id="tripOnly" onclick="checkBack()" value="oneWay" /><label for="tripOnly">单程票</label>
			<br /> 
			<input type="radio" name="ifBack" id="tripAndBack" onclick="checkBack()" value="roundWay" /><label for="tripAndBack">往返票</label>
			<script>
				window.onload = function judge() {
					var trip = "${param.trip}";
					var departure = "${param.Location}";
					var destination = "${param.Destination}";
					var leaveDate = "${param.leaveDate}";
					var arriveDate = "${param.arriveDate}";
					var trainType = "${param.train}";
					var seatType = "${param.seat}";
					if(trip == "oneWay"){
						alert(1);
						$("#tripOnly").attr("checked","true");
					}else if(trip == "roundWay"){
						alert(2);
						$("#tripAndBack").attr("checked","true");
					}
					$("#citySelect1").val(departure);
					$("#citySelect2").val(destination);
					$("#datepicker").val(leaveDate);
					$("#clender").val(arriveDate);
					if(trainType != "NoLimit"){
						var trainTypes = $("#trainftTable input");
						for(var i=0;i<trainTypes.length;i++){
							if(trainTypes.eq(i).val() == trainType){
								alert(trainTypes.eq(i).val());
								trainTypes.eq(i).attr("checked","true");
							}
						}
					}else{
						$("#train_checkall").click();
					}
					if(seatType != "NoLimit"){
						var seatTypes = $("#seatftTable input");
						for(var i=0;i<seatTypes.length;i++){
							if(seatTypes.eq(i).val() == seatType){
								alert(seatTypes.eq(i).val());
								seatTypes.eq(i).attr("checked","true");
							}
						}
					}else{
						$("#seat_checkall").click();
					}
					if((departure+destination+leaveDate+arriveDate)!=null && 
							(departure+destination+leaveDate+arriveDate)!=""){
						alert(departure+destination+leaveDate+arriveDate);
						query();
					}
					
					
					var ifback = document.getElementsByName("ifBack");
					var length = ifback.length;
					var i = 0;
					for (; i < length; i++) {
						ifback[i].onclick = function() {
							var ticketType = this.value;
							if (ticketType == "oneWay") {
								/* $("#btn1").hide(); */
								$("#btn2").hide();
							} else {
								$("#btn1").show();
								$("#btn2").show();
							}
						};
					}

				}
			</script>
		</div>
		<div id="keyCondition">
			<div id="depart">
				<label>出发地</label> <input name="DPT" id="citySelect1" value="城市名">
			</div>
			<div id="destination">
				<label>目的地</label> <input name="DST" id="citySelect2" value="城市名">
			</div>
			<script type="text/javascript" src="js/cityPicker.js"></script>
			<link rel="stylesheet" href="css/cityPicker.css" />
			<div id="DPTtime">
				<label>出发日期</label> <input type="text" name="DPTtime"
					id="datepicker" readonly="true">
			</div>
			<div id="DSTtime">
				<label>返回日期</label> <input type="text" name="DSTtime" id="clender"
					readonly="true">
			</div>
		</div>
		<div id="queryButton">
			<input type="button" name="ticketQuery" id="ticketQuery"
				onclick="query()" value="查  询" style="width: 100px;" />
		</div>
	</div>
	<div style="clear: both;"></div>
	<div id="filtration">
		<div id="trainftTable">
			<span>列车类型：</span> <input id="train_checkall" type="button"
				name="selectAll" value="全部" style="font-size: 12px;" /> <input
				type="checkbox" name="trainft" class="trainft" value="D" />普通动车 <input
				type="checkbox" name="trainft" class="trainft" value="G" />高速动车 <input
				type="checkbox" name="trainft" class="trainft" value="Z" />直达快速 <input
				type="checkbox" name="trainft" class="trainft" value="T" />特别快速 <input
				type="checkbox" name="trainft" class="trainft" value="P" />普通快速 <input
				type="checkbox" name="trainft" class="trainft" value="C" />城际列车 <input
				type="checkbox" name="trainft" class="trainft" value="L" />临时列车 <input
				type="checkbox" name="trainft" class="trainft" value="N" />管内快速
		</div>
		<div id="seatftTable">
			<span>座位类型：</span> <input id="seat_checkall" type="button"
				name="selectAll" value="全部" style="font-size: 12px;" /> <input
				type="checkbox" name="seatft" class="seatft" value="1" />商务座 <input
				type="checkbox" name="seatft" class="seatft" value="2" />一等座 <input
				type="checkbox" name="seatft" class="seatft" value="3" />二等座 <input
				type="checkbox" name="seatft" class="seatft" value="4" />高级软卧 <input
				type="checkbox" name="seatft" class="seatft" value="5" />软卧 <input
				type="checkbox" name="seatft" class="seatft" value="6" />动卧 <input
				type="checkbox" name="seatft" class="seatft" value="7" />硬卧 <input
				type="checkbox" name="seatft" class="seatft" value="8" />软座 <input
				type="checkbox" name="seatft" class="seatft" value="9" />硬座 <input
				type="checkbox" name="seatft" class="seatft" value="10" />无座
		</div>
	</div>
	<script>
		$("#train_checkall").click(function() {
			var i = 0;
			$("input[name='trainft']").each(function(index, content) {
				if ($(content).attr("checked") == "checked") {
					i++;
				}
			});
			if (i < $("input[name='trainft']").length) {
				$("input[name='trainft']").attr("checked", true);
			} else {
				$("input[name='trainft']").removeAttr("checked");
			}
		});
		$("#seat_checkall").click(function() {
			var i = 0;
			$("input[name='seatft']").each(function(index, content) {
				if ($(content).attr("checked") == "checked") {
					i++;
				}
			});
			if (i < $("input[name='seatft']").length) {
				$("input[name='seatft']").attr("checked", true);
			} else {
				$("input[name='seatft']").removeAttr("checked");
			}
		});
	</script>
	<!--table-->
	<input id="btn1" onclick="btn10()" type="button" value="去程" name="go"
		class="gogogo" />
	<input id="btn2" onclick="btn20()" type="button" value="返程" name="come"
		class="comecome" />
	<div class="search_box">
		<form action="" method="post">

			<div id="search1" class="my_table_first" style="display: block;">
				<table class="table" cellspacing="" cellpadding="">
					<tbody id="trip">

						<tr style="background-color: #000000;">
							<th>车次</th>
							<th>出发时间/到达时间</th>
							<th>始发站/终点站</th>
							<th>耗时</th>
							<th>参考票价</th>
							<th></th>
						</tr>

					</tbody>

				</table>
			</div>
			<div class="my_table_second" id="search2" style="display: none;">
				<table class="table">
					<tbody id="back">
						<tr style="background-color: #000000;">
							<th>车次</th>
							<th>出发时间/到达时间</th>
							<th>始发站/终点站</th>
							<th>耗时</th>
							<th>参考票价</th>
							<th></th>
						</tr>
					</tbody>
				</table>
			</div>
		</form>
		<input type="button" name="choseMyTicket" id="choseMyTicket"
			value="提交" class="ImSure" onclick="submitCheckedInfo()" />

	</div>
	<script type="text/javascript">
		function btn10() {

			document.getElementById('search1').style.display = 'block';
			document.getElementById('search2').style.display = 'none';
			document.getElementById('btn1').style.backgroundColor = '#017EBA';
			document.getElementById('btn1').style.color = 'white';
			document.getElementById('btn2').style.backgroundColor = 'lightgray';
			document.getElementById('btn2').style.color = 'black';
		}

		function btn20() {

			document.getElementById('search2').style.display = 'block';
			document.getElementById('search1').style.display = 'none';
			document.getElementById('btn2').style.backgroundColor = '#017EBA';
			document.getElementById('btn2').style.color = 'white';
			document.getElementById('btn1').style.backgroundColor = 'lightgray';
			document.getElementById('btn1').style.color = 'black';
		}
	</script>
	<!--//table-->
	<!--//mainbody-->
	<!--//header-->
	<div class="cuttingLine1 ">
		<div class="tm-section-header ">
			<div class="col-lg-3 col-md-3 col-sm-3 ">
				<hr>
			</div>
			<div class="col-lg-6 col-md-6 col-sm-6 ">
				<h1 class="tm-section-title " style="font-family: 'century gothic';">ABOUT
					US</h1>
			</div>
			<div class="col-lg-3 col-md-3 col-sm-3 ">
				<hr>
			</div>
		</div>
	</div>
	<!--footer-->
	<footer id="footerContainer">
	<div class="footer ">
		<div class="container ">
			<div class="row ">
				<div class="col-md-4 col-sm-6 col-xs-12 ">
					<div class="quicklinks ">
						<h4 class="footerh ">相关链接</h4>
						<br />
						<ul>
							<li><i class="fa fa-angle-right "></i> <a href="# ">企业差旅索引</a>
							</li>
							<li><i class="fa fa-angle-right "></i> <a href="# ">网络社会征信网</a>
							</li>
							<li><i class="fa fa-angle-right "></i> <a href="# ">加盟合作</a>
							</li>
						</ul>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 col-xs-12 ">
					<div class="quickcontact ">
						<h4 class="footerh ">联系我们</h4>
						<br />
						<ul>
							<li><i class="fa fa-phone "></i> 123456789</li>
							<li><i class="fa fa-envelope "></i> abc@website.com</li>
							<li><i class="fa fa-map-marker "></i> 2B Barcelon, Newyork
								-32011</li>
						</ul>
					</div>
				</div>
				<div class="col-md-4 col-sm-12 col-xs-12 ">
					<div class="follow ">
						<h4 class="footerh ">微信公众号</h4>
						<br /> <img src="images/er_ctrip_wechat.jpg " />
					</div>
				</div>
			</div>
		</div>
	</div>

	<div>
		<div class="row " style="background: white;">
			<div class="col-md-12 ">
				<p style="color: black;">Copyright &copy; 2017.Company name All
					rights reserved.</p>
			</div>
		</div>
	</div>
	<div id="toTopButton "></div>
	</footer>
	<!--//footer-->
	<script>
		//var loginStat = "";
		var base_info = document.getElementById("trip").innerHTML;

		$(function() {
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
</body>

</html>