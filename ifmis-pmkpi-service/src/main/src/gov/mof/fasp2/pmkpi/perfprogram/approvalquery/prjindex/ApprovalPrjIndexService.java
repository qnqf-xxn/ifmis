package gov.mof.fasp2.pmkpi.perfprogram.approvalquery.prjindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2021/1/26  gaoming
 */
public class ApprovalPrjIndexService extends PmkpiService {

    private ApprovalPrjIndexBO approvalPrjIndexBO;

    public void setApprovalPrjIndexBO(ApprovalPrjIndexBO approvalPrjIndexBO) {
        this.approvalPrjIndexBO = approvalPrjIndexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proguid = request.getParameter("mainguid") == null ? request.getParameter("projId") : request.getParameter("mainguid");
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency"); //单位
        String busguid = request.getParameter("busguid");//审核定义guid
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String tempcode = request.getParameter("tempcode");//内置模板编码
        String isedittotal = request.getParameter("isedittotal");//总体是否可编辑 1不可编辑
        String procode = request.getParameter("pro_code");
        if (StringUtil.isEmpty(procode)) {
            procode = request.getParameter("procode"); //年中追加绩效目标填报发生调整的项目，无调整后guid
        }
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("tempcode",tempcode);
        config.put("isedittotal", isedittotal);
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("busguid", busguid);
        config.put("showtab", showtab); //指标页签显示
        HashMap<String,Object> param = new HashMap<String,Object>();
        param.put("proguid",proguid);
        param.put("showtab",showtab);
        param.put("tempcode",tempcode);
        param.put("frametype", config.get("frametype"));
        param.put("procode", procode);
        config.put("indexdata", this.findAllIndex(param));
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> kpivals = dss.getRangesByWhereSql("KPIVALSOURCE", "elementcode='KPIVALSOURCE'"); //合肥添加的定量（其他）
        List<DicRangeDTO> kpicalnotapply = dss.getRangesByWhereSql("KPIVALSOURCE","elementcode='KPIVALNOTAPP'");//添加不适用
        config.put("kpicalnotapply",kpicalnotapply);
        config.put("signs",signs);//计算符号
        config.put("kpivals",kpivals);//定量其他
        config.put("proguid", proguid);
        config.put("procode", procode);
        config.put("indexIsAddrow", PerfUtil.getIndexIsAddRow());
        return config;
    }

    /**
     * 查询项目全部的指标数据.
     * @param parms -- 前端参数.
     * @return -- list.
     */
    public Map<String, Object> findAllIndex(HashMap<String,Object> parms) throws AppException {
        return approvalPrjIndexBO.findAllIndex(parms);
    }
}
