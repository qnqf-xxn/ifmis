package gov.mof.fasp2.pmkpi.perfself.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageBO;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfRandomBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfRandomCheckService extends PmkpiService {
    private PerfSelfRandomBO perfSelfRandomBO;

    public void setPerfSelfRandomBO(PerfSelfRandomBO perfSelfRandomBO) {
        this.perfSelfRandomBO = perfSelfRandomBO;
    }
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menuId = request.getParameter("menuId");
        String dept_code = request.getParameter("dept_code");
        String viewtype = request.getParameter("viewtype");
        config.put("menuId", menuId);
        config.put("dept_code", dept_code);
        config.put("viewtype", viewtype);
        return config;
    }
    public Map addrandom(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfSelfRandomBO.addrandom(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public Map delrandom(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfSelfRandomBO.delrandom(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public List<Map<String, Object>> getTreeData(HashMap params) throws AppException {
        return perfSelfRandomBO.getTreeData(params);
    }

}
