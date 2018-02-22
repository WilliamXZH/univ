<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Header</title>
	</head>
<body>
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
									<form action="#" method="post" onsubmit="return validateForm()">
													<input type="text" name="Username1" id="Username1" placeholder="用户名">
													<div id="UsernameInfo1" class="info"></div>
													<input type="password" name="Password1" id="Password1" placeholder="密码">
													<div id="PasswordInfo1" class="info"></div>
													<input type="submit" value="登录" onclick="login()">
												</form>
											</div>
											<div class="form">
												<h3>创建新的账户</h3>
												<form action="#" method="post" onsubmit="return validateForm()">
													<input type="text" name="Username" id="Username" placeholder="用户名" onkeyup="return checkUserName()" maxlength="16">
													<div id="UsernameInfo" class="info"></div>
													<input type="text" name="name" id="name" placeholder="姓名"  onkeyup="value=value.replace(/[^\u4E00-\u9FA5]/g,'');return checkName()" onkeyup="value=value.replace(/[ -~]/g,'')"   onkeydown="if(event.keyCode==13)event.keyCode=9"  maxlength="5">
													<div id="nameInfo" class="info"></div>
													<input type="password" name="Password" id="Password" placeholder="密码" onkeyup="return checkPassword()"  maxlength="16">
													<div id="PasswordInfo" class="info"></div>
													<input type="password" name="Passwordagain" id="Passwordagain" placeholder="密码确认" onkeyup="return checkRepassword()"  maxlength="16">
													<div id="PasswordagainInfo" class="info"></div>
													<input type="text" name="Email" id="Email" placeholder="邮箱地址" onkeyup="return checkEmai()">
													<div id="EmailInfo" class="info"></div>
													<input type="text" name="Phone" id="Phone" placeholder="手机号码"  onkeyup="return checkPhone()">
													<div id="PhoneInfo" class="info"></div>
													<select class="choice_sth">
														<option value="#" style="text-align: center;">
															<--请选择证件类型-->
														</option>
														<option value="护照"> &nbsp;护照</option>
														<option value="身份证"> 身份证</option>
													</select>
													<input type="text" name="identifer" id="identifer" placeholder="证件号" onkeyup="return checkIdentifer()">
													<div id="identiferInfo" class="info"></div>
													<select class="choice_sth">
														<option value="#" style="text-align: center;">
															<--请选择乘客类型-->
														</option>
														<option value="学生"> 学生</option>
														<option value="成人"> 成人</option>
														<option value="军人"> 军人</option>
													</select>
													<select class="choice_sth">
														<option value="#" style="text-align: center;">
															<--请选择性别-->
														</option>
														<option value="男"> 男</option>
														<option value="女"> 女</option>
													</select>
													<div id="check_sth">
														<div id="check_number">
															<input type="text" name="check" placeholder="验证码" >
														</div id="check_button">
														<div>
															<input type="submit" value="发送验证码" />
														</div>

													</div>
													<input type="submit" value="注册">
													<input type="checkbox" id="I_agree" />我已经阅读并同意遵守
													<a href="#">《xxx服务条款》
														<a/>
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
						<li><a href="NotIndex.html">主页</a></li>
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
			<a data-toggle="modal" data-target="#myModal" href="#"><i
				class="glyphicon glyphicon-user"> </i>登录/注册</a>
			
		</div>
		<div class="w3layouts-login" hidden id="personInfo">
			<a href="../userweb/first"><i
				class="glyphicon glyphicon-user"> </i>欢迎您,${user.userName }</a>
			<a  href="#" id="logOut" onclick="logout123()"><i
				> </i>注销</a>
		</div>
	</div>
	<script type="text/javascript">
		testIfLogin();
	</script>
	<!--/banner/-->
</body>
</html>