package gov.mof.fasp2.pmkpi.perfprotrace.warn;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class TraceWarnService extends PmkpiService {
    private TraceWarnBO traceWarnBO;

    public void setTraceWarnBO(TraceWarnBO traceWarnBO) {
        this.traceWarnBO = traceWarnBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String bustype = request.getParameter("bustype");
        String mainguid = request.getParameter("mainguid");
        String proguid = request.getParameter("projguid");
        String taskguid = request.getParameter("taskguid");
        String busguid = request.getParameter("busguid");
        String saveAgency = request.getParameter("saveAgency");
        String viewtype = request.getParameter("viewtype");
        String procode = request.getParameter("procode");
        String protype = request.getParameter("protype");//项目类型，一般、重点
        config.put("bustype", bustype);
        config.put("mainguid", mainguid);
        config.put("proguid", proguid);
        config.put("taskguid", taskguid);
        config.put("busguid", busguid);
        config.put("saveAgency", saveAgency);
        config.put("viewtype", viewtype);
        config.put("procode", procode);
        config.put("protype", protype);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return traceWarnBO.getDatas(parms);
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = traceWarnBO.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 暂存
     * @param params
     * @return
     */
    public Map<String, Object> midsave(HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            PerfMidsaveBO perfMidsaveBO = (PerfMidsaveBO) ServiceFactory.getBean("pmkpi.perfmidsave.PerfMidsaveBO");
            rs =  perfMidsaveBO.saveData2(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 清除暂存
     * @param params
     * @return
     */
    public Map<String, Object> midsavedel(HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        PerfMidsaveBO perfMidsaveBO = (PerfMidsaveBO) ServiceFactory.getBean("pmkpi.perfmidsave.PerfMidsaveBO");
        try {
            rs = perfMidsaveBO.delTabData2(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public String getWarn(HashMap<String, Object> params) {
        return traceWarnBO.getWarn(params);
    }
}
