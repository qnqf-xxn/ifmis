package gov.mof.fasp2.pmkpi.adjust.deptadjperf;

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
public class DtPerfAdjBO extends PmkpiBO {

    private DtPerfAdjDAO dtPerfAdjDAO;

    public void setDtPerfAdjDAO(DtPerfAdjDAO dtPerfAdjDAO) {
        this.dtPerfAdjDAO = dtPerfAdjDAO;
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
        String proguid = (String)params.get("proguid"); //部门整体申报GUID
        StringBuffer sql = new StringBuffer(" t.mainguid = '" + mainguid + "'");
        String orderby = " order by ordernum";
        List<Map<String, Object>> goals = dtPerfAdjDAO.getDatas(dtPerfAdjDAO.BGT_TABLE_GOAL, sql.toString(), orderby); //目标
        List<Map<String, Object>> indexs = dtPerfAdjDAO.getDatas(dtPerfAdjDAO.BGT_TABLE_INDICATOR, sql.toString(), orderby); //指标
        //处理当前调整信息表中不存在，则从申报环节获取数据.
        if (goals.size() == 0){
            sql = new StringBuffer(" mainguid = '").append(proguid).append("'");
            goals = dtPerfAdjDAO.getDatas("V_BGT_PERF_GOAL_INFO", sql.toString(), orderby);
            indexs = dtPerfAdjDAO.getDatas("V_BGT_PERF_INDICATOR", sql.toString(), orderby);
            Map<String, String> guidsMap = new HashMap<>();
            //处理年度与唯一主键
            goals.forEach(r->{
                String tempguid = StringUtil.createUUID();
                guidsMap.put((String) r.get("guid"), tempguid);
                r.put("guid",tempguid);
                r.put("goalguid",tempguid);
                r.put("mainguid",mainguid);
                r.put("year",CommonUtil.getYear());
                r.put("fiscal_year",CommonUtil.getYear());
                r.put("rowtype","add");
                r.put("status","");
            });
            indexs.forEach(r->{
                String tempguid = StringUtil.createUUID();
                r.put("guid",tempguid);
                r.put("kpi_id",tempguid);
                String key = (String) r.get("kpi_dep_id");
                r.put("goalguid",guidsMap.get(key));
                r.put("mainguid",mainguid);
                r.put("year",CommonUtil.getYear());
                r.put("fiscal_year",CommonUtil.getYear());
                r.put("rowtype","add");
                r.put("status","");
            });
        }
        List<Map<String, Object>> tempdatas = dtPerfAdjDAO.getTempdatas(); //模板信息
        List<Map<String, Object>> collist = dtPerfAdjDAO.getCol(dtPerfAdjDAO.BGT_TABLE_INDICATOR);
        List totalgoals = new ArrayList(); //总体
        List yeargoals = new ArrayList(); // 年度
        String goalguid = "";
        String sindex = null;
        String key = "";
        List goalindexs = new ArrayList(); //目标指标对应.
        String status = "";
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>(); //
        List tempindex = new ArrayList();
        for (Map<String, Object> map : indexs) {
            goalguid = (String) map.get("goalguid");
            sindex = (String) map.get("sindex");
            status = map.get("status") + "";
            key = goalguid+"#"+sindex;
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            if ("1".equals(status)) {
                map.put("obligate1", "撤销删除");
            } else{
                map.put("obligate1", "删除");
            }
            if (map.get("status") == null){
                map.put("status","");
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
            status = map.get("status") + "";
            if ("1".equals(status)) {
                map.put("obligate1", "撤销删除");
            } else{
                map.put("obligate1", "");
            }
            if (map.get("status") == null){
                map.put("status","");
            }
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
                    tepmap.put("obligate1", "新增");
                } else {
                    tepmap.put("obligate1", "");
                }
                tepmap.put("mainguid", mainguid);
                tepmap.put("goalguid", goalguid);
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
            //map.put("#delindex", new ArrayList<>()); //调整逻辑整体全部直接删除,不用记录那条删除
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
        List<Map<String, Object>> collist = dtPerfAdjDAO.getCol(dtPerfAdjDAO.BGT_TABLE_INDICATOR);
        List<Map<String, Object>> tempdatas = dtPerfAdjDAO.getTempdatas();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        String levelno = "";
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            levelno = map.get("levelno") + "";
            if (!StringUtils.isEmpty(levelno) && "2".equals(levelno)) {
                map.put("obligate1", "新增");
            } else {
                map.put("obligate1", "");
            }
            map.put("mainguid", mainguid);
            map.put("goalguid", goalguid);
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
        List<Map<String, Object>> collist = dtPerfAdjDAO.getCol(dtPerfAdjDAO.BGT_TABLE_INDICATOR);
        List<Map<String, Object>> tempdatas = dtPerfAdjDAO.getTempdatas();
        //指标数据
        List<Map<String, Object>> indexdatas = dtPerfAdjDAO.getDatas("V_BGT_PERF_INDICATOR", wheresql, null);
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
            tempdata.put("goalguid", goalguid);
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
     * 调整整体的保存.
     * @param params --前端的参数
     * @return --返回结果
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String mainguid = (String) params.get("mainguid");
        String proguid = (String) params.get("proguid"); //申报阶段的数据来源.
        //全部数据
        List<Map<String, Object>> totalgoals = (List<Map<String, Object>>) params.get("totalgoals");
        List<Map<String, Object>> yeargoals = (List<Map<String, Object>>) params.get("yeargoals");
        //主子表的全数据
        List<Map<String, Object>> mainlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> sublist = new ArrayList<Map<String, Object>>();
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
        for (Map<String, Object> map : allList) {
            goalguid = (String) map.get("guid");
            yearflag = (String) map.get("yearflag");
            map.put("ordernum", i++);
            map.put("mainguid", mainguid);
            map.put("proguid", proguid);
            map.put("kpi_dep_id", map.get("guid"));
            map.put("kpi_per_id", map.get("guid"));
            map.put("agencyguid", saveAgency);
            map.put("dept_code", saveAgency.substring(0,3));
            map.put("create_time",timestamp);
            map.put("createtime",timestamp);
            map.put("creater",SecureUtil.getCurrentUser().getGuid());
            map.put("is_deleted","2");
            map.put("year", CommonUtil.getYear());
            map.put("province", CommonUtil.getProvince());
            map.put("fiscal_year", CommonUtil.getYear());
            map.put("mof_div_code", CommonUtil.getProvince());
            map.put("version", timestamp);
            map.put("version_name", "部门绩效目标调整_"+timestamp);
            map.put("updatetime",timestamp);
            map.put("update_time",timestamp);
            mainlist.add(map);
            //处理子表绩效指标
            tempList = (List<Map<String, Object>>) map.get("#indexs");
            int j = 0;
            String levelno = "";
            for (Map<String, Object> submap : tempList) {
                levelno = submap.get("levelno") + "";
                if (levelno != null && "3".equals(levelno)) {
                    String indexguid = (String) submap.get("indexguid");
                    if (indexguid != null && ! indexguid.isEmpty()) {
                        submap.put("tindex", map.get("indexguid"));
                    }
                    submap.put("guid", this.getCreateguid());
                    submap.put("goalguid", goalguid);
                    submap.put("ordernum", j++);
                    submap.put("updatetime",timestamp);
                    submap.put("update_time",timestamp);
                    submap.put("mainguid", mainguid);
                    submap.put("proguid", proguid);
                    submap.put("agencyguid", saveAgency);
                    submap.put("yearflag", yearflag);
                    submap.put("dept_code", saveAgency.substring(0,3));
                    submap.put("create_time",timestamp);
                    submap.put("createtime",timestamp);
                    submap.put("creater",SecureUtil.getCurrentUser().getGuid());
                    submap.put("is_deleted","2");
                    submap.put("year", CommonUtil.getYear());
                    submap.put("province", CommonUtil.getProvince());
                    submap.put("fiscal_year", CommonUtil.getYear());
                    submap.put("mof_div_code", CommonUtil.getProvince());
                    submap.put("kpi_lv1", submap.get("findex"));
                    submap.put("kpi_lv2", submap.get("sindex"));
                    submap.put("kpi_val", submap.get("indexval"));
                    submap.put("kpi_id", submap.get("guid"));
                    submap.put("kpi_evalstd", submap.get("kpi_evalstd")); //评扣分标准
                    submap.put("version", timestamp);
                    submap.put("version_name", "部门绩效标调整_"+timestamp);
                    sublist.add(submap);
                }
            }
        }
        //处理主表逻辑
        String delsql = " mainguid='" + mainguid + "'";
        dtPerfAdjDAO.delDatas(DtPerfAdjDAO.BGT_TABLE_GOAL, delsql);
        dtPerfAdjDAO.saveAll(mainlist, DtPerfAdjDAO.BGT_TABLE_GOAL);
        //子表的处理逻辑
        dtPerfAdjDAO.setIndexCode(sublist);
        this.setIndexDatas(sublist, "DEPT", false);
        dtPerfAdjDAO.delDatas(DtPerfAdjDAO.BGT_TABLE_INDICATOR, delsql);
        dtPerfAdjDAO.saveAll(sublist, DtPerfAdjDAO.BGT_TABLE_INDICATOR);
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
                DtPerfAdjBO deptIndexBO = (DtPerfAdjBO) PerfServiceFactory.getBean("pmkpi.deptperformance.deptperf.DtPerfAdjBOTX");
                //DtPerfAdjBO deptIndexBO = (DtPerfAdjBO) PerfServiceFactory.getBean("pmkpi.deptperformance.index.DtPerfAdjBOTX");
                deptIndexBO.impIndex(deptIndexBO, impDatas, impCols, tablecode, resultList, busParams);
            }
        }
    }

    public void impIndex(DtPerfAdjBO deptIndexBO, ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        //dtPerfAdjDAO dtPerfAdjDAO = (dtPerfAdjDAO) PerfServiceFactory.getBean("pmkpi.deptperformance.index.dtPerfAdjDAO");
        DtPerfAdjDAO dtPerfAdjDAO = (DtPerfAdjDAO) PerfServiceFactory.getBean("pmkpi.deptperformance.deptperf.dtPerfAdjDAO");
        String tabtype = (String) busParams.get("tabtype");
        String proguid = (String) busParams.get("proguid");
        String goalguid =null;
        if(busParams.get("goalguid") != null){
            goalguid = (String) busParams.get("goalguid");
        }
        List<Map<String, Object>> indexList = new ArrayList<>();
        String version = PerfUtil.getServerTimeStamp();
        for (Object indexMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) indexMap;
            String guid = CommonUtil.createGUID();
            data.put("guid", guid);
            data.put("kpi_id", guid);
            data.put("mainguid", proguid);
            data.put("version_name", "部门录入");
            data.put("version", version);
            data.put("agency_code", SecureUtil.getCurrentUser().getUpagencyid());
            data.put("agencyguid", SecureUtil.getCurrentUser().getUpagencyid());
            data.put("updatetime", PerfUtil.getServerTimeStamp());
            data.put("update_time", PerfUtil.getServerTimeStamp());
            data.put("createtime", PerfUtil.getServerTimeStamp());
            data.put("creater", SecureUtil.getCurrentUserID());
            data.put("province", SecureUtil.getUserSelectProvince());
            data.put("year", CommonUtil.getYear());
            if ("year".equals(tabtype)) {
                data.put("yearflag", "0");  //年度
            }else {
                data.put("yearflag", "1");  //长期
            }
//                    String number = "000000000";
//                    data.put("code", number);
//                    data.put("kpi_lv3", number);
            data.put("kpi_lv1", data.get("findex"));
            data.put("findex", data.get("findex"));
            data.put("superid", data.get("sindex"));
            data.put("sindex", data.get("sindex"));
            data.put("kpi_lv2", data.get("sindex"));
            data.put("name", data.get("name"));
            data.put("indexval", data.get("indexval"));
            data.put("kpi_val", data.get("indexval"));
            data.put("meterunit", data.get("meterunit"));
            data.put("computesign", data.get("computesign"));
            data.put("kpi_remark", data.get("kpi_remark"));
            data.put("levelno", 3);
            data.put("is_leaf", 1);
            this.getBasMap(data, "add");
            data.put("fiscal_year", SecureUtil.getUserSelectYear()); //财政年度
            data.put("kpi_dep_id", goalguid);  //目标主键
            indexList.add(data);
        }
        deptIndexBO.setIndexCode(indexList);
        dtPerfAdjDAO.saveAll(indexList, "v_bgt_perf_indicator");
    }
}
