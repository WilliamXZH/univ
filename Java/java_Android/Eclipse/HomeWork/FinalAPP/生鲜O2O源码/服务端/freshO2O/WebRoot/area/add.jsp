<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title></title>
    <meta charset="UTF-8">
    <script type="text/javascript" src="../js/jquery.js"></script>

 <script type="text/javascript" src="http://api.map.baidu.com/api?key=3690f5facff0a96fc7ff291c20f532e0&v=1.0&services=true" ></script>  
<script type="text/javascript">    
  
function MblogDotccMap(keyword){  
    var map = new BMap.Map("MblogMap");          // 创建地图实例    
    var point = new BMap.Point(113.270793,23.135308);  // 创建点坐标    
      
    map.centerAndZoom(point, 17);                 // 初始化地图，设置中心点坐标和地图级别    
      
    //添加缩放控件  
    map.addControl(new BMap.NavigationControl());    
    map.addControl(new BMap.ScaleControl());    
    map.addControl(new BMap.OverviewMapControl());   
      
    /*显示地图中心地点的坐标 
    map.addEventListener("dragend", function(){ 
      //map.panTo(point); 
      var center = map.getCenter(); 
      document.getElementById("info").innerHTML = "当前地图中心坐标：" + center.lng + ", " + center.lat; 
    });*/  
      
    //搜索  
    var local = new BMap.LocalSearch(map, {renderOptions: {map: map, panel: "results_info"}});  
    map.panBy(point);  
    local.search(keyword);   
    local.getResults();  
    local.setSearchCompleteCallback(function(searchResult){  
            var poi = searchResult.getPoi(0);  
            //alert(poi.point.lng+"   "+poi.point.lat);  
            document.getElementById("info1").value = poi.point.lng + "," + poi.point.lat;  
    });  
  
  
    map.addEventListener("click", function (e) {  
            var _point = e.point;  
            document.getElementById("info2").value = _point.lng + "," + _point.lat;  
          
    });  
  
}  
  
</script>   

    <style type="text/css">
        body {
            padding-bottom: 40px;
        }
        .sidebar-nav {
            padding: 9px 0;
        }

        @media (max-width: 980px) {
            /* Enable use of floated navbar text */
            .navbar-text.pull-right {
                float: none;
                padding-left: 5px;
                padding-right: 5px;
            }
        }


    </style>
</head>
<body onload="MblogDotccMap();" onkeydown="if(event.keyCode==13)MblogDotccMap(document.getElementById('keyword').value)">
<div>
    <h4>请先搜索大概位置然后使用鼠标点击所在的位置然后添加</h4>
</div>
<div style="width:400px;height:350px;border:1px solid gray; float:left" id="MblogMap"></div>  
<div style="margin-top:10px; margin-left:10px; float:left">  
先用搜索查询出大概位置，然后鼠标点击想要的具体位置：  
    <div id="search" style="margin-top:10px; margin-left:10px;">搜索：  
        <input type="text" size="20" name="keyword" id="keyword" />   
        <input type="submit" value="提交" onclick="MblogDotccMap(document.getElementById('keyword').value)" />  
    </div>  
    <div id="results_info" style="margin-top:10px; margin-left:10px;"></div>  
    <form id="form1">
    <div id="info" style="margin-top:10px; margin-left:10px;">  
        搜索地址经纬度：<input type="text" id="info1"/><br/>  
        鼠标点击经纬度：<input type="text" id="info2" name="xypoint"/>  
    </div>  
    <div>
    
    
    	小区名：<input type="text" name="areaname" id="areaname"/> <span id="areanametip" style="color:red; margin-left: 10px;"></span><br>
    	
    	小区地址：<input type="text" name="addr" id="addr"/><span id="addrtip" style="color:red; margin-left: 10px;"></span> <br>
    	
    <span id="info2tip" style="color:red; margin-left: 10px;"></span>
    <br>
    <button type= "button" id="submit_btn">保存</button>
    </div>
    </form>
</div> 

</body>
<script>

   $(function(){
		//提交表单
		$('#submit_btn').click(function(){
			if($('#areaname').val() == ''){
				$('#areanametip').text('小区名称不能为空！');	
				$('#areaname').focus();
			}else if($('#addr').val() == ''){
				$('#areanametip').html("");
				$('#addrtip').text('地址不能为空！');
				$('#addr').focus();
			}else if($('#info2').val() == ''){
				$('#info2tip').html("请先点击图片的位置选择经纬度");
				$('#addrtip').text('');
				$('#areanametip').html("");
				$('#info2').focus();
			}else{
				$('#areanametip').text('');
				$('#addrtip').text('');
				
				var formParam = $("#form1").serialize();//序列化表格内容为字符串
				
				$.ajax({    
			        type:'post',        
			        url:'areaAdd.action',    
			        data:formParam,    
			        cache:false,    
			        dataType:'json',    
			        success:function(data){   
			        	console.log(data);
			        	console.log(data.result == "ok");
				        if (data.result == "ok") {
							window.location.href = "success.jsp";
						} else {
							window.location.href = "fail.html";
						} 
			        }    
			    });
			}
		});
	});
	
	$(function() {
		$('#backid').click(function() {
			window.location.href = "index.jsp";
		});
	});
</script>
</html>