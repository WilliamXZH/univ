<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>退票</title>
<script type="text/javascript" src="js/jquery-1.7.1.min.js"></script>
<script type="text/javascript">
	function submit(){
		var Train_id = document.getElementById("Train_Num").innerHTML;
		var orderNum_id=document.getElementById("mynum").innerHTML;
		var seat_id = document.getElementById("seatid").innerHTML;
		var start_id =document.getElementById("start").innerHTML;
		var destation_id =document.getElementById("destation").innerHTML;
		//alert(serial_num+serial_num2);
		$.ajax({
			type:"post",
			url:"refundticket",
			data:"seatid="+seat_id
		+"&startid="+start_id+
		"&destationid="+destation_id+
		"&orderNumid="+orderNum_id+
		"&Trainid="+Train_id,
			success:function(){
				alert("succeed!");
			},
			error:function(){
				
			}
		})
	}
</script>
</head>
<body>
<label >订单号码：</label><label id ="mynum"  name="myNum"></label><br/>
<label>座位号：</label><label id ="seatnum"  name="seatNum"></label><br/>
<label>乘车日期：</label><label id ="DepartureDate"  name="DepartureDate"></label><br/>
<label>车次：</label><label id ="Train_Num"  name="Train_Num"></label><br/>
<label>共计退款：</label><label id ="total_money"  name="total_money"></label><br/>
<label>票款原价：</label><label id ="original_cos"  name="original_cos"></label><br/>
<label>退票手续：</label><label id ="Handling_charge"  name="Handling_charge"></label><br/>
<label>出发地：</label><label id ="start"  name="start"></label><br/>
<label>目的地：</label><label id ="destation"  name="destation"></label><br/>
<label>座位id：</label><label id ="seatid"  name="seatid"></label><br/>
<input type="submit" value="确定" onclick="submit()">
</body>
<script type="text/javascript">
	window.onload=function(){
		getOrder();
	}
	Date.prototype.diff = function(date){
		  return (this.getTime() - date.getTime())/(24 * 60 * 60 * 1000);
		}	
	function getOrder(){
		<%String a = request.getParameter("orderId");%>
		var ordernum = <%=a%>;
		$.ajax({
			type:"post",
			url:"refundticketqqwe",
			dataType:"json",
			data:"orderNum="+ordernum,
			success:function(result){
				var totalmoney=0;
				var handelMoney=0;
				var myData =$("#DepartureDate").text(result.departTime).text();
				var mycos =$("#original_cos").text(result.cost).text();
				var now = new Date();
				var date = new Date(myData);				
				var diff = now.diff(date);	
				//alert(-diff);
				var diff2=-diff;
				if(diff2>15){
					handelMoney=0;
					totalmoney=mycos;
				}else if(2<diff2<=15){
					handelMoney=mycos*0.05;
					totalmoney=mycos-mycos*0.05;
				}else if(1<diff2<=2){
					handelMoney=mycos*0.1;
					totalmoney=mycos-mycos*0.1;
				}else{
					handelMoney=mycos*0.2;
					totalmoney=mycos-mycos*0.2;
				}				
				console.log(result);
				$("#seatnum").text(result.seatNum);
				$("#mynum").text(result.id);
				$("#DepartureDate").text(result.departTime);
				$("#original_cos").text(result.cost);
				$("#Train_Num").text(result.trainId);
				$("#Handling_charge").text(handelMoney);
				$("#total_money").text(totalmoney);
				$("#start").text(result.depatureId);
				$("#destation").text(result.destinationId);
				$("#seatid").text(result.seat_Ids);
				alert("succeed!");
			},
			
			error:function(){
				alert("failed!");
			}
		})
	}
	
</script>
</html>