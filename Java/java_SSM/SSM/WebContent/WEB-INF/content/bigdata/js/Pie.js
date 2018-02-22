$("#range11").click(function() {
	$("#range11").attr("class", "button_active");
	$("#range11").siblings().removeAttr("class", "button_active");
})
$("#range12").click(function() {
	$("#range12").attr("class", "button_active");
	$("#range12").siblings().removeAttr("class", "button_active");
})
$("#range13").click(function() {
	$("#range13").attr("class", "button_active");
	$("#range13").siblings().removeAttr("class", "button_active");
})

var myChart1 = echarts.init(document.getElementById('Pie'));
var option1;
/*var data1 = [{
	value: 335,
	name: '直接访问'
}, {
	value: 310,
	name: '邮件营销'
}, {
	value: 274,
	name: '联盟广告'
}, {
	value: 235,
	name: '视频广告'
}, {
	value: 400,
	name: '搜索引擎'
}];*/
function setOption1(){
	option1 = {
	backgroundColor: 'white',

	title: {
		text: 'Customized Pie',
		left: 'center',
		top: 20,
		textStyle: {
			color: 'black'
		}
	},

	tooltip: {
		trigger: 'item',
		formatter: "{a} <br/>{b} : {c} ({d}%)"
	},

	visualMap: {
		show: false,
		min: 80,
		max: 450,
		inRange: {
			colorLightness: [0.6, 1]
		}
	},
	series: [{
		name: '访问来源',
		type: 'pie',
		radius: '65%',
		center: ['50%', '50%'],
		data: data1.sort(function(a, b) {
			return a.value - b.value;
		}),
		roseType: 'radius',
		label: {
			normal: {
				textStyle: {
					color: 'black'
				}
			}
		},
		labelLine: {
			normal: {
				lineStyle: {
					color: 'lightgray'
				},
				smooth: 0.2,
				length: 10,
				length2: 20
			}
		},
		itemStyle: {
			normal: {
				color: '#c23531',
				shadowBlur: 200,
				shadowColor: 'white'
			}
		},

		animationType: 'scale',
		animationEasing: 'elasticOut',
		animationDelay: function(idx) {
			return Math.random() * 200;
		}
	}]
};
}