/**
 * @Title: PrjIndexService.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-2-11  GM
 */

package gov.mof.fasp2.pmkpi.adjust.index;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexService
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlongtu.cn">GM</a>于 2020-2-11 上午10:51:52
 */
public class AdjustIndexEditService extends PmkpiService {
    /**
     * 初始化加载页面.
     * <p>Title: loadComponent</p>
     * <p>Description: </p>
     * @param request -- 请求
     * @param response -- 响应
     * @param config -- 配置
     * @throws AppException
     * @see gov.mof.fasp2.buscore.framework.component.AbstractComponentService#loadComponent(HttpServletRequest, HttpServletResponse, Map)
     */
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String sindex = request.getParameter("sindex");
        String modguid = request.getParameter("modguid");
        String upguid = request.getParameter("upguid");
        String type = request.getParameter("type");
        String fromtype = request.getParameter("fromtype");
        config.put("sindex", sindex); //二级指标
        config.put("upguid", upguid); //新增选择的行的guid
        config.put("modguid", modguid); //修改的三级指标
        config.put("type", type); //操作类型
        config.put("fromtype",fromtype); //来源树级表还是合并表
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("signs",signs);//计算符号
        List<DicRangeDTO> datatype = dss.getRangesByWhereSql("PMKPIDATATYPE", "");
        config.put("datatype",datatype);//数据类型
        return config;
    }
}
