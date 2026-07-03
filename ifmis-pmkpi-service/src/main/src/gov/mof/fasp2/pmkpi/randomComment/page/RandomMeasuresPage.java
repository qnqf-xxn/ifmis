package gov.mof.fasp2.pmkpi.randomComment.page;

import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public class RandomMeasuresPage extends PmkpiPage {

    
    /**  
     * @Title: index  
     * @Description: TODO(新增绩效指标)  
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception   
     */ 
    public Map measuresAdd(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String sindex = request.getParameter("sindex");
        String findex = request.getParameter("findex");
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("signs",signs);//计算符号
        config.put("findex",findex);
        config.put("sindex",sindex);
        return config;
    }
    
    
    /**  
     * @Title: index  
     * @Description: TODO(选择绩效指标)  
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception   
     */ 
    public Map chooseMeasuresAdd(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
