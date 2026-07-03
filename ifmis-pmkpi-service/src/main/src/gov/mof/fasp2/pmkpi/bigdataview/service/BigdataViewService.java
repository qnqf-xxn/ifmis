package gov.mof.fasp2.pmkpi.bigdataview.service;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.bigdataview.bo.BigdataViewBO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BigdataViewService extends PmkpiService {
    private BigdataViewBO bigdataViewBO;

    public void setBigdataViewBO(BigdataViewBO bigdataViewBO) {
        this.bigdataViewBO = bigdataViewBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String pagetype = request.getParameter("pagetype");
        String tablecode = request.getParameter("tablecode");
        String bustype = request.getParameter("bustype");
        String isAgency = request.getParameter("isAgency");
        config.put("isAgency",isAgency);
        config.put("bustype",bustype);
        config.put("pagetype",pagetype);
        config.put("tablecode",tablecode);
        String queryyear = request.getParameter("queryyear");
        String deptcode = request.getParameter("deptcode");
        queryyear = StringUtil.isNullOrEmpty(queryyear)? CommonUtil.getYear():queryyear;
        config.put("queryyear", queryyear);
        config.put("deptcode", deptcode);
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return bigdataViewBO.getTreeData(params);
    }
    
}
