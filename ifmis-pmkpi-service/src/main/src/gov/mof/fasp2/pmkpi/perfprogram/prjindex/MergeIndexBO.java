/**
 * @Title: PrjIndexBO.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexBO
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-1-6 上午10:41:23
 */

public class MergeIndexBO extends PmkpiBO {

    /**
     * 贵州kpi_lv2_id转换
     */
    public final static Map<String,String> indexcodeMap = new HashMap();
    static {
        indexcodeMap.put("1", "AF2AD8E6-A8BF-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("11", "AF2AD8E6-A8C0-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("12", "AF2AD8E6-A8C1-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("13", "AF2AD8E6-A8C2-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("14", "AF2AD8E6-A8C3-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("2", "AF2AD8E6-A8C4-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("21", "AF2AD8E6-A8C5-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("22", "AF2AD8E6-A8C6-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("23", "AF2AD8E6-A8C7-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("24", "AF2AD8E6-A8C8-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("3", "AF2AD8E6-A8C9-00E0-E053-0A20000DCEDF");
        indexcodeMap.put("31", "AF2AD8E6-A8CA-00E0-E053-0A20000DCEDF");
    }

    /**
     * mergeIndexDAO.
     */
    private MergeIndexDAO mergeIndexDAO;

    /**
     * 注入mergeIndexDAO.
     * @param mergeIndexDAO
     */
    public void setMergeIndexDAO(MergeIndexDAO mergeIndexDAO) {
        this.mergeIndexDAO = mergeIndexDAO;
    }
    /**
     * 查询各年度数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> findYearIndexs(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String selectbillguid = (String) params.get("selectbillguid");//调整前的guid
        String adjadd = (String) params.get("adjadd");//是否调整
        List<Map<String, Object>> indexs = null;
        if ("1".equals(adjadd)) {
            indexs = mergeIndexDAO.findIndexs(proguid,"v_pm_perf_indicator");
            if(indexs.size()<= 0){
                indexs = mergeIndexDAO.findIndexs(selectbillguid,"v_pm_perf_indicator");
            }
        }else{
            indexs = mergeIndexDAO.findIndexs(proguid,"v_pm_perf_indicator");
        }
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String sindex = "";
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode("PM_PERF_INDICATOR");
        List diccolumn = new ArrayList<String>();
        for (DicColumnDTO dicColumnDTO : dicColumnDTOs) {
            diccolumn.add(dicColumnDTO.get("dbcolumncode"));
        }
        for (Map<String, Object> map : indexs) {
            sindex = (String) map.get("sindex");
            keycode = sindex;
            if (!indexMap.containsKey(keycode)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(keycode, tempList);
            } else {
                tempList = indexMap.get(keycode);
            }
            tempList.add(map);
        }
        List<Map<String, Object>> nullTemp = mergeIndexDAO.findNullTemp(proguid); //空指标模板
        List<Map<String, Object>> backindex = new ArrayList<Map<String,Object>>(); //返回指标
        for (Map<String, Object> map : nullTemp) {
            sindex = (String) map.get("sindex");
            map.put("guid",this.getCreateguid());
            map.put("is_add","2");
            map.put("zqindexval", "");
            map.put("zqmeterunit", "");
            map.put("zqcomputesign", "");
            map.put("adjoption","");
            map.put("options","");
            keycode = sindex;
            if (indexMap.containsKey(keycode)) {
                tempList = indexMap.get(keycode);
                backindex.addAll(tempList);
            } else {
                backindex.add(map);
                for (Map<String, Object> bacmap : backindex) {
                    for (int i = 0;i< diccolumn.size();i++) {
                        String col = (String) diccolumn.get(i);
                        if(!bacmap.containsKey(col)){
                            bacmap.put(col.toLowerCase(), null);
                        }
                    }
                }

            }
        }
        yearsMap.put("#index", backindex);
        return yearsMap;
    }
    /**
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("projguid");
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String isshowedit = (String) params.get("isshowedit");
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        Map<String, Object> promap = mergeIndexDAO.queryForMap("select * from v_perf_project_info t where t.guid='" + proguid + "'");
        String tablecode = "";
        if (isshowedit != null && "2".equals(isshowedit)) {
            tablecode = "v_pm_perf_goal_info";
            Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
            String wheresql = " mainguid='" + proguid + "'";
            int i = mergeIndexDAO.getDataCount(tablecode, wheresql);
            editinfo.put("updatetime", PerfUtil.getServerTimeStamp());
            editinfo.put("update_time", PerfUtil.getServerTimeStamp());
            if (i > 0) {
                List<String> cols = new ArrayList<String>(editinfo.keySet());
                mergeIndexDAO.update(cols, editinfo, tablecode);
            } else {
                editinfo.put("guid", this.getCreateguid());
                editinfo.put("creater", SecureUtil.getCurrentUserID());
                editinfo.put("province", SecureUtil.getUserSelectProvince());
                editinfo.put("year", CommonUtil.getYear());
                editinfo.put("createtime", PerfUtil.getServerTimeStamp());
                editinfo.put("agencyguid", saveAgency);
                editinfo.put("mainguid", proguid);
                editinfo.put("kpi_per_id", editinfo.get("guid"));
                editinfo.put("pro_code", promap.get("pro_code"));
                editinfo.put("create_time", PerfUtil.getServerTimeStamp());
                editinfo.put("agency_code", saveAgency);
                editinfo.put("mof_div_code", SecureUtil.getUserSelectProvince());
                editinfo.put("fiscal_year", CommonUtil.getYear());
                mergeIndexDAO.save(editinfo, tablecode);
            }
        }
        int i = 0;
        int j = 0;
        for (Map<String, Object> map : datas) {
            String name=map.get("name").toString();
            j++;
            if (name != null && !name.isEmpty()) {
                ++i;
                map.put("ordernum", j);
                map.put("province", CommonUtil.getProvince());
                map.put("guid", CommonUtil.createGUID());
                map.put("prjguid", proguid);
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("year", CommonUtil.getYear());
                map.put("agencyguid", saveAgency);
                map.put("mainguid", proguid);
                map.put("kpi_id", map.get("guid"));
                map.put("pro_code", promap.get("pro_code"));
                map.put("kpi_lv1", map.get("findex"));
                map.put("kpi_lv2", map.get("sindex"));
                map.put("kpi_val", map.get("indexval"));
                map.put("update_time", PerfUtil.getServerTimeStamp());
                map.put("create_time", PerfUtil.getServerTimeStamp());
                map.put("agency_code", saveAgency);
                map.put("mof_div_code", SecureUtil.getUserSelectProvince());
                map.put("fiscal_year", CommonUtil.getYear());
                String version= (String) map.get("version");
                if (version == null || version.isEmpty()) {
                    map.put("version", PerfUtil.getServerTimeStamp());
                }
                String versionName = (String) map.get("version_name");
                if (versionName == null || versionName.isEmpty()) {
                    map.put("version_name", "版本号");
                }
                String isDeleted = (String) map.get("is_deleted");
                if (isDeleted == null || isDeleted.isEmpty()) {
                    map.put("is_deleted", "2");
                }
                indexList.add(map);
            }
        }
        mergeIndexDAO.setIndexCode(indexList);
        //删除保存
        tablecode = "v_pm_perf_indicator";
        mergeIndexDAO.delTargets(tablecode, proguid);
        mergeIndexDAO.saveAll(indexList,tablecode);
        return this.auditdefine(indexList, busguid,"perf", null);
    }
    /**
     * 获取符号的值集.
     * @return
     * @throws
     */
    public Map<String, Object> queryComputesign() {
        Map<String, Object> computesignMap = new HashMap<String, Object>();
        List<Map<String, Object>> list = mergeIndexDAO.queryComputesign();
        for (Map<String, Object> map : list) {
            computesignMap.put((String) map.get("guid"), map);
        }
        return computesignMap;
    }
    /**
     * 挑选指标走此，分页.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        StringBuffer sql = new StringBuffer();
        String filer = (String)sqlmap.get("filter");
        String sindex = (String)sqlmap.get("sindex");//二级指标.
        String saveAgency = (String)sqlmap.get("saveAgency");
        String pagetype = (String)sqlmap.get("pagetype"); //指标查询类型
        String proguid = (String)sqlmap.get("proguid"); //指标查询类型
        if (pagetype != null && "lastindex".equals(pagetype)){
            sql.append(" select * from pm_perf_indicator p where yearflag = 0 and province = '").append(SecureUtil.getUserSelectProvince()).append("' ");
            sql.append(" and year = ").append(SecureUtil.getUserSelectYear()-1);
            sql.append(" and is_backup=2 and is_deleted=2");
            sql.append(" and mainguid = '").append(proguid).append("'");
        } else {
            sql.append(" select * from V_BAS_PERF_INDICATOR p where 1=1 ");
        /*sql.append(" where (p.agencyguid in ( select c.guid from pmkpi_fasp_t_pubagency c where (c.guid = '").append(saveAgency).append("' or c.superguid = '");
        sql.append(saveAgency).append("'))").append(" or p.agencyguid = '#')");*/
            if ("pickindex".equals(pagetype)) { //挑选指标才添加二级
                sql.append(" and (p.agency_code is null or (p.agency_code = '");
                sql.append(saveAgency);
                sql.append("' and p.wfstatus = '011')  )");
                if (sindex != null && !sindex.isEmpty()) {
                    sql.append(" and p.sindex = '").append(sindex).append("'");
                }
            } else { //指标推荐
                String guid = (String)sqlmap.get("guid"); //推荐指标中,左侧树选中节点
                String iscommon = (String)sqlmap.get("iscommon");
                int isleaf = PerfUtil.mapGetInt(sqlmap,"isleaf");//是否末级节点
                if (iscommon != null && "1".equals(iscommon)) {
                    sql.append(" and p.is_common_ind = '1'");
                    if (guid != null && !"idexcomcls".equals(guid)) {
                        sql.append(" and p.projtype= '").append(guid).append("'");
                    }
                } else {
                    sql.append(" and nvl(p.is_common_ind,'0') <> '1'");
                    if (!"indexcomfunc".equals(guid) && isleaf==1 ){
                        sql.append(" and p.industrycategory= '").append(guid).append("'");
                    } else if (!"indexcomfunc".equals(guid) && isleaf !=1 ){
                        sql.append(" and p.indexcategories= '").append(guid).append("'");
                    }
                }
            }
        }
        if (!StringUtil.isEmpty(filer)) {
            sql.append(" and ").append(filer);
        }
        //sql.append(" order by p.updatetime");
        return sql.toString();
    }
    /**
     * 推荐指标,查询左侧案例模板指标.
     * @param config --参数配置.
     * @return
     * @throws AppException -- 异常.
     * @throws
     */
    public Map finTreeData(HashMap config) throws AppException{
        String tabcode = (String)config.get("tabcode");
        String tabfilter = (String)config.get("tabfilter");//页签配置的过滤
        String condition = (String)config.get("condition");//过滤条件
        String tablecode = "";
        if (tabcode != null && "case".equals(tabcode)) {
            tablecode = "v_perf_t_case";
            condition = " and framesystem = 'PM001'";
        } else if (tabcode != null && "mode".equals(tabcode)) {
            tablecode = "v_perf_t_model";
            condition = " and framesystem = 'PM001'";
        } else if (tabcode != null && "index".equals(tabcode)) {
            tablecode = "v_perf_t_index";
        } else {
            logger.debug("请配置对应的选择页签!");
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            condition += tabfilter;
        }
        List list = mergeIndexDAO.finTreeData(tablecode, condition);
        HashMap map = new HashMap();
        try {
            map.put("datalist", JsonUtils.ListToRecordSet(list));
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
        return map;
    }

    /**
     * 查询案例和模板的明细数据.
     * @param params -- 参数.
     * @return tempMap -- 返回参数.
     * @throws AppException -- 异常.
     * @throws
     */
    public Map<String, Object> findTableData(Map<String, Object> params) throws AppException {
        Map<String, Object> tempMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid"); //主键
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        List<Map<String, Object>> indexs = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        indexs = mergeIndexDAO.findIndexs(mainguid,"v_perf_t_casemodelindex");
//        List<Map<String, Object>> tempList = null;
//        String sindex = "";
//        for (Map<String, Object> map : indexs) {
//            sindex = (String) map.get("sindex");
//            if (!indexMap.containsKey(sindex)) {
//                tempList = new ArrayList<Map<String, Object>>();
//                indexMap.put(sindex, tempList);
//            } else {
//                tempList = indexMap.get(sindex);
//            }
//            tempList.add(map);
//        }
//        List<Map<String, Object>> pmframes = mergeIndexDAO.findNullTemp(mainguid); //体系
//        for (Map<String, Object> map : pmframes) {
//            sindex = (String) map.get("sindex");
//            if (indexMap.containsKey(sindex)) {
//                tempList = indexMap.get(sindex);
//                backdata.addAll(tempList);
//            } else {
//                backdata.add(map);
//            }
//        }
        backdata.addAll(indexs);
        tempMap.put("data", backdata);
        return tempMap;
    }
    /**获取部门guid
     *
     * @param agencyguid
     * @return
     */
    public List<Map<String, Object>> getDeptGuid(String agencyguid) {
        return mergeIndexDAO.getDeptGuid(agencyguid);
    }

    /**
     * 校验指标.
     * @param prolist --
     * @param busguid --
     * @return --
     * @throws AppException --
     */
    public Map checkIndex(List<Map<String, Object>> prolist, String busguid) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try {
            remp = this.auditdefine(prolist, busguid, "perf", null);
        } catch (PerfAppException e) {
            remp = e.getRemap();
            remp.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return remp;
    }

    /**
     * 查询各年度数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> findAllIndex(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String showtab = (String) params.get("showtab"); ////页签显示 1总+年2总3年
        String isbefore = (String) params.get("isbefore"); // 1 显示事前，0 不显示
        String procat = (String) params.get("procat");
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String sindex = "";
        String yearflag = "0";
        String tabfiler = "";
        List<Map<String, Object>> indexs = new ArrayList<>();
        List<Map<String, Object>> goals = new ArrayList<>();
        List<Map<String, Object>> totalgoal = new ArrayList<>();//总体目标
        List<Map<String, Object>> yeargoal = new ArrayList<>();//年度目标
        List<Map<String, Object>> totalindexs = new ArrayList<>();//总体指标
        List<Map<String, Object>> yearindexs = new ArrayList<>();//年度指标
        String tablecode = "v_pm_perf_indicator";
        String goaltable = "v_pm_perf_goal_info";
        //项目库不分年度，总体目标指标根据区划查询物理表
        String province = SecureUtil.getUserSelectProvince();
        if (showtab != null && "1".equals(showtab)) {
            tabfiler = " nvl(yearflag,'0') = '1' and t.is_deleted = '2' and t.is_backup=2 and t.province = '"+province+"'";
            totalindexs = mergeIndexDAO.findIndexsByFilter(proguid,"pm_perf_indicator", tabfiler);
            totalgoal = mergeIndexDAO.getGoalsByFilter(proguid, "pm_perf_goal_info", tabfiler);
            tabfiler = " nvl(yearflag,'0') = '0'";
            yearindexs = mergeIndexDAO.findIndexsByFilter(proguid,tablecode, tabfiler);
            yeargoal = mergeIndexDAO.getGoalsByFilter(proguid, goaltable, tabfiler);
        } else if (showtab != null && "2".equals(showtab)) {
            tabfiler = " nvl(yearflag,'0') = '1'  and t.is_deleted = '2' and t.is_backup =2 and t.province = '"+province+"'";
            totalindexs = mergeIndexDAO.findIndexsByFilter(proguid,"pm_perf_indicator", tabfiler);
            totalgoal = mergeIndexDAO.getGoalsByFilter(proguid, "pm_perf_goal_info", tabfiler);
        } else {
            tabfiler = " nvl(yearflag,'0') = '0'";
            yearindexs = mergeIndexDAO.findIndexsByFilter(proguid,tablecode, tabfiler);
            yeargoal = mergeIndexDAO.getGoalsByFilter(proguid, goaltable, tabfiler);
        }
        List<Map<String, Object>> tempIndexList = new ArrayList<>();
        if ((totalindexs != null && totalindexs.size() > 0)) {
            indexs.addAll(totalindexs);
        }
        if ((totalgoal != null && totalgoal.size() > 0)) {
            goals.addAll(totalgoal);
        }
        if (totalindexs.size() ==0  && "1".equals(procat)){ //河北项目类别 人员
            tempIndexList = mergeIndexDAO.findMouldByFilter("5200901",null);
            indexs = PerfUtil.lowMapKey(tempIndexList);
        }
        if (totalindexs.size() ==0  && "3".equals(procat)){ //河北项目类别 公用
            tempIndexList = mergeIndexDAO.findMouldByFilter("5200902",null);
            indexs = PerfUtil.lowMapKey(tempIndexList);
        }
        if (totalindexs.size() ==0  && ("4".equals(procat) || "5".equals(procat))){
            Map catmap = new HashMap();
            catmap.put("isleaf","1");
            catmap.put("rowtype","add");
            catmap.put("yearflag","1");
            catmap.put("code","149999");
            catmap.put("ordernum","1");
            catmap.put("superid","14");
            catmap.put("levelno","3");
            catmap.put("computesign","3");
            catmap.put("meterunit","%");
            catmap.put("kpi_lv1","1");
            catmap.put("kpi_lv2","14");
            catmap.put("kpi_val","100");
            catmap.put("kpi_remark","项目或定额成本控制率");
            catmap.put("findex","1");
            catmap.put("sindex","14");
            catmap.put("name","项目或定额成本控制率");
            catmap.put("indexval","100");
            indexs.add(catmap);
        }
        List<Map<String, Object>> tempgoalslist = new ArrayList<>();
        if (totalgoal.size() ==0  && "1".equals(procat)){ //河北项目类别 人员
            tempgoalslist = mergeIndexDAO.getMouldGoalByFilter("5200901",null);
            goals = PerfUtil.lowMapKey(tempgoalslist);
        }
        if (totalgoal.size() ==0  && "3".equals(procat)){ //河北项目类别 公用
            tempgoalslist = mergeIndexDAO.getMouldGoalByFilter("5200902",null);
            goals = PerfUtil.lowMapKey(tempgoalslist);
        }
        if ((yearindexs != null && yearindexs.size() > 0)) {
            indexs.addAll(yearindexs);
        }
        if ((yeargoal != null && yeargoal.size() > 0)) {
            goals.addAll(yeargoal);
        }
        if (yearindexs.size() ==0  && ("4".equals(procat) || "5".equals(procat))){
            Map catmap = new HashMap();
            catmap.put("isleaf","1");
            catmap.put("rowtype","add");
            catmap.put("yearflag","0");
            catmap.put("code","149999");
            catmap.put("ordernum","1");
            catmap.put("superid","14");
            catmap.put("levelno","3");
            catmap.put("computesign","3");
            catmap.put("meterunit","%");
            catmap.put("kpi_lv1","1");
            catmap.put("kpi_lv2","14");
            catmap.put("kpi_val","100");
            catmap.put("kpi_remark","项目或定额成本控制率");
            catmap.put("findex","1");
            catmap.put("sindex","14");
            catmap.put("name","项目或定额成本控制率");
            catmap.put("indexval","100");
            indexs.add(catmap);
        }
        List<Map<String, Object>> nullTemp = mergeIndexDAO.getTempdatas(proguid); //空指标模板
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        // 区分项目多页签指标
        for (Map<String, Object> map : indexs) {
            yearflag = (String) map.get("yearflag") == null ? "0" : (String) map.get("yearflag") ;
            sindex = (String) map.get("sindex");
            keycode = sindex+"&"+yearflag;
            if (!indexMap.containsKey(keycode)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(keycode, tempList);
            } else {
                tempList = indexMap.get(keycode);
            }
            map.put("_isleaf", "1");
            if (map.get("guid") == null){ //固定模板的是空
                map.put("guid", StringUtil.createUUID());
            }
            tempList.add(map);
        }
        // 区分项目空模板赋值，不然没有共有字段不显示
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode("V_PM_PERF_INDICATOR");
        for (Map<String, Object> map : nullTemp) {
            for (DicColumnDTO dicdto : dicColumnDTOs) {
                if(!map.containsKey(dicdto.getDbcolumncode())){
                    map.put(dicdto.getDbcolumncode().toLowerCase(), "");
                }
            }
        }
        //处理项目目标总体
        Map<String, Object> goalMap = new HashMap<String, Object>();
        for (Map<String, Object> map : goals) {
            yearflag = (String) map.get("yearflag");
            if (StringUtil.isEmpty(yearflag)){
                yearflag ="0";
            }
            goalMap.put(yearflag, map);
        }
        //处理绩效指标
        List<Map<String, Object>> nullindex = null; //空模板
        List<Map<String, Object>> backindex = null; //返回指标
        if (showtab != null && "1".equals(showtab)) {
            nullindex =(List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            backindex = new ArrayList<Map<String,Object>>();
            for (Map<String, Object> map : nullindex) {
                map.put("_isleaf", "1");
                sindex = (String) map.get("sindex");
                //map.put("guid",this.getCreateguid());
                keycode = sindex+"&1";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#total", backindex); //项目总体
            String tempkpimain = "";
            if (goalMap.containsKey("1")){
                yearsMap.put("#goaltotal", goalMap.get("1"));
                Map<String, Object> goalTempMap = (Map<String, Object>) goalMap.get("1");
                tempkpimain = (String) (goalTempMap.get("kpimainid") == null ? "": goalTempMap.get("kpimainid"));
            } else {
                yearsMap.put("#goaltotal", new HashMap<>());
            }
            yearsMap.put("#kpimaintotal",tempkpimain);
            nullindex =(List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            backindex = new ArrayList<Map<String,Object>>();
            for (Map<String, Object> map : nullindex) {
                map.put("_isleaf", "1");
                sindex = (String) map.get("sindex");
                //map.put("guid",this.getCreateguid());
                keycode = sindex+"&0";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#year", backindex);//年度
            tempkpimain = "";
            if (goalMap.containsKey("0")){
                yearsMap.put("#goalyear", goalMap.get("0"));
                Map<String, Object> goalTempMap = (Map<String, Object>) goalMap.get("0");
                tempkpimain = (String) (goalTempMap.get("kpimainid") == null ? "": goalTempMap.get("kpimainid"));
            } else {
                yearsMap.put("#goalyear", new HashMap<>());
            }
            yearsMap.put("#kpimainyear",tempkpimain);
        } else if (!StringUtil.isEmpty(showtab) && "2".equals(showtab)) {
            nullindex =(List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            backindex = new ArrayList<Map<String,Object>>();
            for (Map<String, Object> map : nullindex) {
                sindex = (String) map.get("sindex");
                map.put("_isleaf", "1");
                //map.put("guid",this.getCreateguid());
                keycode = sindex+"&1";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#total", backindex); //项目总体
            String tempkpimain = "";
            if (goalMap.containsKey("1")){
                yearsMap.put("#goaltotal", goalMap.get("1"));
                Map<String, Object> goalTempMap = (Map<String, Object>) goalMap.get("1");
                tempkpimain = (String) (goalTempMap.get("kpimainid") == null ? "": goalTempMap.get("kpimainid"));
            } else {
                yearsMap.put("#goaltotal", new HashMap<>());
            }
            yearsMap.put("#kpimaintotal",tempkpimain);
        } else {
            nullindex =(List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            backindex = new ArrayList<Map<String,Object>>();
            for (Map<String, Object> map : nullindex) {
                sindex = (String) map.get("sindex");
                map.put("_isleaf", "1");
                //map.put("guid",this.getCreateguid());
                keycode = sindex+"&0";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#year", backindex);//年度
            String tempkpimain = "";
            if (goalMap.containsKey("0")){
                yearsMap.put("#goalyear", goalMap.get("0"));
                Map<String, Object> goalTempMap = (Map<String, Object>) goalMap.get("0");
                tempkpimain = (String) (goalTempMap.get("kpimainid") == null ? "": goalTempMap.get("kpimainid"));
            } else {
                yearsMap.put("#goalyear", new HashMap<>());
            }
            yearsMap.put("#kpimainyear",tempkpimain);
        }
        //获取事前绩效评估内容
        if (!StringUtil.isEmpty(isbefore) && "1".equals(isbefore)) {
            List<Map<String, Object>> beforedatas = this.getBeforeData(proguid);
            yearsMap.put("#before", beforedatas);
        }
        return yearsMap;
    }

    /**
     * 获取事前绩效评估数据.
     * @param projguid -- 项目guid》
     * @return list.
     * @throws AppException
     */
    public List<Map<String, Object>> getBeforeData(String projguid) throws AppException {
        String wheresql = " t.projguid = '" + projguid + "'";
        String province = SecureUtil.getUserSelectProvince();
        List<Map<String, Object>>  data = mergeIndexDAO.getDatas("V_PERF_T_ADVEVAINFO", wheresql, "order by ordernum");
        if(data.size()<1){
            data = mergeIndexDAO.getDatas("V_PERF_T_SCORE_TEMPLATEDETAIL", " t.module_id = 'sqpg"+province+"'", "order by ordernum");
            for (Map<String, Object> map : data) {
                map.put("guid", this.getCreateguid());
                map.put("projguid", projguid);
                map.put("option_value", "");
                map.put("unit_since_score","");
                map.put("score_shows", "");
                map.put("eval_option_value", "");
                map.put("eval_score", "");
                map.put("eval_score_shows", "");
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", province);
                map.put("year", CommonUtil.getYear());
            }
        } else {
            for (Map<String, Object> map : data) {
                if (map.get("option_value") == null){
                    map.put("option_value", "");
                }
                if (map.get("unit_since_score") == null){
                    map.put("unit_since_score", "");
                }
                if (map.get("score_shows") == null){
                    map.put("score_shows", "");
                }
            }
        }
        return data;
    }

    /**
     * 获取空指标模板显示.
     * @param list -- 原模板.
     * @param tempMap -- 要付的值.
     * @return tempList.
     * @throws
     */
    private List<Map<String, Object>> getIndexList(List<Map<String, Object>> list, Map<String, Object> tempMap) {
        List<Map<String, Object>> tempList = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(list);
        for (Map<String, Object> map : tempList) {
            map.putAll(tempMap);
            map.put("guid", this.getCreateguid());
        }
        return tempList;
    }

    /**
     * 绩效制度表树级展示保存.
     * @param params -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> savePrjTreeIndex(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("projguid");

        String saveAgency = (String) params.get("saveAgency");
        String showtab = (String) params.get("showtab"); //页签显示 1总+年2总3年
        String procode = (String) params.get("procode"); //项目编码
//        String procat = (String) params.get("procat"); //项目类别
        String isedittotal = (String) params.get("isedittotal"); //1不可编辑，0 可编辑
        String isbefore = (String) params.get("isbefore"); //事前评估. 1 显示保存，0 不显示
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        Map<String, Object> tabcomps = (Map<String, Object>) params.get("datas"); //多页签的数据
        String proname = "";
        if (StringUtil.isEmpty(procode)){
            Map<String, Object> promap = mergeIndexDAO.getDataMap("v_perf_project_info", "t.guid='" + proguid + "'");
            procode = (String) promap.get("pro_code");
            if (StringUtil.isEmpty(saveAgency)){ //单位
                saveAgency = (String) promap.get("agency_code");
            }
            proname = (String) promap.get("pro_name");
        }
        List<Map<String, Object>> addList = new ArrayList<Map<String, Object>>(); //新增
        List<Map<String, Object>> modList = new ArrayList<Map<String, Object>>(); // 修改
        List<Map<String, Object>> addGoalList = new ArrayList<Map<String, Object>>(); //目标新增
        List<Map<String, Object>> modGoalList = new ArrayList<Map<String, Object>>(); //目标修改
        //项目库不分年度，需要把总体指标目标特殊处理（修改物理表）
        List<Map<String, Object>> modTotalList = new ArrayList<Map<String, Object>>(); // 修改总体指标

        List<Map<String, Object>> addYearGoalList = new ArrayList<Map<String, Object>>(); //年度目标新增
        List<Map<String, Object>> addTotalGoalList = new ArrayList<Map<String, Object>>(); //总体目标新增
        List<Map<String, Object>> modTotalGoalList = new ArrayList<Map<String, Object>>(); //总体目标修改
        List<Map<String, Object>> totalindexList = new ArrayList<Map<String, Object>>(); //总体指标集合
        List<Map<String, Object>> yearindexList = new ArrayList<Map<String, Object>>(); //年度指标集合
        List<String> delList = new ArrayList<String>(); // 删除
        String levelno  =  "";
        String indexname = "";
        String rowtype = "";
        String tablecode = "v_pm_perf_indicator";
        String goaltablecode = "v_pm_perf_goal_info";
        int i = 0;
        int j = 0;
        if (showtab != null && ("1".equals(showtab) || "2".equals(showtab)) && (isedittotal == null || !"1".equals(isedittotal)) ) { // 总+年
            List<String> delTotalList = (List<String>) tabcomps.get("del#total");
            if (delTotalList.size() > 0){
                //delList.addAll(delTotalList);
                //项目库项目年度滚动，不分年度，删除物理表
                this.delIndex(delTotalList, "pm_perf_indicator", proguid);
            }
            List<Map<String, Object>> totalList = (List<Map<String, Object>>) tabcomps.get("#total");
            for(Map tempMap : totalList){
                i++;
                levelno = PerfUtil.mapGetInt(tempMap,"levelno") + "";
                indexname = (String) tempMap.get("name");
                rowtype = (String) tempMap.get("rowtype");
                String version = PerfUtil.getServerTimeStamp();
                String busi_type_code = (String) tempMap.get("busi_type_code");
                if(!StringUtil.isEmpty(busi_type_code) && "2".equals(busi_type_code)){
                    continue;
                }
                if (levelno != null && "3".equals(levelno) && !StringUtil.isEmpty(indexname)) {
                    tempMap.put("mainguid", proguid);
                    tempMap.put("ordernum",i);
                    tempMap.put("yearflag","1");
                    tempMap.put("kpi_val", tempMap.get("indexval"));
                    if (rowtype != null && "add".equals(rowtype)) {
                        tempMap.put("version_name", "项目绩效指标录入");
                        tempMap.put("version", version);
                        tempMap.put("agency_code", saveAgency);
                        tempMap.put("pro_code", procode);
                        tempMap.put("prjguid", proguid);
                        tempMap.put("agencyguid", saveAgency);
                        tempMap.put("busi_type", "1");
                        tempMap.put("busi_type_code", "1");
                        this.setIndexMap(tempMap);
                        addList.add(tempMap);
                    } else {
                        tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
                        tempMap.put("update_time", PerfUtil.getServerTimeStamp());
                        modTotalList.add(tempMap);
                    }
                    totalindexList.add(tempMap); //用于反写接口
                    indexList.add(tempMap); //用于审核定义
                }
            }
            // 绩效目标
            Map<String, Object> goaltotalmap = (Map<String, Object>) tabcomps.get("#goaltotal");
            String guid = (String) goaltotalmap.get("guid");
            goaltotalmap.put("pro_code", procode);
            goaltotalmap.put("update_time", PerfUtil.getServerTimeStamp());
            goaltotalmap.put("updatetime", PerfUtil.getServerTimeStamp());
            goaltotalmap.put("agencyguid", saveAgency);
            goaltotalmap.put("agency_code", saveAgency);
            goaltotalmap.put("mainguid", proguid);
            goaltotalmap.put("proguid", proguid);
            if (StringUtil.isEmpty(guid)){ //新增
                String version = PerfUtil.getServerTimeStamp();
                String tempguid = StringUtil.createUUID();
                goaltotalmap.put("guid", tempguid);
                goaltotalmap.put("kpi_per_id", tempguid);
                goaltotalmap.put("mof_div_code", SecureUtil.getUserSelectProvince());
                goaltotalmap.put("fiscal_year", CommonUtil.getYear());
                goaltotalmap.put("version_name", "项目总体绩效目标录入");
                goaltotalmap.put("version", version);
                goaltotalmap.put("busi_type", "1");
                goaltotalmap.put("yearflag","1");
                goaltotalmap.put("creater", SecureUtil.getCurrentUserID());
                goaltotalmap.put("province", SecureUtil.getUserSelectProvince());
                goaltotalmap.put("year", CommonUtil.getYear());
                goaltotalmap.put("createtime", PerfUtil.getServerTimeStamp());
                goaltotalmap.put("create_time", PerfUtil.getServerTimeStamp());
                goaltotalmap.put("is_deleted", 2);
                addGoalList.add(goaltotalmap);
                addTotalGoalList.add(goaltotalmap);
            } else { //修改
                goaltotalmap.put("yearflag","1");
                modTotalGoalList.add(goaltotalmap);
            }
        }
        if (showtab != null && ("1".equals(showtab) || "3".equals(showtab))) { // 年
            List<String> delYearList = (List<String>) tabcomps.get("del#year");
            if (delYearList != null && delYearList.size() > 0) {
                delList.addAll(delYearList);
            }
            List<Map<String, Object>> yearList = (List<Map<String, Object>>) tabcomps.get("#year");
            String version = PerfUtil.getServerTimeStamp();
            for(Map tempMap : yearList){
                j++;
                levelno = PerfUtil.mapGetInt(tempMap,"levelno") + "";
                indexname = (String) tempMap.get("name");
                rowtype = (String) tempMap.get("rowtype");
                String busi_type_code = (String) tempMap.get("busi_type_code");
                if(!StringUtil.isEmpty(busi_type_code) && "1".equals(busi_type_code)){
                    continue;
                }
                if (levelno != null && "3".equals(levelno) && !StringUtil.isEmpty(indexname)) {
                    tempMap.put("mainguid", proguid);
                    tempMap.put("ordernum",j);
                    tempMap.put("yearflag","0");
                    tempMap.put("kpi_val", tempMap.get("indexval"));
                    if (rowtype != null && "add".equals(rowtype)) {
                        tempMap.put("version_name", "项目录入");
                        tempMap.put("version", version);
                        tempMap.put("agency_code", saveAgency);
                        tempMap.put("pro_code", procode);
                        tempMap.put("prjguid", proguid);
                        tempMap.put("agencyguid", saveAgency);
                        tempMap.put("busi_type", "2");
                        tempMap.put("busi_type_code", "2");
                        this.setIndexMap(tempMap);
                        addList.add(tempMap);
                    } else {
                        tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
                        tempMap.put("update_time", PerfUtil.getServerTimeStamp());
                        modList.add(tempMap);
                    }
                    yearindexList.add(tempMap); //用于反写接口
                    indexList.add(tempMap); //用于审核定义
                }
            }
            // 绩效目标
            Map<String, Object> goalyearmap = (Map<String, Object>) tabcomps.get("#goalyear");
            String guid = (String) goalyearmap.get("guid");
            goalyearmap.put("pro_code", procode);
            goalyearmap.put("update_time", PerfUtil.getServerTimeStamp());
            goalyearmap.put("updatetime", PerfUtil.getServerTimeStamp());
            goalyearmap.put("agencyguid", saveAgency);
            goalyearmap.put("agency_code", saveAgency);
            goalyearmap.put("mainguid", proguid);
            goalyearmap.put("proguid", proguid);
            if (StringUtil.isEmpty(guid)){ //新增
                String tempguid = StringUtil.createUUID();
                goalyearmap.put("guid", tempguid);
                goalyearmap.put("kpi_per_id", tempguid);
                goalyearmap.put("mof_div_code", SecureUtil.getUserSelectProvince());
                goalyearmap.put("fiscal_year", CommonUtil.getYear());
                goalyearmap.put("version_name", "项目年度绩效目标录入");
                goalyearmap.put("version", version);
                goalyearmap.put("busi_type", "2");
                goalyearmap.put("yearflag","0");
                goalyearmap.put("creater", SecureUtil.getCurrentUserID());
                goalyearmap.put("province", SecureUtil.getUserSelectProvince());
                goalyearmap.put("year", CommonUtil.getYear());
                goalyearmap.put("createtime", PerfUtil.getServerTimeStamp());
                goalyearmap.put("create_time", PerfUtil.getServerTimeStamp());
                goalyearmap.put("is_deleted", 2);
                addGoalList.add(goalyearmap);
                addYearGoalList.add(goalyearmap);
            } else { //修改
                goalyearmap.put("yearflag","0");
                modGoalList.add(goalyearmap);
            }
        }
        Map<String,Object> returnMap = this.checkColLength(indexList);
        if(returnMap.size() > 0){
            return returnMap;
        }
        //删除
        int a = 0;
        if (delList != null && delList.size() > 0) {
            StringBuffer indexguids = new StringBuffer("");
            for(String tempguid : delList){
                if (a == 0){indexguids.append("'");}
                indexguids.append(tempguid);
                indexguids.append("','");
                a++;
            }
            if (indexguids != null && indexguids.length() > 0) {
                String guids = indexguids.substring(0,indexguids.length()-2);
                mergeIndexDAO.delIndexByguid(tablecode, guids, proguid);
            }
        }
        //修改
        if (modList != null && modList.size() > 0) {
            List<String>  cols = new ArrayList<String>();
            IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
            List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode(tablecode.toUpperCase());
            for (DicColumnDTO dicdto : dicColumnDTOs) {
                cols.add(dicdto.getDbcolumncode());
            }
            mergeIndexDAO.updateAll(cols, modList, tablecode);
        }
        if (addList != null && addList.size() > 0) {
            mergeIndexDAO.setIndexCode(addList);
            mergeIndexDAO.saveAll(addList,tablecode);
        }
        //处理绩效目标保存
        if (addGoalList != null && addGoalList.size() > 0) {
            mergeIndexDAO.saveAll(addGoalList, goaltablecode); //目标暂存表
        }
        if (modGoalList != null && modGoalList.size() > 0) {
            mergeIndexDAO.updateAll(modGoalList, goaltablecode);
        }
        //modTotalList
        //项目库不分年度，需要把总体指标目标特殊处理（修改物理表）
        if (modTotalList != null && modTotalList.size() > 0) {
            List<String>  cols = new ArrayList<String>();
            IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
            List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode(tablecode.toUpperCase());
            for (DicColumnDTO dicdto : dicColumnDTOs) {
                cols.add(dicdto.getDbcolumncode());
            }
            mergeIndexDAO.updateAll(cols, modTotalList, "pm_perf_indicator");
        }
        if (modTotalGoalList != null && modTotalGoalList.size() > 0) {
            mergeIndexDAO.updateAll(modTotalGoalList, "pm_perf_goal_info");
        }
        if (isbefore != null && "1".equals(isbefore)) { //保存事前评估表
            List<Map<String, Object>> beforeList = (List<Map<String, Object>>) tabcomps.get("#before");
            //删除数据
            String beforsql = " t.projguid = '" + proguid + "'";
            List<Map<String, Object>>  odata = mergeIndexDAO.getDatas("V_PERF_T_ADVEVAINFO", beforsql, "order by ordernum");
            //插入数据
            List<Map<String, Object>> addBeforlist = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> upBeforlist = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : beforeList) {
                if (odata != null && odata.size() > 0) {
                    map.put("updatetime", StringUtil.getSysDBDate());
                    upBeforlist.add(map);
                }else{
                    map.put("createtime", StringUtil.getSysDBDate());
                    map.put("creater", SecureUtil.getCurrentUser().getGuid());
                    map.put("province", SecureUtil.getUserSelectProvince());
                    map.put("year", CommonUtil.getYear());
                    addBeforlist.add(map);
                }
            }
            if (addBeforlist != null && addBeforlist.size() > 0) {
                mergeIndexDAO.saveAll(addBeforlist, "V_PERF_T_ADVEVAINFO");
            }
            if (upBeforlist != null && upBeforlist.size() > 0) {
                mergeIndexDAO.updateAllByPK(upBeforlist, "guid", "V_PERF_T_ADVEVAINFO");
            }
        }
        Map<String, Object> proMap = new HashMap<String, Object>();
        proMap.put("guid", proguid);
        indexList = new ArrayList<Map<String, Object>>();
        indexList.add(proMap);
        String busguid = "hebeiyitihuabusguid002"; //河北一体化对接应用的审核定义.
        if (showtab == "2" || "2".equals(showtab)){
            busguid = "hebeiyitihuabusguid001";
        } else if(showtab == "3" || "3".equals(showtab)) {
            busguid = "hebeiyitihuabusguid002";
        }
        Map<String, Object> result = this.auditdefine(indexList, busguid,"perf", null);
        if((boolean)result.get("success")){//修改-审核定义通过后再调用河北绩效接口反写  并对新增目标进行kpimainid更新
            logger.info("-----auditdefine-result:"+result);
            if (showtab != null && ("1".equals(showtab) || "2".equals(showtab)) && (isedittotal == null || !"1".equals(isedittotal)) ) {
                Map totalparamMap  = new HashMap();
                String kpimainid = "";
                totalparamMap.put("bus_type",1);
                totalparamMap.put("kpimainid",tabcomps.get("#kpimaintotal"));
                totalparamMap.put("proguid",proguid);
                totalparamMap.put("procode",procode);
                totalparamMap.put("proname",proname);
                totalparamMap.put("saveAgency",saveAgency);
                Map<String, Object> goaltotalmap = new HashMap<>();
                if (null == addTotalGoalList||addTotalGoalList.size() == 0){
                    kpimainid = this.putRestHbPerformance(totalparamMap, modTotalGoalList, totalindexList);
                    goaltotalmap = modTotalGoalList.get(0);
                } else {
                    kpimainid = this.putRestHbPerformance(totalparamMap, addTotalGoalList, totalindexList);
                    goaltotalmap = addTotalGoalList.get(0);
                }
                //更新kpimainid
                goaltotalmap.put("kpimainid",kpimainid);
                logger.info("-----update----goaltotalmap:"+goaltotalmap);
                mergeIndexDAO.update(goaltotalmap, goaltablecode);
            }
            if (showtab != null && ("1".equals(showtab) || "3".equals(showtab))) {
                String kpimainid = "";
                Map paramMap  = new HashMap();
                paramMap.put("bus_type",2);
                paramMap.put("kpimainid",tabcomps.get("#kpimainyear"));
                paramMap.put("proguid",proguid);
                paramMap.put("procode",procode);
                paramMap.put("proname",proname);
                paramMap.put("saveAgency",saveAgency);
                Map<String, Object> goalyearmap = new HashMap<>();
                if (null == addYearGoalList||addYearGoalList.size() == 0){
                    kpimainid = this.putRestHbPerformance(paramMap, modGoalList, yearindexList);
                    goalyearmap = modGoalList.get(0);
                } else {
                    kpimainid = this.putRestHbPerformance(paramMap, addYearGoalList, yearindexList);
                    goalyearmap = addYearGoalList.get(0);
                }
                //更新kpimainid
                goalyearmap.put("kpimainid",kpimainid);
                logger.info("-----update----goalyearmap:"+goalyearmap);
                mergeIndexDAO.update(goalyearmap, goaltablecode);
            }
        }
        return result;
    }

    /**
     * 河北模式保存河北项目绩效相关表
     * @param params
     */
    public void saveHeBeiPMData(Map<String, Object> params){
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode");
        String proname = (String) params.get("proname");
        String saveAgency = (String) params.get("saveAgency");
        List<Map<String, Object>> addList = (List<Map<String, Object>>) params.get("addList");
        String kpimainid = StringUtil.createUUID(); //主键
        Map mainMap = new HashMap();
        mainMap.put("kpimainid", kpimainid);
        mainMap.put("proid", proguid);
        mainMap.put("bdgyear", PerfUtil.getYear());
        mainMap.put("procode", procode);
        mainMap.put("proname", proname);
        mainMap.put("parentdept", saveAgency);
        mainMap.put("unitname", saveAgency);
        mainMap.put("admdivcode", PerfUtil.getProvince());
        mergeIndexDAO.saveMain(mainMap);
        Map perfMap = new HashMap();
        perfMap.put("kpiperid", StringUtil.createUUID());
        perfMap.put("proid", proguid);
        perfMap.put("admdivcode", PerfUtil.getProvince());
        perfMap.put("bdgyear", PerfUtil.getYear());
        perfMap.put("performance", "绩效目标");
        perfMap.put("kpimainid", kpimainid);
        mergeIndexDAO.savePerfRecord(perfMap);
        //处理绩效指标addList
        String compgin ="";
        for(Map tempMap : addList){
            tempMap.put("kpimainid",kpimainid);
            tempMap.put("proid", proguid);
            compgin = (String) tempMap.get("computesign");
            if (compgin != null && "6".equals(compgin)) {
                tempMap.put("indexval","0");
            }
        }
        mergeIndexDAO.saveKPIRecord(kpimainid, addList);
    }

    /**
     *河北模式保存河北预算绩效相关表
     * @param params
     */
    public void saveHeBeiBGTData(Map<String, Object> params){
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode");
//        String proname = (String) params.get("proname");
//        String saveAgency = (String) params.get("saveAgency");
        List<Map<String, Object>> addList = (List<Map<String, Object>>) params.get("addList");
        String kpimainid = StringUtil.createUUID(); //主键
        Map mainMap = new HashMap();
        mainMap.put("bgt_data_id", kpimainid);
        mainMap.put("bgt_pmain_id", proguid);
        mainMap.put("pro_code", procode);
        mergeIndexDAO.saveBGTMain(mainMap);
        Map perfMap = new HashMap();
        perfMap.put("bgt_data_id", StringUtil.createUUID());
        perfMap.put("bgt_pmain_id", proguid);
        perfMap.put("pro_code", procode);
        mergeIndexDAO.saveBGTPerfGoal(perfMap);
        //处理绩效指标addList
        String compgin ="";
        for(Map tempMap : addList){
            tempMap.put("kpimainid",StringUtil.createUUID());
            tempMap.put("proid", proguid);
            tempMap.put("pro_code", procode);
            tempMap.put("bgt_pmain_id", proguid);
            compgin = (String) tempMap.get("computesign");
            if (compgin != null && "6".equals(compgin)) {
                tempMap.put("indexval","0");
            }
        }
        mergeIndexDAO.saveBGTPerfIndex(kpimainid, addList);
    }

    /**
     * 绩效保存的时候反写给河北一体化接口内容.
     * @param params -- 参数
     * @param goalList -- 目标
     * @param indexList -- 指标
     * @return
     * @throws AppException
     */
    public String putRestHbPerformance(Map<String, Object> params, List<Map<String,Object>> goalList, List<Map<String, Object>> indexList) throws AppException {
        int bus_type = (int) params.get("bus_type");// 1 项目库 2 预算编制
        String kpimainid = (String) params.get("kpimainid"); //主键
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode");
        String proname = (String) params.get("proname");
        String saveAgency = (String) params.get("saveAgency");
//        Map<String, Object> backMap = new HashMap<String, Object>();
        String url = PerfUtil.getSystemSet("hbsaveprogramperformance"); //一体化地址
//        String schema = PerfUtil.getSystemSet("hbsaveperformancetoschema"); //一体化数据库用户
        String hbprovince = CommonUtil.getProvince();
        if("520194000" == hbprovince || "520194000".equals(hbprovince)){
            hbprovince = "520199000";
        }
        if("520500000" == hbprovince || "520500000".equals(hbprovince)){
            hbprovince = "520501000";
        }
        String schema = "FASP" + hbprovince;
        Map<String, Object> uriParams = new HashMap<>();
        if (StringUtil.isEmpty(url)){
            throw  new AppException("访问一体化请求参数为空，请在系统中进行配置!");
        }
        if (StringUtil.isEmpty(schema)){
            throw  new AppException("一体化数据库的schema参数为空，请在系统中进行配置!");
        }
        uriParams.put("schema", schema);
        Map<String,Object> dataMap = new HashMap<String,Object>();
        uriParams.put("data", dataMap);

        Map<String,Object> mainMap = new HashMap<String,Object>();
        List<Map<String, Object>> mbList = new ArrayList<>();
        List<Map<String, Object>> zbList = new ArrayList<>();
        mainMap.put("KPIMAINID",kpimainid);
        mainMap.put("PROID",proguid);
        mainMap.put("BDGYEAR",CommonUtil.getYear());
        mainMap.put("PROCODE",procode);
        mainMap.put("PRONAME",proname);
        mainMap.put("PARENTDEPT",saveAgency);
        mainMap.put("UNITNAME",saveAgency);
        mainMap.put("PERFORMANCE_PERIOD","中长期目标");
        mainMap.put("ADMDIVCODE",CommonUtil.getProvince());
        mainMap.put("AGENCY_CODE",saveAgency);
        mainMap.put("TEPLATE_ID","");
        mainMap.put("BUSI_TYPE",bus_type);
        if (goalList.size() > 0){
            Map<String, Object> goalMap = goalList.get(0);
            Map<String, Object> mbMap = new HashMap<>();
            mbMap.put("KPI_TARGET",goalMap.get("kpi_target"));
            mbMap.put("INDCONTENT","");
            mbMap.put("ORDERBY",1);
            mbMap.put("EDITUSER",CommonUtil.getCurrentUserID());
            mbMap.put("BUSI_TYPE",bus_type);
            mbMap.put("AGENCY_CODE",saveAgency);
            mbList.add(mbMap);
        }
        if (indexList.size() > 0){
            Map<String, Object> tempMap = null;
            for (Map<String, Object> map : indexList) {
                tempMap = new HashMap<>();
                tempMap.put("KPI_LV1",map.get("kpi_lv1"));
                tempMap.put("KPI_LV2",map.get("kpi_lv2"));
                if (null == map.get("code") || "".equals(map.get("code"))){
                    tempMap.put("KPI_LV3",""+map.get("kpi_lv1")+map.get("kpi_lv2")+map.get("ordernum"));
                }else {
                    tempMap.put("KPI_LV3",map.get("code"));
                }
                tempMap.put("KPI_CONTENT",map.get("name"));
                tempMap.put("KPI_EVALSTD",map.get("name"));
                tempMap.put("KPI_VAL",map.get("kpi_val"));
                tempMap.put("KPI_REMARK","");
                tempMap.put("KPI_LV3_ID",map.get("guid"));
                tempMap.put("KPI_LV2_ID",indexcodeMap.get(map.get("kpi_lv2")));
                tempMap.put("KPI_LV1_ID",indexcodeMap.get(map.get("kpi_lv1")));
                tempMap.put("INDSYMBOL",map.get("computesign"));
                if (map.get("computesign").toString().equals("6")){
                    tempMap.put("INDVALUE",0);
                    tempMap.put("INDUNIT",map.get("kpi_val"));
                } else {
                    tempMap.put("INDVALUE",Float.parseFloat((String) map.get("kpi_val")));
                    tempMap.put("INDUNIT",map.get("meterunit"));
                }
                tempMap.put("INDDESC",map.get("name"));
                tempMap.put("INDTYPENAME",map.get("kpi_lv1"));
                tempMap.put("ORDERBY",PerfUtil.mapGetInt(map,"ordernum"));
                tempMap.put("INDBASIS",map.get("name"));
                tempMap.put("TEMPLATEID","");
                tempMap.put("BUSI_TYPE",bus_type);
                tempMap.put("AGENCY_CODE",saveAgency);
                zbList.add(tempMap);
            }
        }
        dataMap.put("zb",zbList);
        dataMap.put("mb",mbList);
        dataMap.put("main",mainMap);
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        MediaType type = MediaType.parseMediaType("application/json; charset=UTF-8");
        headers.setContentType(type);
        headers.add("Accept", MediaType.APPLICATION_JSON.toString());
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("schema",schema);
        jsonObject.put("data",dataMap);
        HttpEntity<String> formEntity = new HttpEntity<String>(jsonObject.toString(), headers);
        //String tempparam = PerfUtil.parse2Json(uriParams);
        logger.info("==============河北绩效有关信息反写接口开始"+formEntity.toString()+"===========");
        String json = restTemplate.postForObject(url,formEntity, String.class);
        logger.info("==============河北绩效有关信息反写接口返回"+json+"===========");
        Map<String, Object> jsonMap = PerfUtil.parseObj2Map(JSONObject.parse(json));
        logger.info("==============河北绩效有关信息反写接口返回解析：：："+jsonMap.toString()+"===========");
        int statusCode = (int) jsonMap.get("statusCode");
        if ( 1 != statusCode){
            String message = (String) jsonMap.get("message");
            throw new AppException(message);
        }
        String data = (String) jsonMap.get("data");
       return data;
    }

    /**
     * 查询页面表格的注册字段
     * @param uikey
     * @return
     */
    public List<Map<String, Object>> getUicolumn(String uikey){
        List<Map<String, Object>> list = mergeIndexDAO.getUicolumn(uikey);
        return  list;
    }

    /**
     * 查询指标
     * @param proguid
     * @param yearflag
     * @return
     */
    public List<Map<String, Object>> getExportIndex(String proguid, String yearflag){
        //return  mergeIndexDAO.getExportIndex(proguid,yearflag);
        String wheresql = " t.MAINGUID = '"+proguid+"' and t.YEARFLAG = '"+yearflag+"' ";
        return mergeIndexDAO.getDatas("v_perf_indicator_export", wheresql, " order by t.code");
    }

    public void setIndexMap(Map tempMap){
        tempMap.put("province", CommonUtil.getProvince());
        tempMap.put("createtime", PerfUtil.getServerTimeStamp());
        tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
        tempMap.put("creater", SecureUtil.getCurrentUser().getGuid());
        tempMap.put("year", CommonUtil.getYear());
        tempMap.put("kpi_id", tempMap.get("guid"));
        tempMap.put("kpi_lv1", tempMap.get("findex"));
        tempMap.put("kpi_lv2", tempMap.get("sindex"));
        tempMap.put("create_time", PerfUtil.getServerTimeStamp());
        tempMap.put("update_time", PerfUtil.getServerTimeStamp());
        tempMap.put("mof_div_code", SecureUtil.getUserSelectProvince());
        tempMap.put("fiscal_year", CommonUtil.getYear());
        tempMap.put("is_deleted", "2");
        if (tempMap.get("busi_type_code") == null){
            tempMap.put("busi_type_code", "1");
        }
    }

    /**
     * 校验字段长度
     * @param indexList
     * @return
     */
    public Map<String, Object> checkColLength(List<Map<String, Object>> indexList){
//        List<Map<String, Object>> columnlist = mergeIndexDAO.getColDatas("PM_PERF_INDICATOR", "/pmkpi/program/report/treeindex");
        List<Map<String, Object>> columnlist = mergeIndexDAO.getCol("V_PM_PERF_INDICATOR");
        Map<String, Object> returnMap = new HashMap<String, Object>();
        for (Object col : columnlist) {
            Map colsMap = (Map)col;
            String collength = (String) colsMap.get("datalength");
            if (StringUtil.isEmpty(collength)) {
                continue;
            }
            int strLength = Integer.parseInt(collength);
            String colName = (String) colsMap.get("columncode");
            String title = (String) colsMap.get("name");
            colName = colName.toLowerCase();
            for (Map indexMap : indexList) {
                String context = indexMap.get(colName)!=null ? String.valueOf(indexMap.get(colName)).trim() : "";
                Integer orderNum = (Integer) indexMap.get("ordernum");
                int i = 0;
                if (StringUtils.isNotBlank(context)) {
                    for (char chr : context.toCharArray()) {
                        if ((int) chr > 127) {
                            i += 3;
                        } else {
                            i++;
                        }
                    }
                }
                if (i > strLength) {
                    Map<String, Object> errMap = new HashMap<String, Object>();
                    List<Map<String, Object>> errdata = new ArrayList<>();
                    errMap.put("remark", "第" + orderNum + "行" + title + "长度超长，请重新填写！");
                    errMap.put("code", "001");
                    errMap.put("name", "校验字段填写长度");
                    errMap.put("explain", "校验字段填写长度");
                    errdata.add(errMap);
                    returnMap.put("success", false);
                    returnMap.put("redata", errdata);
                    return returnMap;
                }
            }
        }
        return returnMap;
    }

    public void delIndex(List<String> delList, String tablecode, String proguid){
        int a = 0;
        if (delList.size() > 0){
            StringBuffer indexguids = new StringBuffer("");
            for(String tempguid : delList){
                if (a == 0){indexguids.append("'");}
                indexguids.append(tempguid);
                indexguids.append("','");
                a++;
            }
            if(indexguids.length() > 0){
                String guids = indexguids.substring(0,indexguids.length()-2);
                mergeIndexDAO.delIndexByguid(tablecode, guids, proguid);
            }
        }
    }

    /**
     *
     * @param checktype
     * @param province
     * @param year
     * @return
     */
    public List checkHBPerfindex(String checktype, String province, String year, List<Map<String,Object>> guidList) throws AppException {
        mergeIndexDAO.saveAll(guidList,"PERF_TMP_AGENCY");
        return mergeIndexDAO.checkHBPerfindex(checktype,province,year);
    }

    /**
     * 保存数据到表.
     * @param list
     * @param tablecode
     * @return
     * @throws AppException
     */
    public int saveTable(List list, String tablecode) throws AppException {
         return mergeIndexDAO.saveAll(list,tablecode);
    }

    /**
     * 是否显示事前评估页签
     * @param proguid
     * @return
     */
    public Boolean isbeforetab(String proguid){
        String wheresql = " t.proguid = '" + proguid + "' and t.province='"+SecureUtil.getUserSelectProvince()+"'";
        List<Map<String, Object>> list = mergeIndexDAO.getDatas("PERF_HBPROJECT_ISBEFORE", wheresql, null);
        if(list != null && list.size()>0){
            return false;
        }else {
            return true;
        }
    }
}
