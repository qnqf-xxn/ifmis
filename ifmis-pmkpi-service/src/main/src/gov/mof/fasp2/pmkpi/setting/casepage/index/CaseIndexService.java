package gov.mof.fasp2.pmkpi.setting.casepage.index;

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

public class CaseIndexService extends PmkpiService {
    private CaseIndexBO caseIndexBO;

    public void setCaseIndexBO(CaseIndexBO caseIndexBO) {
        this.caseIndexBO = caseIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String saveAgency = request.getParameter("saveAgency");
        String viewtype = request.getParameter("viewtype");
        String busguid = request.getParameter("busguid");
        String ismergeindex = PerfUtil.getSystemSet("ismergeindex");//指标值是否合并 1是 2否 默认不合并
        String bustype = request.getParameter("bustype"); //业务类型
        String mainguid = request.getParameter("mainguid");
        String finintorgguid = request.getParameter("finintorgguid");
        config.put("mainguid", mainguid);
        config.put("saveAgency", saveAgency);
        config.put("viewtype", viewtype);
        config.put("busguid", busguid);
        config.put("ismergeindex", ismergeindex);
        config.put("finintorgguid", finintorgguid);
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> datatype = dss.getRangesByWhereSql("PERFDATATYPE", "");
        List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALNOTAPP'");//添加不适用
        config.put("kpicalnotapply", kpicalnotapply);
        config.put("signs", signs);//计算符号
        config.put("kpivals", kpivals);//定量其他
        config.put("datatype", datatype);//数据类型
        config.put("bustype", bustype);
        config.put("isGx", PerfUtil.getIsGuangXi());//广西模式
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return caseIndexBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = caseIndexBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
