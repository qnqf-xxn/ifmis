package gov.mof.fasp2.pmkpi.deptTJformance.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptTJPerfEditService extends PmkpiService {

    /**
     * 注入bo.
     */
    private DeptTJPerfBO deptTJPerfBO;
    /**
     * bo.
     * @param deptTJPerfBO -- bo.
     * @throws
     */
    public void setDeptTJPerfBO(DeptTJPerfBO deptTJPerfBO) {
        this.deptTJPerfBO = deptTJPerfBO;
    }
    
    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String saveAgency = request.getParameter("saveAgency"); //单位处室
        String mainguid = request.getParameter("mainguid"); //主键
        String busguid = request.getParameter("busguid");
        config.put("workflow",workflow);
        config.put("saveAgency",saveAgency);
        config.put("mainguid",mainguid);
        String viewtype = request.getParameter("viewtype");
        config.put("busguid", busguid);
        config.put("viewtype",viewtype);
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("signs",signs);//计算符号
        String currenttab = request.getParameter("currenttab");
        config.put("savecurrenttab",currenttab);
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
            backMap = deptTJPerfBO.getData(parms);
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
    public Map saveAll(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptTJPerfBO.saveAll(config);
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
