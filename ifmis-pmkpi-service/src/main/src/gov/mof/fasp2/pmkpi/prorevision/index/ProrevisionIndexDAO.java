package gov.mof.fasp2.pmkpi.prorevision.index;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ProrevisionIndexDAO extends PmkpiDAO {
    /**
     * 获取模板数据
     * @param type --
     * @return
     */
    public List<Map<String, Object>> getTempdatas(String type) {
        StringBuffer sql  = new StringBuffer("select guid,t.superid,t.code,t.name,levelno,isleaf,ordernum from ");
        sql.append(PMKPI_TABLE_T_FRAME).append(" t where frametype='").append(type).append("' order by ordernum");
        List<Map<String, Object>> flist = queryForList(sql.toString());
        List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : flist) {
            map.put("rowtype", "mod");
            String guid = (String) map.get("guid");
            String superid = (String) map.get("superid");
            String levelno = map.get("levelno") + "";
            if (!"1".equals(levelno)) {
                map.put("findex", superid);
                map.put("sindex", guid);
            }
            temps.add(map);
        }
        return temps;
    }
    /**
     * 指标树级获取指标.
     *
     * @param mainguid -- 项目guid.
     * @return list.
     */
    public List<Map<String, Object>> getTempdatas(String mainguid, String frametype) {
        StringBuffer sql  = new StringBuffer("select guid,'");
        sql.append(mainguid).append("' mainguid,t.superid,t.code,t.name,levelno,isleaf, '1' rowtype, ordernum from ");
        sql.append(PMKPI_TABLE_T_FRAME).append(" t where frametype='").append(frametype).append("' order by ordernum");
        List<Map<String, Object>> flist = queryForList(sql.toString());
        List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : flist) {
            String guid = (String) map.get("guid");
            String superid = (String) map.get("superid");
            String levelno = map.get("levelno") + "";
            if (!"1".equals(levelno)) {
                map.put("findex", superid);
                map.put("sindex", guid);
            }
            map.put("is_add", "0");
            map.put("zqindexval", "");
            map.put("zqmeterunit", "");
            map.put("zqcomputesign", "");
            map.put("adjoption", "");
            map.put("options", "");
            temps.add(map);
        }
        return temps;
    }

    /**
     * 根据条件查询指标数据.
     *
     * @param proguid   -- 项目guid.
     * @param tablecode -- 查询案例表或项目指标表
     * @param wheresql  -- 过滤条件.
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexsByFilter(String proguid, String tablecode, String wheresql) {
        String isZJ = PerfUtil.getSystemSet("isZJ"); //是否是浙江环境
        StringBuffer sql = new StringBuffer();
        if (null != isZJ && isZJ != "" && "1".equals(isZJ) && "v_pm_perf_indicator".equals(tablecode)) { //浙江环境
            sql.append("select 1 isleaf, '1' rowtype,t.*, ");
            sql.append(" case when f.ADJOPTION = '1' then '指标不够完整' " +
                    "            when f.ADJOPTION = '2' then '指标不够细化、量化' " +
                    "              when f.ADJOPTION = '3' then '指标与项目的相关性不够' " +
                    "            when f.ADJOPTION = '4' then '指标与指标值不匹配' " +
                    "              when f.ADJOPTION = '5' then '建议拆分指标' " +
                    "              when f.ADJOPTION = '6' then '一级指标类型错误' " +
                    "                when f.ADJOPTION = '7' then '二级指标类型错误' " +
                    "                  when f.ADJOPTION = '8' then '建议增加明确效益指标' " +
                    "                    when f.ADJOPTION = '9' then '建议增加明确产出指标' " +
                    "                    when f.ADJOPTION = '10' then '建议增加满意度指标' " +
                    "                      when f.ADJOPTION = '11' then '其他'  end ADJOPTION,");
            sql.append(" f.options from ").append(tablecode).append(" t ");
            sql.append("left join (select * from v_perf_t_supervision where wfstatus = '011') f ");
            sql.append("on t.kpi_id = f.indexguid and t.mainguid = f.mainguid where t.mainguid = '");
        } else {
            sql.append("select 1 isleaf, '1' rowtype,t.* from ").append(tablecode).append(" t where t.mainguid = '");
        }
        sql.append(proguid).append("'");
        if (!StringUtil.isEmpty(wheresql)) {
            sql.append(" and ");
            sql.append(wheresql);
        }
        sql.append(" order by yearflag,t.findex,t.sindex,t.ordernum");
        logger.debug("sql.toString():::"+sql.toString());

        return this.queryForList(sql.toString());
    }

    /**
     * 根据条件查询指标数据.
     *
     * @param proGuid   -- 项目guid.
     * @param tempFilter  -- 显示页签
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexsByFilter(String proGuid, String procode, String[] tempFilter) {
        String tableCode = "";
        StringBuffer wheresql = null;
        String isZJ = PerfUtil.getSystemSet("isZJ"); //是否是浙江环境
        String isSX = PerfUtil.getSystemSet("isSX"); //是否是山西环境
        StringBuffer sql = null;
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag : tempFilter) {
            if (yearflag != null && "1".equals(yearflag)) {
                tableCode = "pm_perf_indicator";
            } else if (yearflag != null && "0".equals(yearflag)) {
                tableCode = "v_pm_perf_indicator";
            }
            wheresql = new StringBuffer();
            if (yearflag != null && "1".equals(yearflag)) {
                wheresql.append(" nvl(yearflag,'0') = '1' and is_deleted = 2 and is_backup=2 and  t.mainguid ='").append(proGuid).append("'");
            } else if ("0".equals(yearflag)) {
                if(PerfUtil.getIsHbei()){
                    wheresql.append(" nvl(yearflag,'0') = '0' and  t.mainguid ='").append(proGuid).append("'");
                }else {
                    wheresql.append(" nvl(yearflag,'3') = '0' and t.pro_code='").append(procode).append("'");
                }
            }
            sql = new StringBuffer();
            if (isZJ != null && !isZJ.isEmpty() && "1".equals(isZJ) && ("v_pm_perf_indicator".equals(tableCode) || "pm_perf_indicator".equals(tableCode))) { //浙江环境
                sql.append("select 1 isleaf, '1' as rowtype,t.*, ");
                sql.append(" case when f.ADJOPTION = '1' then '指标不够完整' " +
                        "            when f.ADJOPTION = '2' then '指标不够细化、量化' " +
                        "              when f.ADJOPTION = '3' then '指标与项目的相关性不够' " +
                        "            when f.ADJOPTION = '4' then '指标与指标值不匹配' " +
                        "              when f.ADJOPTION = '5' then '建议拆分指标' " +
                        "              when f.ADJOPTION = '6' then '一级指标类型错误' " +
                        "                when f.ADJOPTION = '7' then '二级指标类型错误' " +
                        "                  when f.ADJOPTION = '8' then '建议增加明确效益指标' " +
                        "                    when f.ADJOPTION = '9' then '建议增加明确产出指标' " +
                        "                    when f.ADJOPTION = '10' then '建议增加满意度指标' " +
                        "                      when f.ADJOPTION = '11' then '其他'  end ADJOPTION,");
                sql.append(" f.options from ").append(tableCode).append(" t ");
                sql.append("left join (select * from v_perf_t_supervision where wfstatus = '011') f ");
                sql.append("on t.kpi_id = f.indexguid and t.mainguid = f.mainguid where t.mainguid = '");
                sql.append(proGuid).append("'");
            }else {
                sql.append("select 1 isleaf, '1' as rowtype,t.* from ").append(tableCode).append(" t ");
            }
            if (!StringUtil.isEmpty(wheresql.toString())) {
                sql.append(" where ").append(wheresql);
            }
            sql.append(" order by yearflag,t.findex,t.sindex,t.ordernum");
            logger.debug("sql.toString():::"+sql.toString());
            List<Map<String, Object>> indexList = this.queryForList(sql.toString());
            //山西环境 若无年度绩效指标  则查询实施期绩效指标  若年度指标存在  则拼接实施期绩效指标
            if(isSX != null && !isSX.isEmpty() && "1".equals(isSX) && ("v_pm_perf_indicator".equals(tableCode) || "pm_perf_indicator".equals(tableCode))){ //山西环境
                if (yearflag != null && "0".equals(yearflag)) {//年度绩效指标查询
                    sql = new StringBuffer();
                    if (indexList == null || indexList.size()==0){
                        sql.append("select 1 isleaf, t.indexval as zqindexval,t.computesign as zqcomputesign,t.meterunit as zqmeterunit,'1' as rowtype,t.* from ")
                        .append("pm_perf_indicator").append(" t where t.mainguid = '").append(proGuid).append("' and nvl(yearflag,'0') = '1' and is_deleted = '2'")
                        .append(" and t.is_backup =2 and t.province='").append(CommonUtil.getProvince()).append("'");
                        indexList = this.queryForList(sql.toString());
                        logger.debug("查询实施期绩效指标:::"+sql.toString()+"指标个数"+indexList.size());
                        if (indexList !=null && indexList.size()>0){
                            for(Map<String,Object> map : indexList){
                                map.put("yearflag","0");
                                map.put("guid",StringUtil.createUUID());
                                map.put("rowtype","add");
                            }
                        }
                    }else{
                        sql.append("select t.*,tt.indexval as zqindexval,tt.computesign as zqcomputesign,tt.meterunit as zqmeterunit ");
                        sql.append(" from (select * from v_pm_perf_indicator where nvl(yearflag,'0') = '0' ) t");
                        sql.append(" left join (select * from v_pm_perf_indicator where yearflag = '1' and mainguid = '").append(proGuid).append("') tt");
                        sql.append(" on t.name = tt.name and t.superid = tt.superid where t.pro_code = '").append(procode).append("'");
                        indexList = this.queryForList(sql.toString());
                        logger.debug("查询年度期绩效指标关联实施期指标值:::"+sql.toString()+"指标个数"+indexList.size());
                    }
                }
            }
            list.addAll(indexList);
        }
        return list;
    }

}
