function start_audio(vname)
{
	var audio=document.getElementById("start");
	audio.getElementsByTagName("object").display="none"; 
	audio.innerHTML=""; 
	var inner="<object classid='CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6' classid='CLSID:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA' width='100%' height='500' align='top'> <param name='type' value='audio/mpeg' /><param name='URL'  value='songs/"+vname+"'><param name='uiMode' value='full' /><param name='autoStart' value='true' /><embed   width='100%' height='500px' type='audio/mpeg' src='songs/"+vname+"' controls='all' loop='false' autostart='true' pluginspage='http://www.microsoft.com/windows/windowsmedia/' /></object>";
	audio.innerHTML=inner;
	/*vname="songs/"+vname;
	var audio2=document.getElementById("change");
	audio2.setAttribute("value",vname);
	alert(audio2.value);
	document.getElementById("change").load();*/
	var name=document.getElementById("video_name");
	name.innerHTML=vname;
}
/*var funcGetSelectText = function(){
	var txt = '';
	if(document.selection){
		txt = document.selection.createRange().text;//ie
	}else{
		txt = document.getSelection();
	}
	return txt.toString();
}
var container = container || document;
container.onmouseup = function(){
	var txt = funcGetSelectText();
	if(txt)
	{
		//alert(txt);
	}
}*/
$(document).ready(function(){
	$("div").mouseover(function(){
		if(this.id=="mp3")
		{
			$("p").click(function(){
				start_audio(this.innerHTML+".mp3");
			});
		}
		else if(this.id=="mp4")
		{
			$("p").click(function(){
				start_audio(this.innerHTML+".mp4");
			});
		}
	});
});