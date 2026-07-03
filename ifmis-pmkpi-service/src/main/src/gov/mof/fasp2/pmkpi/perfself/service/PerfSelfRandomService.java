package gov.mof.fasp2.pmkpi.perfself.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfRandomBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class PerfSelfRandomService extends PmkpiService {
    private PerfSelfRandomBO perfSelfRandomBO;

    public void setPerfSelfRandomBO(PerfSelfRandomBO perfSelfRandomBO) {
        this.perfSelfRandomBO = perfSelfRandomBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("sys_random", PerfUtil.getSystemSet("perfselfrandom"));
        return config;
    }

    public Map selfRandom(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfSelfRandomBO.selfRandom(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public Map selfsue(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfSelfRandomBO.selfsue(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    public Map selfsueoff(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfSelfRandomBO.selfsueoff(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }



}
