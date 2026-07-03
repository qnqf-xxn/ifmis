package gov.mof.fasp2.pmkpi.perfprogram.prjindex.airecoindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
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

public class AiRecomIndexService extends PmkpiService {
    /**
     * 注入bo.
     */
    private AiRecoindexBO aiRecoindexBO;
    
    /**
     * 注入bo.
     * @param aiRecoindexBO -- bo.
     * @throws
     */
    public void setAiRecoindexBO(AiRecoindexBO aiRecoindexBO) {
        this.aiRecoindexBO = aiRecoindexBO;
    }
    /**
     * 初始化加载页面.
     * <p>Title: loadComponent</p>
     * <p>Description: </p>
     * @param request -- 请求
     * @param response -- 响应
     * @param config -- 配置
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.buscore.framework.component.AbstractComponentService#loadComponent(HttpServletRequest, HttpServletResponse, Map)
     */
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String fromtype = request.getParameter("fromtype");
        String is_profrompage = request.getParameter("is_profrompage");
        String loadingtips = request.getParameter("loadingtips");
        config.put("fromtype",fromtype); //来源树级表还是合并表
        config.put("is_profrompage",is_profrompage); //项目信息是否来自页面
        config.put("loadingtips",loadingtips); //加载时的提示文字
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("signs",signs);//计算符号
        List<DicRangeDTO> ind = dss.getRangesByWhereSql("PMKPIFRAME", "");
        config.put("indmap",ind);//指标层次分类
        String procode = request.getParameter("procode");
        config.put("procode", procode);
        String proguid = request.getParameter("proguid");
        config.put("proguid", proguid);
        //AI指标推荐逻辑 组装提示词
        String recomtype = request.getParameter("recomtype");//推荐类型
        if(!StringUtil.isNullOrEmpty(recomtype) && "AI".equals(recomtype)){
            String frametype = request.getParameter("frametype");//体系类型
            String plusprompt = request.getParameter("plusprompt");//页面追加的提示词
            String yearflag = request.getParameter("yearflag");//区分总体还是年度绩效
            config.put("frametype", frametype);
            config.put("plusprompt", plusprompt);
            config.put("yearflag", yearflag);
            config.put("isShowThink", PerfUtil.get_isShowAIThink());//是否显示AI思考过程，兼容无思考过程的的AI模型
            if(!StringUtil.isNullOrEmpty(frametype) && frametype.startsWith("PM")){//查询项目信息并组装提示词
//                String procode = request.getParameter("procode");//项目code
//                this.getAIprompt(config, procode, yearflag);
                config.put("apikey", request.getParameter("api_key"));
                config.put("apicode", request.getParameter("api_code"));
            }
        }
        return config;
    }

    public Map<String, Object> getAIprompt(HashMap<String, Object> params) throws AppException{
        String procode = (String) params.get("procode");
        String yearflag = (String) params.get("yearflag");
        String type = (String) params.get("type");
        Map<String, Object> result = new HashMap<>();
        String aiprompt = "";
        if(StringUtils.isNotEmpty(type) && "onlygoal".equals(type)){
            String kpiTarget = getGoalByPro(params);
            result.put("kpi_target",kpiTarget);
            result.put("success",true);
            return result;
        }
        String tablecode = PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO;
        if(StringUtil.isNullOrEmpty(procode)){//新增时，项目编码为空
            result.put("aiprompt","");
            result.put("error","项目编码为空");
            result.put("success",false);
            return result;
        }
        if(PerfUtil.getIS_HUBEI()){
            Map<String, Object> proMap = aiRecoindexBO.getDataMap(tablecode, "pro_code='" + procode + "'");
            String proguid = (String)proMap.get("pro_id");
            aiprompt = "项目名称："+proMap.get("pro_name")+"，";
            if(!StringUtil.isNullOrEmpty(proMap.get("pro_desc"))){
                aiprompt += "项目概述："+proMap.get("pro_desc")+"，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("v_col25"))){
                aiprompt += "立项依据："+proMap.get("v_col25")+"，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("pro_term"))){
                aiprompt += "项目期限："+proMap.get("pro_term")+"年，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("dept_name"))){
                aiprompt += "部门："+proMap.get("dept_name")+"，";
            }
            List<Map<String, Object>>  proEstMapList = aiRecoindexBO.getDatas("V_PM_PERF_ESTAGG", yearflag.equals("1") ? "proguid='" + proguid + "'" : "proguid='" + proguid + "' and year ='" + CommonUtil.getYear() + "'",null);
            if(proEstMapList.size()>0){
                Map<String, Object> proEstMap = proEstMapList.get(0);
                aiprompt += "项目测算依据："+proEstMap.get("est_content")+"，";
            }else if(yearflag.equals("0")){
                aiprompt += "项目测算依据：本年度无测算依据，";
            }else{
                aiprompt += "项目测算依据：无测算依据，";
            }

        }else if (PerfUtil.getIsGuangXi()){
            Map<String, Object> proMap = aiRecoindexBO.getDataMap(tablecode, "pro_code='" + procode + "'");
            aiprompt = "项目名称："+proMap.get("pro_name")+"，";
            if(!StringUtil.isNullOrEmpty(proMap.get("pro_term"))){
                aiprompt += "项目期限："+proMap.get("pro_term")+"年，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("agency_name"))){
                aiprompt += "单位："+proMap.get("agency_name")+"，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("dept_name"))){
                aiprompt += "部门："+proMap.get("dept_name")+"，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("pro_desc"))){
                aiprompt += "项目概述："+proMap.get("pro_desc")+"，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("parent_pro_name"))){
                aiprompt += "一级项目名称："+proMap.get("parent_pro_name")+"，";
            }
            String kpiTarget = getGoalByPro(params);
            if(!StringUtil.isNullOrEmpty(kpiTarget)){
                aiprompt += (yearflag.equals("1") ? "总体绩效目标：" : "本年度绩效目标：") + kpiTarget+"，";
            }
        } else {
            Map<String, Object> proMap = aiRecoindexBO.getDataMap(tablecode, "pro_code='" + procode + "'");
            params.put("proguid",proMap.get("pro_id"));
            aiprompt = "项目名称："+proMap.get("pro_name")+"，";
            if(!StringUtil.isNullOrEmpty(proMap.get("pro_bases"))){
                aiprompt += "立项依据："+proMap.get("pro_bases")+"，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("pro_desc"))){
                aiprompt += "项目内容："+proMap.get("pro_desc")+"，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("pro_term"))){
                aiprompt += "项目期限："+proMap.get("pro_term")+"年，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("v_col7"))){
                aiprompt += "测算依据及说明："+proMap.get("v_col7")+"，";
            }
            if(!StringUtil.isNullOrEmpty(proMap.get("dept_name"))){
                aiprompt += "部门："+proMap.get("dept_name")+"，";
            }
            String kpiTarget = getGoalByPro(params);
            if(!StringUtil.isNullOrEmpty(kpiTarget)){
                aiprompt += (yearflag.equals("1") ? "总体绩效目标：" : "本年度绩效目标：") + kpiTarget+"，";
            }
        }
        result.put("aiprompt",aiprompt);
        result.put("success",true);
        return result;
    }

    public String getGoalByPro(HashMap<String, Object> params){
        String procode = (String) params.get("procode");
        String pro_id = (String) params.get("proguid");
        String yearflag = (String) params.get("yearflag");
        Map<String, Object> kpiTargetMap;
        if(StringUtils.isNotEmpty(yearflag) && yearflag.equals("1")){
            kpiTargetMap = aiRecoindexBO.getDataMap("PM_PERF_GOAL_INFO", "mainguid='" + pro_id + "' and yearflag = '1' and province ='" + SecureUtil.getUserSelectProvince() + "' ");
        }else {
            kpiTargetMap = aiRecoindexBO.getDataMap("V_PM_PERF_GOAL_INFO", "pro_code='" + procode + "' and yearflag = '0' ");
        }
        String kpi_target = (String) kpiTargetMap.get("kpi_target");
        return  kpi_target;
    }

    public Map<String, Object> getAIRecoindexDatas(HashMap<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            remp = aiRecoindexBO.getAIRecoindexDatas(params);
            remp.put("msg", "Y");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
            remp.put("msg", e.getMessage());
        }
        return remp;
    }

    /**
     * 保存新的实时辅助审核结果
     * @param params --
     * @return --
     */
    public Map<String, Object> saveNewAIRecoindexDatas(HashMap<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            remp = aiRecoindexBO.saveNewAIRecoindexDatas(params);
            remp.put("msg", "Y");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
            remp.put("msg", e.getMessage());
        }
        return remp;
    }

}
