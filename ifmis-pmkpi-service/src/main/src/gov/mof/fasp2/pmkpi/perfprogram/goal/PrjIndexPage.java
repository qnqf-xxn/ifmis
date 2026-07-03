/**
 * @Title: PrjIndexPage.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.goal;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import java.util.Map;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * @ClassName: PrjIndexPage
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-1-6 上午10:40:42
 */

public class PrjIndexPage extends PmkpiPage {
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

    /**
     * 复制上年目标选择上年项目
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map<String, Object> lastyearpro(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
        config.put("filterbeanid", "pmkpi.filter.PerfUIFilter");
        return config;
    }
}
