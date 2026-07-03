package gov.mof.fasp2.pmkpi.perfprotrace.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceAuditDAO extends PmkpiDAO {

    /**
     * 处理规范表数据
     * @param datas
     * @param actioncode
     * @throws AppException
     */
    public void updateTracePayTabelDatas (List<Map<String, Object>> datas, String actioncode, String bustype) throws AppException {
        if (!"protrace".equals(bustype)) {
            return;
        }
        String istraceinitiateadjust = PerfUtil.getSystemSet("ISTRACEINITIATEADJUST");//调整是否走工作流
        Map<String, Object> mm = PerfUtil.parseString2Map(istraceinitiateadjust);
        String deptwfststus = (String) mm.get("deptwfststus");
        String jxwfststus = (String) mm.get("jxwfststus");
        List<String> addguids = new ArrayList<>();
        List<String> delguids = new ArrayList<>();
        Map<String, Object> mainMap = new HashMap();
        List<String> proguids = new ArrayList<>();
        for (Map<String, Object> data : datas) {
            String wfstatus = (String) data.get("wfstatus");
            String guid = (String) data.get("guid");
            String depttask = (String) data.get("depttask");
            String provincetask = (String) data.get("provincetask");
            String audittype = (String) data.get("audittype");
            if ("auditbatch".equals(actioncode) || "audit".equals(actioncode) || "sendaudit".equals(actioncode)) {
                //终审状态、一般监控、不进行成果上传都要替换
                if ("011".equals(wfstatus)
                || ("1".equals(depttask) && "2".equals(provincetask) && deptwfststus != null && deptwfststus.equals(wfstatus))
                || ("1".equals(provincetask) && !"2".equals(audittype) && !StringUtil.isEmpty(jxwfststus) && jxwfststus.equals(wfstatus))) {
                    addguids.add(guid);
                    if (PerfUtil.getIsHbei()) {
                        proguids.add((String) data.get("proguids"));
                    } else {
                        proguids.add((String) data.get("pro_code"));
                    }
                }
            } else if ("cancelaudit".equals(actioncode) || "cancelsendaudit".equals(actioncode)) {
                if (!"011".equals(wfstatus)) {
                    delguids.add(guid);
                }
            }
            mainMap.put(guid, data);
        }
        //新增规范表数据
        if (addguids.size() > 0) {
            //一般监控终审、下达重点以后，规范表已存在数据，先进行删除操作
            String upsql = "is_last_inst=2 , t.is_deleted=1";
            this.updateAllByColumn("perf_task_id", addguids, ProTraceManageDAO.PERF_TABLE_MONITOR_INFO, " perf_mon_id = sys_guid()," + upsql, null);
            String wheresql = " exists(select 1 from v_perf_file b where b.filetype = 'protracetraceindexfile' and b.guid=t.perf_att_id)";
            this.updateAllByColumn(null, null, ProTraceManageDAO.PERF_TABLE_MONITOR_ATTACH, "perf_att_id = sys_guid()," + upsql, wheresql);
            
            String filter = "";
            String goalTablecode = "V_PM_PERF_GOAL_INFO";
            if (PerfUtil.getIsHbei()) {
                filter = this.createInSql("mainguid", proguids);
            } else {
                filter = this.createInSql("pro_code", proguids);
            }
            filter += " and t.yearflag = '0'";
            //查询绩效目标
            List<Map<String, Object>> goalList = this.getDatas(goalTablecode, filter, null);
            Map<String, Object> goalMap = new HashMap<>();
            for (Map<String, Object> goal : goalList) {
                if (PerfUtil.getIsHbei()) {
                    goalMap.put((String) goal.get("mainguid"), goal);
                } else {
                    goalMap.put((String) goal.get("pro_code"), goal);
                }
            }
            //更新规范主表终审状态
            this.updateAllByColumn("perf_task_id", addguids, ProTraceManageDAO.PERF_TABLE_MANAGE_TASK, "is_last_inst=1", null);
            //根据主建查询指标、以及指标的附件
            wheresql = this.createInSql("mainguid", addguids);
            String sql = "select t.* from v_perf_t_proindextrace t where " + wheresql;
            List<Map<String, Object>> indexList = this.queryForList(sql);
            sql = " select t.* from v_perf_file t where t.filetype = 'protracetraceindexfile' and exists(select 1 from v_perf_t_proindextrace a where t.billguid=a.guid||a.mainguid and " + wheresql + ")";
            List<Map<String, Object>> fileList = this.queryForList(sql);
            Map<String, Object> indexMap = new HashMap<>();
            if (indexList.size() > 0) {
                //处理指标数据
                for (Map<String, Object> index : indexList) {
                    String mainguid = (String) index.get("mainguid");
                    indexMap.put(index.get("guid") + mainguid, index);
                    Map<String, Object> maindata = (Map<String, Object>) mainMap.get(mainguid);
                    Map<String, Object> goaldata = null;
                    if (PerfUtil.getIsHbei()) {
                        goaldata = (Map<String, Object>) goalMap.get(maindata.get("proguid"));
                    } else {
                        goaldata = (Map<String, Object>) goalMap.get(maindata.get("pro_code"));
                    }
                    index.put("perf_mon_id", index.get("guid"));
                    index.put("perf_task_id", index.get("mainguid"));
                    index.put("perf_mon_no", maindata.get("taskstage"));
                    //是否重点监控通版1、山西3
                    if ("1".equals(maindata.get("provincetask")) || "3".equals(maindata.get("provincetask"))) {
                        index.put("perf_type_code", "2");
                        index.put("perf_type_name", ProTraceManageDAO.PERF_TYPE_PROVINCENAME);
                    } else {
                        index.put("perf_type_code", "1");
                        index.put("perf_type_name", ProTraceManageDAO.PERF_TYPE_DEPTNAME);
                    }
                    index.put("pro_code", maindata.get("pro_code"));
                    index.put("pro_name", maindata.get("name"));
                    if (goaldata != null && !goaldata.isEmpty()) {
                        index.put("kpi_target", goaldata.get("kpi_target"));
                    }
                    index.put("pro_bgt_comp", 0);//项目预算执行情况
                    index.put("est_pro_bgt_annual", 0);//项目预算全年预计执行情况
                    index.put("kpi_val", index.get("targetvalue"));//指标值
                    index.put("perf_comp", index.get("indexval"));//绩效指标完成情况
                    if (index.get("completeanalyscon") == null) {//绩效指标全年预计完成情况
                        index.put("est_perf_annual", "无");
                    } else {
                        index.put("est_perf_annual", index.get("completeanalyscon"));
                    }
                    //偏差原因分析
                    if (index.get("deviationanalysis") == null) {
                        index.put("ana_dev_reasons", "无偏差");
                    } else {
                        index.put("ana_dev_reasons", index.get("deviationanalysis"));
                    }
                    index.put("complete_rate", 0);//完成目标可能性
                    index.put("perf_send_date", index.get("update_time"));//报送日期
                    index.put("is_last_inst", 1);//是否终审
                    if (StringUtil.isEmpty((String) index.get("create_time"))) {
                        index.put("create_time", index.get("update_time"));
                    }
                    this.getBasMap(index, null);
                }
                this.setIndexDatas(indexList, "PM001", false);
                this.saveAll(indexList, ProTraceManageDAO.PERF_TABLE_MONITOR_INFO);
            }
            if (fileList.size() > 0) {
                //处理附件数据
                for (Map<String, Object> filedata : fileList) {
                    Map<String, Object> index = (Map<String, Object>) indexMap.get(filedata.get("billguid"));
                    filedata.put("perf_att_id", filedata.get("guid"));
                    filedata.put("perf_mon_id", index.get("guid"));
                    filedata.put("file_name", filedata.get("filename"));//附件名称
                    filedata.put("full_path", "无");//附件路径
                    filedata.put("report_file", "无");//附件文件
                    filedata.put("is_last_inst", 1);//是否终审
                    this.getBasMap(filedata, null);
                }
                this.saveAll(fileList, ProTraceManageDAO.PERF_TABLE_MONITOR_ATTACH);
            }
        }
        //删除规范表数据
        if (delguids.size() > 0) {
            String upsql = "is_last_inst=2";
            this.updateAllByColumn("perf_task_id", delguids, ProTraceManageDAO.PERF_TABLE_MANAGE_TASK, upsql, null);
            upsql += ", t.is_deleted=1";
            this.updateAllByColumn("perf_task_id", delguids, ProTraceManageDAO.PERF_TABLE_MONITOR_INFO, " perf_mon_id = sys_guid()," + upsql, null);
            String wheresql = " exists(select 1 from v_perf_file b where b.filetype = 'protracetraceindexfile' and b.guid=t.perf_att_id)";
            this.updateAllByColumn(null, null, ProTraceManageDAO.PERF_TABLE_MONITOR_ATTACH, "perf_att_id = sys_guid()," + upsql, wheresql);
        }
    }

    /**
     * 修改审核状态
     * @return
     * @throws AppException
     */
    public void updateaudittype(String guid, String audittype) throws AppException {
        String sql = "update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.conaudittype= '"+audittype+"' where t.guid='"+guid+"'";
        this.execute(sql);
    }

}
