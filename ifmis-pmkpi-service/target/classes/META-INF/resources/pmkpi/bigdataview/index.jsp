<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<meta name="description" content="">
<meta name="keywords" content="">

<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<title>绩效监控数据中心</title>
<!--大屏-->
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/jquery-1.11.0.min.js"></script>
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/jquery.numscroll.js"></script>
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/echarts.all.js"></script>
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/echarts.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=(String) request.getAttribute("appidpath")%>/bigdataview/css/public.css">
<link rel="stylesheet" type="text/css" href="<%=(String) request.getAttribute("appidpath")%>/bigdataview/css/icon.css">
<link rel="stylesheet" type="text/css" href="<%=(String) request.getAttribute("appidpath")%>/bigdataview/css/index.css">
<script type="text/javascript">
        document.documentElement.style.fontSize = document.documentElement.clientWidth /768*100 + 'px';
</script>
</head>
<style>
    .container {
        width: 200px;
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .container:hover {
        overflow: visible;
        text-overflow: inherit;
        white-space: nowrap;
    }

</style>

<script type="text/javascript">
    function getUrlParam(val,url){
        var uri = url||window.location.search;
        var re = new RegExp("(\\?|&)" +val+ "\=([^\&\?]*)", "ig");
        return ((uri.match(re))?(uri.match(re)[0].substr(val.length+2)):null);
    }
    var aUrl = "../bigdataview/getTextData.do?tokenid="+getUrlParam('tokenid',window.location.search);
    var b1Url = "../bigdataview/getDeptDeviateListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
    var b2Url = "../bigdataview/getProjectReportData.do?tokenid="+getUrlParam('tokenid',window.location.search);
    var c1Url = "../bigdataview/getIndexDeviateListData.do?tokenid="+getUrlParam('tokenid',window.location.search);
    var d1Url = "../bigdataview/getDeptWarnData.do?tokenid="+getUrlParam('tokenid',window.location.search);
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
                        $('#starttime').text(data.starttime);
                        $('#projectcount').text(data.projectcount);
                        $('#dlindexcount').text(data.dlindexcount);
                        $('#dxindexcount').text(data.dxindexcount);
                        //C2
                        $('#deptcount').text(data.deptcount);
                        $('#agencycount').text(data.agencycount);
                        $('#amttotal').text(data.amttotal);
                        $('#exeamt').text(data.exeamt);
                        $('#paydeviate').text(data.paydeviate);
                        $('#indexdeviate').text(data.indexdeviate);
                    }, 30);
                }
            }
        });
    };
    function chartdivB1(){
        $.ajax({
            method: 'post',
            url: b1Url,
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
                //指定图表的配置项和数据
                var dataAxis = result.xAxis;
                var data = result.series;
                var dataShadow = [];
                var option = {
                    title: {
                        text: '',
                        subtext: ''
                    },
                    grid:{
                        x:60,
                        y:40,
                        x2:20,
                        y2:20,

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
                        { // For shadow
                            type: 'bar',
                            itemStyle: {
                                color: 'rgba(0,0,0,0.05)'
                            },
                            barGap: '-100%',
                            barCategoryGap: '40%',
                            data: dataShadow,
                            animation: false
                        },
                        {
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
                            data: data
                        }
                    ]
                };
                var myChart = echarts.init(document.getElementById('chartmain'));
                myChart.setOption(option);
                setTimeout(function(){
                    myChart.resize();
                },30);
            }
        });
    }
    function chartdivB2(){
        $.ajax({
            method: 'post',
            url: b2Url,
            dataType: "json",
            contentType: "application/json",
            success: function (result) {
                //指定图表的配置项和数据
                var dataxAxis = result.xAxis;
                var dataSeries1 = result.series1;
                var dataSeries2 = result.series2;
                var option = {
                    title: {
                        text: ''
                    },
                    tooltip: {
                        trigger: 'axis'
                    },
                    legend: {
                        textStyle: {
                            color: '#fff',
                            fontSize: 12,
                        },
                        right:'10%',
                        data: ['执业医师', '注册护士']
                    },
                    grid:{
                        x:40,
                        y:40,
                        x2:20,
                        y2:20,
                    },
                    toolbox: {
                        feature: {
                            //saveAsImage: {}
                        }
                    },
                    xAxis: {
                        type: 'category',
                        boundaryGap: false,
                        axisLabel: {
                            /*inside: true,*/
                            interval:0,
                            textStyle: {
                                color: '#fff',
                                fontSize: 12

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
                                color: '#fff',
                            }
                        },
                        data: dataxAxis
                    },
                    yAxis: {
                        type: 'value',

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
                    series: [
                        {
                            name: '项目总数',
                            type: 'line',
                            stack: '总量',
                            data: dataSeries1,
                            itemStyle: {
                                normal: {
                                    color: "#0efdff",//折线点的颜色
                                    lineStyle: {
                                        color: "#0efdff",//折线的颜色
                                        width:2,
                                    }
                                },
                            }
                        },
                        {
                            name: '监控完成数',
                            type: 'line',
                            stack: '总量',
                            data: dataSeries2
                        },
                    ]
                };
                //获取dom容器
                var myChart = echarts.init(document.getElementById('chartmain_zhe'));
                myChart.setOption(option);
                setTimeout(function(){
                    myChart.resize();
                },30);
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
    function chartdivD1() {
        $.ajax({
            method: 'post',
            url: d1Url,
            dataType: "json",
            success: function (data) {
                if(data != null){
                    setTimeout(function () {
                        debugger;
                        //C1
                        var deptwarnlist = data.option;
                        if(deptwarnlist!= undefined){
                            for (var i = 0 ;i<deptwarnlist.length;i++){
                                var deptwarn = deptwarnlist[i];
                                $('#deptwarnlist').append('<ul class="ul_con"><li class="container">'+deptwarn.dept_code+'</li>'+
                                '<li>'+deptwarn.projectcount+'</li><li>'+deptwarn.greencount+'</li><li>'+deptwarn.yellowcount+'</li><li>'+deptwarn.redcount+'</li></ul>');
                            }
                        }
                    }, 30);
                }
            }
        });
    }
    $(function() {
        inintData();
        chartdivB1();
        chartdivB2();
        chartdivC1();
        chartdivD1();
    });
</script>
<body>
<div class="bg">
	<div class="title">绩效监控数据中心</div>
    <div class="leftMain">
    	<div class="leftMain_top">
        	<div class="leftMain_topIn">
            	<ul>
                	<li>
                        <div class="liIn">
                            <h3>监控下达时间</h3>
                            <p class="shu"><span class="shu1" id="starttime"></span></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                	<li>
                        <div class="liIn">
                            <h3>监控项目数</h3>
                            <p class="shu"><span class="shu2" id="projectcount"></span><i>个</i></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                	<li>
                        <div class="liIn">
                            <h3>绩效定量指标个数</h3>
                            <p class="shu"><span class="shu3" id="dlindexcount"></span><i>个</i></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                	<li>
                        <div class="liIn">
                            <h3>绩效定性指标个数</h3>
                            <p class="shu"><span class="shu4" id="dxindexcount"></span><i>个</i></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
        <div class="leftMain_middle">
        	<div class="leftMain_middle_left">
            	<div class="leftMain_middle_leftIn">
                	<h3>部门排名</h3>
                    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                    <div class="biaoge" style="width:100%; height:25vh" id="chartmain"></div>
                    <span class="border_bg_leftTop"></span>
                    <span class="border_bg_rightTop"></span>
                    <span class="border_bg_leftBottom"></span>
                    <span class="border_bg_rightBottom"></span>
                </div>
            </div>
        	<div class="leftMain_middle_right">
            	<div class="leftMain_middle_rightIn">
                	<h3>指标偏离度</h3>
                    <div class="biaoge biaoge_pai" style="width:100%; height:25vh">
                    	<div class="biaoge_paiIn">
                        	<ul id="indexdeviatelist"></ul>
                        </div>
                    </div>
                    <span class="border_bg_leftTop"></span>
                    <span class="border_bg_rightTop"></span>
                    <span class="border_bg_leftBottom"></span>
                    <span class="border_bg_rightBottom"></span>
                </div>
            </div>
        </div>
        <div class="leftMain_middle">
        	<div class="leftMain_middle_left">
            	<div class="leftMain_middle_leftIn">
                	<h3>监控报送及时性</h3>
                    <div class="biaoge" style="width:100%; height:25vh" id="chartmain_zhe"></div>
                    <span class="border_bg_leftTop"></span>
                    <span class="border_bg_rightTop"></span>
                    <span class="border_bg_leftBottom"></span>
                    <span class="border_bg_rightBottom"></span>
                </div>
            </div>
        	<div class="leftMain_middle_right">
            	<div class="leftMain_middle_rightIn">
                	<h3>上报情况分析</h3>
                    <div class="biaoge biaoge_bi" style="width:100%; height:25vh">
                    	<ul>
                        	<li>
                            	<div class="liIn">
                                	<p class="shu shu1" id="deptcount"></p>
                                    <p class="zi">部门上报个数</p>
                                </div>
                            </li>
                        	<li>
                            	<div class="liIn">
                                	<p class="shu shu2" id="agencycount"></p>
                                    <p class="zi">单位上报个数</p>
                                </div>
                            </li>
                        	<li>
                            	<div class="liIn">
                                	<p class="shu shu3" id="amttotal"></p>
                                    <p class="zi">监控资金总量（亿）</p>
                                </div>
                            </li>
                        	<li>
                            	<div class="liIn">
                                	<p class="shu shu4" id="exeamt"></p>
                                    <p class="zi">1-7月执行数（亿）</p>
                                </div>
                            </li>
                        	<li>
                            	<div class="liIn">
                                	<p class="shu shu5" id="paydeviate"></p>
                                    <p class="zi">执行总体偏离度%</p>
                                </div>
                            </li>
                        	<li>
                            	<div class="liIn">
                                	<p class="shu shu6" id="indexdeviate"></p>
                                    <p class="zi">指标总体偏离度%</p>
                                </div>
                            </li>
                        </ul>

                    </div>
                    <span class="border_bg_leftTop"></span>
                    <span class="border_bg_rightTop"></span>
                    <span class="border_bg_leftBottom"></span>
                    <span class="border_bg_rightBottom"></span>
                </div>
            </div>
        </div>
    </div>
     <div class="rightMain">
       
		 
        <div class="rightMain_bottom">
            <div class="rightMain_bottomIn">
                <h3>部门报送情况</h3>
                <div class="biaoge biaoge_list" style="width:100%; height:36vh">
                	<div class="biaoge_listIn">
                    	<ul class="ul_title">
                        	<li>部门</li>
                            <li>项目数量</li>
                            <li>绿灯个数</li>
                            <li>黄灯个数</li>
                            <li>红灯个数</li>
                        </ul>
                        <div class="ul_list">
                        	<div class="ul_listIn" id="deptwarnlist">
                            </div>
                       </div>
                   </div>

                </div>
                <span class="border_bg_leftTop"></span>
                <span class="border_bg_rightTop"></span>
                <span class="border_bg_leftBottom"></span>
                <span class="border_bg_rightBottom"></span>
            </div>
         </div>
    </div>
    <div style="clear:both;"></div>
</div>
<!--大屏-->
<!--数字增长累加动画-->
<script type="text/javascript">
	$(".shu1").numScroll();
	$(".shu2").numScroll();
	$(".shu3").numScroll();
	$(".shu4").numScroll();
	$(".shu5").numScroll();
	$(".shu6").numScroll();
</script>
<!--大屏-->
</body>
</html>
