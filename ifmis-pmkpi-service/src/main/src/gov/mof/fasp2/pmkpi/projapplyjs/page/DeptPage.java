package gov.mof.fasp2.pmkpi.projapplyjs.page;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class DeptPage extends PmkpiPage {

    
    /**
     * 部门整体绩效基本信息
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map deptperfinfo(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 部门整体绩效预算
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map deptperfbudget(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 部门整体职能
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map deptfunction(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 部门整体职能-选择项目
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map deptfunctionproj(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 部门整体绩效指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map deptperfindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 部门整体绩效指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map deptperfindexedit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

}
