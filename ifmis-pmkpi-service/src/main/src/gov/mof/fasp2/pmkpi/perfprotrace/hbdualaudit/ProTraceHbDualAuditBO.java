package gov.mof.fasp2.pmkpi.perfprotrace.hbdualaudit;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceHbDualAuditBO extends PmkpiBO {

    private ProTraceHbDualAuditDAO proTraceHbDualAuditDAO;

    public void setProTraceHbDualAuditDAO(ProTraceHbDualAuditDAO proTraceHbDualAuditDAO) {
        this.proTraceHbDualAuditDAO = proTraceHbDualAuditDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String) sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String) sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String prolev = (String) sqlmap.get("prolev"); //项目级别：一二三级项目
        String tasktype = (String) sqlmap.get("tasktype");
        String elementcode = PerfUtil.getSystemSet("tlprogram_lefttree_" + prolev); //来源elementcode
        String columncode = PerfUtil.getSystemSet("tlprogram_lefttree_col_" + prolev);  //表字段
        logger.debug("左侧树要素" + elementcode + "####");
        if (StringUtil.isEmpty(elementcode)) {
            elementcode = "PMKPIAGENCYALLPAY"; //没有配置默认单位
            columncode = "agencyguid";
        }
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" where 1=1 and t.tasktype='").append(tasktype).append("'");
        String datarule = this.getDataRuleByMenuguid(tasktype + proTraceHbDualAuditDAO.PERF_STRING_TRACE, "t", null); //数据权限
        datarule = datarule.replace("t.agencyguid", "t.guid");
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        if (!"1".equals(isleaf) && !"treeroot".equals(saveAgency)) {
            datarule += " and isleaf=1 start with superguid='" + saveAgency + "' connect by prior guid = superguid";
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode, datarule);
            proTraceHbDualAuditDAO.saveAll(eledatas, proTraceHbDualAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        } else {
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode, datarule);
            proTraceHbDualAuditDAO.saveAll(eledatas, proTraceHbDualAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        if (!StringUtil.isEmpty(wheresql)) {
            returnsql.append(" and ").append(wheresql);
        }
        if (!StringUtil.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (!StringUtil.isEmpty(wfsql)) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        if (!StringUtil.isEmpty(isleaf) && "1".equals(isleaf)) {
            returnsql.append(" and t.").append(columncode).append("='").append(saveAgency).append("'");
        } else {
            returnsql.append(" and exists(select 1 from ").append(proTraceHbDualAuditDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.").append(columncode).append(")");
        }
        if (StringUtil.isEmpty(orderby)) {
            returnsql.append(" order by t.updatetime");
        }
        return returnsql.toString();
    }

    /**
     * 查询左侧树。
     *
     * @param menuId -- 菜单.
     * @return
     * @throws AppException
     */
    public Map getTraceLeftTree(String menuId) throws Exception {
        Map leftconfig = new HashMap();
        List<String> types = new ArrayList<String>();
        types.add("protrace");
        types.add("depttrace");
        Object[] tabs = new Object[types.size()];
        for (int i = 0; i < types.size(); i++) {
            String type = types.get(i);
            leftconfig = new HashMap();
            String datarule = this.getDataRuleByMenuguid(type + proTraceHbDualAuditDAO.PERF_STRING_TRACE, "t", "1=1");
            datarule += " and tasktype = '" + type + "'";
            //根据权限查询单位
            List<Map<String, Object>> list = proTraceHbDualAuditDAO.getTreeList(datarule, ProTraceManageDAO.PERF_VIEW_TRACEMANAGE);
            proTraceHbDualAuditDAO.saveAll(list, proTraceHbDualAuditDAO.PMKPI_TABLE_TMP_AGENCY);
            if (list.size() <= 0) {
                Map<String, Object> map = new HashMap<>();
                map.put("guid", "treeroot");
                map.put("code", "00");
                map.put("name", "全部");
                map.put("superid", "0");
                map.put("levelno", "1");
                map.put("isleaf", "0");
                list.add(map);
                leftconfig.put("datas", list);
            } else {
                if ("protrace".equals(type)) {
                    list = proTraceHbDualAuditDAO.getLeftTree();
                    leftconfig.put("datas", list);
                } else if ( "depttrace".equals(type)) {
                    leftconfig.put("datas", list);
                }
            }
            leftconfig.put("showRootNode", Boolean.TRUE);
            leftconfig.put("dosearch", Boolean.FALSE);
            leftconfig.put("outformart", "#code-#name");
            leftconfig.put("expandlevel", 2);
            Map f1 = new HashMap();
            if ("protrace".equals(type)) {
                leftconfig.put("name", "项目支出");
                f1.put("name", "项目支出");
            } else if ("depttrace".equals(type)) {
                leftconfig.put("name", "部门整体");
                f1.put("name", "部门整体");
            }
            f1.put("ordernum", i);
            f1.put("code", type);
            f1.put("click", "tabChange");
            f1.put("treeinfo", leftconfig);
            tabs[i] = f1;
        }
        Map m = new HashMap();
        m.put("onlydata", Boolean.TRUE);
        m.put("activeTab", 0);
        m.put("dosearch", Boolean.TRUE);
        m.put("tabs", tabs);
        return m;
    }

    /**
     * 查询左侧树数据
     *
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = ProTraceManageDAO.PERF_VIEW_TRACEMANAGE;
        String tasktype = (String) params.get("tasktype");
        String datarule = this.getDataRuleByMenuguid(tasktype + proTraceHbDualAuditDAO.PERF_STRING_TRACE, "t", "1=1");
        //根据权限查询单位
        datarule += " and t.tasktype = '" + tasktype + "'";
        List<Map<String, Object>> list = proTraceHbDualAuditDAO.getTreeList(datarule, tablecode);
        proTraceHbDualAuditDAO.saveAll(list, proTraceHbDualAuditDAO.PMKPI_TABLE_TMP_AGENCY);
        return proTraceHbDualAuditDAO.getLeftTree();
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        Map<String, Object> auditdata = (Map<String, Object>) params.get("auditdata");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = "";
        if(auditdata!=null&&auditdata.size()>0){
            Map<String, Object> o = (Map<String, Object>) ((Map<String, Object>) params.get("auditdata")).get("maindata");
            remark = (String) o.get("remark");
        }
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, "V_PERF_T_HBPROMONITOR", datas);
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * <p></p >
     *
     * @param
     * @author hw
     * @date 2021/5/27 11:18
     */
    public void savePushremind(HashMap<String, Object> datas) throws AppException {
        List<HashMap<String, Object>> dataList = (List) datas.get("data");
        List<HashMap<String, Object>> pushList = new ArrayList<>();
        List<HashMap<String, Object>> adjustList = new ArrayList<>();
        UserDTO user = SecureUtil.getCurrentUser();
        for (HashMap<String, Object> oneMap : dataList) {
            String proguid = (String) oneMap.get("proguid"); // 获取项目id
            /**
             * 查询当前项目是否确认，未确认则不推送
             */
            List<Map<String, Object>> getOne = proTraceHbDualAuditDAO.queryForList("select t.* from  v_perf_t_adjustremind t where status = 0 and projguid =  '" + proguid + "'");
            if (getOne != null && !getOne.isEmpty()) {
                //如果这条数据不是监控推过来的要改为监控的
                List<Map<String, Object>> pushOne = proTraceHbDualAuditDAO.queryForList("select t.* from  v_perf_t_pushremind t where  proguid =  '" + proguid + "'");
                if (pushOne != null && !pushOne.isEmpty()) {
                    Map<String, Object> stringObjectMap = pushOne.get(0);
                    String isjk = (String) stringObjectMap.get("isjk");
                    String guid = (String) stringObjectMap.get("guid");
                    if (StringUtils.isEmpty(isjk) || !"1".equals(isjk)) {
                        String updateSql = "UPDATE v_perf_t_pushremind SET ISJK = '1' WHERE GUID = '" + guid + "'";
                        proTraceHbDualAuditDAO.update(updateSql);
                    }
                }
                continue;
            }
            HashMap<String, Object> params = new HashMap<>(); // 创建推送提醒对象
            String uuid = StringUtil.createUUID();
            params.put("guid", uuid);
            params.put("bgtge1t", null);
            params.put("amt1", null);
            params.put("amt2", null);
            params.put("amt3", null);
            params.put("amt4", null);
            params.put("proguid", proguid);
            params.put("isedit", null);
            params.put("update_time", null);
            params.put("startdate", null);
            params.put("ordernum", null);
            params.put("isjk", "1");
            params.put("status", "1");
            params.put("createtime", StringUtil.getSysDBDate());
            params.put("updatetime", StringUtil.getSysDBDate());
            params.put("province", CommonUtil.getProvince());
            params.put("year", CommonUtil.getYear());
            params.put("lastupdatetime", StringUtil.getSysDBDate());
            pushList.add(params);

            HashMap<String, Object> params1 = new HashMap<>();//创建关联对象
            params1.put("guid", this.getCreateguid());
            params1.put("projguid", proguid);
            params1.put("mainguid", uuid);
            params1.put("status", 0);
            params1.put("confirmtime", null);
            params1.put("agencyguid", null);
            params1.put("finintorgguid", null);
            params1.put("createtime", null);
            params1.put("updatetime", null);
            params1.put("lastupdatetime", null);
            params1.put("creater", user.getGuid());
            params1.put("province", user.getProvince());
            params1.put("year", CommonUtil.getYear());
            adjustList.add(params1);
        }
        proTraceHbDualAuditDAO.saveAll(pushList, "v_perf_t_pushremind"); // 推送提醒表入库
        proTraceHbDualAuditDAO.saveAll(adjustList, "v_perf_t_adjustremind"); // 关联表入库
    }

    /**
     * <p>推送到监控整改通知编制</p >
     *
     * @param
     * @author hw
     * @date 2021/5/28 15:53
     */
    public void monRect(HashMap<String, Object> datas) throws AppException {
        List<HashMap<String, Object>> dataList = (List) datas.get("data");
        String rectifyWfid = (String) datas.get("rectifyWfid"); // PERF_T_RECTIFY 表里面固定的流程id
        List<HashMap<String, Object>> pushList = new ArrayList<>();
        UserDTO user = SecureUtil.getCurrentUser();
        for (HashMap<String, Object> oneMap : dataList) {
            /**
             *如果有当前项目则判断是否已终审
             * 如果已终审则可以继续推，如果未终审则不推
             */
            String guid = (String) oneMap.get("guid"); //
            String agencyguid = (String) oneMap.get("agencyguid"); // 获取项目id
            String pro_name = (String) oneMap.get("pro_name"); // 获取项目id
            String finintorgguid = (String) oneMap.get("finintorgguid"); // 获取项目id
            String proguid = (String) oneMap.get("proguid"); // 获取项目id
            String proCode = (String) oneMap.get("pro_code"); // 获取项目   pro_code
            String sql = "select * from V_PERF_T_RECTIFY where mainguid = '" + guid + "' and proguid = '" + proguid + "' and isfinal ='2'";
            List<Map<String, Object>> getOne = proTraceHbDualAuditDAO.queryForList(sql);
            if (getOne != null && !getOne.isEmpty()) {
                continue;
            }
            HashMap<String, Object> params = new HashMap<>(); // 创建对象
            String uuid = StringUtil.createUUID();
            params.put("guid", uuid);
            params.put("agencyguid", agencyguid); //预算单位
            params.put("projname", pro_name); // 项目名称
            params.put("finintorgguid", finintorgguid); // 业务科室
            params.put("wfstatus", "000"); // 审核状态
            params.put("creater", user.getGuid()); // 填报人
            params.put("proguid", proguid); // 项目id
            params.put("wfid", rectifyWfid); // 流程id
            params.put("mainguid", guid); //
            params.put("createuid", user.getGuid());
            params.put("createuname", user.getName());
            params.put("updateuid", user.getGuid());
            params.put("updateuname", user.getName());
            params.put("createtime", StringUtil.getDateBySimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
            params.put("updatetime", StringUtil.getSysDBDate());
            params.put("lastupdatetime", StringUtil.getSysDBDate());
            params.put("province", user.getProvince());
            params.put("year", CommonUtil.getYear());
            params.put("state", 0);
            params.put("delstatus", "0");
            params.put("auditor", user.getGuid());
            params.put("status", "1");
            params.put("projcode", proCode);
            params.put("isfinal", "2");  //isfinal=1(已终审) isfinal = 2(未终审)
            params.put("bustype", "1"); // 暂时写死
            params.put("type", "TRACE");
            pushList.add(params);
        }
        proTraceHbDualAuditDAO.saveAll(pushList, "V_PERF_T_RECTIFY"); // 推送提醒表入库
    }

    /**
     * <p>字符串转sql</p >
     * 001,002 --->  '001','002'
     *
     * @param
     * @author hw
     * @date 2021/5/27 19:37
     */
    public static String strToSql(String str) {
        String[] strArray = str.split(",");
//        String resultStr = "";
        StringBuilder resultStr = new StringBuilder();
        for (String s : strArray) {
//            resultStr += "'" + s + "',";
            resultStr.append("'").append(s).append("',");
        }
        String result = resultStr.toString();
        return result.substring(0, result.length() - 1);
    }

    public List getTraceAudit(Map sqlmap) throws AppException {
        String sql = this.getVodSql(sqlmap);
        List list = proTraceHbDualAuditDAO.queryForList(sql);
        return list;
    }

}
