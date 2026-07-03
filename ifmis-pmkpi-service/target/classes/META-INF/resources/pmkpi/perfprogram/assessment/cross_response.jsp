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
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/common.js"></script>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_datatable.js"></script>
<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/datatable3.0.js"></script>
<script type="text/javascript" src="../../common/template/template_default.js"></script>
<script type="text/javascript" src="../../common/perfcommon.js"></script>
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
var pdmsave = getUrlParam('pdmsave');
responseWind.Ext.lt.layout.doLayout();
function checkAssessment(datas){
    var returnStr = "";
    var str = "";
    var cols = responseWind.datatable.getCols();
    for (var i = 0,leni = datas.length; i < leni; i++) {
        for (var j = 0,lenj = cols.length; j < lenj; j++) {
            if (cols[j].requirement == '1' && datas[i]["isleaf"] == 1) {
                var value = datas[i][cols[j].colcode];
                if (value == null || value == "" || ("" + value).trim().length == 0) {
                    str = "第" + (datas[i]["_sortid"] + 1) + "行的" + cols[j].alias + "为必录项，必须有值。";
                    returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                    return returnStr;
                }
            }
        }
    }
    try {
        if (!responseWind.editform.check()) {
            return "{callsuc:0,callmsg:'请填写评估意见必填项'}";
        }
    } catch (e) {}
    return "";
}
var otherappfunc = function(){
	debugger;
	var result = "";
	var url = "/pmkpi/perfprogram/saveAssessment.do?tokenid="+getUrlParam('tokenid',responseWind.location.search)+"&authorization="+getUrlParam('authorization',responseWind.location.search);
    var datas = responseWind.datatable.getRecordSet().toArray();
    var assessmentInfojson = "";
    var is_JiangXi = responseWind.is_JiangXi;
    var projcode = "";
    var projname = "";
    var performdesc ="";
    var returnStr = "";
    var v_col7 = "";//江西是否事前评估 1是2否
    if(responseWind.parent["editform"]){
        if(responseWind.parent["editform"].getCol("procode")){
            projcode = responseWind.parent["editform"].getCol("procode").getvalue();
        }
        if(responseWind.parent["editform"].getCol("proname")){
            projname = responseWind.parent["editform"].getCol("proname").getvalue();
        }
        if(responseWind.parent["editform"].getCol("performdesc")){
            performdesc = responseWind.parent["editform"].getCol("performdesc").getvalue();
        }
        if(responseWind.parent["editform"].getCol("v_col7")){
            v_col7 = responseWind.parent["editform"].getCol("v_col7").getvalue();
        }
    }
    if(is_JiangXi && v_col7 == "1" && pdmsave != '21') { //21暂存功能
        returnStr = checkAssessment(datas);
    } else if (!is_JiangXi && pdmsave != '21') {
        returnStr = checkAssessment(datas);
    }
    if (returnStr && returnStr != "" && returnStr != "undefined") {
        return returnStr;
    }
    try {
        var opinioninfo = responseWind.editform.getEditFormValues();
        if (JSON.stringify(opinioninfo) != "{}") {
            assessmentInfojson = encodeURIComponent(JSON.stringify(opinioninfo),"utf-8");
        }
    } catch (e) {}
	var json = encodeURIComponent(JSON.stringify(datas),"utf-8");
	var projguid = getUrlParam('projId',responseWind.location.search);
    if(pdmsave=='21'){ //21暂存功能
        projguid = getUrlParam('stagid',responseWind.location.search);
    }
    var selectbillguid = getUrlParam('selectbillguid',responseWind.location.search);//调整前的guid
    var adjadd = getUrlParam('adjadd',responseWind.location.search);//是否调整
    var midproguid = getUrlParam('midguid',responseWind.location.search); //暂存草稿
	var projtype = getUrlParam('projtype',responseWind.location.search);
    var pdm_proinfo = $("#pdm_proinfo").val();
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
            "performdesc":performdesc,
            "pdm_proinfo":pdm_proinfo,
            "pdmsave":pdmsave,
            "assessmentInfojson":assessmentInfojson,
            "selectbillguid":selectbillguid,
            "adjadd":adjadd,
            "midproguid":midproguid,
            "list":json
        },
        success : function(data) {
            var rs = JSON.parse(data);
            if (rs && rs.success == true) {
                result= "{callsuc:1,callmsg:'保存成功!'}";
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
                } else {
                    result= "{callsuc:0,callmsg:'保存失败!'}";
                }
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            result= "{callsuc:0,callmsg:'"+textStatus+"'}";
        }
    });
	return result;


};
//调用保存方法,并返回状态给项目库系统,调用js方法自行实现
var retJson = "{callsuc:1,callmsg:'保存成功!'}";
//retJson = "{callsuc:0,callmsg:'保存失败!'}";
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
window.location.href=url+'?'+reqParam.join('&');

</script>