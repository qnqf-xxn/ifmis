package gov.mof.fasp2.pmkpi.deptperformance.deptperftest;

import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>湖北-部门整体绩效（试点）</p >
 *
 * @author hw
 * @date 2022/9/8 16:37
 */
public class DeptPerfHbTestBO extends PmkpiBO {

    private DeptPerfHbTestDAO deptPerfHbTestDAO;

    public void setDeptPerfHbTestDAO(DeptPerfHbTestDAO deptPerfHbTestDAO) {
        this.deptPerfHbTestDAO = deptPerfHbTestDAO;
    }

    /**
     * <p>查询主表目标数据</p >
     *
     * @param
     * @author hw
     * @date 2022/9/20 17:02
     */
    public Map<String, Object> getMainDatas(HashMap<String, Object> params) {
        Map backMap = new HashMap(); //返回消息
        String mainguid = (String) params.get("mainguid");
        String agencyguid = (String) params.get("agencyguid"); //单位
        String viewtype = (String) params.get("viewtype"); //viewtype
        StringBuffer sql = new StringBuffer(" t.mainguid = '" + mainguid + "'");
        String orderby = " order by ordernum";
        List<Map<String, Object>> goals = deptPerfHbTestDAO.getDatas(deptPerfHbTestDAO.BGT_TABLE_GOAL, sql.toString(), orderby); //目标
        if (!"query".equals(viewtype)) {
            formatGoals(goals, agencyguid, mainguid);
        }
        List totalgoals = new ArrayList(); //总体
        List yeargoals = new ArrayList(); // 年度
        setGoalIndex(sql, goals, totalgoals, yeargoals);
        backMap.put("totalgoals", totalgoals);
        backMap.put("yeargoals", yeargoals);
        return backMap;
    }

    /**
     * <p>格式化目标数据，保证年度和总体各有一条目标数据</p >
     *
     * @param
     * @author hw
     * @date 2022/9/20 17:02
     */
    public void formatGoals(List<Map<String, Object>> goals, String agencyguid, String mainguid) {
        Map<String, Object> newgoal = new HashMap<>();
        newgoal.put("agencyguid", agencyguid);
        newgoal.put("mainguid", mainguid);
        newgoal.put("createtime", StringUtil.getSysDBDate());
        newgoal.put("updatetime", StringUtil.getSysDBDate());
        newgoal.put("creater", SecureUtil.getCurrentUser().getGuid());
        newgoal.put("province", SecureUtil.getUserSelectProvince());
        newgoal.put("year", CommonUtil.getYear());
        newgoal.put("mof_div_code", SecureUtil.getUserSelectProvince());
        newgoal.put("fiscal_year", CommonUtil.getYear());
        newgoal.put("dept_code", agencyguid.substring(0, 3));
        newgoal.put("create_time", StringUtil.getSysDBDate());
        newgoal.put("update_time", StringUtil.getSysDBDate());
        newgoal.put("is_deleted", 2);
        newgoal.put("ordernum", 1);
        newgoal.put("rowtype", "add");
        if (goals.size() == 1) {
            Map<String, Object> goal = goals.get(0);
            String yearflag = goal.get("yearflag") == null ? "1" : (String) goal.get("yearflag");
            String guid = CommonUtil.createGUID();
            newgoal.put("guid", guid);
            newgoal.put("kpi_dep_id", guid);
            if ("1".equals(yearflag)) { // 有总体，添加年度
                newgoal.put("goalname", "年度目标1");
                newgoal.put("yearflag", "0");
            } else { // 有年度，添加总体
                newgoal.put("goalname", "长期目标1");
                newgoal.put("yearflag", "1");
            }
            goals.add(newgoal);
        } else if (goals.size() == 0) { // 添加总体和年度
            Map<String, Object> yeargoal = new HashMap<>();
            yeargoal.putAll(newgoal);
            String guid = CommonUtil.createGUID();
            yeargoal.put("guid", guid);
            yeargoal.put("kpi_dep_id", guid);
            yeargoal.put("goalname", "年度目标1");
            yeargoal.put("yearflag", "0");
            goals.add(yeargoal);
            Map<String, Object> totalgoal = new HashMap<>();
            totalgoal.putAll(newgoal);
            String guid1 = CommonUtil.createGUID();
            totalgoal.put("guid", guid1);
            totalgoal.put("kpi_dep_id", guid1);
            totalgoal.put("goalname", "长期目标1");
            totalgoal.put("yearflag", "1");
            goals.add(totalgoal);
        }
    }

    /**
     * <p>目标关联指标数据</p >
     *
     * @param
     * @author hw
     * @date 2022/9/20 17:02
     */
    public void setGoalIndex(StringBuffer sql, List<Map<String, Object>> goals, List totalgoals, List yeargoals) {
        String goalguid = "";
        String yearflag = "";
        List<Map<String, Object>> tempindexs = deptPerfHbTestDAO.getTempdatas(); //模板信息
        for (Map<String, Object> map : goals) { //三级指标放入目标
            //java深拷贝list方法：先序列化一下，再反序列化一下即可
            List<Map> newtempindexs = JSONObject.parseArray(JSONObject.toJSONString(tempindexs), Map.class);
            goalguid = (String) map.get("guid");
            yearflag = map.get("yearflag") == null ? "1" : (String) map.get("yearflag");
            StringBuffer sql1 = new StringBuffer(sql);
            sql1.append(" and t.kpi_dep_id = '" + goalguid + "'");
            List<Map<String, Object>> tindexs = deptPerfHbTestDAO.getDatas(deptPerfHbTestDAO.BGT_TABLE_INDICATOR, sql1.toString(), "order by sindex"); //指标
            if (tindexs != null && !tindexs.isEmpty()) {
                map.put("#indexs", tindexs);
            } else {
                newtempindexs.forEach(r -> {
                    r.put("kpi_dep_id", map.get("guid"));
                });
                map.put("#indexs", newtempindexs);
            }
            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            map.put("#delindex", new ArrayList<>()); //存放子表删除的绩效指标
            if ("1".equals(yearflag)) {
                totalgoals.add(map);
            } else {
                yeargoals.add(map);
            }
        }
    }

    /**
     * 整体的保存.
     *
     * @param params --前端的参数
     * @return --返回结果
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String mainguid = (String) params.get("mainguid");
        //全部数据
        List<Map<String, Object>> totalgoals = (List<Map<String, Object>>) params.get("totalgoals");
        List<Map<String, Object>> yeargoals = (List<Map<String, Object>>) params.get("yeargoals");
        //删除数据
        List<Map<String, Object>> deltotal = (List<Map<String, Object>>) params.get("deltotal");
        List<Map<String, Object>> delyear = (List<Map<String, Object>>) params.get("delyear");
        //新增和修改的数据
        List<Map<String, Object>> addMainlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> upMainlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> addSublist = new ArrayList<Map<String, Object>>(); //指标表新增
        List<Map<String, Object>> upSublist = new ArrayList<Map<String, Object>>(); //指标表更新
        List<Map<String, Object>> delSublist = new ArrayList<Map<String, Object>>(); //指标表新增
        //现有的数据保存.
        List<Map<String, Object>> allList = new ArrayList<>();
        if (totalgoals.size() > 0) {
            allList.addAll(totalgoals);
        }
        if (yeargoals.size() > 0) {
            allList.addAll(yeargoals);
        }
        int i = 1;
        String goalguid = "";
        String rowtype = "";
        String yearflag = "";
        String timestamp = PerfUtil.getServerTimeStamp();
        List<Map<String, Object>> tempList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> tempDelList = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : allList) {
            goalguid = (String) map.get("guid");
            rowtype = (String) map.get("rowtype");
            yearflag = (String) map.get("yearflag");
            map.put("ordernum", i++);
            map.put("updatetime",timestamp);
            map.put("update_time",timestamp);
            map.put("mainguid", mainguid);
            map.put("kpi_dep_id", map.get("guid"));
            map.put("agencyguid", saveAgency);
            if (rowtype != null && "add".equals(rowtype)){
                this.getBasMap(map, "add");
                map.put("is_last_inst",2);
                addMainlist.add(map);
            } else {
                upMainlist.add(map);
            }
            //处理子表绩效指标
            tempList = (List<Map<String, Object>>) map.get("#indexs");
            int j = 0;
            String subrowtype = "";
            for (Map<String, Object> submap : tempList) {
                subrowtype = (String) submap.get("rowtype");
                submap.put("kpi_dep_id", goalguid);
                submap.put("ordernum", j++);
                submap.put("updatetime",timestamp);
                submap.put("update_time",timestamp);
                submap.put("mainguid", mainguid);
                submap.put("agencyguid", saveAgency);
                submap.put("yearflag", yearflag);
                if (subrowtype != null && "add".equals(subrowtype)){
                    submap.put("kpi_val", submap.get("indexval"));
                    submap.put("status", "");
                    String kpievalstd = (String)submap.get("kpi_evalstd");
                    if(StringUtils.isEmpty(kpievalstd)){
                        submap.put("kpi_evalstd", 1); //评扣分标准
                    }
                    this.getBasMap(submap, "add");
                    submap.put("is_last_inst",2);//是否终审
                    submap.put("kpi_dep_id", goalguid);//湖北指标表该字段用于绑定目标，需要重新赋值
                    addSublist.add(submap);
                } else {
                    upSublist.add(submap);
                }
            }
            tempDelList = (List<Map<String, Object>>) map.get("#delindex");
            if (tempDelList.size() > 0) {
                delSublist.addAll(tempDelList);
            }
        }
        //处理主表删除
        List<Map<String, Object>> delList = new ArrayList<>();
        if (deltotal.size() > 0) {
            delList.addAll(deltotal);
        }
        if (delyear.size() > 0) {
            delList.addAll(delyear);
        }
        String tempgoalguid = "";
        List<String> delguids = new ArrayList<>();
        for (Map<String, Object> delmap : delList) {
            tempgoalguid = (String) delmap.get("guid");
            delguids.add(tempgoalguid);
        }
        //删除主表与子表
        if (delguids.size() > 0) {
            deptPerfHbTestDAO.deleteAllByColumn("guid", delguids, deptPerfHbTestDAO.BGT_TABLE_GOAL);
            deptPerfHbTestDAO.deleteAllByColumn("kpi_dep_id", delguids, deptPerfHbTestDAO.BGT_TABLE_INDICATOR);
        }
        //主表新增与修改
        if (addMainlist.size() > 0) {
            deptPerfHbTestDAO.saveAll(addMainlist, deptPerfHbTestDAO.BGT_TABLE_GOAL);
        }
        if (upMainlist.size() > 0) {
            deptPerfHbTestDAO.updateAllByPK(upMainlist, "guid", deptPerfHbTestDAO.BGT_TABLE_GOAL);
        }
        //子表的新增与修改
        if (addSublist.size() > 0) {
            deptPerfHbTestDAO.setIndexDatas(addSublist,"DEPT",false);
            deptPerfHbTestDAO.setIndexCode(addSublist);
            System.out.println("---ddSublist---" + addSublist.toString());
            deptPerfHbTestDAO.saveAll(addSublist, deptPerfHbTestDAO.BGT_TABLE_INDICATOR);
        }
        if (upSublist.size() > 0) {
            deptPerfHbTestDAO.updateAllByPK(upSublist, "guid", deptPerfHbTestDAO.BGT_TABLE_INDICATOR);
        }
        //更新二级指标编码
        deptPerfHbTestDAO.updateGroupSindx(mainguid, (String) totalgoals.get(0).get("guid"));
        deptPerfHbTestDAO.updateGroupSindx(mainguid, (String) yeargoals.get(0).get("guid"));
        //更新三级指标编码
        deptPerfHbTestDAO.updateGroupTindx(mainguid, (String) totalgoals.get(0).get("guid"));
        deptPerfHbTestDAO.updateGroupTindx(mainguid, (String) yeargoals.get(0).get("guid"));
        //子表的删除
        if (delSublist.size() > 0) {
            List<String> delsubids = new ArrayList<>();
            delSublist.forEach(r -> {
                delsubids.add((String) r.get("guid"));
            });
            deptPerfHbTestDAO.deleteAllByColumn("guid", delsubids, deptPerfHbTestDAO.BGT_TABLE_INDICATOR);
        }
        return this.auditdefine(allList, busguid, "perf", null);
    }

    /**
     * 根据主表记录查询没有记录的查询默认模板数据
     *
     * @param params --数据
     * @return
     * @throws AppException
     */
    public Map<String, Object> getSubData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String goalguid = (String) params.get("goalguid");
        List<Map<String, Object>> collist = deptPerfHbTestDAO.getCol(deptPerfHbTestDAO.BGT_TABLE_INDICATOR);
        List<Map<String, Object>> tempdatas = deptPerfHbTestDAO.getTempdatas();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            map.put("mainguid", mainguid);
            map.put("kpi_dep_id", goalguid);
            map.put("_isleaf", "1");
            backdata.add(map);
        }
        backMap.put("data", backdata);
        return backMap;
    }

    /**
     * 根据目标查询对应的指标数据
     *
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> getIndexData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String goalguid = (String) params.get("goalguid");
        String wheresql = " mainguid = '" + mainguid + "' and kpi_dep_id = '" + goalguid + "'";
        //获取模板数据
        List<Map<String, Object>> collist = deptPerfHbTestDAO.getCol(deptPerfHbTestDAO.BGT_TABLE_INDICATOR);
        List<Map<String, Object>> tempdatas = deptPerfHbTestDAO.getTempdatas();
        //指标数据
        List<Map<String, Object>> indexdatas = deptPerfHbTestDAO.getDatas("V_BGT_PERF_INDICATOR", wheresql, null);
        List<Map<String, Object>> datas = new ArrayList<>();
        //模板数据
        for (Map<String, Object> tempdata : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = tempdata.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    tempdata.put(col, "");
                }
            }
            tempdata.put("mainguid", mainguid);
            tempdata.put("kpi_dep_id", goalguid);
            tempdata.put("_isleaf", "1");
            datas.add(tempdata);
        }
        //指标数据
        for (Map<String, Object> indexdata : indexdatas) {
            datas.add(indexdata);
        }
        backMap.put("data", datas);
        return backMap;
    }

    /**
     * 导入指标
     *
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importIndexData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            List<Map<String, Object>> errorlist = this.checkImpColLength(impDatas, impCols);
            errorlist.addAll(this.checkIndexFrame(impDatas));
            if (errorlist.size() > 0) {
                throw new AppException("ANA-ERROR", "指标导入数据错误");
            } else {
                DeptPerfHbTestBO deptIndexBO = (DeptPerfHbTestBO) PerfServiceFactory.getBean("pmkpi.deptperformance.deptperftest.DeptPerfHbTestBOTX");
                deptIndexBO.impIndex(deptIndexBO, impDatas, impCols, tablecode, resultList, busParams);
            }
        }
    }

    public void impIndex(DeptPerfHbTestBO deptIndexBO, ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        DeptPerfHbTestDAO deptPerfHbTestDAO = (DeptPerfHbTestDAO) PerfServiceFactory.getBean("pmkpi.deptperformance.deptperftest.DeptPerfHbTestDAO");
        String tabtype = (String) busParams.get("tabtype");
        String proguid = (String) busParams.get("proguid");
        String goalguid = null;
        if (busParams.get("goalguid") != null) {
            goalguid = (String) busParams.get("goalguid");
        }
        List<Map<String, Object>> indexList = new ArrayList<>();
        String version = PerfUtil.getServerTimeStamp();
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> nullTemp = dss.getRangesByWhereSql("PMKPIFRAME", "frametype='DEPT'");
        Map<Object, Object> tempMap = nullTemp.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
        for (Object indexMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) indexMap;
            String guid = CommonUtil.createGUID();
            data.put("guid", guid);
            data.put("kpi_id", guid);
            data.put("mainguid", proguid);
            data.put("agency_code", SecureUtil.getCurrentUser().getUpagencyid());
            data.put("agencyguid", SecureUtil.getCurrentUser().getUpagencyid());
            if ("year".equals(tabtype)) {
                data.put("yearflag", "0");  //年度
            } else {
                data.put("yearflag", "1");  //长期
            }
            data.put("findex", data.get("findex"));
            data.put("superid", data.get("sindex"));
            data.put("sindex", data.get("sindex"));
            data.put("name", data.get("name"));
            data.put("indexval", data.get("indexval"));
            data.put("kpi_val", data.get("indexval"));
            data.put("meterunit", data.get("meterunit"));
            data.put("computesign", data.get("computesign"));
            data.put("kpi_remark", data.get("kpi_remark"));
            data.put("levelno", 3);
            data.put("is_leaf", 1);
            this.getBasMap(data, "add");
            data.put("kpi_dep_id", goalguid);  //目标主键
            data.put("is_last_inst",2);//是否终审
            indexList.add(data);
        }
        deptIndexBO.setIndexCode(indexList);
        deptPerfHbTestDAO.saveAll(indexList, "v_bgt_perf_indicator");
        //更新二级指标编码
        deptPerfHbTestDAO.updateGroupSindx(proguid, goalguid);
        //更新三级指标编码
        deptPerfHbTestDAO.updateGroupTindx(proguid, goalguid);
    }

}
