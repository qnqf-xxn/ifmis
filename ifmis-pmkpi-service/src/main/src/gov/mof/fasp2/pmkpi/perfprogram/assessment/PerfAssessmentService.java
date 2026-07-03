package gov.mof.fasp2.pmkpi.perfprogram.assessment;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfAssessmentService extends PmkpiService {
    private PerfAssessmentBO perfAssessmentBO;

    public void setPerfAssessmentBO(PerfAssessmentBO perfAssessmentBO) {
        this.perfAssessmentBO = perfAssessmentBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proguid = request.getParameter("mainguid")== null ? request.getParameter("projId") : request.getParameter("mainguid");
        String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
        String adjadd = request.getParameter("adjadd");//是否调整
        logger.debug("--------是否调整-------------" + adjadd);
        logger.debug("--------调整前的guid-------------"+ selectbillguid);
        logger.debug("--------调整后的guid-------------"+ proguid);
        String viewtype = request.getParameter("viewtype");
        String menucode = request.getParameter("menucode"); // 项目库参数-判断嵌入项目库系统页面的标志：menucode=detail-只读
        String showall = request.getParameter("showall");  //项目库可以跨地区查询项目基本信息
        String dataprovince = request.getParameter("dataprovince"); //查询数据区划
        if (!StringUtils.isEmpty(menucode) && "detail".equals(menucode)) {
            viewtype = "query";
            logger.debug("-------------viewtype-------------" + viewtype);
        }
        String saveAgency = request.getParameter("saveAgency"); //单位
        String pdmsave = request.getParameter("pdmsave"); //保存方式
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        String isprogramiframe = request.getParameter("isprogramiframe");//是否项目库嵌套
        String busguid = request.getParameter("busguid");//审核定义guid
        String procode = request.getParameter("pro_code");
        if ("20".equals(pdmsave)) {
            proguid = request.getParameter("stagid");
        }
        Map<String, Object> proMap = null;
        if (StringUtil.isEmpty(procode)) {
            if (adjadd != null && "1".equals(adjadd)) {
                proMap = perfAssessmentBO.getDataMap(PmkpiDAO.PMKPI_TABLE_PROJECT_INFO, "guid='" + selectbillguid + "'");
            } else {
                proMap = perfAssessmentBO.getDataMap(PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO, "guid='" + proguid + "'");
            }
            procode = (String) proMap.get("pro_code");
        }
        logger.error("--------项目编码procode：-------------" + procode);
        config.put("proguid", proguid);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("prolev", prolev); //项目等级123级项目
        if (StringUtil.isEmpty(isprogramiframe)) {
            config.put("iframeurl", PerfUtil.getSystemSet("porgramurl_index"));
        }
        config.put("busguid", busguid);
        config.put("selectbillguid", selectbillguid);
        config.put("adjadd", adjadd);
        config.put("pdmsave", pdmsave);
        config.put("procode", procode);
        config.put("is_JiangXi", PerfUtil.get_IsJiangXi());
        List<DicRangeDTO> assessmentTypes = PerfUtil.getSourceData("PERFASSESSMENTTYPE", " guid <> 'assessment' ");
        config.put("assessmentTypes", assessmentTypes);
        boolean isShowselAssessment = perfAssessmentBO.isAssessment();
        config.put("isShowselAssessment", isShowselAssessment); //根据模板数据类型个数，是否显示下拉框
        if (isShowselAssessment) { //显示下拉框，查询业务bustype类型，查询数据、回显使用
            config.put("bustype", perfAssessmentBO.getSelAssessment(proguid, adjadd, selectbillguid));
        }
        config.put("showall",showall);
        config.put("dataprovince",dataprovince);
        return config;
    }

    /**
     * 查询指标集合.
     * @param params -- 参数集合.
     * @return treedatas.
     * @throws AppException --异常.
     * @throws
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        return perfAssessmentBO.getDatas(params);
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
            rs = perfAssessmentBO.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
