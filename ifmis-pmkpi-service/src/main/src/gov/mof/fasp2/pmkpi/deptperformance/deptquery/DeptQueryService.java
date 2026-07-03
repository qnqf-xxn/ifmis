package gov.mof.fasp2.pmkpi.deptperformance.deptquery;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptQueryService extends PmkpiService {
    private DeptQueryBO deptQueryBO;

    public void setDeptQueryBO(DeptQueryBO deptQueryBO) {
        this.deptQueryBO = deptQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        return config;
    }

    /**
     * 保存
     * @param params --
     * @return
     * @throws AppException
     */
	public Map save(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptQueryBO.save(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
	}

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return deptQueryBO.del(parms);
    }

}
