package gov.mof.fasp2.pmkpi.deptperformance.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.deptperformance.bo.DeptPerformanceBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.Map;

public class DeptPerformanceService extends PmkpiService {
    private DeptPerformanceBO deptPerformanceBO;

    public void setDeptPerformanceBO(DeptPerformanceBO deptPerformanceBO) {
        this.deptPerformanceBO = deptPerformanceBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String pagetype = request.getParameter("pagetype");
        String workflow = request.getParameter("workflow");
        String name = request.getParameter("name");
        String checksuperid = request.getParameter("checksuperid");
        if(name!=null){
        	name= URLDecoder.decode(name,"UTF-8");
        	name= URLDecoder.decode(name,"UTF-8");
        }
        if (pagetype != null && pagetype.equals("editreport")){//编辑
            String uikey = (String) config.get("pageurl");
            String mainguid = request.getParameter("mainguid");
            String agency = request.getParameter("agency");
            String flg = request.getParameter("flg");
        	config.put("mainguid", mainguid);
        	config.put("agency", agency);
            config.put("uikey", uikey);
            config.put("flg", flg);
            config.put("tabData", deptPerformanceBO.getTabData(uikey));
            config.put("issaveall", PerfUtil.getSystemSet("issaveall"));
        }
        config.put("agencyflag", PerfUtil.getSystemSet("dept_letftree"));
        config.put("workflow",workflow);
        config.put("name",name);
        config.put("checksuperid",checksuperid);
        return config;
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
	public Map infosave(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptPerformanceBO.infosave(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
	}

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
	public Map<String, Object> tablesave(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptPerformanceBO.tablesave(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
	public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return deptPerformanceBO.getData(parms);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
	    return deptPerformanceBO.del(parms);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptPerformanceBO.wfAudit(params);
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
     * 编辑区查询
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        return deptPerformanceBO.editquery(params);
    }

    /**
     * 保存全部组件数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveall(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptPerformanceBO.saveall(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    
    /**
     * 选择指标查询.
     * @param parms --
     * @return --
     */
	public Map<String, Object> indexcheck(HashMap<String,Object> parms) throws AppException {
        return deptPerformanceBO.indexcheck(parms);
    }
}
