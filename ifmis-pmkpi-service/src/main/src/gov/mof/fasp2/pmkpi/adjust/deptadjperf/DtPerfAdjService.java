package gov.mof.fasp2.pmkpi.adjust.deptadjperf;

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
 * @Description:
 * @Revision History:
 * @Revision 20:18 2022/08/2 gaoming
 */
public class DtPerfAdjService extends PmkpiService {

    private DtPerfAdjBO dtPerfAdjBO;
    public void setDtPerfAdjBO(DtPerfAdjBO dtPerfAdjBO) {
        this.dtPerfAdjBO = dtPerfAdjBO;
    }


    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String saveAgency = request.getParameter("saveAgency");
        String viewtype = request.getParameter("viewtype");
        String sindex = request.getParameter("sindex");
        String busguid = request.getParameter("busguid");
        String proguid = request.getParameter("proguid"); //调整部门整体申报的guid
        String ismergeindex = PerfUtil.getSystemSet("ismergeindex");//指标值是否合并 1是 2否 默认不合并
        config.put("mainguid", mainguid);
        config.put("proguid",proguid);
        config.put("saveAgency", saveAgency);
        config.put("viewtype", viewtype);
        config.put("sindex", sindex);
        config.put("busguid", busguid);
        config.put("ismergeindex", ismergeindex);
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> datatype = dss.getRangesByWhereSql("PMKPIDATATYPE", "");
        config.put("signs",signs);//计算符号
        config.put("datatype",datatype);//数据类型
        return config;
    }

    /**
     * 查询主表目标数据.
     * @param parms -- 参数。
     * @return --
     */
    public Map<String, Object> getMainDatas(HashMap<String,Object> parms) throws AppException {
        return dtPerfAdjBO.getMainDatas(parms);
    }

    /**
     * 根据主表记录查询子表指标数据.
     * @param parms -- 参数。
     * @return --
     */
    public Map<String, Object> getSubData(HashMap<String,Object> parms) throws AppException {
        return dtPerfAdjBO.getSubData(parms);
    }

    /**
     * 根据目标查询对应的指标数据
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String,Object> getIndexData(HashMap<String,Object> params) throws AppException{
        return dtPerfAdjBO.getIndexData(params);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = dtPerfAdjBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
