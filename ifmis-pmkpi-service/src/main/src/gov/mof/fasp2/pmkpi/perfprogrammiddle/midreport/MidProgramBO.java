package gov.mof.fasp2.pmkpi.perfprogrammiddle.midreport;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class MidProgramBO extends PmkpiBO {

    private MidProgramDAO midProgramDAO;
    /**
     * 注入dao.
     * @param midProgramDAO --dao.
     * @throws
     */
    public void setMidProgramDAO(MidProgramDAO midProgramDAO) {
        this.midProgramDAO = midProgramDAO;
    }
    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see PmkpiBO#getVodSql(Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String)sqlmap.get("nodeguid"); //节点id.
        String saveagency = (String)sqlmap.get("saveAgency");
        if (nodeguid == null || nodeguid.isEmpty()) {
            nodeguid = saveagency;
        }
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1"); //数据权限
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t where ");
        StringBuffer wsql = new StringBuffer();
        if (wheresql != null && !wheresql.isEmpty()) {
            wsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            wsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            wsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            wsql.append(" and (").append(wfsql).append(") ");
        }
        returnsql.append(datarule);
        if (wsql.length() > 0) {
            returnsql.append(wsql);
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, nodeguid, midProgramDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }

    /**
     * 获取左侧树数据.
     * @param menuId -- 菜单.
     * @param prolev -- 几级项目.
     * @return --
     */
    @SuppressWarnings({"unchecked"})
    public Map<String, Object> getTreeData(String menuId,String prolev) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        if (prolev == null || prolev.isEmpty()) {
            throw new AppException("请在菜单配置是几级项目申报！");
        }
        String sql = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //根据权限查询
        leftconfig.put("datas", midProgramDAO.getLeftTree(sql));
        return leftconfig;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = "V_PERF_T_DEPTPERFMIDDECLARE";
        //审核定义
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        String tablecode = "V_PERF_T_DEPTPERFMIDDECLARE";
        try {
            List<String> procodes = new ArrayList();
            List<String> proguids = new ArrayList();
            List<String> guids = new ArrayList();
            deldatas.forEach(data -> {
                procodes.add((String) data.get("pro_code"));
                proguids.add((String) data.get("proguid"));
                guids.add((String) data.get("guid"));
            });
            String delsql = midProgramDAO.createInSql("guid", guids);
            midProgramDAO.delDatas(tablecode, delsql);
            if (procodes.size() > 0) {
                if (PerfUtil.getIsHbei()) {
                    delsql = midProgramDAO.createInSql("mainguid", proguids) + " and yearflag = '0'";
                } else {
                    // 增加年中追加项目删除条件，避免年中和预算编制同时填报后再删除年中追加项目导致年度绩效数据被删除，存在当年预算申报资金的项目年度绩效数据不删除
                    String whersql = " and yearflag = '0' and not exists (select 1 from V_PERF_PROJECT_BGTYEAR a where a.pro_code = t.pro_code)";
                    delsql = midProgramDAO.createInSql("pro_code", procodes) + whersql;
                }
                midProgramDAO.updateIsDeleteDatas(PerfConstant.PMKPI_VPM_GOAL_INFO, delsql);
                midProgramDAO.updateIsDeleteDatas(PerfConstant.PMKPI_VPM_INDICATOR, delsql);
            }
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
    
    /**
     * 保存调整数据
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveProgramadjust(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = "V_PERF_T_DEPTPERFMIDDECLARE";
        String workflow = (String)params.get("workflow");
        String bustype = (String) params.get("bustype");
        if (datas != null && datas.size() >= 0) {
            midProgramDAO.saveAll(datas, midProgramDAO.PMKPI_TABLE_TMP_GUIDS);
            String wheresql = "";
            //根据项目信息获取调整主单信息
            wheresql = " exists(select * from "+ PmkpiDAO.PMKPI_TABLE_TMP_GUIDS + " a where t.guid=a.guid)";
            List<Map<String, Object>> maindatas = midProgramDAO.getDatas(tablecode, wheresql, null);
            //删除临时表数据
            midProgramDAO.delDatas(PmkpiDAO.PMKPI_TABLE_TMP_GUIDS, null);
            midProgramDAO.saveAll(maindatas, midProgramDAO.PMKPI_TABLE_TMP_GUIDS);
            //获取项目最大调整次数
            List<Map<String, Object>> adjustList = new ArrayList<>();
            Map<String, Object> adjustMap = null;
            for (Map<String, Object> map : datas) {
                String agencyguid = (String) map.get("agencyguid");
                adjustMap = new HashMap<>();
                adjustMap.put("guid",  map.get("guid"));
                adjustMap.put("pro_code",map.get("pro_code"));
                adjustMap.put("pro_name",map.get("pro_name"));
                adjustMap.put("createtime", StringUtil.getSysDBDate());
                adjustMap.put("updatetime", StringUtil.getSysDBDate());
                adjustMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                adjustMap.put("province", SecureUtil.getUserSelectProvince());
                adjustMap.put("year", CommonUtil.getYear());
                adjustMap.put("wfid", workflow);
                adjustMap.put("agencyguid", agencyguid);
                if (bustype != null && "program".equals(bustype)) {
                    adjustMap.put("finintorgguid", map.get("mof_dep_code"));
                } else {
                    adjustMap.put("finintorgguid", map.get("finintorgguid"));
                }
                adjustMap.put("bustype", bustype);
                adjustList.add(adjustMap);
            }
            this.workflow("create", workflow, "", tablecode, adjustList);
        }
        return backMap;
    }

}
