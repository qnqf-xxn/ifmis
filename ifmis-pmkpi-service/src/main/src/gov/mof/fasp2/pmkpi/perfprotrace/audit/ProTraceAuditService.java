package gov.mof.fasp2.pmkpi.perfprotrace.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.bo.RectificationBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceAuditService extends PmkpiService {

    private ProTraceAuditBO proTraceAuditBO;

    public void setProTraceAuditBO(ProTraceAuditBO proTraceAuditBO) {
        this.proTraceAuditBO = proTraceAuditBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev");
        config.put("prolev", prolev);
        String hbprodualwfstatus = PerfUtil.getSystemSet("hbprodualwfstatus");
        Map<String, Object> wfstatusmap = PerfUtil.parseString2Map(hbprodualwfstatus);
        String hbstartwfstatus = (String) wfstatusmap.get("startwfstatus");
        String hbendwfstatus = (String) wfstatusmap.get("endwfstatus");
        config.put("hbstartwfstatus", hbstartwfstatus);
        config.put("hbendwfstatus", hbendwfstatus);
        String istraceinitiateadjust = PerfUtil.getSystemSet("ISTRACEINITIATEADJUST");//调整是否走工作流
        Map<String, Object> mm = PerfUtil.parseString2Map(istraceinitiateadjust);
        String deptwfststus = (String) mm.get("deptwfststus");
        String jxwfststus = (String) mm.get("jxwfststus");
        config.put("deptwfststus", deptwfststus);
        config.put("jxwfststus", jxwfststus);
        return config;
    }

    /**
     * 审核/送审/取消审核/退回
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = proTraceAuditBO.wfAudit(params);
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code", e.getCode());
        } catch (AppException e) {
            backmap.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        return proTraceAuditBO.getTreeData(params);
    }


    /**
     * <p>发起目标调整</p >
     *
     * @param
     * @author hw
     * @date 2021/5/26 14:58
     */
    public Map<String, Object> adjustTarget(HashMap<String, Object> datas) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        backmap.put("success", true);
        backmap.put("code", "200");
        backmap.put("message", "发起调整成功!");
        backmap.put("resp", null);
        try {
            proTraceAuditBO.savePushremind(datas);
        } catch (AppException e) {
            backmap.put("success", false);
            backmap.put("code", "400");
            backmap.put("message", "发起调整失败!");
        }
        return backmap;
    }

    /**
     * 双流程，是否能继续审核
     * @param traceguid
     * @return
     */
    public Map<String, Object> isdualaudit(String traceguid){
        Map<String, Object> backmap = new HashMap<String, Object>();
        backmap = proTraceAuditBO.isdualaudit(traceguid);
        return backmap;
    }

    //判断发起整改的数据表中是否存在
    public Integer getDataByGuid(HashMap<String, Object> params){
        return proTraceAuditBO.getDataByGuid(params);
    }

    /**
     * 发起整改 -- 保存并下发
     * @param params --
     * @return --
     */
    public Map<String, Object> sendandudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        RectificationBO rectificationBO = (RectificationBO) ServiceFactory.getBean("pmkpi.rectification.RectificationBOTX");
        try {
            rs = rectificationBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getCode() + e.getMessage().replace(e.getCode(), ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 获取河北监控分支数据
     * @param traceguid
     * @return
     */
    public Map<String, Object> getHbpromonitor(String traceguid){
        Map<String, Object> backmap = new HashMap<String, Object>();
        backmap = proTraceAuditBO.getHbpromonitor(traceguid);
        return backmap;
    }

}
