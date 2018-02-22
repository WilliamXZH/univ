$("#range41").click(function() {
	$("#range41").attr("class", "button_active");
	$("#range41").siblings().removeAttr("class", "button_active");
})
$("#range42").click(function() {
	$("#range42").attr("class", "button_active");
	$("#range42").siblings().removeAttr("class", "button_active");
})
var myChart4 = echarts.init(document.getElementById('dot'));
var option4;
function setOption4() {
	option4 = {
		title : {
			text : '用户购票散点图'
		},
		grid : {
			left : '3%',
			right : '7%',
			bottom : '3%',
			containLabel : true
		},
		tooltip : {
			// trigger: 'axis',
			showDelay : 0,
			formatter : function(params) {
				if (params.value.length > 1) {
					return params.seriesName + ' :<br/>' + params.value[0]
							+ '岁 ' + params.value[1] + '张 ';
				} else {
					return params.seriesName + ' :<br/>' + params.name + ' : '
							+ params.value + '张 ';
				}
			},
			axisPointer : {
				show : true,
				type : 'cross',
				lineStyle : {
					type : 'dashed',
					width : 1
				}
			}
		},
		toolbox : {
			feature : {
				dataZoom : {},
				brush : {
					type : [ 'rect', 'polygon', 'clear' ]
				}
			}
		},
		brush : {},
		legend : {
			data : [ '女性', '男性' ],
			left : 'center'
		},
		xAxis : [ {
			type : 'value',
			scale : true,
			axisLabel : {
				formatter : '{value} 岁'
			},
			splitLine : {
				show : false
			}
		} ],
		yAxis : [ {
			type : 'value',
			scale : true,
			axisLabel : {
				formatter : '{value} 张'
			},
			splitLine : {
				show : false
			}
		} ],
		series : [
				{
					name : '女性',
					type : 'scatter',
					data : man,
					markArea : {
						silent : true,
						itemStyle : {
							normal : {
								color : 'transparent',
								borderWidth : 1,
								borderType : 'dashed'
							}
						},
						data : [ [ {
							name : '女性分布区间',
							xAxis : 'min',
							yAxis : 'min'
						}, {
							xAxis : 'max',
							yAxis : 'max'
						} ] ]
					},
					markPoint : {
						data : [ {
							type : 'max',
							name : '最大值'
						}, {
							type : 'min',
							name : '最小值'
						} ]
					},
					markLine : {
						lineStyle : {
							normal : {
								type : 'solid'
							}
						},
						data : [ {
							type : 'average',
							name : '平均值'
						}, {
							xAxis : 160
						} ]
					}
				},
				{
					name : '男性',
					type : 'scatter',
					data : woman,
					markArea : {
						silent : true,
						itemStyle : {
							normal : {
								color : 'transparent',
								borderWidth : 1,
								borderType : 'dashed'
							}
						},
						data : [ [ {
							name : '男性分布区间',
							xAxis : 'min',
							yAxis : 'min'
						}, {
							xAxis : 'max',
							yAxis : 'max'
						} ] ]
					},
					markPoint : {
						data : [ {
							type : 'max',
							name : '最大值'
						}, {
							type : 'min',
							name : '最小值'
						} ]
					},
					markLine : {
						lineStyle : {
							normal : {
								type : 'solid'
							}
						},
						data : [ {
							type : 'average',
							name : '平均值'
						}, {
							xAxis : 170
						} ]
					}
				} ]
	};
}