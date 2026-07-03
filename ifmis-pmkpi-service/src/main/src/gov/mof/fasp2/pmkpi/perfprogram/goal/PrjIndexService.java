/**
 * @Title: PrjIndexService.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.goal;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: PrjIndexService
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:41:56
 */
public class PrjIndexService extends PmkpiService {
    /**
     * prjIndexBO.
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

        private final static Logger logger = Logger.getLogger(PrjIndexService.class);
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
        String selectbillguid = request.getParameter("selectbillguid");//调整前的guid
        String adjadd = request.getParameter("adjadd");//是否调整
        logger.error("--------是否调整-------------" + adjadd);
        logger.error("--------调整前的guid-------------"+ selectbillguid);
        logger.error("--------调整后的guid-------------"+ proguid);
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency"); //单
        String pdmsave = request.getParameter("pdmsave"); //单位
        String prolev = request.getParameter("prolev"); //项目等级
        String isprogramiframe = request.getParameter("isprogramiframe");//是否项目库嵌套
        String isedittotal = request.getParameter("isedittotal");//总体是否可编辑 1不可编辑
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String busguid = request.getParameter("busguid");//审核定义guid
        String isZJ = PerfUtil.getSystemSet("isZJ");
        String showall = request.getParameter("showall");  //项目库可以跨地区查询项目基本信息
        String dataprovince = request.getParameter("dataprovince");
        String procode = request.getParameter("pro_code")== null ? request.getParameter("procode") : request.getParameter("pro_code");
        String isnzzj = request.getParameter("isnzzj");  //是否年中追加项目
        if (pdmsave != null && "20".equals(pdmsave)) {
            proguid = request.getParameter("stagid");
        }
        config.put("isedittotal", isedittotal);
        config.put("showtab", showtab);
        config.put("proguid", proguid);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("prolev", prolev); //项目等级123级项目
        if (isprogramiframe == null || isprogramiframe.isEmpty()) {
            config.put("iframeurl", PerfUtil.getSystemSet("porgramurl_index"));
        }
        if("true".equals(isnzzj)){
            proguid = prjIndexBO.getProGuid(proguid, procode); // 年中追加调整终审项目获取调整后项目guid
        }
        HashMap<String,Object> param = new HashMap<String,Object>();
        param.put("proguid",proguid);
        param.put("pdmsave",pdmsave);
        param.put("showall",showall);
        param.put("dataprovince",dataprovince);
        List<Map<String, Object>> list = null;
        List<Map<String, Object>> goalList = new ArrayList<>();
        if (adjadd != null && "1".equals(adjadd)) {
            list = prjIndexBO.getGoalByGuid(proguid,pdmsave);
            if(list.size()<=0){
                list = prjIndexBO.getGoalByGuid(selectbillguid,pdmsave);
                //调整项目查询不存在数据，重新生成guid，解决项目库嵌套保存不刷新页面
                if (list != null && list.size() > 0) {
                    list.get(0).put("guid",prjIndexBO.getCreateguid());
                }
            }
        }else{
            //浙江年度绩效目标查询页面使用
            if("3".equals(showtab) && "1".equals(isZJ)){
                list = prjIndexBO.getGoalByCode(proguid,pdmsave);
            }else{
                list = prjIndexBO.getGoalByGuid(proguid,pdmsave);
            }
            goalList = prjIndexBO.getGoal(param);
        }
        config.put("goalinfo", goalList);
        config.put("isnzzj", isnzzj);
        config.put("editinfo", list);
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
//    public Map<String, Object> savePrjIndex(HashMap<String, Object> params) throws AppException {
//        Map<String, Object> rs = new HashMap<String, Object>();
//        try {
//            rs = prjIndexBO.saveData(params);
//        } catch (PerfAppException e) {
//            rs = e.getRemap();
//            rs.put("code",e.getCode());
//        } catch (AppException e) {
//            logger.error(e.getMessage(), e);
//        }
//        return rs;
//    }

}
