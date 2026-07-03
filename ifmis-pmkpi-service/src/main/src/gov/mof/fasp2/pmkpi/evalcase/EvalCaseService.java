package gov.mof.fasp2.pmkpi.evalcase;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class EvalCaseService extends PmkpiService {
    private EvalCaseBO evalCaseBO;
    
    public void setEvalCaseBO(EvalCaseBO evalCaseBO) {
        this.evalCaseBO = evalCaseBO;
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
        String mainguid = request.getParameter("mainguid");
        String saveAgency = request.getParameter("saveAgency");
        String viewtype = request.getParameter("viewtype");
        String busguid = request.getParameter("busguid");
        config.put("mainguid",mainguid);
        config.put("saveAgency",saveAgency);
        config.put("viewtype",viewtype);
        config.put("busguid",busguid);
        String querytype = request.getParameter("querytype");
        config.put("querytype",querytype);
        return config;
    }
    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
	    return evalCaseBO.del(parms);
    }
    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = evalCaseBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> getFundDatas(HashMap<String,Object> params) throws AppException {
        return evalCaseBO.getFundDatas(params);
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     */
    public Map<String, Object> saveFundDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = evalCaseBO.saveFundDatas(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
