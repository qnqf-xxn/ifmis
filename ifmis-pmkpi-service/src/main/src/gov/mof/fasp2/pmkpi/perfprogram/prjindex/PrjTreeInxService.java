package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfprogram.goal.SelLastYearProBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2021/1/26  gaoming
 */
public class PrjTreeInxService extends PmkpiService {

    private PrjIndexBO prjIndexBO;

    public void setPrjIndexBO(PrjIndexBO prjIndexBO) {
        this.prjIndexBO = prjIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proguid = request.getParameter("mainguid") == null ? request.getParameter("projId") : request.getParameter("mainguid");
        //预算调用‘标记绩效审核’页面传的参数为pro_id
        if(StringUtils.isEmpty(proguid)){
            proguid = request.getParameter("pro_id");
        }
        String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
        String adjadd = request.getParameter("adjadd");//是否调整
        String viewtype = request.getParameter("viewtype");
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String menucode = request.getParameter("menucode"); // 项目库参数-判断嵌入项目库系统页面的标志：menucode=detail-只读
        String isyears = "0";
        String showall = request.getParameter("showall");  //项目库可以跨地区查询项目基本信息
        String dataprovince = request.getParameter("dataprovince");
        if (!StringUtils.isEmpty(menucode) && "detail".equals(menucode) ) {
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
        String saveAgency = request.getParameter("saveAgency"); //单位
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        String isprogramiframe = request.getParameter("isprogramiframe");//是否项目库嵌套
        String busguid = request.getParameter("busguid");//审核定义guid
        String pdmsave = request.getParameter("pdmsave");//项目库类型，21草稿保存,20草稿查询
        String tempcode = request.getParameter("tempcode");//内置模板编码
        String isedittotal = request.getParameter("isedittotal");//总体是否可编辑 1不可编辑
        String procode = request.getParameter("pro_code");
        String isnzzj = request.getParameter("isnzzj");  //是否年中追加项目
        String parentproid = request.getParameter("parentproid");  //父级项目id
        if (StringUtil.isEmpty(procode)) {
            procode = request.getParameter("procode"); //年中追加绩效目标填报发生调整的项目，无调整后guid
        }
        logger.debug("--------项目编码1 procode：-------------" + procode);
        String isperform = request.getParameter("isperform"); // 特殊绩效标识
        if (pdmsave != null && "20".equals(pdmsave)) {
            proguid = request.getParameter("stagid");
        }
        Map<String, Object> proMap = null;
        String tablecode = PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO;
        if (StringUtil.isEmpty(procode) && !"20".equals(pdmsave)) {
            if (adjadd != null && "1".equals(adjadd)) {
                proMap = prjIndexBO.getDataMap(PmkpiDAO.PMKPI_TABLE_PROJECT_INFO, "guid='" + selectbillguid + "'");
            } else {
                proMap = prjIndexBO.getDataMap(PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO, "guid='" + proguid + "'");
            }
            procode = (String) proMap.get("pro_code");
        }
        String isGX = PerfUtil.getSystemSet("IS_GUANGXI");
        if ("1".equals(isGX) && "2".equals(prolev) && adjadd != null && "1".equals(adjadd) && StringUtil.isEmpty(parentproid)) {//广西 二级项目 项目库调整-修改 的情况获取不到一级项目id，需要自己查询
            proMap = prjIndexBO.getDataMap(PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO, "guid='" + proguid + "'");
            parentproid = (String) proMap.get("parent_pro_id");
        }
        if ("1".equals(isGX) && "2".equals(prolev) && pdmsave != null && "20".equals(pdmsave) && StringUtil.isEmpty(parentproid)) {//广西 二级项目 项目库储备-保存草稿 的情况获取不到一级项目id，需要自己查询暂存数据
            Map<String, Object> midProMap = prjIndexBO.getDataMap("V_PM_MIDSAVE", "guid='" + proguid + "'");
            Map midDataMap = (Map) JSONObject.parse(midProMap.get("data").toString());
            String parent_pro_code = (String)midDataMap.get("parent_pro_code");
            Map<String, Object> firProMap = prjIndexBO.getDataMap(PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO, "pro_code='" + parent_pro_code + "'");
            parentproid = (String) firProMap.get("pro_id");
        }
        logger.debug("--------一级项目parentproid-------------" + parentproid);
        logger.debug("--------是否调整-------------" + adjadd);
        logger.debug("--------调整前的guid-------------"+ selectbillguid);
        logger.debug("--------调整后的guid-------------"+ proguid);
        logger.debug("--------项目编码2 procode：-------------" + procode);

        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("prolev", prolev); //项目等级123级项目
        config.put("selectbillguid", selectbillguid);
        config.put("adjadd", adjadd);
        config.put("tempcode",tempcode);
        config.put("isedittotal", isedittotal);
        if (isprogramiframe == null ||isprogramiframe.isEmpty()) {
            config.put("iframeurl", PerfUtil.getSystemSet("porgramurl_index"));
        }
        /*String isshowedit = PerfUtil.getSystemSet("tlprogramindex_edit") == null ? "1" : PerfUtil.getSystemSet("tlprogramindex_edit");
        if ("2".equals(isshowedit)) {
            config.put("editinfo", prjIndexBO.getGoalByGuid(proguid));
        }
        config.put("isshowedit", isshowedit);*/
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("busguid", busguid);
        config.put("showtab", showtab); //指标页签显示
        HashMap<String,Object> param = new HashMap<String,Object>();
        if("true".equals(isnzzj)){
            proguid = prjIndexBO.getProGuid(proguid, procode); // 年中追加调整终审项目获取调整后项目guid
        }
        param.put("proguid",proguid);
        param.put("parentproid",parentproid);
        param.put("showtab",showtab);
        param.put("pdmsave",pdmsave);
        param.put("adjadd",adjadd);
        param.put("tempcode",tempcode);
        param.put("frametype", config.get("frametype"));
        param.put("selectbillguid",selectbillguid);
        param.put("procode", procode);
        param.put("isperform", isperform);
        param.put("showall",showall);
        param.put("dataprovince",dataprovince);
//        if("1".equals(isperform)){
//            config.put("indexdata", this.specialPmkpi(param));
//        }else{
//        }
        param.put("queryYear",config.get("queryYear"));
        param.put("queryProvince",config.get("queryProvince"));
        config.put("indexdata", this.findAllIndex(param));
        config.put("pdmsave",pdmsave); //保存还是暂存
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE","elementcode='KPIVALNOTAPP'");//添加不适用
        config.put("kpicalnotapply",kpicalnotapply);
        config.put("signs",signs);//计算符号
        config.put("kpivals",kpivals);//定量其他
        config.put("isZJ", PerfUtil.getSystemSet("isZJ"));
        config.put("isSX", PerfUtil.getSystemSet("isSX"));
        config.put("isGx", PerfUtil.getSystemSet("IS_GUANGXI"));
        config.put("isJiangXI", PerfUtil.get_IsJiangXi() == true ? "1":"0");
        //查询项目数据是否存在，如果存在，判断审核意见是否可修改
        if (!StringUtil.isEmpty(procode) && !"20".equals(pdmsave)) {
            proMap = prjIndexBO.getDataMap(tablecode, "pro_code='" + procode + "'");
            String prowfststus = (String) proMap.get("wfstatus");
            String isEditOpinionStatus = PerfUtil.getSystemSet("PDMWFSTSTUSTOINDEXOPINION");//指标值是否合并单位符号
            if (!StringUtil.isEmpty(isEditOpinionStatus)) {
                Map<String, Object> mm = PerfUtil.parseString2Map(isEditOpinionStatus);
                String wfstatus = (String) mm.get("wfstatus");
                String[] wfst = wfstatus.split(",");
                for (String str : wfst) {
                    if (str.equals(prowfststus)) {
                        config.put("opinion_remark", true);
                    }
                }
            }
        }
        config.put("proguid", proguid);
        config.put("procode", procode);
        config.put("parentproid",parentproid);
        String isnewapply = prjIndexBO.isNewApply();
        config.put("isnewapply", isnewapply);
        config.put("indexIsAddrow", PerfUtil.getIndexIsAddRow());
        config.put("isyears",isyears); //项目入库查询年度时候能切换年度查看多年度绩效.
        config.put("isnzzj", isnzzj);
        config.put("mainguid", proguid);

        String isfrombdm = request.getParameter("isfrombdm");
        config.put("isfrombdm",isfrombdm);
        config.put("indsource", PerfUtil.getSourceData("PERFINDSOURCE", ""));
        return config;
    }

    /**
     * 查询项目全部的指标数据.
     * @param parms -- 前端参数.
     * @return -- list.
     */
    public Map<String, Object> findAllIndex(HashMap<String,Object> parms) throws AppException {
        return prjIndexBO.findAllIndex(parms);
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> savePrjTreeIndex(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = prjIndexBO.savePrjTreeIndex(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
    public String chcekProgram(HashMap<String, Object> parms) throws AppException {
        return prjIndexBO.chcekProgram(parms);
    }


    /**
     * 项目查看页面查询项目各年度绩效.
     * @param params -- 参数
     * @return
     * @throws AppException
     */
    public Map<String, Object> getYearIndicator(Map<String, Object> params) throws AppException {
        return prjIndexBO.getYearIndicator(params);
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

    /**
     * 查询所属一级项目指标.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getparentproindex(Map<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = prjIndexBO.getparentproindex(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询上年项目关系.
     * @param parms -- 参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getLastProData(HashMap<String,Object> parms) throws AppException {
        SelLastYearProBO selLastYearProBO = (SelLastYearProBO) PerfServiceFactory.getBean("pmkpi.perfprogram.goal.SelLastYearProBOTX");
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = selLastYearProBO.getLastProData(parms);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
