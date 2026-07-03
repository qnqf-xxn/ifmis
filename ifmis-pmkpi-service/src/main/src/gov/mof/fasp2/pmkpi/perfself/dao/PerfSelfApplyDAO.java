package gov.mof.fasp2.pmkpi.perfself.dao;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class PerfSelfApplyDAO extends PmkpiDAO {
	
    public static final String AUDITSUB_TABLE = "perf_t_audititems";
    public static final String AUDITMAIN_TABLE = "perf_t_auditmain";
    public static final String TEMPLATE_TABLE = "perf_t_natrueaudittemp";
    public static final String SELFEVALTASK_TABLE = "PERF_V_SELFEVALTASK"; // 绩效自评数据表-项目支出
    public static final String SELF_EVAL_TABLE = "V_PM_PERF_SELF_EVAL";//项目绩效自评信息表
    public static final String SELF_GOAL_TABLE = "V_PM_SELF_EVAL_GOAL";//项目目标单位自评表
    public static final String SELF_IND_TABLE = "V_PM_SELF_EVAL_INDICATOR";//项目指标单位自评表
    public static final String SELF_BGT_TABLE = "V_PM_PERF_SELF_BGT";//项目预算执行完成情况表
    public static final String SELF_FILE_TABLE = "V_PERF_PUBLIC_FILE";//绩效评价附件表

    public static final String PERF_TABLE_SELFPERFDESC = "V_PERF_T_SELFPERFDESC";
    public static final String PERF_TABLE_EVALUATEINFO = "V_PERF_T_EVALUATEINFO";

    public void deleteByMainguid(String tableName, String guidcol, String mainguid, String where) {
        StringBuilder sql = new StringBuilder("delete from ");
        sql.append(tableName).append(" where ").append(guidcol).append(" = '").append(mainguid).append("'");
        if (where != null && where.isEmpty()) {
            sql.append(" and ").append(where);
        }
        this.execute(sql.toString());
    }


    /**
     * @description 获取四性审核明细数据.
     * @param mainguid -- 主表guid
     * @return map
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> getData(String mainguid) {
        StringBuilder sql = new StringBuilder("select t.*, m.proposal from ");
        sql.append(TEMPLATE_TABLE).append(" t left join (select * from ").append(AUDITSUB_TABLE);
        sql.append(" where auditguid = '").append(mainguid).append("') m on t.guid = m.tempguid order by ordernum");
        List<Map<String, Object>> datas = this.queryForList(sql.toString());
        return datas;
    }

    /**
     * 查询自评的主单数据
     */
    public List<Map<String, Object>> getSelfMainData(String wheresql) {
        String sql = "select t.* from v_perf_t_selfevaltask t where  " + wheresql;
        return this.queryForList(sql);
    }

    /**
     * 根据项目，年度，查询年度明细指标.
     * @param tablecode -- 查询案例表或项目指标表
     * @param  filter -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexs(String tablecode, String filter, String reporttype, String viewtype, List<Map<String, Object>> tempdatas) {
        Map<Object, Object> fMap = null;
        Map<Object, Object> sMap = null;
        Map<Object, Object> tMap = null;
        if ("imp".equals(viewtype)) {
            tMap = tempdatas.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
        } else {
            fMap = tempdatas.stream().collect(Collectors.toMap(l -> l.get("findex"), l -> l.get("findexname"), (o, n) -> o));
            sMap = tempdatas.stream().collect(Collectors.toMap(l -> l.get("sindex"), l -> l.get("sindexname"), (o, n) -> o));
        }
        StringBuffer sql = new StringBuffer("select t.*,");
        sql.append(" c.name as computesignname from ").append(tablecode).append(" t");
        sql.append(" left join v_perf_enum c on c.code = t.computesign and c.elementcode='PMKPIZBXS' ");
        if (!StringUtil.isEmpty(filter)) {
            sql.append(" where ").append(filter);
        }
        sql.append(" order by t.findex,t.sindex,t.ordernum");
        logger.info("---自评指标查询sql: " + sql);
        List<Map<String, Object>> indexList = this.queryForList(sql.toString());
        if (indexList.size() > 0) {
            for (Map<String, Object> indexMap : indexList) {
                String findex = (String) indexMap.get("findex");
                String sindex = (String) indexMap.get("sindex");
                if ("imp".equals(viewtype)) {
                    indexMap.put("findexname", tMap.get(findex));
                    indexMap.put("sindexname", tMap.get(sindex));
                } else {
                    if (("hfprogram".equals(reporttype) || "hfdept".equals(reporttype)) && "3".equals(findex)) {
                        indexMap.put("findex", "2");
                    }
                    indexMap.put("findexname", fMap.get(findex));
                    indexMap.put("sindexname", sMap.get(sindex));
                }
            }
        }
        return indexList;
    }

    /**
     * <p>获取自评固化指标</p >
     * @param
     */
    public List<Map<String, Object>> getSelfFrameData(String frametype, String viewtype) {
        StringBuffer sql = new StringBuffer();
        sql.append("select t.*,'selfframe' as datatype,");
        sql.append(" t.weight as actualweight,b.superid as findex from v_perf_t_selfframe t");
        sql.append(" left join v_perf_t_selfframe b on t.superid = b.guid and t.frametype = b.frametype");
        sql.append(" where t.frametype =? order by t.ordernum");
        List<Map<String, Object>> list = PerfUtil.lowMapKey(this.queryForList(sql.toString(), new String[]{frametype}));
        if (list.size() > 0) {
            Map<Object, Object> tMap = list.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
            Map<Object, Object> wMap = list.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("weight")));
            for (Map<String, Object> map : list) {
                String guid = (String) map.get("guid");
                String superid = (String) map.get("superid");
                String findex = (String) map.get("findex");
                String levelno = map.get("levelno") + "";
                String weight = map.get("weight") + "";
                String findexname = "";
                String sindexname = "";
                if ("1".equals(levelno)) {
                    map.put("findex", guid);
                    map.put("sindex", "");
                    if (StringUtil.isEmpty(weight) || "null".equals(weight) || "query".equals(viewtype)) {
                        findexname = (String) tMap.get(guid);
                    } else {
                        findexname = tMap.get(guid) + "(" + weight + "分)";
                    }
                    sindexname = "0";
                } else if ("2".equals(levelno)) {
                    map.put("findex", superid);
                    map.put("sindex", guid);
                    if (StringUtil.isEmpty(weight) || "null".equals(weight) || "query".equals(viewtype)) {
                        findexname = (String) tMap.get(superid);
                        sindexname = (String) tMap.get(guid);
                    } else {
                        findexname = tMap.get(superid) + "(" + weight + "分)";
                        sindexname = tMap.get(guid) + "(" + weight + "分)";
                    }
                } else if ("3".equals(levelno)) {
                    map.put("sindex", superid);
                    if (StringUtil.isEmpty(weight) || "null".equals(weight) || "query".equals(viewtype)) {
                        findexname = (String) tMap.get(findex);
                        sindexname = (String) tMap.get(superid);
                    } else {
                        findexname = tMap.get(findex) + "(" + wMap.get(findex) + "分)";
                        sindexname = tMap.get(superid) + "(" + wMap.get(superid) + "分)";
                    }
                }
                map.put("findexname", findexname);
                map.put("sindexname", sindexname);
            }
        }
        return list;
    }

    /**
     * <p>获取模板数据</p >
     *
     * @author hw
     * @date 2022/5/17 11:25
     * @param
     */
    public List<Map<String, Object>> getTempdatas(String type, String viewtype, String reporttype) {
        StringBuffer sql = new StringBuffer();
        String[] strs = new String[]{type};
        sql.append("select t.guid,t.code,t.name,t.levelno,t.isleaf,t.ordernum,");
        if (("hfprogram".equals(reporttype) || "hfdept".equals(reporttype)) && !"imp".equals(viewtype)) {
            strs = new String[]{type, type};
            sql.append("decode(t.superid,'3','2', t.superid) as superid,");
            sql.append("case when guid='2' then (select sum(a.weight) as weight from v_perf_t_frame a where a.frametype=? and a.guid in('2','3')) else weight end weight");
        } else {
            sql.append("t.superid, t.weight");
        }
        sql.append(" from ").append(PMKPI_TABLE_T_FRAME).append(" t where t.frametype=? ");
        if (!"imp".equals(viewtype)) {
            if ("hfprogram".equals(reporttype) || "hfdept".equals(reporttype)) {
                sql.append(" and t.guid not in('3')");
            }
        }
        sql.append(" order by ordernum");
        List<Map<String, Object>> list = PerfUtil.lowMapKey(this.queryForList(sql.toString(), strs));
        for (Map<String, Object> map : list) {
            String guid = (String) map.get("guid");
            String superid = (String) map.get("superid");
            String levelno = map.get("levelno") + "";
            String weight = map.get("weight") + "";
            if ("1".equals(levelno)) {
                map.put("findex", guid);
                map.put("sindex", "");
                if (StringUtil.isEmpty(weight) || "null".equals(weight) || "query".equals(viewtype)) {
                    map.put("findexname", map.get("name"));
                } else {
                    map.put("findexname", map.get("name") + "(" + weight + "分)");
                }
            } else if ("2".equals(levelno)) {
                map.put("findex", superid);
                map.put("sindex", guid);
                if (StringUtil.isEmpty(weight) || "null".equals(weight) || "query".equals(viewtype)) {
                    map.put("sindexname", map.get("name"));
                } else {
                    map.put("sindexname", map.get("name") + "(" + weight + "分)");
                }
            }
        }
        if (!"imp".equals(viewtype)) {
            Map<Object, Object> fMap = list.stream().filter(m -> "1".equals(m.get("levelno") + "")).collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("findexname")));
            list = list.stream().filter(map -> "2".equals(map.get("levelno") + "")).collect(Collectors.toList());
            list.forEach(map -> {
                map.put("name", null);
                map.put("findexname", fMap.get(map.get("findex")));
            });
        }
        return list;
    }



    /**
     * 处理规范表数据.
     * @param datas actioncode  bustype -- 参数.
     * @return
     */
    public void updateTabelDatas(List<Map<String, Object>> datas, String actioncode, String bustype) throws AppException {
        if (!"program".equals(bustype) && !"transprogram".equals(bustype) && !"parentprogram".equals(bustype)) {//只处理项目数据
            return;
        }
        if(datas != null && datas.size()>0) {
            List<Map<String, Object>> mainlist = new ArrayList<>();
            List<Map<String, Object>> goallist = new ArrayList<>();
            List<Map<String, Object>> indexlist = new ArrayList<>();
            List<Map<String, Object>> fundlist = new ArrayList<>();
            List<Map<String, Object>> filelist = new ArrayList<>();
            List<String> addguids = new ArrayList<>();
            List<String> delguids = new ArrayList<>();
            List<String> delcodes = new ArrayList<>();
            List<String> querykeys = new ArrayList<>();
            Map<String, Object> maindatas = new HashMap<>();
            for (Map<String, Object> data : datas) {
                String guid = (String) data.get("guid");
                String wfstatus = (String) data.get("wfstatus");
                if ("audit".equals(actioncode) || "auditbatch".equals(actioncode) || "sendaudit".equals(actioncode)) {
                    if ("011".equals(wfstatus)) {//终审
                        addguids.add(guid);
                        querykeys.add((String) data.get("pro_code"));
                    }
                } else if ("cancelaudit".equals(actioncode) || "cancelsendaudit".equals(actioncode)) {
                    if (!"011".equals(wfstatus)) {//取消终审
                        delguids.add(guid);
                        delcodes.add((String) data.get("pro_code"));
                    }
                }
                maindatas.put(guid,data);
            }
            String sql = this.createInSql("guid", addguids);
            String wheresql = this.createInSql("mainguid", addguids);
            String filewheresql = this.createInSql("billguid", addguids);
            String queryreprotsql =  this.createInSql("pro_code", querykeys);
            if(addguids.size() > 0) {
                Map<String, Object> agencyMap = new HashMap<>();
                List<Map<String, Object>> eledatas = this.getDatas(PmkpiDAO.PMKPI_TABLE_T_AGENCY, null, null);
                for (Map<String, Object> map : eledatas) {
                    agencyMap.put((String) map.get("guid"), map.get("name"));
                }
                //查询需要同步的数据
                String mainsql ="select * from (select t1.score,t.* from v_perf_t_selfevaltask t left join v_perf_t_selfperfdesc t1 on t.guid = t1.mainguid) "+"where (" + sql + ")";
                List<Map<String, Object>> maindata = this.queryForList(mainsql);
                List<Map<String, Object>> goaldata = this.getDatas("v_perf_t_selfperfdesc", wheresql, null);
                if(PerfUtil.getIS_HUBEI()){
                    String goalsql ="select * from (select t1.allyeargoal,t.kpi_target as yeargoal,t.* from v_perf_t_selfperfgoal t left join v_perf_t_selfperfdesc t1 on t.mainguid = t1.mainguid) "+"where (" + wheresql + ")";
                    goaldata = this.queryForList(goalsql);
                }
                List<Map<String, Object>> funddata = this.getDatas("v_perf_t_selfprofund", wheresql, "order by ordernum");
                List<Map<String, Object>> filedata = this.getDatas("perf_file", filewheresql, null);
                List<Map<String, Object>> indexdata = this.getDatas("v_perf_t_selfperfindex", wheresql, "order by ordernum");
                //处理自评主表信息
                if (maindata != null && maindata.size() > 0) {
                    for (Map selfmap : maindata) {
                        selfmap.put("eval_id", selfmap.get("guid"));
                        selfmap.put("pro_code", selfmap.get("pro_code"));
                        selfmap.put("pro_name", selfmap.get("name"));
                        selfmap.put("devi_analy", "");//偏差分析及整改措施
                        selfmap.put("application_advise", "");//结果应用建议
                        selfmap.put("total_eval_value", selfmap.get("score") == null ? 0 : selfmap.get("score"));
                        selfmap.put("is_last_inst", 1);//是否终审
                        this.setDataMap(selfmap, "add", agencyMap);
                        mainlist.add(selfmap);
                    }
                }
                //处理目标信息
                if (goaldata != null && goaldata.size() > 0) {
                    for (Map goalmap : goaldata) {
                        Map<String, Object> selfdatas = (Map<String, Object>) maindatas.get(goalmap.get("mainguid"));
                        goalmap.put("eval_kpi_id", StringUtil.isNullOrEmpty(goalmap.get("guid")) ? StringUtil.createUUID() : goalmap.get("guid"));
                        goalmap.put("eval_id", goalmap.get("mainguid"));
                        goalmap.put("kpi_per_id", goalmap.get("guid"));//项目绩效目标主键 ??
                        goalmap.put("pro_code", selfdatas.get("pro_code"));
                        goalmap.put("pro_name", selfdatas.get("name"));
                        goalmap.put("agencyguid", selfdatas.get("agencyguid"));
                        goalmap.put("kpi_target", goalmap.get("yeargoal"));
                        goalmap.put("goal_comp", StringUtil.isNullOrEmpty(goalmap.get("allyeargoal")) ? "无" : goalmap.get("allyeargoal"));
                        goalmap.put("is_last_inst", 1);//是否终审
                        this.setDataMap(goalmap, "add", agencyMap);
                        goallist.add(goalmap);
                    }
                }
                //处理指标信息
                if (indexdata != null && indexdata.size() > 0) {
                    for (Map indexmap : indexdata) {
                        Map<String, Object> selfdatas = (Map<String, Object>) maindatas.get(indexmap.get("mainguid"));
                        indexmap.put("eval_ind_id", indexmap.get("guid"));
                        indexmap.put("eval_id", indexmap.get("mainguid"));
                        indexmap.put("kpi_id", indexmap.get("tindex"));//项目绩效指标主键
                        indexmap.put("agencyguid", selfdatas.get("agencyguid"));
                        indexmap.put("pro_name", selfdatas.get("name"));
                        indexmap.put("kpi_val", indexmap.get("indexval"));//指标值
                        indexmap.put("ind_comp", indexmap.get("actualvalue"));//指标值完成情况
                        indexmap.put("ind_weight", indexmap.get("actualweight") == null ? 0 : indexmap.get("actualweight"));//权重
                        if(PerfUtil.getIsZJ()){
                            indexmap.put("ind_weight", indexmap.get("weight"));//权重
                        }
                        indexmap.put("eval_score", indexmap.get("score") == null ? 0 : indexmap.get("score"));
                        indexmap.put("devi_analy", indexmap.get("kpi_remark"));//偏差分析及整改措施
                        indexmap.put("application_advise", indexmap.get("opinion_remark"));//结果应用建议
                        indexmap.put("is_last_inst", 1);//是否终审
                        this.setDataMap(indexmap, "add", agencyMap);
                        indexlist.add(indexmap);
                    }
                }
                //处理资金信息
                if (funddata != null && funddata.size() > 0) {
                    for (Map fundmap : funddata) {
                        Map<String, Object> selfdatas = (Map<String, Object>) maindatas.get(fundmap.get("mainguid"));
                        fundmap.put("bgt_eval_id", fundmap.get("guid"));
                        fundmap.put("found_type_code", "1"); //资金来源代码  ??
                        fundmap.put("found_type_name", "1");//资金来源名称  ??
                        fundmap.put("pro_name", selfdatas.get("name"));
                        fundmap.put("reply_amt", fundmap.get("amt1"));//年初批复数
                        fundmap.put("year_adj_amt", fundmap.get("amt2"));//年度调整金额
                        fundmap.put("cur_amt", fundmap.get("amt3"));//变动后预算数
                        fundmap.put("year_exe_amt", fundmap.get("amt4"));//全年执行数
                        fundmap.put("exe_amt_rate", fundmap.get("bgtget"));//资金执行率
                        fundmap.put("exe_score", fundmap.get("score") == null ? 0 : fundmap.get("score"));//资金执行得分
                        fundmap.put("is_last_inst", 1);//是否终审
                        this.setDataMap(fundmap, "add", agencyMap);
                        fundlist.add(fundmap);
                    }
                }
                //处理附件信息
                if (filedata != null && filedata.size() > 0) {
                    for (Map filemap : filedata) {
                        filemap.put("file_id", filemap.get("guid"));
                        filemap.put("eval_id", filemap.get("billguid"));
                        filemap.put("file_name", filemap.get("filename"));//附件名称
                        filemap.put("full_path", "无");//附件路径
                        filemap.put("report_type_code", "1");//绩效评价报告类型代码 1.单位自评 2.部门评价 3.财政评价
                        filemap.put("report_type_name", "单位自评");//绩效评价报告类型名称
                        filemap.put("is_last_inst", 1);//是否终审
                        this.setDataMap(filemap, "add", agencyMap);
                        filelist.add(filemap);
                    }
                }
                //20240703-是否需要重新查询年度目标值 解决问题:v_perf_t_selfperfdesc中可能存在yeargoal为空的情况,插入规范表kpi_target报错
                boolean is_queryreportgoal = false;
                for (Map goalmap : goallist) {
                    if(StringUtil.isNullOrEmpty((String) goalmap.get("kpi_target"))){
                        is_queryreportgoal = true;
                        break;
                    }
                }
                if(is_queryreportgoal){
                    List<Map<String, Object>> queryGoaldata = null;
                    if ("parentprogram".equals(bustype)) {//广西一级项目没有年度绩效，取总体
                        List<Map<String, Object>> proList = this.getDatas(PmkpiDAO.PMKPI_TABLE_PROJECT_INFO, queryreprotsql, null);
                        List<String> list = new ArrayList<>();
                        proList.forEach(m -> list.add((String) m.get("guid")));
                        queryreprotsql = this.createInSql("mainguid", list);
                        queryreprotsql += " and yearflag ='1' and is_deleted=2 and is_backup=2 and province='" + SecureUtil.getUserSelectProvince() + "'";
                        queryGoaldata = this.getDatas("pm_perf_goal_info", queryreprotsql, null);
                    } else {
                        queryreprotsql += " and yearflag ='0'";
                        queryGoaldata = this.getDatas("v_pm_perf_goal_info", queryreprotsql, null);
                    }
                    Map<Object, Object> queryGoalMap = queryGoaldata.stream().collect(Collectors.toMap(l -> l.get("pro_code"), l -> l.get("kpi_target")));
                    for (Map<String, Object> goal : goallist) {
                        if(StringUtil.isNullOrEmpty((String) goal.get("kpi_target"))){
                            goal.put("kpi_target",queryGoalMap.get(goal.get("pro_code")));
                        }
                    }
                }
                if (mainlist.size() > 0) {
                    this.saveAll(mainlist, this.SELF_EVAL_TABLE);
                }
                if (goallist.size() > 0) {
                    this.saveAll(goallist, this.SELF_GOAL_TABLE);
                }
                if (indexlist.size() > 0) {
                    this.setIndexDatas(indexlist, "PM001", true);
                    this.saveAll(indexlist, this.SELF_IND_TABLE);
                }
                if (fundlist.size() > 0) {
                    this.saveAll(fundlist, this.SELF_BGT_TABLE);
                }
                if (filelist.size() > 0) {
                    this.saveAll(filelist, this.SELF_FILE_TABLE);
                }
            }
            //取消终审则将终审状态改为2 删除状态改为1
            if(delguids.size()>0){
                String delsql = "is_last_inst=2,is_deleted = 1";
                this.updateAllByColumn("eval_id", delguids, this.SELF_EVAL_TABLE, " eval_id = sys_guid(),"+delsql, null);
                this.updateAllByColumn("eval_id", delguids, this.SELF_GOAL_TABLE, " eval_kpi_id = sys_guid(),"+delsql, null);
                this.updateAllByColumn("eval_id", delguids, this.SELF_IND_TABLE, " eval_ind_id = sys_guid(),"+delsql, null);
                this.updateAllByColumn("pro_code", delcodes, this.SELF_BGT_TABLE, " bgt_eval_id = sys_guid(),"+delsql, null);
                this.updateAllByColumn("eval_id", delguids, this.SELF_FILE_TABLE, " file_id = sys_guid(),"+delsql, null);
            }
        }
    }



    /**
     * 基础规范字段赋值
     * @param map
     * @return
     */
    public Map<String, Object> setDataMap(Map<String, Object> map, String type, Map<String, Object> agencyMap){
        if (map != null){
            String agencyguid = (String) map.get("agencyguid");
            if (!StringUtil.isEmpty(agencyguid) && agencyguid.length() >= 3) {
                if (agencyguid.length() > 0) {
                    String dept_code = agencyguid.length() == 3 ? agencyguid : agencyguid.substring(0, agencyguid.length() - 3);
                    map.put("dept_code", dept_code);
                    map.put("dept_name", agencyMap.get(dept_code));
                }
            }
            map.put("agency_name", agencyMap.get(agencyguid));
            map.put("agency_code", agencyguid);
            map.put("fiscal_year", SecureUtil.getUserSelectYear());
            map.put("mof_div_code", SecureUtil.getUserSelectProvince());
            map.put("mof_div_name", CommonUtil.getProvinceNameByCode((String) map.get("mof_div_code")));
            map.put("update_time", PerfUtil.getServerTimeStamp());
            map.put("is_deleted", 2);
            if (type != null && "add".equals(type)) {
                map.put("create_time", PerfUtil.getServerTimeStamp());
            }
        }
        return map;
    }
}
