package gov.mof.fasp2.pmkpi.evaluate.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluate.bo.PreEvaluateProGoalBo;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class PreEvaluateProGoalService extends PmkpiService {

    private PreEvaluateProGoalBo preEvaluateProGoalBo;

    public void setPreEvaluateProGoalBo(PreEvaluateProGoalBo preEvaluateProGoalBo) {
        this.preEvaluateProGoalBo = preEvaluateProGoalBo;
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
        String proguid = request.getParameter("mainguid")== null ? request.getParameter("projId") : request.getParameter("mainguid");
        String procode = request.getParameter("procode");
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency"); //单位
        String prolev = request.getParameter("prolev"); //项目等级
        String isprogramiframe = request.getParameter("isprogramiframe");//是否项目库嵌套
        String busguid = request.getParameter("busguid");//审核定义guid
        config.put("proguid", proguid);
        config.put("procode", procode);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("prolev", prolev); //项目等级123级项目
        if (StringUtils.isEmpty(isprogramiframe)) {
            config.put("iframeurl", PerfUtil.getSystemSet("porgramurl_index"));
        }
        String isshowindex = PerfUtil.getSystemSet("tlprogramindex_edit") == null ? "1" : PerfUtil.getSystemSet("tlprogramindex_edit");
        config.put("editinfo", preEvaluateProGoalBo.getGoalByGuid(proguid));
        config.put("isshowindex", isshowindex);
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("busguid", busguid);
        return config;
    }

    /**
     * 查询指标集合.
     * @param params -- 参数集合.
     * @return treedatas.
     * @throws AppException --异常.
     * @throws
     */
    public Map<String, Object> findIndex(HashMap<String, Object> params) throws AppException {
        Map<String, Object> tabcomps = preEvaluateProGoalBo.findYearIndexs(params);
        return tabcomps;
    }
    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> savePrjIndex(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = preEvaluateProGoalBo.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
