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
var pdmsave = getUrlParam('pdmsave');
responseWind.Ext.lt.layout.doLayout();
debugger;
var isperform = '2';
var special = getUrlParam('special',responseWind.location.search);
if(responseWind.parent["editform"].getCol("is_perform") != undefined){
    isperform = responseWind.parent["editform"].getCol("is_perform").getvalue();
}
var otherappfunc = function(){
	debugger;
	//alert("save done!");
	var result = "";
	var url = "/pmkpi/perfprogram/saveAllGoal.do?tokenid="+getUrlParam('tokenid',responseWind.location.search)+"&authorization="+getUrlParam('authorization',responseWind.location.search)+"&year="+getUrlParam('year',responseWind.location.search);
    if(pdmsave != '21') { //21暂存功能
        if (!responseWind.editform.check()) {
            result= "{callsuc:0,callmsg:'请填写绩效目标！',timeout:1}";
            return result;
        }
    }
    var _curtab = responseWind["_curtab"];
    var showtab = responseWind["showtab"];
    var _procode = responseWind["_procode"];
    var _isedittotal = responseWind["_isedittotal"];
    var tempdata =  responseWind.editform.getEditFormValues();
    var tabcomps = responseWind.tabcomps;
    tabcomps["#"+_curtab]=Ext.lt.cloneobj(tempdata);
    var _yeardata;
    var _totaldata;
    if(pdmsave != '21') { //21暂存功能
        if ((showtab == "1" || showtab == "3")) {
            _yeardata = tabcomps["#year"];
            //校验年度目标是否为空
            if (!_yeardata || !_yeardata.kpi_target || _yeardata.kpi_target == "") {
                //Ext.lt.ui.alert("请填写年度绩效目标！",{timeout:1},function(){});
                result= "{callsuc:0,callmsg:'请填写年度绩效目标！',timeout:1}";
                return result;
            }
            if (_yeardata.kpi_target == "-" || _yeardata.kpi_target == "_" || _yeardata.kpi_target == "*") {
                result= "{callsuc:0,callmsg:'年度绩效目标不符合规范,请重新填写！',timeout:1}";
                return result;
            }
            var checkresult = responseWind.Ext.lt.pmkpi.checkSpaceValue(_yeardata,"年度绩效目标","editform");//校验空格
            if (checkresult && checkresult != "success"){//校验空格
                result = checkresult;
                return result;
            }
        }
        if ((showtab == "1" || showtab == "2")) {
            _totaldata = tabcomps["#total"];
            //校验中期目标是否为空
            if (!_totaldata || !_totaldata.kpi_target || _totaldata.kpi_target == "") {
                result= "{callsuc:0,callmsg:'请填写总体绩效目标！',timeout:1}";
                return result;
            }
            if (_totaldata.kpi_target == "-" || _totaldata.kpi_target == "_" || _totaldata.kpi_target == "*") {
                result= "{callsuc:0,callmsg:'总体绩效目标不符合规范,请重新填写！',timeout:1}";
                return result;
            }
            var checkresult = responseWind.Ext.lt.pmkpi.checkSpaceValue(_totaldata,"总体绩效目标","editform");//校验空格
            if (checkresult && checkresult != "success"){//校验空格
                result = checkresult;
                return result;
            }
        }
    }
	var commitable=true;
    try{
        if (_yeardata) {
            _yeardata.kpi_target = convertStr(_yeardata.kpi_target);
        }
        if (_totaldata) {
            _totaldata.kpi_target = convertStr(_totaldata.kpi_target);
        }
    }catch(exception){
        return false;
    }
    var goaljson = encodeURIComponent(JSON.stringify(tabcomps),"utf-8");
    //var editinfojson = convertStr(goaledit);
	//var projguid = responseWind.projguid;
	var projguid = getUrlParam('projId',responseWind.location.search);
    if(pdmsave=='21'){ //21暂存功能
        projguid = getUrlParam('stagid',responseWind.location.search);
    }
	var selectbillguid = getUrlParam('selectbillguid',responseWind.location.search);//调整前的guid
    var adjadd = getUrlParam('adjadd',responseWind.location.search);//是否调整
    var projtype = getUrlParam('projtype',responseWind.location.search);
    var dbgyear = getUrlParam('year',responseWind.location.search); //年度暂时没有用到
    var midproguid = getUrlParam('midguid',responseWind.location.search); //暂存草稿
	
	var projcode = "";
	var projname = "";
    if(responseWind.parent["editform"]){
   	   if(responseWind.parent["editform"].getCol("pro_code")){
 	      projcode = responseWind.parent["editform"].getCol("pro_code").getvalue();
       }
	   if(responseWind.parent["editform"].getCol("pro_name")){
	      projname = responseWind.parent["editform"].getCol("pro_name").getvalue();
	   }
	   /*if(responseWind.parent["editform"].getCol("pro_desc")){
          performdesc = responseWind.parent["editform"].getCol("performdesc").getvalue();
	   }*/
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
                    "isedittotal":_isedittotal,
					"pdmsave":pdmsave,
                    "goaljson":goaljson,
                    "selectbillguid":selectbillguid,
                    "adjadd":adjadd,
                    "showtab":showtab,
                    "midproguid":midproguid,
                    "isperform":isperform
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
    var tabcomps = responseWind.tabcomps;
    var url = "/pmkpi/perfprogram/getSpecialGoal.do?tokenid="+getUrlParam('tokenid',responseWind.location.search)+"&authorization="+getUrlParam('authorization',responseWind.location.search)+"&year="+getUrlParam('year',responseWind.location.search);
    var commitable=true;
    var goaljson = encodeURIComponent(JSON.stringify(tabcomps),"utf-8");
    //var editinfojson = convertStr(goaledit);
    //var projguid = responseWind.projguid;
    var projguid = getUrlParam('projId',responseWind.location.search);
    if(pdmsave=='21'){ //21暂存功能
        projguid = getUrlParam('stagid',responseWind.location.search);
    }
    var selectbillguid = getUrlParam('selectbillguid',responseWind.location.search);//调整前的guid
    var adjadd = getUrlParam('adjadd',responseWind.location.search);//是否调整

    var projcode = "";
    if(responseWind.parent["editform"]){
        if(responseWind.parent["editform"].getCol("pro_code")){
            projcode = responseWind.parent["editform"].getCol("pro_code").getvalue();
        }
    }
    if(commitable){
        $.ajax({
            url : url,
            type:"POST",
            dataType:"text",
            async: false,
            data : {
				"proguid":projguid,
                "procode":projcode,
                "pdmsave":pdmsave,
                "goaljson":goaljson,
                "selectbillguid":selectbillguid,
                "adjadd":adjadd,
                "isperform":isperform
            },
            success : function(data) {
                var rs = JSON.parse(data);
                if (rs && rs.success == true) {
                    var rtdata = rs.rtdata;
                    parent.editform.synchEditform(rtdata);
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
//retJson = "{callsuc:0,callmsg:'保存失败!'}"; 
debugger;
if(isperform == '1' && special == '1'){
    debugger;
    specialpmkpi();
}
if(pdmsave=='1' || pdmsave=='21'){ //21暂存功能
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

/**
 * 特殊字替换
 * @param remark
 * @returns {*}
 */
function convertStr1 (remark) {
    /*
    为 全角
    \>
    \<
    \;
    \& 和号
    \'单引号
    \" 双引号
    \% 百分号
    \# #号
    */
    remark =remark.replace("\\","＼");
    var  s= "/,>,<,;,&,',\",%,#,\\?,\\[,\\]";
    var  n= "／,》,《,；,＆,‘,“,％,＃,？,【,】";
    var sArray = s.split(",");
    var nArray = n.split(",") ;
    for (var i = 0 ;i<sArray.length;i++){
        var reg = new RegExp(sArray[i],"g") ;
        remark = remark.replace( reg,nArray[i]) ;
    }
    remark = replaceGBKPoint(remark);
    return remark ;
}

</script>