function getUrlParam(val,url){
    var uri = url||window.location.search;
    var re = new RegExp("(\\?|&)" +val+ "\=([^\&\?]*)", "ig");
    return ((uri.match(re))?(uri.match(re)[0].substr(val.length+2)):null);
}
var aUrl = "../bigdataview/selfeval/getTextData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var b1Url = "../bigdataview/selfeval/getBgtgetRate.do?tokenid="+getUrlParam('tokenid',window.location.search);
var b2Url = "../bigdataview/selfeval/getEvalListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var c1Url = "../bigdataview/selfeval/getIndexListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var c2Url = "../bigdataview/selfeval/getIndexAdjListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var c3Url = "../bigdataview/selfeval/getIndexAdjRateListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
var c4Url = "../bigdataview/selfeval/getIndexAdjListData2.do?tokenid="+getUrlParam('tokenid',window.location.search);
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
                    $('#evalagencycount').text(data.evalagencycount);
                    $('#agencycount').text(data.agencycount);
                    $('#evalprojcount').text(data.evalprojcount);
                    $('#projcount').text(data.projcount);
                    $('#zpamt1').text(data.zpamt1);
                    $('#zpamt2').text(data.zpamt2);
                    $('#zpamt3').text(data.zpamt3);
                    $('#zpamt4').text(data.zpamt4);
                    $('#evalbgtget').text(data.evalbgtget);
                    $('#evalscore').text(data.evalscore);
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
function chartdivB1() {
    $.ajax({
        method: 'post',
        url: b1Url,
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
                    show:true,
                    type: 'scroll',
                    orient: 'vertical',
                    right: 10,
                    top: 10,
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
function chartdivB2(){
    $.ajax({
        method: 'post',
        url: b2Url,
        dataType: "json",
        success: function (data) {
            if(data != null){
                var datas = data.option;
                if(datas!= undefined){
                    for (var i = 0 ;i<datas.length;i++){
                        var rowdata = datas[i];
                        var queryurl = "../perfself/query.page?menuId=3AB2573C68B34E6C80ABB2D41FB30062&proworkflow=97453626C11A83A453494FB4E08F3C16&deptworkflow=AB1C3F88E5BA9F021C1D2B249ADBDA27";
                        queryurl += "&deptcode="+rowdata.dept_code+"&tokenid="+getUrlParam('tokenid',window.location.search);
                        $('#zpfxlist').append('<ul class="ul_con"><li class="container"><a href="'+queryurl+'" target="_blank">'+rowdata.div_name+'</a></li>'+
                            '<li>'+rowdata.div_code+'</li><li>'+rowdata.deptcount+'</li><li>'+rowdata.projectcount+'</li><li>'+rowdata.adjustamt+'</li></ul>');
                    }
                }
            }
            setTimeout(function () {
                $('.zpfxlistDiv').liMarquee({
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
                            $('#indexvallist').append('<li><div class="liIn '+colorline+'">'+
                                '<div class="liIn_left"><span class="bot"></span><span class="zi">'+index.name+'</span></div>'+
                                '<div class="liIn_line"><div class="line_lineIn" style="width:'+index.rate+'%;"></div></div>'+
                                '<p class="num">'+index.rate+'%</p></div></li>');
                        }
                    }
                }, 30);
            }
        }
    });
}

function chartdivC2() {
    $.ajax({
        method: 'post',
        url: c2Url,
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
                            $('#indexadjlist1').append('<li><div class="liIn '+colorline+'">'+
                                '<div class="liIn_left"><span class="bot"></span><span class="zi">'+index.name+'</span></div>'+
                                '<div class="liIn_line"><div class="line_lineIn" style="width:'+index.rate+'%;"></div></div>'+
                                '<p class="num">'+index.rate+'%</p></div></li>');
                        }
                    }
                }, 30);
            }
        }
    });
}
function chartdivC4() {
    $.ajax({
        method: 'post',
        url: c4Url,
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
                            $('#indexadjlist2').append('<li><div class="liIn '+colorline+'">'+
                                '<div class="liIn_left"><span class="bot"></span><span class="zi">'+index.name+'</span></div>'+
                                '<div class="liIn_line"><div class="line_lineIn" style="width:'+index.rate+'%;"></div></div>'+
                                '<p class="num">'+index.rate+'%</p></div></li>');
                        }
                    }
                }, 30);
            }
        }
    });
}
function chartdivC3() {
    $.ajax({
        method: 'post',
        url: c3Url,
        dataType: "json",
        success: function (data) {
            if(data != null){
                var datas = data.option;
                if(datas!= undefined){
                    for (var i = 0 ;i<datas.length;i++){
                        var rowdata = datas[i];
                        var queryurl = "../perfself/query.page?menuId=3AB2573C68B34E6C80ABB2D41FB30062&proworkflow=97453626C11A83A453494FB4E08F3C16&deptworkflow=AB1C3F88E5BA9F021C1D2B249ADBDA27";
                        queryurl += "&deptcode="+rowdata.dept_code+"&tokenid="+getUrlParam('tokenid',window.location.search);
                        $('#indexadjdeptlist').append('<ul class="ul_con"><li class="container"><a href="'+queryurl+'" target="_blank">'+rowdata.dept_name+'</a></li>'+
                            '<li>'+rowdata.dept_code+'</li><li>'+rowdata.projectrate+'</li><li>'+rowdata.indexrate+'</li><li>'+rowdata.evalselfrate+'</li><li>'+rowdata.evalselfscore+'</li></ul>');
                    }
                }
            }
            setTimeout(function () {
                $('.indexadjdeptlistDiv').liMarquee({
                    direction: 'up',//身上滚动
                    runshort: false,//内容不足时不滚动
                    scrollamount: 20//速度
                });
            }, 100);
        }
    });
}
$(function() {
    inintData();
    chartdivB1();
    chartdivB2();
    chartdivC1();
    chartdivC2();
    chartdivC3();
    chartdivC4();
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