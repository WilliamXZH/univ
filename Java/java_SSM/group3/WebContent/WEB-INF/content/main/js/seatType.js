$(function() {
	var NoLimited_train=["<-不限->"];
	var D_train = ["<-不限->","商务座", "一等座", "二等座"];
	var G_train = ["<-不限->","商务座", "一等座", "二等座"];
	var Z_train = ["<-不限->","高级软卧", "软卧", "硬卧", "无座"];
	var T_train = ["<-不限->","软卧", "硬卧", "硬座", "无座"];
	var P_train = ["<-不限->","软卧", "硬卧", "硬座", "无座"];
	var C_train = ["<-不限->","商务座", "一等座", "二等座"];
	var L_train = ["<-不限->","软座", "硬座", "无座"];
	var N_train = ["<-不限->","软座", "硬座", "无座"];
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
				var option = $("<option>").val("NoLimit").text(NoLimited_train[i]);
				$("select[name='seat']").append(option);
			}

		}
		else if(selected_value == "D") { //普通动车
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < D_train.length; i++) {
				var option = $("<option>").val("NoLimit").text(D_train[i]);
				$("select[name='seat']").append(option);
			}

		}
		else if(selected_value == "G") { //高速动车
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < G_train.length; i++) {
				var option = $("<option>").val("NoLimit").text(G_train[i]);
				$("select[name='seat']").append(option);
			}

		} 
		else if(selected_value == "Z") { //直达快递
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < Z_train.length; i++) {
				var option = $("<option>").val("NoLimit").text(Z_train[i]);
				$("select[name='seat']").append(option);
			}
		} 
		else if(selected_value == "T") { //特别快速
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < T_train.length; i++) {
				var option = $("<option>").val("NoLimit").text(T_train[i]);
				$("select[name='seat']").append(option);
			}

		} 
		else if(selected_value == "P") { //普通快速
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < P_train.length; i++) {
				var option = $("<option>").val("NoLimit").text(P_train[i]);
				$("select[name='seat']").append(option);
			}

		} 
		else if(selected_value == "C") { //城际列车
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < C_train.length; i++) {
				var option = $("<option>").val("NoLimit").text(C_train[i]);
				$("select[name='seat']").append(option);
			}

		} 
		else if(selected_value == "L") { //临时列车
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < L_train.length; i++) {
				var option = $("<option>").val("NoLimit").text(L_train[i]);
				$("select[name='seat']").append(option);
			}

		} 
		else if(selected_value == "N") { //管内快速
			$("select[name='seat']").empty();
			//循环添加
			for(var i = 0; i < N_train.length; i++) {
				var option = $("<option>").val("NoLimit").text(N_train[i]);
				$("select[name='seat']").append(option);
			}

		} 
	});

});