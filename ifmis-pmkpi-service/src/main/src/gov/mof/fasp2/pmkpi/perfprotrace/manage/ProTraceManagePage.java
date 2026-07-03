package gov.mof.fasp2.pmkpi.perfprotrace.manage;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProTraceManagePage extends PmkpiPage {
    /**
     * 下达页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map tasklist(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProTraceManageBO proTraceManageBO = (ProTraceManageBO) PerfServiceFactory.getBean("pmkpi.perfprotrace.manage.ProTraceManageBOTX");
        String menuId = request.getParameter("menuId");
        if(StringUtils.isEmpty(menuId)){
            menuId = request.getParameter("menuguid");
        }
        request.setAttribute("leftconfig", proTraceManageBO.getTreeData(menuId));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }

    /**
     * 下达
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map prolist(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProTraceManageBO proTraceManageBO = (ProTraceManageBO) PerfServiceFactory.getBean("pmkpi.perfprotrace.manage.ProTraceManageBOTX");
        //任务类型，项目/部门/政策
        String tasktype = request.getParameter("tasktype");
        if ("protrace".equals(tasktype)) {
            request.setAttribute("leftconfig", proTraceManageBO.getLeftData());  //项目支出有左侧树
            config.put("left", "lefttree");
        }
        return config;
    }

    /**
     * 任务复制
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map taskcopy(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
