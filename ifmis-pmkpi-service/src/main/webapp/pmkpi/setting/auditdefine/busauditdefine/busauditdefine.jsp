<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="gov.mof.fasp2.buscore.framework.util.GlobalConfig" %>
<%@ page import="java.util.Date" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

	String systemstyle = "darkblue";//GlobalConfig.getConfigData("SYSTEM_STYLE", "darkblue");
	String systemtitle = GlobalConfig.getConfigData("SYSTEM_TITLE", "");
	String time = ""+(new Date().getTime());
     
String SYSTEM_STYLE = (String) request.getAttribute("SYSTEM_STYLE");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<script type="text/javascript">
			var info_load={};
			info_load.publics=[];//每个js/css加载时间  {name:string,time:int};
			info_load.ocxs=[];//每个ojbect(ocx等控件)加载时间  {name:string,time:int};
			info_load.public=new Date();
			info_load.all=new Date();
			var _ROOT_PATH_='/';
			var _BASE_STYLE = '<%=systemstyle%>';
		</script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/frameworksupport.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_core.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_template.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/common.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_toolbuttonbar.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/common/template/template_default.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/calendar.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/groupbydatatable.js?<%=GlobalConfig.getVersionYear()%>"></script>

		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/datatable3.0.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/editdatatable.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_editpanel.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_editformpanel.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_tabpanelbutton.js"></script>

		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/common/themes/<%=systemstyle%>/uistyle.css" />
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_spliterbar.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/layui/css/layui.css" />
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/common/themes/darkblue/anhui_other.css" />
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/style/fuds.css" />
		<%--<link rel="stylesheet" type="text/css" href="/pmkpi/themes/<%=systemstyle%>/common.css" />--%>

		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/layui/layui.js"></script>

		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/fuds-upload.js?time=<%=time %>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/fuds-download.js?time=<%=time %>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/swfupload/jslib/fupload.js?time=<%=time %>"></script>
		<title><%=systemtitle%></title>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/common/perfcommon.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/common/perfutil.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/common/ueditor/ueditor.config.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/common/ueditor/ueditor.all.js"></script>
		<%=request.getAttribute("page_head")%>
		<%=request.getAttribute("page_head")%>
		<title>审核定义业务配置</title>
	</head>
	 <body style="overflow-y: hidden;">
	 	<div id="leftbody" class="left_tree  mar_top have_border" style="margin:5px;height:97%;float:left;">
	 		<%-- 左侧树--%>
			<div id='lefttreediv'  style="height:100%;"></div>
	 	</div>
		<div id="contentbody" class="left_tree  mar_top have_border" style="margin:5px;float:left;height:98%;">
			<%-- 中间树 --%>
			<div id='contenttreediv'  style="height:98%;"></div>
		</div>
	 	<div id="rightbody_div" class="rightbody" style="margin:5px;float:left;height:95%;">
	 		<div id='buttondiv' style='heigth:40px;display:block;'></div>
			<div id='datatablediv' style="float:left;"></div>
	 	</div>
	</body>
</html>
<%=request.getAttribute("page_content")%>