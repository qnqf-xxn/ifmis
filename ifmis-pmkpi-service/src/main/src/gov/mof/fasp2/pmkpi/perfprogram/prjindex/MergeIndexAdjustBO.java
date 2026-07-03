/**
 * @Title: PrjIndexBO.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.lang.StringUtils;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;


/**
 * @ClassName: PrjIndexBO
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@szlogntu.com">GM</a>于 2020-1-6 上午10:41:23
 */

public class MergeIndexAdjustBO extends PmkpiBO {

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
    private MergeIndexAdjustDAO mergeIndexAdjustDAO;

    /**
     * 注入mergeIndexDAO.
     * @param mergeIndexAdjustDAO
     */
    public void setMergeIndexAdjustDAO(MergeIndexAdjustDAO mergeIndexAdjustDAO) {
        this.mergeIndexAdjustDAO = mergeIndexAdjustDAO;
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
            indexs = mergeIndexAdjustDAO.findIndexs(proguid,"v_pm_perf_indicator");
            if(indexs.size()<= 0){
                indexs = mergeIndexAdjustDAO.findIndexs(selectbillguid,"v_pm_perf_indicator");
            }
        }else{
            indexs = mergeIndexAdjustDAO.findIndexs(proguid,"v_pm_perf_indicator");
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
        List<Map<String, Object>> nullTemp = mergeIndexAdjustDAO.findNullTemp(proguid); //空指标模板
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
        Map<String, Object> promap = mergeIndexAdjustDAO.queryForMap("select * from v_perf_project_info t where t.guid='" + proguid + "'");
        String tablecode = "";
        if (isshowedit != null && "2".equals(isshowedit)) {
            tablecode = "v_pm_perf_goal_info";
            Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
            String wheresql = " mainguid='" + proguid + "'";
            int i = mergeIndexAdjustDAO.getDataCount(tablecode, wheresql);
            editinfo.put("updatetime", PerfUtil.getServerTimeStamp());
            editinfo.put("update_time", PerfUtil.getServerTimeStamp());
            if (i > 0) {
                List<String> cols = new ArrayList<String>(editinfo.keySet());
                mergeIndexAdjustDAO.update(cols, editinfo, tablecode);
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
                mergeIndexAdjustDAO.save(editinfo, tablecode);
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
        mergeIndexAdjustDAO.setIndexCode(indexList);
        //删除保存
        tablecode = "v_pm_perf_indicator";
        mergeIndexAdjustDAO.delTargets(tablecode, proguid);
        mergeIndexAdjustDAO.saveAll(indexList,tablecode);
        return this.auditdefine(indexList, busguid,"perf", null);
    }
    /**
     * 获取符号的值集.
     * @return
     * @throws
     */
    public Map<String, Object> queryComputesign() {
        Map<String, Object> computesignMap = new HashMap<String, Object>();
        List<Map<String, Object>> list = mergeIndexAdjustDAO.queryComputesign();
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
     * @see PmkpiBO#getVodSql(Map)
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
            sql.append(" and p.is_backup=2 and p.is_deleted=2");
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
        List list = mergeIndexAdjustDAO.finTreeData(tablecode, condition);
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
        indexs = mergeIndexAdjustDAO.findIndexs(mainguid,"v_perf_t_casemodelindex");
        backdata.addAll(indexs);
        tempMap.put("data", backdata);
        return tempMap;
    }
    public int mapGetInt(Map<String, Object> map, String col) {
        Object o = map.get(col);
        if (o == null) {
            return 0;
        }
        return Integer.parseInt(o.toString());
    }

    /**
     * 查询各年度数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> findProAdjustIndex(Map<String, Object> params) throws AppException {
        String isbefore = (String) params.get("isbefore");
        String viewtype = (String) params.get("viewtype");
        String proguid = (String) params.get("proguid");
        String adjmainguid = (String) params.get("adjmainguid");
        String procat = (String) params.get("procat");
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String sindex = "";
        String yearflag = "1";
        String tabfiler = "";
        List<Map<String, Object>> indexs = new ArrayList<>();
        List<Map<String, Object>> goals = new ArrayList<>();
        List<Map<String, Object>> totalgoal = new ArrayList<>();//总体目标
        List<Map<String, Object>> totalindexs = new ArrayList<>();//总体指标
        String tablecode = "v_perf_t_adjustindex";
        String goaltable = "v_perf_t_adjustgoal";
        //项目库不分年度，总体目标指标根据区划查询物理表
        String province = SecureUtil.getUserSelectProvince();
        String totaltabfiler = " nvl(yearflag,'0') = '1' and is_backup=2 and t.is_deleted = 2 and t.province = '"+province+"'";
        boolean isAdjStart = false;
        //查询调整主单
        if((adjmainguid == null || "".equals(adjmainguid)) && (proguid !=null && !"".equals(proguid))){
            List<Map<String, Object>> mainadjust = mergeIndexAdjustDAO.getDatas("v_perf_t_adjust", " proguid='"+proguid+"' and islast =1", "order by guid");
            if(mainadjust!=null && mainadjust.size()>0){
                adjmainguid = (String) mainadjust.get(0).get("guid");
            }else if(!"query".equals(viewtype)){
                //不存在调整主单数据先创建
                Map<String, Object> adjustMap = new HashMap<>();
                adjustMap.put("proguid", proguid);
                adjmainguid = this.getCreateguid();
                adjustMap.put("adjustnum", 1);
                List<Map<String, Object>> adjustnums = mergeIndexAdjustDAO.getJustnums(proguid);
                int adjustnum = 0;
                if (adjustnums!=null && adjustnums.size()>0) {
                    adjustnum = this.mapGetInt(adjustnums.get(0),"adjustnum");
                    adjustMap.put("adjustnum", adjustnum + 1);
                }
                adjustMap.put("guid", adjmainguid);
                adjustMap.put("createtime", StringUtil.getSysDBDate());
                adjustMap.put("updatetime", StringUtil.getSysDBDate());
                adjustMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                adjustMap.put("province", SecureUtil.getUserSelectProvince());
                adjustMap.put("year", CommonUtil.getYear());
                List<Map<String, Object>> proinfo = mergeIndexAdjustDAO.getDatas("V_PERF_PROJECT_INFO", " guid='"+proguid+"'", "order by guid");
                if(proinfo!=null && proinfo.size()>0){
                    adjustMap.put("pro_code", proinfo.get(0).get("pro_code"));
                    adjustMap.put("agencyguid", proinfo.get(0).get("agency_code"));
                    adjustMap.put("manage_dept_code", proinfo.get(0).get("manage_dept_code"));
                    adjustMap.put("manage_mof_dep_code", proinfo.get(0).get("manage_mof_dep_code"));
                    adjustMap.put("mof_dep_code", proinfo.get(0).get("mof_dep_code"));
                    adjustMap.put("dept_code", proinfo.get(0).get("dept_code"));
                    adjustMap.put("agency_code", proinfo.get(0).get("agency_code"));
                    adjustMap.put("finintorgguid", proinfo.get(0).get("mof_dep_code"));
                }
                adjustMap.put("islast", 1);
                adjustMap.put("adjstatus", "2");
                adjustMap.put("bustype", "program");
                mergeIndexAdjustDAO.save(adjustMap,"v_perf_t_adjust");
                isAdjStart = true;
            }else{
                isAdjStart = true;
            }
        }
        //总体指标和目标
        tabfiler = " nvl(yearflag,'0') = '1'";
        totalindexs = mergeIndexAdjustDAO.findIndexsByFilter(adjmainguid,tablecode, tabfiler);
        boolean ishaveGhindex = false;
        if (totalindexs == null || totalindexs.size() <= 0) {
            String orderby = " order by yearflag,findex,sindex,ordernum";
            tablecode = "(select a.*,guid indexguid,weight as adjustweight from pm_perf_indicator a)";
            totalindexs = mergeIndexAdjustDAO.getDatas(tablecode, totaltabfiler+ " and mainguid = '"+proguid+"'", orderby);
            for (Map<String, Object> map : totalindexs){
                map.put("guid", this.getCreateguid());
                map.put("mainguid", adjmainguid);
                map.put("status", "");
                if(map.get("adjustindexval") ==null){
                    map.put("adjustindexval", "");
                }
            }
        }
       //存在业务数据，判断是否存在固化指标
        for (Map<String, Object> map : totalindexs){
            String indexname = (String) map.get("name");
            if(indexname !=null && "项目或定额成本控制率".equals(indexname)){
                ishaveGhindex = true;
                break;
            }
        }
        totalgoal = mergeIndexAdjustDAO.getGoalsByFilter(adjmainguid, goaltable, tabfiler);
        if (totalgoal == null || totalgoal.size() <= 0) {
            String orderby = " order by guid";
            tablecode = "pm_perf_goal_info";
            totalgoal = mergeIndexAdjustDAO.getDatas(tablecode, totaltabfiler+ " and mainguid = '"+proguid+"'", orderby);
        }

        List<Map<String, Object>> tempIndexList = new ArrayList<>();
        if ((totalindexs != null && totalindexs.size() > 0)) {
            indexs.addAll(totalindexs);
        }
        if ((totalgoal != null && totalgoal.size() > 0)) {
            goals.addAll(totalgoal);
        }
        if (indexs.size() ==0  && "1".equals(procat)){ //河北项目类别 人员
            tempIndexList = mergeIndexAdjustDAO.findMouldByFilter("5200901",null);
            indexs = PerfUtil.lowMapKey(tempIndexList);
        }
        if (indexs.size() ==0  && "3".equals(procat)){ //河北项目类别 公用
            tempIndexList = mergeIndexAdjustDAO.findMouldByFilter("5200902",null);
            indexs = PerfUtil.lowMapKey(tempIndexList);
        }
        if ((totalindexs.size() ==0  && ("4".equals(procat) || "5".equals(procat))) || !ishaveGhindex){
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
        List<Map<String, Object>> nullTemp = mergeIndexAdjustDAO.getTempdatas(proguid); //空指标模板
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        // 区分项目多页签指标
        for (Map<String, Object> map : indexs) {
            String status = map.get("status") + "";
            if ("1".equals(status)) {
                map.put("obligate1", "撤销删除");
            } else {
                if("149999".equals(map.get("code")) || "项目或定额成本控制率".equals(map.get("name"))){
                    map.put("obligate1", "");
                }else {
                    map.put("obligate1", "删除");
                }
            }
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
        List<Map<String, Object>> tempgoalslist = new ArrayList<>();
        if (goals.size() ==0  && "1".equals(procat)){ //河北项目类别 人员
            tempgoalslist = mergeIndexAdjustDAO.getMouldGoalByFilter("5200901",null);
            goals = PerfUtil.lowMapKey(tempgoalslist);
        }
        if (goals.size() ==0  && "3".equals(procat)){ //河北项目类别 公用
            tempgoalslist = mergeIndexAdjustDAO.getMouldGoalByFilter("5200902",null);
            goals = PerfUtil.lowMapKey(tempgoalslist);
        }
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
        nullindex =(List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
        backindex = new ArrayList<Map<String,Object>>();
        for (Map<String, Object> map : nullindex) {
            String levelno = map.get("levelno") + "";
            if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                map.put("obligate1", "新增");
            }else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                map.put("obligate1", "");
            }
            map.put("_isleaf", "1");
            if(map.get("adjustindexval") == null){
                map.put("adjustindexval", "");
            }
            sindex = (String) map.get("sindex");
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
        yearsMap.put("#adjmainguid",adjmainguid);
        //获取事前绩效评估内容
        if (!StringUtil.isEmpty(isbefore) && "1".equals(isbefore)) {
            List<Map<String, Object>> beforedatas = this.getBeforeData(proguid,isAdjStart);
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
    public List<Map<String, Object>> getBeforeData(String projguid,boolean isAdjStart) throws AppException {
        String wheresql = " t.projguid = '" + projguid + "'";
        String province = SecureUtil.getUserSelectProvince();
        List<Map<String, Object>>  data = mergeIndexAdjustDAO.getDatas("V_PERF_T_ADVEVAINFO", wheresql, "order by ordernum");
        if(data!=null && data.size()>0){
            data.forEach(map ->{
                map.put("adjust_opt_value", "".equals(map.get("adjust_opt_value")) ? map.get("option_value") : map.get("adjust_opt_value"));
                map.put("adjust_score", "".equals(map.get("adjust_score")) ? map.get("unit_since_score") : map.get("adjust_score"));
                map.put("adjustremark", isAdjStart ? "" : map.get("adjustremark"));
            });
        }
        return data;
    }

    /**
     * 查询各年度数据.（河北一体化）
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> findAllIndex(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String viewtype = (String) params.get("viewtype");
        String adjmainguid = (String) params.get("adjmainguid");
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
        String tablecode = "v_perf_t_adjustindex";
        String goaltable = "v_perf_t_adjustgoal";
        //项目库不分年度，总体目标指标根据区划查询物理表
        String province = SecureUtil.getUserSelectProvince();
        tabfiler = " nvl(yearflag,'0') = '1' and t.is_deleted = 2 and t.is_backup=2 and t.province = '"+province+"'";
        totalindexs = mergeIndexAdjustDAO.findIndexsByFilter(proguid,"pm_perf_indicator", tabfiler);
        totalgoal = mergeIndexAdjustDAO.getGoalsByFilter(proguid, "pm_perf_goal_info", tabfiler);
        //查询调整主单
        if((adjmainguid == null || "".equals(adjmainguid)) && (proguid !=null && !"".equals(proguid))){
            List<Map<String, Object>> mainadjust = mergeIndexAdjustDAO.getDatas("v_perf_t_adjust", " proguid='"+proguid+"' and islast =1", "order by guid");
            if(mainadjust!=null && mainadjust.size()>0){
                adjmainguid = (String) mainadjust.get(0).get("guid");
            }else if(!"query".equals(viewtype)){
                //不存在调整主单数据先创建
                Map<String, Object> adjustMap = new HashMap<>();
                adjustMap.put("proguid", proguid);
                adjmainguid = this.getCreateguid();
                adjustMap.put("adjustnum", 1);
                List<Map<String, Object>> adjustnums = mergeIndexAdjustDAO.getJustnums(proguid);
                int adjustnum = 0;
                if (adjustnums!=null && adjustnums.size()>0) {
                    adjustnum = this.mapGetInt(adjustnums.get(0),"adjustnum");
                    adjustMap.put("adjustnum", adjustnum + 1);
                }
                adjustMap.put("guid", adjmainguid);
                adjustMap.put("createtime", StringUtil.getSysDBDate());
                adjustMap.put("updatetime", StringUtil.getSysDBDate());
                adjustMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                adjustMap.put("province", SecureUtil.getUserSelectProvince());
                adjustMap.put("year", CommonUtil.getYear());
                List<Map<String, Object>> proinfo = mergeIndexAdjustDAO.getDatas("V_PERF_PROJECT_INFO", " guid='"+proguid+"'", "order by guid");
                if(proinfo!=null && proinfo.size()>0){
                    adjustMap.put("pro_code", proinfo.get(0).get("pro_code"));
                    adjustMap.put("agencyguid", proinfo.get(0).get("agency_code"));
                    adjustMap.put("manage_dept_code", proinfo.get(0).get("manage_dept_code"));
                    adjustMap.put("manage_mof_dep_code", proinfo.get(0).get("manage_mof_dep_code"));
                    adjustMap.put("mof_dep_code", proinfo.get(0).get("mof_dep_code"));
                    adjustMap.put("dept_code", proinfo.get(0).get("dept_code"));
                    adjustMap.put("agency_code", proinfo.get(0).get("agency_code"));
                    adjustMap.put("finintorgguid", proinfo.get(0).get("mof_dep_code"));
                }
                adjustMap.put("islast", 1);
                adjustMap.put("adjstatus", "2");
                adjustMap.put("bustype", "program");
                mergeIndexAdjustDAO.save(adjustMap,"v_perf_t_adjust");
            }
        }
        //年度指标和目标
        tabfiler = " nvl(yearflag,'0') = '0'";
        yearindexs = mergeIndexAdjustDAO.findIndexsByFilter(adjmainguid,tablecode, tabfiler);
        if (yearindexs == null || yearindexs.size() <= 0) {
            String orderby = " order by yearflag,findex,sindex,ordernum";
            tablecode = "(select a.*,guid indexguid,weight as adjustweight from v_pm_perf_indicator a)";
            yearindexs = mergeIndexAdjustDAO.getDatas(tablecode, tabfiler+ " and mainguid = '"+proguid+"'", orderby);
            for (Map<String, Object> map : yearindexs){
                map.put("guid", this.getCreateguid());
                map.put("mainguid", adjmainguid);
                map.put("status", "");
                if(map.get("adjustindexval") ==null){
                    map.put("adjustindexval", "");
                }
            }
        }
        yeargoal = mergeIndexAdjustDAO.getGoalsByFilter(adjmainguid, goaltable, tabfiler);
        if (yeargoal == null || yeargoal.size() <= 0) {
            String orderby = " order by guid";
            tablecode = "v_pm_perf_goal_info";
            yeargoal = mergeIndexAdjustDAO.getDatas(tablecode, tabfiler+ " and mainguid = '"+proguid+"'", orderby);
        }

        List<Map<String, Object>> tempIndexList = new ArrayList<>();
        if ((totalindexs != null && totalindexs.size() > 0)) {
            indexs.addAll(totalindexs);
        }
        if ((yearindexs != null && yearindexs.size() > 0)) {
            indexs.addAll(yearindexs);
        }
        if ((totalgoal != null && totalgoal.size() > 0)) {
            goals.addAll(totalgoal);
        }
        if ((yeargoal != null && yeargoal.size() > 0)) {
            goals.addAll(yeargoal);
        }
        if (indexs.size() ==0  && "1".equals(procat)){ //河北项目类别 人员
            tempIndexList = mergeIndexAdjustDAO.findMouldByFilter("5200901",null);
            indexs = PerfUtil.lowMapKey(tempIndexList);
        }
        if (indexs.size() ==0  && "3".equals(procat)){ //河北项目类别 公用
            tempIndexList = mergeIndexAdjustDAO.findMouldByFilter("5200902",null);
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
        List<Map<String, Object>> nullTemp = mergeIndexAdjustDAO.getTempdatas(proguid); //空指标模板
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        // 区分项目多页签指标
        for (Map<String, Object> map : indexs) {
            String status = map.get("status") + "";
            if ("1".equals(status)) {
                map.put("obligate1", "撤销删除");
            } else {
                if("149999".equals(map.get("code")) || "项目或定额成本控制率".equals(map.get("name"))){
                    map.put("obligate1", "");
                }else {
                    map.put("obligate1", "删除");
                }
            }
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
        List<Map<String, Object>> tempgoalslist = new ArrayList<>();
        if (goals.size() ==0  && "1".equals(procat)){ //河北项目类别 人员
            tempgoalslist = mergeIndexAdjustDAO.getMouldGoalByFilter("5200901",null);
            goals = PerfUtil.lowMapKey(tempgoalslist);
        }
        if (goals.size() ==0  && "3".equals(procat)){ //河北项目类别 公用
            tempgoalslist = mergeIndexAdjustDAO.getMouldGoalByFilter("5200902",null);
            goals = PerfUtil.lowMapKey(tempgoalslist);
        }
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
        nullindex =(List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
        backindex = new ArrayList<Map<String,Object>>();
        for (Map<String, Object> map : nullindex) {
            String levelno = map.get("levelno") + "";
            if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                map.put("obligate1", "新增");
            }else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                map.put("obligate1", "");
            }
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
            String levelno = map.get("levelno") + "";
            if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                map.put("obligate1", "新增");
            }else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                map.put("obligate1", "");
            }
            map.put("_isleaf", "1");
            if(map.get("adjustindexval") == null){
                map.put("adjustindexval", "");
            }
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
        yearsMap.put("#adjmainguid",adjmainguid);
        return yearsMap;
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
     * 绩效制度表树级展示保存.(河北一体化)
     * @param params -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> savePrjTreeIndex(HashMap<String, Object> params) throws AppException {
        String yearflag = (String) params.get("adjusttype")!=null ? (String) params.get("adjusttype") :"0";
        String isbefore = (String) params.get("isbefore");
        String proguid = (String) params.get("projguid");
        String adjmainguid = (String) params.get("adjmainguid");
        String saveAgency = (String) params.get("saveAgency");
        String procode = (String) params.get("procode"); //项目编码
        String versionstr = "1".equals(yearflag) ? "项目变更总体绩效目标调整_" : "项目绩效目标调整调剂_";
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        Map<String, Object> tabcomps = (Map<String, Object>) params.get("datas"); //多页签的数据
        if (StringUtil.isEmpty(procode)){
            Map<String, Object> promap = mergeIndexAdjustDAO.getDataMap("v_perf_project_info", "t.guid='" + proguid + "'");
            procode = (String) promap.get("pro_code");
            if (StringUtil.isEmpty(saveAgency)){ //单位
                saveAgency = (String) promap.get("agency_code");
            }
        }
        String levelno  =  "";
        String indexname = "";
        String tablecode = "v_perf_t_adjustindex";
        String goaltable = "v_perf_t_adjustgoal";
        int i = 0;
        int j = 0;
        List<Map<String, Object>> indexdataList = new ArrayList<Map<String, Object>>();
        Map<String, Object> goaldatamap = new HashMap<>();
        if("1".equals(yearflag)){
            indexdataList = (List<Map<String, Object>>) tabcomps.get("#total");//总体绩效指标
            goaldatamap = (Map<String, Object>) tabcomps.get("#goaltotal");//总体绩效目标
        }else{
            indexdataList = (List<Map<String, Object>>) tabcomps.get("#year");//年度绩效指标
            goaldatamap = (Map<String, Object>) tabcomps.get("#goalyear");//年度绩效目标
        }
        String version = PerfUtil.getServerTimeStamp();
        for(Map tempMap : indexdataList){
            j++;
            levelno = PerfUtil.mapGetInt(tempMap,"levelno") + "";
            indexname = (String) tempMap.get("name");
            if (levelno != null && "3".equals(levelno) && !StringUtil.isEmpty(indexname)) {
                tempMap.put("pro_code", procode);
                String indexguid = (String) tempMap.get("indexguid");
                if (indexguid != null && ! indexguid.isEmpty()) {
                    tempMap.put("tindex", tempMap.get("indexguid"));
                }
                tempMap.put("guid", this.getCreateguid());
                tempMap.put("ordernum", i++);
                tempMap.put("proguid", proguid);
                tempMap.put("mainguid", adjmainguid);
                tempMap.put("yearflag", yearflag);
                tempMap.put("createtime", PerfUtil.getServerTimeStamp());
                tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
                tempMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                tempMap.put("province", SecureUtil.getUserSelectProvince());
                tempMap.put("agencyguid", saveAgency);
                tempMap.put("year", CommonUtil.getYear());
                this.getBasMap(tempMap,"add");
                tempMap.put("fiscal_year", SecureUtil.getUserSelectYear());
                tempMap.put("kpi_lv1", tempMap.get("findex"));
                tempMap.put("kpi_lv2", tempMap.get("sindex"));
                tempMap.put("kpi_val", tempMap.get("indexval"));
                tempMap.put("version", version);
                tempMap.put("version_name", versionstr+version);
                indexList.add(tempMap); //用于审核定义
            }
        }
        Map<String,Object> returnMap = this.checkColLength(indexList);
        if(returnMap.size() > 0){
            return returnMap;
        }
        mergeIndexAdjustDAO.setIndexCode(indexList);
        String delsql = " mainguid='" + adjmainguid + "'";
        mergeIndexAdjustDAO.delDatas(tablecode, delsql);
        mergeIndexAdjustDAO.saveAll(indexList, tablecode);
        //年度绩效目标
        String guid = (String) goaldatamap.get("guid");
        Map<String, Object> goalmap = null;
        List<Map<String, Object>> adjustdata = mergeIndexAdjustDAO.getDatas(goaltable, delsql, "order by update_time");
        if (guid == null || guid.isEmpty()) {
            String kpi_target = (String) goaldatamap.get("kpi_target");
            if (kpi_target == null || kpi_target.isEmpty()) {
                goaldatamap.put("kpi_target", " ");
            }
            goaldatamap.put("guid", this.getCreateguid());
            goaldatamap.put("creater", SecureUtil.getCurrentUserID());
            goaldatamap.put("province", SecureUtil.getUserSelectProvince());
            goaldatamap.put("year", CommonUtil.getYear());
            goaldatamap.put("updatetime", PerfUtil.getServerTimeStamp());
            goaldatamap.put("createtime", PerfUtil.getServerTimeStamp());
            goaldatamap.put("mainguid", adjmainguid);
            goaldatamap.put("proguid", proguid);
            goaldatamap.put("agencyguid", saveAgency);
            goaldatamap.put("pro_code", procode);
            goaldatamap.put("kpi_per_id", goaldatamap.get("guid"));
            goaldatamap.put("yearflag", yearflag);
            goaldatamap.put("version", version);
            goaldatamap.put("version_name", versionstr+version);
            this.getBasMap(goaldatamap, "add");
            mergeIndexAdjustDAO.save(goaldatamap, goaltable);
            List<Map<String, Object>> goalList = new ArrayList<Map<String, Object>>();
            if(goaldatamap != null){
                goalList.add(goaldatamap);
            }
        }
        if (adjustdata != null && adjustdata.size() > 0) {
            goalmap = adjustdata.get(0);
            goalmap.putAll(goaldatamap);
            mergeIndexAdjustDAO.update(goalmap, goaltable);
        } else {
            delsql += " and yearflag="+yearflag+" ";
            adjustdata = mergeIndexAdjustDAO.getDatas(tablecode, delsql, "order by update_time");
            if (adjustdata != null && adjustdata.size() > 0) {
                goalmap = adjustdata.get(0);
                goalmap.putAll(goaldatamap);
                goalmap.put("guid", this.getCreateguid());
                goalmap.put("kpi_per_id", goalmap.get("guid"));
                mergeIndexAdjustDAO.save(goalmap, goaltable);
            }
        }
        if (isbefore != null && "1".equals(isbefore)) { //保存事前评估表
            List<Map<String, Object>> beforeList = (List<Map<String, Object>>) tabcomps.get("#before");
            String beforsql = " t.projguid = '" + proguid + "'";
            List<Map<String, Object>>  odata = mergeIndexAdjustDAO.getDatas("V_PERF_T_ADVEVAINFO", beforsql, "order by ordernum");
            //修改数据
            List<Map<String, Object>> upBeforlist = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : beforeList) {
                if (odata != null && odata.size() > 0) {
                    map.put("updatetime", StringUtil.getSysDBDate());
                    upBeforlist.add(map);
                }
            }
            if (upBeforlist != null && upBeforlist.size() > 0) {
                mergeIndexAdjustDAO.updateAllByPK(upBeforlist, "guid", "V_PERF_T_ADVEVAINFO");
            }
        }
        Map<String, Object> proMap = new HashMap<String, Object>();
        proMap.put("guid", adjmainguid);
        indexList = new ArrayList<Map<String, Object>>();
        indexList.add(proMap);
        String busguid = "hebeiyitihuabusguid003"; //河北一体化对接应用的审核定义-调整调剂年度绩效.
        if("1".equals(yearflag)){
            busguid = "hebeiyitihuabusguid004"; //河北一体化对接应用的审核定义-项目调整总体绩效.
        }
        return this.auditdefine(indexList, busguid,"perf", null);
    }

    /**
     *
     * @param adjusttype
     * @param province
     * @param year
     * @return
     */
    public List endHBPerformance(String adjusttype, String province, String year, List<Map<String,Object>> guidList) throws AppException {
        List<Map<String, Object>> returnmapList = new ArrayList<>();
        Map imptemp = new HashMap();
        String yearflag = adjusttype;//1为调整总体绩效,默认为0年度绩效
        String versionstr = "1".equals(yearflag) ? "项目变更总体绩效目标调整_" : "项目绩效目标调整调剂_";
        String proyearsql =" and province ='"+province+"' and year ='"+year+"'";
        String wheresql = "";
        StringBuffer bufferid = new StringBuffer();
        StringBuffer bufferproguid = new StringBuffer();
        for (int i = 0; i < guidList.size(); i++) {
            imptemp = guidList.get(i);
            if (i != 0) {
                bufferproguid.append(",");
            }
            bufferproguid.append("'").append(imptemp.get("guid")).append("'");
        }
        String delindex = "1".equals(yearflag) ? " mainguid in (" + bufferproguid.toString() + ")  and yearflag = '"+yearflag+"' and is_backup=2 and is_deleted=2 " : " mainguid in (" + bufferproguid.toString() + ")  and yearflag = '"+yearflag+"' and is_backup=2 and is_deleted =2 " + proyearsql;
        Map<String, Object> auditMap = new HashMap<>();
        List<Map<String, Object>> adjustdata = mergeIndexAdjustDAO.getDatas("perf_t_adjust", " proguid in (" + bufferproguid.toString() + ") and islast =1"+ proyearsql, "order by updatetime");
        if(adjustdata!=null && adjustdata.size()>0){
            for (int i = 0; i < adjustdata.size(); i++) {
                imptemp = adjustdata.get(i);
                if (i != 0) {
                    bufferid.append(",");
                }
                bufferid.append("'").append(imptemp.get("guid")).append("'");
                auditMap.put((String) imptemp.get("guid"), imptemp);
            }
            wheresql = " mainguid in (" + bufferid.toString() + ")  and yearflag = '"+yearflag+"' " + proyearsql;
            List<Map<String, Object>> goaldata = mergeIndexAdjustDAO.getDatas("perf_t_adjustgoal", wheresql, "order by update_time");
            wheresql += " and nvl(status,4) <> 1 ";
            List<Map<String, Object>> indexdata = mergeIndexAdjustDAO.getDatas("perf_t_adjustindex", wheresql, "order by update_time");
            String goaltablecode = "pm_perf_goal_info";
            String indextablecode = "pm_perf_indicator";
            Map<String, Object> objectMap = null;
            String date = PerfUtil.getServerTimeStamp();
            //对项目目标进行替换
            String mainguids = "";
            //kpimainid更新
            List<Map<String, Object>> perfgoaldata = mergeIndexAdjustDAO.getDatas(goaltablecode, delindex, "order by update_time");
            Map<String, Object> kpimainguidmap = new HashMap<>();
            if(perfgoaldata!=null && perfgoaldata.size()>0) {
                for (int i = 0; i < perfgoaldata.size(); i++) {
                    Map<String, Object> perfgoal = perfgoaldata.get(i);
                    kpimainguidmap.put((String) perfgoal.get("mainguid"), perfgoal.get("kpimainid"));
                }
            }
            for (Map<String, Object> goal : goaldata) {
                mainguids = (String) goal.get("mainguid");
                String adjustndgoal = (String) goal.get("adjustndgoal");
                objectMap = (Map<String, Object>) auditMap.get(mainguids);
                if (adjustndgoal != null && !adjustndgoal.isEmpty()) {
                    goal.put("kpi_target", adjustndgoal);
                    goal.put("ndgoal", adjustndgoal);
                }
                goal.put("yearflag", yearflag);
                goal.put("version", date);
                goal.put("version_name", versionstr + date);
                goal.put("update_time",date);
                goal.put("updatetime",date);
                goal.put("busi_type_code", "1".equals(yearflag) ? "1" : "2");
                goal.put("mainguid", goal.get("proguid"));
                goal.put("pro_code", objectMap.get("pro_code"));
                goal.put("kpi_dep_id", goal.get("guid"));
                goal.put("dept_code", goal.get("dept_code"));
                String newguid = this.getCreateguid();
                goal.put("guid", newguid);
                goal.put("kpi_per_id", newguid);
                goal.put("kpi_dep_id", newguid);
                goal.put("kpimainid", kpimainguidmap.get(goal.get("proguid")));
            }
            //对项目指标进行替换
            String indexid = "";
            for (Map<String, Object> index : indexdata) {
                indexid = (String) index.get("mainguid");
                String adjustindexval = (String) index.get("adjustindexval");
                Object adjustweight = index.get("adjustweight");
                objectMap = (Map<String, Object>) auditMap.get(indexid);
                if (adjustindexval != null) {
                    index.put("indexval", index.get("adjustindexval"));
                    index.put("kpi_val", index.get("adjustindexval"));
                }
                if (adjustweight != null) {
                    index.put("weight", Integer.parseInt(String.valueOf(adjustweight)));
                }
                index.put("pro_code", objectMap.get("pro_code"));
                index.put("mainguid", index.get("proguid"));
                index.put("yearflag", yearflag);
                String status = index.get("status") + "";
                if (status != null && "1".equals(status)) {
                    index.put("is_deleted", "1");
                }
                index.put("version", date);
                index.put("version_name", versionstr + date);
                index.put("update_time",date);
                index.put("updatetime",date);
                String newguid = this.getCreateguid();
                index.put("guid", newguid);
                index.put("kpi_id", newguid);
                index.put("busi_type_code", "1".equals(yearflag) ? "1" : "2");
                index.put("status", "");
            }
            if (goaldata != null && goaldata.size() > 0) {
                mergeIndexAdjustDAO.updateIndexDelStuts(goaltablecode, delindex);
                mergeIndexAdjustDAO.saveAll(goaldata, goaltablecode);
            }
            if (indexdata != null && indexdata.size() > 0) {
                mergeIndexAdjustDAO.updateIndexDelStuts(indextablecode, delindex);
                mergeIndexAdjustDAO.saveAll(indexdata, indextablecode);
            }
            //修改最后调整状态
            String sql = "update perf_t_adjust t set t.islast = 0 where t.proguid in (" + bufferproguid.toString() + ") "+proyearsql;
            mergeIndexAdjustDAO.execute(sql);
            //追加事前绩效评估表处理
            if("1".equals(yearflag)){
                wheresql = " projguid in (" + bufferproguid.toString() + ")  " + proyearsql;
                List<Map<String, Object>> beforedata = mergeIndexAdjustDAO.getDatas("V_PERF_T_ADVEVAINFO", wheresql, "order by ordernum");
                if(beforedata!=null && beforedata.size()>0){//存在事前数据才处理
                    for (Map<String, Object> before : beforedata) {
                        before.put("unit_since_score", before.get("adjust_score"));
                        before.put("option_value", before.get("adjust_opt_value"));
                        before.put("version", date);
                        before.put("version_name", versionstr + date);
                    }
                    mergeIndexAdjustDAO.updateAllByPK(beforedata, "guid", "V_PERF_T_ADVEVAINFO");
                }
            }
        }else{
            //查询不到调整主数据，返回项目id
            returnmapList = guidList;
        }
        return returnmapList;
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
        tempMap.put("busi_type_code", "1");
    }

    /**
     * 校验字段长度
     * @param indexList
     * @return
     */
    public Map<String, Object> checkColLength(List<Map<String, Object>> indexList){
//        List<Map<String, Object>> columnlist = mergeIndexAdjustDAO.getColDatas("V_PERF_T_ADJUSTINDEX", "/pmkpi/program/report/bgtindex");
        List<Map<String, Object>> columnlist = mergeIndexAdjustDAO.getCol("V_PERF_T_ADJUSTINDEX");
        Map<String, Object> returnMap = new HashMap<String, Object>();
        for (Map colsmap : columnlist) {
            String collength = (String) colsmap.get("datalength");
            if (StringUtil.isEmpty(collength) || "0".equals(collength)) {
                continue;
            }
            int strlength = Integer.parseInt(collength); //规定长度
            String colname = (String) colsmap.get("columncode");
            String title = (String) colsmap.get("name");
            colname = colname.toLowerCase();
            for (Map indexmap : indexList) {
                String context = indexmap.get(colname) != null ? String.valueOf(indexmap.get(colname)).trim() : "";
                int i = 0; //录入长度
                if (!StringUtil.isEmpty(context)) {
                    for (char chr : context.toCharArray()) {
                        if ((int) chr > 127) {
                            i += 3;
                        } else {
                            i++;
                        }
                    }
                }
                if(StringUtils.isNotBlank(context) && !"status".equals(colname)){
                    if (i > strlength) {
                        Map<String, Object> errMap = new HashMap<String, Object>();
                        List<Map<String, Object>> errdata = new ArrayList<>();
                        errMap.put("remark","字段：" + title + "长度超长，请重新填写！");
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
                mergeIndexAdjustDAO.delIndexByguid(tablecode, guids, proguid);
            }
        }
    }

    /**
     * 是否显示事前评估页签
     * @param proguid
     * @return
     */
    public Boolean isadjbeforetab(String proguid){
        String wheresql = " t.projguid = '" + proguid + "'";
        List<Map<String, Object>> list = mergeIndexAdjustDAO.getDatas("v_perf_t_advevainfo", wheresql, null);
        if(list != null && list.size()>0){
            return true;
        }else {
            return false;
        }
    }

    /**
     * 调整调剂_终审（预算一体化调整调剂）
     * status=6用于标识调整前是否有申报数据
     * 如果存在申报数据，status存储为空，多次取消调整，保留上一次终审数据为申报数据
     * 如果不存在申报数据，status存储值为6，多次取消调整，清空申报数据
     * @param province
     * @param year
     * @return
     */
    public List endAdjperformance(String province, String year, List<Map<String, Object>> proList) throws AppException {
        List<Map<String, Object>> returnmapList = new ArrayList<>();
        List<String> procodeList = new ArrayList<>();
        Map<String, Object> subMap = new HashMap<>();
        //是否转移支付
        boolean istra = false;
        for (Map<String, Object> map : proList) {
            String pro_code = (String) map.get("pro_code");
            String submofdiv = (String) map.get("submofdiv");
            if (!istra && !StringUtil.isNullOrEmpty(submofdiv)) {
                istra = true;
            }
            subMap.put(pro_code, StringUtil.isNullOrEmpty(submofdiv) ? new ArrayList<>() : Arrays.asList(submofdiv.split(",")));
            procodeList.add(pro_code);
        }
        this.setYearAndProvince(year, province);
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> nullTemp = dss.getRangesByWhereSql("PMKPIFRAME", "frametype='PM001'");
        Map<Object, Object> tempFrameMap = nullTemp.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
        String wheresql = mergeIndexAdjustDAO.createInSql("pro_code", procodeList) + " and islast=1 and wfid is null";
        //查询调整主单
        List<Map<String, Object>> adjustList = mergeIndexAdjustDAO.getDatas("v_perf_t_adjust", wheresql, "order by updatetime");
        if (adjustList.size() > 0) {
            List<String> agencyList = new ArrayList<>();
            List<String> adjprocodeList = new ArrayList<>();
            Map<String, Object> adjMap = new HashMap<>();
            for (Map<String, Object> map : adjustList) {
                String guid = (String) map.get("guid");
                String agencyguid = (String) map.get("agencyguid");
                String pro_code = (String) map.get("pro_code");
                agencyList.add(agencyguid);
                adjMap.put(guid, map);
                adjprocodeList.add(pro_code);
            }
            //查询所有涉及的单位信息
            String agencyslq = mergeIndexAdjustDAO.createInSql("guid", agencyList);
            List<DicRangeDTO> eledatas = PerfUtil.getSourceData("PMKPIAGENCYALLPAY", agencyslq);
            Map<String, String> agencyMaps = new HashMap<>();
            if (eledatas != null && eledatas.size() > 0) {
                for (DicRangeDTO dicRangeDTO : eledatas) {
                    String code = dicRangeDTO.getCode();
                    String name = dicRangeDTO.getName();
                    agencyMaps.put(code, name);
                }
            }
            if (istra) {
                this.traAdjust(province, year, tempFrameMap, agencyMaps, adjprocodeList, adjMap, subMap);
                //处理中间表数据
                this.saveProSubmofdiv(subMap, province, year);
            } else {
                this.adjust(province, year, tempFrameMap, agencyMaps, adjprocodeList, adjMap);
            }
        }
        return returnmapList;
    }

    /**
     * 预算调整调剂-下级转移支付项目区划明细保存
     * @Prolist {procode,procode} --编码.
     */
    public void saveProSubmofdiv(Map<String, Object> subMap, String province, String year) throws AppException {
        String time = PerfUtil.getServerTimeStamp();
        List<Map<String, Object>> saveList = new ArrayList<>();
        String tablecode = "v_perf_t_prosubmofdiv";
        Map<String, Object> proMap = null;
        StringBuffer delsql = new StringBuffer();
        for (String pro_code : subMap.keySet()) {
            List<String> subList = (List<String>) subMap.get(pro_code);
            if (subList != null && subList.size() > 0) {
                for (String submofdivcode : subList) {
                    if (delsql.length() > 0) {
                        delsql.append(" or ");
                    }
                    delsql.append("(pro_code='").append(pro_code).append("' and submofdivcode='").append(submofdivcode).append("')");
                    proMap = new HashMap<>();
                    proMap.put("guid", StringUtil.createUUID());
                    proMap.put("submofdivcode", submofdivcode);
                    proMap.put("pro_code", pro_code);
                    proMap.put("createtime", time);
                    proMap.put("updatetime", time);
                    proMap.put("creater", SecureUtil.getCurrentUserID());
                    proMap.put("province", province);
                    proMap.put("year", year);
                    saveList.add(proMap);
                }
            }

        }
        if (delsql.length() > 0) {
            mergeIndexAdjustDAO.delDatas(tablecode, delsql.toString());
        }
        if (saveList.size() > 0) {
            mergeIndexAdjustDAO.saveAll(saveList, tablecode);
        }
    }

    private void adjust(String province, String year, Map<Object, Object> tempFrameMap, Map<String, String> agencyMaps, List<String> adjprocodeList, Map<String, Object> adjMap) throws AppException {
        String yearflag = "0";//1为调整总体绩效,默认为0年度绩效
        String delindex = mergeIndexAdjustDAO.createInSql("pro_code", adjprocodeList) + " and yearflag = '" + yearflag + "'";
        String wheresql = mergeIndexAdjustDAO.createInSql("mainguid", adjMap.keySet()) + " and yearflag = '" + yearflag + "' ";
        //查询调整目标
        List<Map<String, Object>> goaldatas = mergeIndexAdjustDAO.getDatas("v_perf_t_adjustgoal", wheresql, "order by update_time");
        //查询调整指标
        wheresql += " and nvl(status,4) <> 1 ";
        List<Map<String, Object>> indexdatas = mergeIndexAdjustDAO.getDatas("v_perf_t_adjustindex", wheresql, "order by update_time");
        String goaltablecode = PerfConstant.PMKPI_VPM_GOAL_INFO;
        String indextablecode = PerfConstant.PMKPI_VPM_INDICATOR;
        Map<String, Object> objectMap = null;
        String date = PerfUtil.getServerTimeStamp();
        //对项目目标进行替换
        String mainguid = "";
        for (Map<String, Object> goal : goaldatas) {
            mainguid = (String) goal.get("mainguid");
            goal.put("fromguid", mainguid);//调整主单id,记录用于取消终审
            String adjustndgoal = (String) goal.get("adjustndgoal");
            objectMap = (Map<String, Object>) adjMap.get(mainguid);
            if (adjustndgoal != null && !adjustndgoal.isEmpty()) {
                goal.put("kpi_target", adjustndgoal);
                goal.put("ndgoal", adjustndgoal);
            }
            goal.put("yearflag", yearflag);
            goal.put("createtime", date);
            goal.put("create_time", date);
            goal.put("update_time",date);
            goal.put("updatetime",date);
            goal.put("creater", SecureUtil.getCurrentUser().getGuid());
            goal.put("is_last_inst",1);//是否终审
            goal.put("is_backup",2);
            goal.put("is_deleted",2);
            goal.put("versiontype",0);
            goal.put("version", PerfConstant.PMKPI_VERSION_RCDTWH);
            goal.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            goal.put("perf_obj_type_code", PerfConstant.PMKPI_TOW);
            goal.put("perf_obj_type_name", PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME_YEAR);
            goal.put("province", province);
            goal.put("mof_div_code", province);
            goal.put("mof_div_name", CommonUtil.getProvinceNameByCode(province));
            goal.put("year", year);
            goal.put("fiscal_year", year);
            goal.put("busi_type_code", "2");
            goal.put("mainguid", goal.get("proguid"));
            goal.put("pro_code", objectMap.get("pro_code"));
            goal.put("kpi_dep_id", goal.get("guid"));
            goal.put("agencyguid", objectMap.get("agencyguid"));
            goal.put("agency_code", objectMap.get("agencyguid"));
            if(StringUtil.isEmpty((String) goal.get("agency_name"))){
                goal.put("agency_name", agencyMaps.get(goal.get("agencyguid")));
            }
            goal.put("dept_code", goal.get("dept_code"));
            String newguid = this.getCreateguid();
            goal.put("guid", newguid);
            goal.put("kpi_per_id", newguid);
            goal.put("kpi_dep_id", newguid);
        }
        //对项目指标进行替换
        for (Map<String, Object> index : indexdatas) {
            mainguid = (String) index.get("mainguid");
            index.put("fromguid", mainguid);//调整主单id,记录用于取消终审
            String adjustindexval = (String) index.get("adjustindexval");
            Object adjustweight = index.get("adjustweight");
            objectMap = (Map<String, Object>) adjMap.get(mainguid);
            if (!StringUtil.isNullOrEmpty(adjustindexval)) {
                index.put("indexval", index.get("adjustindexval"));
                index.put("kpi_val", index.get("adjustindexval"));
            }
            if (!StringUtil.isNullOrEmpty(adjustweight)) {
                index.put("weight", Integer.parseInt(String.valueOf(adjustweight)));
            }
            index.put("pro_code", objectMap.get("pro_code"));
            index.put("mainguid", index.get("proguid"));
            index.put("yearflag", yearflag);
            String status = index.get("status") + "";
            if ("1".equals(status)) {
                index.put("is_deleted", "1");
            }
            index.put("createtime", date);
            index.put("create_time", date);
            index.put("update_time",date);
            index.put("updatetime",date);
            index.put("creater", SecureUtil.getCurrentUser().getGuid());
            index.put("is_last_inst",1);//是否终审
            index.put("is_backup",2);
            index.put("versiontype",0);
            index.put("version", PerfConstant.PMKPI_VERSION_RCDTWH);
            index.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            index.put("perf_obj_type_code", PerfConstant.PMKPI_TOW);
            index.put("perf_obj_type_name", PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME_YEAR);
            index.put("lv1_perf_ind_code", index.get("findex"));
            index.put("lv2_perf_ind_code", index.get("sindex"));
            index.put("lv3_perf_ind_code", index.get("code"));
            index.put("lv1_perf_ind_name", tempFrameMap.get(index.get("findex")));
            index.put("lv2_perf_ind_name", tempFrameMap.get(index.get("sindex")));
            index.put("lv3_perf_ind_name", index.get("name"));
            index.put("province", province);
            index.put("mof_div_code", province);
            index.put("mof_div_name", CommonUtil.getProvinceNameByCode(province));
            index.put("year", year);
            index.put("fiscal_year", year);
            index.put("agencyguid", objectMap.get("agencyguid"));
            index.put("agency_code", objectMap.get("agencyguid"));
            if(StringUtil.isEmpty((String) index.get("agency_name"))){
                index.put("agency_name", agencyMaps.get(index.get("agencyguid")));
            }
            String newguid = this.getCreateguid();
            index.put("guid", newguid);
            index.put("kpi_id", newguid);
            index.put("busi_type_code", "2");
            index.put("status", "");
        }
        HashSet<String> goalProcodeList = new HashSet<>();
        HashSet<String> indexProcodeList = new HashSet<>();
        //查询目标表数据，fromguid 封装删除数据
        List<Map<String, Object>> perfgoaldata = mergeIndexAdjustDAO.getDatas(goaltablecode, delindex, "order by update_time");
        if (perfgoaldata.size() > 0) {
            for (Map<String, Object> perfgoal: perfgoaldata) {
                String status = perfgoal.get("status") + "";
                perfgoal.put("is_deleted","1");
                perfgoal.put("updatetime",PerfUtil.getServerTimeStamp());
                perfgoal.put("update_time",PerfUtil.getServerTimeStamp());
                String oldprocode = (String) perfgoal.get("pro_code");
                goalProcodeList.add(oldprocode);
                for (Map<String, Object> goal : goaldatas) {
                    String newprocode = (String) goal.get("pro_code");
                    if(newprocode.equals(oldprocode)){
                        perfgoal.put("fromguid",goal.get("fromguid"));
                    }
                    if (!"null".equals(status)) {
                        goal.put("status", status);
                    }
                }
            }
        } else {
            //未填报绩效，最后一次取消，删除最后一次规范表数据标记
            goaldatas.forEach(m -> {m.put("status","6");});
        }
        //查询指标表数据，fromguid 封装删除数据
        List<Map<String, Object>> perfindexdata = mergeIndexAdjustDAO.getDatas(indextablecode, delindex, "order by update_time");
        if (perfindexdata.size() > 0) {
            for (Map<String, Object> perfindex: perfindexdata) {
                String status = perfindex.get("status") + "";
                perfindex.put("is_deleted","1");
                perfindex.put("updatetime",PerfUtil.getServerTimeStamp());
                perfindex.put("update_time",PerfUtil.getServerTimeStamp());
                String oldprocode = (String) perfindex.get("pro_code");
                indexProcodeList.add(oldprocode);
                for (Map<String, Object> index : indexdatas) {
                    String newprocode = (String) index.get("pro_code");
                    if(newprocode.equals(oldprocode)){
                        perfindex.put("fromguid",index.get("fromguid"));
                    }
                    if (!"null".equals(status)) {
                        index.put("status", status);
                    }
                }
            }
        } else {
            //未填报绩效，最后一次取消，删除最后一次规范表数据标记
            indexdatas.forEach(m -> {m.put("status","6");});
        }
        //清空新增数据的fromguid
        goaldatas.forEach(m -> {m.put("fromguid","");});
        indexdatas.forEach(m -> {m.put("fromguid","");});
        //同一项目多个指标多次终审时，前面调整删除数据，把关联字段清空，最后一次数据，保留关联关系，用户取消终审时还原数据
        wheresql = mergeIndexAdjustDAO.createInSql("fromguid", adjMap.keySet()) + " and province='" + province + "' and year='" + year + "' and is_backup=2 and yearflag='0' and is_deleted = 1";
        String upsql = " fromguid=null ";
        if (goaldatas != null && goaldatas.size() > 0) {
            if (goalProcodeList.size() > 0) {
                wheresql += " and " + mergeIndexAdjustDAO.createInSql("pro_code", goalProcodeList);
                mergeIndexAdjustDAO.updateAllByColumn(null, null, PerfConstant.PMKPI_BACKUP_GOAL_INFO, upsql, wheresql);
            }
            if (perfgoaldata != null && perfgoaldata.size() > 0) {
                mergeIndexAdjustDAO.updateAll(perfgoaldata,goaltablecode);
            }
            mergeIndexAdjustDAO.saveAll(goaldatas, goaltablecode);
        }

        if (indexdatas != null && indexdatas.size() > 0) {
            if (indexProcodeList.size() > 0) {
                wheresql += " and " + mergeIndexAdjustDAO.createInSql("pro_code", indexProcodeList);
                mergeIndexAdjustDAO.updateAllByColumn(null, null, PerfConstant.PMKPI_BACKUP_INDICATOR, upsql, wheresql);
            }
            if (perfindexdata != null && perfindexdata.size() > 0) {
                mergeIndexAdjustDAO.updateAll(perfindexdata,indextablecode);
            }
            mergeIndexAdjustDAO.saveAll(indexdatas, indextablecode);
        }
        //修改最后调整状态
        String sql = "update v_perf_t_adjust t set t.wfstatus='011',updatetime = ? where " + mergeIndexAdjustDAO.createInSql("pro_code", adjprocodeList) + " and islast=1";
        mergeIndexAdjustDAO.update(sql,new String[]{date});
    }

    private void traAdjust(String province, String year, Map<Object, Object> tempFrameMap, Map<String, String> agencyMaps, List<String> adjprocodeList, Map<String, Object> adjMap, Map<String, Object> subMap) throws AppException {
        String yearflag = "0";//1为调整总体绩效,默认为0年度绩效
        StringBuffer wheresql = new StringBuffer("(");
        for (String key : adjMap.keySet()) {
            Map<String, Object> map = (Map<String, Object>) adjMap.get(key);
            String guid = (String) map.get("guid");
            String pro_code = (String) map.get("pro_code");
            List<String> submofdivcodes = (List<String>) subMap.get(pro_code);
            if (wheresql.length() > 1) {
                wheresql.append(" or ");
            }
            wheresql.append("(mainguid='").append(guid).append("' and (sub_mof_div_code is null").append("");
            if (submofdivcodes != null && submofdivcodes.size() > 0) {
                for (String submofdivcode : submofdivcodes) {
                    wheresql.append(" or sub_mof_div_code='").append(submofdivcode).append("'");
                }
            }
            wheresql.append("))");
        }
        wheresql.append(") and yearflag='").append(yearflag).append("'");
        //查询调整目标
        List<Map<String, Object>> goaldatas = mergeIndexAdjustDAO.getDatas("v_perf_t_adjustallgoal", wheresql.toString(), "order by update_time");
        //查询调整指标
        wheresql.append(" and nvl(status,4) <> 1 ");
        List<Map<String, Object>> indexdatas = mergeIndexAdjustDAO.getDatas("v_perf_t_adjustallindex", wheresql.toString(), "order by update_time");
        String goaltablecode = PerfConstant.PMKPI_BACKUP_GOAL_INFO;
        String indextablecode = PerfConstant.PMKPI_BACKUP_INDICATOR;
        Map<String, Object> objectMap = null;
        String date = PerfUtil.getServerTimeStamp();
        //对项目目标进行替换
        String mainguid = "";
        HashSet<String> goalcodes = new HashSet<>();
        for (Map<String, Object> goal : goaldatas) {
            mainguid = (String) goal.get("mainguid");
            String adjustndgoal = (String) goal.get("adjustndgoal");
            objectMap = (Map<String, Object>) adjMap.get(mainguid);
            if (adjustndgoal != null && !adjustndgoal.isEmpty()) {
                goal.put("kpi_target", adjustndgoal);
                goal.put("ndgoal", adjustndgoal);
            }
            goal.put("yearflag", yearflag);
            goal.put("createtime", date);
            goal.put("create_time", date);
            goal.put("update_time",date);
            goal.put("updatetime",date);
            goal.put("creater", SecureUtil.getCurrentUser().getGuid());
            goal.put("is_last_inst",1);//是否终审
            goal.put("is_backup",2);
            goal.put("is_deleted",2);
            goal.put("versiontype",0);
            goal.put("version", PerfConstant.PMKPI_VERSION_RCDTWH);
            goal.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            goal.put("perf_obj_type_code", PerfConstant.PMKPI_TOW);
            goal.put("perf_obj_type_name", PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME_YEAR);
            goal.put("province", province);
            goal.put("mof_div_code", province);
            goal.put("mof_div_name", CommonUtil.getProvinceNameByCode(province));
            goal.put("year", year);
            goal.put("fiscal_year", year);
            goal.put("busi_type_code", "2");
            goal.put("mainguid", goal.get("proguid"));
            goal.put("pro_code", objectMap.get("pro_code"));
            goal.put("kpi_dep_id", goal.get("guid"));
            goal.put("agencyguid", objectMap.get("agencyguid"));
            goal.put("agency_code", objectMap.get("agencyguid"));
            if(StringUtil.isEmpty((String) goal.get("agency_name"))){
                goal.put("agency_name", agencyMaps.get(goal.get("agencyguid")));
            }
            goal.put("dept_code", goal.get("dept_code"));
            String newguid = this.getCreateguid();
            goal.put("guid", newguid);
            goal.put("kpi_per_id", newguid);
            goal.put("kpi_dep_id", newguid);
            goalcodes.add((String) goal.get("pro_code"));
        }
        //对项目指标进行替换
        HashSet<String> indexcodes = new HashSet<>();
        for (Map<String, Object> index : indexdatas) {
            mainguid = (String) index.get("mainguid");
            String adjustindexval = (String) index.get("adjustindexval");
            Object adjustweight = index.get("adjustweight");
            objectMap = (Map<String, Object>) adjMap.get(mainguid);
            if (!StringUtil.isNullOrEmpty(adjustindexval)) {
                index.put("indexval", index.get("adjustindexval"));
                index.put("kpi_val", index.get("adjustindexval"));
            }
            if (!StringUtil.isNullOrEmpty(adjustweight)) {
                index.put("weight", Integer.parseInt(String.valueOf(adjustweight)));
            }
            index.put("pro_code", objectMap.get("pro_code"));
            index.put("mainguid", index.get("proguid"));
            index.put("yearflag", yearflag);
            String status = index.get("status") + "";
            if ("1".equals(status)) {
                index.put("is_deleted", "1");
            }
            index.put("createtime", date);
            index.put("create_time", date);
            index.put("update_time",date);
            index.put("updatetime",date);
            index.put("creater", SecureUtil.getCurrentUser().getGuid());
            index.put("is_last_inst",1);//是否终审
            index.put("is_backup",2);
            index.put("versiontype",0);
            index.put("version", PerfConstant.PMKPI_VERSION_RCDTWH);
            index.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            index.put("perf_obj_type_code", PerfConstant.PMKPI_TOW);
            index.put("perf_obj_type_name", PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME_YEAR);
            index.put("lv1_perf_ind_code", index.get("findex"));
            index.put("lv2_perf_ind_code", index.get("sindex"));
            index.put("lv3_perf_ind_code", index.get("code"));
            index.put("lv1_perf_ind_name", tempFrameMap.get(index.get("findex")));
            index.put("lv2_perf_ind_name", tempFrameMap.get(index.get("sindex")));
            index.put("lv3_perf_ind_name", index.get("name"));
            index.put("province", province);
            index.put("mof_div_code", province);
            index.put("mof_div_name", CommonUtil.getProvinceNameByCode(province));
            index.put("year", year);
            index.put("fiscal_year", year);
            index.put("agencyguid", objectMap.get("agencyguid"));
            index.put("agency_code", objectMap.get("agencyguid"));
            if(StringUtil.isEmpty((String) index.get("agency_name"))){
                index.put("agency_name", agencyMaps.get(index.get("agencyguid")));
            }
            String newguid = this.getCreateguid();
            index.put("guid", newguid);
            index.put("kpi_id", newguid);
            index.put("busi_type_code", "2");
            index.put("status", "");
            indexcodes.add((String) index.get("pro_code"));
        }
        if (goaldatas != null && goaldatas.size() > 0) {
            StringBuffer goalsql = new StringBuffer("(");
            List<Map<String, Object>> goalList = null;
            for (String procode : goalcodes) {
                goalList = goaldatas.stream().filter(m-> procode.equals(m.get("pro_code"))).collect(Collectors.toList());
                if (goalsql.length() > 1) {
                    goalsql.append(" or ");
                }
                goalsql.append("(pro_code='").append(procode).append("' and (sub_mof_div_code is null").append("");
                HashSet<String> goalsubs = new HashSet<>();
                goalList.stream().forEach(m->
                        goalsubs.add((String) m.get("sub_mof_div_code"))
                );
                for (String submofdivcode : goalsubs) {
                    if (!StringUtil.isNullOrEmpty(submofdivcode)) {
                        int j = goalList.stream().filter(m-> submofdivcode.equals(m.get("sub_mof_div_code"))).collect(Collectors.toList()).size();
                        if (j > 0) {
                            goalsql.append(" or sub_mof_div_code='").append(submofdivcode).append("'");
                        }
                    }
                }
                goalsql.append("))");
            }
            goalsql.append(")");
            if (goalsql.length() > 2) {
                goalsql.append(" and is_deleted=2 and is_backup=2 and yearflag= '").append(yearflag).append("' and year='").append(year).append("' and province='").append(province).append("'");
                mergeIndexAdjustDAO.updateIndexDelStuts(goaltablecode, goalsql.toString());
            }
            mergeIndexAdjustDAO.saveAll(goaldatas, PerfConstant.PMKPI_VPM_GOAL_INFO);
        }
        if (indexdatas != null && indexdatas.size() > 0) {
            List<Map<String, Object>> indexList = null;
            StringBuffer indexsql = new StringBuffer("(");
            for (String procode : indexcodes) {
                indexList = goaldatas.stream().filter(m-> procode.equals(m.get("pro_code"))).collect(Collectors.toList());
                if (indexsql.length() > 1) {
                    indexsql.append(" or ");
                }
                indexsql.append("(pro_code='").append(procode).append("' and (sub_mof_div_code is null").append("");
                HashSet<String> indexsubs = new HashSet<>();
                indexList.stream().forEach(m->
                        indexsubs.add((String) m.get("sub_mof_div_code"))
                );
                for (String submofdivcode : indexsubs) {
                    if (!StringUtil.isNullOrEmpty(submofdivcode)) {
                        int j = indexList.stream().filter(m-> submofdivcode.equals(m.get("sub_mof_div_code"))).collect(Collectors.toList()).size();
                        if (j > 0) {
                            indexsql.append(" or sub_mof_div_code='").append(submofdivcode).append("'");
                        }
                    }
                }
                indexsql.append("))");
            }
            indexsql.append(")");
            if (indexsql.length() > 2) {
                indexsql.append(" and is_deleted=2 and is_backup=2 and yearflag= '").append(yearflag).append("' and year='").append(year).append("' and province='").append(province).append("'");
                mergeIndexAdjustDAO.updateIndexDelStuts(indextablecode, indexsql.toString());
            }
            mergeIndexAdjustDAO.saveAll(indexdatas, PerfConstant.PMKPI_VPM_INDICATOR);
        }
        //修改最后调整状态
        String sql = "update v_perf_t_adjust t set t.wfstatus='011',updatetime = ? where " + mergeIndexAdjustDAO.createInSql("pro_code", adjprocodeList) + " and islast=1";
        mergeIndexAdjustDAO.update(sql,new String[]{date});
    }

    /**
     * 调整调剂_取消终审（预算一体化调整调剂）
     * @param province
     * @param year
     * @return
     */
    public List cancelEndAdjperformance(String province, String year, List<String> codeList) throws AppException {
        List<Map<String, Object>> returnmapList = new ArrayList<>();
        String yearflag = "0";//1为调整总体绩效,默认为0年度绩效
        //取消已终审过的调整项目
        String wheresql = mergeIndexAdjustDAO.createInSql("pro_code", codeList) + " and islast = 1";
        //设置年度区划
        this.setYearAndProvince(year, province);
        //查询调整主单
        List<Map<String, Object>> adjustList = mergeIndexAdjustDAO.getDatas("v_perf_t_adjust", wheresql, "order by updatetime");
        List<String> adjMainList = new ArrayList<>();
        List<String> updatecols = Arrays.asList("is_deleted", "is_last_inst", "updatetime", "update_time", "fromguid");//更新用的字段
        List<String> proList = new ArrayList<>();
        if (adjustList.size() > 0) {
            for (Map<String, Object> map : adjustList) {
                String guid = (String) map.get("guid");
                String pro_code = (String) map.get("pro_code");
                adjMainList.add(guid);
                proList.add(pro_code);
            }
            String delindex = mergeIndexAdjustDAO.createInSql("pro_code", proList) + " and is_backup=2 and yearflag = ? and year = ? and province = ? ";
            String goaltablecode = PerfConstant.PMKPI_BACKUP_GOAL_INFO;
            String indextablecode = PerfConstant.PMKPI_BACKUP_INDICATOR;
            String wq = "";
            wheresql = delindex + " and is_deleted = 1 and " + mergeIndexAdjustDAO.createInSql("fromguid", adjMainList);
            wq = delindex + " and status = '6' and t.is_deleted=2";
            //查询已删除得标记fromguid的对应项目的年度目标表数据
            List<Map<String, Object>> deledgoaldata = mergeIndexAdjustDAO.getDatas(goaltablecode, wheresql, "order by update_time", new String[]{yearflag, year, province});
            //查询已删除得标记fromguid的对应项目的年度目标表数据
            List<Map<String, Object>> deledindexdata = mergeIndexAdjustDAO.getDatas(indextablecode, wheresql, "order by update_time", new String[]{yearflag, year, province});
            delindex += " and is_deleted = 2";
            String timestamp = PerfUtil.getServerTimeStamp();
            //判断，是否有预算调整调剂的终审调整数据，如果不存在，则就不需要处理调整前数据
            if (deledgoaldata.size() > 0) {
                //查询对应项目的年度目标表数据，更新为已删除
                List<Map<String, Object>> perfgoaldata = mergeIndexAdjustDAO.getDatas(goaltablecode, delindex, "order by update_time", new String[]{yearflag, year, province});
                if (perfgoaldata.size() > 0) {
                    for (Map<String, Object> perfgoal: perfgoaldata) {
                        perfgoal.put("is_deleted", 1);
                        perfgoal.put("is_last_inst", 2);
                        perfgoal.put("updatetime", timestamp);
                        perfgoal.put("update_time", timestamp);
                    }
                    mergeIndexAdjustDAO.updateAll(updatecols, perfgoaldata, goaltablecode);
                }
                //更新为未删除，清空fromguid
                if (deledgoaldata.size() > 0) {
                    for (Map<String, Object> delperfgoal: deledgoaldata) {
                        delperfgoal.put("is_deleted", 2);
                        delperfgoal.put("is_last_inst", 1);
                        delperfgoal.put("updatetime", PerfUtil.getServerTimeStamp());
                        delperfgoal.put("update_time", PerfUtil.getServerTimeStamp());
                        delperfgoal.put("fromguid", "");
                    }
                    mergeIndexAdjustDAO.updateAll(updatecols, deledgoaldata, goaltablecode);
                }
            } else {
                //申报未有填报绩效，多次取消审核，删除规范表数据
                deledgoaldata = mergeIndexAdjustDAO.getDatas(goaltablecode, wq, "order by update_time", new String[]{yearflag, year, province});
                if (deledgoaldata.size() > 0) {
                    for (Map<String, Object> perfgoal: deledgoaldata) {
                        perfgoal.put("is_deleted", 1);
                        perfgoal.put("is_last_inst", 2);
                        perfgoal.put("updatetime", timestamp);
                        perfgoal.put("update_time", timestamp);
                    }
                    mergeIndexAdjustDAO.updateAll(updatecols, deledgoaldata, goaltablecode);
                }
            }
            if (deledindexdata.size() > 0) {
                //查询对应项目的年度目标表数据，更新为已删除
                List<Map<String, Object>> perfindexdata = mergeIndexAdjustDAO.getDatas(indextablecode, delindex, "order by update_time", new String[]{yearflag, year, province});
                if (perfindexdata.size() > 0) {
                    for (Map<String, Object> perfindex: perfindexdata) {
                        perfindex.put("is_deleted", 1);
                        perfindex.put("is_last_inst", 2);
                        perfindex.put("updatetime", timestamp);
                        perfindex.put("update_time", timestamp);
                    }
                    mergeIndexAdjustDAO.updateAll(updatecols, perfindexdata, indextablecode);
                }
                if (deledindexdata.size() > 0) {
                    //更新为未删除，清空fromguid
                    for (Map<String, Object> delperfindex: deledindexdata) {
                        delperfindex.put("is_deleted", 2);
                        delperfindex.put("is_last_inst", 1);
                        delperfindex.put("updatetime", PerfUtil.getServerTimeStamp());
                        delperfindex.put("update_time", PerfUtil.getServerTimeStamp());
                        delperfindex.put("fromguid", "");
                    }
                    mergeIndexAdjustDAO.updateAll(updatecols,deledindexdata,indextablecode);
                }
            } else {
                deledindexdata = mergeIndexAdjustDAO.getDatas(indextablecode, wq, "order by update_time", new String[]{yearflag, year, province});
                if (deledindexdata.size() > 0) {
                    //更新为未删除，清空fromguid
                    for (Map<String, Object> delperfindex: deledindexdata) {
                        delperfindex.put("is_deleted", 1);
                        delperfindex.put("is_last_inst", 2);
                        delperfindex.put("updatetime", PerfUtil.getServerTimeStamp());
                        delperfindex.put("update_time", PerfUtil.getServerTimeStamp());
                    }
                    mergeIndexAdjustDAO.updateAll(updatecols,deledindexdata,indextablecode);
                }
            }
            //修改最后调整状态
            String sql = "update v_perf_t_adjust t set t.wfstatus='',updatetime = ? where " + mergeIndexAdjustDAO.createInSql("pro_code", codeList) + " and islast =1";
            mergeIndexAdjustDAO.update(sql,new String[]{timestamp});
        }
        return returnmapList;
    }

    /**
     * 调整调剂_取消终审（预算一体化调整调剂）
     * @param province
     * @param year
     * @return
     */
    public List delAdjperformance(String province, String year, List<String> codeList) throws AppException {
        List<Map<String, Object>> returnmapList = new ArrayList<>();
        //取消已终审过的调整项目
        String wheresql = mergeIndexAdjustDAO.createInSql("pro_code", codeList) + " and islast = 1 and wfid is null";
        //设置年度区划
        this.setYearAndProvince(year, province);
        //查询调整主单
        List<Map<String, Object>> adjustList = mergeIndexAdjustDAO.getDatas("v_perf_t_adjust", wheresql, "order by updatetime");
        List<String> adjMainList = new ArrayList<>();
        List<String> proList = new ArrayList<>();
        if (adjustList.size() > 0) {
            for (Map<String, Object> map : adjustList) {
                adjMainList.add((String) map.get("guid"));
                proList.add((String) map.get("pro_code"));
            }
            wheresql = mergeIndexAdjustDAO.createInSql("guid", adjMainList);
            mergeIndexAdjustDAO.delDatas("v_perf_t_adjust", wheresql);
            wheresql = mergeIndexAdjustDAO.createInSql("pro_code", proList);
            //修改不是末级
            String sql = "update v_perf_t_adjust t set t.islast=1 where exists(select * from ";
            sql += "(select max(a.adjustnum)adjustnum,pro_code from v_perf_t_adjust a where bustype= 'program' group by pro_code) b where " + wheresql;
            sql += " and b.adjustnum=t.adjustnum) and bustype= 'program'";
            mergeIndexAdjustDAO.execute(sql);
            wheresql = mergeIndexAdjustDAO.createInSql("mainguid", adjMainList);
            mergeIndexAdjustDAO.delDatas("v_perf_t_adjustgoal", wheresql);
            mergeIndexAdjustDAO.delDatas("v_perf_t_adjustindex", wheresql);
        }
        return returnmapList;
    }

    /**
     * 查询各年度数据.（预算一体化调整调剂）
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> findBdmAllIndex(Map<String, Object> params) throws AppException {
        String procode = (String)params.get("procode");//项目编码
        String viewtype = (String) params.get("viewtype");
        String adjmainguid = (String) params.get("adjmainguid");
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
        String tablecode = "v_perf_t_adjustindex";
        String goaltable = "v_perf_t_adjustgoal";
        //先查询是否有绩效目标调整在途数据
        List<Map<String, Object>> perfadjust = mergeIndexAdjustDAO.getDatas("v_perf_t_adjust", " pro_code='"+procode+"' and islast =1 and wfstatus is not null and wfstatus <> '011'", "order by guid");
        if(perfadjust!=null && perfadjust.size()>0){
            yearsMap.put("#noadjust","1");
            return yearsMap;
        }
        String proguid = "";
        Map<String, Object> promap = mergeIndexAdjustDAO.getDataMap("v_perf_project_info", "t.pro_code='" + procode + "'");
        proguid = (String) promap.get("pro_id");
        //项目库不分年度，总体目标指标根据区划查询物理表(只展示)
        String province = SecureUtil.getUserSelectProvince();
        tabfiler = " nvl(yearflag,'0') = '1' and t.is_deleted = 2 and t.is_backup=2 and t.province = '"+province+"'";
        totalindexs = mergeIndexAdjustDAO.findIndexsByCodeFilter(procode,"pm_perf_indicator", tabfiler);
        totalgoal = mergeIndexAdjustDAO.getGoalsByCodeFilter(procode, "pm_perf_goal_info", tabfiler);
        //查询调整主单
        if((adjmainguid == null || "".equals(adjmainguid)) && (procode !=null && !"".equals(procode))){
            String mainsql = " pro_code='"+procode+"' and islast =1 and (wfstatus is null or wfstatus <>'011') ";
            List<Map<String, Object>> mainadjust = mergeIndexAdjustDAO.getDatas("v_perf_t_adjust", mainsql, "order by guid");
            if(mainadjust!=null && mainadjust.size()>0){
                adjmainguid = (String) mainadjust.get(0).get("guid");
            }else if(!"query".equals(viewtype)){
                adjmainguid = this.getCreateguid();
            }
        }
        //年度指标和目标
        tabfiler = " nvl(yearflag,'0') = '0'";
        String goalsql = tabfiler+ " and pro_code = '"+procode+"'";
        yearindexs = mergeIndexAdjustDAO.findIndexsByFilter(adjmainguid,tablecode, tabfiler);
        if (yearindexs == null || yearindexs.size() <= 0) {
            String orderby = " order by yearflag,findex,sindex,ordernum";
            tablecode = "(select a.*,guid indexguid,weight as adjustweight from v_pm_perf_indicator a)";
            yearindexs = mergeIndexAdjustDAO.getDatas(tablecode, goalsql, orderby);
            for (Map<String, Object> map : yearindexs){
                map.put("guid", this.getCreateguid());
                map.put("mainguid", adjmainguid);
                map.put("status", "");
                if(map.get("adjustindexval") ==null){
                    map.put("adjustindexval", "");
                }
            }
        }
        yeargoal = mergeIndexAdjustDAO.getGoalsByFilter(adjmainguid, goaltable, tabfiler);
        if (yeargoal == null || yeargoal.size() <= 0) {
            String orderby = " order by guid";
            tablecode = "v_pm_perf_goal_info";
            yeargoal = mergeIndexAdjustDAO.getDatas(tablecode, goalsql, orderby);
        }

        List<Map<String, Object>> tempIndexList = new ArrayList<>();
        if ((totalindexs != null && totalindexs.size() > 0)) {
            indexs.addAll(totalindexs);
        }
        if ((totalgoal != null && totalgoal.size() > 0)) {
            goals.addAll(totalgoal);
        }
        if ((yearindexs != null && yearindexs.size() > 0)) {
            indexs.addAll(yearindexs);
        }
        if ((yeargoal != null && yeargoal.size() > 0)) {
            goals.addAll(yeargoal);
        }
        List<Map<String, Object>> nullTemp = mergeIndexAdjustDAO.getTempdatas(proguid); //空指标模板
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        // 区分项目多页签指标
        for (Map<String, Object> map : indexs) {
            String status = map.get("status") + "";
            if ("1".equals(status)) {
                map.put("obligate1", "撤销删除");
            } else {
                map.put("obligate1", "删除");
            }
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
        nullindex =(List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
        backindex = new ArrayList<Map<String,Object>>();
        for (Map<String, Object> map : nullindex) {
            String levelno = map.get("levelno") + "";
            map.put("_isleaf", "1");
            sindex = (String) map.get("sindex");
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
            String levelno = map.get("levelno") + "";
            if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                map.put("obligate1", "新增");
            }else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                map.put("obligate1", "");
            }
            map.put("_isleaf", "1");
            if(map.get("adjustindexval") == null){
                map.put("adjustindexval", "");
            }
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
        yearsMap.put("#adjmainguid",adjmainguid);
        return yearsMap;
    }

    /**
     * 绩效制度表树级展示保存.(预算一体化调整调剂)
     * @param params -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> saveBdmPrjTreeIndex(HashMap<String, Object> params) throws AppException {
        String yearflag = "0";
        String proguid;
        String adjmainguid = (String) params.get("adjmainguid");
        String saveAgency = (String) params.get("saveAgency");
        String procode = (String) params.get("procode"); //项目编码
        String pro_name = (String) params.get("pro_name");
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        Map<String, Object> tabcomps = (Map<String, Object>) params.get("datas"); //多页签的数据
        Map<String, Object> promap = mergeIndexAdjustDAO.getDataMap("v_perf_project_info", "t.pro_code='" + procode + "'");
        proguid = (String) promap.get("pro_id");
        if (StringUtil.isEmpty(saveAgency)){ //单位
            saveAgency = (String) promap.get("agency_code");
        }
        if (StringUtil.isEmpty(pro_name)){
            pro_name = (String) promap.get("pro_name");
        }
        String dept_code = saveAgency.length() == 3 ? saveAgency : saveAgency.substring(0, saveAgency.length() - 3);
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> nullTemp = dss.getRangesByWhereSql("PMKPIFRAME", "frametype='PM001'");
        Map<Object, Object> tempFrameMap = nullTemp.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
        String dept_name = (String) params.get("dept_name");
        String agency_name = (String) params.get("agency_name");
        if (StringUtil.isEmpty(dept_name) || StringUtil.isEmpty(agency_name)) {
            String wheresql = "guid in ('" + dept_code + "', '" + saveAgency + "')";
            List<DicRangeDTO> eledatas = PerfUtil.getSourceData("PMKPIAGENCYALLPAY", wheresql);
            if (eledatas != null && eledatas.size() > 0) {
                for (DicRangeDTO dicRangeDTO : eledatas) {
                    String code = dicRangeDTO.getCode();
                    if (code.equals(dept_code)) {
                        dept_name = dicRangeDTO.getName();
                    } else if (code.equals(saveAgency)) {
                        agency_name = dicRangeDTO.getName();
                    }
                }
            }
        }
        String date = PerfUtil.getServerTimeStamp();
        //如果主单不存在先插入主单
        List<Map<String, Object>> mainadjust = mergeIndexAdjustDAO.getDatas("v_perf_t_adjust", "guid='"+adjmainguid+"'", "order by guid");
        if(mainadjust.size()==0){
            //先更新最后一次调整数据状态
            String sql = "update v_perf_t_adjust t set t.islast = 0 where t.pro_code='" + procode + "' and islast =1";
            mergeIndexAdjustDAO.execute(sql);
            //封装新增主单数据
            Map<String, Object> adjustMap = new HashMap<>();
            adjustMap.put("adjustnum", 1);
            List<Map<String, Object>> adjustnums = mergeIndexAdjustDAO.getJustnums(proguid);
            int adjustnum = 0;
            if (adjustnums!=null && adjustnums.size()>0) {
                adjustnum = this.mapGetInt(adjustnums.get(0),"adjustnum");
                adjustMap.put("adjustnum", adjustnum + 1);
            }
            adjustMap.put("guid", adjmainguid);
            adjustMap.put("createtime", StringUtil.getSysDBDate());
            adjustMap.put("updatetime", StringUtil.getSysDBDate());
            adjustMap.put("creater", SecureUtil.getCurrentUser().getGuid());
            adjustMap.put("province", SecureUtil.getUserSelectProvince());
            adjustMap.put("year", CommonUtil.getYear());
            adjustMap.put("pro_code", procode);
            adjustMap.put("proguid", proguid);
            if(promap!=null){
                adjustMap.put("agencyguid", promap.get("agency_code"));
                adjustMap.put("manage_dept_code", promap.get("manage_dept_code"));
                adjustMap.put("manage_mof_dep_code", promap.get("manage_mof_dep_code"));
                adjustMap.put("mof_dep_code", promap.get("mof_dep_code"));
                adjustMap.put("dept_code", promap.get("dept_code"));
                adjustMap.put("agency_code", promap.get("agency_code"));
                adjustMap.put("finintorgguid", promap.get("mof_dep_code"));
            }
            adjustMap.put("islast", 1);
            adjustMap.put("adjstatus", "2");
            adjustMap.put("bustype", "program");
            mergeIndexAdjustDAO.save(adjustMap,"v_perf_t_adjust");
        }

        String levelno  =  "";
        String indexname = "";
        String tablecode = "v_perf_t_adjustindex";
        String goaltable = "v_perf_t_adjustgoal";
        int i = 0;
        List<Map<String, Object>> indexdataList = new ArrayList<Map<String, Object>>();
        Map<String, Object> goaldatamap = new HashMap<>();
        indexdataList = (List<Map<String, Object>>) tabcomps.get("#year");//年度绩效指标
        goaldatamap = (Map<String, Object>) tabcomps.get("#goalyear");//年度绩效目标
        //绩效指标
        for(Map tempMap : indexdataList){
            levelno = PerfUtil.mapGetInt(tempMap,"levelno") + "";
            indexname = (String) tempMap.get("name");
            if (levelno != null && "3".equals(levelno) && !StringUtil.isEmpty(indexname)) {
                String rowtype = (String) tempMap.get("rowtype");
                if (rowtype != null && "add".equals(rowtype)) {
                    tempMap.put("guid", this.getCreateguid());
                    tempMap.put("kpi_id", tempMap.get("guid"));
                    tempMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                    tempMap.put("createtime", date);
                    tempMap.put("create_time", date);
                }
                String indexguid = (String) tempMap.get("indexguid");
                if (indexguid != null && ! indexguid.isEmpty()) {
                    tempMap.put("tindex", tempMap.get("indexguid"));
                }
                tempMap.put("ordernum", i++);
                tempMap.put("proguid", proguid);
                tempMap.put("pro_code", procode);
                tempMap.put("pro_name", pro_name);
                tempMap.put("mainguid", adjmainguid);
                tempMap.put("yearflag", yearflag);
                tempMap.put("agencyguid", saveAgency);
                tempMap.put("agency_name", agency_name);
                tempMap.put("dept_code", dept_code);
                tempMap.put("dept_name", dept_name);
                tempMap.put("is_last_inst",2);//是否终审
                tempMap.put("is_backup",2);
                tempMap.put("perf_obj_type_code", PerfConstant.PMKPI_TOW);
                tempMap.put("perf_obj_type_name", PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME_YEAR);
                tempMap.put("kpi_val", tempMap.get("indexval"));
                tempMap.put("lv1_perf_ind_code", tempMap.get("findex"));
                tempMap.put("lv2_perf_ind_code", tempMap.get("sindex"));
                tempMap.put("lv3_perf_ind_code", tempMap.get("code"));
                tempMap.put("lv1_perf_ind_name", tempFrameMap.get(tempMap.get("findex")));
                tempMap.put("lv2_perf_ind_name", tempFrameMap.get(tempMap.get("sindex")));
                tempMap.put("lv3_perf_ind_name", tempMap.get("name"));
                this.getBasMap(tempMap,rowtype);
                indexList.add(tempMap); //用于审核定义
            }
        }
        Map<String,Object> returnMap = this.checkColLength(indexList);
        if(returnMap.size() > 0){
            return returnMap;
        }
        mergeIndexAdjustDAO.setIndexCode(indexList);
        String delsql = " mainguid='" + adjmainguid + "'";
        mergeIndexAdjustDAO.delDatas(tablecode, delsql);
        mergeIndexAdjustDAO.saveAll(indexList, tablecode);
        //绩效目标
        Map<String, Object> goalmap = null;
        List<Map<String, Object>> adjustdata = mergeIndexAdjustDAO.getDatas(goaltable, delsql, "order by update_time");
        if (adjustdata != null && adjustdata.size() > 0) {
            goalmap = adjustdata.get(0);
            goalmap.putAll(goaldatamap);
            goalmap.put("update_time", PerfUtil.getServerTimeStamp());
            goalmap.put("updatetime", PerfUtil.getServerTimeStamp());
            mergeIndexAdjustDAO.update(goalmap, goaltable);
        }else{
            String kpi_target = (String) goaldatamap.get("kpi_target");
            if (kpi_target == null || kpi_target.isEmpty()) {
                goaldatamap.put("kpi_target", " ");
            }
            goaldatamap.put("guid", this.getCreateguid());
            goaldatamap.put("mainguid", adjmainguid);
            goaldatamap.put("proguid", proguid);
            goaldatamap.put("agencyguid", saveAgency);
            goaldatamap.put("agency_code", saveAgency);
            goaldatamap.put("agency_name", agency_name);
            goaldatamap.put("dept_code", dept_code);
            goaldatamap.put("dept_name", dept_name);
            goaldatamap.put("pro_code", procode);
            goaldatamap.put("pro_name", pro_name);
            goaldatamap.put("kpi_per_id", goaldatamap.get("guid"));
            goaldatamap.put("yearflag", yearflag);
            goaldatamap.put("is_last_inst",2);//是否终审
            goaldatamap.put("is_backup",2);
            goaldatamap.put("perf_obj_type_code", PerfConstant.PMKPI_TOW);
            goaldatamap.put("perf_obj_type_name", PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME_YEAR);
            this.getBasMap(goaldatamap,"add");
            mergeIndexAdjustDAO.save(goaldatamap, goaltable);
            List<Map<String, Object>> goalList = new ArrayList<Map<String, Object>>();
            if(goaldatamap != null){
                goalList.add(goaldatamap);
            }
        }
        Map<String, Object> proMap = new HashMap<String, Object>();
        proMap.put("guid", procode);
        indexList = new ArrayList<Map<String, Object>>();
        indexList.add(proMap);
        String busguid = "bdmadjbusguid001"; //预算一体化调整调剂的审核定义-项目调整年度绩效.
        return this.auditdefine(indexList, busguid,"perf", null);
    }

    /**
     *
     * @param province
     * @param year
     * @return
     */
    public List checkYearAdjperformance(String province, String year, List<Map<String,Object>> guidList) throws AppException {
        //设置年度区划
        mergeIndexAdjustDAO.setYearAndProvince(year,province);
        mergeIndexAdjustDAO.saveAll(guidList,"PERF_TMP_GUIDS");
        return mergeIndexAdjustDAO.checkYearAdjperformance(province,year);
    }
}
