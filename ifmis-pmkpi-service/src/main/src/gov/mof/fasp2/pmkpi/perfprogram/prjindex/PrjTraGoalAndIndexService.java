package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PrjTraGoalAndIndexService extends PmkpiService {
    private PrjTraGoalAndIndexBO prjTraGoalAndIndexBO;

    public void setPrjTraGoalAndIndexBO(PrjTraGoalAndIndexBO prjTraGoalAndIndexBO) {
        this.prjTraGoalAndIndexBO = prjTraGoalAndIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proguid = request.getParameter("mainguid") == null ? request.getParameter("projId") : request.getParameter("mainguid");
        String viewtype = request.getParameter("viewtype");
        String menucode = request.getParameter("menucode"); // 项目库参数-判断嵌入项目库系统页面的标志：menucode=detail-只读
        if (!StringUtils.isEmpty(menucode) && "detail".equals(menucode) ) {
            viewtype = "query";
            logger.debug("-------------viewtype-------------" + viewtype);
        }
        String saveAgency = request.getParameter("saveAgency"); //单位
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        String isprogramiframe = request.getParameter("isprogramiframe");//是否项目库嵌套
        String busguid = request.getParameter("busguid");//审核定义guid
        String procode = request.getParameter("pro_code");
        Map<String, Object> proMap = null;
        if (StringUtil.isEmpty(procode)) {
            proMap = prjTraGoalAndIndexBO.getDataMap(PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO, "guid='" + proguid + "'");
            procode = (String) proMap.get("pro_code");
        }
        logger.debug("--------项目guid-------------"+ proguid);
        logger.debug("--------项目编码 procode：-------------" + procode);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("prolev", prolev); //项目等级123级项目
        if (isprogramiframe == null ||isprogramiframe.isEmpty()) {
            config.put("iframeurl", PerfUtil.getSystemSet("porgramurl_index"));
        }
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("busguid", busguid);
        config.put("procode", procode);
        config.put("indexIsAddrow", PerfUtil.getIndexIsAddRow());
        config.put("signs", signs);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return prjTraGoalAndIndexBO.getDatas(parms);
    }

    /**
     *保存
     * @param parms
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveGoalAndIndex(HashMap<String,Object> parms) throws AppException {
        return prjTraGoalAndIndexBO.saveGoalAndIndex(parms);
    }

    /**
     * 清理绩效数据
     * @param parms
     */
    public void updaedata(HashMap<String,Object> parms) throws AppException {
        prjTraGoalAndIndexBO.updaedata(parms);
    }
}
