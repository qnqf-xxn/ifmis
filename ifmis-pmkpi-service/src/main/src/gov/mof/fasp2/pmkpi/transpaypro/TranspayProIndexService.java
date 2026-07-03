package gov.mof.fasp2.pmkpi.transpaypro;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class TranspayProIndexService extends PmkpiService {

    private TranspayProIndexBO transpayProIndexBO;

    public void setTranspayProIndexBO(TranspayProIndexBO transpayProIndexBO) {
        this.transpayProIndexBO = transpayProIndexBO;
    }


    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String tokenid = request.getParameter("tokenid");// 登录凭证
        String tabcode = request.getParameter("tabcode");
        String viewtype = request.getParameter("viewtype");
        config.put("tokenid", tokenid);
        config.put("tabcode", tabcode);
        config.put("viewtype", viewtype);
        config.put("currentyear", SecureUtil.getUserSelectYear());
        config.put("currentprovince", SecureUtil.getUserSelectProvince());
        IDataSetService dss = (IDataSetService) ServiceFactory.getBean("bus.dic.datasetmanagerange.service");
        List<DicRangeDTO> finintorgds = dss.getRangesByDsGuid("099003");
        config.put("finintorgds", finintorgds);
        List<DicRangeDTO> deptcodeds = dss.getRangesByElementcode("PMKPIDEPT");
        config.put("deptcodeds", deptcodeds);
        return super.loadComponent(request, response, config);
    }

    /**
     * 以区划，年度，guid为主键的增删改
     * @param params
     * @return
     */
    public Map<String, Object> savemajorkey(Map<String, Object> params){
        Map<String, Object> remp = new HashMap<String, Object>();
        try{
            remp = transpayProIndexBO.savemajorkey(params);
        } catch (PerfAppException e){
            remp = e.getRemap();
            remp.put("code", e.getCode());
        } catch(AppException e){
            logger.error(e.getMessage(), e);
        }
        return remp;
    }

    /**
     * 查询数据.
     * @param params
     * @return
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params){
        return transpayProIndexBO.getDatas(params);
    }

}
