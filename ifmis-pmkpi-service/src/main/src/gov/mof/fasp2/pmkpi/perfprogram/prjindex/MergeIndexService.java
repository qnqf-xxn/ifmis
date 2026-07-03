package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Log;
import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2021/1/26  gaoming
 */
public class MergeIndexService extends PmkpiService {

    private final static Log logger = LogFactory.getLog(MergeIndexService.class);

    private MergeIndexBO mergeIndexBO;

    /**
     * 注入BO.
     * @param mergeIndexBO
     */
    public void setMergeIndexBO(MergeIndexBO mergeIndexBO) {
        this.mergeIndexBO = mergeIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        //String proguid = request.getParameter("mainguid")== null ? request.getParameter("projId") : request.getParameter("mainguid");
        //String viewtype = request.getParameter("viewtype");
        /*String saveAgency = request.getParameter("saveAgency"); //单位
        String busguid = request.getParameter("busguid");//审核定义guid
        String ProCat = "3";
        String ISXZZD = "1";
        String PROBUSICODE = "121212";
        String setyear = "2022";
        String admdiv = "520000000";
        String usercode = "bgt_101001";*/

        ////////////////////////////////////
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String noreadonly = request.getParameter("noreadonly") == null ? "" : request.getParameter("noreadonly"); //用于区分录入还是查看
        String proguid = request.getParameter("itemid");
        String ProCat = request.getParameter("ProCat"); //项目类别 1 人员类 3共用经费 4 运转类其他 5 特定目标类
        String PROBUSICODE = request.getParameter("PROBUSICODE"); //项目编码
        String saveAgency = request.getParameter("saveAgency"); //单位
        String busguid = request.getParameter("busguid");//审核定义guid
        ///////////////end;
        String state = request.getParameter("state"); //1新增2修改，3查看
        //String isbefore = request.getParameter("isbefore");//1事前显示，0事前不显示
        String isbefore = (String) config.get("isbefore");
        String ISXZZD = isbefore;
        String viewtype = "add";
        if (("1".equals(showtab) || "3".equals(showtab)) && !"1".equals(noreadonly)){ //预算编制传递过来的是类别编码
            Map<String, String> map = new HashMap<>();
            map.put("21", "3");
            map.put("22", "4");
            map.put("3", "5");
            String procatid = map.get(ProCat);
            if(!StringUtil.isEmpty(procatid)){
                ProCat = procatid;
            }
        }
        if ("3".equals(state) || "1".equals(ProCat) || "3".equals(ProCat) || StringUtil.isEmpty(noreadonly)) {
            viewtype = "query";
        }
        if ("0".equals(ISXZZD) || "1".equals(ProCat) || "3".equals(ProCat)) {
            isbefore = "0";
        }
        logger.info("proguid="+proguid);
        logger.info("ProCat="+ProCat);
        logger.info("PROBUSICODE="+PROBUSICODE);
        String isedittotal = request.getParameter("isedittotal");//总体是否可编辑 1不可编辑
        String tempatecode = request.getParameter("tempatecode");//导出模板code
        String setyear = request.getParameter("setyear");//导出模板code
        String admdiv = request.getParameter("admdiv");//导出模板code
        String usercode = request.getParameter("usercode");//导出模板code
        config.put("isbefore",isbefore);
        config.put("proguid", proguid);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("isedittotal", isedittotal);
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("busguid", busguid);
        config.put("showtab", showtab); //指标页签显示
        config.put("procat", ProCat); //项目类别
        config.put("isxzzd",ISXZZD);//是否新增项目
        config.put("tempatecode",tempatecode);
        config.put("noreadonly",noreadonly); //查看页面还是编辑页面.
        config.put("setyear",setyear);
        config.put("admdiv",admdiv);
        config.put("ISXZZD",ISXZZD);
        config.put("usercode",usercode);
        HashMap<String,Object> param = new HashMap<String,Object>();
        param.put("proguid",proguid);
        param.put("showtab",showtab);
        param.put("isbefore",isbefore);
        param.put("procat",ProCat);
        config.put("indexdata", this.findAllIndex(param));
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        //List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        //List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE","elementcode='KPIVALNOTAPP'");//添加不适用
        //config.put("kpicalnotapply",kpicalnotapply);
        config.put("signs",signs);//计算符号
        //config.put("kpivals",kpivals);//定量其他
        config.put("state", state);
        config.put("prjindexcoldatas", mergeIndexBO.getCols("/pmkpi/program/report/treeindex"));
        return config;
    }

    /**
     * 查询项目全部的指标数据.
     * @param parms -- 前端参数.
     * @return -- list.
     */
    public Map<String, Object> findAllIndex(HashMap<String,Object> parms) throws AppException {
        return mergeIndexBO.findAllIndex(parms);
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
            rs = mergeIndexBO.savePrjTreeIndex(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
