function writeQueryResult(act_name,result){
	var action = document.getElementById(act_name);
	action.innerHTML = base_info;
	for(var i=0;i<result.length;i++){
		
		var countTmp = 0;
		for(var liv_t=0;liv_t<result[i].tickets.length;liv_t++){
			countTmp += result[i].tickets[liv_t].quantity;
		}
		if(countTmp==0)continue;
		
		
		var trainInfo = document.createElement("tr");
		
		var td1 = document.createElement("td");
		var train_number_label = document.createElement("label");
		train_number_label.setAttribute("class","train_number");
		train_number_label.innerHTML=result[i].serialNum;
		td1.appendChild(train_number_label);
		trainInfo.appendChild(td1);

		var td2 = document.createElement("td");
		var train_time_li1 = document.createElement("li");
		train_time_li1.setAttribute("class","train_time");
		var train_time_li1_label = document.createElement("label");
		train_time_li1_label.innerHTML=result[i].lvTime;
		train_time_li1_label.setAttribute("class","train_number");
		train_time_li1.appendChild(train_time_li1_label);
		td2.appendChild(train_time_li1);
		var train_time_li2 = document.createElement("li");
		train_time_li2.setAttribute("class","train_time");
		var train_time_li2_label = document.createElement("label");
		train_time_li2_label.innerHTML=result[i].arvTime;
		train_time_li2_label.setAttribute("class","train_arrive");
		train_time_li2.appendChild(train_time_li2_label);
		td2.appendChild(train_time_li2);
		trainInfo.appendChild(td2);
		


		var td3 = document.createElement("td");
		var train_time_li1 = document.createElement("li");
		train_time_li1.setAttribute("class","train_time");
		var train_time_li1_label = document.createElement("label");
		train_time_li1_label.innerHTML=result[i].stations[0].name;
		train_time_li1_label.setAttribute("class","td_style");
		train_time_li1.appendChild(train_time_li1_label);
		td3.appendChild(train_time_li1);
		var train_time_li2 = document.createElement("li");
		train_time_li2.setAttribute("class","train_time");
		var train_time_li2_label = document.createElement("label");
		train_time_li2_label.innerHTML=result[i].stations[result[i].stations.length-1].name;
		train_time_li2_label.setAttribute("class","td_style");
		train_time_li2.appendChild(train_time_li2_label);
		td3.appendChild(train_time_li2);
		trainInfo.appendChild(td3);
		
		var td4 = document.createElement("td");
		var td4_label = document.createElement("label");
		td4_label.innerHTML=result[i].totalTime;
		td4_label.setAttribute("class","td_style");
		td4.appendChild(td4_label);
		trainInfo.appendChild(td4);
		
		var tickets = result[i].tickets;

		var td5 = document.createElement("td");
		td5.setAttribute("class","test");
		td5.setAttribute("style","width:250px;");
		for(var j=0;j<tickets.length;j++){
			if(tickets[j].quantity==0)continue;
			
			var td5_li = document.createElement("li");
			td5_li.setAttribute("class","train_time");
			
			var td5_li_1 = document.createElement("label");
			td5_li_1.setAttribute("class","td_style");
			td5_li_1.innerHTML = tickets[j].ticketType;
			td5_li.appendChild(td5_li_1);
			
			var td5_li_2 = document.createElement("span");
			td5_li_2.innerHTML='￥';
			td5_li.appendChild(td5_li_2);
			
			var td5_li_3 = document.createElement("label");
			td5_li_3.setAttribute("class","ticket_price");
			td5_li_3.innerHTML = tickets[i].price;
			td5_li.appendChild(td5_li_3);

			var td5_li_4 = document.createElement("label");
			td5_li_4.innerHTML="余票";
			td5_li.appendChild(td5_li_4);
			//td5_li.append("余票");
			
			var td5_li_5 = document.createElement("label");
			td5_li_5.setAttribute("class","ticket_number");
			td5_li_5.innerHTML = tickets[j].quantity;
			td5_li.appendChild(td5_li_5);
			
			var td5_li_6 = document.createElement("label");
			td5_li_6.innerHTML = "张";
			td5_li.appendChild(td5_li_6);
			td5.appendChild(td5_li);
		}
		trainInfo.appendChild(td5);
		
		
		var td6 = document.createElement("td");
		td6.setAttribute("class","train_time");
		for(var k=0;k<tickets.length;k++){
			if(tickets[k].quantity==0)continue;
			
			var td6_li = document.createElement("li");
			td6_li.setAttribute("class","train_time");
			var td6_li_input = document.createElement("input");
			td6_li_input.setAttribute("type","radio");
			
			if(tickets[k].quantity==0){
				td6_li_input.setAttribute("disabled","");
			}
			
			if(act_name=="trip"){
				//td6_li_input.setAttribute("class","choice_ticket1");
				td6_li_input.setAttribute("name","seatType1");
			}else{
				//td6_li_input.setAttribute("class","choice_ticket2");
				td6_li_input.setAttribute("name","seatType2");
			}
			
			//var input_value = "{\"trainInfo\":"+JSON.stringify(result[i])+",\"seatInfo\":"+JSON.stringify(tickets[k])+"}";
			//console.log(JSON.parse(JSON.stringify(result[i])));
			//td6_li_input.setAttribute("class","choice_ticket");
			//td6_li_input.setAttribute("name","seatType");
			td6_li_input.setAttribute("value",result[i].id+':'+tickets[k].ticketTypeId);
			//td6_li_input.setAttribute("value",input_value);
			
			td6_li.appendChild(td6_li_input);
			td6.appendChild(td6_li);
		}
		trainInfo.appendChild(td6);
		
		action.appendChild(trainInfo);
		//alert("apend_succeed!");
	}
}
			

function query(){				
	var city1 = document.getElementById("citySelect1").value;
	var city2 = document.getElementById("citySelect2").value;
	var date1 = document.getElementById("datepicker").value;
	var date2 = document.getElementById("clender").value;

	date1 = convert(date1);
	date2 = convert(date2);

	//alert(city1+'\t'+city2+'\t'+date1+"\t"+date2);
	
	
	var ttl = document.getElementsByClassName("trainft");
	var tts = "";
	var rtts = "";
	for(var i=0;i<ttl.length;i++){
		if(ttl[i].checked==true){
			tts += ttl[i].value;
		}
		rtts += ttl[i].value;
	}
	if(tts=="")tts=rtts;
	//alert("tts:"+tts);
	
	var stl = document.getElementsByClassName("seatft");
	var sts = "";
	var rsts = "";
	for(var j=0;j<stl.length;j++){
		if(stl[j].checked==true){
			sts += '-'+stl[j].value+'-';
		}
		rsts += '-'+stl[j].value+'-';
	}
	if(sts=="")sts=rsts;
	//alert("sts:"+sts);
	
	$.ajax({
		type:"POST",
		url:"queryTicket",
		data:"departure="+city1+"&destination="+city2+"&date="+date1+"&trainTypes="+tts+"&ticketTypes="+sts+"&type=trip",
		success:function(result){
			console.log(result);
			writeQueryResult("trip",result);
 					
		},
		error:function(){
			alert("error");
		} 
	})
	
	var tripAndBack = document.getElementById("tripAndBack");
	if(tripAndBack.checked==true){
		$.ajax({
			type:"POST",
			url:"queryTicket",
			data:"departure="+city2+"&destination="+city1+"&date="+date2+"&trainTypes="+tts+"&ticketTypes="+sts+"&type=back",
			success:function(result){
				writeQueryResult("back",result);
			},
			error:function(){
				alert("error");
			} 
		})
	}
}

function checkBack(){
	var tripOnly = document.getElementById("tripOnly");
	var tripAndBack = document.getElementById("tripAndBack");
	var trip = document.getElementById("btn2");
	if(tripAndBack.checked==true){
		trip.style.display = "block";
	}else if(tripOnly.checked==true){
		trip.style.display = "none";
	}
}




