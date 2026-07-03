package gov.mof.fasp2.pmkpi.doubleprocess.report;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class TlpProgramPage extends PmkpiPage {

    /**
     * 申报页面
     * @param request -- 请求
     * @param response -- 响应  
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        TlpDoublepressBO tlpProgramBO  = (TlpDoublepressBO) PerfServiceFactory.getBean("pmkpi.doubleprocess.TlpProgramBOTX");
        String menuId = request.getParameter("menuId");
        String prolev = request.getParameter("prolev"); //项目一二三级项目
        request.setAttribute("leftconfig", tlpProgramBO.getTreeData(menuId,prolev));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);
        return config;
    }
    
    /**
     * 申报页面编辑
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception -- 异常.
     */
    public Map editindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String viewtype = request.getParameter("viewtype");
        if (viewtype != null && "query".equals(viewtype)) {
//            List heights = new ArrayList();
//            List<String> mainlist = (List<String>) config.get("main");
//            List<String> hlist = (List<String>) config.get("heights");
//            if (mainlist != null && mainlist.size() > 0){
//                for (int i= 0; i < mainlist.size(); i++) {
//                    if (mainlist.get(i).indexOf("datatable") != -1 || mainlist.get(i).indexOf("file") != -1) {
//                        heights.add(400);
//                    } else {
//                        if (hlist != null && hlist.size() > 0 && hlist.get(i) != null && !"null".equals(hlist)) {
//                            heights.add(hlist.get(i));
//                        } else {
//                            heights.add(null);
//                        }
//                    }
//                }
//                config.put("heights", heights);
//            }
        }
        return config;
    }

    /**
     * 指标新增页.
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map addindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return config;
    }
}
