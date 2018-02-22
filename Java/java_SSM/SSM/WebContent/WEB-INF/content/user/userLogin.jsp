<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="../plugin/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
	function testAjax(){
		$.ajax({
			type:"POST",
			url:"<%=basePath %>testAjax",
			data:{
				name:"sand",
				sex:"man"
			},
			success:function(data){
				$.each(data,function(index,content){
					/* console.log(index);
					console.log(content);
					console.log(data[index]); */
					for(var i in content){
						if(i == "list"){
							
						}
						console.log(content[i]);
					}
				})
			}
		});
	}
	function testLoad(){
		$("#main").load("<%=basePath %>user/show");
	}
	function changePage(pageNum){
		$("#main").load("<%=basePath %>user/show?pageNum=" + pageNum);
	}
	function testLoadWithPara(){
		$("#main").load("<%=basePath %>user/showByCondition",{
			name:"sand",
			sex:"女"
		});
	}
</script>
<title>Insert title here</title>
</head>
<body>
	<input type="button" value="测试" onclick="testAjax()" />
	<input type="button" value="加载" onclick="testLoad()" />
	<input type="button" value="传参" onclick="testLoadWithPara()" />
	<form action="<%=basePath %>user/login" onsubmit="return testAjax()">
		姓名：<input type="text" name="name" /><br />
		年龄：<input type="text" name="age" /><br />
		<input type="submit" value="提交">
	</form>
	<div id="main">
		
	</div>
</body>
</html>