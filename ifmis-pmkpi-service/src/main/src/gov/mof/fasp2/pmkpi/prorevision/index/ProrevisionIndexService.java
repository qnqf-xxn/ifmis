package gov.mof.fasp2.pmkpi.prorevision.index;

import gov.mof.fasp2.buscore.framework.exception.AppException;
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

public class ProrevisionIndexService extends PmkpiService {
    private ProrevisionIndexBO revisionIndexBO;

    public void setRevisionIndexBO(ProrevisionIndexBO revisionIndexBO) {
        this.revisionIndexBO = revisionIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String proguid = request.getParameter("proguid"); //调整项目guid
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency"); //单位
        String prolev = request.getParameter("prolev"); //项目等级
        String busguid = request.getParameter("busguid");//审核定义guid
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String isedittotal = request.getParameter("isedittotal");//总体是否可编辑 1不可编辑
        String procode = request.getParameter("procode");//项目编码
        String pro_name = request.getParameter("pro_name");//项目名称
        config.put("pro_name", pro_name);
        config.put("proguid", proguid);
        config.put("procode", procode);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("prolev", prolev); //项目等级123级项目
        config.put("isedittotal", isedittotal);
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("busguid", busguid);
        config.put("showtab", showtab); //指标页签显示
        HashMap<String,Object> param = new HashMap<String,Object>();
        param.put("proguid",proguid);
        param.put("showtab",showtab);
        param.put("procode", procode);
        String mainguid = request.getParameter("mainguid");
        config.put("mainguid", mainguid);
        param.put("mainguid",mainguid);
        config.put("indexdata", this.findAllIndex(param));
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE","elementcode='KPIVALNOTAPP'");//添加不适用
        config.put("kpicalnotapply",kpicalnotapply);
        config.put("signs",signs);//计算符号
        config.put("kpivals",kpivals);//定量其他
        config.put("isZJ", PerfUtil.getSystemSet("isZJ"));
        return config;
    }

    /**
     * 查询项目全部的指标数据.
     * @param parms -- 前端参数.
     * @return -- list.
     */
    public Map<String, Object> findAllIndex(HashMap<String,Object> parms) throws AppException {
        return revisionIndexBO.findAllIndex(parms);
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
            rs = revisionIndexBO.savePrjTreeIndex(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
