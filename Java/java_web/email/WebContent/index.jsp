<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
	<head>
		<meta charset="urf-8">
		<meta name="Keywords" content="">
		<meta name="Description" content="">
		<style type="text/css">
			*{
				margin:0;
				padding:0;
			}
			body{background:url("images/bg.jpg");background-size:cover;}
			.box{background:#00ffff;}
			.box .content{width:1000px;height:60px;background:#cc3300;margin:auto;}
			.box .content span{font-size:20px;font-weight:700px;float:right;line-height:62px;}

			.center{width:640px;height:350px;margin:60px;/*background:#33ff66;*/}
			.center p span{font-size:16px;line-height:50px;}
			.center .c-con{width:510px;height:30px;}
			.center .c-text{width:510px;height:144px;}
			.center .c-btn{width:510px;height:40px;margin-left:64px;border:none;outline:none;font-size:16px;border-radius:4px;box-shadow:1px 1px 4px #000;}
			.center .c-btn:hover{background:-webkit-repeating-linear-gradient(45deg,#fff 10px,#eee 20px,#eee 30px,#fff 40px);border-radius:20px;transition:0.3s;animation:bg 10s linear infinite;}
			/*	定义关键帧		*/
			@keyframe bg{
				from{background-position:0 0;}
				to{background-position:1000px 0;}
			}

		</style>
	</head>
	<body>
		<!-- start box -->
		<div class="box">
			<div class="content">
				<!-- img图片标签四要素：src路径 width height alt 浏览器渲染 快0.3s alt优化 -->
				<img src="images/logo.gif">
				<span>Java开发邮件群发系统</span>
			</div>
		</div>
		<!-- end box -->

		<!-- start center -->
		<form action="/mail" method="post">
		<div class="center">
			<p>
				<span>收件人：</span><input type="text" class="c-con" name="m_name">
			</p>
			<p>
				<span>主&emsp;题：</span><input type="text" class="c-con" name="m_topic">
			</p>
			<p>
				<span>正&emsp;文：</span><input type="text" class="c-text" name="m_con">
			</p>
			<input type="submit" value="发送邮件" class="c-btn">

		</div>
		</form>
	</body>
</html>