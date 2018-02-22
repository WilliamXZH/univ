// JavaScript Document


jquery1_8(function(){
	//根据总页数判断，如果小于5页，则显示所有页数，如果大于5页，则显示5页。根据当前点击的页数生成
	
	var pageCount = 11;//模拟后台总页数
	//生成分页按钮
	if(pageCount>5){
		page_icon(1,5,0);
	}else{
		page_icon(1,pageCount,0);
	}
	//点击分页按钮触发
	jquery1_8("#pageGro li").live("click",function(){
		if(pageCount > 5){
			var pageNum = parseInt($(this).html());//获取当前页数
			pageGroup(pageNum,pageCount);
		}else{
			$(this).addClass("this");
			$(this).siblings("li").removeClass("this");
		}
	});
	
	//点击上一页触发
	jquery1_8("#pageGro .pageUp").click(function(){
		if(pageCount > 5){
			var pageNum = parseInt($("#pageGro li.this").html());//获取当前页
			pageUp(pageNum,pageCount);
		}else{
			var index = $("#pageGro ul li.this").index();//获取当前页
			if(index > 0){
				$("#pageGro li").removeClass("this");//清除所有选中
				$("#pageGro ul li").eq(index-1).addClass("this");//选中上一页
			}
		}
	});
	
	//点击下一页触发
	jquery1_8("#pageGro .pageDown").click(function(){
		if(pageCount > 5){
			var pageNum = parseInt($("#pageGro li.this").html());//获取当前页
			pageDown(pageNum,pageCount);
		}else{
			var index = $("#pageGro ul li.this").index();//获取当前页
			if(index+1 < pageCount){
				$("#pageGro li").removeClass("this");//清除所有选中
				$("#pageGro ul li").eq(index+1).addClass("this");//选中上一页
			}
		}
	});
});

//点击跳转页面
function pageGroup(pageNum,pageCount){
	switch(pageNum){
		case 1:
			page_icon(1,5,0);
		break;
		case 2:
			page_icon(1,5,1);
		break;
		case pageCount-1:
			page_icon(pageCount-4,pageCount,3);
		break;
		case pageCount:
			page_icon(pageCount-4,pageCount,4);
		break;
		default:
			page_icon(pageNum-2,pageNum+2,2);
		break;
	}
}

//根据当前选中页生成页面点击按钮
function page_icon(page,count,eq){
	var ul_html = "";
	for(var i=page; i<=count; i++){
		ul_html += "<li>"+i+"</li>";
	}
	jquery1_8("#pageGro ul").html(ul_html);
	jquery1_8("#pageGro ul li").eq(eq).addClass("this");
}

//上一页
function pageUp(pageNum,pageCount){
	switch(pageNum){
		case 1:
		break;
		case 2:
			page_icon(1,5,0);
		break;
		case pageCount-1:
			page_icon(pageCount-4,pageCount,2);
		break;
		case pageCount:
			page_icon(pageCount-4,pageCount,3);
		break;
		default:
			page_icon(pageNum-2,pageNum+2,1);
		break;
	}
}

//下一页
function pageDown(pageNum,pageCount){
	switch(pageNum){
		case 1:
			page_icon(1,5,1);
		break;
		case 2:
			page_icon(1,5,2);
		break;
		case pageCount-1:
			page_icon(pageCount-4,pageCount,4);
		break;
		case pageCount:
		break;
		default:
			page_icon(pageNum-2,pageNum+2,3);
		break;
	}
}