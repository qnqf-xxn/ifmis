package gov.mof.fasp2.pmkpi.adjust.goal;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class AdjustGoalListService extends PmkpiService {
    private AdjustGoalBO adjustGoalBO;

    public void setAdjustGoalBO(AdjustGoalBO adjustGoalBO) {
        this.adjustGoalBO = adjustGoalBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String proguid = request.getParameter("proguid"); //调整项目guid
        String busguid = request.getParameter("busguid"); //审核定义
        String prolev = request.getParameter("prolev"); //项目级次
        String bustype = request.getParameter("bustype"); //业务类型
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency");
        String procode = request.getParameter("procode");//项目编码
        String mainguid = request.getParameter("mainguid");
        String pro_name = request.getParameter("pro_name");
        config.put("mainguid",mainguid);
        config.put("proguid",proguid);
        config.put("busguid",busguid);
        config.put("prolev",prolev);
        config.put("bustype",bustype);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency);
        config.put("procode", procode);
        config.put("pro_name", pro_name);
        return config;
    }



    /**
     * 目标列表.
     * @param parms -- 参数。
     * @return --
     */
    public Map<String, Object> getGoalList(HashMap<String,Object> parms) throws AppException {
        return adjustGoalBO.getGoalList(parms);
    }

    /**
     * 查询目标.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveGoalList(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = adjustGoalBO.saveGoalList(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
            logger.error(e.getMessage(), e);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
