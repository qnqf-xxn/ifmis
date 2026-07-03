package gov.mof.fasp2.pmkpi.perfprogram.approvalquery.prjindex;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


/**
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-1-6 上午10:42:14
 * @ClassName: PrjIndexDAO
 * @Description: Description of this class
 */

public class ApprovalPrjIndexDAO extends PmkpiDAO {
    public static final String PMKPI_TABLE_TMP_AGENCY = "PERF_TMP_AGENCY";

    //模板库的表
    public static final String PMKPI_PERF_T_CASEMODELINDEX = "PERF_T_CASEMODELINDEX";


    /**
     * 根据条件查询指标数据.
     *
     * @param proGuid   -- 项目guid.
     * @param tempFilter  -- 显示页签
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexsByFilter(String proGuid, String procode, String[] tempFilter,String goalguid) {
        String tableCode = "v_perf_bgt_indicatorpf";
        StringBuffer wheresql = null;
        StringBuffer sql = new StringBuffer();
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag : tempFilter) {
            wheresql = new StringBuffer();
            if (yearflag != null && "1".equals(yearflag)) {
                wheresql.append(" yearflag = '1' and is_deleted = 2 and  t.mainguid ='").append(proGuid).append("'");
            } else if ("0".equals(yearflag)) {
                if(PerfUtil.getIsHbei()){
                    wheresql.append(" yearflag = '0' and t.mainguid='").append(proGuid).append("'");
                }else{
                    wheresql.append(" yearflag = '0' and t.pro_code='").append(procode).append("'");
                }
            }
            sql.append("select 1 isleaf, '1' as rowtype,t.* from ").append(tableCode).append(" t where 1=1 ");
            if (!StringUtil.isEmpty(wheresql.toString())) {
                sql.append(" and ");
                sql.append(wheresql);
            }
            sql.append(" order by yearflag,t.findex,t.sindex,t.ordernum");
            logger.debug("sql.toString():::"+sql.toString());
            List<Map<String, Object>> indexList = this.queryForList(sql.toString());
            list.addAll(indexList);
        }
        return list;
    }

    /**
     * 指标树级获取指标.
     *
     * @param mainGuid -- 项目guid.
     * @return list.
     */
    public List<Map<String, Object>> getTempdatas(String mainGuid, String frameType) {
        String sql = "select guid,'" + mainGuid + "' mainguid,t.superid,t.code,t.name,levelno,isleaf, '1' as rowtype, ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='" + frameType + "' order by ordernum";
        List<Map<String, Object>> flist = queryForList(sql);
        List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : flist) {
            //map.put("rowtype", "mod");
            String guid = (String) map.get("guid");
            String superId = (String) map.get("superid");
            String levelNo = map.get("levelno") + "";
            if (levelNo != null && !"1".equals(levelNo)) {
                map.put("findex", superId);
                map.put("sindex", guid);
                //map.put("_isleaf", map.get("isleaf"));
            }
            map.put("is_add", "0");
            map.put("zqindexval", "");
            map.put("zqmeterunit", "");
            map.put("zqcomputesign", "");
            map.put("adjoption", "");
            map.put("options", "");
            map.put("qnindexval", "");//前年指标值
            map.put("snindexval", "");//上年指标值
            temps.add(map);
        }
        return temps;
    }

    /**
     * 查询页面表格的注册字段
     *
     * @param uiKey
     * @return
     */
    public List<Map<String, Object>> getUicolumn(String uiKey) {
        String sql = "SELECT * FROM ( " +
                "SELECT LOWER(a.columncode) as columncode,a.name,a.ordernum FROM busfw_t_Uicolumn a where " +
                "a.key='" + uiKey + "' and a.columncode in('FINDEX','SINDEX') " +
                " UNION ALL " +
                "SELECT LOWER(t.columncode) as columncode,t.name,t.ordernum FROM busfw_t_Uicolumn t where " +
                "t.key='" + uiKey + "' and t.isvisiable=1 and  t.columncode <>'OBLIGATE1'" +
                "union all select 'type' columncode ,'类型' as name, 0 ordernum from dual ) order by ordernum";
        return this.queryForList(sql);
    }

    //通过模板编码查询模板中的指标数据,根据页签查询数据，如果页签为1需要两份数据，一份yearflag为0的，一份yearflag为1的数据
    public List<Map<String, Object>> findIndexsByTempCode(String proGuid,String tempCode,String[] tempFilter) {
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearFlag:tempFilter) {
            List<Map<String, Object>> indexlist = new ArrayList<>();
            StringBuffer sql = new StringBuffer();
            sql.append(" select  3 levelno, 'add' as rowtype, '" + proGuid + "' as mainguid, '" + yearFlag + "' as yearflag, t.*,SINDEX as superguid,SINDEX as superid,sys_guid()  guid,sys_guid()  code from ").append(PMKPI_PERF_T_CASEMODELINDEX);
            sql.append(" t right join V_PERF_T_MODEL vptm on (t.mainguid = vptm.guid) where 1=1 and vptm.code = '").append(tempCode).append("' ");
            indexlist = this.queryForList(sql.toString());
            list.addAll(indexlist);
            logger.info("获取内置模板指标数据：-------------" + sql.toString());
        }
        return list;
    }

    public List<Map<String, Object>> findIndexsSpecial(String proGuid, String procode, String[] tempFilter) {
        StringBuffer sql = null;
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag : tempFilter) {
            sql = new StringBuffer();
            sql.append("select sys_guid() as guid,code,name,findex,sindex,tindex,findex as kpi_lv1,sindex as kpi_lv2, code as kpi_lv3,sindex as superid," +
                    "indexvalue as indexval,framesystem,computesign,meterunit,weight,kpi_remark,status,createtime,updatetime,creater,province,year," +
                    "sys_guid() as kpi_id,ordernum,'2' as is_deleted,updatetime as update_time,createtime as create_time,province as mof_div_code,year as fiscal_year," +
                    "'0' as is_add,'1' as busi_type_code,'3' as levelno,'"+procode+"' as pro_code,'"+proGuid+"' as proguid,'"+proGuid+"' as mianguid,");
            if (yearflag != null && "1".equals(yearflag)) {
                sql.append(" '1' as yearflag");
            }  else if ("0".equals(yearflag)) {
                sql.append(" '0' as yearflag");
            }
            sql.append(" from v_perf_T_casemodelindex t where exists (select * from v_perf_T_model t1 where t.mainguid = t1.guid and t1.code = '13' )");

            logger.debug("sql.toString():::"+sql.toString());
            List<Map<String, Object>> indexList = this.queryForList(sql.toString());
            list.addAll(indexList);
        }
        return list;
    }
}
