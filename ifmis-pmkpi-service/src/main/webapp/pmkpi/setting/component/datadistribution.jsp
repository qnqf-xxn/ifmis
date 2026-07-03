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

		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/datatable3.0.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/editdatatable.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_editpanel.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_editformpanel.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_tabpanelbutton.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/buscommon/fileimport/js/import.js?<%=GlobalConfig.getVersionYear()%>"></script>

		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/common/themes/<%=systemstyle%>/uistyle.css" />
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/ui_spliterbar.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/layui/css/layui.css" />
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/common/themes/darkblue/anhui_other.css" />
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/style/fuds.css" />

		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/layui/layui.js?<%=GlobalConfig.getVersionYear()%>"></script>

		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/fuds-upload.js?<%=GlobalConfig.getVersionYear()%>&time=<%=time %>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/fuds-download.js?<%=GlobalConfig.getVersionYear()%>&time=<%=time %>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/swfupload/jslib/fupload.js?<%=GlobalConfig.getVersionYear()%>&time=<%=time %>"></script>
		<title><%=systemtitle%></title>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/common/perfcommon.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/common/perfutil.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/common/ueditor/ueditor.config.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/common/ueditor/ueditor.all.js?<%=GlobalConfig.getVersionYear()%>"></script>
		<%=request.getAttribute("page_head")%>
		<title>组件数据权限分配</title>
	</head>
	 <body style="overflow: hidden">
	    <%--<div id="headerdiv" class='header'><div style="width:100%;"></div></div>--%>
	 	<div id="leftbody" class="left_tree  mar_top have_border" style="width:300px;float:left;">
	 		<div class="customdiv" style="width:290px;">
	 			角色类型<select id = "roletypeselect" style="margin-left:10px;width:180px;margin-top:10px;" onchange="caruletypeChange(this)">
								<option value="1">财政角色</option>
								<option value="2">单位角色</option>
								<option value="3">部门角色</option>
								<option value="4">银行角色</option>
					  </select>
	 		</div>
	 		<%-- 左侧树形列表区 --%>
			<div id='lefttreediv'  style="width:290px;"></div>
	 	</div>
	 	<div id="rightbody_div" class="rightbody" style="margin:10px;float:left;">
	 		<div id='buttondiv' style='heigth:40px;display:block;'></div>
			<div style="display:block;float:left;">
				<div id="leftmenudiv" style="border:1px solid #ddd;width:350px; float:left;">
					<%--<div class="tbtitle" id='tbtitle' style="margin-top:0px;">
						<ul>
							<li><div>系统菜单</div></li>
						</ul>
					</div>--%>
					<div id ='menudiv' ></div>
				</div>
				<div id="leftbodys" class="left_tree  mar_top have_border" style="width:300px;float:left;">
				<div class="operatediv" style="margin:5px;width:290px;">
					<select id = "operationtypeselect" style="width: 150px" onchange="operationTypeButton(this)">
					<option value="">请选择</option>
				</select>
				</div>
				<div style="margin:5px;float:left; width:400px;" id='drdiv'></div>
			</div>
			</div>
	 	</div>
		
	</body> 
</html>
<%=request.getAttribute("page_content")%>