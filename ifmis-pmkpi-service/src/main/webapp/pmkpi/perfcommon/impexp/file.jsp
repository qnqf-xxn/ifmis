<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" import="gov.mof.fasp2.buscore.framework.util.ServiceFactory,gov.mof.fasp2.pmkpi.perfcommon.impexp.ImpExpAComponet,gov.mof.fasp2.buscore.framework.server.ServerContext"%>
<%  
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
    ImpExpAComponet fileUploadService = (ImpExpAComponet)ServiceFactory.getBean("pmkpi.perfcommon.impexp.ImpExpAComponet");
    ServerContext context = new ServerContext(request, response, this);
    fileUploadService.setServerContext(context);
    byte[] aa = fileUploadService.upload();
    out.println(new String(aa));
%>