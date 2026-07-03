package gov.mof.fasp2.pmkpi.evaluation.dept.result;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluation.dept.audit.DeptAuditBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class DeptResultBO extends PmkpiBO {
    private DeptResultDAO deptResultDAO;

    public void setDeptResultDAO(DeptResultDAO deptResultDAO) {
        this.deptResultDAO = deptResultDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String type = (String) sqlmap.get("type"); //项目调整选择项目
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String columncode = "agencyguid";
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.* from ").append(deptResultDAO.PERF_TABLE_DEPTEVAL).append(" t where t.bustype='").append(lefttabtype).append("' ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null);
        if (!StringUtils.isEmpty(wheresql)){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtils.isEmpty(tablesql)){
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtils.isEmpty(tabfilter)){
            returnsql.append(" and ").append(tabfilter);
        }
        if (StringUtils.isEmpty(type)) {
            String wfsql = this.getWfSql(tabcode, workflow);
            if (!StringUtils.isEmpty(wfsql)) {
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        }
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, deptResultDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode="v_perf_t_deptevaluation";
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='" + bustype + "' ";
        return deptResultDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String busguid = (String) params.get("busguid");
        String bustype = (String) params.get("bustype");
        this.workflow(actioncode, workflow, remark, deptResultDAO.PERF_TABLE_DEPTEVAL, datas);
        if (actioncode != null && "cancelaudit".equals(actioncode)) {
            deptResultDAO.saveAll(datas, deptResultDAO.PMKPI_TABLE_TMP_GUIDS);
            String wheresql = " exists (select 1 from " + deptResultDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid) ";
            deptResultDAO.delDatas("v_perf_expertreview", wheresql);
            wheresql = " exists (select 1 from " + deptResultDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.review) ";
            deptResultDAO.delDatas("perf_reviewintermediary", wheresql);
        }
        Map<String, Object> auditdata = this.auditdefine(datas, busguid, actioncode, null);
        //处理规范表数据
        DeptAuditBO deptAuditBO = (DeptAuditBO) ServiceFactory.getBean("pmkpi.evaluation.dept.audit.DeptAuditBOTX");
        deptAuditBO.updateDeptEvalTabelDatas(datas, actioncode);
        return auditdata;
    }

    /**
     * 获取数据
     * @param mainguid --
     * @return
     */
    public Map<String, Object> getDataById(String mainguid) {
        String sql = " proguid='" + mainguid + "'";
        return deptResultDAO.getDataMap("v_perf_t_evaluateaudit", sql);
    }

    /**
     * 保存审核意见
     * @param params
     * @return
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
        editinfo.put("guid", this.getCreateguid());
        editinfo.put("createtime", PerfUtil.getServerTimeStamp());
        editinfo.put("updatetime", PerfUtil.getServerTimeStamp());
        editinfo.put("creater", SecureUtil.getCurrentUserID());
        editinfo.put("province", SecureUtil.getUserSelectProvince());
        editinfo.put("year", SecureUtil.getUserSelectYear());
        editinfo.put("status", "1");
        editinfo.put("proguid", mainguid);
        editinfo.put("agencyguid", saveAgency);
        String wheresql = " t.proguid = '"+mainguid+"'";
        deptResultDAO.delDatas("V_PERF_T_EVALUATEAUDIT",wheresql);
        deptResultDAO.save(editinfo, "V_PERF_T_EVALUATEAUDIT");
        String remark = (String) editinfo.get("opinion");
        String ordinarytype = (String) editinfo.get("ordinarytype");
        List<Map<String, Object>> datas = this.getDatas(deptResultDAO.PERF_TABLE_DEPTEVAL, " guid='" + mainguid + "' ", "");
        return this.workflow(ordinarytype, workflow, remark, deptResultDAO.PERF_TABLE_DEPTEVAL, datas);
    }

    /**
     * 编辑页查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        List<Map<String, Object>> list = deptResultDAO.getDatas(tablecode, "t.guid = '" + mainguid + "'", null);
        if (list == null || list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

    /**
     * 评价成果修改
     *
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String) config.get("tablecode");
        String busguid = (String) config.get("busguid");
        String iswf = (String) config.get("iswf");
        String bustype = (String) config.get("bustype");
        String mainguid = (String) config.get("mainguid");
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        infodata.put("guid", mainguid);
        infodata.put("updatetime", PerfUtil.getServerTimeStamp());
        if(!mainguid.isEmpty()){
            List<Map<String, Object>> list = deptResultDAO.getDatas(tablecode, "t.guid = '" + mainguid + "'", null);
            if(list.size() > 0){
                uplist = list.stream()
                        .map(map -> {
                            Map<String, Object> newMap = new HashMap<>(map);
                            infodata.forEach(newMap::put);
                            return newMap;
                        })
                        .collect(Collectors.toList());
            }
            deptResultDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        return this.auditdefine(uplist, busguid, "perf", null);
    }

}
