<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>User Login</title>
		<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
		<style type="text/css">
			#info{
				border:solid 1px black;
			}
		</style>
	</head>
	<body>
		<div id="form">
			<form action="userLogin" method="post" >
				<input type="text" name="message"/><br/>
				<input type="text" name="password"/><br/>
				<input type="submit" value="login"/>
				&nbsp;&nbsp;&nbsp;
				<a href="retrievePasswordByCel" >忘记密码?</a>
			</form>
		</div>
		
		<div id="info" style="display:none;border:solid 1px black;">
		${user.userName}<br/>
		request:${requestScope.user }<br/>
		session:${sessionScope.user }<br/>
		default:${user }<br/>
		application:${applicationScope.user }<br/>
		${user.userName}<br/>
		</div>
		
	</body>
	
		<script type="text/javascript">
			var loginStat = ${loginStat};
			alert(loginStat);
			
			//alert('${id}');
			
			if(loginStat==1){
				document.getElementById("info").setAttribute("style","display:block !important");
				document.getElementById("form").setAttribute("style","display:none !important");
				//document.getElementById("form").style.display="none";
				//document.getElementById("info").style.display="block";
				
				//history.go(0);
			}else{
				//document.getElementById("form").style.display="block";
				//document.getElementById("info").style.display="none";
				document.getElementById("form").setAttribute("style","display:block !important");
				document.getElementById("info").setAttribute("style","display:none !important");
				 
				//location.reload();
			}
		</script>
</html>