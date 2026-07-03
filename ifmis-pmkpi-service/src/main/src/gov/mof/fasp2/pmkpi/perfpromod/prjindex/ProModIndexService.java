/**
 * @Title: PrjIndexService.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfpromod.prjindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexService
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:41:56
 */

public class ProModIndexService extends PmkpiService {
    /**
     * proModIndexBO.*/
    private ProModIndexBO proModIndexBO;
    /**
     * 注入bo.
     * @param proModIndexBO -- bo.
     * @throws*/
    public void setProModIndexBO(ProModIndexBO proModIndexBO) {
        this.proModIndexBO = proModIndexBO;
    }

    /**
     * 初始化页面.
     * <p>Title: loadComponent</p>
     * <p>Description: </p>
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config -- 参数.
     * @throws AppException -- 异常.*/

    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String mainguid = request.getParameter("mainguid");
        String proguid = request.getParameter("projguid");
        String type = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency"); //单位
        String prolev = request.getParameter("prolev"); //项目等级
        String pagetype = request.getParameter("pagetype");
        String busguid = request.getParameter("busguid"); //审核定义的guid
        String modtype = request.getParameter("modtype");
        String viewtype = request.getParameter("viewtype");
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE","elementcode='KPIVALNOTAPP'");//添加不适用
        config.put("kpicalnotapply",kpicalnotapply);
        config.put("signs",signs);//计算符号
        config.put("kpivals",kpivals);//定量其他
        config.put("mainguid", mainguid);
        config.put("proguid", proguid);
        config.put("type", type);
        config.put("saveAgency", saveAgency); //单位
        config.put("prolev", prolev); //项目等级123级项目
        config.put("pagetype", pagetype);
        config.put("busguid",busguid);
        config.put("modtype", modtype);
        config.put("viewtype", viewtype);
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("ishebei", PerfUtil.getSystemSet("IS_HBEI"));//河北模式
        return config;
    }
    /**
     * 查询指标集合.
     * @param params -- 参数集合.
     * @return treedatas.
     * @throws AppException --异常.
     * @throws*/

    public Map<String, Object> findIndex(HashMap<String, Object> params) throws AppException {
        Map<String, Object> tabcomps = proModIndexBO.findYearIndexs(params);
        return tabcomps;
    }
   /* *
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws*/

    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = proModIndexBO.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /* *
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws*/

    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            Map<String, Object> goalMap = proModIndexBO.getGoal(params);
            List<Map<String, Object>> indexList = proModIndexBO.getIndex(params);
            rs.put("editinfo", goalMap);
            rs.put("indexdata", indexList);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
