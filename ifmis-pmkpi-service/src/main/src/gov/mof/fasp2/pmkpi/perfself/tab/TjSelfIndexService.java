package gov.mof.fasp2.pmkpi.perfself.tab;

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

public class TjSelfIndexService extends PmkpiService {

    private TjSelfIndexBO tjSelfIndexBO;

    public void setTjSelfIndexBO(TjSelfIndexBO tjSelfIndexBO) {
        this.tjSelfIndexBO = tjSelfIndexBO;
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
//        config.put("isSX",PerfUtil.getSystemSet("isSX"));//山西环境
//        config.put("indexvaldatas",selfIndexBO.getValData("protraceindex")); // indexval
        config.put("dxzbsource", PerfUtil.getSourceData("PMKPISELFINDEXVAL", null));
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("signs",signs);//计算符号
        config.put("bustype", bustype);
        config.put("ismergeindex", PerfUtil.getSystemSet("ismergeindex"));//指标值是否合并单位符号
        config.put("procode", procode);
        config.put("qualtype", qualtype);

        String rationscore = StringUtils.isEmpty(request.getParameter("rationscore")) ? "1" : request.getParameter("rationscore");
        String qualscore = StringUtils.isEmpty(request.getParameter("qualscore")) ? "1" : request.getParameter("qualscore");
        config.put("rationscore", rationscore); //定量指标得分类型：1或null-不自动计算，可编辑；2-自动计算，可编辑；3-自动计算，不可编辑；（默认为null）
        config.put("qualscore", qualscore);     //定性指标得分类型：1或null-不自动计算，可编辑；2-自动计算，可编辑；3-自动计算，不可编辑；（默认为null）
        config.put("selfindexval", PerfUtil.getSystemSet("SELFINDEXVAL"));//自评价完成情况编辑框，1、下拉，其他文本，默认为下拉

        return config;
    }


    /**
     * 查询主表目标数据.
     * @param parms -- 参数。
     * @return --
     */
    public Map<String, Object> getMainDatas(HashMap<String,Object> parms) throws AppException {
        return tjSelfIndexBO.getDeptMainDatas(parms);
    }


    /**
     * 根据主表记录查询子表指标数据.
     * @param parms -- 参数。
     * @return --
     */
    public Map<String, Object> getSubData(HashMap<String,Object> parms) throws AppException {
        return tjSelfIndexBO.getDeptSubData(parms);
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
            rs = tjSelfIndexBO.saveHbData(params);
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
        return tjSelfIndexBO.getWarn(params);
    }

    /**
     * 获取申报的目标、指标.
     * @param params -- 参数集合.
     * @return treedatas.
     * @throws AppException --异常.
     * @throws
     */
    public Map<String, Object> getindexAndGoal(HashMap<String, Object> params) throws AppException {
        return tjSelfIndexBO.getnewindexAndGoal(params);
    }
}
