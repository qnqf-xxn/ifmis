function getUrlParam(val,url){
    var uri = url||window.location.search;
    var re = new RegExp("(\\?|&)" +val+ "\=([^\&\?]*)", "ig");
    return ((uri.match(re))?(uri.match(re)[0].substr(val.length+2)):null);
}
var aUrl = "../bigdataview/trace/getTextData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var b1Url = "../bigdataview/trace/getDeptDeviateListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var b2Url = "../bigdataview/trace/getProjectReportData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var c1Url = "../bigdataview/trace/getIndexDeviateListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var d1Url = "../bigdataview/trace/getDeptWarnData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var e1Url = "../bigdataview/trace/getProjproblemData.do?tokenid="+getUrlParam('tokenid',window.location.search);
function inintData() {
    $.ajax({
        method: 'post',
        url: aUrl,
        dataType: "json",
        success: function (data) {
            if(data != null){
                setTimeout(function () {
                    debugger;
                    //A1-4
                    $('#traceagencycount').text(data.traceagencycount);
                    $('#agencycount').text(data.agencycount);
                    $('#traceprojcount').text(data.traceprojcount);
                    $('#projcount').text(data.projcount);
                    $('#bgtyeallowcount').text(data.bgtyeallowcount);
                    $('#bgtredcount').text(data.bgtredcount);
                    $('#goalyeallowprojcount').text(data.goalyeallowprojcount);
                    $('#goalredprojcount').text(data.goalredprojcount);
                    //C2
                    $('#deptcount').text(data.deptcount);
                    $('#agencycount').text(data.agencycount);
                    $('#amttotal').text(data.amttotal);
                    $('#exeamt').text(data.exeamt);
                    $('#paydeviate').text(data.paydeviate);
                    $('#indexdeviate').text(data.indexdeviate);
                    $(".shu1").numScroll();
                    $(".shu2").numScroll();
                    $(".shu3").numScroll();
                    $(".shu4").numScroll();
                    $(".shu5").numScroll();
                    $(".shu6").numScroll();
                }, 30);
            }
        }
    });
};
function chartdivB1(desc){
    $.ajax({
        method: 'post',
        url: b1Url,
        data: desc ? "1" : "0",
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            //指定图表的配置项和数据
            var deptcodes = result.deptcodes;
            var dataAxis = result.xAxis;
            var data1 = result.series1;
            var data2 = result.series2;
            var option = {
                title: {
                    text: '',
                    subtext: ''
                },
                legend: {
                    data: ['全年预计执行率', '1-8月预算执行情况'],
                    textStyle:{
                        color: '#fff'
                    }
                },
                grid:{
                    top: '40',
                    left: '40',
                    right: '20',
                    bottom: '20'
                },
                tooltip: {
                    trigger: 'item'
                },
                xAxis: {
                    data: dataAxis,
                    axisLabel: {
                        /*inside: true,*/
                        interval:0,
                        textStyle: {
                            color: '#fff',
                            fontSize: 12
                        },
                        interval: 0,  // 隐藏所有刻度
                        formatter: function (value, index) {
                            // 自定义刻度显示格式
                            if (value.length > 5) {
                                return value.slice(0, 5) + '...';  // 截取前10个字符并添加省略号
                            } else {
                                return value;  // 正常显示
                            }
                        }
                    },
                    axisTick: {
                        show: false,
                    },
                    axisLine: {
                        show: true,
                        symbol:['none', 'arrow'],
                        symbolOffset: 12,
                        lineStyle:{
                            color: '#fff'
                        }
                    },
                    z: 10
                },
                yAxis: {
                    type: 'value',
                    name: '单位：%',
                    axisLine: {
                        show: true,
                        symbol: ['none', 'arrow'],
                        symbolOffset: 12,
                        lineStyle:{
                            color: '#fff',
                        }
                    },
                    axisTick: {
                        show: false
                    },
                    axisLabel: {
                        textStyle: {
                            color: '#fff',
                            fontSize: 12
                        }
                    }
                },

                dataZoom: [
                    {
                        type: 'inside'
                    }
                ],
                series: [
                    {
                        name:'全年预计执行率',
                        type: 'bar',
                        itemStyle: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#0efdff'},
                                    {offset: 0.5, color: '#188df0'},
                                    {offset: 1, color: '#188df0'}
                                ]
                            )
                        },
                        emphasis: {
                            itemStyle: {
                                color: new echarts.graphic.LinearGradient(
                                    0, 0, 0, 1,
                                    [
                                        {offset: 0, color: '#2378f7'},
                                        {offset: 0.7, color: '#2378f7'},
                                        {offset: 1, color: '#0efdff'}
                                    ]
                                )
                            }
                        },
                        data: data1
                    },
                    {
                        name:'1-8月预算执行情况',
                        type: 'bar',
                        itemStyle: {
                            color: new echarts.graphic.LinearGradient(
                                0, 0, 0, 1,
                                [
                                    {offset: 0, color: '#ff9f9f'},
                                    {offset: 0.5, color: '#fc3a3a'},
                                    {offset: 1, color: '#ff0e0e'}
                                ]
                            )
                        },
                        emphasis: {
                            itemStyle: {
                                color: new echarts.graphic.LinearGradient(
                                    0, 0, 0, 1,
                                    [
                                        {offset: 0, color: '#ff0e0e'},
                                        {offset: 0.7, color: '#fc3a3a'},
                                        {offset: 1, color: '#ff9f9f'}
                                    ]
                                )
                            }
                        },
                        data: data2
                    }
                ]
            };
            var myChart = echarts.init(document.getElementById('chartmain'));
            myChart.setOption(option);
            setTimeout(function(){
                myChart.resize();
            },30);
            myChart.on('click', function (params) {
                var currentIndex = params.dataIndex;
                var deptcode = deptcodes[currentIndex];
                var queryurl = "../program/trace/query.page?menuId=B5A085C812D20888E0535164A8C0487E&workflow=B7279B405D487EB4E0530100007FD738";
                queryurl += "&deptcode="+deptcode+"&tokenid="+getUrlParam('tokenid',window.location.search);
                window.open(queryurl, '_blank');
            });
        }
    });
}
function chartdivB2(){
    $.ajax({
        method: 'post',
        url: b2Url,
        dataType: "json",
        success: function (data) {
            if(data != null){
                var deptwarnlist = data.option;
                if(deptwarnlist!= undefined){
                    for (var i = 0 ;i<deptwarnlist.length;i++){
                        var deptwarn = deptwarnlist[i];
                        var queryurl = "../program/trace/query.page?menuId=B5A085C812D20888E0535164A8C0487E&workflow=B7279B405D487EB4E0530100007FD738&divcode="+deptwarn.div_code+"&tokenid="+getUrlParam('tokenid',window.location.search);
                        $('#divamtlist').append('<ul class="ul_con"><li class="container"><a href="'+queryurl+'" target="_blank">'+deptwarn.div_name+'</a></li>'+
                            '<li>'+deptwarn.div_code+'</li><li>'+deptwarn.deptcount+'</li><li>'+deptwarn.projectcount+'</li><li>'+deptwarn.adjustamt+'</li></ul>');
                    }
                }
            }
            setTimeout(function () {
                $('.divamtlistDiv').liMarquee({
                    direction: 'up',//身上滚动
                    runshort: false,//内容不足时不滚动
                    scrollamount: 20//速度
                });
            }, 100);
        }
    });
}
function chartdivC1() {
    $.ajax({
        method: 'post',
        url: c1Url,
        dataType: "json",
        success: function (data) {
            if(data != null){
                setTimeout(function () {
                    var indexdeviatelist = data.option;
                    if(indexdeviatelist!= undefined){
                        for (var i = 0 ;i<indexdeviatelist.length;i++){
                            debugger;
                            var index = indexdeviatelist[i];
                            var colorline = (i == 0) ? '' : ('liIn'+(i+1));
                            $('#indexdeviatelist').append('<li><div class="liIn '+colorline+'">'+
                                '<div class="liIn_left"><span class="bot"></span><span class="zi">'+index.name+'</span></div>'+
                                '<div class="liIn_line"><div class="line_lineIn" style="width:'+index.rate+'%;"></div></div>'+
                                '<p class="num">'+index.deviate+'</p></div></li>');
                        }
                    }
                }, 30);
            }
        }
    });
}
function chartdivE1() {
    $.ajax({
        method: 'post',
        url: e1Url,
        dataType: "json",
        contentType: "application/json",
        success: function (result) {
            //指定图表的配置项和数据
            var divnames = result.divnames;
            var divscores = result.divscores;
            option = {
                tooltip: {
                    trigger: 'item',
                    formatter: '{b} : {c} ({d}%)'
                },
                legend: {
                    // orient: 'vertical',
                    // top: 'middle',
                    show:false,
                    type: 'scroll',
                    orient: 'vertical',
                    right: 10,
                    top: 40,
                    bottom: 20,
                    left: 'right',
                    data: divnames,
                    textStyle: {
                        color: '#fff',
                        fontSize: 12
                    }

                },
                grid:{
                    x:'-10%',
                    y:40,
                    x2:20,
                    y2:20,
                },
                color : [ '#09d0fb', '#f88cfb', '#95f8fe', '#f9f390',  '#ecfeb7' ],
                series: [
                    {
                        type: 'pie',
                        radius: '75%',
                        center: ['50%', '50%'],
                        selectedMode: 'single',
                        data: divscores,
                        emphasis: {
                            itemStyle: {
                                shadowBlur: 10,
                                shadowOffsetX: 0,
                                shadowColor: 'rgba(0, 0, 0, 0.5)'
                            }
                        }
                    }
                ]
            };
            //获取dom容器
            var myChart = echarts.init(document.getElementById('chartmain_bing'));
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }
    });
}
function chartdivD1() {
    $.ajax({
        method: 'post',
        url: d1Url,
        dataType: "json",
        success: function (data) {
            if(data != null){
                var deptwarnlist = data.option;
                if(deptwarnlist!= undefined){
                    for (var i = 0 ;i<deptwarnlist.length;i++){
                        var deptwarn = deptwarnlist[i];
                        var queryurl = "../program/trace/query.page?menuId=B5A085C812D20888E0535164A8C0487E&workflow=B7279B405D487EB4E0530100007FD738&deptcode="+deptwarn.dept_code+"&tokenid="+getUrlParam('tokenid',window.location.search);
                        $('#deptwarnlist').append('<ul class="ul_con"><li class="container"><a href="'+queryurl+'" target="_blank">'+deptwarn.dept_name+'</a></li>'+
                            '<li>'+deptwarn.dept_code+'</li><li>'+deptwarn.projectcount+'</li><li>'+deptwarn.sumdeptamt4+'</li><li>'+deptwarn.bgtget+'</li><li>'+deptwarn.yearbgtget+'</li></ul>');
                    }
                }
            }
            setTimeout(function () {
                $('.deptwarnlistDiv').liMarquee({
                    direction: 'up',//身上滚动
                    runshort: false,//内容不足时不滚动
                    scrollamount: 20//速度
                });
            }, 100);
        }
    });
}
$(function() {
    var desc = false;
    inintData();
    chartdivB1(desc);
    chartdivB2();
    chartdivC1();
    chartdivD1();
    chartdivE1();
    $("#changedivamtlist").click(function(){
        desc = desc ? false : true;
        chartdivB1(desc);
        $("#changedivamtlist").text(desc ? "切换前5名" : "切换后5名");
    });
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