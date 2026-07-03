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
    <title>绩效自评数据中心</title>
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
    <link rel="stylesheet" type="text/css" href="<%=(String) request.getAttribute("appidpath")%>/bigdataview/css/index0.css">
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

<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/bigdataview/zpindex.js"></script>
<body>
<div class="bg">
    <div class="title">绩效自评数据中心</div>
    <div class="leftMain">
        <div class="leftMain_top">
            <div class="leftMain_topIn">
                <ul>
                    <li>
                        <div class="liIn">
                            <h3>已上报自评单位数/自评单位数</h3>
                            <p class="shu jktitle"><span class="shu1" id="evalagencycount"></span>/<span class="shu1" id="agencycount"></span></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                    <li>
                        <div class="liIn">
                            <h3>已上报自评项目数/自评项目数</h3>
                            <p class="shu jktitle"><span class="shu2" id="evalprojcount"></span>/<span class="shu2" id="projcount"></span></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                    <li>
                        <div class="liIn">
                            <h3>自评资金总额：<span class="shu3" id="zpamt1"></span></h3>
                            <p class="shu jktitle">中央资金：<span class="shu3" id="zpamt2"></span></p>
                            <p class="shu jktitle">市级资金：<span class="shu3" id="zpamt3"></span></p>
                            <p class="shu jktitle">其他资金：<span class="shu3" id="zpamt4"></span></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                    <li>
                        <div class="liIn">
                            <h3>总体预算执行率</h3>
                            <p class="shu jktitle"><span class="shu4" id="evalbgtget"></span></p>
                            <span class="border_bg_leftTop"></span>
                            <span class="border_bg_rightTop"></span>
                            <span class="border_bg_leftBottom"></span>
                            <span class="border_bg_rightBottom"></span>
                        </div>
                    </li>
                    <li>
                        <div class="liIn">
                            <h3>自评平均得分</h3>
                            <p class="shu jktitle"><span class="shu5" id="evalscore"></span></p>
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
                    <h3>预算执行率分布图</h3>
                    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
                    <div class="biaoge" style="width:100%; height:25vh" id="chartmain_bing"></div>
                    <span class="border_bg_leftTop"></span>
                    <span class="border_bg_rightTop"></span>
                    <span class="border_bg_leftBottom"></span>
                    <span class="border_bg_rightBottom"></span>
                </div>
            </div>
            <div class="leftMain_middle_right" style="width: 25%;padding-right: 0.1rem;">
                <div class="leftMain_middle_rightIn">
                    <h3>各项指标完成度</h3>
                    <div class="biaoge biaoge_pai scrollable" style="width:100%; height:25vh; overflow: auto;">
                        <div class="biaoge_paiIn">
                            <ul id="indexvallist"></ul>
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
                    <h3>自评情况分析</h3>
                    <div class="biaoge biaoge_list" style="width:100%;height:25vh">
                        <div class="biaoge_listIn">
                            <div>
                                <ul class="ul_title">
                                    <li>专项大类</li>
                                    <li>部门名称</li>
                                    <li>部门编码</li>
                                    <li>项目名称</li>
                                    <li>预算执行率</li>
                                    <li>自评平均分数</li>
                                </ul>
                            </div>
                            <div class="ul_list scrollDiv zpfxlistDiv">
                                <div class="ul_listIn" id="zpfxlist">
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
        <div class="leftMain_bottom">
            <div class="leftMain_middle_right" style="width: 25%;padding-right: 0.1rem;">
                <div class="leftMain_middle_rightIn">
                    <h3>绩效指标调整率分析<span class="changetitle" >指标调整比率</span></h3>
                    <div class="biaoge biaoge_pai scrollable" style="width:100%; height:25vh; overflow: auto;">
                        <div class="biaoge_paiIn">
                            <ul id="indexadjlist1"></ul>
                        </div>
                    </div>
                    <span class="border_bg_leftTop"></span>
                    <span class="border_bg_rightTop"></span>
                    <span class="border_bg_leftBottom"></span>
                    <span class="border_bg_rightBottom"></span>
                </div>
            </div>
            <div class="leftMain_middle_right" style="width: 25%;padding-right: 0.1rem;">
                <div class="leftMain_middle_rightIn">
                    <h3>绩效指标调整率分析<span class="changetitle" >指标调整项目比率</span></h3>
                    <div class="biaoge biaoge_pai scrollable" style="width:100%; height:25vh; overflow: auto;">
                        <div class="biaoge_paiIn">
                            <ul id="indexadjlist2"></ul>
                        </div>
                    </div>
                    <span class="border_bg_leftTop"></span>
                    <span class="border_bg_rightTop"></span>
                    <span class="border_bg_leftBottom"></span>
                    <span class="border_bg_rightBottom"></span>
                </div>
            </div>
            <div class="leftMain_middle_right" style="width: 50%;">
                <div class="leftMain_middle_rightIn">
                    <h3>绩效指标调整率</h3>
                    <div class="biaoge biaoge_list" style="width:100%;height:25vh">
                        <div class="biaoge_listIn">
                            <div>
                                <ul class="ul_title">
                                    <li>部门名称</li>
                                    <li>部门编码</li>
                                    <li class="container">指标调整项目比率</li>
                                    <li class="container">指标调整指标比率</li>
                                    <li>总体预算执行率</li>
                                    <li>自评平均分数</li>
                                </ul>
                            </div>
                            <div class="ul_list scrollDiv indexadjdeptlistDiv">
                                <div class="ul_listIn" id="indexadjdeptlist">
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
    </div>
    <div style="clear:both;"></div>
</div>
</body>
</html>
