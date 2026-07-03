package gov.mof.fasp2.pmkpi.perfprotrace.indextarget;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProIndexTargetService extends PmkpiService {
    private ProIndexTargetBO proIndexTargetBO;

    public void setProIndexTargetBO(ProIndexTargetBO proIndexTargetBO) {
        this.proIndexTargetBO = proIndexTargetBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev"); //项目一二三级
        String mainguid = request.getParameter("mainguid"); //主键
        String proguid = request.getParameter("projguid"); //调整项目guid
        String viewtype = request.getParameter("viewtype"); //页面状态，修改/查看
        String busguid = request.getParameter("busguid"); //审核定义的guid
        String taskguid = request.getParameter("taskguid"); //任务guid
        String saveAgency = request.getParameter("saveAgency"); //任务guid
        String bustype = request.getParameter("bustype"); //类型
        String procode = request.getParameter("procode");
        String qualtype = request.getParameter("qualtype"); //定性指标类型：1或空-下拉框（默认）；2-手动输入；
        if(StringUtils.isEmpty(qualtype)){
            qualtype = "1";
        }
        config.put("prolev",prolev);
        config.put("mainguid",mainguid);
        config.put("proguid",proguid);
        config.put("viewtype",viewtype);
        config.put("busguid",busguid);
        config.put("taskguid",taskguid);
        config.put("saveAgency",saveAgency);
        config.put("isTianjin",PerfUtil.getIsTianJin());
        config.put("isSX",PerfUtil.getSystemSet("isSX"));//山西环境
        config.put("indexvaldatas", PerfUtil.getSourceData(ProIndexTargetDAO.INDEX_DATASOURCE, null)); // indexval
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("signs",signs);//计算符号
        config.put("bustype", bustype);
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("procode", procode);
        config.put("qualtype", qualtype);

        config.put("ishebei", PerfUtil.getSystemSet("IS_HBEI"));//河北模式
        config.put("indexdevstandard", PerfUtil.getSystemSet("indexdevstandard"));//指标偏差度标准
        config.put("isGX", PerfUtil.getIsGuangXi());//广西参数
        config.put("isNX", PerfUtil.getIsNINGXIA());//宁夏参数

        String ismarkpro = request.getParameter("ismarkpro");
        config.put("ismarkpro", ismarkpro);
        config.put("taskstage", request.getParameter("taskstage"));
        return config;
    }

    /**
     * 查询指标集合.
     * @param params -- 参数集合.
     * @return treedatas.
     * @throws AppException --异常.
     * @throws
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        return proIndexTargetBO.getData(params);
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> savePrjIndex(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = proIndexTargetBO.saveData(params);
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
     * 获取申报的目标、指标.
     * @param params -- 参数集合.
     * @return treedatas.
     * @throws AppException --异常.
     * @throws
     */
    public Map<String, Object> getindexAndGoal(HashMap<String, Object> params) throws AppException {
        return proIndexTargetBO.getindexAndGoal(params);
    }
}
