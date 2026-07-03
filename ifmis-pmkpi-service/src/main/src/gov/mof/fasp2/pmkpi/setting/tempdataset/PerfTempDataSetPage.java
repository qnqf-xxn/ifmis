package gov.mof.fasp2.pmkpi.setting.tempdataset;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PerfTempDataSetPage extends PmkpiPage {

    /**
     * 层次分类
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config, menuId);
        return config;
    }
    /**
     * 带左侧树的
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    public Map leftindex(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfTempDataSetBO perfTempDataSetBO = (PerfTempDataSetBO) ServiceFactory.getBean("pmkpi.setting.tempdataset.PerfTempDataSetBOTX");
        String menuId = request.getParameter("menuId");
        String tablecode = request.getParameter("lefttablecode");
        String defprovince = request.getParameter("defprovince");
        String defyear = request.getParameter("defyear");
        String leftcode = request.getParameter("leftcode");
        if(defyear!=null&&"1".equals(defyear)){
            defyear = CommonUtil.getYear();
        }
        if(defprovince!=null&&"1".equals(defprovince)){
            defprovince = SecureUtil.getUserSelectProvince();
        }
        config.put("defprovince",defprovince);
        config.put("defyear",defyear);
        config.put("leftcode",leftcode);
        if(tablecode==null||"".equals(tablecode)){
            tablecode = menuId;
        }
        request.setAttribute("leftconfig", perfTempDataSetBO.getTreeData(tablecode));
        config.put("left", "lefttree");
        this.getHeadTitle(config,menuId);

        return config;
    }

    /*
    * 查询左侧树
    * */
    public Map getLeftData(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        PerfTempDataSetBO perfTempDataSetBO = (PerfTempDataSetBO) ServiceFactory.getBean("pmkpi.setting.tempdataset.PerfTempDataSetBOTX");
        request.setAttribute("leftconfig", perfTempDataSetBO.getLeftTree());
        config.put("left", "lefttree");
        String menuId = request.getParameter("menuId");
        this.getHeadTitle(config,menuId);
        return config;
    }
}
