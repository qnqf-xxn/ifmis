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
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ClassName: PrjIndexService
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-2-11 上午10:51:52
 */
public class RefindiIndexService extends PmkpiService {
    /**
     * 注入bo.
     */
    private PrjIndexBO prjIndexBO;
    
    /**
     * 注入bo.
     * @param prjIndexBO -- bo.
     * @throws
     */
    public void setPrjIndexBO(PrjIndexBO prjIndexBO) {
        this.prjIndexBO = prjIndexBO;
    }
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
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String sindex = request.getParameter("sindex");
        String guid = request.getParameter("guid");
        String prolev = request.getParameter("prolev");
        String saveAgency = request.getParameter("saveAgency");
        String fromtype = request.getParameter("fromtype");
        String isadjust = request.getParameter("isadjust");//是否调整
        String showtab = request.getParameter("showtab");//页签展示，1总+年 2总 3年
        String proguid = request.getParameter("proguid");//项目guid
        String fundguid = request.getParameter("fundguid");//项目guid

        config.put("sindex", sindex); //二级指标
        config.put("guid", guid); //选择的行
        config.put("prolev", prolev);
        config.put("saveAgency", saveAgency);
        config.put("fromtype",fromtype); //来源树级表还是合并表
        //计算符号
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql("PMKPIZBXS", "");
        List<DicRangeDTO> standards = dss.getRangesByWhereSql("INDEXSTANDARDS", "");
        config.put("signs",signs);//计算符号
        config.put("standards",standards);//绩效标准
        config.put("isZJ", PerfUtil.getSystemSet("isZJ"));
        config.put("isSX", PerfUtil.getSystemSet("isSX"));
        config.put("isHuBei", PerfUtil.getSystemSet("IS_HUBEI"));
        config.put("isadjust", isadjust);
        config.put("showtab", showtab);
        config.put("proguid", proguid);
        config.put("fundguid", fundguid); //项目测算GUID

        List<DicRangeDTO> ind = dss.getRangesByWhereSql("PMKPIFRAME", "");
        config.put("indmap",ind);//指标层次分类
        config.put("menuid", "pmkpiprogramrecoindexhide");
        return config;
    }
    
    /**
     * 查询案例与模板左侧树.
     * @param config -- config.
     * @return
     * @throws AppException --异常
     * @throws
     */
    public Map finTreeData(HashMap config) throws AppException{       
        return prjIndexBO.finTreeDataNew(config);
    }
    
    /**
     * 查询案例或模板明细.
     * @param params -- 参数.
     * @return remp.
     * @throws AppException --自定义异常.
     * @throws
     */
    public Map<String, Object> findTableData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            remp = prjIndexBO.findTableDataNew(params);
            remp.put("msg", "Y");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
            remp.put("msg", e.getMessage());
        }
        return remp;
    }

    /**
     * 案例目标引用保存.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> saveGoal(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            prjIndexBO.saveGoal(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
