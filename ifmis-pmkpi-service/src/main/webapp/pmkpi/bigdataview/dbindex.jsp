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
    <title>天津市绩效监控、自评业务数据对比分析</title>
    <!--大屏-->
    <script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/jquery-1.11.0.min.js"></script>
    <script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/jquery.numscroll.js"></script>
    <script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/jquery.liMarquee.js"></script>
    <script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/jquery.countup.min.js"></script>
    <script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/jquery.waypoints.min.js"></script>
    <script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/echarts.min.js"></script>
    <script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/js/countDown.js"></script>
    <link rel="stylesheet" type="text/css" href="<%=(String) request.getAttribute("appidpath")%>/bigdataview/css/comon1.css">
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
    #inevallist li .container{
        display: inline-block;
        margin-left: 5px;
    }
    #analysislist li .container{
        display: inline-block;
        margin-left: 5px;
    }
</style>
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/dbindex.js"></script>
<body>
<div class="head">
    <h1><span style="color: rgba(14, 253, 255, 1);">天津市绩效监控、自评业务数据对比分析</span></h1>
</div>
<div class="mainbox">
    <ul class="clearfix">
        <li>
            <div class="boxall" style="height:calc(100% - .15rem); padding: 0;">
                <div class="tit04">监控纳入自评情况对比</div>
                <div class="boxnav nav04">
                    <div class="listhead listhead2">
                        <span>部门名称</span>
                        <span>监控总数</span>
                        <span>纳入自评数</span>
                        <span>纳入占比</span>
                    </div>
                    <div class="listnav listnav2 scrollDiv inevallistDiv">
                        <ul class="smjl" id="inevallist">
                        </ul>
                    </div>
                </div>
                <div class="boxfoot"></div>
            </div>
        </li>
        <li>
            <div class="boxall" style="height: calc(60% - .15rem)">
                <ul class="row h30 clearfix">
                    <li class="col-6">
                        <div class="sqzs h100">
                            <p>监控资金总量</p>
                            <h1><span id="traceamt"></span>亿</h1>
                        </div> </li>
                    <li class="col-6">
                        <div class="sqzs h100">
                            <p>自评资金总量</p>
                            <h1><span id="evalselfamt"></span>亿</h1>
                        </div> </li>
                </ul>
                <ul class="row h30 clearfix">
                    <li class="col-6">
                        <div class="sqzs h100">
                            <p>监控项目总量</p>
                            <h1><span id="traceprocount"></span>个</h1>
                        </div> </li>
                    <li class="col-6">
                        <div class="sqzs h100">
                            <p>自评项目总量</p>
                            <h1><span id="evalselfprocount"></span>个</h1>
                        </div> </li>
                </ul>
                <ul class="row h30 clearfix">
                    <li class="col-6">
                        <div class="sqzs h100">
                            <p>监控整体偏离度</p>
                            <h1><span id="tracedeviate"></span>%</h1>
                        </div> </li>
                    <li class="col-6">
                        <div class="sqzs h100">
                            <p>自评整体平均得分</p>
                            <h1><span id="evalselfscore"></span></h1>
                        </div> </li>
                </ul>
            </div>
            <div class="boxall" style="height: calc(40% - .15rem)">
                <div class="alltitle">
                    监控、自评情况对比
                </div>
                <div class="boxnav" id="echarts1" style="margin-left: 10px;"></div>
            </div>
        </li>
        <li>
            <div class="boxall" style="height:calc(100% - .15rem); padding: 0;">
                <div class="tit04">监控、自评对比分析</div>
                <div class="boxnav nav04">
                    <div class="listhead listhead2">
                        <span>部门名称</span>
                        <span>监控偏离度</span>
                        <span>自评得分</span>
                        <span>监控执行率</span>
                        <span>自评执行率</span>
                    </div>
                    <div class="listnav listnav2 scrollDiv analysislistDiv">
                        <ul class="smjl" id="analysislist">
                        </ul>
                    </div>
                </div>
                <div class="boxfoot"></div>
            </div>
        </li>
    </ul>
</div>
<!--大屏-->
</body>
</html>
