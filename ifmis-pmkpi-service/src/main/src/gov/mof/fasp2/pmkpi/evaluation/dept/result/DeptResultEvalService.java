package gov.mof.fasp2.pmkpi.evaluation.dept.result;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptResultEvalService extends PmkpiService {
    private DeptResultBO deptResultBO;

    public void setDeptResultBO(DeptResultBO deptResultBO) {
        this.deptResultBO = deptResultBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String bustype = request.getParameter("bustype");
        config.put("mainguid", mainguid);
        config.put("bustype", bustype);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getData(HashMap<String,Object> parms) throws AppException {
        return deptResultBO.getData(parms);
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptResultBO.save(config);
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
