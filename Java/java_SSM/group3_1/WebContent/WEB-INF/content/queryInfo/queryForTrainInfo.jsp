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
		}
		var serialNum = document.getElementById("serialNum").value;
		var bdDate = document.getElementById("bdDate").value;
		$.ajax({
			type:"POST",
			url:"queryTrainInfo",
			data:{
				serialNum :serialNum,
				bdDate :bdDate
			},
			dataType :"json",
			/* contentType :"charset=UTF-8", */
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
	车次：<input id="serialNum" type="text"/>
	日期：<input id="bdDate" type="text" />
	<input type="button" value="查询" onclick="submit()"/><br/>
	<table id="list" cellspacing="0" cellpadding="0">
		<tr>
			<td>站序</td>
			<td>车站</td>
			<td>入站时间</td>
			<td>出战时间</td>
			<td>停留时间</td>
			<td>其他</td>
		</tr>
		<!-- <tr>
			<td id="num">2</td>
			<td id="trainName"></td>
			<td id="arvTime"> </td>
			<td id="lvTime"> </td>
			<td id="stayTime"> </td>
			<td id="otherInfo"> </td>
		</tr> -->
	</table>	
	
</body>
</html>