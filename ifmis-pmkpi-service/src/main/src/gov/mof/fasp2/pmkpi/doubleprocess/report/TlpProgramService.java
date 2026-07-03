package gov.mof.fasp2.pmkpi.doubleprocess.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class TlpProgramService extends PmkpiService {
    private TlpDoublepressBO tlpProgramBO;
    
    public void setTlpProgramBO(TlpDoublepressBO tlpProgramBO) {
        this.tlpProgramBO = tlpProgramBO;
    }

    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String prolev = request.getParameter("prolev"); //项目一二三级项目
        config.put("workflow",workflow);
        config.put("prolev",prolev);
        String elementcode = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev); //来源elementcode
        String columncode = PerfUtil.getSystemSet("tlprogram_lefttree_col_" + prolev);  //表字段
        config.put("elementcode", elementcode);
        config.put("columncode", columncode);
        return config;
    }
    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
	    return tlpProgramBO.del(parms);
    }
    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = tlpProgramBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 获取预算单位的审批流程.
     * @param parms -- 选中项目数据.
     * @return
     */
    public Map<String, Object> getBdmWfstatus(HashMap<String,Object> parms){
        return tlpProgramBO.getPmWfstatus(parms);
    }
}
