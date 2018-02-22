var totalData = [];
var pageSize = 5;
var curPage = 1;
var totalPage = 1;

//id:#pageGro is needed 
function initPage(res){
	totalData = res;
	totalPage = totalData.length/pageSize;
	if(totalData.length%pageSize>0){
		totalPage++;
	}
	
	for(var i=1;i<=totalPage;i++){
		$("#pageGro .pageList ul").append($("<li>"+i+"</li>"));
	}
	
	return getPage();
}
//下一页
function postPage(){
	if(curPage<totalPage){
		curPage++;
	}else{
		
	}
	return getPage();
}
//上一页
function prePage(){
	if(curPage>1){
		curPage--;
	}else{
		
	}
	return getPage();
}
//获取固定页数的数据
getPage(pageNo){
	curPage=pageNo;
	return getPage();
}
//获取当前页数据
function getPage(){
	var tmpData = [];
	var start = (pageNo-1)*pageSize;
	for(var i=0;i<pageNo*pageSize;i++){
		tmpData[i]=totalData[start+i];
	}
	return tmpData;
}
//设置每页数据量条数
function setPageSize(size){
	pageSize = size;
}