/**
 * @Title: PrjIndexBO.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfpromod.prjindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexBO
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:41:23
 */

public class ProModIndexBO extends PmkpiBO {
    /**
     * proModIndexDAO.
     */
    private ProModIndexDAO proModIndexDAO;
    /**
     * 注入dao.
     * @param proModIndexDAO --proModIndexDAO.
     * @throws
     */
    public void setProModIndexDAO(ProModIndexDAO proModIndexDAO) {
        this.proModIndexDAO = proModIndexDAO;
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
        String mainguid = (String) params.get("mainguid");
        String pagetype = (String) params.get("pagetype");
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String sindex = "";
        if (pagetype == null || !"adjust".equals(pagetype)) {
            mainguid = proguid;
        }
        List<Map<String, Object>> indexs = proModIndexDAO.findIndexs(mainguid,"perf_t_prjindex");
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
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
        List<Map<String, Object>> nullTemp = proModIndexDAO.findNullTemp(proguid); //空指标模板
        List<Map<String, Object>> backindex = new ArrayList<Map<String,Object>>(); //返回指标
        for (Map<String, Object> map : nullTemp) {
            sindex = (String) map.get("sindex");
            map.put("guid",this.getCreateguid());
            keycode = sindex;
            if (indexMap.containsKey(keycode)) {
                tempList = indexMap.get(keycode);
                backindex.addAll(tempList);
            } else {
                backindex.add(map);
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
        String proguid = (String) params.get("proguid");
        String mainguid = (String) params.get("mainguid");
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String modtype = (String) params.get("modtype");
        Map<String, Object> goalMap = (Map<String, Object>) params.get("goaldatas");
        List<Map<String, Object>> indexList = (List<Map<String, Object>>) params.get("indexdatas");
        String yearflag = "";
        if (modtype != null && "total".equals(modtype)) {
            yearflag = "1";
        }else {
            yearflag = "0";
        }
        Map<String, Object> promap = proModIndexDAO.queryForMap("select * from v_perf_project_info t where t.guid='" + proguid + "'");
        String goalguid = this.getCreateguid();
        goalMap.put("guid", goalguid);
        goalMap.put("kpi_per_id", goalguid);
        goalMap.put("pro_code", promap.get("pro_code"));
        goalMap.put("creater", SecureUtil.getCurrentUserID());
        goalMap.put("createtime", PerfUtil.getServerTimeStamp());
        goalMap.put("updatetime", PerfUtil.getServerTimeStamp());
        goalMap.put("proguid", proguid);
        goalMap.put("mainguid", mainguid);
        goalMap.put("yearflag", yearflag);
        goalMap.put("province", SecureUtil.getUserSelectProvince());
        goalMap.put("year", CommonUtil.getYear());
        goalMap.put("mof_div_code", SecureUtil.getUserSelectProvince());
        goalMap.put("fiscal_year", CommonUtil.getYear());
        String version = PerfUtil.getServerTimeStamp();
        goalMap.put("version", version);
        goalMap.put("version_name", "项目绩效目标修订_" + version);
        //将此数据插入修订目标表中
        String delsql = " t.mainguid = '"+mainguid+"'";
        proModIndexDAO.delDatas("V_PERF_PROVISION_GOAL_INFO", delsql);
        proModIndexDAO.save(goalMap, "V_PERF_PROVISION_GOAL_INFO");
        int i = 0;
        String levelno = "";
        String indexname = "";
        String rowtype = "";
        List<Map<String, Object>> saveList = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> indexMap : indexList) {
            i++;
            levelno = PerfUtil.mapGetInt(indexMap, "levelno") + "";
            indexname = (String) indexMap.get("name");
            rowtype = (String) indexMap.get("rowtype");
            if (levelno != null && "3".equals(levelno) && !StringUtil.isEmpty(indexname)) {
                indexMap.put("mainguid", proguid);
                indexMap.put("ordernum", i);
                indexMap.put("yearflag", yearflag);
                indexMap.put("kpi_val", indexMap.get("indexval"));
                indexMap.put("mainguid", mainguid);
                indexMap.put("proguid", proguid);
                indexMap.put("yearflag", yearflag);
                version = PerfUtil.getServerTimeStamp();
                indexMap.put("version", version);
                indexMap.put("version_name", "项目绩效指标修订_" + version);
                if (rowtype != null && "add".equals(rowtype)) {
                    indexMap.put("agency_code", saveAgency);
                    indexMap.put("pro_code", promap.get("pro_code"));
                    indexMap.put("prjguid", proguid);
                    indexMap.put("agencyguid", saveAgency);
                    this.setIndexMap(indexMap);
                    saveList.add(indexMap);
                } else {
                    indexMap.put("updatetime", PerfUtil.getServerTimeStamp());
                    indexMap.put("update_time", PerfUtil.getServerTimeStamp());
                    saveList.add(indexMap);
                }
            }
        }
        proModIndexDAO.setIndexCode(saveList);
        //保存修改、新增的指标
        delsql = "  t.mainguid = '"+mainguid+"'";
        proModIndexDAO.delDatas("V_PERF_PROVISION_INDICATOR", delsql);
        proModIndexDAO.saveAll(saveList, "V_PERF_PROVISION_INDICATOR");
        return this.auditdefine(saveList, busguid,"perf", null);
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
        String filer = (String)sqlmap.get("filer");
        String sindex = (String)sqlmap.get("sindex");//二级指标.
        String saveAgency = (String)sqlmap.get("saveAgency");
        String pagetype = (String)sqlmap.get("pagetype"); //指标查询类型
        String mainguid = (String)sqlmap.get("mainguid"); //推荐指标中,左侧树 1部门指标2财政指标
        if (!StringUtil.isEmpty(filer)) {
            sql.append(filer);
        }
        sql.append(" select * from perf_v_allindex p ");
        sql.append(" where (p.agencyguid in ( select c.guid from pmkpi_fasp_t_pubagency c where (c.guid = '").append(saveAgency).append("' or c.superguid = '");
        sql.append(saveAgency).append("'))").append(" or p.agencyguid = '#')");
        if (pagetype != null && "pickindex".equals(pagetype)) { //挑选指标才添加二级
            sql.append(" and sindex = '").append(sindex).append("'");
        } else { //指标推荐
            sql.append(" and type = '").append(mainguid).append("'");
        }
        sql.append(" order by p.updatetime");
        return sql.toString();
    }

    public void setIndexMap(Map tempMap) {
        tempMap.put("province", CommonUtil.getProvince());
        tempMap.put("createtime", PerfUtil.getServerTimeStamp());
        tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
        tempMap.put("creater", SecureUtil.getCurrentUser().getGuid());
        tempMap.put("year", CommonUtil.getYear());
        tempMap.put("kpi_id", tempMap.get("guid"));
        tempMap.put("kpi_lv1", tempMap.get("findex"));
        tempMap.put("kpi_lv2", tempMap.get("sindex"));
        tempMap.put("agency_code", tempMap.get("agencyguid"));
        tempMap.put("create_time", PerfUtil.getServerTimeStamp());
        tempMap.put("update_time", PerfUtil.getServerTimeStamp());
        tempMap.put("mof_div_code", SecureUtil.getUserSelectProvince());
        tempMap.put("fiscal_year", CommonUtil.getYear());
        tempMap.put("is_deleted", "2");
    }

    /**
     * 获取目标数据
     * @param params --项目guid
     * @return
     */
    public Map<String, Object> getGoal(Map<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String proguid = (String) params.get("proguid");
        String modtype = (String) params.get("modtype");
        String yearflagsql = "";
        String tablecode = "";
        if (modtype != null && "total".equals(modtype)) {
            yearflagsql = " and t.yearflag = '1' and is_deleted=2 and is_backup=2";
            tablecode = "PM_PERF_GOAL_INFO";
        }else {
            yearflagsql = " and t.yearflag = '0'";
            tablecode = "V_PM_PERF_GOAL_INFO";
        }
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(" t.mainguid ='").append(mainguid)
                .append("' and t.proguid = '").append(proguid).append("' ").append(yearflagsql);

        Map<String, Object> goalMap = proModIndexDAO.getDataMap("V_PERF_PROVISION_GOAL_INFO", wheresql.toString());
        if(goalMap.isEmpty()){
            wheresql = new StringBuffer();
            wheresql.append(" t.mainguid ='").append(proguid).append("' ").append(yearflagsql);
            goalMap = proModIndexDAO.getDataMap(tablecode, wheresql.toString());
        }
        return goalMap;
    }

    /**
     * 获取指标数据
     * @param params --项目guid
     * @return
     */
    public List<Map<String, Object>> getIndex(Map<String, Object> params) throws AppException{
        String mainguid = (String) params.get("mainguid");
        String proguid = (String) params.get("proguid");
        String modtype = (String) params.get("modtype");
        String yearflagsql = "";
        String tablecode = "";
        if (modtype != null && "total".equals(modtype)) {
            yearflagsql = " and t.yearflag = '1' and t.is_backup=2";
            tablecode = "PM_PERF_INDICATOR";
        }else {
            yearflagsql = " and t.yearflag = '0'";
            tablecode = "V_PM_PERF_INDICATOR";
        }
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(" t.mainguid ='").append(mainguid)
                .append("' and t.proguid = '").append(proguid).append("' ").append(yearflagsql);

        List<Map<String, Object>> indexList = proModIndexDAO.getDatas("V_PERF_PROVISION_INDICATOR", wheresql.toString(),"order by code");
        if(indexList.size() == 0){
            wheresql = new StringBuffer();
            wheresql.append(" t.mainguid ='").append(proguid).append("' ").append(yearflagsql);
            indexList = proModIndexDAO.getDatas(tablecode, wheresql.toString(), "order by code");
        }

        List<Map<String, Object>> nullTemp = proModIndexDAO.getTempdatas(proguid, "PM001"); //空指标模板 //空指标模板
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        for (Map<String, Object> map : indexList) {
            keycode = (String) map.get("sindex");
            if (!indexMap.containsKey(keycode)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(keycode, tempList);
            } else {
                tempList = indexMap.get(keycode);
            }
            map.put("_isleaf", "1");
            tempList.add(map);
        }
        // 区分项目空模板赋值，不然没有共有字段不显示
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode("V_PERF_PROVISION_INDICATOR");
        for (Map<String, Object> map : nullTemp) {
            for (DicColumnDTO dicdto : dicColumnDTOs) {
                if (!map.containsKey(dicdto.getDbcolumncode())) {
                    map.put(dicdto.getDbcolumncode().toLowerCase(), "");
                }
            }
        }
        //处理绩效指标
        List<Map<String, Object>> nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp); //空模板
        List<Map<String, Object>> backindex = new ArrayList<Map<String, Object>>(); //返回指标
        for (Map<String, Object> map : nullindex) {
            keycode = (String) map.get("sindex");
            map.put("_isleaf", "1");
            if (indexMap.containsKey(keycode)) {
                tempList = indexMap.get(keycode);
                map.put("isleaf", "0");
                backindex.add(map);
                backindex.addAll(tempList);
            } else {
                backindex.add(map);
            }
        }

        return backindex;
    }
}
