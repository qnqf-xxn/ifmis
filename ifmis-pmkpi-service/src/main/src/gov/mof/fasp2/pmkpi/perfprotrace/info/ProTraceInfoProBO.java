package gov.mof.fasp2.pmkpi.perfprotrace.info;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceInfoProBO extends PmkpiBO {
    private ProTraceInfoProDAO proTraceInfoProDAO;

    public void setProTraceInfoProDAO(ProTraceInfoProDAO proTraceInfoProDAO) {
        this.proTraceInfoProDAO = proTraceInfoProDAO;
    }

    /**
     * 查询项目信息
     * @param params --项目guid
     * @return
     */
    public Map<String, Object> getEditInfo(HashMap<String, Object> params)  throws AppException {
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode");
        String bustype = (String) params.get("bustype");
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            proTraceInfoProDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String tablecode = "";
        StringBuffer wheresql = new StringBuffer();
        if (PerfUtil.getIsHbei() || "dept".equals(bustype) || "depttrace".equals(bustype)) {
            wheresql.append(" guid = '").append(proguid).append("'");
        } else {
            wheresql.append(" pro_code = '").append(procode).append("'");
        }
        if ("depttrace".equals(bustype)) {
            if(PerfUtil.getIsSx()){
                tablecode = proTraceInfoProDAO.PMKPI_TABLE_SXDEPTPERFDECLARE;
            }else{
                tablecode = proTraceInfoProDAO.PMKPI_TABLE_DEPTPERFDECLARE;
            }
        } else {
            tablecode = proTraceInfoProDAO.PMKPI_TABLE_PROJECT_INFO;
        }
        return proTraceInfoProDAO.getDataMap(tablecode, wheresql.toString());
    }

    /**
     * 获取监控基本信息
     * @return
     */
    public Map<String, Object> getTraceinfo(HashMap<String, Object> params) {
        String mainguid = (String) params.get("mainguid");
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            proTraceInfoProDAO.setYearAndProvince(queryYear, queryProvince);
        }
        return proTraceInfoProDAO.getDataMap(ProTraceManageDAO.PERF_TABLE_TRACEMANAGE, " guid=?", new String[]{mainguid});
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) throws AppException {
        String busguid = (String) config.get("busguid");
        String workflow = (String) config.get("workflow");
        Map<String, Object> traceMap = this.getTraceinfo(config);
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        Map<String, Object> editdata = (Map<String, Object>) config.get("editdata");
        String fillman = (String) editdata.get("fillman"); //填报人
        String fillcontacttype = (String) editdata.get("fillcontacttype"); //填报人联系方式
        traceMap.put("fillman",fillman);
        traceMap.put("fillcontacttype",fillcontacttype);
        traceMap.putAll(infodata);
        String wfid = (String) traceMap.get("wfid");
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(traceMap);
        if (StringUtil.isEmpty(wfid)) {
            this.workflow("createnosave", workflow, "", ProTraceManageDAO.PERF_TABLE_TRACEMANAGE, l);
        } else {
            proTraceInfoProDAO.update(traceMap, ProTraceManageDAO.PERF_TABLE_TRACEMANAGE);
        }
        return this.auditdefine(l, busguid,"perf", null);
    }

}
