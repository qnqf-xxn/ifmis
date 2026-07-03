function getUrlParam(val,url){
    var uri = url||window.location.search;
    var re = new RegExp("(\\?|&)" +val+ "\=([^\&\?]*)", "ig");
    return ((uri.match(re))?(uri.match(re)[0].substr(val.length+2)):null);
}
var a1Url = "../bigdataview/dbfx/getInevalListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var b1_6Url = "../bigdataview/dbfx/getTextData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var c1Url = "../bigdataview/dbfx/getInevalRateListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var d1Url = "../bigdataview/dbfx/getAnalysisListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
function inintData() {
    $.ajax({
        method: 'post',
        url: b1_6Url,
        dataType: "json",
        success: function (data) {
            if(data != null){
                setTimeout(function () {
                    debugger;
                    //B1-6
                    $('#traceamt').append('<span class="shu" style="display:inline">'+data.traceamt+'</span>');
                    $('#evalselfamt').append('<span class="shu" style="display:inline">'+data.evalselfamt+'</span>');
                    $('#traceprocount').append('<span class="shu" style="display:inline">'+data.traceprocount+'</span>');
                    $('#evalselfprocount').append('<span class="shu" style="display:inline">'+data.evalselfprocount+'</span>');
                    $('#tracedeviate').append('<span class="shu" style="display:inline">'+data.tracedeviate+'</span>');
                    $('#evalselfscore').append('<span class="shu" style="display:inline">'+data.evalselfscore+'</span>');
                    $(".shu").numScroll();
                }, 30);
            }
        }
    });
};
function chartdivC1(){
    $.ajax({
        method: 'post',
        url: c1Url,
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            //指定图表的配置项和数据
            var years = result.years;
            var dataAxis = result.xAxis;
            var data1 = result.series1;
            var data2 = result.series2;
            var data3 = result.series3;
            option = {
                tooltip: {
                    trigger: 'axis',
                    axisPointer: {type: 'shadow'},
                },grid: {
                    top: '40',
                    left: '60',
                    right: '30',
                    bottom: '20'
                },
                legend: {
                    data: ['监控项目总量', '自评项目总量', '纳入自评占比率'],
                    right: 'center', width:'99%',
                    textStyle: {
                        color: "#fff"
                    },
                    itemWidth: 12,
                    itemHeight: 10,
                },
                "xAxis": [
                    {
                        "type": "category",
                        data: dataAxis,
                        axisLine: { lineStyle: {color: "rgba(255,255,255,.1)"}},
                        axisLabel:  { textStyle: {color: "rgba(255,255,255,.7)", fontSize: '14', }
                        },
                    },
                ],
                "yAxis": [
                    {
                        "type": "value",
                        "name": "自评项目总量",
                        data: data2,
                        axisTick: {show: false},
                        splitLine: {
                            show: false,
                        },
                        "axisLabel": {
                            "show": true,
                            fontSize:14,
                            color: "rgba(255,255,255,.6)"

                        },
                        axisLine: {
                            min:0,
                            max:10,
                            lineStyle: {color: 'rgba(255,255,255,.1)'}
                        },//左线色
                    },
                    {
                        "type": "value",
                        data: data3,
                        "name": "纳入自评占比率",
                        "show": true,
                        "axisLabel": {
                            "show": true,
                            fontSize:14,
                            formatter: "{value} %",
                            color: "rgba(255,255,255,.6)"
                        },
                        axisTick: {show: false},
                        axisLine: {lineStyle: {color: 'rgba(255,255,255,.1)'}},//右线色
                        splitLine: {show:true,lineStyle: {color:'rgba(255,255,255,.1)'}},//x轴线
                    },
                ],
                "series": [
                    {
                        "name": "监控项目总量",
                        "type": "bar",
                        "data": data1,
                        "barWidth": "15%",
                        "itemStyle": {
                            "normal": {
                                barBorderRadius: 15,
                                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                    offset: 0,
                                    color: '#8bd46e'
                                }, {
                                    offset: 1,
                                    color: '#09bcb7'
                                }]),
                            }
                        },
                        "barGap": "0.2"
                    },
                    {
                        "name": "自评项目总量",
                        "type": "bar",
                        "data":data2,
                        "barWidth": "15%",
                        "itemStyle": {
                            "normal": {
                                barBorderRadius: 15,
                                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                    offset: 0,
                                    color: '#ff9f46'
                                }, {
                                    offset: 1,
                                    color: '#ff9f46'
                                }]),
                            }
                        },
                        "barGap": "0.2"
                    },
                    {
                        "name": "纳入自评占比率",
                        "type": "bar",
                        "data":data3,
                        "barWidth": "15%",
                        "itemStyle": {
                            "normal": {
                                barBorderRadius: 15,
                                color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [{
                                    offset: 0,
                                    color: '#e7280a'
                                }, {
                                    offset: 1,
                                    color: '#e7280a'
                                }]),
                            }
                        },
                        "barGap": "0.2"
                    }
                ]
            };
            var myChart = echarts.init(document.getElementById('echarts1'));
            myChart.setOption(option);
            window.addEventListener("resize",function(){
                myChart.resize();
            });
            myChart.on('click', function (params) {
                var currentIndex = params.dataIndex;
                var year = years[currentIndex];
                var queryurl = "../program/traceselfeval/query.page?menuId=7U7AD7F3D9928F2CE79799997ED5BB66";
                queryurl += "&queryyear="+year+"&tokenid="+getUrlParam('tokenid',window.location.search);
                window.open(queryurl, '_blank');
            });
        }
    });
}
function chartdivA1() {
    $.ajax({
        method: 'post',
        url: a1Url,
        dataType: "json",
        success: function (data) {
            debugger;
            var inevallist = data.option;
            if(inevallist!= undefined){
                for (var i = 0 ;i<inevallist.length;i++){
                    var ineval = inevallist[i];
                    var queryurl = "../program/traceselfeval/query.page?menuId=7U7AD7F3D9928F2CE79799997ED5BB66";
                    queryurl += "&deptcode="+ineval.dept_code+"&tokenid="+getUrlParam('tokenid',window.location.search);
                    $('#inevallist').append('<li> <span class="container"><a href="'+queryurl+'" target="_blank">'+ineval.dept_name+'</a></span> <span>'+ineval.traceprocount+'</span>'+
                        ' <span>'+ineval.evalselfprocount+'</span> <span>'+ineval.inevalrate+'%</span> </li>');
                }
            }
            setTimeout(function () {
                $('.inevallistDiv').liMarquee({
                    direction: 'up',//身上滚动
                    runshort: false,//内容不足时不滚动
                    scrollamount: 20//速度
                });
            }, 30);
        }
    });
}
function chartdivD1() {
    $.ajax({
        method: 'post',
        url: d1Url,
        dataType: "json",
        success: function (data) {
            debugger;
            var analysislist = data.option;
            if(analysislist!= undefined){
                for (var i = 0 ;i<analysislist.length;i++){
                    var analysis = analysislist[i];
                    var queryurl = "../program/traceselfeval/query.page?menuId=7U7AD7F3D9928F2CE79799997ED5BB66";
                    queryurl += "&deptcode="+analysis.dept_code+"&tokenid="+getUrlParam('tokenid',window.location.search);
                    $('#analysislist').append('<li> <span class="container"><a href="'+queryurl+'" target="_blank">'+analysis.dept_name+'</a></span> <span class="text-green">'+analysis.tracedeviate+'%</span>'+
                        '<span>'+analysis.evalselfscore+'</span> <span>'+analysis.tracerate+'%</span> <span>'+analysis.evalselfrate+'%</span> </li>');
                }
            }
            setTimeout(function () {
                $('.analysislistDiv').liMarquee({
                    direction: 'up',//身上滚动
                    runshort: false,//内容不足时不滚动
                    scrollamount: 20//速度
                });
            }, 100);
        }
    });
}
$(function() {
    var whei=$(window).width()
    $("html").css({fontSize:whei/20})
    $(window).resize(function(){
        var whei=$(window).width()
        $("html").css({fontSize:whei/20})
    });
    inintData();
    chartdivA1();
    chartdivC1();
    chartdivD1();
});

$('.counter').countUp();

$("input[name='countDown']").each(function () {
    var time_end = this.value;
    var con = $(this).next("span");
    var _ = this.dataset;
    countDown(con, {
        time_end: time_end//开始时间
    })
        //提供3个事件分别为:启动,重启,停止
        .on("countDownStarted countDownRestarted  countDownEnded ", function (arguments) {
            console.info(arguments);
        });
});