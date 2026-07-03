package gov.mof.fasp2.pmkpi.transfer.report;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class TransferPage extends PmkpiPage {


    /**
     *
     * @param request
     * @param response
     * @param config
     * @return  绩效目标页签
     * @throws Exception
     */
    public Map<String, Object> goallist(HttpServletRequest request, HttpServletResponse response, Map<String, Object> config) throws Exception {
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
     *
     * @param request
     * @param response
     * @param config
     * @return  绩效指标页签
     * @throws Exception
     */
    public Map indexlist(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        //项目级次显示页签名称
        String program_totalname = PerfUtil.getSystemSet("program_totalname");
        String totalIndexName = "";
        String frametype = "";
        if (!StringUtil.isEmpty(program_totalname) && !StringUtil.isEmpty(prolev)) {
            Map<String, Object> mm = PerfUtil.parseString2Map(program_totalname);
            String prolevtype = (String) mm.get(prolev);
            String[] prolevtypes = prolevtype.split(",");
            totalIndexName = (String) mm.get(prolevtypes[1]);
            frametype = (String) mm.get(prolevtypes[2]);
        }
        config.put("totalname", totalIndexName);
        config.put("frametype", frametype);
        config.put("filterbeanid", "pmkpi.filter.PerfUIFilter");
        return config;
    }
}
