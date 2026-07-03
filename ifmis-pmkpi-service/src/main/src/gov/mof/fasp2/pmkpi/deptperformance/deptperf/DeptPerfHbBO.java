package gov.mof.fasp2.pmkpi.deptperformance.deptperf;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2022/5/11  gaoming
 */
public class DeptPerfHbBO extends PmkpiBO {

    private DeptPerfHbDAO deptPerfHbDAO;
    
    public void setDeptPerfHbDAO(DeptPerfHbDAO deptPerfHbDAO) {
        this.deptPerfHbDAO = deptPerfHbDAO;
    }

    /**
     * 查询主表目标数据.
     * @param params -- 参数。
     * @return
     * @throws AppException -- 自定义异常
     */
    public Map<String, Object> getMainDatas(HashMap<String, Object> params) throws AppException {
        Map backMap = new HashMap(); //返回消息
        String mainguid = (String)params.get("mainguid");
        String agencyguid = (String)params.get("agencyguid"); //单位
        StringBuffer sql = new StringBuffer(" t.mainguid = '" + mainguid + "'");
        String orderby = " order by ordernum";
        List<Map<String, Object>> goals = deptPerfHbDAO.getDatas(deptPerfHbDAO.BGT_TABLE_GOAL, sql.toString(), orderby); //目标
        List<Map<String, Object>> indexs = deptPerfHbDAO.getDatas(deptPerfHbDAO.BGT_TABLE_INDICATOR, sql.toString(), orderby); //指标
        //处理当前年度总体绩效不存在，从上一年复制情况。
        if (goals.size() == 0){
            List mainList = deptPerfHbDAO.getMainMap(agencyguid);
            int endyear = 0;
            if (mainList.size() > 0){
                Map mainMap = (Map) mainList.get(0);
                Object o = PerfUtil.transformUpperCase(mainMap).get("endyear");
                if (o == null) {
                    endyear= 0;
                } else {
                    endyear = Integer.parseInt(o.toString());
                }
                if (endyear >= Integer.parseInt(CommonUtil.getYear())) {
                    String upyearguid = (String) mainMap.get("guid");
                    sql = new StringBuffer(" 1=1");
                    sql.append(" and t.yearflag = '1' and t.is_deleted = 2");
                    sql.append(" and t.mainguid = '").append(upyearguid).append("'");
                    sql.append(" and t.province = '").append(CommonUtil.getProvince()).append("'");
                    goals = deptPerfHbDAO.getDatas("BGT_PERF_GOAL_INFO", sql.toString(), "");
                    indexs = deptPerfHbDAO.getDatas("BGT_PERF_INDICATOR", sql.toString(), "");
                    Map<String, String> guidsMap = new HashMap<>();
                    //处理年度与唯一主键
                    goals.forEach(r->{
                        String tempguid = StringUtil.createUUID();
                        guidsMap.put((String) r.get("guid"), tempguid);
                        r.put("guid",tempguid);
                        r.put("kpi_dep_id",tempguid);
                        r.put("mainguid",mainguid);
                        r.put("year",CommonUtil.getYear());
                        r.put("fiscal_year",CommonUtil.getYear());
                        r.put("dept_code",null);
                        r.put("rowtype","add");
                    });
                    indexs.forEach(r->{
                        String tempguid = StringUtil.createUUID();
                        r.put("guid",tempguid);
                        r.put("kpi_id",tempguid);
                        String key = (String) r.get("kpi_dep_id");
                        r.put("kpi_dep_id",guidsMap.get(key));
                        r.put("mainguid",mainguid);
                        r.put("year",CommonUtil.getYear());
                        r.put("fiscal_year",CommonUtil.getYear());
                        r.put("dept_code",null);
                        r.put("rowtype","add");
                    });
                }
            }
        }
        List<Map<String, Object>> tempdatas = deptPerfHbDAO.getTempdatas(); //模板信息
        List<Map<String, Object>> collist = deptPerfHbDAO.getCol(deptPerfHbDAO.BGT_TABLE_INDICATOR);
        List totalgoals = new ArrayList(); //总体
        List yeargoals = new ArrayList(); // 年度
        String goalguid = "";
        String sindex = null;
        String key = "";
        List goalindexs = new ArrayList(); //目标指标对应.
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>(); //
        List tempindex = new ArrayList();
        for (Map<String, Object> map : indexs) {
            goalguid = (String) map.get("kpi_dep_id");
            sindex = (String) map.get("sindex");
            key = goalguid+"#"+sindex;
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            if (indexMap.containsKey(key)){
                tempindex = indexMap.get(key);
                tempindex.add(map);
            } else {
                tempindex = new ArrayList();
                tempindex.add(map);
                indexMap.put(key, tempindex);
            }
        }
        String yearflag = "";
        for (Map<String, Object> map : goals) {
            goalguid = (String) map.get("guid");
            yearflag = map.get("yearflag") == null? "1": (String) map.get("yearflag");
            sindex ="";
            goalindexs = new ArrayList();
            List<Map> tempdatalist = new ArrayList();
            JSONArray jsonArray = JSONArray.parseArray(JSONObject.toJSONString(tempdatas));
            List<Map> jsonlist = jsonArray.toJavaList(Map.class);
            tempdatalist.addAll(jsonlist);
            for (Map<String, Object> tepmap : tempdatalist) {
                for (Map<String, Object> colmap : collist) {
                    String col = (String) colmap.get("columncode");
                    String value = tepmap.get(col) + "";
                    if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                        tepmap.put(col, "");
                    }
                }
                String levelno = tepmap.get("levelno") + "";
                goalindexs.add(tepmap);
                if (!StringUtils.isEmpty(levelno) && "2".equals(levelno)) {
                    sindex = (String) tepmap.get("guid");
                    key = goalguid+"#"+sindex;
                    if (indexMap.containsKey(key)) {
                        tempindex = indexMap.get(key);
                        goalindexs.addAll(tempindex);
                    }
                }
                tepmap.put("mainguid", mainguid);
                tepmap.put("kpi_dep_id", goalguid);
                tepmap.put("_isleaf", "1");
            }
            map.put("#indexs",goalindexs); //行级数据保存
            if ("1".equals(yearflag)){
                totalgoals.add(map);
            } else {
                yeargoals.add(map);
            }
            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            map.put("#delindex", new ArrayList<>()); //存放子表删除的绩效指标
        }
        backMap.put("totalgoals", totalgoals);
        backMap.put("yeargoals", yeargoals);
        return backMap;
    }

    /**
     * 根据主表记录查询没有记录的查询默认模板数据
     * @param params --数据
     * @return
     * @throws AppException
     */
    public Map<String, Object> getSubData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String goalguid = (String)params.get("goalguid");
        List<Map<String, Object>> collist = deptPerfHbDAO.getCol(deptPerfHbDAO.BGT_TABLE_INDICATOR);
        List<Map<String, Object>> tempdatas = deptPerfHbDAO.getTempdatas();
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
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String,Object> getIndexData(HashMap<String,Object> params) throws AppException{
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String goalguid = (String)params.get("goalguid");
        String wheresql = " mainguid = '"+mainguid+"' and kpi_dep_id = '"+goalguid+"'";
        //获取模板数据
        List<Map<String, Object>> collist = deptPerfHbDAO.getCol(deptPerfHbDAO.BGT_TABLE_INDICATOR);
        List<Map<String, Object>> tempdatas = deptPerfHbDAO.getTempdatas();
        //指标数据
        List<Map<String, Object>> indexdatas = deptPerfHbDAO.getDatas("V_BGT_PERF_INDICATOR", wheresql, null);
        List<Map<String,Object>> datas = new ArrayList<>();
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
        backMap.put("data",datas);
        return  backMap;
    }

    /**
     * 整体的保存.
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
            deptPerfHbDAO.deleteAllByColumn("guid",delguids,deptPerfHbDAO.BGT_TABLE_GOAL);
            deptPerfHbDAO.deleteAllByColumn("kpi_dep_id",delguids,deptPerfHbDAO.BGT_TABLE_INDICATOR);
        }
        //主表新增与修改
        if (addMainlist.size() > 0) {
            deptPerfHbDAO.saveAll(addMainlist, deptPerfHbDAO.BGT_TABLE_GOAL);
        }
        if (upMainlist.size() > 0) {
            deptPerfHbDAO.updateAllByPK(upMainlist, "guid", deptPerfHbDAO.BGT_TABLE_GOAL);
        }
        //子表的新增与修改
        if (addSublist.size() > 0) {
            deptPerfHbDAO.setIndexDatas(addSublist,"DEPT",false);
            deptPerfHbDAO.setIndexCode(addSublist);
            deptPerfHbDAO.saveAll(addSublist, deptPerfHbDAO.BGT_TABLE_INDICATOR);
        }
        if (upSublist.size() > 0) {
            deptPerfHbDAO.updateAllByPK(upSublist, "guid", deptPerfHbDAO.BGT_TABLE_INDICATOR);
        }
        //子表的删除
        if (delSublist.size() > 0){
            List<String> delsubids = new ArrayList<>();
            delSublist.forEach(r->{
                delsubids.add((String) r.get("guid"));
            });
            deptPerfHbDAO.deleteAllByColumn("guid",delsubids,deptPerfHbDAO.BGT_TABLE_INDICATOR);
        }
        return this.auditdefine(allList, busguid,"perf", null);
    }

    /**
     * 导入指标
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
                DeptPerfHbBO deptIndexBO = (DeptPerfHbBO) PerfServiceFactory.getBean("pmkpi.deptperformance.deptperf.DeptPerfHbBOTX");
                //DeptPerfHbBO deptIndexBO = (DeptPerfHbBO) PerfServiceFactory.getBean("pmkpi.deptperformance.index.DeptPerfHbBOTX");
                deptIndexBO.impIndex(deptIndexBO, impDatas, impCols, tablecode, resultList, busParams);
            }
        }
    }

    public void impIndex(DeptPerfHbBO deptIndexBO, ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        //DeptPerfHbDAO deptPerfHbDAO = (DeptPerfHbDAO) PerfServiceFactory.getBean("pmkpi.deptperformance.index.deptPerfHbDAO");
        DeptPerfHbDAO deptPerfHbDAO = (DeptPerfHbDAO) PerfServiceFactory.getBean("pmkpi.deptperformance.deptperf.DeptPerfHbDAO");
        String tabtype = (String) busParams.get("tabtype");
        String proguid = (String) busParams.get("proguid");
        String goalguid =null;
        if(busParams.get("goalguid") != null){
            goalguid = (String) busParams.get("goalguid");
        }
        List<Map<String, Object>> indexList = new ArrayList<>();
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
            }else {
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
        deptIndexBO.setIndexDatas(indexList,"DEPT",false);
        deptIndexBO.setIndexCode(indexList);
        deptPerfHbDAO.saveAll(indexList, "v_bgt_perf_indicator");
    }
}
