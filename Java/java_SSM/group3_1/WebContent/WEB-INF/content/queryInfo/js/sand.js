$(function(){
	$("#toTopButton").click(function(){
		$("body").animate({
			scrollTop:0
		},500);
	})
})


$(window).scroll(function(){
	if($(window).scrollTop() > 600){
		$("#toTopButton").stop(true,true).fadeIn(500);
	}else{
		$("#toTopButton").stop(true,true).fadeOut(500);
	}
})
