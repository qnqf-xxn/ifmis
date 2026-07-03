package gov.mof.fasp2.pmkpi.perfprogram.approvalquery.goal;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


public class ApprovalGoalService extends PmkpiService {
    /**
     * ApprovalGoalBO.
     */
    private ApprovalGoalBO approvalGoalBO;

    /**
     * 注入bo.
     *
     * @param approvalGoalBO -- bo.
     * @throws
     */
    public void setApprovalGoalBO(ApprovalGoalBO approvalGoalBO) {
        this.approvalGoalBO = approvalGoalBO;
    }

    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String proguid = request.getParameter("mainguid") == null ? request.getParameter("projId") : request.getParameter("mainguid");
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency"); //单
        String pdmsave = request.getParameter("pdmsave"); //单位
        String prolev = request.getParameter("prolev") == null ? request.getParameter("projtype") : request.getParameter("prolev");
        String busguid = request.getParameter("busguid");//审核定义guid
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String isedittotal = request.getParameter("isedittotal");//总体是否可编辑 1不可编辑
        String tempcode = request.getParameter("tempcode");
        String procode = request.getParameter("pro_code");
        if (StringUtil.isEmpty(procode)) {
            procode = request.getParameter("procode"); //年中追加绩效目标填报发生调整的项目，无调整后guid
        }
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("prolev", prolev); //项目等级123级项目
        config.put("busguid", busguid);
        config.put("showtab", showtab);
        config.put("tempcode", tempcode);
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("proguid", proguid);
        param.put("showtab", showtab);
        param.put("pdmsave", pdmsave);
        param.put("tempcode", tempcode);
        param.put("saveAgency", saveAgency);
        param.put("isedittotal", isedittotal);
        param.put("procode", procode);
        config.put("proguid", proguid);
        config.put("goaldata", this.getAllGoal(param));
        config.put("isedittotal", isedittotal);
        config.put("procode", procode);
        return config;
    }

    /**
     * 查询项目全部的指标数据.
     *
     * @param parms -- 前端参数.
     * @return -- list.
     */
    public Map<String, Object> getAllGoal(HashMap<String, Object> parms) throws AppException {
        return approvalGoalBO.getAllGoal(parms);
    }
}

