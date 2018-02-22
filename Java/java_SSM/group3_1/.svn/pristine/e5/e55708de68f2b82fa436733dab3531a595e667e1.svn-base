<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0 ,minimum-scale=1.0, maximum-scale=1.0, user-scalable=no" />
		<title>Ticket Order</title>
		<link href="css/amazeui.css" rel="stylesheet" type="text/css" />
		<link href="css/demo.css" rel="stylesheet" type="text/css" />
		<link href="css/cartstyle.css" rel="stylesheet" type="text/css" />
		<link href="css/jsstyle.css" rel="stylesheet" type="text/css" />
		<link rel="stylesheet" href="css/style_nav.css" />
		<link rel="stylesheet" href="css/news-nav.css" />
		<link rel="stylesheet" href="css/bootstrap.css" />
		<link rel="stylesheet" href="css/font-awesome.min.css" />
		<link rel="stylesheet" href="css/passengerInfo_css.css" />
		<link rel="stylesheet" href="css/common_css.css" />
		<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
		<!-- Custom Theme files -->
		<script type="text/javascript" src="js/jquery-1.7.1.js"></script>
		<script type="text/javascript" src="js/city.min.js"></script>
		<script type="text/javascript" src="js/jquery.min.js"></script>
		<link rel="stylesheet" href="css/city.css" />
		<script type="text/javascript" src="js/address.js"></script>
		<script type="text/javascript" src="js/common_js.js"></script>
		<script type="text/javascript" src="js/passengerInfo_js.js"></script>
		<script src="js/jquery.min.js"></script>
		<script src="js/bootstrap.min.js"></script>
		<link rel="stylesheet" href="css/style_footer.css" />
		<script type="text/javascript" src="js/passengerInfo_js.js"></script>
		<script type="application/x-javascript">
			addEventListener("load", function() {
				setTimeout(hideURLbar, 0);
			}, false);

			function hideURLbar() {
				window.scrollTo(0, 1);
			}
		</script>
		<!--webfont-->
<!-- 		<link href='#css?family=Oxygen:400,700,300' rel='stylesheet' type='text/css' />
		<link href='#css?family=Open+Sans:400,300,600,700,800' rel='stylesheet' type='text/css' /> -->
		<!-- start menu -->
		<!-- <link href="css/megamenu.css" rel="stylesheet" type="text/css" media="all" /> -->
		<script type="text/javascript" src="js/megamenu.js"></script>

		<script>
			$(document).ready(function() {
				$(".megamenu").megamenu();
				var no = 1;
			});
		</script>
		<script type="text/javascript" src="js/jquery.leanModal.min.js"></script>
		<!-- <link rel="stylesheet" href="css/menu.css" /> -->
		<script src="js/easyResponsiveTabs.js" type="text/javascript"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				$('#horizontalTab').easyResponsiveTabs({
					type: 'default', //Types: default, vertical, accordion           
					width: 'auto', //auto or any width like 600px
					fit: true // 100% fit in a container
				});
			});
		</script>
		<!---- start-smoth-scrolling---->
		<script type="text/javascript" src="js/move-top.js"></script>
		<script type="text/javascript" src="js/easing.js"></script>
		<script type="text/javascript">
			jQuery(document).ready(function($) {
				$(".scroll").click(function(event) {
					event.preventDefault();
					$('html,body').animate({
						scrollTop: $(this.hash).offset().top
					}, 1200);
				});
			});
		</script>
		<script type="text/javascript">
			function rec() {
				var mymessage = confirm("本系统不提供选座，请服从随机分配！");
				/* if(mymessage == true) {
					window.open('http://127.0.0.1:8020/%e8%b4%ad%e7%a5%a8Liu/ticket_order_confirm.html')
				} else {
					document.write("");
				} */
				var orderInfo = packageToJson();
				var trainInfo = trainInfoToJson();
				console.log(orderInfo);
				console.log(trainInfo);
				$.ajax({
					type:"POST",
					url:"addOrder",
					//dataType:"json",
					data:{
						oi:orderInfo,
						ti:trainInfo
					},
					success:function(result){
						console.log("result:"+result);
						if(result!=null){
							alert("成功");
							window.location.href="";
						}
					},
					error:function(){
						alert("Error!");
					}
				})
			}
		</script>

	</head>

	<body id="body_id" class="dhtmlx_winviewport  dhtmlx_winviewport dhtmlx_skin_dhx_terrace">
		<div class="tm-header">
			<div class="container">
				<div class="row">
					<div class="col-lg-6 col-md-4 col-sm-3 tm-site-name-container">
						<a href="#" class="tm-site-name">logo</a>
					</div>
					<div class="col-lg-6 col-md-8 col-sm-9">
						<div class="mobile-menu-icon">
							<i class="fa fa-bars"></i>
						</div>
						<nav class="tm-nav" style="width: 600px;">
							<ul>
								<li>
									<a href="#" class="">主页</a>
								</li>
								<li>
									<a href="NomalQuestion.html">常见问题</a>
								</li>
								<li>
									<a href="tours.html">铁路常识</a>
								</li>
								<li>
									<a href="contact.html">站车风采</a>
								</li>
								<li>
									<a href="contact.html">温馨服务</a>
								</li>
							</ul>
						</nav>
					</div>
				</div>
			</div>
			<!--//logo-->
			<div class="w3layouts-login">
				<a data-toggle="modal" data-target="#myModal" href="#"><i class="glyphicon glyphicon-user"> </i>个人中心</a>
			</div>
		</div>
		<div class="faq">
			<div class="container">
				<div class="agileits-news-top">
					<ol class="breadcrumb">
						<li>
							<a href="index.html">主页</a>
						</li>
						<li>
							<a href="#">查询</a>
						</li>

						<li class="active">购票</li>
					</ol>
				</div>
			</div>
		</div>
		<div class="clear"></div>
		<div class="clear"></div>

		<!--订单 -->
		<div>
			<div class="content" style="min-height: 445px;">
				<!--列车信息 开始-->
				<div class="layout t-info">
					<div class="lay-hd">
						列车信息<span class="small">（以下余票信息仅供参考）</span>
					</div>
					<div class="lay-bd">
						<p class="t-tit" id="ticket_tit_id">
							<strong class="mr5">2017-06-30（周,五） K265 北京站（13:55开）—长春站（05:11到）</strong>
						</p>
						<p class="t-con" id="ticket_con_id">
							<!-- <span id="ticket_status_id" class="s2">软卧（<span class="colorA">￥348.5</span>）无票</span>

							<span id="ticket_status_id" class="s2">硬卧（<span class="colorA">￥222.5</span>）无票</span>

							<span id="ticket_status_id" class="s2">硬座（<span class="colorA">￥128.5</span>）无票</span>

							<span id="ticket_status_id" class="s1">无座（<span class="colorA">￥128.5</span>）有票</span>
						 --></p>
					</div>
				</div>

				<!--列车信息 结束-->
				<!--改签原票信息 开始-->
				<!--改签原票信息 结束-->
				<div style="display: none;">
					<input style="display: none;" type="checkbox" id="fczk" />
				</div>
				<!--乘客信息 开始-->

				<script>
					// alert("enter the page!");
					//alert("enter the page!");
					var jsonlist = ${requestScope.partners};
						console.log(jsonlist);

					var tripTrain = ${requestScope.tripTrain};
						console.log(tripTrain);
					
					var tripTicket = ${requestScope.tripTicket};
						console.log(tripTicket);
					
					var backTrain = ${requestScope.backTrain};
						console.log(backTrain);
					
					var backTicket = ${requestScope.backTicket};
						console.log(backTicket);
					
					//console.log(jsonstr);
					//console.log(JSON.parse(JSON.stringify('${requestScope.partners}')));
					//console.log(eval('('+jsonstr+')'));
					//var jsonlist = JSON.parse('${requestScope.partners}');
					//var jsonlist0 =${partners};
					//console.log('${requestScope.partners}');
					//var jsonlist1 = eval('('+'${partners}'+')');
					//var jsonlist2 = JSON.stringify('${partners}');
					//var jsonlist = JSON.parse('${partners}');
					//var jsonlist3 = $.getJSON();
					//alert(jsonlist1+":"+jsonlist2+":"+jsonlist3);
					//console.log(jsonlist); 
					//var jsonlist = [{
					//console.log(jsonlist);
					/* var jsonlist = [{
						"name": "张三",
						"type": "身份证",
						"identify": 123456,
						"phone": 13683683189

					}, {
						"name": "李四",
						"type": "军人证",
						"identify": 654321,
						"phone": 13683683189
					}];  */
					//console.log(jsonlist);
					window.onload=function(){
						var trainInfo = tripTrain.bdDate.split(" ")[0]+" "
							+tripTrain.serialNum+" "+tripTrain.departure
							+"("+tripTrain.lvTime+"开)—"+tripTrain.destination
							+"("+tripTrain.arvTime+"到)";
						$("#ticket_tit_id").find("strong").html(trainInfo);
						
						var tickets = tripTrain.tickets;
						var cp_base_ticket = '<span id="" class="s2">(软卧￥348.5)无票</span>';

						for(var liv_t=0;liv_t<tickets.length;liv_t++){
							var t_span = $(cp_base_ticket);
							t_span.html('(<span class="colorA">'+tickets[liv_t].ticketType+'￥'+tickets[liv_t].price+'</span>)'
									+(tickets[liv_t].quantity>0?tickets[liv_t].quantity+'张':'无票'));
							if(tickets[liv_t].ticketTypeId==tripTicket.ticketTypeId){
								t_span.attr("class","s1");
							}else{
								t_span.attr("class","s2");
							}
							t_span.attr("id","ticket_status_id_"+liv_t);
							//console.log(t_span.html());
							$("#ticket_con_id").append(t_span);
						}
						//console.log($("#ticket_con_id").html());
						
						//var base = $("#normal_passenger_id").find("ul");
						var base = $("#cp_base");
						var basecontent = base.html();
						base.html("");
						//alert(base);
						//var basecontent = base.html();
						//console.log(basecontent);
						//$("#normal_passenger_id").find("ul").append(basecontent);
						for(var i =0;i<jsonlist.length;i++){
							var obj = $(basecontent);
							var totaltimes = 93+i*6;
							//console.log(totaltimes);
							obj.css("display","inline-block");
							obj.find("input").attr("id","normalPassenger_"+i);
							obj.find("input").attr("totaltimes",totaltimes);
							obj.find("input").val(jsonlist[i].name);
							obj.find("label").text(jsonlist[i].name);
							obj.find("label").attr("for","normalPassenger_"+i);
							obj.html('<li class="partner">'+obj.html()+'</li>');
							//console.log(obj.html());
							base.append(obj.html());
						} 
					}
					
					
				</script>

				<div class="layout person">
					<div class="lay-hd">
						乘客信息<span class="small" id="psInfo">（填写说明）</span>

					</div>
					<div id="normal_passenger_id" class="lay-bd">
						<div class="per-sel">

							<div class="item clearfix">

								<ul id="cp_base">
									<li >
										<input totaltimes="93" typeflag="1" id="normalPassenger_0" type="checkbox" class="check" onclick="abc(this)" value="张三" /><label for="normalPassenger_0" style="cursor: pointer" >张三</label>
									</li>
								</ul>
								<div class="btn-all" style="display: none;" id="btnAll">
									<a id="show_more_passenger_id" title="展开" href="javascript:" style="" shape="rect"><label id="gd">更多</label>
										<b></b>
									</a>
								</div>
							</div>
						</div>
						<table class="per-ticket">
							<tbody id="ticketInfo">
								<tr>
									<th width="28" rowspan="1" colspan="1">序号</th>
									<th rowspan="1" colspan="1">席别 </th>
									<th rowspan="1" colspan="1">票种</th>
									<th rowspan="1" colspan="1">姓名</th>
									<th rowspan="1" colspan="1">证件类型</th>
									<th rowspan="1" colspan="1">证件号码</th>
									<th rowspan="1" colspan="1">手机号码</th>
									<!-- 
						<th><input type="checkbox" class="check" id="selected_ticket_passenger_all"
							onclick="javascript:selectedTicketPassengerAll(this,true);" checked="checked" />全部</th>
						-->
									<th width="70" rowspan="1" colspan="1"></th>
									<th width="30" rowspan="1" colspan="1"></th>
								</tr>
							</tbody>
							<tbody id="ticketInfo_id" hidden="hidden">
								<tr id="tr_id_1">
									<td align="center">1</td>
									<td>
										<select onclick="javascript:stepFirValidatorTicketInfo(true);" id="seatType_1" disabled="disabled" class="select_ticketTypes">

											<!-- <option value="硬座-128.5" selected="selected">
												硬座（￥128.5）
											</option> -->

										</select>
									</td>
									<td>
										<select id="ticketType_1" onchange="javascript:updateSeatTypeByeTickeType(this);" class="kind_of_user">

											<option name="ticket_type_option" value="1" selected="selected">成人票</option>

											<option value="2">儿童票 </option>

											<option value="3">学生票 </option>

											<option value="4">残军票 </option>

										</select>
									</td>
									<td>
										<div class="pos-rel">
											<input type="text" id="passenger_name" class="inptxt w110" value=" " disabled="disabled" style="color:#999999" title="不允许修改乘车人信息" />

										</div>
									</td>
									<td>
										<select id="passenger_id_type_1" class="passenger_id_type" disabled="disabled" style="color:#999999" title="不允许修改乘车人信息">

											<option value="二代身份证" selected="selected">二代身份证</option>

											<option value="港澳通行证">港澳通行证</option>

											<option value="台湾通行证">台湾通行证</option>

											<option value="护照">护照</option>

										</select>
									</td>
									<td>
										<div class="pos-rel"><input id="passenger_id_no_1" class="inptxt w160" value="" size="20" maxlength="35" disabled="disabled" style="color:#999999; font-size:14px" title="不允许修改乘车人信息" />
											<div class="w160-focus" id="passenger_id_no_1_notice"></div>
										</div>
									</td>
									<td id="phoneNum">
										<div class="pos-rel"><input type="text" id="phone_no_1" class="inptxt w110" value="" size="11" maxlength="20" disabled="disabled" style="color:#999999; font-size:14px " title="不允许修改乘车人信息" />
											<div class="w160-focus" id="phone_no_1_notice"></div>
										</div>
									</td>

									<td style="width:40;">
										<a href="javascript:" id="addchild_1" name="addchild_default_0"></a>
									</td>
									<td width="10%" align="center">
										<input type="button" value="  -  " onclick="RemoveTr(this);" />
									</td>

								</tr>

							</tbody>
						</table>
						<div>
							<div class="add-per">
								<div class="tc-btn createAddr theme-login am-btn am-btn-danger">新增乘客</div>

							</div>
						</div>
						<script type="text/javascript" src="js/add_validate.js"></script>
					</div>
				</div>
				<script type="text/javascript"></script>
				<script type="text/javascript">
					var tickets = tripTrain.tickets;
					var ticket_base_content = '<option value="硬座-128.5" selected="selected">硬座（￥128.5）</option>';
					//添加常用联系人
					function abc(currentBox) {
						var index = $("#normal_passenger_id").find("#cp_base").find(currentBox).parent().index();
						//var index = $("#cp_base").index($(currentBox).parent());
						//alert(index);
						//console.log($(currentBox).attr("checked"));
						if($(currentBox).attr("checked") == "checked") {
							var name = currentBox.value;
							var content = $($("#ticketInfo_id").html());

							if($("#ticketInfo").find("tr").length>tripTicket.quantity){
								alert("余票不足");
								$(currentBox).parent().removeAttr("checked");
								return;
							}
							content.attr("id", "ticketInfo" + index);
							for(var i in jsonlist) {
								if(jsonlist[i].name == name) {
									content.find("#passenger_name").val(jsonlist[i].name);
									content.find("#passenger_id_type_1").val(jsonlist[i].userType);
									content.find("#passenger_id_no_1").val(jsonlist[i].idtfNum);
									content.find("#phone_no_1").val(jsonlist[i].telNum);
									
									content.find(".select_ticketTypes").attr("id","seatType_"+index);
									var seatTypes = content.find("#seatType_"+index);
									//seatTypes.html("");
									for(var j=0;j<tickets.length;j++){
										var ticket_option = $(ticket_base_content);
										ticket_option.attr("value",tickets[j].ticketType+"-"+tickets[j].price);
										ticket_option.text(tickets[j].ticketType+'(￥'+tickets[j].price+')');
										if(tickets[j].ticketTypeId==tripTicket.ticketTypeId){
											ticket_option.attr("selected","selected");
										}else{
											ticket_option.removeAttr("selected");
										}
										//alert(ticket_option.html());
										seatTypes.append(ticket_option);
									}
									//alert(seatTypes.html());
									
								}
							}
							//console.log(content.html());
							$("#ticketInfo").append(content);
						} else {
							$("#ticketInfo" + index).remove();
						}	
						var length = $("#ticketInfo").find("tr").length; //#tb为Table的id  获取所有行
						for(i = 0; i < length; i++) {
							$("#ticketInfo tr").eq(i).children("td").eq(0).html(i); //给每行的第一列重写赋值

						}
					}
					//添加乘客
					function AddTr(obj) {
                        var content = $($("#ticketInfo_id").html());
						var flag = 0;
						$("#ticketInfo .passenger_id_no_1").each(function(index,content){
							if($(content).val() == $(".theme-popover #idetityNum").val()){
								flag = 1;
								return;
							}
						})
						if(flag == 1){
							alert("此乘客已存在");
							return;
						}else{
							if($("#ticketInfo").find("tr").length>tripTicket.quantity){
								alert("余票不足,添加乘客失败!");
								return;
							}
							content.find("#passenger_name").val($("#.theme-popover #user_name").val());
							content.find("#passenger_id_no_1").val($("#.theme-popover #idetityNum").val());
							content.find("#phone_no_1").val($("#.theme-popover #user_phone").val());		
							$("#ticketInfo").append(content);
						}
						var length = $("#ticketInfo").find("tr").length; //#tb为Table的id  获取所有行
						for(i = 0; i < length; i++) {
							$("#ticketInfo tr").eq(i).children("td").eq(0).html(i); //给每行的第一列重写赋值
						}
					}
					//删除乘客
					function RemoveTr(obj) {
						var currentTr = $(obj).parent().parent();
						var currentTrName = currentTr.find("#passenger_name").val();
						var i = 0;
						for(;i<$("#cp_base li").length;i++){
							if($("#cp_base li").eq(i).find("input").val()==currentTrName){
								$("#cp_base li").eq(i).find("input").removeAttr("checked");
							}
						}
						$(obj).parent().parent().remove();
						var length = $("#ticketInfo").find("tr").length; //#tb为Table的id  获取所有行
						for(i = 0; i < length; i++) {
							$("#ticketInfo tr").eq(i).children("td").eq(0).html(i); //给每行的第一列重写赋值

						}
					}
					function trainInfoToJson(){
						var trainInfo = new Object();
						trainInfo.trainId = tripTrain.id;
						trainInfo.ticketTypeId = tripTicket.ticketTypeId;
						
						var stations = tripTrain.stations;
						for(var j=0;j<stations.length;j++){
							if(tripTrain.departure==stations[j].name){
								trainInfo.departureId=stations[j].stationId;
							}
							if(tripTrain.destination==stations[j].name){
								trainInfo.destinationId=stations[j].stationId;
							}
						}
						return JSON.stringify(trainInfo);
					}
					function packageToJson(){
						var info = new Array();
						for(var i=1;i<$("#ticketInfo").find("tr").length;i++){
							var content = $("#ticketInfo").find("tr");
							//alert(i);
							info[i-1] = new Object();
							info[i-1].trainId=tripTrain.id;
							info[i-1].departTime=tripTrain.bdDate;
							//info[i-1].cost=
							seat_type_cost=$(content[i]).find(".select_ticketTypes").val();
							//info[i-1].ticketType=seat_type_cost.split('-')[0];
							info[i-1].ticketTypeId=tripTicket.ticketTypeId;
							info[i-1].ticketType=tripTicket.ticketType;
							info[i-1].cost=tripTicket.price;							
							//info[i-1].cost=seat_type_cost.split('-')[1];
							info[i-1].userType=$(content[i]).find(".kind_of_user").val();
							info[i-1].name=$(content[i]).find(".pos-rel .inptxt").val();
							info[i-1].idtfType=$(content[i]).find(".passenger_id_type").val();
							info[i-1].identify=$(content[i]).find("#passenger_id_no_1").val();
							info[i-1].phoneNum=$(content[i]).find("#phone_no_1").val();
							
							//alert(tripTrain.stations);
							var stations = tripTrain.stations;
							for(var j=0;j<stations.length;j++){
								if(tripTrain.departure==stations[j].name){
									info[i-1].departureId=stations[j].stationId;
								}
								if(tripTrain.destination==stations[j].name){
									info[i-1].destinationId=stations[j].stationId;
								}
							}
						}
						alert(JSON.stringify(info));
						return JSON.stringify(info);
					}
				</script>
				

				<div class="lay-btn">
					<a id="preStep_id" href="javascript:" class="btn92" shape="rect">上一步</a>
					<a id="submitOrder_id" href="javascript:void(0);" class="btn92s" shape="rect" onclick="rec()">提交订单</a>
				</div>
				<div class="clear"></div>
			</div>

			<div class="cuttingLine1">
				<div class="tm-section-header">
					<div class="col-lg-3 col-md-3 col-sm-3">
						<hr>
					</div>
					<div class="col-lg-6 col-md-6 col-sm-6">
						<h1 class="tm-section-title"><font style="text-align: center;"><font>关于我们</font></font></h1>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-3">
						<hr />
					</div>
				</div>
			</div>
		</div>
		<footer id="footerContainer">
			<div class="footer">
				<div class="container">
					<div class="row">
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="quicklinks">
								<h4 class="footerh"><font><font>相关链接</font></font></h4>
								<br />
								<ul>
									<li><i class="fa fa-angle-right"></i>
										<a href="#">
											<font>
												<font>企业差旅索引</font>
											</font>
										</a>
									</li>
									<li><i class="fa fa-angle-right"></i>
										<a href="#">
											<font>
												<font>网络社会征信网</font>
											</font>
										</a>
									</li>
									<li><i class="fa fa-angle-right"></i>
										<a href="#">
											<font>
												<font>加盟合作</font>
											</font>
										</a>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-md-4 col-sm-6 col-xs-12">
							<div class="quickcontact">
								<h4 class="footerh"><font><font>联系我们</font></font></h4>
								<br />
								<ul>
									<li><i class="fa fa-phone"></i>
										<font>
											<font> 123456789</font>
										</font>
									</li>
									<li><i class="fa fa-envelope"></i>
										<font>
											<font> abc@website.com</font>
										</font>
									</li>
									<li><i class="fa fa-map-marker"></i>
										<font>
											<font> 2B Barcelon，纽约-32011</font>
										</font>
									</li>
								</ul>
							</div>
						</div>
						<div class="col-md-4 col-sm-12 col-xs-12">
							<div class="follow">
								<h4 class="footerh"><font><font>微信公众号</font></font></h4>
								<br />
								<img src="images/er_ctrip_wechat.jpg" />
							</div>
						</div>
					</div>
				</div>
			</div>

			<div>
				<div class="row" style="background: white;">
					<div class="col-md-12">
						<p style="color: black;">
							<font style="text-align: center;">
								<font>版权所有©2017.公司名称保留所有权利。
								</font>
							</font>
						</p>
					</div>
				</div>
			</div>
			<div id="toTopButton"></div>
		</footer>

		<div class="theme-popover-mask"></div>
		<div class="theme-popover">

			<!--标题 -->
			<div class="am-cf am-padding">
				<div class="am-fl am-cf"><strong class="am-text-danger am-text-lg">新增乘客</strong> / <small>Add passenger</small></div>
			</div>
			<hr/>

			<div class="am-u-md-12">
				<form class="am-form am-form-horizontal" action="#" method="post">

					<div class="am-form-group">

						<label for="user_name" class="am-form-label">姓名</label>
						<div class="am-form-content">

							<input type="text" name="user_name" id="user_name" placeholder="姓名" onkeyup="value=value.replace(/[^\u4E00-\u9FA5]/g,'');return checkName()" onkeyup="value=value.replace(/[ -~]/g,'')" onkeydown="if(event.keyCode==13)event.keyCode=9" maxlength="5" />
							<div id="usernameInform" class="inform"></div>
						</div>
					</div>
					<div class="am-form-group">
						<label for="identitype" class="am-form-label">证件类型</label>
						<div class="am-form-content">
							<select>
								<option value="1">二代身份证</option>
								<option value="2">护照</option>
								<option value="3">港澳通行证</option>
								<option value="4">台胞证</option>
							</select>
						</div>
					</div>
					<div class="am-form-group">
						<label for="idetityNum" class="am-form-label">证件号码</label>
						<div class="am-form-content">

							<input type="text" name="idetityNum" id="idetityNum" placeholder="证件号" onkeyup="return checkIdentifer()" />

							<div id="idetityNumInfo" class="inform"></div>
						</div>
					</div>

					<div class="am-form-group">
						<label for="user_phone" class="am-form-label">手机号码</label>

						<div class="am-form-content">

							<input type="text" name="Phone" id="user_phone" placeholder="手机号必填" onkeyup="return checkPhone()" />
							<div id="user_phoneInform" class="inform"></div>
						</div>
					</div>
					<div class="am-form-group theme-poptit">
						<div class="am-u-sm-9 am-u-sm-push-3">
							<input class="am-btn am-btn-danger " id="submit" type="button" value="保存" onclick="validateForm()" />
							<div id="closeWindow" class="am-btn am-btn-danger close">取消</div>
						</div>
						<input id="reset" type="reset" hidden="hidden" />
					</div>
				</form>
			</div>

		</div>

		<div class="clear"></div>
	</body>
	
</html>