<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    String time = ""+(new Date().getTime());
      
    String SYSTEM_STYLE = (String) request.getAttribute("SYSTEM_STYLE");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<script type="text/javascript">
		var ROOT_PATH = '/';
		</script>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1"/> 
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/frameworksupport.js?time=<%=time %>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/ltext_core.js?time=<%=time %>"></script>
		<%--<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/fuds-upload.js?time=<%=time %>"></script>--%>
		<script type="text/javascript" src="/pmkpi/common/filemanage/fuds-upload.js?time=<%=time %>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/fuds-download.js?time=<%=time %>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/swfupload/jslib/fupload.js?time=<%=time %>"></script>
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/datatable3.0.js?time=<%=time %>"></script>
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/common/themes/<%=SYSTEM_STYLE%>/uistyle.css" />
		<%--<link rel="stylesheet" type="text/css" href="/pmkpi/themes/<%=SYSTEM_STYLE%>/common.css" />--%>
		<link rel="stylesheet" type="text/css" href="<%=(String)request.getAttribute("appidpath")%>/busfw/ltext/style/fuds.css" />
		<script type="text/javascript" src="<%=(String)request.getAttribute("appidpath")%>/busfw/common/ui/common.js?time=<%=time %>"></script>
  		<title>附件管理</title>
  		<script>
  		    var systemStyle = '<%=SYSTEM_STYLE%>';
  		</script>
  	</head>
	<body class="sysdefaultbg">
		<div align="center" style="border:solid 0px #336699;width: 100%;height: 100%;">
			<table border="0" cellpadding="0" cellspacing="0" style="width: 100%;height: 100%;">
				<tr>
					<td style="height:40px;" valign="middle">
						<div id="filediv" style="height:30px;line-height: 30px;"></div>
					</td>
				</tr>
				<tr>
					<td style="height:380px;">
						<div id="filelistdiv" style="height:380px;border:solid 1px #c2c2c2;
							margin-left:3px;"></div>
					</td>
				</tr>
			</table>
		</div>
	</body>
</html>