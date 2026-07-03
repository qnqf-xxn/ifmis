package gov.mof.fasp2.pmkpi.deptperformance.deptperftest;

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
 * <p>湖北-部门整体绩效（试点）</p >
 *
 * @author hw
 * @date 2022/9/8 16:37
 */
public class DeptPerfHbTestService extends PmkpiService {
    private DeptPerfHbTestBO deptPerfHbTestBO;

    public void setDeptPerfHbTestBO(DeptPerfHbTestBO deptPerfHbTestBO) {
        this.deptPerfHbTestBO = deptPerfHbTestBO;
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
        config.put("signs", signs);//计算符号
        return config;
    }

    /**
     * 查询主表目标数据.
     *
     * @param parms -- 参数。
     * @return --
     */
    public Map<String, Object> getMainDatas(HashMap<String, Object> parms) {
        return deptPerfHbTestBO.getMainDatas(parms);
    }

    /**
     * 根据主表记录查询子表指标数据.
     *
     * @param parms -- 参数。
     * @return --
     */
    public Map<String, Object> getSubData(HashMap<String, Object> parms) throws AppException {
        return deptPerfHbTestBO.getSubData(parms);
    }

    /**
     * 根据目标查询对应的指标数据
     *
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> getIndexData(HashMap<String, Object> params) throws AppException {
        return deptPerfHbTestBO.getIndexData(params);
    }

    /**
     * 保存.
     *
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptPerfHbTestBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code", e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
