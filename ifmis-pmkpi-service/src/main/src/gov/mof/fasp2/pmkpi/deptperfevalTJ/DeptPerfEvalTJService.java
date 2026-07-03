package gov.mof.fasp2.pmkpi.deptperfevalTJ;

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


public class DeptPerfEvalTJService extends PmkpiService {

    private DeptPerfEvalTJBO deptPerfEvalTJBO;

    public void setDeptPerfEvalTJBO(DeptPerfEvalTJBO deptPerfEvalTJBO) {
        this.deptPerfEvalTJBO = deptPerfEvalTJBO;
    }


    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String workflow = request.getParameter("workflow");
        String type = request.getParameter("type");
        config.put("workflow", workflow);
        config.put("type", type);
        IDataSetService dss = (IDataSetService) ServiceFactory.getBean("bus.dic.datasetmanagerange.service");
        List<DicRangeDTO> evalTypes = dss.getRangesByElementcode("PMKPIEVALTYPETJ");
        config.put("eval_types", evalTypes);
        return super.loadComponent(request, response, config);
    }

    /**
     * 以区划，年度，guid为主键的增删改
     * @param params
     * @return
     */
    public Map<String, Object> save(Map<String, Object> params){
        Map<String, Object> remp = new HashMap<String, Object>();
        try{
            remp = deptPerfEvalTJBO.save(params);
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
        return deptPerfEvalTJBO.getDatas(params);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptPerfEvalTJBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
