package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 参考历年指标
 */
public class CalendarIndexService extends PmkpiService {
    private CalendarIndexBO calendarIndexBO;

    public void setCalendarIndexBO(CalendarIndexBO calendarIndexBO) {
        this.calendarIndexBO = calendarIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        Integer year = SecureUtil.getUserSelectYear();
        int j = 3;
        Integer[] years = new Integer[j];
        for (int i = 1; i <= j; i++) {
            years[j - i] = year - i;
        }
        config.put("years", years);
        config.put("proguid", request.getParameter("proguid"));
        config.put("procode", request.getParameter("procode"));
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("signs",signs);//计算符号
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public List<Map<String, Object>> getDatas(HashMap<String,Object> parms) throws AppException {
        return calendarIndexBO.getData(parms);
    }
}
