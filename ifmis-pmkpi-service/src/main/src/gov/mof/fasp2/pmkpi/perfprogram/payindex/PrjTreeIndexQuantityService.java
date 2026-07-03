package gov.mof.fasp2.pmkpi.perfprogram.payindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class PrjTreeIndexQuantityService extends PmkpiService {

    private PrjTreeIndexQuantityBO prjTreeIndexQuantityBO;
    /**
     * 注入bo.
     * @param prjTreeIndexQuantityBO
     * @throws
     */
    public void setPrjTreeIndexQuantityBO(PrjTreeIndexQuantityBO prjTreeIndexQuantityBO) {
        this.prjTreeIndexQuantityBO = prjTreeIndexQuantityBO;
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
        String procode = request.getParameter("pro_code");
        String payid = request.getParameter("payid");
        String viewtype = request.getParameter("viewtype");
        String busguid = request.getParameter("busguid");//审核定义guid
        config.put("procode", procode);
        config.put("payid", payid);
        config.put("viewtype", viewtype);
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("busguid", busguid);
        IDataSetService dss = (IDataSetService) ServiceFactory.getBean("bus.dic.datasetmanagerange.service");
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("signs",signs);//计算符号
        return config;
    }

    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        return prjTreeIndexQuantityBO.getDatas(params);
    }

    public Map<String, Object> save(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = prjTreeIndexQuantityBO.saveData(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }


}
