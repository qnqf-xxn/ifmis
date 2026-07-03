/**
 * @Title: ImpExpAComponet.java
 * @Copyright (C) 2018
 * @Description:
 * @Revision History:
 * @Revision 1.0 2018-9-4  钟毅
 */

package gov.mof.fasp2.pmkpi.perfcommon.impexp;

import com.jspsmart.upload.File;
import com.jspsmart.upload.SmartUpload;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.xch.util.Globals;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.*;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class ImpExpAComponet extends PmkpiService {

    private static Logger logger = Logger.getLogger(ImpExpAComponet.class);

    public static final ThreadLocal<String> FILE_GUIDS =new ThreadLocal<String>();

    private ImpExpABO impExpABO = null;

    private static Date lastClear  =null;

    protected SmartUpload init() throws Exception {
        SmartUpload su = new SmartUpload();
        su.service(this.getRequest(), this.getResponse());
        su.upload();
        return su;
    }

    /**
     * 获取返回处理
     * @return
     */
    public Map getImportData(String guid) {
        return (Map) this.getSession().getAttribute(guid);
    }

    /**
     * @return impExpABO
     */
    public ImpExpABO getImpExpABO() {
        if (impExpABO == null) {
            impExpABO = (ImpExpABO) PerfServiceFactory.getBean("pmkpi.perfcommon.impexp.ImpExpABOTX");
        }
        return impExpABO;
    }

    /**
     * @param impExpABO 要设置的 impExpABO
     */
    public void setImpExpABO(ImpExpABO impExpABO) {
        this.impExpABO = impExpABO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    public Map confirmSave(HashMap paras, ArrayList datalist) throws AppException{
        return this.getImpExpABO().busImpConfirmDatasSave(paras, datalist);
    }

    public Map impexp(HashMap<String, Object> params) throws AppException {
        HttpServletRequest request = this.getRequest();
        HttpServletResponse response = this.getResponse();
        String expimp = (String) params.get("expimp");
        if (expimp == null) {
            return null;
        } else if ("exp".equals(expimp)) {// 导出
            this.getImpExpABO().exp(params, request, response);
        } else if("impmodel".equals(expimp)){
            this.getImpExpABO().expImpModel(params, request, response);
        }
        return null;
    }

    /**
     * 获取要导入数据
     * @param
     * @return
     */
    @SuppressWarnings("rawtypes")
    public byte[] upload() throws Exception {
        this.getRequest().setCharacterEncoding("gbk");
        List<Map<String,String>> results = new ArrayList<Map<String,String>>();
        String impexpcode = null;
        String args = null;
        String imptype = null;
        Map argMap = new HashMap();
        StringBuffer str = new StringBuffer();
        try {
            SmartUpload su = init();
            File f = su.getFiles().getFile(0); // 获取导入文件
            String _APPID_PATH_= (String) this.getRequest().getAttribute("appidpath");
            // 预留参数
            args = this.getRequest().getParameter("args");
            if (args != null && !args.isEmpty()) {
                argMap = JsonUtils.jsonToMap(Escape.unescape(args));
            }
            // 获取模板编码
            impexpcode = (String) argMap.get("impexpcode");
            // 导入类型
            imptype = (String) argMap.get("imptype");
            if (f.isMissing()) {
                logger.error("无文件");
                Globals.putErrorInfo(results,"无上传文件");
                this.getSession().setAttribute(impexpcode, Globals.getResultinfo(Globals.ERRORFLAG, results));
                return null;
            } else {
                // 导入数据处理
                List errorList = null;
                //处理1天前的日志文件
                if(lastClear==null){
                    lastClear = new Date();
                }
                long date = System.currentTimeMillis();
                if(date-lastClear.getTime()>1000*60*60*24){
                    FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
                    errordao.clearErrorMsg(lastClear);
                    lastClear=new Date();
                }
                FILE_GUIDS.set(RandomGUID.geneGuid().toUpperCase());
                ImpExpABO impExpABO = (ImpExpABO) PerfServiceFactory.getBean("pmkpi.perfcommon.impexp.ImpExpABO");
                //报告导入
                if ("reportimp".equals(imptype)) {
                    errorList = impExpABO.impreport(f, argMap);
                } else { //正常导入
                    errorList = impExpABO.imp(f, argMap);
                }
                if (errorList != null && errorList.size() > 0) {
                    this.getSession().setAttribute(impexpcode, Globals.getResultinfo(Globals.ERRORFLAG, errorList));
                    str.append("<html xmlns='http://www.w3.org/1999/xhtml'>");
                    str.append("<head>");
                    str.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>");
                    str.append("<meta http-equiv='X-UA-Compatible' content='IE=Edge,chrome=1'>");
                    str.append("</head>");
                    str.append("<body>");
                    str.append("<script>");
                    str.append("var _APPID_PATH_='");
                    str.append(_APPID_PATH_);
                    str.append("';\r\n");
                    str.append("window.onload =");
                    str.append("function(){");
                    str.append("window.parent.showerrordiv('"+FILE_GUIDS.get()+"');");
                    str.append("window.history.back();}");
//                    str.append("window.onload =");
//                    str.append("function(){alert('导入报错!报错信息:第");
//                    str.append("" + ((Map)errorList.get(0)).get("lineno") + "");
//                    str.append("行：" + ((Map)errorList.get(0)).get("errormsg") + "");
//                    str.append("');window.parent.Ext.lt.outfile.window.close();}");
                    str.append("</script>");
                    str.append("</body>");
                    str.append("</html>");
                } else {
                    Globals.putErrorInfo(results, "文件解析上传成功,成功条数：" + impExpABO.getSucessCount());
                    this.getSession().setAttribute(impexpcode, Globals.getResultinfo(Globals.SUCESSFLAG, results));
                    String callBackFunc = this.getRequest().getParameter("callBackFunc");
                    if (callBackFunc != null) {
                        callBackFunc = Escape.unescape(callBackFunc);
                    }
                    String APPIDPATH= (String) this.getRequest().getAttribute("appidpath");
                    String systemstyle = GlobalConfig.getConfigData("SYSTEM_STYLE", "default");
                    str.append("<html xmlns='http://www.w3.org/1999/xhtml'>");
                    str.append("<head>");
                    str.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>");
                    str.append("<meta http-equiv='X-UA-Compatible' content='IE=Edge,chrome=1'>");
                    str.append("<script type='text/javascript' src='" + APPIDPATH
                            + "/busfw/ltext/frameworksupport.js'></script>");
                    str.append("<script type='text/javascript' src='" + APPIDPATH
                            + "/busfw/ltext/ltext_core.js'></script>");
                    str.append("<script type='text/javascript' src='" + APPIDPATH
                            + "/busfw/ltext/ltext_template.js'></script>");
                    str.append("<script type='text/javascript' src='" + APPIDPATH
                            + "/busfw/common/ui/common.js'></script>");
                    str.append("<script type='text/javascript' src='" + APPIDPATH
                            + "/busfw/common/template/template_default.js'></script>");
                    str.append("<script type='text/javascript' src='" + APPIDPATH
                            + "/busfw/ltext/datatable3.0.js'></script>");
                    str.append("<script type='text/javascript' src='" + APPIDPATH
                            + "/busfw/common/ui/ui_datatable.js'></script>");
                    str.append("<link rel='stylesheet' type='text/css' href='" + APPIDPATH
                            + "/busfw/common/themes/" + systemstyle + "/uistyle.css' />");
                    str.append("<link rel='stylesheet' type='text/css' href='" + APPIDPATH
                            + "/busportal/themes/" + systemstyle + "/portal_default.css' />");
                    str.append("<link rel='stylesheet' type='text/css' href='" + APPIDPATH
                            + "/busportal/themes/" + systemstyle + "/common_style.css' />");
                    str.append("</head>");
                    str.append("<body>");
                    str.append("<script>");
                    str.append("window.onload =");
                    str.append(callBackFunc);
                    str.append(";Ext.lt.ui.loadingClose();");
                    str.append("</script>");
                    str.append("</body>");
                    str.append("</html>");
                }
            }
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
            Globals.putErrorInfo(results, "文件上传失败，失败原因:" + e.getMessage());
            this.getSession().setAttribute(impexpcode, Globals.getResultinfo(Globals.ERRORFLAG, results));
            if(FILE_GUIDS.get()!=null&&"ANA-ERROR".equalsIgnoreCase(e.getCode())){//excel解析报错
                str.append("<html xmlns='http://www.w3.org/1999/xhtml'>");
                str.append("<head>");
                str.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>");
                str.append("<meta http-equiv='X-UA-Compatible' content='IE=Edge,chrome=1'>");
                str.append("</head>"
                        + "<script type='text/javascript' src='/busfw/ltext/frameworksupport.js'></script>"
                        + "<script type='text/javascript' src='/busfw/ltext/ltext_core.js'></script>"
                        + "<script type='text/javascript' src='/busfw/ltext/ltext_template.js'></script>"
                        + "<script type='text/javascript' src='/busfw/common/ui/common.js'></script>");
                str.append("<body>");
                str.append("<script>");
                str.append("window.onload =");
                str.append("function(){");
                str.append("window.parent.showerrordiv('"+FILE_GUIDS.get()+"');");
                str.append("window.history.back();}");
//			str.append("window.parent.Ext.lt.outfile.window.close();}";
                str.append("</script>");
                str.append("</body>");
                str.append("</html>");
            }else{
                str.append("<html xmlns='http://www.w3.org/1999/xhtml'>");
                str.append("<head>");
                str.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>");
                str.append("<meta http-equiv='X-UA-Compatible' content='IE=Edge,chrome=1'>");
                str.append("</head>");
                str.append("<body>");
                str.append("<script>");
                str.append("window.onload =");
                str.append("function(){alert(");
                str.append("'" + e.getMessage() + "'");
                str.append(");window.parent.Ext.lt.outfile.window.close();}");
                str.append("</script>");
                str.append("</body>");
                str.append("</html>");
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            Globals.putErrorInfo(results, "文件上传失败，失败原因:" + e.getMessage());
            this.getSession().setAttribute(impexpcode, Globals.getResultinfo(Globals.ERRORFLAG, results));
            str.append("<html xmlns='http://www.w3.org/1999/xhtml'>");
            str.append("<head>");
            str.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>");
            str.append("<meta http-equiv='X-UA-Compatible' content='IE=Edge,chrome=1'>");
            str.append("</head>");
            str.append("<body>");
            str.append("<script>");
            str.append("window.onload =");
            str.append("function(){alert(");
            str.append("'导入异常:"+e.getMessage()
                    + "，请联系管理员检查导入日志！'");
            str.append(");window.parent.Ext.lt.outfile.window.close();}");
            str.append("</script>");
            str.append("</body>");
            str.append("</html>");
        }
        FILE_GUIDS.remove();
        return str.toString().getBytes();
    }

}
