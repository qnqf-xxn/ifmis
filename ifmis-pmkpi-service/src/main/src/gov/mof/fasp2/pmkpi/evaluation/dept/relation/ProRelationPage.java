package gov.mof.fasp2.pmkpi.evaluation.dept.relation;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class ProRelationPage extends PmkpiPage {
    /**
     *
     * 部门评价关联项目
     * @param
     * @author zxt
     * @date 2026/3/02 11:21
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        config.remove("amtflag"); // 去除页签内金额万元切换
        return config;
    }

    /**
     *
     * 关联项目列表
     * @param
     * @author zxt
     * @date 2026/3/02 15:52
     */
    public Map check(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        ProRelationBO proRelationBO = (ProRelationBO) PerfServiceFactory.getBean("pmkpi.dept.relation.ProRelationBOTX");
        String leftmenuid = request.getParameter("leftmenuid");
        request.setAttribute("leftconfig", proRelationBO.getTreeData(leftmenuid));
        config.put("left", "lefttree");
        return config;
    }

}
