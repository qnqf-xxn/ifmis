package gov.mof.fasp2.pmkpi.perfprotrace.fund;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TjProFundService extends PmkpiService {
    private TjProFundBO tjProFundBO;

    public void setTjProFundBO(TjProFundBO tjProFundBO) {
        this.tjProFundBO = tjProFundBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev"); //项目一二三级
        String mainguid = request.getParameter("mainguid"); //主键
        String proguid = request.getParameter("projguid"); //调整项目guid
        String procode = request.getParameter("procode"); //项目编码
        String viewtype = request.getParameter("viewtype"); //页面状态，修改/查看
        String busguid = request.getParameter("busguid"); //审核定义的guid
        String taskguid = request.getParameter("taskguid"); //任务guid
        String saveAgency = request.getParameter("saveAgency"); //任务guid
        String bustype = request.getParameter("bustype");//任务类型
        String isHbei = PerfUtil.getSystemSet("IS_HBEI");//河北资金取数
        String isZJ = PerfUtil.getSystemSet("isZJ");//浙江资金取数
        String isSX = PerfUtil.getSystemSet("isSX");//山西资金取数
        config.put("prolev",prolev);
        config.put("mainguid",mainguid);
        config.put("proguid",proguid);
        config.put("viewtype",viewtype);
        config.put("busguid",busguid);
        config.put("taskguid",taskguid);
        config.put("saveAgency",saveAgency);
        config.put("bustype",bustype);
        config.put("isHbei",isHbei);
        config.put("procode", procode);
        config.put("isZJ", isZJ);
        config.put("isSX", isSX);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public List<Map<String, Object>> getDatas(HashMap<String,Object> parms) throws AppException {
        return tjProFundBO.getDatas(parms);
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = tjProFundBO.saveData(params);
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
        return tjProFundBO.getWarn(params);
    }
}
