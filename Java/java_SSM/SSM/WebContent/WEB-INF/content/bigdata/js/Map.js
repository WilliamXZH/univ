$("#range31").click(function() {
	$("#range31").attr("class", "button_active");
	$("#range31").siblings().removeAttr("class", "button_active");
})
$("#range32").click(function() {
	$("#range32").attr("class", "button_active");
	$("#range32").siblings().removeAttr("class", "button_active");
})
var myChart3 = echarts.init(document.getElementById('map'));
var option3;
function setOption3() {

	var geoCoordMap = {
		'北京' : [ 116.4551, 40.2539 ],		
		'拉萨' : [ 91.1115, 29.6560 ],
		'成都' : [ 104.0695, 30.6667 ],
	    '昆明' : [ 102.7133, 25.0541 ],
	    '桂林' : [ 110.2832, 25.2699 ],
	    '呼和浩特' : [ 111.6891, 40.8492 ],
	    '贵阳' : [ 106.6449, 26.6532 ],
	    '上海' : [ 121.4787, 31.2379 ],
	    '深圳' : [ 114.0638, 22.5484 ],		
	    '杭州' : [ 119.5313, 29.8773 ],
		'南京' : [ 118.8013, 32.0654 ],
		'武汉' : [ 114.3896, 30.6628 ],
		'天津' : [ 117.4219, 39.4189 ],
		'西安' : [ 109.1162, 34.2004 ],
		'重庆' : [ 107.7539, 30.1904 ],
		'青岛' : [ 120.4651, 36.3373 ],
		'沈阳' : [ 123.1238, 42.1216 ],
		'长沙' : [ 113.0823, 28.2568 ],
		'大连' : [ 122.2229, 39.4409 ],
		'厦门' : [ 118.1689, 24.6478 ],
		'无锡' : [ 120.3442, 31.5527 ],
		'福州' : [ 119.4543, 25.9222 ],
		'济南' : [ 117.1582, 36.8701 ]
	};

	/*
	 * var ALLData = [ [ { name : '北京' }, { name : '上海' } ], [ { name : '北京' }, {
	 * name : '天津' } ], [ { name : '北京' }, { name : '济南' } ], [ { name : '北京' }, {
	 * name : '沈阳' } ], [ { name : '北京' }, { name : '大连' } ], [ { name : '北京' }, {
	 * name : '青岛' } ], [ { name : '北京' }, { name : '西安' } ], [ { name : '上海' }, {
	 * name : '无锡' } ], [ { name : '上海' }, { name : '南京' } ], [ { name : '上海' }, {
	 * name : '杭州' } ], [ { name : '上海' }, { name : '武汉' } ], [ { name : '上海' }, {
	 * name : '福州' } ], [ { name : '广州' }, { name : '深圳' } ], [ { name : '广州' }, {
	 * name : '厦门' } ], [ { name : '广州' }, { name : '长沙' } ], [ { name : '广州' }, {
	 * name : '福州' } ] ];
	 */
	/*
	 * var BJData = [ [ { name : '北京' }, { name : '上海' } ], [ { name : '北京' }, {
	 * name : '天津' } ], [ { name : '北京' }, { name : '济南' } ], [ { name : '北京' }, {
	 * name : '沈阳' } ], [ { name : '北京' }, { name : '大连' } ], [ { name : '北京' }, {
	 * name : '青岛' } ], [ { name : '北京' }, { name : '西安' } ] ];
	 * 
	 * var SHData = [ [ { name : '上海' }, { name : '无锡' } ], [ { name : '上海' }, {
	 * name : '南京' } ], [ { name : '上海' }, { name : '杭州' } ], [ { name : '上海' }, {
	 * name : '武汉' } ], [ { name : '上海' }, { name : '福州' } ] ];
	 * 
	 * var GZData = [ [ { name : '广州' }, { name : '深圳' } ], [ { name : '广州' }, {
	 * name : '厦门' } ], [ { name : '广州' }, { name : '长沙' } ], [ { name : '广州' }, {
	 * name : '福州' } ] ];
	 * 
	 * var SZData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var CDData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var HZData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var NJData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var WHData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var TJData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var XAData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var CQData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var QDData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var SYData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var CSData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var DLData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var XMData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var WXData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var FZData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 * 
	 * var JNData = [ [ { name : '广州' }, { name : '福州' } ] ];
	 */
	var planePath = 'path://M1705.06';

	var convertData = function(data) {
		var res = [];
		for (var i = 0; i < data.length; i++) {
			var dataItem = data[i];
			var fromCoord = geoCoordMap[dataItem[0].name];
			var toCoord = geoCoordMap[dataItem[1].name];
			if (fromCoord && toCoord) {
				res.push({
					fromName : dataItem[0].name,
					toName : dataItem[1].name,
					coords : [ fromCoord, toCoord ]
				});
			}
		}
		return res;
	};

	/*
	 * var color = [ '#003366', '#003366', '#003366', '#003366', '#003366',
	 * '#003366', '#003366', '#003366', '#003366', '#003366', '#003366',
	 * '#003366', '#003366', '#003366', '#003366', '#003366', '#003366',
	 * '#003366', '#003366', '#003366' ];
	 */
	var series = [];
	[ [ '概览', temp1 ], [ '概览', temp2 ], [ '概览', temp3 ] ].forEach(function(
			item, i) {
		series.push({
			name : item[0],
			type : 'lines',
			zlevel : 1,
			effect : {
				show : true,
				period : 6,
				trailLength : 0.7,
				color : item[1][0][2].color,
				symbolSize : 3
			},
			lineStyle : {
				normal : {
					color : item[1][0][2].color,
					width : 0,
					curveness : 0.2
				}
			},
			data : convertData(item[1])
		}, {
			name : item[0],
			type : 'lines',
			zlevel : 2,
			symbol : [ 'none', 'arrow' ],
			symbolSize : 10,
			effect : {
				show : true,
				period : 6,
				trailLength : 0,
				symbol : planePath,
				symbolSize : 15
			},
			lineStyle : {
				normal : {
					color : item[1][0][2].color,
					width : 1,
					opacity : 0.6,
					curveness : 0.2
				}
			},
			data : convertData(item[1])
		}, {
			name : item[0],
			type : 'effectScatter',
			coordinateSystem : 'geo',
			zlevel : 2,
			rippleEffect : {
				brushType : 'stroke'
			},
			label : {
				normal : {
					show : true,
					position : 'right',
					formatter : '{b}',
					textStyle : {
						fontSize : 18,
						color : "black"
					}
				}
			},
			symbolSize : 3,
			/*
			 * symbolSize : function(val) { return val[2] / 8; }, itemStyle : {
			 * normal : { color : color[i] } },
			 */
			data : item[1].map(function(dataItem) {
				return {
					name : dataItem[1].name,
					value : geoCoordMap[dataItem[1].name]
				};
			})
		});
	});

	option3 = {
		backgroundColor : 'white',
		title : {
			text : '铁路路线压力图',
			left : 'center',
			textStyle : {
				fontSize : '25',
				color : 'black'
			}
		},
		tooltip : {
			trigger : 'item'
		},
		legend : {
			orient : 'horizontal',
			top : 'bottom',
			left : 'right',
			data : [ '概览', '北京', '上海', '广州', '深圳', '成都', '杭州', '南京', '武汉',
					'天津', '西安', '重庆', '青岛', '沈阳', '长沙', '大连', '厦门', '无锡', '福州',
					'济南' ],
			textStyle : {
				color : 'black'
			},
			selectedMode : 'single'
		},
		geo : {
			map : 'china',
			label : {
				emphasis : {
					show : false
				}
			},
			roam : false,
			itemStyle : {
				normal : {
					areaColor : '#FFFAE8',
					borderColor : '#404a59'
				},
				emphasis : {
					areaColor : '#BCD68D'
				}
			}
		},
		series : series
	};
}
