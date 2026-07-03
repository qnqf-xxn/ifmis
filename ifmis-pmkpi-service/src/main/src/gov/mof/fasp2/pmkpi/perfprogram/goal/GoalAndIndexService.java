package gov.mof.fasp2.pmkpi.perfprogram.goal;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

;

public class GoalAndIndexService extends PmkpiService {
    private PrjIndexBO prjIndexBO;

    public void setPrjIndexBO(PrjIndexBO prjIndexBO) {
        this.prjIndexBO = prjIndexBO;
    }


    private gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO indexBO;

    public gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO getIndexBO() {
        if(indexBO == null){
            indexBO = (gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBO");
        }
        return indexBO;
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

        String proguid = request.getParameter("mainguid") == null ? request.getParameter("projId") : request.getParameter("mainguid");
        String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
        String adjadd = request.getParameter("adjadd");//是否调整
        String isnzzj = request.getParameter("isnzzj");  //是否年中追加项目
        String pagetype = request.getParameter("pagetype");
        String viewtype = request.getParameter("viewtype");
        String menucode = request.getParameter("menucode"); // 项目库参数-判断嵌入项目库系统页面的标志：menucode=detail-只读
        String showall = request.getParameter("showall");  //项目库可以跨地区查询项目基本信息
        String dataprovince = request.getParameter("dataprovince");
        if (!StringUtils.isEmpty(menucode) && "detail".equals(menucode)) {
            viewtype = "query";
            logger.error("-------------viewtype-------------" + viewtype);
        }
        //绩效目标评审
        if ("review".equals(pagetype)) {
            logger.error("--------pagetype-------------" + pagetype);
            proguid = request.getParameter("proguid");
        }
        String saveAgency = request.getParameter("saveAgency"); //单位
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        String isprogramiframe = request.getParameter("isprogramiframe");//是否项目库嵌套
        String busguid = request.getParameter("busguid");//审核定义guid
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String pdmsave = request.getParameter("pdmsave");
        String tempcode = request.getParameter("tempcode");//内置模板编码
        String isedittotal = request.getParameter("isedittotal");//总体是否可编辑 1不可编辑
        String procode = request.getParameter("pro_code")== null ? request.getParameter("procode") : request.getParameter("pro_code");
        if (pdmsave != null && "20".equals(pdmsave)) {
            proguid = request.getParameter("stagid");
        }
        Map<String, Object> proMap = null;
        String tablecode = PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO;
        if (StringUtil.isEmpty(procode)) {
            if (adjadd != null && "1".equals(adjadd)) {
                proMap = prjIndexBO.getDataMap(PmkpiDAO.PMKPI_TABLE_PROJECT_INFO, "guid='" + selectbillguid + "'");
            } else {
                proMap = prjIndexBO.getDataMap(tablecode, "guid='" + proguid + "'");
            }
            procode = (String) proMap.get("pro_code");
        }
        if("true".equals(isnzzj)){
            proguid = prjIndexBO.getProGuid(proguid, procode); // 年中追加调整终审项目获取调整后项目guid
        }
        logger.error("--------是否调整-------------" + adjadd);
        logger.error("--------是否年中追加-------------" + isnzzj);
        logger.error("--------调整前的guid-------------"+ selectbillguid);
        logger.error("--------调整后的guid-------------"+ proguid);
        logger.error("--------项目编码procode：-------------" + procode);
        config.put("proguid", proguid);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("prolev", prolev); //项目等级123级项目
        config.put("selectbillguid", selectbillguid);
        config.put("adjadd", adjadd);
        config.put("isnzzj",isnzzj);
        config.put("tempcode",tempcode);
        config.put("isedittotal", isedittotal);
        if (isprogramiframe == null ||isprogramiframe.isEmpty()) {
            config.put("iframeurl", PerfUtil.getSystemSet("porgramurl_index"));
        }
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("busguid", busguid);
        config.put("showtab", showtab); //页签显示
        config.put("pdmsave",pdmsave); //保存还是暂存
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> standards = dss.getRangesByWhereSql("INDEXSTANDARDS", "");
        List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE","elementcode='KPIVALNOTAPP'");//添加不适用
        config.put("kpicalnotapply",kpicalnotapply);
        config.put("standards",standards);//绩效标准
        config.put("signs",signs);//计算符号
        config.put("kpivals",kpivals);//定量其他
        //查询项目数据是否存在，如果存在，判断审核意见是否可修改
        if (!StringUtil.isEmpty(procode)) {
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
        config.put("showall",showall);
        config.put("dataprovince",dataprovince);
        config.put("procode", procode);
        return config;
    }


    /**
     * 查询主表目标数据(湖北)
     * @param parms -- 参数。
     * @return --
     */
    public Map<String, Object> getMainDatas(HashMap<String,Object> parms) throws AppException {
        return prjIndexBO.getMainDatas(parms);
    }

    /**
     * 根据主表记录查询子表指标数据(湖北)
     * @param parms -- 参数。
     * @return --
     */
    public Map<String, Object> getSubData(HashMap<String,Object> parms) throws AppException {
        return prjIndexBO.getSubData(parms);
    }

    /**
     * 根据目标查询对应的指标数据
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String,Object> getIndexData(HashMap<String,Object> params) throws AppException{
        return prjIndexBO.getIndexData(params);
    }

    /**
     * 保存湖北申报数据
     * @param parms --
     * @return --
     */
    public Map<String, Object> saveHbDatas(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = prjIndexBO.saveHbDatas(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 申报导入指标前 校验项目
     * @param parms
     * @return
     * @throws AppException
     */
    public String chcekProgram(HashMap<String, Object> parms) throws AppException {
        return getIndexBO().chcekProgram(parms);
    }
}
