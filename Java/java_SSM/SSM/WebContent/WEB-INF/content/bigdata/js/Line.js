$("#range21").click(function() {
	$("#range21").attr("class", "button_active");
	$("#range21").siblings().removeAttr("class", "button_active");
})
$("#range22").click(function() {
	$("#range22").attr("class", "button_active");
	$("#range22").siblings().removeAttr("class", "button_active");
})
var myChart2 = echarts.init(document.getElementById('Line'));
var option2;
function setOption2(){
option2 = {
    title: {
        text: '折线图'
    },
    tooltip: {
        trigger: 'axis'
    },
    legend: {
        data:['2016','2015']
    },
    grid: {
        left: '3%',
        right: '4%',
        bottom: '3%',
        containLabel: true
    },
    toolbox: {
        feature: {
            saveAsImage: {}
        }
    },
    xAxis: {
        type: 'category',
        boundaryGap: false,
        data: ['Jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec']
    },
    yAxis: {
        type: 'value'
    },
    series: [
        {
            name:'2016',
            type:'line',
            data:quantity2016
        },
        {
            name:'2015',
            type:'line',
            data:quantity2015
        }
    ]
};
}
