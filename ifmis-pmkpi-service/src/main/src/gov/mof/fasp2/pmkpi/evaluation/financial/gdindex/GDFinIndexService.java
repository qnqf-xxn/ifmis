package gov.mof.fasp2.pmkpi.evaluation.financial.gdindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfprotrace.indextarget.ProIndexTargetBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class GDFinIndexService extends PmkpiService {
    private gov.mof.fasp2.pmkpi.evaluation.financial.gdindex.GDFinIndexBO GDFinIndexBO;
    private ProIndexTargetBO proIndexTargetBO;

    public void setGDFinIndexBO(gov.mof.fasp2.pmkpi.evaluation.financial.gdindex.GDFinIndexBO GDFinIndexBO) {
        this.GDFinIndexBO = GDFinIndexBO;
    }

    @Resource(name = "pmkpi.perfprotrace.indextarget.ProIndexTargetBO")
    public void setProIndexTargetBO(ProIndexTargetBO proIndexTargetBO) {
        this.proIndexTargetBO = proIndexTargetBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String projguid = request.getParameter("projguid");
        String procode = request.getParameter("procode");
        String bustype = request.getParameter("bustype");
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency");
        String busguid = request.getParameter("busguid");
        String isZJ = PerfUtil.getSystemSet("isZJ");
        String rationscore = StringUtils.isEmpty(request.getParameter("rationscore")) ? "1" : request.getParameter("rationscore");
        String qualscore = StringUtils.isEmpty(request.getParameter("qualscore")) ? "1" : request.getParameter("qualscore");
        String qualischeck = StringUtils.isEmpty(request.getParameter("qualischeck")) ? "1" : request.getParameter("qualischeck");
        config.put("isZJ", isZJ);
        config.put("busguid", busguid);
        config.put("mainguid", mainguid);
        config.put("projguid", projguid);
        config.put("procode", procode);
        config.put("bustype", bustype);
        config.put("viewtype", this.getISGD(procode)); //查询还是编辑
        config.put("saveAgency", saveAgency); //单位
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("dxzbsource", dss.getRangesByWhereSql("PMKPISELFINDEXVAL", ""));
        config.put("signs",signs);//计算符号
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("selfindexval", PerfUtil.getSystemSet("SELFINDEXVAL"));//完成情况编辑框，1、下拉，其他文本，默认为下拉
        config.put("rationscore", rationscore); //定量指标得分类型：1或null-不自动计算，可编辑；2-自动计算，可编辑；3-自动计算，不可编辑；（默认为null）
        config.put("qualscore", qualscore);     //定性指标得分类型：1或null-不自动计算，可编辑；2-自动计算，可编辑；3-自动计算，不可编辑；（默认为null）
        config.put("qualischeck", qualischeck); //是否校验定性指标区间： 1或null-是；2-否；（默认为null）
        String isCheckWeightGtZero = PerfUtil.getSystemSet("isCheckWeightGtZero");//是否校验指标权重大于0:1-是，其它-否；
        config.put("isCheckWeightGtZero", isCheckWeightGtZero);
        config.put("pagetype", request.getParameter("pagetype"));
        return config;
    }

    /**
     * 是否债券项目
     * @param
     * @return
     */
    public String getISGD(String procode) throws AppException {
        return GDFinIndexBO.getISGD(procode);
    }

    /**
     * 查询数据.
     *
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String, Object> parms) throws AppException {
        return GDFinIndexBO.getData(parms);
    }

    /**
     * 保存.
     *
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = GDFinIndexBO.saveIndex(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 预警规则.
     * @param params
     * @return
     */
    public String getWarn(HashMap<String, Object> params) {
        return proIndexTargetBO.getWarn(params);
    }

    /**
     * 评分规则.
     * @param params
     * @return
     */
    public String getScore(HashMap<String, Object> params) {
        return proIndexTargetBO.getWarn(params);
    }

    /**
     * 暂存.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> midsave(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            PerfMidsaveBO perfMidsaveBO = (PerfMidsaveBO) gov.mof.fasp2.buscore.framework.util.ServiceFactory.getBean("pmkpi.perfmidsave.PerfMidsaveBO");
            rs =  perfMidsaveBO.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 清除暂存
     * @param params
     * @return
     */
    public Map<String, Object> midsavedel(HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        PerfMidsaveBO perfMidsaveBO = (PerfMidsaveBO) gov.mof.fasp2.buscore.framework.util.ServiceFactory.getBean("pmkpi.perfmidsave.PerfMidsaveBO");
        try {
            rs = perfMidsaveBO.delTabData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
