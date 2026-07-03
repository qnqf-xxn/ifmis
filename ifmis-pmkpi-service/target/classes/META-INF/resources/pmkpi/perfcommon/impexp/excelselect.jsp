<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="gov.mof.fasp2.buscore.framework.util.GlobalConfig"%>
<%@ page import="java.util.Date" %>
<%
	response.setHeader("Cache-Control", "no-cache");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	String systemstyle = GlobalConfig.getConfigData("SYSTEM_STYLE", "default");
	String systemtitle = GlobalConfig.getConfigData("SYSTEM_TITLE", "");
	String appidpath = (String) request.getAttribute("appidpath");
	String time = ""+(new Date().getTime());
	String appid = null;

	if(appidpath!=null && !"".equals(appidpath)){
		appid = appidpath.substring(1,appidpath.length()).toUpperCase();
	}
	String key_warningmsg = "BUSCOMMON_UPLOAD_WARNING";

	String warningmsg=gov.mof.fasp2.buscore.framework.util.GlobalConfig.getConfigDataWithSpecialAppId(key_warningmsg,appid,"");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/>
	<script type="text/javascript">
		var info_load={};
		info_load.publics=[];//每个js/css加载时间  {name:string,time:int};
		info_load.ocxs=[];//每个ojbect(ocx等控件)加载时间  {name:string,time:int};
		info_load.public=new Date();
		info_load.all=new Date();
		var _ROOT_PATH_='/';
		var _BASE_STYLE = '<%=systemstyle%>';
		var _APPID_PATH_="<%=(String)request.getAttribute("appidpath")%>";
	</script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/frameworksupport.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_core.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_template.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/calendar.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/common.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/template/template_default.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/datatable3.0.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_datatable.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/common/themes/<%=systemstyle%>/uistyle.css" />
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/layui/layui.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/layui/css/layui.css" />
	<script type="text/javascript" src="/pmkpi/perfcommon/impexp/impexp_a.js"></script>
	<script type="text/javascript" src="/pmkpi/common/perfutil.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/common/template/template_default.js?<%=GlobalConfig.getVersionYear()%>"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/groupbydatatable.js?<%=GlobalConfig.getVersionYear()%>"></script>

	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/editdatatable.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_editpanel.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_editformpanel.js"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_tabpanelbutton.js"></script>

	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_spliterbar.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/common/themes/darkblue/anhui_other.css" />
	<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/style/fuds.css" />
	<%--<link rel="stylesheet" type="text/css" href="/pmkpi/themes/<%=systemstyle%>/common.css" />--%>

	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/fuds-upload.js?time=<%=time %>"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/fuds-download.js?time=<%=time %>"></script>
	<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/swfupload/jslib/fupload.js?time=<%=time %>"></script>
	<style>
		.button_style{
			background: #3472ef;
			border: 1px solid #3472ef;
			color: #fff;
			border-radius: 5px;
			padding: 3px 5px;
		}
		.OverBtn{
			background: #40a6ff;
			border: 1px solid #40a6ff;
			color: #fff;
			border-radius: 5px;
			padding: 3px 5px;
		}
		.importBtns{
			position: fixed;
			bottom: 20px;
			right: 10px;
			text-align: right;
		}
	</style>
	<title>文件选择</title>
	<script>

		$(function(){
			//是否显示导出模板按钮
			var isShowExpBtn = getUrlParam("isShowExpBtn");
			if (isShowExpBtn && isShowExpBtn == "false") {
				$("#importdata").hide();
			}
		})

		function exporttemplate(){
			var params = {};
			var url = window.location.search;
			params = getAllUrlParams(url);
			params.expimp = "impmodel";
			_exppost(params);
		}
		debugger
		function saveFile(){
			var tokenid = window.parent.Ext.lt.token.getTokenid();
			var formObject = document.getElementById("uploadfileform");
			var subfix = formObject.uploadfile.value;
			var imptype = getUrlParam("imptype");
			if(formObject.uploadfile.value == ""){
				alert("请选择要导入的文件！");
				return false;
			}
			if((subfix.substring(subfix.lastIndexOf(".") + 1))!="xls"&&(subfix.substring(subfix.lastIndexOf(".") + 1))!="xlsx"){
				alert("请选择excel文件!");
				return false;
			}
			Ext.lt.ui.loadingShow();
			if (_APPID_PATH_ == null || _APPID_PATH_ == "") {
				var pathname = window.location.pathname;
				pathname = pathname.substring(1, pathname.length);
				pathname = pathname.substring(0, pathname.indexOf("/"));
				document.getElementById("uploadfileform").action = "/" + pathname
						+ "/perfcommon/impexp/file.jsp?serverid=pmkpi.perfcommon.impexp.ImpExpAComponet&tokenid=" + tokenid;
			}
			document.getElementById("uploadfileform").action += "&tokenid=" + tokenid + "&method=upload&imptype="+imptype+
					"&args="+encodeURI(window.parent.Ext.lt.outfile.args)+
					"&callBackFunc="+encodeURI(window.parent.Ext.lt.outfile.callBackFunc);
			var btn = document.getElementById("importdata1");
			var btn1 = document.getElementById("importdata");
			var btn2 = document.getElementById("importdata2");
			// btn.disabled = 'disabled';
			// btn1.disabled = 'disabled';
			// btn2.disabled = 'disabled';
			document.getElementById("uploadfileform").submit();
		}

		function cancle(){
			window.parent.Ext.lt.outfile.window.close();
		}

	</script>

</head>
<body>
<br />
<form id="uploadfileform" name="uploadfileform" method="post" ENCTYPE="multipart/form-data" action ="<%=(String)request.getAttribute("appidpath")%>/perfcommon/impexp/file.jsp?serverid=pmkpi.perfcommon.impexp.ImpExpAComponet">
	<label for="uploadfile" >选择文件：</label>
	<input type="file"  name= "filename" id="uploadfile" SIZE="60"/>
	<br />
	<span><font style='color: red;height: 36px;margin-left: 0px;font-size: 13px;'><%=warningmsg %></font></span>
</form>
<br />
<div class="importBtns">
	<button id="importdata" name="importdata" onclick="exporttemplate()" class="button_style"
			onmouseover="this.className='OverBtn'"
			onmouseout="this.className='button_style'"
			onmousedown="this.className='down'">
		导出模板
	</button>
	&nbsp;&nbsp;&nbsp;
	<button id="importdata1" name="importdata" onclick="saveFile()" class="button_style"
			onmouseover="this.className='OverBtn'"
			onmouseout="this.className='button_style'"
			onmousedown="this.className='down'">
		导入数据
	</button>
	&nbsp;&nbsp;&nbsp;
	<button id="importdata2" name="importdata" onclick="cancle()" class="button_style"
			onmouseover="this.className='OverBtn'"
			onmouseout="this.className='button_style'"
			onmousedown="this.className='down'">
		取消操作
	</button>
</div>
</body>

</html>