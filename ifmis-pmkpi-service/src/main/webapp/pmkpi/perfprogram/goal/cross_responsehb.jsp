<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" isErrorPage="true"%>
<% String pdm_proinfo = request.getParameter("pdm_proinfo");
    pdm_proinfo = pdm_proinfo.replace("'","’");
%>
<html>
<head>
    <title>cross_response.html</title>
    <meta http-equiv="X-UA-Compatible" content="IE=8" />
    <meta http-equiv="description" content="">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
</head>
<body>
<input id="pdm_proinfo" name="pdm_proinfo" type="hidden" value='<%= pdm_proinfo%>' />
本页面为项目库跨域请求后,三方系统返回页面,此页面放在第三方接入系统的web服务器,并在调用放配置地址,由调用方自动发起请求
配置方法:在页签配置url中加入参数 crossreturl,并通过encodeURIComponent加密地址
本页面三方系统实现嵌入项目库页签页面的保存调用,并返回调用结果,为json格式 {callsuc:1,callmsg:'tipmsg'};
callsuc:为调用是否成功标识 1:成功保存  0:保存失败
callmsg:调用结果提示消息,如失败返回失败原因
</body>
</html>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/frameworksupport.js"></script>
<script type="text/javascript" src="<%=(String) request.getAttribute("appidpath")%>/busfw/ltext/ltext_core.js"></script>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_template.js"></script>
<%--<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/common.js"></script>--%>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_datatable.js"></script>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/datatable3.0.js"></script>
<script type="text/javascript" src="../../common/template/template_default.js"></script>
<script type="text/javascript" src="../../common/perfcommon.js"></script>
<script type="text/javascript" src="../../common/common.js"></script>
<script type="text/javascript" src="../../common/perfutil.js"></script>
<script type="text/javascript" src="../../js/json2.js"></script>
<script type="text/javascript">
    //提取url参数中得值 如: 当前url querystring:a=1   调用getUrlParam('a')返回1;
    function getUrlParam(val,url){
        var uri = url||window.location.search;
        var re = new RegExp("(\\?|&)" +val+ "\=([^\&\?]*)", "ig");
        return ((uri.match(re))?(uri.match(re)[0].substr(val.length+2)):null);
    }

    var responseWind=parent; //嵌入项目库页签的url所在页面的 window对象
    function checkAll() {
        //校验目标
        var datas = responseWind.goaldatatable.getRecordSet().toArray();
        var cols = responseWind.datatable.getCols();
        var _curtab = responseWind["_curtab"];
        var sumratio = 0;
        var returnStr = "";
        var str = "";
        for (var i = 0,leni = datas.length; i < leni; i++) {
            if(!datas[i].kpi_target || datas[i].kpi_target == ""){
                str = "第" + (datas[i]["_sortid"] + 1)  + "行的绩效目标为必录项，必须有值。";
                returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                return returnStr;
            }
            sumratio+=Number(datas[i]['ratio']);

            var id = datas[i].guid;//目标id
            if(id != null && id !=""){
                //校验目标下的指标
                var yearlist = null;
                var totallist = null;
                if(datas[i].yearflag == "0"){
                    yearlist = datas[i]["#indexs"];
                }else{
                    totallist = datas[i]["#indexs"];
                }

                if (yearlist != null && yearlist.length > 0) {
                    var sumweight = 0;
                    for (var a = 0, yleni = yearlist.length; a < yleni; a++) {
                        if (yearlist[a]["levelno"] == 3 && yearlist[a]["indexval"] == "" || yearlist[a]["indexval"] == undefined) {
                            str = "第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (yearlist[a]["_sortid"] + 1) + "行的年度绩效指标指标值为必录项，必须有值。";
                            returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                            return returnStr;
                        }
                        if (yearlist[a]["levelno"] == 3) {
                            if(yearlist[a].computesign != 6 && yearlist[a].computesign != 9 && yearlist[a].computesign != 10 && (!yearlist[a].meterunit || yearlist[a].meterunit == "")){
                                str = "第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (yearlist[a]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。";
                                returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                                return returnStr;
                            }
                        }
                        if (yearlist[a]['computesign'] == '9' && yearlist[a]['kpi_remark'] == undefined) {
                            str = "第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (yearlist[a]["_sortid"] + 1) + "行的计算符号选择“定量（其他）”时指标值说明为必录项，必须有值。";
                            returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                            return returnStr;
                        }
                        for (var c = 0,lenj = cols.length; c < lenj; c++) {
                            if (cols[c].requirement == '1' && yearlist[a]["levelno"] == 3) {
                                var value = yearlist[a][cols[c].colcode];
                                if (value == null || value == "" || ("" + value).trim().length == 0) {
                                    str = "第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (yearlist[a]["_sortid"] + 1) + "行的" + cols[c].alias + "为必录项，必须有值。";
                                    returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                                    return returnStr;
                                }
                            }
                        }
                        if(yearlist[a]["levelno"] == 3){
                            sumweight+=Number(yearlist[a]['weight']);
                        }
                    }
                    var columns = responseWind.datatable.config.data[0].columns;
                    var isvisiable = 0;
                    for(var num=0;num<columns.length;num++) {
                        if(columns[num]["colcode"] == "weight"){
                            isvisiable = columns[num]["isvisiable"];
                            break;
                        }
                    }
                    if(sumweight != 80 && isvisiable == 1){
                        str = "第" + (datas[i]["_sortid"] + 1) + "行目标，指标权重之和应等于80分，请检查。";
                        returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                        return returnStr;
                    }
                }



                if (totallist != null && totallist.length > 0) {
                    for (var b = 0, tleni = totallist.length; b < tleni; b++) {
                        if (totallist[b]["levelno"] == 3 && totallist[b]["indexval"] == "" || totallist[b]["indexval"] == undefined) {
                            str = "第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (totallist[b]["_sortid"] + 1) + "行的总体绩效指标指标值为必录项，必须有值。";
                            returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                            return returnStr;
                        }
                        if (totallist[b]["levelno"] == 3) {
                            if(totallist[b].computesign != 6 && totallist[b].computesign != 9 && totallist[b].computesign != 10 && (!totallist[b].meterunit || totallist[b].meterunit == "")){
                                str = "第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (totallist[b]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。";
                                returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                                return returnStr;
                            }
                        }
                        if (totallist[b]['computesign'] == '9' && totallist[b]['kpi_remark'] == undefined) {
                            str = "第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (totallist[b]["_sortid"] + 1) + "行的计算符号选择“定量（其他）”时指标值说明为必录项，必须有值。";
                            returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                            return returnStr;
                        }
                        for (var e = 0,lenj = cols.length; e < lenj; e++) {
                            if (cols[e].requirement == '1' && totallist[b]["levelno"] == 3) {
                                var value = totallist[b][cols[e].colcode];
                                if (value == null || value == "" || ("" + value).trim().length == 0) {
                                    str = "第" + (datas[i]["_sortid"] + 1) + "行目标的第" + (totallist[b]["_sortid"] + 1) + "行的" + cols[e].alias + "为必录项，必须有值。";
                                    returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                                    return returnStr;
                                }
                            }
                        }
                    }
                }
            }
        }

        var goalcolumns = responseWind.goaldatatable.config.data[0].columns;
        var isvisiable = 0;
        for(var g=0;g<goalcolumns.length;g++) {
            if(goalcolumns[g]["colcode"] == "ratio"){
                isvisiable = goalcolumns[g]["isvisiable"];
                break;
            }
        }
        if(_curtab == "year" && sumratio != 100 && isvisiable == 1){
            str = "指标权重比例合计应为100%。";
            returnStr = "{callsuc:0,callmsg:'"+str+"'}";
            return returnStr;
        }


        return returnStr;
    }
    var pdmsave = getUrlParam('pdmsave');
    responseWind.Ext.lt.layout.doLayout();
    debugger;
    var otherappfunc = function(){
        debugger;
        //alert("save done!");
        var result = "";
        var url = "/pmkpi/perfprogram/saveGoalAndIndex.do?tokenid="+getUrlParam('tokenid',responseWind.location.search)+"&authorization="+getUrlParam('authorization',responseWind.location.search)+"&year="+getUrlParam('year',responseWind.location.search);
        if (responseWind.goaldatatable.getEditor()){
            responseWind.goaldatatable.closeEdit();
        }
        if (responseWind.datatable.getEditor()){
            responseWind.datatable.closeEdit();
        }
        //表格保存之前先保存一下子表到主表行
        var datas = responseWind.datatable.getRecordSet().toArray();
        if (datas != null && datas.length > 0) {
            var goalguid = datas[0].goalguid;
            var mainsel = responseWind.goaldatatable.getRecordset().query({guid:goalguid});
            if (mainsel.length > 0){
                mainsel[0]["#indexs"] = datas;
            }
        }
        responseWind.goaldatatable.reflashdata();
        var _curtab = responseWind["_curtab"];
        var _procode = responseWind["_procode"];
        var totalgoals = responseWind["totalgoals"];////总体目标
        var yeargoals = responseWind["yeargoals"];//年度目标
        var deltotal = responseWind["deltotal"];//删除的总体目标
        var delyear = responseWind["delyear"];//删除的年度目标
        var isedittotal = getUrlParam('isedittotal',responseWind.location.search);
        //获取最新目标数据
        try{
            if(_curtab =="total"){
                totalgoals = responseWind.goaldatatable.getRecordSet().toArray();
            }else{
                yeargoals = responseWind.goaldatatable.getRecordSet().toArray();
            }
            //处理特殊符号
            totalgoals = getNewData(totalgoals);
            yeargoals = getNewData(yeargoals);
            deltotal = getNewData(deltotal);
            delyear = getNewData(delyear);
        }catch(exception){
            return false;
        }
        var commitable=true;
        var tabdata = {};
        tabdata["#total"] = totalgoals;
        tabdata["#year"] = yeargoals;
        tabdata["#deltotal"] = deltotal;
        tabdata["#delyear"] = delyear;
        var totalgoalsjson = encodeURIComponent(JSON.stringify(totalgoals),"utf-8");
        var yeargoalsjson = encodeURIComponent(JSON.stringify(yeargoals),"utf-8");
        var deltotaljson = encodeURIComponent(JSON.stringify(deltotal),"utf-8");
        var delyearjson = encodeURIComponent(JSON.stringify(delyear),"utf-8");
        var projguid = getUrlParam('projId',responseWind.location.search);
        if(pdmsave=='21'){ //21暂存功能
            projguid = getUrlParam('stagid',responseWind.location.search);
        }else{
            var result = checkAll();
            if(result != ""){
                return result;
            }
            if(totalgoals && totalgoals.length>0){
                for(var i=0;i<totalgoals.length;i++) {
                    var goalguid = totalgoals[i]["guid"];
                    var goalname = totalgoals[i]["goalname"];
                    var totalindex = totalgoals[i]["#indexs"];
                    var checkresult = responseWind.Ext.lt.pmkpi.checkSpaceValue(totalgoals[i],"绩效目标：" + goalname+"","goaldatatable");//校验空格
                    if (checkresult && checkresult != "success"){//校验空格
                        result = checkresult;
                        return result;
                    }
                    for(var j=0;j<totalindex.length;j++) {
                        var checkresult = responseWind.Ext.lt.pmkpi.checkSpaceValue(totalindex[j],"绩效目标：" + goalname+"-绩效指标-第" + (totalindex[j]["_sortid"] + 1) + "行","datatable");
                        if (checkresult && checkresult != "success"){//校验空格
                            result = checkresult;
                            return result;
                        }
                        if(totalindex[j]["levelno"] == 3 && (totalindex[j].yearflag != "1" || (goalguid && goalguid != totalindex[j]["goalguid"]))) {
                            result= "{callsuc:0,callmsg:'【总体目标】：" + goalname + "的【总体指标】三级指标：" + totalindex[j].name + "录入不正确，请删除后重新录入!'}";
                            return result;
                        }
                    }
                }
            }
            if(yeargoals && yeargoals.length>0){
                for(var i=0;i<yeargoals.length;i++) {
                    var goalguid = yeargoals[i]["guid"];
                    var goalname = yeargoals[i]["goalname"];
                    var yearindex = yeargoals[i]["#indexs"];
                    var checkresult = responseWind.Ext.lt.pmkpi.checkSpaceValue(yeargoals[i],"绩效目标：" + goalname+"","goaldatatable");//校验空格
                    if (checkresult && checkresult != "success"){//校验空格
                        result = checkresult;
                        return result;
                    }
                    for(var j=0;j<yearindex.length;j++) {
                        var checkresult = responseWind.Ext.lt.pmkpi.checkSpaceValue(yearindex[j],"绩效目标：" + goalname+"-绩效指标-第" + (yearindex[j]["_sortid"] + 1) + "行","datatable");
                        if (checkresult && checkresult != "success"){//校验空格
                            result = checkresult;
                            return result;
                        }
                        if(yearindex[j]["levelno"] == 3 && (yearindex[j].yearflag != "0" || (goalguid && goalguid != yearindex[j]["goalguid"]))) {
                            result= "{callsuc:0,callmsg:'【年度目标】：" + goalname + "的【年度指标】三级指标：" + yearindex[j].name + "录入不正确，请删除后重新录入!'}";
                            return result;
                        }
                    }
                }
            }
        }
        var projtype = getUrlParam('projtype',responseWind.location.search);
        var selectbillguid = getUrlParam('selectbillguid',responseWind.location.search);//调整前的guid
        var adjadd = getUrlParam('adjadd',responseWind.location.search);//是否调整
        var dbgyear = getUrlParam('year',responseWind.location.search); //年度暂时没有用到
        var midproguid = getUrlParam('midguid',responseWind.location.search); //暂存草稿
        var issuper = getUrlParam('issuper',responseWind.location.search); //浙江预算编制监审操作

        var projcode = "";
        var projname = "";
        if(responseWind.parent["editform"]){
            if(responseWind.parent["editform"].getCol("pro_code")){
                projcode = responseWind.parent["editform"].getCol("pro_code").getvalue();
            }
            if(responseWind.parent["editform"].getCol("pro_name")){
                projname = responseWind.parent["editform"].getCol("pro_name").getvalue();
            }
        }
        var showtab = responseWind["showtab"]; //总+年显示方式
        var pdm_proinfo = $("#pdm_proinfo").val();
        if(commitable){
            $.ajax({
                url : url,
                type:"POST",
                dataType:"text",
                async: false,
                data : {
                    "projguid":projguid,
                    "projtype":projtype,
                    "projcode":projcode,
                    "projname":projname,
                    "procode":_procode,
                    "pdm_proinfo":pdm_proinfo,
                    "pdmsave":pdmsave,
                    "isedittotal":isedittotal,
                    "showtab":showtab,
                    "totalgoalsjson":totalgoalsjson,
                    "yeargoalsjson":yeargoalsjson,
                    "deltotaljson":deltotaljson,
                    "delyearjson":delyearjson,
                    "selectbillguid":selectbillguid,
                    "adjadd":adjadd,
                    "midproguid":midproguid,
                    "issuper":issuper
                },
                success : function(data) {
                    var rs = JSON.parse(data);
                    if (rs && rs.success == true) {
                        result= "{callsuc:1,callmsg:'保存成功!'}";
                        if("true"==JSON.parse(pdm_proinfo).midsave && "21"==pdmsave){//暂存点击暂存
                            responseWind.Ext.lt.pmkpi.inittreeindex();
                        }else if ("true"!=JSON.parse(pdm_proinfo).midsave && "21"!=pdmsave){//保存点击保存
                            responseWind.Ext.lt.pmkpi.inittreeindex();
                        }
                    } else {
                        if (rs.success == false){
                            var errinfo = '';
                            var errdata = rs.redata;
                            if(errdata && errdata.length >0 ){
                                for(var i=0; i<errdata.length; i++){
                                    errinfo += errdata[i].remark + ',';
                                }
                                errinfo = errinfo.substring(0,errinfo.length-1);
                            }
                            result= "{callsuc:0,callmsg:'"+decodeURI(errinfo)+"'}";
                            //openlistdiv(rs);
                        } else {
                            result= "{callsuc:0,callmsg:'保存失败!'}";
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    result= "{callsuc:0,callmsg:'"+textStatus+"'}";
                }
            });
        }
        return result;
    };
    //调用保存方法,并返回状态给项目库系统,调用js方法自行实现
    var retJson = "{callsuc:1,callmsg:'保存成功!'}";
    //retJson = "{callsuc:0,callmsg:'保存失败!'}";
    debugger;
    if(pdmsave=='1' || pdmsave=='21'){
        retJson = otherappfunc();
    }
    //通过window.name返回跨域执行结果
    window.name=retJson;
    //返回请求方url(项目库)
    var hostport=document.location.host;//ip:端口号
    var url=document.location.protocol+'//'+hostport+'/pdm/cross_request.html';
    //携带参数
    var reqParam = [];
    reqParam.push("t="+new Date().getTime()); //时间戳
    reqParam.push("tokenid="+getUrlParam('tokenid',responseWind.location.search)); //登录验证tokenid
    reqParam.push("urltabguid="+getUrlParam('urltabguid'));//当前
    reqParam.push("pdmsave="+getUrlParam('pdmsave'));
    reqParam.push("year="+getUrlParam('year')); //请求新增跳转年度.
    window.location.href=url+'?'+reqParam.join('&');
    var listdiv = null;
    /**
     * 审核定义弹窗
     * @param rt
     */
    function openlistdiv(rt){
        if(listdiv == null){
            var dicv=document.createElement('div');
            var _scrHeight = window.screen.height;
            var _scrWidth = window.screen.width;
            dicv.innerHTML='<div id="errdiv" style="height: '+(_scrHeight-250)+'px;overflow: hidden">' +
                '<div id="errordata" style="height: '+(_scrHeight-200)+'px;overflow: hidden"></div></div>';
            dicv.style.height=_scrHeight;
            dicv.style.width=_scrWidth;
            listdiv=new Ext.lt.window({title:"错误信息", w:_scrWidth-200, h:_scrHeight-200,close:true,pop:true,mark:true,className:'windpop'});
            listdiv.draw(dicv);
            var rtdata = rt.redata;
            var detaildatas = "";
            var dtable = "";
            detaildatas = new Ext.lt.recordset();
            dtable = new Ext.lt.datatable(detaildatas);
            var columns = [
                {name:'code',alias:'审核定义编码',datatype:'s',columncode:'code'},
                {name:'name',alias:'审核定义名称',datatype:'s',columncode:'name'},
                {name:'remark',alias:'错误信息',datatype:'s',columncode:'remark'},
                {name:'explain',alias:'审核说明',datatype:'s',columncode:'explain'}
            ];
            dtable.setCols(columns);
            dtable.setMouselight('#FCE0AE');
            dtable.mousedrag(false);
            dtable.setClassName('dttheme_ifmis');
            var errordiv = document.getElementById('errordata');
            errordiv.style.height = _scrHeight;
            dtable.draw(errordiv);
            $('body').append(listdiv.outerHTML);
        }
        detaildatas.setData(rtdata);
        listdiv.show();
    }


    /**
     * 特殊字替换
     */
    function getNewData (goals) {
        if (goals) {
            //处理特殊符号
            for (var x = 0; x < goals.length; x++) {
                goals[x].kpi_target = goals[x].kpi_target == "" || goals[x].kpi_target == undefined ? "" : convertStr(goals[x].kpi_target);
                goals[x].pro_name = goals[x].pro_name == "" || goals[x].pro_name == undefined ? "" : convertStr(goals[x].pro_name);
                var indexlist = goals[x]["#indexs"];
                var delindexlist = goals[x]["#delindex"];
                var goalname = goals[x]["goalname"];
                for (var y = 0; y < indexlist.length; y++) {
                    if(indexlist[y]["levelno"] == 3){
                        indexlist[y]["pro_name"] = indexlist[y]["pro_name"] == "" || indexlist[y]["pro_name"] == undefined ? "" :convertStr(indexlist[y]["pro_name"]);
                        indexlist[y]["name"] = indexlist[y]["name"] == "" || indexlist[y]["name"] == undefined ? "" :convertStr(indexlist[y]["name"]);
                        indexlist[y]["lv3_perf_ind_name"] = indexlist[y]["lv3_perf_ind_name"] == "" || indexlist[y]["lv3_perf_ind_name"] == undefined ? "" :convertStr(indexlist[y]["lv3_perf_ind_name"]);
                        indexlist[y]["kpi_content"] = indexlist[y]["kpi_content"] == "" || indexlist[y]["kpi_content"] == undefined ? "" :convertStr(indexlist[y]["kpi_content"]);
                        indexlist[y]["value_remark"] = indexlist[y]["value_remark"] == "" || indexlist[y]["value_remark"] == undefined ? "" :convertStr(indexlist[y]["value_remark"]);
                        indexlist[y]["indexval"] = indexlist[y]["indexval"] == "" || indexlist[y]["indexval"] == undefined ? "" :convertStr(indexlist[y]["indexval"]);
                        indexlist[y]["kpi_val"] = indexlist[y]["kpi_val"] == "" || indexlist[y]["kpi_val"] == undefined ? "" :convertStr(indexlist[y]["kpi_val"]);
                    }
                }
                for(var z = 0; z < delindexlist.length; z++){
                    if(delindexlist[z]["levelno"] == 3){
                        delindexlist[z]["pro_name"] = delindexlist[z]["pro_name"] == "" || delindexlist[z]["pro_name"] == undefined ? "" :convertStr(delindexlist[z]["pro_name"]);
                        delindexlist[z]["name"] = delindexlist[z]["name"] == "" || delindexlist[z]["name"] == undefined ? "" :convertStr(delindexlist[z]["name"]);
                        delindexlist[z]["lv3_perf_ind_name"] = delindexlist[z]["lv3_perf_ind_name"] == "" || delindexlist[z]["lv3_perf_ind_name"] == undefined ? "" :convertStr(delindexlist[z]["lv3_perf_ind_name"]);
                        delindexlist[z]["kpi_content"] = delindexlist[z]["kpi_content"] == "" || delindexlist[z]["kpi_content"] == undefined ? "" :convertStr(delindexlist[z]["kpi_content"]);
                        delindexlist[z]["value_remark"] = delindexlist[z]["value_remark"] == "" || delindexlist[z]["value_remark"] == undefined ? "" :convertStr(delindexlist[z]["value_remark"]);
                        delindexlist[z]["indexval"] = delindexlist[z]["indexval"] == "" || delindexlist[z]["indexval"] == undefined ? "" :convertStr(delindexlist[z]["indexval"]);
                        delindexlist[z]["kpi_val"] = delindexlist[z]["kpi_val"] == "" || delindexlist[z]["kpi_val"] == undefined ? "" :convertStr(delindexlist[z]["kpi_val"]);
                    }
                }
            }
        }
        return goals ;
    }
</script>