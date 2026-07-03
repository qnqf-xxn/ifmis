package gov.mof.fasp2.pmkpi.perfself.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfself.bo.PerfSelfApplyBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfSelfApplyService extends PmkpiService {
    private PerfSelfApplyBO perfSelfApplyBO;

    public void setPerfSelfApplyBO(PerfSelfApplyBO perfSelfApplyBO) {
        this.perfSelfApplyBO = perfSelfApplyBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("deptqfdatas", perfSelfApplyBO.getQueryFrom("/pmkpi/perfself/apply/dept"));
        config.put("proqfdatas", perfSelfApplyBO.getQueryFrom("/pmkpi/perfself/apply/index"));
        config.put("isNINGXIA", PerfUtil.getIsNINGXIA());
        return config;
    }
 
    /**
     * 审核/送审/取消审核/退回
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfSelfApplyBO.wfAudit(params);
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
     * <p>左侧树-整合菜单首次进入页面</p >
     *
     * @author hw
     * @date 2021/7/17 16:06
     * @param
     */
    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return perfSelfApplyBO.getTreeData(params);
    }

    /**
     * 根据项目id查询自评详情
     * @param params -- 项目id.
     * @return
     */
    public Map<String, Object> findByProjGuid(HashMap<String, Object> params){
        return perfSelfApplyBO.findByProjGuid(params);
    }

    /**
     * 获取参数配置
     * @return
     */
    public String getSystemSet(String str) throws AppException {
        return 	PerfUtil.getSystemSet(str);

    }
}
