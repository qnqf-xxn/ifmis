package gov.mof.fasp2.pmkpi.perfprogram.approvalquery.goal;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;



public class ApprovalGoalPage extends PmkpiPage {
    /**
     * 初始化页面.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> listpage(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        //项目级次显示页签名称
        String program_totalname = PerfUtil.getSystemSet("program_totalname");
        String totalGoalName = null;
        if (!StringUtil.isEmpty(program_totalname) && !StringUtil.isEmpty(prolev)) {
            Map<String, Object> mm = PerfUtil.parseString2Map(program_totalname);
            String prolevtype = (String) mm.get(prolev);
            String[] prolevtypes = prolevtype.split(",");
            totalGoalName = (String) mm.get(prolevtypes[0]);
        }
        config.put("totalname", totalGoalName);
        config.put("filterbeanid", "pmkpi.filter.PerfUIFilter");
        return config;
    }


    /**
     * 初始化页面.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> hblist(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        //项目级次显示页签名称
        String program_totalname = PerfUtil.getSystemSet("program_totalname");
        String totalGoalName = null;
        if (!StringUtil.isEmpty(program_totalname) && !StringUtil.isEmpty(prolev)) {
            Map<String, Object> mm = PerfUtil.parseString2Map(program_totalname);
            String prolevtype = (String) mm.get(prolev);
            String[] prolevtypes = prolevtype.split(",");
            totalGoalName = (String) mm.get(prolevtypes[0]);
        }
        config.put("totalname", totalGoalName);
        config.put("filterbeanid", "pmkpi.filter.PerfUIFilter");
        return config;
    }
}
