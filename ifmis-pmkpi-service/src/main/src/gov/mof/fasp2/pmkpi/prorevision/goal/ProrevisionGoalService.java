package gov.mof.fasp2.pmkpi.prorevision.goal;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProrevisionGoalService extends PmkpiService {
    private ProrevisionGoalBO revisionGoalBO;

    public void setRevisionGoalBO(ProrevisionGoalBO revisionGoalBO) {
        this.revisionGoalBO = revisionGoalBO;
    }

    /**
     * 初始化页面.
     * <p>Title: loadComponent</p>
     * <p>Description: </p>
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config -- 参数.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String proguid = request.getParameter("proguid"); //调整项目guid
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency"); //单
        String busguid = request.getParameter("busguid");//审核定义guid
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String isedittotal = request.getParameter("isedittotal");//总体是否可编辑 1不可编辑
        String procode = request.getParameter("procode");//项目编码;//项目编码
        String pro_name = request.getParameter("pro_name");//项目名称
        config.put("pro_name", pro_name);
        config.put("proguid", proguid);
        config.put("procode", procode);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        String mainguid = request.getParameter("mainguid");
        config.put("mainguid", mainguid);
        config.put("busguid", busguid);
        config.put("showtab", showtab);
        HashMap<String,Object> param = new HashMap<String,Object>();
        param.put("proguid",proguid);
        param.put("mainguid",mainguid);
        param.put("showtab",showtab);
        param.put("saveAgency",saveAgency);
        param.put("isedittotal", isedittotal);
        param.put("procode", procode);
        config.put("goaldata", this.getAllGoal(param));
        config.put("isedittotal", isedittotal);
        return config;
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> saveGoal(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = revisionGoalBO.saveGoal(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询项目全部的指标数据.
     * @param parms -- 前端参数.
     * @return -- list.
     */
    public Map<String, Object> getAllGoal(HashMap<String,Object> parms) throws AppException {
        return revisionGoalBO.getAllGoal(parms);
    }

}
