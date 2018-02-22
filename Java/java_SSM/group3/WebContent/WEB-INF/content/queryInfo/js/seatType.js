$(function() {
	var NoLimited_train=["<---不限--->"];
	var GaoTie_train = ["<---不限--->","商务座", "一等座", "二等座"];
	var DongChe_train = ["<---不限--->","一等座", "二等座", "无座"];
	var ZhiDa_train = ["<---不限--->","高级软卧", "软卧", "硬卧", "无座"];
	var tekuai_train = ["<---不限--->","软卧", "硬卧", "硬座", "无座"];
	var kuaisu_train = ["<---不限--->","软卧", "硬卧", "硬座", "无座"];

	$("select[name='train']").change(function() {
		//被选中的option
		var selected_value = $(this).val();

		if(selected_value == "select") {
			$("select[name='seat']").empty();

		} 
		else if(selected_value == "NoLimit") { //不限
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < NoLimited_train.length; i++) {
				var option = $("<option>").val(NoLimited_train[i]).text(NoLimited_train[i]);
				$("select[name='seat']").append(option);
			}

		}
		
		else if(selected_value == "GaoTie") { //高铁
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < GaoTie_train.length; i++) {
				var option = $("<option>").val(GaoTie_train[i]).text(GaoTie_train[i]);
				$("select[name='seat']").append(option);
			}

		} else if(selected_value == "DongChe") { //动车
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < DongChe_train.length; i++) {
				var option = $("<option>").val(DongChe_train[i]).text(DongChe_train[i]);
				$("select[name='seat']").append(option);
			}

		} else if(selected_value == "tekuai") { //特快
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < tekuai_train.length; i++) {
				var option = $("<option>").val(tekuai_train[i]).text(tekuai_train[i]);
				$("select[name='seat']").append(option);
			}

		} else if(selected_value == "kuaisu") { //快速
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < kuaisu_train.length; i++) {
				var option = $("<option>").val(kuaisu_train[i]).text(kuaisu_train[i]);
				$("select[name='seat']").append(option);
			}

		} else if(selected_value == "ZhiDa") { //山东
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < ZhiDa_train.length; i++) {
				var option = $("<option>").val(ZhiDa_train[i]).text(ZhiDa_train[i]);
				$("select[name='seat']").append(option);
			}
		}
	});

});