/**
 * @Title: PrjIndexService.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-2-11  GM
 */

package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

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
public class IndexLastService extends PmkpiService {
    /**
     * 注入bo.
     */
    private PrjIndexBO prjIndexBO;
    /**
     * bo.
     * @param prjIndexBO
     * @throws
     */
    public void setPrjIndexBO(PrjIndexBO prjIndexBO) {
        this.prjIndexBO = prjIndexBO;
    }
    /**
     * 注入bo.
     * @param indexRecomBO -- bo.
     * @throws
     */
    /**
     * 初始化加载页面.
     * <p>Title: loadComponent</p>
     * <p>Description: </p>
     * @param request -- 请求
     * @param response -- 响应
     * @param config -- 配置
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.buscore.framework.component.AbstractComponentService#loadComponent(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.util.Map)
     */
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String sindex = request.getParameter("sindex");
        String guid = request.getParameter("guid");
        String prolev = request.getParameter("prolev");
        String saveAgency = request.getParameter("saveAgency");
        String fromtype = request.getParameter("fromtype");
        String proguid = request.getParameter("proguid");
        String pagetype = request.getParameter("pagetype");
        String procode = request.getParameter("procode");
        String isadjust = request.getParameter("isadjust");//是否调整
        config.put("sindex", sindex); //二级指标
        config.put("guid", guid); //选择的行
        config.put("prolev", prolev);
        config.put("saveAgency", saveAgency);
        config.put("fromtype",fromtype); //来源树级表还是合并表
        config.put("proguid", proguid);
        config.put("pagetype", pagetype);
        config.put("procode", procode);
        config.put("isadjust", isadjust);
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        config.put("signs",signs);//计算符号
        String ismultipro = request.getParameter("ismultipro");
        config.put("ismultipro", ismultipro);
        return config;
    }
    
    public List<Map<String, Object>> getDeptGuid(String agencyguid){
    	return prjIndexBO.getDeptGuid(agencyguid);
    }
}
