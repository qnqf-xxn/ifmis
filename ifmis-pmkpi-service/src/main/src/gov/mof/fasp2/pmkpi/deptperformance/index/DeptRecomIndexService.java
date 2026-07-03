package gov.mof.fasp2.pmkpi.deptperformance.index;

import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;


public class DeptRecomIndexService extends PmkpiService {
    private DeptRecomIndexBO deptRecomIndexBO;

    public void setDeptRecomIndexBO(DeptRecomIndexBO deptRecomIndexBO) {
        this.deptRecomIndexBO = deptRecomIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String saveAgency = request.getParameter("saveAgency");
        String viewtype = request.getParameter("viewtype");
        String sindex = request.getParameter("sindex");
        String busguid = request.getParameter("busguid");
        String ismergeindex = PerfUtil.getSystemSet("ismergeindex");//指标值是否合并 1是 2否 默认不合并
        String isadjust = request.getParameter("isadjust");//是否调整
        String tableid = request.getParameter("tableid");//是否调整
        config.put("mainguid", mainguid);
        config.put("saveAgency", saveAgency);
        config.put("viewtype", viewtype);
        config.put("sindex", sindex);
        config.put("busguid", busguid);
        config.put("ismergeindex", ismergeindex);
        config.put("isadjust", isadjust);
        config.put("tableid", tableid);
        config.put("isZJ", PerfUtil.getSystemSet("isZJ"));
        config.put("isSX", PerfUtil.getSystemSet("isSX"));
        config.put("isHuBei", PerfUtil.getSystemSet("IS_HUBEI"));
        config.put("isHebei", PerfUtil.getSystemSet("IS_HBEI"));
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE","elementcode='KPIVALNOTAPP'");//添加不适用
        config.put("signs",signs);//计算符号
        config.put("kpivals", kpivals);
        config.put("kpicalnotapply",kpicalnotapply);
        return config;
    }

}
