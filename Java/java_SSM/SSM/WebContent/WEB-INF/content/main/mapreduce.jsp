<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>大数据</title>
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
function submit2(){
	var pie_value = document.getElementById("pie_picture").value;
	alert(pie_value);
	$.ajax({
		type:"post",
		url:"dataStatistics",
		data:"picture="+pie_value,
		//dataType:"json",
		success:function(result){
			console.log(result);
			
		},
		error:function(){
			alert("fail");
		}
	})
}
	
</script>
</head>
<body>
	<form action="<%=basePath%>main/dataStatistics">
		<input type="button" value="pie_picture" id="pie_picture" onclick="submit2()"></input>
	</form>
	<label  id="date" name="date"></label>
 	<%-- <form action="<%=basePath%>main/runMapReduce">
		执行算法：<select name="name">
			<option></option>
			<option value="wordCount">单词统计</option>
			<option value="flowCount">流量统计</option>
		</select>
		<br /><br />
		数据源路径：<input type="text" name="inputPath" />
		数据保存路径：<input type="text" name="outputPath" />
		<br /><br />
		<input type="submit" value="提交" />
	</form> --%>
</body>
</html>