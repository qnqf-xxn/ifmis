package gov.mof.fasp2.pmkpi.adjust.index;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdjustTraIndexService extends PmkpiService {
    private AdjustTraIndexBO adjustTraIndexBO;

    public void setAdjustTraIndexBO(AdjustTraIndexBO adjustTraIndexBO) {
        this.adjustTraIndexBO = adjustTraIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency"); //单位
        String busguid = request.getParameter("busguid");//审核定义guid
        String procode = request.getParameter("procode");
        logger.debug("--------项目编码 procode：-------------" + procode);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("busguid", busguid);
        config.put("procode", procode);
        config.put("indexIsAddrow", PerfUtil.getIndexIsAddRow());
        config.put("signs", signs);
        config.put("mainguid", mainguid);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return adjustTraIndexBO.getDatas(parms);
    }

    /**
     *保存
     * @param parms
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveGoalAndIndex(HashMap<String,Object> parms) throws AppException {
        return adjustTraIndexBO.saveGoalAndIndex(parms);
    }

    /**
     * 清理绩效数据
     * @param parms
     */
    public void updaedata(HashMap<String,Object> parms) throws AppException {
        adjustTraIndexBO.updaedata(parms);
    }
}
