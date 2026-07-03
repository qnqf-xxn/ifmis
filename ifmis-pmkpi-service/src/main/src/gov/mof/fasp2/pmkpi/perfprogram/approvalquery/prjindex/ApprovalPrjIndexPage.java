package gov.mof.fasp2.pmkpi.perfprogram.approvalquery.prjindex;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfprogram.prjindex.MergeIndexAdjustBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexPage
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-1-6 上午10:40:42
 */

public class ApprovalPrjIndexPage extends PmkpiPage {
    /**
     * 初始化页面.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> listpage(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        return config;
    }
    /**
     * 精准推荐.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @throws Exception -- 异常.
     * @throws
     */
    public Map<String, Object> cmpage(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        Map leftconfig = new HashMap();
        leftconfig.put("showRootNode", Boolean.FALSE);
        leftconfig.put("dosearch", Boolean.FALSE);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 1);
        //leftconfig.put("name", "案例");
        List<DicRangeDTO> value = new ArrayList<DicRangeDTO>();
        leftconfig.put("datas", value);
        request.setAttribute("leftconfig", leftconfig);
        config.put("left", "lefttree");
        return config;
    }
    /**
     * 挑选指标.
     * @param request --请求
     * @param response --响应
     * @param config -- 配置
     * @return
     * @throws Exception
     * @throws
     */
    public Map<String, Object> pickpage(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        return config;
    }
    
    /**
     * 编辑指标.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置
     * @return
     * @throws Exception -- 异常。
     * @throws
     */
    public Map<String, Object> editpage(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        return config;
    }

    /**
     * 指标
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
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

    /**
     * 上年项目指标.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置
     * @return
     * @throws Exception -- 异常。
     * @throws
     */
    public Map<String, Object> lastpage(HttpServletRequest request, HttpServletResponse response,
                                        Map<String, Object> config) throws Exception {
        return config;
    }

    /**
     * 往年项目预算执行情况.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置
     * @return
     * @throws Exception -- 异常。
     * @throws
     */
    public Map<String, Object> bdugetpage(HttpServletRequest request, HttpServletResponse response,
                                        Map<String, Object> config) throws Exception {
        return config;
    }

    /**
     * 绩效的目标指标一个页面处理.
     * @param request -- 请求
     * @param response -- 响应
     * @param config -- 配置
     * @return
     * @throws Exception
     */
    public Map<String, Object> mergeindex(HttpServletRequest request, HttpServletResponse response,
                                          Map<String, Object> config) throws Exception {
        if(PerfUtil.getIsHbei()){
            String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
            String state = request.getParameter("state"); //1新增2修改，3查看
            if(showtab!=null && "1".equals(showtab)){ //预算编制 始终不展示事前
                config.put("isbefore","0");
            }else if(showtab!=null && "2".equals(showtab)){ //项目申报
                if(state!=null && "3".equals(state)){ //查询：根据是否填报事前判断
                    String proguid = request.getParameter("itemid");
                    MergeIndexAdjustBO mergeIndexAdjustBO  = (MergeIndexAdjustBO) PerfServiceFactory.getBean("pmkpi.prjindex.MergeIndexAdjustBOTX");
                    Boolean isbeforetab = mergeIndexAdjustBO.isadjbeforetab(proguid);
                    config.put("isbefore",isbeforetab ? "1" : "0");
                }else{ //填报：始终展示事前
                    config.put("isbefore","1");
                }
            }else{
                config.put("isbefore","0");
            }
        }
        config.put("filterbeanid", "pmkpi.filter.MergeTabFilter");
        return config;
    }

    /**
     * 绩效的目标指标一个页面处理调整调剂.
     * @param request -- 请求
     * @param response -- 响应
     * @param config -- 配置
     * @return
     * @throws Exception
     */
    public Map<String, Object> mergeindexadjust(HttpServletRequest request, HttpServletResponse response,
                                          Map<String, Object> config) throws Exception {
        String adjusttype = request.getParameter("adjusttype");
        if(adjusttype!=null && "1".equals(adjusttype)){
            String proguid = request.getParameter("itemid");
            MergeIndexAdjustBO mergeIndexAdjustBO  = (MergeIndexAdjustBO) PerfServiceFactory.getBean("pmkpi.prjindex.MergeIndexAdjustBOTX");
            Boolean isbeforetab = mergeIndexAdjustBO.isadjbeforetab(proguid);
            config.put("isbefore",isbeforetab ? "1" : "0");
        }
        config.put("filterbeanid", "pmkpi.filter.MergeTabFilter");
        String ProCat = request.getParameter("ProCat");
        if(ProCat!=null && ("1".equals(ProCat) || "3".equals(ProCat))){
            String params = request. getQueryString();
            String domain = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
                    + request.getContextPath() + request.getServletPath();
            response.sendRedirect(domain.replace("bgtindex","mergeindex")+"?"+params);
        }
        return config;
    }

    /**
     * 参考历年指标.
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置
     * @return
     * @throws Exception -- 异常。
     * @throws
     */
    public Map<String, Object> calendarIndex(HttpServletRequest request, HttpServletResponse response,
                                          Map<String, Object> config) throws Exception {
        return config;
    }
}
