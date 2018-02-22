<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
	function submit(){
		var rowLength = $("#list tr").length-1;
		var i=0;
		for(;i<rowLength;i++){
			$("#listContent").remove();
			$("#listContent2").remove();
		}
		var way = document.getElementById("selectByDate").value;
		var condition = document.getElementById("condition").value;
		var start = document.getElementById("start").value;
		var end = document.getElementById("end").value;
		$.ajax({
			type:"POST",
			url:"selectOrder",
			data:{
				type :"historical",
				way :way,
				condition :condition,
				start :start,
				end :end
			},
			dataType :"json",
			/* contentType :"charset=UTF-8", */
			success:function(result){
				console.log(result);
				var i = 0;
				if(result == null){
					alert("刘宇");
				}else{
					for(;i<result.length;i++){
						var newNode = document.createElement("tr");
						newNode.id = "listContent";
						newNode.innerHTML ="<td>"+result[i].orderId+"</td>"
							+"<td>"+result[i].userName+"</td>"
							+"<td>"+result[i].trainName+"</td>"
							+"<td>"+result[i].carriage+"</td>"
							+"<td>"+result[i].seat+"</td>"
							+"<td>"+result[i].depature+"</td>"
							+"<td>"+result[i].destination+"</td>"
							+"<td>"+result[i].ticketType+"</td>"
							+"<td>"+result[i].cost+"</td>"
							+"<td>"+result[i].orderTime+"</td>"
							+"<td>"+result[i].departTime+"</td>"
							+"<td>"+result[i].payMethod+"</td>"
						document.getElementById("list").appendChild(newNode);
					} 
				}
			}
		})
	}
	

</script>
<style type="text/css">
	#list{
		border-bottom: 1px solid black;
		border-right: 1px solid black;
	}
	#list td{
		border-top: 1px solid black;
		border-left: 1px solid black;
		padding: 3px;
	}
</style>
<title>Insert title here</title>
</head>
<body>
	<select id="selectByDate" name="way">
		<option selected value="1" onclick="ticketDate()">按订票日期查询</option>
		<option value="2">按乘车日期查询</option>
	</select>
	<input type="text" id="condition" value=""/><br/>
	<input type="text" id="start" value="2017-06-01"/>
	-
	<input type="text" id="end" value="2017-07-03"/>
	<input type="button" value="查询" onclick="submit()"/>
	<table id="list" cellspacing="0" cellpadding="0">
		<tr>
			<td>订单号</td>
			<td>姓名</td>
			<td>车次</td>
			<td>车厢</td>
			<td>座位</td>
			<td>出发地</td>
			<td>目的地</td>
			<td>票型</td>
			<td>票价</td>
			<td>购票日期</td>
			<td>乘车日期</td>
			<td>支付方式</td>
		</tr>
	</table>	
</body>
</html>