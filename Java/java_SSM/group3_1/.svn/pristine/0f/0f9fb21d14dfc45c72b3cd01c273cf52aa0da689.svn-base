<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
	body{ background:#EEEEEE;margin:0; padding:0; font-family:"微软雅黑", Arial, Helvetica, sans-serif; }
	a{ color:#006600; text-decoration:none;}
	a:hover{color:#990000;}
	.info select{ border:1px initial solid; background:#FFFFFF;float:left;height:21px;}
	.info #show{ color:#3399FF; }
	.bottom{ text-align:right; font-size:12px; color:#CCCCCC; width:1000px;}
</style>
	<script type="text/javascript">
		var Gid  = document.getElementById ;
		var showArea = function(){
		Gid('show').innerHTML = "<h3>省" + Gid('s_province').value + " - 市" + 	
		Gid('s_city').value + " - 县/区" + 
		Gid('s_county').value + "</h3>"										}
		Gid('s_county').setAttribute('onchange','showArea()');
		
		function setValue(){
			p = document.getElementById("s_province").value;
			ci = document.getElementById("s_city").value;
			co = document.getElementById("s_county").value;
			document.getElementById("setV").value=p+ci+co;
		}
	</script>
</head>
<body>
	<form action="../main/userRegister9" method="post">
		用户名<input type="text" name="id"/><br/>
		密码<input type="text" name="password"/><br/>	
		姓名<input type="text" name="userName"/><br/>
		邮箱<input type="text" name="mail"/><br/>
		手机号<input type="text" name="telNum"/><br/>
		证件类型<select id="u69_input" name="idtfType">
		          <option value="二代身份证">二代身份证</option>
		          <option selected value="军人">军人证</option>
	       	  </select><br/>
		证件号<input type="text" name="idtfNum"/><br/>
		旅客类型<input type="text" name="userType"/><br/>
		地址<div class="info" style="display:inline-block;">
				<div>
					<select id="s_province" name="s_province"></select>  
				    <select id="s_city" name="s_city" ></select>  
				    <select id="s_county" name="s_county"></select>
				    <script class="resources library" src="js/area.js" type="text/javascript"></script>
				    
				    <script type="text/javascript">_init_area();</script>
			    </div>
			    <div id="show"></div>
			</div><br>
			<input type="hidden" id="setV" name="address" value=""/>
		性别<input type="text" name="gender"/><br/>
		   <input type="submit" value="提交" onclick="setValue()">	
	</form>

</body>
</html>