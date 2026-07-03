package gov.mof.fasp2.pmkpi.randomComment.tab;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RandomIndexEditService extends PmkpiService {
    private RandomIndexEditBO randomIndexEditBO;

    public void setRandomIndexEditBO(RandomIndexEditBO randomIndexEditBO) {
        this.randomIndexEditBO = randomIndexEditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String tablecode = request.getParameter("tabcode1");
        String mainguid = request.getParameter("mainguid");
        String projguid = request.getParameter("projguid");
        String procode = request.getParameter("procode");
        String vcol31 = request.getParameter("vcol31");
        String saveAgency = request.getParameter("saveAgency");
        config.put("saveAgency", saveAgency);
        config.put("vcol31", vcol31);
        config.put("mainguid", mainguid);
        config.put("projguid", projguid);
        config.put("tablecode",tablecode);
        config.put("procode",procode);
       //定性指标数据源
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> dxzbsource = dss.getRangesByWhereSql("PMKPISJDXZB1", "");
        config.put("dxzbsource", dxzbsource);
        return config;
    }
    
    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return randomIndexEditBO.getDatas(parms);
    }
    
    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        return randomIndexEditBO.saveIndex(parms);
    }
	
}
