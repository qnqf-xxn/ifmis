package gov.mof.fasp2.pmkpi.perfprogram.goal;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

;

public class PrjGoalTabService extends PmkpiService {
    private PrjIndexBO prjIndexBO;

    public void setPrjIndexBO(PrjIndexBO prjIndexBO) {
        this.prjIndexBO = prjIndexBO;
    }

    /**
     * 初始化页面.
     * <p>Title: loadComponent</p>
     * <p>Description: </p>
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config -- 参数.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proguid = request.getParameter("mainguid")== null ? request.getParameter("projId") : request.getParameter("mainguid");
        //预算调用‘标记绩效审核’页面传的参数为pro_id
        if(StringUtils.isEmpty(proguid)){
            proguid = request.getParameter("pro_id");
        }
        String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
        String adjadd = request.getParameter("adjadd");//是否调整
        String pagetype = request.getParameter("pagetype");
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        //绩效目标评审
        if ("review".equals(pagetype)) {
            logger.debug("--------pagetype-------------" + pagetype);
            proguid = request.getParameter("proguid");
        }
        logger.debug("--------是否调整-------------" + adjadd);
        logger.debug("--------调整前的guid-------------"+ selectbillguid);
        logger.debug("--------调整后的guid-------------"+ proguid);
        String viewtype = request.getParameter("viewtype");
        String menucode = request.getParameter("menucode"); // 项目库参数-判断嵌入项目库系统页面的标志：menucode=detail-只读
        String isyears = "0";
        String showall = request.getParameter("showall");  //项目库可以跨地区查询项目基本信息
        String dataprovince = request.getParameter("dataprovince");
        if (!StringUtils.isEmpty(menucode) && "detail".equals(menucode)) {
            viewtype = "query";
            if (!StringUtils.isEmpty(showtab) && !"2".equals(showtab) ) {
                isyears = "1";
            }
            logger.debug("-------------viewtype-------------" + viewtype);
        }
        //isyears：绩效年度查询组件是否显示
        String pageyear = (String) config.get("isyears");
        if (!StringUtil.isEmpty(pageyear)){
            isyears = pageyear;
        }
        String saveAgency = request.getParameter("saveAgency"); //单
        String pdmsave = request.getParameter("pdmsave"); //项目库类型，21草稿保存,20草稿查询
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        String isprogramiframe = request.getParameter("isprogramiframe");//是否项目库嵌套
        String busguid = request.getParameter("busguid");//审核定义guid

        String isedittotal = request.getParameter("isedittotal");//总体是否可编辑 1不可编辑
        String tempcode = request.getParameter("tempcode");
        String procode = request.getParameter("pro_code");
        String isnzzj = request.getParameter("isnzzj");  //是否年中追加项目
        if (StringUtil.isEmpty(procode)) {
            procode = request.getParameter("procode"); //年中追加绩效目标填报发生调整的项目，无调整后guid
        }
        logger.debug("--------项目编码1 procode：-------------" + procode);
        String isperform = request.getParameter("isperform"); // 特殊绩效标识
        if ("20".equals(pdmsave)) {
            proguid = request.getParameter("stagid");
        }
        Map<String, Object> proMap = null;
        String tablecode = PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO;
        if (StringUtil.isEmpty(procode) && !"20".equals(pdmsave)) {
            if (adjadd != null && "1".equals(adjadd)) {
                proMap = prjIndexBO.getDataMap(PmkpiDAO.PMKPI_TABLE_PROJECT_INFO, "guid='" + selectbillguid + "'");
            } else {
                proMap = prjIndexBO.getDataMap(tablecode, "guid='" + proguid + "'");
            }
            procode = (String) proMap.get("pro_code");
        }
        logger.debug("--------项目编码2 procode：-------------" + procode);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("prolev", prolev); //项目等级123级项目
        if (StringUtil.isEmpty(isprogramiframe)) {
            config.put("iframeurl", PerfUtil.getSystemSet("porgramurl_index"));
        }
        config.put("busguid", busguid);
        config.put("showtab", showtab);
        config.put("tempcode",tempcode);
        HashMap<String,Object> param = new HashMap<String,Object>();
        if("true".equals(isnzzj)){
            proguid = prjIndexBO.getProGuid(proguid, procode); // 年中追加调整终审项目获取调整后项目guid
        }
        param.put("proguid",proguid);
        param.put("showtab",showtab);
        param.put("pdmsave",pdmsave);
        param.put("adjadd",adjadd);
        param.put("tempcode",tempcode);
        param.put("saveAgency",saveAgency);
        param.put("isedittotal", isedittotal);
        param.put("selectbillguid",selectbillguid);
        param.put("procode", procode);
        param.put("isperform", isperform);
        param.put("showall",showall);
        param.put("dataprovince",dataprovince);
        param.put("queryYear",config.get("queryYear"));
        param.put("queryProvince",config.get("queryProvince"));
        config.put("proguid", proguid);
        config.put("goaldata", this.getAllGoal(param));
        config.put("isedittotal", isedittotal);
        config.put("procode", procode);
        config.put("isyears",isyears); //项目入库查询年度时候能切换年度查看多年度绩效.
        config.put("isnzzj", isnzzj);
        config.put("adjadd",adjadd);

        String isfrombdm = request.getParameter("isfrombdm");
        config.put("isfrombdm",isfrombdm);
        return config;
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> saveGoal(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = prjIndexBO.saveGoal(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询项目全部的指标数据.
     * @param parms -- 前端参数.
     * @return -- list.
     */
    public Map<String, Object> getAllGoal(HashMap<String,Object> parms) throws AppException {
        return prjIndexBO.getAllGoal(parms);
    }


    public Map<String, Object> copyGoal(HashMap<String,Object> parms) throws AppException {
        return prjIndexBO.copyGoal(parms);
    }

    /**
     * 项目查看页面查询项目各年度绩效.
     * @param params -- 参数
     * @return
     * @throws AppException
     */
    public Map<String, Object> getYearGoal(Map<String, Object> params) throws AppException {
        return prjIndexBO.getYearGoal(params);
    }

    /**
     * 查询项目涉及哪些年度.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public List getYearOption(Map<String, Object> params) throws AppException {
        return prjIndexBO.getYearOption(params);
    }

}
