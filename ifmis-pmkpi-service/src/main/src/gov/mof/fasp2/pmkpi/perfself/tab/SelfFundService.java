package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:44 2020/8/24  chongdayong
 */
public class SelfFundService extends PmkpiService {
    private SelfFundBO selfFundBO;

    public void setSelfFundBO(SelfFundBO selfFundBO) {
        this.selfFundBO = selfFundBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String projguid = request.getParameter("projguid");
        String procode = request.getParameter("procode");
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency");
        String busguid = request.getParameter("busguid");
        String bustype = request.getParameter("bustype");
        String isHebei = PerfUtil.getSystemSet("IS_HBEI");//河北参数
        config.put("mainguid", mainguid);
        config.put("projguid", projguid);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency);
        config.put("busguid", busguid);
        config.put("bustype", bustype);
        config.put("procode", procode);
        config.put("isHebei", isHebei);
        config.put("isHubei", PerfUtil.getIS_HUBEI());
        String isSX = PerfUtil.getSystemSet("isSX");//山西参数
        config.put("isSX", isSX);
        config.put("isZJ", PerfUtil.getIsZJ());
        config.put("isAH", PerfUtil.get_ISANHUI());
        config.put("is_JiangXi",PerfUtil.get_IsJiangXi());
        config.put("isNINGXIA",PerfUtil.getIsNINGXIA());
        return config;
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
            rs = selfFundBO.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 查询预算执行情况.
     * @param parms -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> getPayDatas(HashMap<String,Object> parms) throws AppException {
        String isSX = PerfUtil.getSystemSet("isSX");
        String bustype = (String) parms.get("bustype");
        if("1".equals(isSX) && "dept".equals(bustype)){//山西部门整体资金分（按资金来源划分、按资金方向划分）两个表
            Map<String, Object> backMap = new HashMap<String, Object>();
            parms.put("bgtsource","1");
            Map<String, Object> rs1  = selfFundBO.getPayDatas(parms);
            backMap.put("data",rs1.get("data"));
            parms.put("bgtsource","2");
            parms.put("compconfigid","dirdatatable");
            Map<String, Object> rs2  = selfFundBO.getPayDatas(parms);
            backMap.put("data2",rs2.get("data"));
            backMap.put("hidButtons",rs1.get("hidButtons"));
            return backMap;
        }else{
            return selfFundBO.getPayDatas(parms);
        }
    }

    /**
     * 预警规则.
     * @param params
     * @return
     */
    public String getWarn(HashMap<String, Object> params) {
        return selfFundBO.getWarn(params);
    }

}
