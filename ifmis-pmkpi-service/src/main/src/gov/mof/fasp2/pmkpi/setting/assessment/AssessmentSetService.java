package gov.mof.fasp2.pmkpi.setting.assessment;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AssessmentSetService extends PmkpiService {
    private AssessmentSetBO assessmentSetBO;

    public void setAssessmentSetBO(AssessmentSetBO assessmentSetBO) {
        this.assessmentSetBO = assessmentSetBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return assessmentSetBO.getData(parms);
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            assessmentSetBO.save(params);
            rs.put("success", true);
        } catch (AppException e) {
            rs.put("success", false);
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
