<!DOCTYPE html>
<html>
	<head>
		<title>生鲜管理系统</title>
		<meta charset="UTF-8">
		<link rel="stylesheet" type="text/css" href="../css/bootstrap.css" />
		<link rel="stylesheet" type="text/css"
			href="../css/bootstrap-responsive.css" />
		<link rel="stylesheet" type="text/css" href="../css/style.css" />
		<script type="text/javascript" src="../js/jquery.js"></script>
		<script type="text/javascript" src="../js/bootstrap.js"></script>
		<script type="text/javascript" src="../js/ckform.js"></script>
		<script type="text/javascript" src="../js/common.js"></script>
		<style type="text/css">
body {
	padding-bottom: 40px;
}

.sidebar-nav {
	padding: 9px 0;
}

@media ( max-width : 980px) { /* Enable use of floated navbar text */
	.navbar-text.pull-right {
		float: none;
		padding-left: 5px;
		padding-right: 5px;
	}
}
</style>
	</head>
	<body>
		<form id="form1" class="form-inline definewidth m20">
			
			&nbsp;&nbsp;
			<button class="btn btn-info" id="deduction" type="button">
				积分抵扣设定
			</button>
			&nbsp;&nbsp;
			<button type="button" class="btn btn-success" id="exchange">
				积分兑换设定
			</button>
		</form>
		<table class="table table-bordered table-hover definewidth m10"
			id="table1">
			<thead>
				<tr>
					<th>
						商品分类
					</th>
					<th>
						名称
					</th>
					<th>
						价格
					</th>
					<th>
						积分
					</th>
					<th>
						库存
					</th>
					<th>
						描述
					</th>
					<th>
						图片
					</th>
					<th>
						操作
					</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						蔬菜
					</td>
					<td>
						萝卜
					</td>
					<td>
						2.0
					</td>
					<td>
						白萝卜
					</td>
					<td>
						 <img src="1.png"
								alt="edit"  style="vertical-align: middle;height:50px;width: 50px;">
					</td>
					<td>
						<a href="edit.jsp">编辑 <img src="../images/edit-icon.png"
								alt="edit" class="icons" style="vertical-align: middle;">
						</a>
						<a href="edit.html" style="margin-left: 10px;">删除 <img
								src="../images/trash-icon.png" alt="trash"> </a>
					</td>
				</tr>
				<tr>
					<td>
						肉类
					</td>
					<td>
						猪肉
					</td>
					<td>
						20.0
					</td>
					<td>
						新鲜猪肉
					</td>
					<td>
						 <img src="../upload/posi.png"
								alt="edit"  style="vertical-align: middle;height:50px;width: 50px;">
					</td>
					<td>
						<a href="edit.jsp">编辑 <img src="../images/edit-icon.png"
								alt="edit" class="icons" style="vertical-align: middle;">
						</a>
						<a href="edit.html" style="margin-left: 10px;">删除 <img
								src="../images/trash-icon.png" alt="trash"> </a>
					</td>
				</tr>
				<tr>
					<td>
						肉类
					</td>
					<td>
						羊肉
					</td>
					<td>
						40.0
					</td>
					<td>
						手切羊肉
					</td>
					<td>
						 <img src="3.png"
								alt="edit"  style="vertical-align: middle;height:50px;width: 50px;">
					</td>
					<td>
						<a href="edit.jsp">编辑 <img src="../images/edit-icon.png"
								alt="edit" class="icons" style="vertical-align: middle;">
						</a>
						<a href="edit.html" style="margin-left: 10px;">删除 <img
								src="../images/trash-icon.png" alt="trash"> </a>
					</td>
				</tr>
				<tr>
					<td>
						水果
					</td>
					<td>
						苹果
					</td>
					<td>
						12.0
					</td>
					<td>
						苹果
					</td>
					<td>
						 <img src="4.png"
								alt="edit"  style="vertical-align: middle;height:50px;width: 50px;">
					</td>
					<td>
						<a href="edit.jsp">编辑 <img src="../images/edit-icon.png"
								alt="edit" class="icons" style="vertical-align: middle;">
						</a>
						<a href="edit.html" style="margin-left: 10px;">删除 <img
								src="../images/trash-icon.png" alt="trash"> </a>
					</td>
				</tr>
				<tr>
					<td>
						干货
					</td>
					<td>
						杏仁
					</td>
					<td>
						60.0
					</td>
					<td>
						2
					</td>
					<td>
						杏仁
					</td>
					<td>
						 <img src="5.png"
								alt="edit"  style="vertical-align: middle;height:50px;width: 50px;">
					</td>
					<td>
						<a href="edit.jsp">编辑 <img src="../images/edit-icon.png"
								alt="edit" class="icons" style="vertical-align: middle;">
						</a>
						<a href="edit.html" style="margin-left: 10px;">删除 <img
								src="../images/trash-icon.png" alt="trash"> </a>
					</td>
				</tr>
				
			</tbody>
		</table>
		<div class="inline pull-right page">
			<span id="totalCount">5</span> 条记录
			<span id="pageIndex"></span>/
			<span id="totalPage"></span> 1页
			<span id="firstpage" style="cursor: pointer; color: blue;">首页</span>
			<span id="prepage" style="cursor: pointer; color: blue;">上一页</span>
			<span class='current'><span id="pageIndex2"></span>
			</span>
			<span id="nextpage" style="cursor: pointer; color: blue;">下一页</span>
			<span id="lastpage" style="cursor: pointer; color: blue;">最后一页</span>
		</div>
	</body>
	<script>
		 var gotoPage = 0;
	
		 $('#firstpage').click(function(){
		 	gotoPage = -2;
			select();
		 });
		 
		 $('#lastpage').click(function(){
		 	gotoPage = 2;
			select();
		 });
		 
		 $('#prepage').click(function(){
		 	gotoPage = -1;
			select();
		 });
		 
		 $('#nextpage').click(function(){
		 	gotoPage = 1;
			select();
		 });
		 
		 
		 $('#deduction').click(function(){
			window.location.href="deduction.jsp";
		 });
		 
		 $('#exchange').click(function(){
			window.location.href="add.jsp";
		 });
		 
		 
		 $('#select').click(function(){
			select();
				
		 });
		 
		 $('#refresh').click(function(){
			var username = $('#g_name').val();
			console.log("g_name : "+g_name);
			select();
		 });
		 
		function del(id){
			if(confirm("确定要删除吗？")){
				var url = "index.jsp";
				window.location.href=url;
			}
		}
		
		function select(){
			$('table tbody').empty();
			
			var formParam = $("#form1").serialize();//序列化表格内容为字符串    
		    $.ajax({    
		        type:'post',        
		        url:'goodsSelect.action?g_reco=3&gotoPage='+gotoPage,    
		        data:formParam,    
		        cache:false,    
		        dataType:'json',    
		        success:function(data){ 
		        	console.log(data);
					if (data.result == "ok") {
						//$('#msg').text('');
						//window.location.href = "success.html";
						$('#totalCount').text(data.totalCount);
						$('#pageIndex').text(data.pageIndex);
						$('#totalPage').text(data.totalPage);
						$('#pageIndex2').text(data.pageIndex);
						
						for (var i = 0; i < data.list.length; i++) { 
				            console.log(data.list[i]); 
				       
								var trvalue = " <tr>"+
									" 	<td>";
									
								if(data.list[i].categoryId == "1"){
								    trvalue = trvalue + "蔬菜";
								}else if(data.list[i].categoryId == "2"){
									trvalue = trvalue + "谷物";
								}else if(data.list[i].categoryId == "3"){
									trvalue = trvalue + "肉类";
								}else if(data.list[i].categoryId == "4"){
									trvalue = trvalue + "水果";
								}else {
									trvalue = trvalue + "干货";
								}
									
								trvalue = trvalue + " 	</td>"+
									" 	<td>"+
									data.list[i].GName+
									" 	</td>"+
									" 	<td>"+
									data.list[i].GPrice+
									" 	</td>"+
									" 	<td>"+
									data.list[i].g_integration+
									" 	</td>"+
									" 	<td>"+
									data.list[i].g_count+
									" 	</td>"+
									" 	<td>"+
									data.list[i].GDesc+
									" 	</td>"+
									" 	<td>"+
									" 		 <img src='.."+data.list[i].GPic+"' style='vertical-align: middle;height:50px;width: 50px;'>"+
									" 	</td>"+
									"<td>"+
									"	<a href='edit.jsp?g_id="+(data.list[i].GId)+"'>商品积分设定"+
									"	</a>"+
									"</td>"+
									" </tr>";
									
				            var $table = $('#table1');
		          
		           			$table.append(trvalue);
				            
				        }; 
						
					} else {
						//$('#msg').text(data.msg);
						$('#totalCount').text('0');
						$('#pageIndex').text('0');
						$('#totalPage').text('0');
						$('#pageIndex2').text('0');
					}
		        }    
		    });
		}
		select();
	</script>
</html>



