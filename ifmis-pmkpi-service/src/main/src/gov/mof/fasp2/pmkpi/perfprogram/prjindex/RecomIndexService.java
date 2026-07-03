/**
 * @Title: PrjIndexService.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-2-11  GM
 */

package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.setting.indexauth.IndexAuthBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: PrjIndexService
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlongtu.cn">GM</a>于 2021-2-11 上午10:51:52
 */
public class RecomIndexService extends PmkpiService {
    /**
     * 注入bo.
     */
    private PrjIndexBO prjIndexBO;
    
    /**
     * 注入bo.
     * @param prjIndexBO -- bo.
     * @throws
     */
    public void setPrjIndexBO(PrjIndexBO prjIndexBO) {
        this.prjIndexBO = prjIndexBO;
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
     * @see gov.mof.fasp2.buscore.framework.component.AbstractComponentService#loadComponent(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.util.Map)
     */
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String sindex = request.getParameter("sindex");
        String guid = request.getParameter("guid");
        String prolev = request.getParameter("prolev");
        String saveAgency = request.getParameter("saveAgency");
        String fromtype = request.getParameter("fromtype");
        String isadjust = request.getParameter("isadjust");//是否调整
        String showtab = request.getParameter("showtab");//页签展示，1总+年 2总 3年
        String proguid = request.getParameter("proguid");//项目guid
        String fundguid = request.getParameter("fundguid");//项目guid
        String goalguid = request.getParameter("goalguid");//关联目标guid

        config.put("sindex", sindex); //二级指标
        config.put("guid", guid); //选择的行
        config.put("prolev", prolev);
        config.put("saveAgency", saveAgency);
        config.put("fromtype",fromtype); //来源树级表还是合并表
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> standards = dss.getRangesByWhereSql("INDEXSTANDARDS", "");
        config.put("signs",signs);//计算符号
        config.put("standards",standards);//绩效标准
        config.put("isZJ", PerfUtil.getSystemSet("isZJ"));
        config.put("isSX", PerfUtil.getSystemSet("isSX"));
        config.put("isHuBei", PerfUtil.getSystemSet("IS_HUBEI"));
        config.put("isJiangXI", PerfUtil.get_IsJiangXi() == true ? "1":"0");
        config.put("isadjust", isadjust);
        config.put("showtab", showtab);
        config.put("proguid", proguid);
        config.put("fundguid", fundguid); //项目测算GUID
        config.put("goalguid", goalguid);//关联目标guid

        List<DicRangeDTO> ind = dss.getRangesByWhereSql("PMKPIFRAME", "");
        config.put("indmap",ind);//指标层次分类

        List<Map<String, Object>> authData = prjIndexBO.getAuthData(SecureUtil.getUserSelectProvince());
        config.put("authData", authData);//指标授权信息
        config.put("isHebei", PerfUtil.getSystemSet("IS_HBEI"));
        config.put("menuid", "pmkpiprogramrecoindexhide");
        config.put("indsource", PerfUtil.getSourceData("PERFINDSOURCE", ""));

        //AI指标推荐逻辑 组装提示词
        String recomtype = request.getParameter("recomtype");//推荐类型
        if(!StringUtil.isNullOrEmpty(recomtype) && "AI".equals(recomtype)){
            String frametype = request.getParameter("frametype");//体系类型
            String plusprompt = request.getParameter("plusprompt");//页面追加的提示词
            String yearflag = request.getParameter("yearflag");//区分总体还是年度绩效
            config.put("frametype", frametype);
            config.put("plusprompt", plusprompt);
            config.put("isShowThink", PerfUtil.get_isShowAIThink());//是否显示AI思考过程，兼容无思考过程的的AI模型
            if(!StringUtil.isNullOrEmpty(frametype) && frametype.startsWith("PM")){//查询项目信息并组装提示词
                String procode = request.getParameter("procode");//项目code
                this.getAIprompt(config, procode, yearflag);
                config.put("apikey", request.getParameter("api_key"));
                config.put("apicode", request.getParameter("api_code"));
            }
        }
        return config;
    }

    public Map getAIprompt(Map config,String procode,String yearflag) throws AppException{
        String aiprompt = "";
            String tablecode = PmkpiDAO.PMKPI_TABLE_ALLPROJECT_INFO;
            if(StringUtil.isNullOrEmpty(procode)){//新增时，项目编码为空
                config.put("aiprompt", "");
            }else if(PerfUtil.getIsZJ()){
                Map<String, Object> proMap = prjIndexBO.getDataMap(tablecode, "pro_code='" + procode + "'");
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
                config.put("aiprompt", aiprompt);
            }else if(PerfUtil.getIS_HUBEI()){
                Map<String, Object> proMap = prjIndexBO.getDataMap(tablecode, "pro_code='" + procode + "'");
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
                List<Map<String, Object>>  proEstMapList = prjIndexBO.getDatas("V_PM_PERF_ESTAGG", yearflag.equals("1") ? "proguid='" + proguid + "'" : "proguid='" + proguid + "' and year ='" + CommonUtil.getYear() + "'",null);
                if(proEstMapList.size()>0){
                    Map<String, Object> proEstMap = proEstMapList.get(0);
                    aiprompt += "项目测算依据："+proEstMap.get("est_content")+"，";
                }else if(yearflag.equals("0")){
                    aiprompt += "项目测算依据：本年度无测算依据，";
                }else{
                    aiprompt += "项目测算依据：无测算依据，";
                }
                config.put("aiprompt", aiprompt);
            }
        return config;
    }
    
    /**
     * 查询案例与模板左侧树.
     * @param config -- config.
     * @return
     * @throws AppException --异常
     * @throws
     */
    public Map finTreeData(HashMap config) throws AppException{
        String tabcode = (String) config.get("tabcode");
        String selectedAuth = (String) config.get("selectedAuth");
        if(PerfUtil.getIsHbei() &&  "index".equals(tabcode) && selectedAuth!=null && !"00".equals(selectedAuth)){//接口获取共享指标左侧树节点
            IndexAuthBO indexAuthBO = (IndexAuthBO)PerfServiceFactory.getBean("pmkpi.setting.IndexAuthBOTX");
            return indexAuthBO.getHBAuthIndexTree(config);
        }if(PerfUtil.getIsGuangXi() && "case".equals(tabcode)){
            return prjIndexBO.finTreeDataNew(config);
        }else{
            return prjIndexBO.finTreeData(config);
        }
    }

    /**
     * 查询推荐指标共享指标库指标
     * @param config -- config.
     * @return
     * @throws AppException --异常
     * @throws
     */
    public Map getHBAuthIndex(HashMap config) throws AppException{
        IndexAuthBO indexAuthBO = (IndexAuthBO)PerfServiceFactory.getBean("pmkpi.setting.IndexAuthBOTX");
        return indexAuthBO.getHBAuthIndex(config);
    }

    /**
     * 查询案例或模板明细.
     * @param params -- 参数.
     * @return remp.
     * @throws AppException --自定义异常.
     * @throws
     */
    public Map<String, Object> findTableData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            String tabcode = (String) params.get("tabcode");
            if(PerfUtil.getIsGuangXi() && "case".equals(tabcode)){
                remp = prjIndexBO.findTableDataNew(params);
            }else{
                remp = prjIndexBO.findTableData(params);
            }
            remp.put("msg", "Y");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
            remp.put("msg", e.getMessage());
        }
        return remp;
    }

    /**
     * 案例目标引用保存.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> saveGoal(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            prjIndexBO.saveGoal(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
