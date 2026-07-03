package gov.mof.fasp2.pmkpi.probleamtask;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.ca.user.dto.UserDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


public class ProblemTaskService extends PmkpiService {

    private ProblemTaskBO problemTaskBO;

    public void setProblemTaskBO(ProblemTaskBO problemTaskBO) {
        this.problemTaskBO = problemTaskBO;
    }


    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String workflow = request.getParameter("workflow");
        String pagetype = request.getParameter("pagetype");
        String viewtype = request.getParameter("viewtype");
        String taskguid = request.getParameter("taskguid");
        String mainguid = request.getParameter("mainguid");
        config.put("workflow", workflow);
        config.put("pagetype", pagetype);
        config.put("viewtype", viewtype);
        config.put("taskguid", taskguid);
        config.put("mainguid", mainguid);
        config.put("delaycoldatas", problemTaskBO.getCols("/pmkpi/problemtask/delayaudit"));
        String menuid = request.getParameter("menuId");
        String datarule = problemTaskBO.getDataRuleByMenuguidNull(menuid, "t", "1=1"); //数据权限
        config.put("jsfiltersql", datarule);
        return super.loadComponent(request, response, config);
    }

    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = problemTaskBO.wfAudit(params);
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
     * 删除
     * @param params --
     * @return --
     */
    public Map<String, Object> del(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = problemTaskBO.del(params);
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
     * 查询
     * @param params
     * @return
     */
    public Map<String, Object> getData(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = problemTaskBO.getData(params);
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
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = problemTaskBO.save(parms);
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
     * 下达
     * @param parms --
     * @return --
     */
    public Map<String, Object> issue(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = problemTaskBO.issue(parms);
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
     * 延期
     * @param parms --
     * @return --
     */
    public Map<String, Object> delayupdate(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = problemTaskBO.delayupdate(parms);
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
     * 获取已申报的任务反馈数据
     * @param parms --
     * @return --
     */
    public Map<String, Object> getreportdatas(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = problemTaskBO.getreportdatas(parms);
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
