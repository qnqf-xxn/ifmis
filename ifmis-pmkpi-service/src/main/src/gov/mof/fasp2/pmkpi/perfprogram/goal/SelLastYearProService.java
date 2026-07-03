package gov.mof.fasp2.pmkpi.perfprogram.goal;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: SelLastYearProService
 * @Description: 复制上年目标-选择上年项目(选择本项目单位下的填报过上年年度绩效目标项目）保存本项目和上年项目的对应关系
 */

public class SelLastYearProService extends PmkpiService {

    private SelLastYearProBO selLastYearProBO;

    public void setSelLastYearProBO(SelLastYearProBO selLastYearProBO) {
        this.selLastYearProBO = selLastYearProBO;
    }


    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String agency_code = request.getParameter("agency_code");
        String pro_code = request.getParameter("pro_code");
        String type = request.getParameter("type");
        config.put("agency_code", agency_code);
        config.put("pro_code", pro_code);
        config.put("type", type);
        List<Map<String, Object>> selpro = selLastYearProBO.getSelData(config);
        config.put("selpro", selpro);
        return config;
    }

    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = selLastYearProBO.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
