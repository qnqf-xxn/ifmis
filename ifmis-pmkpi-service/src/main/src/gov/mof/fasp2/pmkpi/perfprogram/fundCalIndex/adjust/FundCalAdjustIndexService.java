/**
 * @Title: PrjIndexService.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.fundCalIndex.adjust;

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


public class FundCalAdjustIndexService extends PmkpiService {
    /**
     * fundCalIndexBO.
     */
    private FundCalAdjustIndexBO fundCalAdjustIndexBO;
    /**
     * 注入bo.
     * @param fundCalIndexBO -- bo.
     * @throws
     */
    public void setFundCalAdjustIndexBO(FundCalAdjustIndexBO fundCalAdjustIndexBO) {
        this.fundCalAdjustIndexBO = fundCalAdjustIndexBO;
    }
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
        String proguid = request.getParameter("projguid"); //调整项目guid
        String prolev = request.getParameter("prolev")== null ? request.getParameter("projtype") : request.getParameter("prolev");
        String procode = request.getParameter("procode");
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String isfundcal = request.getParameter("isfundcal");
        String busguid = request.getParameter("busguid");
        String mainguid = request.getParameter("mainguid");
        String bustype = request.getParameter("bustype"); //业务类型
        String saveAgency = request.getParameter("saveAgency");
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> datatype = dss.getRangesByWhereSql("PMKPIDATATYPE", "");
        config.put("proguid", proguid);
        config.put("prolev", prolev);
        config.put("procode", procode);
        config.put("showtab", showtab);
        config.put("isfundcal", isfundcal);
        config.put("busguid", busguid);
        config.put("mainguid", mainguid);
        config.put("bustype", bustype);
        config.put("saveAgency", saveAgency);
        config.put("datatype",datatype);//数据类型
        config.put("isZJ", PerfUtil.getSystemSet("isZJ"));

        return config;
    }

    /**
     * @description:
     * @param: 查询项目指标集合
     * @return:  tabComps
     * @author: zhangxutao
     * @date: 2021/9/1 16:58
     */
    public Map<String, Object> findIndex(HashMap<String, Object> params) throws AppException {
        Map<String, Object> tabComps = fundCalAdjustIndexBO.findYearIndexs(params);
        return tabComps;
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = fundCalAdjustIndexBO.save(parms);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
