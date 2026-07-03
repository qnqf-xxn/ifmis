package gov.mof.fasp2.pmkpi.deptracetask.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptracetask.bo.DeptraceTaskBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptraceTaskService extends PmkpiService {
    private DeptraceTaskBO deptraceTaskBO;

    public void setDeptraceTaskBO(DeptraceTaskBO deptraceTaskBO) {
        this.deptraceTaskBO = deptraceTaskBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String pagetype = request.getParameter("pagetype");
        String workflow = request.getParameter("workflow");
        if (pagetype != null && pagetype.equals("editreport")){//编辑
            String uikey = (String) config.get("pageurl");
            String mainguid = request.getParameter("mainguid");
            String agency = request.getParameter("agency");
            String flg = request.getParameter("flg");
        	config.put("mainguid", mainguid);
        	config.put("agency", agency);
            config.put("uikey", uikey);
            config.put("flg", flg);
            config.put("tabData", deptraceTaskBO.getTabData(uikey));
        }
        config.put("workflow",workflow);
        return config;
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
	public Map infosave(HashMap config) throws AppException{
		return deptraceTaskBO.infosave(config);
	}

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
	public Map<String, Object> tablesave(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        try {
            deptraceTaskBO.tablesave(params);
            backMap.put("flg", "1");
        } catch (AppException e){
            throw new AppException("保存失败");
        }
        return backMap;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
	public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptraceTaskBO.getData(parms);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
	    return deptraceTaskBO.del(parms);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            deptraceTaskBO.wfAudit(params);
            backmap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

    /**
     * 生成guid
     * @return
     */
    public String getCreateguid() throws AppException {
        return deptraceTaskBO.getCreateguid();
    }

    /**
     * 编辑区查询
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        return deptraceTaskBO.editquery(params);
    }
}
