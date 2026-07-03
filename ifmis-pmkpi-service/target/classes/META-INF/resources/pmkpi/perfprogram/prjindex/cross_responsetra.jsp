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
    if (!responseWind.editform.check()) {
        result= "{callsuc:0,callmsg:'请填写绩效目标！',timeout:1}";
        return result;
    }
    var datas = responseWind.datatable.getRecordSet().toArray();
    var cols = responseWind.datatable.getCols();
    var returnStr = "";
    var str = "";
    for (var i = 0,leni = datas.length; i < leni; i++) {
        if (datas[i]["levelno"] == 3) {
            if(datas[i].computesign != 6 && datas[i].computesign != 9 && datas[i].computesign != 10 && (!datas[i].meterunit || datas[i].meterunit == "")){
                str = "第" + (datas[i]["_sortid"] + 1) + "行的计量单位为必录项，必须有值。";
                returnStr = "{callsuc:0,callmsg:'"+str+"'}";
                return returnStr;
            }
            for (var j = 0,lenj = cols.length; j < lenj; j++) {
                if (cols[j].requirement == '1' && datas[i]["levelno"] == 3) {
                    var value = datas[i][cols[j].colcode];
                    if (value == null || value == "" || ("" + value).trim().length == 0) {
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

responseWind.Ext.lt.layout.doLayout();
var otherappfunc = function(){
	debugger;
	var url = "/pmkpi/perfprogram/saveTraGoalAndIndex.do?tokenid="+getUrlParam('tokenid',responseWind.location.search)+"&authorization="+getUrlParam('authorization',responseWind.location.search)+"&year="+getUrlParam('year',responseWind.location.search);
    var _treeid = responseWind["_treeid"];
    var result = "";
    if (responseWind.datatable.getEditor()){
        responseWind.datatable.closeEdit();
    }
    if (_treeid) {
        result = checkAll();
    }
    if(result != ""){
        return result;
    }
    var tabdata = responseWind.datasmap; //页面数据
    var _procode = responseWind["_procode"];

    var indexs = responseWind.datatable.getRecordSet().toArray();
    var goal =  responseWind.editform.getEditFormValues();
    var params = {};
    params.goal = goal;
    params.indexs = indexs;
    tabdata[_treeid] = params;
    Object.keys(tabdata).forEach(key => {
        if (tabdata[key] && tabdata[key].goal) {
            var goaldata = tabdata[key].goal;
            goaldata.kpi_target = convertStr(goaldata.kpi_target);
            var indexsdata = tabdata[key].indexs;
            if (indexsdata && indexsdata.length > 0) {
                for (var a = 0, leni = indexsdata.length; a < leni; a++) {
                    if(indexsdata[a].levelno == "3") {
                        var checkresult = responseWind.Ext.lt.pmkpi.checkSpaceValue(indexsdata[a],"绩效指标-第" + (indexsdata[a]["_sortid"] + 1) + "行","datatable");
                        if (checkresult && checkresult != "success"){//校验空格
                            result = checkresult;
                            return result;
                        }
                        indexsdata[a].name = convertStr(indexsdata[a].name);
                        indexsdata[a].indexval = convertStr(indexsdata[a].indexval);
                        indexsdata[a].kpi_val = convertStr(indexsdata[a].kpi_val);
                    }
                }
            }
        }
    });
    var commitable=true;
	var json = encodeURIComponent(JSON.stringify(tabdata),"utf-8");
    var pdm_proinfo = $("#pdm_proinfo").val();
	if(commitable){
		$.ajax({
				url : url,
				type:"POST",
				dataType:"text",
				async: false,
				data : {
                    "procode":_procode,
					"pdm_proinfo":pdm_proinfo,
					"json":json
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

//调用保存方法,并返回状态给项目库系统,调用js方法自行实现
var retJson = "{callsuc:1,callmsg:'保存成功!'}";
debugger;
if(pdmsave=='1' || pdmsave=='21'){
	retJson = otherappfunc();
} else {
    if (responseWind.datasmap &&  responseWind.datasmap.submofs.length > 0) {
        responseWind.Ext.lt.pmkpi.queryiframedastas();//加载填报过的年度绩效目标、指标
    }
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
</script>