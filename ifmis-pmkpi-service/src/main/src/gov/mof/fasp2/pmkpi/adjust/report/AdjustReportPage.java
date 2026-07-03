package gov.mof.fasp2.pmkpi.adjust.report;

import gov.mof.fasp2.buscore.framework.runtime.LogService;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Map;

public class AdjustReportPage extends PmkpiPage {
    /**
     * 调整列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.waitDoAction(request,response,config);
        AdjustReportBO adjustReportBO = (AdjustReportBO) ServiceFactory.getBean("pmkpi.adjust.report.AdjustReportBOTX");
        request.setAttribute("leftconfig", adjustReportBO.getLeftTabTree(config));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        List<String> removelist = new ArrayList<String>();
        List<String> mainlist = (List<String>) config.get("main");
        String adjusthide = PerfUtil.getSystemSet("adjusthide");//判断是否进行指标/目标替换
        if (adjusthide != null && !adjusthide.isEmpty()) {
            String[] str = adjusthide.split(",");
            if (mainlist != null && mainlist.size() > 0){
                for (int i= 0; i < mainlist.size(); i++) {
                    for (String s : str){
                        if (mainlist.get(i).indexOf(s) != -1) {
                            removelist.addAll(Collections.singleton(mainlist.get(i)));
                        }
                    }
                }
            }
            mainlist.removeAll(removelist);
        }
        return config;
    }

    /**
     * 选择项目列表
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map check(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }

    /**
     * 调整调剂调用调整页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map tztjadjust(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        AdjustReportBO adjustReportBO = (AdjustReportBO) ServiceFactory.getBean("pmkpi.adjust.report.AdjustReportBOTX");
        String procode = request.getParameter("pro_code");
        String viewtype = request.getParameter("viewtype");//没有查看，暂时不传递该参数
        String province = request.getParameter("province");
        String year = request.getParameter("year");
        String submofdivcodes = request.getParameter("submofdivcodes");
        String prolev = ""; //项目一二三级
        String mainguid = ""; //主键
        String proguid = ""; //调整项目guid
        String saveAgency = "";
        String pro_name = "";
        String projectkind = "";
        Map<String, Object> adjustMap = adjustReportBO.tztjAdjust(year, province, procode);
        if (!adjustMap.isEmpty()) {
            mainguid = (String) adjustMap.get("guid");
            prolev = String.valueOf(PerfUtil.mapGetInt(adjustMap, "pro_lev"));
            proguid = (String) adjustMap.get("proguid");
            saveAgency = (String) adjustMap.get("agencyguid");
            pro_name = URLEncoder.encode((String) adjustMap.get("name"), "UTF-8");
            projectkind = (String) adjustMap.get("projectkind");
        }
        String params = request.getQueryString() + "&istztj=1&prolev=" + prolev +"&mainguid=" + mainguid + "&submofdivcodes=" + submofdivcodes
                + "&proguid=" + proguid + "&viewtype=" + viewtype + "&bustype=program&saveAgency=" + saveAgency + "&projectkind=" + projectkind
                + "&pro_name=" + pro_name + "&queryYear=" + year + "&queryProvince=" + province + "&procode=" + procode;
        String url = request.getServletPath();
        if ("/pmkpi/adjust/report/protztj.page".equals(url)) {
            String curl = url.replace("/pmkpi/adjust/report/protztj","/pmkpi/adjust/protztjedit")+"?"+params;
            LogService.endJob();
            request.getRequestDispatcher(curl).forward(request, response);
        }
        return config;
    }

    /**
     * 调整调剂调用调整页面
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map tztjedit(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        config.put("filterbeanid", "pmkpi.filter.PerfUIFilter");
        return config;
    }
}
