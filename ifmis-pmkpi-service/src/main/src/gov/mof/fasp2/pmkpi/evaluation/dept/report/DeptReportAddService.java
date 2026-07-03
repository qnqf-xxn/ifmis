package gov.mof.fasp2.pmkpi.evaluation.dept.report;

import gov.mof.fasp2.buscommon.bill.bo.CommonBO;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class DeptReportAddService extends PmkpiService{

    private DeptReportAddBO deptReportAddBO;
    public void setDeptReportAddBO(DeptReportAddBO deptReportAddBO) {
        this.deptReportAddBO = deptReportAddBO;
    }
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev"); //项目一二三级
        String mainguid = request.getParameter("mainguid"); //主键
        String proguid = request.getParameter("projguid"); //调整项目guid
        String viewtype = request.getParameter("viewtype"); //页面状态，修改/查看
        String busguid = request.getParameter("busguid"); //审核定义的guid
        String workflow = request.getParameter("workflow"); //审核定义的guid
        String projcode = request.getParameter("projcode");
        String pro_code = request.getParameter("pro_code"); //项目编码
        String bustype = request.getParameter("bustype");
        String year = CommonUtil.getYear();
        config.put("prolev",prolev);
        config.put("mainguid",mainguid);
        config.put("proguid",proguid);
        config.put("viewtype",viewtype);
        config.put("busguid",busguid);
        config.put("workflow",workflow);
        config.put("projcode", projcode);
        config.put("pro_code", pro_code);
        config.put("bustype", bustype);
        config.put("year",year);
        return config;
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = deptReportAddBO.save(config);
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
     * @param parms --
     * @return --
     */
    public Map<String, Object> getData(HashMap<String,Object> parms) throws AppException {
        return deptReportAddBO.getData(parms);
    }

    /**
     * 查询项目编码
     * @param parms --
     * @return --
     */
    public String getProCode(HashMap<String,Object> parms) throws AppException {
        return deptReportAddBO.getProCode(parms);
    }

    /**
     * 查询部门数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getdeptData(HashMap<String,Object> parms) throws AppException {
        return deptReportAddBO.getdeptData(parms);
    }
}
