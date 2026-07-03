package gov.mof.fasp2.pmkpi.deptZJformanceadjust.report;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

public class DeptPerfEdit extends PmkpiService {

    /**
     * 注入bo.
     */
    private DeptPerfBO deptPerfBO;
    /**
     * bo.
     * @param deptPerfBO -- bo.
     * @throws
     */
    public void setDeptPerfBO(DeptPerfBO deptPerfBO) {
        this.deptPerfBO = deptPerfBO;
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String saveAgency = request.getParameter("saveAgency"); //单位处室
        String mainguid = request.getParameter("mainguid"); //主键
        String projguid = request.getParameter("projguid"); //项目
        config.put("workflow",workflow);
        config.put("saveAgency",saveAgency);
        config.put("mainguid",mainguid);
        config.put("projguid",projguid);
        String viewtype = request.getParameter("viewtype");
        config.put("viewtype",viewtype);
        String uikey = (String) config.get("pageurl"); //获取配置了多少页签.
        config.put("tabData", deptPerfBO.getTabData(uikey));
        IDataSetService dss = (IDataSetService) ServiceFactory.getBean("bus.dic.datasetmanagerange.service");
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("signs",signs);//计算符号
        List<DicRangeDTO> ind = dss.getRangesByWhereSql("PMKPIFRAME", "");
        config.put("indmap",ind);//指标层次分类
        List<DicRangeDTO> indimport = dss.getRangesByWhereSql("INDEXIMPORT", "");
        config.put("indimport",indimport);//指标重要性
        List<DicRangeDTO> funcresp = dss.getRangesByWhereSql("PDMFUNCRESP", "");
        config.put("funcresp",funcresp);//部门职责
        return config;
    }
    
    /**
     * 编辑区表格查询数据.
     * @param parms -- 参数
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        try {
            backMap = deptPerfBO.getData(parms);
            backMap.put("flg", "1");
            backMap.put("msg", "查询成功");
        } catch (AppException e) {
            backMap.put("flg", "0");
            backMap.put("msg", e.getMessageNoCode().replaceAll("-null", "查询失败"));
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
    
    /**
     * 编辑区查询
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<>();
        try {
            backMap = deptPerfBO.editquery(params);
            backMap.put("flg", "1");
            backMap.put("msg", "查询成功");
        } catch (AppException e) {
            backMap.put("flg", "0");
            backMap.put("msg", e.getMessageNoCode().replaceAll("-null", "查询失败"));
            logger.error(e.getMessage(), e);
        }
        return backMap;
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
            rs = deptPerfBO.infosave(config);
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
            rs = deptPerfBO.tablesave(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
