package gov.mof.fasp2.pmkpi.adjust.index;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdjustIndexBO extends PmkpiBO {
    private AdjustIndexDAO adjustIndexDAO;

    public void setAdjustIndexDAO(AdjustIndexDAO adjustIndexDAO) {
        this.adjustIndexDAO = adjustIndexDAO;
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
        String proguid = (String)params.get("proguid");
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String)params.get("tablesql");
        String bustype = (String)params.get("bustype");
        String procode = (String) params.get("procode");
        String indexsql = " t.mainguid = '" + mainguid + "'";
        String orderby = " order by ordernum";
        String type = "";
        String filter = "";
        if ("dept".equals(bustype) || "depttrace".equals(bustype)) {
            type = "DEPT";
            filter = " mainguid='" + proguid + "' ";
        } else if ("program".equals(bustype) || "protrace".equals(bustype)) {
            type = "PM001";
            if(PerfUtil.getIsHbei()){
                filter = " mainguid='" + proguid + "' ";
            }else {
                filter = " pro_code='" + procode + "' ";
            }
        }
        if ("program".equals(bustype) || PerfUtil.getIS_HUBEI()) {
            filter += " and yearflag = '0' ";
        }
        String queryYear = (String) params.get("queryYear");
        String queryProvince = (String) params.get("queryProvince");
        if (!StringUtil.isNullOrEmpty(queryYear) && !StringUtil.isNullOrEmpty(queryProvince)) {
            this.setYearAndProvince(queryYear, queryProvince);
        }
        List<Map<String, Object>> collist = adjustIndexDAO.getCol(adjustIndexDAO.TABLE_INDEX);
        List<Map<String, Object>> indexs = adjustIndexDAO.getDatas(adjustIndexDAO.TABLE_INDEX, indexsql, orderby);
        if (indexs == null || indexs.size() <= 0) {
            indexsql = filter;
            if (tablesql != null && ! tablesql.isEmpty()) {
                indexsql += " and " + tablesql;
            }
            tablecode = "(select a.*,guid indexguid,weight as adjustweight from " + tablecode +" a)";
            indexs = adjustIndexDAO.getDatas(tablecode, indexsql, orderby);
            for (Map<String, Object> map : indexs){
                map.put("guid", this.getCreateguid());
                map.put("status", "");
                map.put("rowtype", "add");
                map.put("is_add", "2"); //非新增指标.
            }
        }
        List<Map<String, Object>> tempdatas = adjustIndexDAO.getTempdatas(type);
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        Map<String, Object> sumMap = new HashMap<String, Object>();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        List<Map<String, Object>> tempList = null;
        String iszj = PerfUtil.getSystemSet("isZJ");
        String sindex = "";
        String findex = "";
        String fsuperid = "";
        String ssuperid = "";
        float sweightsum = 0;
        float fweightsum = 0;
        for (Map<String, Object> map : indexs) {
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            String status = map.get("status") + "";
            if ("1".equals(status)) {
                map.put("obligate1", "撤销删除");
            } else if (!"1".equals(status)) {
                if(PerfUtil.getIsHbei() && ("149999".equals(map.get("code")) || "项目或定额成本控制率".equals(map.get("name")))){
                    map.put("obligate1", "");
                }else if(PerfUtil.getIsTianJin() && "1".equals(map.get("isunmod"))){//天津模式，河北一体化来源指标不可删除修改
                    map.put("obligate1", "");
                }else if(PerfUtil.getIsGuangXi() && "1".equals(map.get("isfromparent")+"")){//广西模式，一级项目指标来源指标不可删除修改
                    map.put("obligate1", "");
                }else {
                    map.put("obligate1", "删除");
                }
            }
            findex = (String) map.get("findex");
            sindex = (String) map.get("sindex");
            String weight = map.get("weight") + "";
            if (findex.equals(fsuperid)) {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    Float num = Float.parseFloat(weight);
                    fweightsum = fweightsum + num;
                    fweightsum=(float)(Math.round(fweightsum*100))/100;
                }
            } else {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    if (ssuperid != null && !"null".equals(ssuperid) && !ssuperid.isEmpty()) {
                        if (fsuperid != null && !"null".equals(fsuperid) && !fsuperid.isEmpty()) {
                            fweightsum = 0;
                        }
                    }
                    Float num = Float.parseFloat(weight);
                    fweightsum =  + num;
                    fweightsum=(float)(Math.round(fweightsum*100))/100;
                }
            }
            if (sindex.equals(ssuperid)) {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    Float num = Float.parseFloat(weight);
                    sweightsum = sweightsum + num;
                    sweightsum=(float)(Math.round(sweightsum*100))/100;
                }
            } else {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    if (ssuperid != null && !"null".equals(ssuperid) && !ssuperid.isEmpty()) {
                        if (fsuperid != null && !"null".equals(fsuperid) && !fsuperid.isEmpty()) {
                            sweightsum = 0;
                        }
                    }
                    Float num = Float.parseFloat(weight);
                    sweightsum = num;
                    sweightsum=(float)(Math.round(sweightsum*100))/100;
                }
            }
            map.put("superid", sindex);
            if (!indexMap.containsKey(sindex)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(sindex, tempList);
            } else {
                tempList = indexMap.get(sindex);
            }
            tempList.add(map);

            ssuperid = sindex;
            fsuperid = findex;
            sumMap.put(sindex, sweightsum);
            sumMap.put(findex, fweightsum);

        }
        for (Map<String, Object> map : tempdatas) {
            map.put("indexguid", "");
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || value.isEmpty() || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            map.put("isleaf", "0");
            map.put("_isleaf", "0");
            String levelno = map.get("levelno") + "";
            if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                sindex = (String) map.get("guid");
                if (!"1".equals(iszj)) {
                    map.put("obligate1", "新增");
                }
                map.put("weight",sumMap.get(sindex));
            } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                findex = (String) map.get("guid");
                map.put("obligate1", "");
                map.put("weight",sumMap.get(findex));
                sindex = "";
            } else {
                sindex = "";
            }
            if (indexMap.containsKey(sindex)) {
                tempList = indexMap.get(sindex);
                backdata.addAll(tempList);
            }
            backdata.add(map);
        }
        backMap.put("data", backdata);
        return backMap;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = adjustIndexDAO.TABLE_INDEX;
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String proguid = (String) params.get("proguid");
        String bustype = (String) params.get("bustype");
        String procode = (String) params.get("procode");
        String queryYear = (String) params.get("queryYear");
        String queryProvince = (String) params.get("queryProvince");
        if (!StringUtil.isNullOrEmpty(queryYear) && !StringUtil.isNullOrEmpty(queryProvince)) {
            this.setYearAndProvince(queryYear, queryProvince);
        }
        this.setProAgencyName(params);
        String saveAgency = (String) params.get("saveAgency");
        String pro_name = (String) params.get("pro_name");
        String agency_name = (String) params.get("agency_name");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> list = new ArrayList<>();
        List<String> delguids = (List<String>) params.get("delguids");
        List<Map<String, Object>> addList = new ArrayList<>();
        List<Map<String, Object>> upList = new ArrayList<>();
        List<Map<String, Object>> busList = new ArrayList<>();
        String frametype = "";
        if ("dept".equals(bustype) || "depttrace".equals(bustype)) {
            frametype = "DEPT";
        } else if ("program".equals(bustype) || "protrace".equals(bustype)) {
            frametype = "PM001";
        }
        int i = 1;
        if(datas != null && datas.size() > 0){
            if (PerfUtil.getIsuCheckIndexName()) { // 是否校验三级指标名称重复
                //删除指标不参与校验  status = 1
                List<Map<String, Object>> checkdatas = new ArrayList<Map<String, Object>>();
                for (Map<String, Object> map : datas) {
                    String status = map.get("status") + "";
                    if(!"1".equals(status)){
                        checkdatas.add(map);
                    }
                }
                //校验指标名称不可重复
                Map<String, Object> nameDupCheckMap = this.nameDuplicateCheck(checkdatas);
                if(nameDupCheckMap != null && !nameDupCheckMap.isEmpty() && nameDupCheckMap.get("success").equals(false)){
                    return nameDupCheckMap;
                }
            }
        }
        for (Map<String, Object> map : datas) {
            String levelno = map.get("levelno") + "";
            String rowtype = (String) map.get("rowtype");
            if ("3".equals(levelno)) {
                if ("program".equals(bustype) || "protrace".equals(bustype)) {
                    map.put("pro_code", procode);
                    map.put("pro_name", pro_name);
                }
                if (!StringUtil.isNullOrEmpty(agency_name)) {
                    map.put("agency_name", agency_name);
                }
                if ("add".equals(rowtype)) {
                    String weight = null;
                    String weightindex = map.get("weight") + "";
                    if (weightindex != null && !weightindex.isEmpty() && !"null".equals(weightindex)) {
                        weight = map.get("weight").toString();
                        map.put("weight", Float.parseFloat(weight));
                    }
                    if (weight==null||weight.isEmpty()){
                        map.put("weight", 0);
                    }
                    String indexguid = (String) map.get("indexguid");
                    if (indexguid != null && ! indexguid.isEmpty()) {
                        map.put("tindex", map.get("indexguid"));
                    }
                    map.put("guid", this.getCreateguid());
                    map.put("ordernum", i++);
                    map.put("proguid", proguid);
                    map.put("mainguid", mainguid);
                    map.put("yearflag", 0);
                    map.put("is_last_inst", 2);
                    map.put("agencyguid", saveAgency);
                    map.put("kpi_val", map.get("indexval"));
                    map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                    map.put("queryYear", queryYear);
                    map.put("queryProvince", queryProvince);
                    this.getBasMap(map,"add");
                    addList.add(map);
                } else {
                    map.put("update_time", PerfUtil.getServerTimeStamp());
                    map.put("updatetime", PerfUtil.getServerTimeStamp());
                    upList.add(map);
                }
                busList.add(map);
                list.add(map);
            }
        }
        if (delguids.size() > 0) {
            adjustIndexDAO.deleteAllByColumn("guid", delguids, tablecode);
        }
        if (upList.size() > 0) {
            this.setIndexDatas(upList, frametype, false);
            adjustIndexDAO.updateAll(upList, tablecode);
        }
        if (addList.size() > 0) {
            adjustIndexDAO.setIndexCode(addList);
            this.setIndexDatas(addList, frametype, false);
            adjustIndexDAO.saveAll(addList, tablecode);
        }
        return this.auditdefine(list, busguid,"perf", null);
    }

    /**
     * 获取项目名称和单位名称
     * @param params
     */
    public void setProAgencyName(Map<String, Object> params){
        String procode = (String) params.get("procode"); //项目编码
        String pro_name = (String) params.get("pro_name");//项目名称
        if (!StringUtil.isEmpty(procode) && StringUtil.isEmpty(pro_name)) {
            String wheresql = "t.pro_code = '" + procode + "'";
            Map<String, Object> proMap = adjustIndexDAO.getDataMap(adjustIndexDAO.PMKPI_TABLE_PROJECT_INFO, wheresql);
            if (!proMap.isEmpty()) {
                pro_name = (String) proMap.get("pro_name");
                String saveAgency = (String) proMap.get("agency_code");
                String agency_name = (String) proMap.get("agency_name");
                params.put("pro_name", pro_name);
                params.put("agency_name", agency_name);
                params.put("saveAgency", saveAgency);
            }
        }
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
        String proguid = (String)params.get("proguid");
        String procode = (String) params.get("procode");
        String agencyguid = (String)params.get("agencyguid"); //单位
        StringBuffer sql = new StringBuffer(" t.mainguid = '" + mainguid + "' and yearflag = '0' and is_deleted = 2");
        String orderby = " order by ordernum";
        List<Map<String, Object>> goals = adjustIndexDAO.getDatas(adjustIndexDAO.TABLE_GOAL, sql.toString(), orderby); //目标
        List<Map<String, Object>> indexs = adjustIndexDAO.getDatas(adjustIndexDAO.TABLE_INDEX, sql.toString(), orderby); //指标
        StringBuffer pmsql = new StringBuffer(" t.mainguid = '" + proguid + "' and yearflag = '0' ");
        if (goals == null || goals.size() <= 0) {//如果不存在目标数据  则查询项目申报表
            goals = adjustIndexDAO.getDatas("v_pm_perf_goal_info", pmsql.toString(), null); //目标
            indexs = adjustIndexDAO.getDatas("v_pm_perf_indicator", pmsql.toString(), null); //指标
            indexs.forEach(r->{
                r.put("is_add","2");
            });
        }
        List<Map<String, Object>> tempdatas = adjustIndexDAO.getTempdatas("PM001"); //模板信息
        List<Map<String, Object>> collist = adjustIndexDAO.getCol(adjustIndexDAO.TABLE_INDEX);
        List yeargoals = new ArrayList(); // 年度
        String goalguid = "";
        String sindex = null;
        String key = "";
        List goalindexs = new ArrayList(); //目标指标对应.
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>(); //
        List tempindex = new ArrayList();
        for (Map<String, Object> map : indexs) {
            goalguid = (String) map.get("goalguid");
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
                tepmap.put("goalguid", goalguid);
                tepmap.put("_isleaf", "1");
            }
            map.put("#indexs",goalindexs); //行级数据保存
            yeargoals.add(map);

            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            map.put("#delindex", new ArrayList<>()); //存放子表删除的绩效指标
            String is_deleted = String.valueOf(map.get("is_deleted"));
            if(map.get("adjustndgoal")!= null && map.get("status")== null && "2".equals(is_deleted)){//年度绩效目标(调整后)不为空标记为"修改"
                map.put("status", 2);//修改
            }
            if("1".equals(is_deleted)){//删除状态标记为删除,操作列增加"撤销删除"功能
                map.put("status", 1);
                map.put("obligate1", "撤销删除");
            }
        }
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
        List<Map<String, Object>> collist = adjustIndexDAO.getCol(adjustIndexDAO.TABLE_INDEX);
        List<Map<String, Object>> tempdatas = adjustIndexDAO.getTempdatas("PM001");
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
            map.put("goalguid", goalguid);
            map.put("_isleaf", "1");
            map.put("is_add", "2");
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
        String wheresql = " mainguid = '"+mainguid+"' and goalguid = '"+goalguid+"' and yearflag = '0'";
        //获取模板数据
        List<Map<String, Object>> collist = adjustIndexDAO.getCol(adjustIndexDAO.TABLE_INDEX);
        List<Map<String, Object>> tempdatas = adjustIndexDAO.getTempdatas("PM001");
        //指标数据
        List<Map<String, Object>> indexdatas = adjustIndexDAO.getDatas(adjustIndexDAO.TABLE_INDEX, wheresql, null);
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
            datas.add(tempdata);
        }
        //指标数据
        for (Map<String, Object> indexdata : indexdatas) {
            indexdata.put("goalguid",goalguid);
            datas.add(indexdata);
        }
        backMap.put("data",datas);
        return  backMap;
    }


    /**
     * 湖北调整目标指标保存.
     * @param params --前端的参数
     * @return --返回结果
     */
    public Map<String, Object> saveGoalAndIndex(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String mainguid = (String) params.get("mainguid");
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode");
        String pro_name = (String) params.get("pro_name");
        String bustype = (String) params.get("bustype");
        //全部数据
        List<Map<String, Object>> yeargoals = (List<Map<String, Object>>) params.get("yeargoals");
        //删除数据
        List<Map<String, Object>> delyear = (List<Map<String, Object>>) params.get("delyear");
        //新增和修改的数据
        List<Map<String, Object>> addMainlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> upMainlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> addSublist = new ArrayList<Map<String, Object>>(); //指标表新增
        List<Map<String, Object>> upSublist = new ArrayList<Map<String, Object>>(); //指标表更新
        List<Map<String, Object>> delSublist = new ArrayList<Map<String, Object>>(); //指标表新增
        //现有的数据保存.
        List<Map<String, Object>> allList = new ArrayList<>();
        if (yeargoals.size() > 0) {
            allList.addAll(yeargoals);
        }
        String frametype = "";
        if ("dept".equals(bustype) || "depttrace".equals(bustype)) {
            frametype = "DEPT";
        } else if ("program".equals(bustype) || "protrace".equals(bustype)) {
            frametype = "PM001";
        }
        int i = 1;
        String goalguid = "";
        String rowtype = "";
        List<Map<String, Object>> tempList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> tempDelList = new ArrayList<Map<String, Object>>();
        HashMap<String,String> goalguidMap = new HashMap<String,String>();
         for (Map<String, Object> map : allList) {
            goalguid = (String) map.get("guid");
            rowtype = (String) map.get("rowtype");
            String kpi_target = (String) map.get("kpi_target");
            if (kpi_target == null || kpi_target.isEmpty()) {
                map.put("kpi_target", " ");
            }
            map.put("ordernum", i++);
            map.put("mainguid", mainguid);
            map.put("agencyguid", saveAgency);
            map.put("proguid", proguid);
            map.put("pro_code", procode);
            map.put("yearflag", "0");
            map.put("pro_name", pro_name);
            map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            map.put("is_last_inst", 2);
            if (rowtype != null && "add".equals(rowtype)){
                String newguid = this.getCreateguid();
                goalguidMap.put(goalguid,newguid);
                map.put("guid", newguid);
                this.getBasMap(map, "add");
                addMainlist.add(map);
            } else {
                //根据id查询有无数据
                String guid = String.valueOf(map.get("guid"));
                StringBuffer sql = new StringBuffer("select * from "+adjustIndexDAO.TABLE_GOAL+" where guid = '"+guid+"'");
                List list = adjustIndexDAO.queryForList(sql.toString());
                if(list!= null && list.size()>0){
                    upMainlist.add(map);
                }else{
                    String newguid = this.getCreateguid();
                    goalguidMap.put(goalguid,newguid);
                    map.put("guid", newguid);
                    this.getBasMap(map, "add");
                    addMainlist.add(map);
                }
            }
            //处理子表绩效指标
            tempList = (List<Map<String, Object>>) map.get("#indexs");
            int j = 0;
            String subrowtype = "";
            for (Map<String, Object> submap : tempList) {
                String levelno = String.valueOf(submap.get("levelno"));
                if(levelno != null && "3".equals(levelno)) {
                    subrowtype = (String) submap.get("rowtype");
                    submap.put("goalguid", goalguidMap.get(goalguid) == null ? goalguid : goalguidMap.get(goalguid));
                    submap.put("ordernum", j++);
                    submap.put("proguid", proguid);
                    submap.put("pro_code", procode);
                    submap.put("mainguid", mainguid);
                    submap.put("yearflag", 0);
                    submap.put("agencyguid", saveAgency);
                    submap.put("kpi_val", submap.get("indexval"));
                    submap.put("pro_name", pro_name);
                    submap.put("is_last_inst", 2);
                    submap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                    submap.put(frametype, submap);
                    if (rowtype != null && "add".equals(subrowtype)) {
                        this.getBasMap(submap, "add");
                        addSublist.add(submap);
                    } else {
                        //根据id查询有无数据
                        String guid = String.valueOf(submap.get("guid"));
                        StringBuffer sql = new StringBuffer("select * from " + adjustIndexDAO.TABLE_INDEX + " where guid = '" + guid + "'");
                        List list = adjustIndexDAO.queryForList(sql.toString());
                        if (list != null && list.size() > 0) {
                            upSublist.add(submap);
                        } else {
                            this.getBasMap(submap, "add");
                            addSublist.add(submap);
                        }
                    }
                }
            }
            tempDelList = (List<Map<String, Object>>) map.get("#delindex");
            if (tempDelList.size() > 0) {
                delSublist.addAll(tempDelList);
            }
        }
        //处理主表删除
        List<Map<String, Object>> delList = new ArrayList<>();
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
            adjustIndexDAO.deleteAllByColumn("guid",delguids,adjustIndexDAO.TABLE_GOAL);
            adjustIndexDAO.deleteAllByColumn("goalguid",delguids,adjustIndexDAO.TABLE_INDEX);
        }
        //主表新增与修改
        if (addMainlist.size() > 0) {
            adjustIndexDAO.saveAll(addMainlist, adjustIndexDAO.TABLE_GOAL);
        }
        if (upMainlist.size() > 0) {
            adjustIndexDAO.updateAllByPK(upMainlist, "guid", adjustIndexDAO.TABLE_GOAL);
        }
        //子表的新增与修改
        if (addSublist.size() > 0) {
            adjustIndexDAO.setIndexCode(addSublist);
            this.setIndexDatas(addSublist, frametype, false);
            adjustIndexDAO.saveAll(addSublist, adjustIndexDAO.TABLE_INDEX);
        }
        if (upSublist.size() > 0) {
            this.setIndexDatas(upSublist, frametype, false);
            adjustIndexDAO.updateAllByPK(upSublist, "guid", adjustIndexDAO.TABLE_INDEX);
        }
        //子表的删除
        if (delSublist.size() > 0){
            List<String> delsubids = new ArrayList<>();
            delSublist.forEach(r->{
                delsubids.add((String) r.get("guid"));
            });
            adjustIndexDAO.deleteAllByColumn("guid",delsubids,adjustIndexDAO.TABLE_INDEX);
        }
        return this.auditdefine(allList, busguid,"perf", null);
    }
}
