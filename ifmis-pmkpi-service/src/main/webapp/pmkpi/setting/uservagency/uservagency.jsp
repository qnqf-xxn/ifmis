<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
     
String SYSTEM_STYLE = (String) request.getAttribute("SYSTEM_STYLE");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/> 
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/frameworksupport.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_core.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_template.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/fasp.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/common.js"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/layui/layui.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/datatabletheme35.css" />
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/calendar/calendar.css" />
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/common/themes/default/uistyle.css" />
		<%=request.getAttribute("page_head")%>
		<title>用户对单位</title>
	</head>
	 <body style="overflow:hidden;">
	 	<div id="leftbody" class="left_tree  mar_top have_border" style="width:28%;float:left;">
	 		<div class="customdiv" style="width:98%;"></div>
	 		<%-- 左侧树形列表区 --%>
			<div id='lefttreediv'  style="border:1px solid #ddd;width:98%;"></div>
	 	</div>
	 	<div id="rightbody_div" class="rightbody" style="margin:10px;float:left;width:70%;height:98%">
	 		<div id='buttondiv' style='heigth:40px;display:block;'></div>
			<div id="tip" style="color: red;font-weight:bold;font-size:12px;margin:18px;">不覆盖本年度配置，仅同步增量部分</div>
			<div style="display:block;float:left;">
				<div id="leftmenudiv" style="float:left;width:480px;">
					<div class="tbtitle" id='tbtitle' style="margin-top:-10px;heigth:40px;">
						<ul>
							<li><div>可选单位</div></li>
						</ul>
					</div>
					<div id ='menudiv' style="border:1px solid #ddd; margin-top:-10px; " ></div>
				</div>

				<div id="copymenudiv" style="float:left;width:480px;">
					<div class="tbtitle" id='copytitle' style="margin-top:-10px;heigth:40px;">
						<ul>
							<li><div>上年已配置单位</div></li>
						</ul>
					</div>
					<div id ='copymenudiv2' style="border:1px solid #ddd; margin-top:-10px; " ></div>
				</div>

				<div style="border:1px solid #ddd;float:left; width:400px;margin-top:33px;" id='drdiv'></div>
			</div>
	 	</div>

		<%--<div id="copybody_div" class="copybody" style="border:1px solid red;margin:10px;float:left;width:70%;height:98%">
			<div style="display:block;float:left;">
				<div id="copymenudiv" style="float:left;width:480px;">
					<div class="tbtitle" id='copytitle' style="margin-top:-10px;heigth:40px;">
						<ul>
							<li><div>上年已配置单位</div></li>
						</ul>

					</div>
					<div id ='copymenudiv2' style="border:1px solid #ddd; margin-top:-10px; " ></div>
				</div>
				<div style="border:1px solid #ddd;float:left; width:400px;margin-top:33px;" id='drdivcopy'></div>
			</div>
		</div>--%>

	</body> 
</html>
<%=request.getAttribute("page_content")%>