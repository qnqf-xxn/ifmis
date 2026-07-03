package gov.mof.fasp2.pmkpi.common;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.component.AbstractComponentService;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PmkpiService  extends AbstractComponentService {
    protected Logger logger = LogFactory.getLog(this.getClass());

    private PmkpiBO pmkpiBO;

    private PmkpiBO getPmkpiBO() {
        if (pmkpiBO == null) {
            pmkpiBO = PerfServiceFactory.getPmkpiBO();
        }
        return pmkpiBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        config.put("tokenid", request.getParameter("tokenid"));// 登录凭证
        String menuid = request.getParameter("menuId");
        String tokenid = request.getParameter("tokenid");
        String selectyear = CommonUtil.getYear();
        String selectprovince = CommonUtil.getProvince();
        String userguid = SecureUtil.getCurrentUserID();
        if(StringUtils.isEmpty(menuid)){
            menuid = request.getParameter("menuguid");
        }
        config.put("menuid", menuid);
        config.put("tokenid", tokenid);
        config.put("appid", "pmkpi");
        config.put("year", selectyear);
        config.put("province", selectprovince);
        config.put("userguid", userguid);
        config.put("usertype", CommonUtil.getCurrentUser().getUsertype()); //0财政1单位 用户类型
        config.put("isShowTabPendingTask", PerfUtil.getSystemSet("isShowTabPendingTask"));
        config.put("isCheckSpace", PerfUtil.get_isCheckSpace()); //是否校验字段内空格
        config.put("isAH", PerfUtil.get_ISANHUI());
        config.put("isHUBEI", PerfUtil.getIS_HUBEI());
        config.put("isSHANXI", PerfUtil.getIsSx());
        config.put("queryYear", request.getParameter("queryYear"));//跨年查询查询年度
        config.put("queryProvince", request.getParameter("queryProvince"));//跨年查询查询区划
        config.put("isNINGXIA", PerfUtil.getIsNINGXIA());
        config.put("isYANSHI", PerfUtil.get_ISYANSHI());
        config.put("isGUANGXI", PerfUtil.getIsGuangXi());
        return config;
    }


    /**
     * 生成guid
     * @return
     */
    public String getCreateguid() throws AppException {
        return StringUtil.createUUID();
    }

    /**
     * 获取表中所有数据源数据.
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getDataSource(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        List<Map<String, Object>> cols = (List<Map<String, Object>>) params.get("cols");
        StringBuilder resultStr = new StringBuilder();
        for (Map<String, Object> col : cols) {
            String type = (String) col.get("type");
            if (type != null && "tree".equals(type)) {
                String column = StringUtil.isEmpty((String) col.get("columncode")) ? StringUtil.isEmpty((String) col.get("colcode")) ? "" : (String) col.get("colcode") : (String) col.get("columncode");
                resultStr.append("'").append(column.toUpperCase()).append("',");
            }
        }
        String result = resultStr.toString();
        result = result.substring(0, result.length() - 1);
        Map<String, Object> sourceMap = new HashMap<>();
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        String wheresql = " tablecode='" + tablecode.toUpperCase() + "' and dbcolumncode in(" + result + ") ";
        List<Map<String, Object>> list = getPmkpiBO().getDatas("fasp_t_diccolumn", wheresql , null);
        List<DicRangeDTO> datasource = null;
        for (Map<String, Object> map : list) {
            String dbcolumncode = (String) map.get("dbcolumncode");
            String csid = (String) map.get("csid");
            if (csid != null && !csid.isEmpty()) {
                datasource = dss.getRangesByDsGuid(csid);
                sourceMap.put(dbcolumncode.toLowerCase(), datasource);
            }
        }
        return sourceMap;
    }

    /**
     * 查询当前节点审核类型
     * @param workflow 工作流
     * @param prevwfstatus --当前数据状态
     */
    public Map<String, Object> queryAuditType(String workflow , String prevwfstatus) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        String audittype = "";
        String nodeguid = "";
        try {
            List<Map<String, Object>> auditmain = getPmkpiBO().queryAuditType(workflow, prevwfstatus);
            if (auditmain.size() > 0) {
                audittype = auditmain.get(0).get("audittype") + "";
                nodeguid = auditmain.get(0).get("nodeguid") + "";
            }
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            backmap.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        backmap.put("audittype", audittype);
        backmap.put("nodeguid", nodeguid);
        return backmap;
    }

    /**
     * 根据上一节点获取审核流程配置
     * @param workflow
     * @param prevwfstatus
     * @return
     */
    public Map<String, Object> queryPrevAuditType(String workflow , String prevwfstatus){
        Map<String, Object> backmap = new HashMap<String, Object>();
        String audittype = "";
        String nodeguid = "";
        try {
            List<Map<String, Object>> auditmain = getPmkpiBO().queryPrevAuditType(workflow, prevwfstatus);
            if (auditmain.size() > 0) {
                audittype = auditmain.get(0).get("audittype") + "";
                nodeguid = auditmain.get(0).get("nodeguid") + "";
            }
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            backmap.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        backmap.put("audittype", audittype);
        backmap.put("nodeguid", nodeguid);
        return backmap;
    }

    /**
     * 查询上一节点获取当前数据的结果状态
     * @param workflow  工作流id
     * @param wfstatus  当前数据状态
     * @return
     */
    public Map<String, Object> queryWfstatusType(String workflow , String wfstatus) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        boolean isconts = false;
        try {
            List<Map<String, Object>> listmap = getPmkpiBO().queryWfstatusType(workflow);
            logger.debug("==========审核流程节点=========="+listmap);
            if (listmap.size() > 0) {
                for (Map<String, Object> map : listmap) {
                    if (map.containsValue(wfstatus)){
                        isconts = true;
                    }
                }
            }
        } catch (PerfAppException e) {
            backmap = e.getRemap();
            backmap.put("code",e.getCode());
        } catch (AppException e) {
            backmap.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        backmap.put("isconts",isconts);
        return backmap;
    }

    /**
     * <p>页签数据必填校验</p >
     *
     * @author hw
     * @date 2022/10/27 15:58
     * @param
     */
    public Map<String, Object> checkTabPageData(HashMap<String, Object> params) throws AppException {
        return getPmkpiBO().checkTabPageData(params);
    }

    /**
     * 页面页签待办条数
     * @param menuConfig
     * @return
     * @throws AppException
     */
    public Map getTabPendingTask(HashMap menuConfig) throws AppException {
        return getPmkpiBO().getTabPendingTask(menuConfig);
    }

    /**
     * <p>问题整改-根据业务不同查询详情</p>
     *
     * @param --rectifyperfself-自评；rectifydepteval-部门评价；rectifyfinancialeval-财政评价；rectifytrace-监控；
     * @param --guid：问题整改主键；
     * @author hw
     * @date 2023/2/15 11:24
     */
    public List<Map<String, Object>> getProDetail(HashMap<String, Object> params) {
        return getPmkpiBO().getProDetail(params);
    }

    /**
     * 暂存
     * @param params
     * @return
     */
    public Map<String, Object> midsave(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<>();
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        try {
            rs = perfMidsaveBO.saveData(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
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
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
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

    /**
     * AI查询数据.
     * @param params -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public List<Map<String, Object>> getAIDatas(HashMap<String,Object> params) throws AppException {
        return getPmkpiBO().getAIDatas(params);
    }

    /**
     * 纳入ai辅助审核的任务队列
     * @param params
     * @return
     */
    public Map<String, Object> aiSupportAuditTask(HashMap<String,Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = getPmkpiBO().aiSupportAuditTask(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 导入数据处理.
     *
     * @param parms --
     * @return --
     */
    public List<Map<String, Object>> impDatas(HashMap<String, Object> parms) throws AppException {
        return getPmkpiBO().impDatas(parms);
    }

}
