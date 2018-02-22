var totalData = [];
var pageSize = 5;
var pageNoCount = 4;
var pageCurNo = 1;
var totalPage = 1;

//#pageGroup
//#pageList
//#prePage
//#postPage
//put all datas in the function 'initPage(res)', and create a show function to show data.
function initPage(res){
	//totalData = res;
	
	for(var i=0;i<res.length;i++){
		totalData[i]=res[i];
	}
	document.getElementById("prePage").setAttribute("onclick","prePage()");
	document.getElementById("postPage").setAttribute("onclick","postPage()");
	var page_ul = document.getElementById("pageList-ul")//.getElementsByTagName("ul");
	for(var j=1;j<=pageNoCount;j++){
		var page_li = document.createElement("li")
		page_li.value=j;
		page_li.textContent=j;
		page_li.setAttribute("onclick","getPage(this.value)")
		page_ul.appendChild(page_li);
	}
	
	//console.log(totalData);
	totalPage = Math.floor(totalData.length/pageSize);
	if(totalData.length%pageSize>0){
		alert(totalPage+":totalPage++");
		totalPage++;
	}
	console.log("totalPage:"+totalPage+"&pageCurNo:"+pageCurNo);
	getCurPageInfo();
}

function pagePlay(){
	var preButton = document.getElementById("prePage");
	if(pageCurNo==1){
		//preButton.style.display="none";
		preButton.style.visibility="hidden";
	}else{
		preButton.style.visibility="visible";
		//preButton.style.display="block";
	}
	
	var postButton = document.getElementById("postPage");
	if(pageCurNo==totalPage){
		//postButton.setAttribute("disabled","disabled");
		//postButton.style.display="none";
		postButton.style.visibility="hidden";
	}else{
		postButton.style.visibility="visible";
		//postButton.style.display="block";
	}
	
	var lis = document.getElementById("pageList-ul").childNodes;
	//console.log(lis);
	for(var i=0;i<lis.length;i++){
		//alert(lis[i].valueOf()+":"+lis[i].textContent+":"+lis[i].itemValue);
		console.log(lis[i]);
		
		
		if(pageCurNo<=(pageNoCount+1)/2){
			lis[i].value=i+1;
			lis[i].textContent=i+1;
		}else if(pageCurNo>=totalPage-(pageNoCount-1)/2){
			lis[i].value=totalPage-pageNoCount+i+1;
			lis[i].textContent=totalPage-pageNoCount+i+1;
		}else{
			lis[i].value=pageCurNo-Math.floor(pageNoCount/2)+i;
			lis[i].textContent=pageCurNo-Math.floor(pageNoCount/2)+i;
		}
		
		if(pageCurNo==lis[i].value){
			lis[i].setAttribute("class","curPage");
		}else{
			lis[i].setAttribute("class","otherPage");
		}
	}
}

function setPageSize(size){
	pageSize=size;
}
function setPageNoCount(count){
	pageNoCount = count;
}
function getPage(pageNo){
	pageCurNo = pageNo;
	getCurPageInfo();
}
function prePage(){
	pageCurNo--;
	getCurPageInfo();
}

function postPage(){
	pageCurNo++;
	getCurPageInfo();
}


//function show(res) is needed!!!
function getCurPageInfo(){
	var start = (pageCurNo-1)*pageSize;
	var end = pageCurNo<totalPage?pageCurNo*pageSize:totalData.length;
	//alert(start+':'+end);
	
/*	var tmp=[];
	console.log(JSON.stringify(totalData));
	for(var i=start;i<end;i++){
		//console.log(i+":"+totalData[i]);
		tmp[i-start]=totalData[i];
		//alert(tmp[i-start]);
	}*/
	
	//return tmp;
	//console.log(totalData.slice(0,5));
	pagePlay();
	show(totalData.slice(start,end));
}
