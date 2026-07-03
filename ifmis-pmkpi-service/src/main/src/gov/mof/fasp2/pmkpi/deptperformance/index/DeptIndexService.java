package gov.mof.fasp2.pmkpi.deptperformance.index;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.tabfream.TabfreamBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2020/8/24  chongdayong
 */
public class DeptIndexService extends PmkpiService {
    private DeptIndexBO deptIndexBO;

    public void setDeptIndexBO(DeptIndexBO deptIndexBO) {
        this.deptIndexBO = deptIndexBO;
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
        config.put("mainguid", mainguid);
        config.put("saveAgency", saveAgency);
        config.put("viewtype", viewtype);
        config.put("sindex", sindex);
        config.put("busguid", busguid);
        config.put("ismergeindex", ismergeindex);
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE","elementcode='KPIVALNOTAPP'");//添加不适用
        config.put("signs",signs);//计算符号
        config.put("kpivals", kpivals);
        config.put("kpicalnotapply",kpicalnotapply);
        config.put("isnewapply", deptIndexBO.isNewApply());
        config.put("is_JiangXi", PerfUtil.get_IsJiangXi());
        List<DicRangeDTO> ind = dss.getRangesByWhereSql("PMKPIFRAME", "");
        config.put("indmap",ind);//指标层次分类
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptIndexBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptIndexBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    
    /**
     * 选择指标查询.
     * @param parms --
     * @return --
     */
	public Map<String, Object> indexcheck(HashMap<String,Object> parms) {
        return deptIndexBO.indexcheck(parms);
    }

    /**
     * 获取上年绩效目标/指标复制.
     * @param parms -- 参数
     * @return --
     */
    public Map<String, Object> copyPerf(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        try {
            TabfreamBO tabfreamBO = (TabfreamBO) ServiceFactory.getBean("pmkpi.tabfream.TabfreamBOTX");
            backMap = tabfreamBO.copyPerf(parms);
            backMap.put("success", true);
        } catch (AppException e) {
            backMap.put("success", false);
            backMap.put("error", e.getMessage());
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
}
