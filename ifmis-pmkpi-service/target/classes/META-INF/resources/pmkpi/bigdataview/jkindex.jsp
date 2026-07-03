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
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/jquery.liMarquee.js"></script>
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/jquery.countup.min.js"></script>
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/jquery.waypoints.min.js"></script>
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/echarts.min.js"></script>
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/countDown.js"></script>
<link rel="stylesheet" type="text/css" href="<%=(String) request.getAttribute("appidpath")%>/bigdataview/css/public.css">
<link rel="stylesheet" type="text/css" href="<%=(String) request.getAttribute("appidpath")%>/bigdataview/css/icon.css">
<link rel="stylesheet" type="text/css" href="<%=(String) request.getAttribute("appidpath")%>/bigdataview/css/index.css">
<script type="text/javascript">
        document.documentElement.style.fontSize = document.documentElement.clientWidth /768*100 + 'px';
</script>
</head>
<style>
    .container {
        white-space: nowrap;
        overflow: hidden;
        text-overflow: ellipsis;
    }
    .container:hover {
        overflow: visible;
        text-overflow: inherit;
        white-space: nowrap;
    }
    a, a:visited, a:link, a:hover{
        color:white;
    }
    . jktitle i{
        font-size: 0.08rem;
    }
    .changetitle {
        font-size: 0.07rem;
        float: right;
        margin-right: 0.07rem;
    }
    .scrollable {
        scrollbar-width: none; /* 对于现代浏览器隐藏滚动条 */
    }
    /* 兼容IE和Edge */
    .scrollable::-webkit-scrollbar {
        width: 0;
        height: 0;
    }
    .scrollable::-webkit-scrollbar-track {
        background: transparent;
    }
    .scrollable::-webkit-scrollbar-thumb {
        background: transparent;
    }
    .scrollable::-webkit-scrollbar-button {
        background: transparent;
    }
    .scrollable::-webkit-scrollbar-corner {
        background: transparent;
    }
    .scrollable::-webkit-resizer {
        background: transparent;
    }

</style>

<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/jkindex.js"></script>
<body>
<div class="bg">
	<div class="title">绩效监控数据中心</div>
    <div class="leftMain">
    	<div class="leftMain_top">
        	<div class="leftMain_topIn">
            	<ul>
                	<li>
                        <div class="liIn">
                            <h3>已上报监控单位数/监控单位数</h3>
                            <p class="shu jktitle"><span class="shu1" id="traceagencycount"></span>/<span class="shu1" id="agencycount"></span></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                	<li>
                        <div class="liIn">
                            <h3>已上报监控项目数/监控项目数</h3>
                            <p class="shu jktitle"><span class="shu2" id="traceprojcount"></span>/<span class="shu2" id="projcount"></span></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                	<li>
                        <div class="liIn">
                            <h3>预算执行情况偏差预警</h3>
                            <p class="shu jktitle">黄灯预警项目数量：<span class="shu3" id="bgtyeallowcount"></span></p>
                            <p class="shu jktitle">红灯预警项目数量：<span class="shu3" id="bgtredcount"></span></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                	<li>
                        <div class="liIn">
                            <h3>绩效目标完成情况偏差预警</h3>
                            <p class="shu jktitle">黄灯预警项目数量：<span class="shu4" id="goalyeallowprojcount"></span></p>
                            <p class="shu jktitle">红灯预警项目数量：<span class="shu5" id="goalredprojcount"></span></p>
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
                	<h3>部门全年预计执行情况<span class="changetitle" id="changedivamtlist">切换后5名</span></h3>
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
                	<h3>项目偏差原因情况分析</h3>
                    <div class="biaoge biaoge_pai" style="width:100%; height:25vh" id="chartmain_bing">
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
                	<h3>拟调整预算资金项目情况</h3>
                    <div class="biaoge biaoge_list" style="width:100%;height:25vh">
                        <div class="biaoge_listIn">
                            <div>
                                <ul class="ul_title">
                                    <li>处室名称</li>
                                    <li>处室编码</li>
                                    <li>涉及部门数</li>
                                    <li>涉及项目数</li>
                                    <li>涉及调整资金数额</li>
                                </ul>
                            </div>
                            <div class="ul_list scrollDiv divamtlistDiv">
                                <div class="ul_listIn" id="divamtlist">
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
        	<div class="leftMain_middle_right">
            	<div class="leftMain_middle_rightIn">
                    <h3>绩效指标完成情况偏离分析</h3>
                    <div class="biaoge biaoge_pai scrollable" style="width:100%; height:25vh; overflow: auto;">
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
    </div>
     <div class="rightMain">

        <div class="rightMain_bottom">
            <div class="rightMain_bottomIn">
                <h3>项目监控整体情况汇总表</h3>
                <div class="biaoge biaoge_list" style="width:100%; height:78vh">
                	<div class="biaoge_listIn">
                        <div>
                            <ul class="ul_title">
                                <li>部门名称</li>
                                <li>部门编码</li>
                                <li>监控项目数</li>
                                <li>监控资金总额</li>
                                <li class="container">1-8月预算执行率</li>
                                <li class="container">全年预计预算执行率</li>
                            </ul>
                        </div>
                        <div class="ul_list scrollDiv deptwarnlistDiv">
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
</body>
</html>
