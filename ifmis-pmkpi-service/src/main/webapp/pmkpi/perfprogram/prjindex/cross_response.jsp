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
    var datas = responseWind.datatable.getRecordSet().toArray();
    var cols = responseWind.datatable.getCols();
    var returnStr = "";
    var str = "";

    for (var i = 0,leni = datas.length; i < leni; i++) {
        if (datas[i]["levelno"] == 3) {
            if(datas[i].computesign != 6 && datas[i].computesign != 9 && datas[i].computesign != 10 && (!datas[i].meterunit || datas[i].meterunit == "")){
                //Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。",{timeout:1},function(){});
                str = "第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。";
                returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                return returnStr;
            }
            if(datas[i]['computesign'] == '9' && (!datas[i].value_remark || datas[i].value_remark == '')){
                //Ext.lt.ui.alert("计算符号选择“定量（其他）”时，指标值说明必填！",{timeout:1},function(){});
                returnStr = "{callsuc:0,callmsg:'计算符号选择“定量（其他）”时，指标值说明必填！'}";
                return returnStr;
            }
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
                        //Ext.lt.ui.alert("第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。",{timeout:1},function(){});
                        str = "第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。";
                        returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                        return returnStr;
                    }
                    if (cols[j].colcode == 'indexval' && value.match(RegExp("[*_-]")) != null) {
                        str = "第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。";
                        returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                        return returnStr;
                    }
                    if ((cols[j].colcode == 'name') && (value == "-" || value == "_" || value == "*")) {
                        str = "第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "不符合规范，请重新填写。";
                        returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                        return returnStr;
                    }
                }
            }
        }
    }
    return returnStr;
}
var pdmsave = getUrlParam('pdmsave');
debugger;
var isperform = '2';
var special = getUrlParam('special',responseWind.location.search);
if(responseWind.parent["editform"].getCol("is_perform") != undefined){
    isperform = responseWind.parent["editform"].getCol("is_perform").getvalue();
}

responseWind.Ext.lt.layout.doLayout();
var otherappfunc = function(){
	debugger;
	//alert("save done!");
	// var result = "";
    var result = "{callsuc:0, callmsg:'保存失败 未调用ajax'}";
	var url = "/pmkpi/perfprogram/saveTreeIndex.do?tokenid="+getUrlParam('tokenid',responseWind.location.search)+"&authorization="+getUrlParam('authorization',responseWind.location.search)+"&year="+getUrlParam('year',responseWind.location.search);
    if (responseWind.datatable.getEditor()){
        responseWind.datatable.closeEdit();
    }
	var permData = responseWind.datatable.getRecordSet().toArray();
	var _curtab = responseWind["_curtab"];
    var _procode = responseWind["_procode"];
    var _ischeckweight = responseWind["_ischeckweight"];
    var _weight_sum = responseWind["_weight_sum"];
    var yearflag = "";
    for (var i=0; i<permData.length; i++) {
        if (permData[i].levelno == 3) {
            if (permData[i].yearflag) {
                yearflag = permData[i].yearflag;
                break;
            }
        }
    }
    if (yearflag == "1"){
        responseWind.tabcomps["#total"] = Ext.lt.cloneobj(permData);
    } else if (yearflag == "0") {
        responseWind.tabcomps["#year"] = Ext.lt.cloneobj(permData);
    }
    //处理指标名称、指标值字段 特殊字替换
    var totalgoals = responseWind.tabcomps["#total"];////总体目标
    var yeargoals = responseWind.tabcomps["#year"];//年度目标
    if (totalgoals && totalgoals.length > 0) {
        for (var a = 0, tleni = totalgoals.length; a < tleni; a++) {
            if(totalgoals[a].levelno == "3"){
                var checkresult = responseWind.Ext.lt.pmkpi.checkSpaceValue(totalgoals[a],"【总体绩效指标】三级指标：第" + (totalgoals[a]["_sortid"] + 1) + "行","datatable");
                if (checkresult && checkresult != "success"){//校验空格
                    result = checkresult;
                    return result;
                }
                totalgoals[a].name = convertStr(totalgoals[a].name);
                totalgoals[a].indexval = convertStr(totalgoals[a].indexval);
                totalgoals[a].kpi_val = convertStr(totalgoals[a].kpi_val);
            }
        }
    }
    if (yeargoals && yeargoals.length > 0) {
        for (var b = 0, yleni = yeargoals.length; b < yleni; b++) {
            if(yeargoals[b].levelno == "3") {
                var checkresult= responseWind.Ext.lt.pmkpi.checkSpaceValue(yeargoals[b],"【年度绩效指标】三级指标：第" + (yeargoals[b]["_sortid"] + 1) + "行","datatable");
                if (checkresult && checkresult != "success"){//校验空格
                    result = checkresult;
                    return result;
                }
                yeargoals[b].name = convertStr(yeargoals[b].name);
                yeargoals[b].indexval = convertStr(yeargoals[b].indexval);
                yeargoals[b].kpi_val = convertStr(yeargoals[b].kpi_val);
            }
        }
    }
    var tabdata = responseWind.tabcomps; //存放多年度页签.
    var commitable=true;
	var json = encodeURIComponent(JSON.stringify(tabdata),"utf-8");
	var projguid = getUrlParam('projId',responseWind.location.search);
    var isedittotal = getUrlParam('isedittotal',responseWind.location.search); //
    var showtab = responseWind["showtab"]; //总+年显示方式

    if(pdmsave=='21'){ //21暂存功能
        projguid = getUrlParam('stagid',responseWind.location.search);
    }else{
        var result;
        if (_curtab == "total" && isedittotal == "1") {
            result = "";
        } else {
            result = checkAll();
        }
        if(result != ""){
            return result;
        }
        var totalindex = tabdata['#total'];
        var yearindex = tabdata['#year'];
        if(totalindex && totalindex.length>0){
            var sumweight = 0;
            for(var i=0;i<totalindex.length;i++) {
                if(totalindex[i]["levelno"] == 3){
                    sumweight+=Number(totalindex[i]["weight"]);
                    if (totalindex[i].yearflag != "1") {
                        result= "{callsuc:0,callmsg:'【总体指标】三级指标：" + totalindex[i].name + "录入不正确，请删除后重新录入!'}";
                        return result;
                    }
                }
                if(totalindex[i]["levelno"] == 3 && totalindex[i]["indexval"] == "" || totalindex[i]["indexval"] == undefined){
                    result= "{callsuc:0,callmsg:'总体绩效指标指标值不能为空，保存失败!'}";
                    return result;
                }
            }
            var columns = responseWind.datatable.config.data[0].columns;
            var isvisiable = 0;
            for(var i=0;i<columns.length;i++) {
                if(columns[i]["colcode"] == "weight"){
                    isvisiable = columns[i]["isvisiable"];
                    break;
                }
            }
            if(sumweight != 100 && isvisiable == 1){
                result= "{callsuc:0,callmsg:'总体总绩效指标权重需为100，保存失败!'}";
                return result;
            }
        }
        if(yearindex && yearindex.length>0){
            var sumweight = 0;
            for(var i=0;i<yearindex.length;i++) {
                if(yearindex[i]["levelno"] == 3){
                    sumweight+=Number(yearindex[i]["weight"]);
                    if (yearindex[i].yearflag != "0") {
                        result= "{callsuc:0,callmsg:'【年度指标】三级指标：" + yearindex[i].name + "录入不正确，请删除后重新录入!'}";
                        return result;
                    }
                }
                if(yearindex[i]["levelno"] == 3 && yearindex[i]["indexval"] == "" || yearindex[i]["indexval"] == undefined){
                    result= "{callsuc:0,callmsg:'年度总绩效指标指标值不能为空，保存失败!'}";
                    return result;
                }
            }
            var columns = responseWind.datatable.config.data[0].columns;
            var isvisiable = 0;
            for(var i=0;i<columns.length;i++) {
                if(columns[i]["colcode"] == "weight"){
                    isvisiable = columns[i]["isvisiable"];
                    break;
                }
            }
            if(sumweight != 100 && isvisiable == 1){
                result= "{callsuc:0,callmsg:'年度总绩效指标权重需为100，保存失败!'}";
                return result;
            }
            if(_ischeckweight){
                var weightcheckresult = responseWind.Ext.lt.pmkpi.weightCheckNew(responseWind.datatable,_weight_sum,"frameweight","actualweight","crossjsp","1");
                if (weightcheckresult && weightcheckresult != "success"){//校验
                    return weightcheckresult;
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
					"projname":encodeURIComponent(projname),
                    "procode":_procode,
					"pdm_proinfo":pdm_proinfo,
					"pdmsave":pdmsave,
                    "showtab":showtab,
					"indexdata":json,
                    "selectbillguid":selectbillguid,
                    "adjadd":adjadd,
                    "midproguid":midproguid,
                    "issuper":issuper,
                    "isedittotal":isedittotal,
                    "isperform":isperform
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
                            if(errinfo.indexOf('%') > -1) {
                                errinfo = errinfo.replace(/%/g,'%25');
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
// 处理特殊绩效
var specialpmkpi = function(){
    debugger;
    var result = "";
    var url = "/pmkpi/perfprogram/getSpecialIndex.do?tokenid="+getUrlParam('tokenid',responseWind.location.search)+"&authorization="+getUrlParam('authorization',responseWind.location.search)+"&year="+getUrlParam('year',responseWind.location.search);
    var permData = responseWind.datatable.getRecordSet().toArray();
    var _curtab = responseWind["_curtab"];
    var _procode = responseWind["_procode"];
    responseWind.tabcomps["#"+_curtab] =Ext.lt.cloneobj(permData);
    var tabdata = responseWind.tabcomps; //存放多年度页签.

    var commitable=true;
    var json = encodeURIComponent(JSON.stringify(tabdata),"utf-8");
    var projguid = getUrlParam('projId',responseWind.location.search);
    if(pdmsave=='21'){ //21暂存功能
        projguid = getUrlParam('stagid',responseWind.location.search);
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
                "showtab":showtab,
                "indexdata":json,
                "selectbillguid":selectbillguid,
                "adjadd":adjadd,
                "midproguid":midproguid,
                "issuper":issuper,
                "isperform":isperform
            },
            success : function(data) {
                var rs = JSON.parse(data);
                if (rs && rs.success == true) {
                    var rtdata = rs.rtdata;
                    var data = responseWind.datatable.getRecordSet().toArray();
                    responseWind.datatable.remove();
                    responseWind.datatable.addData(rtdata);
                    // var detaildatas = "";
                    // var dtable = "";
                    // detaildatas = new Ext.lt.recordset();
                    // dtable = new Ext.lt.datatable(detaildatas);
                    // detaildatas.setData(rtdata);
                } else if (rs.success == false){
                    result= "{callsuc:0,callmsg:'"+rs.rtdata;+"'}";
                } else {
                    result= "{callsuc:0,callmsg:'特殊绩效模板获取失败，请联系管理员!'}";

                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                result= "{callsuc:0,callmsg:'"+textStatus+"'}";
            }
        });
    }
    return result;
}
//调用保存方法,并返回状态给项目库系统,调用js方法自行实现
var retJson = "{callsuc:1,callmsg:'保存成功!'}";
// var retJson = "{callsuc:0, callmsg:'保存失败 未调用ajax'}";
debugger;
if(isperform == '1' && special == '1'){
    debugger;
    specialpmkpi();
}
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

</script>