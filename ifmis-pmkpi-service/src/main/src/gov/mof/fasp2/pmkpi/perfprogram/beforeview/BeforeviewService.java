package gov.mof.fasp2.pmkpi.perfprogram.beforeview;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class BeforeviewService extends PmkpiService {
    private BeforeviewBO beforeviewBO;

    public void setBeforeviewBO(BeforeviewBO beforeviewBO) {
        this.beforeviewBO = beforeviewBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proguid = request.getParameter("mainguid")== null ? request.getParameter("projId") : request.getParameter("mainguid");
        String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
        String adjadd = request.getParameter("adjadd");//是否调整
        logger.error("--------是否调整-------------" + adjadd);
        logger.error("--------调整前的guid-------------"+ selectbillguid);
        logger.error("--------调整后的guid-------------"+ proguid);
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency"); //单
        String pdmsave = request.getParameter("pdmsave"); //单位
        String isprogramiframe = request.getParameter("isprogramiframe");//是否项目库嵌套
        String busguid = request.getParameter("busguid");//审核定义guid
        String showall = request.getParameter("showall");  //项目库可以跨地区查询项目基本信息
        String dataprovince = request.getParameter("dataprovince");
        if (pdmsave != null && "20".equals(pdmsave)) {
            proguid = request.getParameter("stagid");
        }
        String menucode = request.getParameter("menucode"); // 项目库参数-判断嵌入项目库系统页面的标志：menucode=detail-只读
        if (!StringUtils.isEmpty(menucode) && "detail".equals(menucode)) {
            viewtype = "query";
            logger.debug("-------------viewtype-------------" + viewtype);
        }
        config.put("proguid", proguid);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        if (isprogramiframe == null || isprogramiframe.isEmpty()) {
            config.put("iframeurl", PerfUtil.getSystemSet("porgramurl_index"));
        }
        HashMap<String,Object> param = new HashMap<String,Object>();
        param.put("proguid",proguid);
        param.put("pdmsave",pdmsave);
        param.put("showall",showall);
        param.put("dataprovince",dataprovince);
        config.put("editinfo", beforeviewBO.getBeforeview(proguid, adjadd, selectbillguid));
        config.put("busguid", busguid);
        return config;
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = beforeviewBO.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
