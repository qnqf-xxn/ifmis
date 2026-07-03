package gov.mof.fasp2.pmkpi.adjust.index;

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

public class AdjustIndexService extends PmkpiService {
    private AdjustIndexBO adjustIndexBO;

    public void setAdjustIndexBO(AdjustIndexBO adjustIndexBO) {
        this.adjustIndexBO = adjustIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String saveAgency = request.getParameter("saveAgency");
        String viewtype = request.getParameter("viewtype");
        String busguid = request.getParameter("busguid");
        String prolev = request.getParameter("prolev");
        String proguid = request.getParameter("proguid"); //调整项目guid
        String ismergeindex = PerfUtil.getSystemSet("ismergeindex");//指标值是否合并 1是 2否 默认不合并
        String bustype = request.getParameter("bustype"); //业务类型
        String procode = request.getParameter("procode");
        String mainguid = request.getParameter("mainguid");
        String pro_name = request.getParameter("pro_name");
        String isnewPage = request.getParameter("isnewPage");
        config.put("proguid",proguid);
        config.put("mainguid", mainguid);
        config.put("saveAgency", saveAgency);
        config.put("viewtype", viewtype);
        config.put("busguid", busguid);
        config.put("ismergeindex", ismergeindex);
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> datatype = dss.getRangesByWhereSql("PMKPIDATATYPE", "");
        List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE","elementcode='KPIVALNOTAPP'");//添加不适用
        List<DicRangeDTO> pmkpidatatype = dss.getRangesByWhereSql("PMKPIDATATYPE",null);//添加不适用
        config.put("kpicalnotapply",kpicalnotapply);
        config.put("signs",signs);//计算符号
        config.put("kpivals",kpivals);//定量其他
        config.put("datatype",datatype);//数据类型
        config.put("bustype", bustype);
        config.put("prolev", prolev);
        config.put("isZJ", PerfUtil.getSystemSet("isZJ"));
        config.put("procode", procode);
        config.put("pmkpidatatype", pmkpidatatype);
        config.put("ishebei", PerfUtil.getSystemSet("IS_HBEI"));//河北模式
        config.put("isTianjin", PerfUtil.getIsTianJin());//天津模式
        config.put("isGx", PerfUtil.getIsGuangXi());//广西模式
        config.put("pro_name", pro_name);
        config.put("isnewPage", isnewPage);
        config.put("indsource", PerfUtil.getSourceData("PERFINDSOURCE", ""));
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return adjustIndexBO.getData(parms);
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = adjustIndexBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
