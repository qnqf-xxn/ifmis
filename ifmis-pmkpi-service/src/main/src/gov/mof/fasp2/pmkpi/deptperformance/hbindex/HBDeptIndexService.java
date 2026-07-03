package gov.mof.fasp2.pmkpi.deptperformance.hbindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HBDeptIndexService extends PmkpiService {
    private HBDeptIndexBO hbDeptIndexBO;

    public void setHbDeptIndexBO(HBDeptIndexBO hbDeptIndexBO) {
        this.hbDeptIndexBO = hbDeptIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("yearflag", request.getParameter("yearflag"));
        config.put("mainguid", request.getParameter("mainguid"));
        config.put("saveAgency", request.getParameter("saveAgency"));
        config.put("viewtype", request.getParameter("viewtype"));
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> perfendvaltype = dss.getRangesByWhereSql("PERFENDVALTYPE", "");
        List<DicRangeDTO> indexstandards = dss.getRangesByWhereSql("INDEXSTANDARDS", "");
        config.put("signs",signs);//计算符号
        config.put("perfendvaltype", perfendvaltype);
        config.put("indexstandards", indexstandards);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return hbDeptIndexBO.getDatas(parms);
    }

    /**
     * 查询长期绩效指标.
     * @param parms --
     * @return --
     */
    public List<Map<String, Object>> getIndexs(HashMap<String,Object> parms) throws AppException {
        return hbDeptIndexBO.getIndexs(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = hbDeptIndexBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
