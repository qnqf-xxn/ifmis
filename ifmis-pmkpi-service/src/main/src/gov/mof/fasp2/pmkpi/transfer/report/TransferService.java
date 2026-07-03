package gov.mof.fasp2.pmkpi.transfer.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
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

public class TransferService extends PmkpiService {

    private TransferBO transferBO;

    public void setTransferBO(TransferBO transferBO) {
        this.transferBO = transferBO;
    }

    private final static Logger logger = Logger.getLogger(TransferService.class);

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
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String proguid = "";
        String procode = request.getParameter("pro_code");
        String year = request.getParameter("year");
        String state = request.getParameter("state");
        if (StringUtil.isEmpty(procode)) {
            procode = request.getParameter("procode");
        }
        logger.error("--------项目编码-------------" + procode);
        String viewtype = request.getParameter("viewtype");
        /*if(StringUtil.isEmpty(viewtype) && !StringUtil.isEmpty(state) && "3".equals(state)){
            viewtype = "query";
        }*/
        logger.error("-------------viewtype-------------" + viewtype);
        String saveAgency = request.getParameter("saveAgency"); //单
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        String busguid = request.getParameter("busguid");//审核定义guid
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String isedittotal = request.getParameter("isedittotal");//总体是否可编辑 1不可编辑
        config.put("viewtype", viewtype);
        config.put("prolev", prolev); //项目等级123级项目
        config.put("busguid", busguid);
        config.put("showtab", showtab);
        HashMap<String,Object> param = new HashMap<String,Object>();
        //根据项目code反查当时的项目id
        String proSql = " t.pro_code ='" + procode + "'";
        List<Map<String, Object>> proInfo = transferBO.getDatas("v_perf_project_info", proSql, null);
        if (proInfo != null && !proInfo.isEmpty()) {
            proguid = (String) proInfo.get(0).get("guid");
            if (StringUtil.isEmpty(saveAgency)) {
                saveAgency = (String) proInfo.get(0).get("agency_code");
            }
        }
        param.put("proguid",proguid);
        param.put("showtab",showtab);
        param.put("procode", procode);
        param.put("year", year);
        config.put("proguid", proguid);
        config.put("state",state);//页面是否可修改 1新增 2修改，3查看
        config.put("goaldata", this.getAllGoal(param));
        config.put("isedittotal", isedittotal);
        config.put("procode", procode);
        //获取指标数据
        String tempcode = request.getParameter("tempcode");//内置模板编码
        config.put("tempcode",tempcode);
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        param.put("tempcode",tempcode);
        config.put("indexdata", this.findAllIndex(param));
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE","elementcode='KPIVALNOTAPP'");//添加不适用
        config.put("kpicalnotapply",kpicalnotapply);
        config.put("signs",signs);//计算符号
        config.put("kpivals",kpivals);//定量其他
        config.put("indexIsAddrow", PerfUtil.getIndexIsAddRow());
        config.put("saveAgency", saveAgency); //单位
        return config;
    }

    /**
     * 查询项目的目标数据.
     * @param parms -- 前端参数.
     * @return -- list.
     */
    public Map<String, Object> getAllGoal(HashMap<String,Object> parms) throws AppException {
        return transferBO.getAllGoal(parms);
    }

    /**
     * 查询项目指标数据
     * @param parms
     * @return
     * @throws AppException
     */
    public Map<String, Object> findAllIndex(HashMap<String,Object> parms) throws AppException {
        return transferBO.findAllIndex(parms);
    }

    /**
     * 绩效目标保存
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveGoal(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = transferBO.saveGoal(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询项目上年度指标数据
     * @param parms
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> lastYearIndex(HashMap<String,Object> parms) throws AppException {
        return transferBO.lastYearIndex(parms);
    }


    /**
     * 结转指标保存.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> saveIndex(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = transferBO.saveIndex(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询项目上年度目标数据
     * @param parms
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> lastYearGoal(HashMap<String,Object> parms) throws AppException {
        return transferBO.lastYearGoal(parms);
    }

}
