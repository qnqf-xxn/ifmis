package gov.mof.fasp2.pmkpi.evaluation.financial.deptfill;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmDAO;
import gov.mof.fasp2.pmkpi.evaluation.financial.result.ResultBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptfillBO extends PmkpiBO {
    private DeptfillDAO deptfillDAO;

    public void setDeptfillDAO(DeptfillDAO deptfillDAO) {
        this.deptfillDAO = deptfillDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        //String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        //String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        //String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String type = (String) sqlmap.get("type"); //项目调整选择项目
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String columncode = "agencyguid";
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.* from ").append(ProConfirmDAO.PERF_TABLE_PROCONFIRM).append(" t where t.bustype='").append(lefttabtype).append("' ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
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
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, deptfillDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }


    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode="v_perf_t_finevaluation";
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='" + bustype + "' ";
        return deptfillDAO.getLeftTree(tablecode, datarule);
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
        this.workflow(actioncode, workflow, remark, ProConfirmDAO.PERF_TABLE_PROCONFIRM, datas);
        //处理规范表数据
        ResultBO resultBO = (ResultBO) PerfServiceFactory.getBean("pmkpi.evaluation.financial.ResultBOTX");
        resultBO.updateDeptEvalTabelDatas(datas, actioncode);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String bustype = (String)params.get("bustype");
        String wheresql = " a.mainguid = '" + mainguid + "' and a.tempguid = t.guid where t.bustype='" + bustype + "'";
        List<Map<String, Object>> list = deptfillDAO.getDeptScoreDatas(wheresql,mainguid,bustype+"deptscore");
        wheresql = " t.mainguid = '" + mainguid + "' and t.isdeptadd = '1'";
        list.addAll(deptfillDAO.getDataFile("v_perf_t_deptscore", wheresql, "order by ordernum",bustype+"deptscore",mainguid));
        backMap.put("data", list);
        return backMap;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = "v_perf_t_deptscore";
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String proguid = (String) params.get("proguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> updatas = new ArrayList<>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        List<Map<String, Object>> list = new ArrayList<>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            String isedit = (String) map.get("isedit");
            if ((rowtype != null && "add".equals(rowtype)) || (isedit != null && "1".equals(isedit))) {
                map.put("tempguid", map.get("guid"));
                map.put("proguid", proguid);
                map.put("mainguid", mainguid);
                map.put("status", 1);
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getCurrentUser().getProvince());
                map.put("agencyguid", saveAgency);
                map.put("year", CommonUtil.getYear());
                map.put("ordernum", i);
                if ("add".equals(rowtype)) {
                    map.put("isdeptadd", 1);
                }else{
                    map.put("guid", this.getCreateguid());
                }
                i++;
                list.add(map);
            } else {
                updatas.add(map);
            }
        }
        String delsql = " mainguid='" + mainguid + "' and nvl(isdeptadd,'0') <> 1 ";
        deptfillDAO.delDatas(tablecode, delsql);
        deptfillDAO.saveAll(list, tablecode);
        if (updatas.size()>0) {
            deptfillDAO.updateAll(updatas, tablecode);
        }
        if (deldatas.size()>0) {
            deptfillDAO.saveAll(deldatas, deptfillDAO.PMKPI_TABLE_TMP_GUIDS);
            delsql = " exists(select 1 from " + deptfillDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            deptfillDAO.delDatas(tablecode, delsql);
        }
        return this.auditdefine(list, busguid,"perf", null);
    }



}
