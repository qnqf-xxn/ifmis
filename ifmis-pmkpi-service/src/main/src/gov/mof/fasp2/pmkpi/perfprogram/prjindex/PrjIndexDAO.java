/**
 * @Title: PrjIndexDAO.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.dto.DataSetDTO;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.ConnectionCallback;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-1-6 上午10:42:14
 * @ClassName: PrjIndexDAO
 * @Description: Description of this class
 */

public class PrjIndexDAO extends PmkpiDAO {
    public static final String PMKPI_TABLE_TMP_AGENCY = "PERF_TMP_AGENCY";
    //部门绩效指标的menuid，用来获取数据权限
    public static final String PMKPI_PRJ_MENUID = "deptperformancehide";

    //模板库的表
    public static final String PMKPI_PERF_T_CASEMODELINDEX = "PERF_T_CASEMODELINDEX";

    /**
     * 指标表.
     */
    public static final String PMKPI_TABLE_PM_INDEX = "V_PM_PERF_INDICATOR";

    /**
     * 查询年度指标空指标模板.
     *
     * @param proguid -- 项目.
     * @return list.
     */
    public List<Map<String, Object>> findNullTemp(String proguid) {
        String sql = "select sys_guid() guid, t.superid findex, t.guid sindex, t.guid frame, '"
                + proguid + "' prjguid from " + PMKPI_TABLE_T_FRAME + " t where "
                + " t.isleaf = 1 and t.frametype = 'PM001' order by ordernum";
        return this.queryForList(sql);
    }

    /**
     * 获取固化指标
     *
     * @param proguid
     * @param yearflag
     * @return
     */
    public List<Map<String, Object>> getProFixedIndexData(String proguid,String yearflag) {
        String fixedindex = PerfUtil.getSystemSet("ISLOADFIXEDINDEX"); //是否开启固化指标配置 1.关闭  2.开启 ，默认1
        if(!StringUtil.isEmpty(fixedindex) && "2".equals(fixedindex)){
            String sql = "select t.code,t.name,t.findex,t.sindex,t.ordernum,t.remark,t.status,t.weight,t.indexval,t.computesign,t.meterunit,t.yearflag,t.frametype,t.is_deleted,t.create_time,t.update_time,t.year,t.province," +
                    "t.sindex as superid,sys_guid()||'' as guid,'add' as rowtype,'3' as levelno,1 as isfixed,'" + proguid + "' prjguid from V_PERF_T_FIXEDINDEX t where t.frametype=? and t.yearflag = ? ";
            sql += "order by t.ordernum";
            logger.info("---固化指标查询sql：" + sql);
            return PerfUtil.lowMapKey(this.queryForList(sql, new String[]{"PM001",yearflag}));
        }else{
            return new ArrayList<>();
        }
    }

    /**
     * 获取父级项目总体指标
     * 带过来的一级项目绩效指标不能删除，只有指标值可改，其他要素都不能改；增加‘是否适用’标识（必填，默认是）
     * 20240830 追加逻辑，只查询nvl(t.onlyself,2)=2 “仅本级适用”为否的数据，根据t.isallowedit'是否允许修改指标值'为1指标值给空
     * @param proguid 项目id
     * @param parentproid 父级项目id
     * @param yearflag 年度或总体
     * @return
     */
    public List<Map<String, Object>> getParentProIndexData(String proguid,String parentproid,String yearflag) {
        String sql = "select t.code,t.name,t.findex,t.sindex,t.ordernum,t.status,t.weight,t.isallowedit,t.onlyself," +
                "case when t.isallowedit = '1' then '' else t.indexval end as indexval,t.computesign,t.meterunit,t.kpi_remark,'"+yearflag+"' yearflag,t.is_deleted,t.create_time,t.update_time,t.year,t.province," +
                "t.sindex as superid,sys_guid()||'' as guid,'add' as rowtype,'3' as levelno,1 as isfromparent, 1 as isapply, '" + proguid + "' proguid from pm_perf_indicator t where nvl(t.onlyself,2)=2 and t.is_deleted = 2 and t.is_backup = 2 and t.yearflag = ? and t.mainguid = ? and t.province =?";
        sql += "order by t.ordernum";
        logger.info("---父级项目总体指标查询sql：" + sql);
        List<Map<String, Object>> parentIndexList = this.queryForList(sql, new String[]{yearflag,parentproid,SecureUtil.getUserSelectProvince()});
        if(parentIndexList.size()>0){
            return PerfUtil.lowMapKey(parentIndexList);
        }else{
            return new ArrayList<>();
        }
    }

    /**
     * 根据项目，年度，查询年度明细指标.
     *
     * @param proGuid   -- 项目guid.
     * @param tableCode -- 查询案例表或项目指标表
     * @return list.
     * @throws
     */

    public List<Map<String, Object>> findIndexs(String proGuid, String tableCode, String wheresql) {
        String isZJ = PerfUtil.getSystemSet("isZJ"); //是否是浙江环境
        StringBuffer sql = new StringBuffer();
        if ("1".equals(isZJ) && tableCode != null && "v_pm_perf_indicator".equals(tableCode)) { //浙江环境
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
            sql.append("left join v_perf_t_supervision f ");
            sql.append("on t.kpi_id = f.indexguid and t.pro_code = f.mainguid where f.wfstatus = '011' and t.mainguid = '");
        } else {
            sql.append("select * from ").append(tableCode).append(" t where t.mainguid = '");
        }

        sql.append(proGuid).append("'");
        if (!StringUtil.isEmpty(wheresql)) {
            sql.append(" and ").append(wheresql);
        }
        sql.append(" order by t.sindex,t.findex,t.ordernum");
        logger.debug("-------------指标查询sql-------------" + sql.toString());
        return this.queryForList(sql.toString());
    }

    /**
     * 推荐指标查询左侧树.
     *
     * @param tabCode -- 表名
     * @param filter  -- 过滤条件
     * @return
     * @throws
     */
    public List<Map<String, Object>> finTreeData(String tabCode, String filter) {
        StringBuffer sql = new StringBuffer(" select t.* from ");
        sql.append(tabCode).append(" t ");
        if (!StringUtil.isEmpty(filter)) {
            sql.append(" where 1=1 ").append(filter);
        }
        sql.append(" order by code");
        logger.debug("查询指标推荐左侧树sql:"+ sql.toString());
        return this.queryForList(sql.toString());
    }

    /**
     * 获取部门guid
     *
     * @param agencyGuid
     * @return
     */
    public List<Map<String, Object>> getDeptGuid(String agencyGuid) {
        String sql = "select t.guid,t.code||'-'||t.NAME as agency from " + PMKPI_TABLE_T_AGENCY + " t " +
                " where t.id in (select a.superid from " + PMKPI_TABLE_T_AGENCY + " a where a.GUID= " +
                " '" + agencyGuid + "')";
        return this.queryForList(sql);
    }

    /**
     * 根据条件查询指标数据.
     *
     * @param proGuid   -- 项目guid.
     * @param pdmSave -- 保存类型 20草稿保存
     * @param tempFilter  -- 显示页签
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexsByFilter(String proGuid, String procode, String pdmSave, String[] tempFilter,String goalguid, String dataprovince) {
        String tableCode = "";
        StringBuffer wheresql = null;
        String isZJ = PerfUtil.getSystemSet("isZJ"); //是否是浙江环境
        String isSX = PerfUtil.getSystemSet("isSX"); //是否是山西环境
        StringBuffer sql = null;
        String province = StringUtil.isNullOrEmpty(dataprovince) ? SecureUtil.getUserSelectProvince() : dataprovince;
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag : tempFilter) {
            if (pdmSave != null && "20".equals(pdmSave)) {
                tableCode = "v_pm_perf_indicator_temp";
            } else {
                if (yearflag != null && "1".equals(yearflag)) {
                    tableCode = "pm_perf_indicator";
                } else if (PerfUtil.getProgramIsyear() && "0".equals(yearflag)) {//项目库填报年度
                    tableCode = "pm_perf_indicator";
                } else if (yearflag != null && "0".equals(yearflag)) {
                    tableCode = "v_pm_perf_indicator";
                }
            }
            wheresql = new StringBuffer();
            String wsql = "";
            if ("20".equals(pdmSave)) {
                wsql = " and is_deleted = 2 and t.mainguid ='" + proGuid + "' and t.province='" + province + "'";
            }else{
                wsql = " and is_deleted = 2 and is_backup = 2 and t.mainguid ='" + proGuid + "' and t.province='" + province + "'";
            }
            if (yearflag != null && "1".equals(yearflag)) {
                wheresql.append(" yearflag = '1'").append(wsql);
            } else if (PerfUtil.getProgramIsyear() && "0".equals(yearflag)) {//草稿查询年度绩效，pro_code空，根据项目guid查询
                wheresql.append(" yearflag = '0' ").append(wsql).append(" and t.year='").append(SecureUtil.getUserSelectYear()).append("'");
                wheresql.append(" and t.sub_mof_div_code is null");//追加条件，查询物理表时过滤掉转移支付数据
            } else if ("0".equals(yearflag)) {
                if(PerfUtil.getIsHbei()){
                    wheresql.append(" yearflag = '0' and t.mainguid='").append(proGuid).append("'");
                }else if("20".equals(pdmSave)){//草稿查询年度绩效，pro_code空，根据项目guid查询
                    wheresql.append(" yearflag = '0'").append(wsql);
                }else{
                    wheresql.append(" yearflag = '0' and t.pro_code='").append(procode).append("'");
                }
            }
            sql = new StringBuffer();
            if (isZJ != null && !isZJ.isEmpty() && "1".equals(isZJ) && ("v_pm_perf_indicator".equals(tableCode) || "pm_perf_indicator".equals(tableCode))) { //浙江环境
                sql.append("select 1 isleaf, '1' as rowtype,t.* ,");
                if (yearflag != null && "0".equals(yearflag)) {//年度绩效指标查询
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
                    sql.append(" f.options from ");
                    sql.append(tableCode).append(" t ");
                    sql.append("left join (select * from v_perf_t_supervision where wfstatus = '011') f ");
                    sql.append("on t.kpi_id = f.indexguid and t.pro_code = f.mainguid ");
                } else {
                    sql.append(" '' as ADJOPTION, '' as options from ");
                    sql.append(tableCode).append(" t ");
                }
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
                        sql.append("select 1 isleaf, t.indexval as zqindexval,t.computesign as zqcomputesign,t.meterunit as zqmeterunit,'1' as rowtype,t.* from pm_perf_indicator t where t.mainguid = '").
                                append(proGuid).append("' and nvl(yearflag,'0') = '1' and is_deleted = 2 and is_backup=2 and province='" + CommonUtil.getProvince() + "'");
                        indexList = this.queryForList(sql.toString());
                        logger.debug("查询实施期绩效指标:::"+sql.toString()+"指标个数"+indexList.size());
                        if (indexList !=null && indexList.size()>0){
                            for(Map<String,Object> map : indexList){
                                map.put("yearflag","0");
                                map.put("guid",StringUtil.createUUID());
                                map.put("rowtype","add");
                                map.put("year", CommonUtil.getYear());
                            }
                        }
                    }else{
                        sql.append("select t.*,tt.indexval as zqindexval,tt.computesign as zqcomputesign,tt.meterunit as zqmeterunit ");
                        sql.append(" from (select * from v_pm_perf_indicator where nvl(yearflag,'0') = '0' ) t");
                        sql.append(" left join (select * from pm_perf_indicator where yearflag = '1' and mainguid = '").append(proGuid).append("' and is_deleted = 2 and is_backup=2 and province='" + CommonUtil.getProvince() + "') tt");
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

    /**
     * 指标树级获取指标.
     *
     * @param mainGuid -- 项目guid.
     * @return list.
     */
    public List<Map<String, Object>> getTempdatas(String mainGuid, String frameType) {
        String sql = "select guid,'" + mainGuid + "' mainguid,t.superid,t.code,t.name,levelno,isleaf, '1' as rowtype, weight as frameweight, ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='" + frameType + "' order by ordernum";
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
            map.put("is_add", "2");
            map.put("zqindexval", "");
            map.put("zqmeterunit", "");
            map.put("zqcomputesign", "");
            map.put("adjoption", "");
            map.put("options", "");
            map.put("qnindexval", "");//前年指标值
            map.put("snindexval", "");//上年指标值
            map.put("ai_recoindexmark", "");
            temps.add(map);
        }
        return temps;
    }

    /**
     * 授权指标左侧树
     * @return
     * @throws AppException
     */
    public List finAuthDeptTreeData(String province,String year) throws AppException {
        String elementCode = "INDEXCOMFUNCAUTH";
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        DataSetDTO ds = dss.getDataSetByElementCode(elementCode);
        String querySql = (String) ds.get("datasource");
        StringBuffer sql = new StringBuffer();
        sql.append(" select t.guid,t.superid from ( ");
        sql.append(querySql);
        sql.append(" )t where exists(select 1 from BAS_PERF_INDICATOR vbpi where vbpi.province ='"+province+"' and vbpi.is_deleted =2 and vbpi.industrycategory = t.guid and vbpi.wfstatus = '011' ");
        sql.append(" and vbpi.agencyguid is not null )");
        sql.append(" and PERF_AUTHPROVINCE_VIEW.set_province('"+ province +"') = '"+ province +"' and PERF_AUTHPROVINCE_VIEW.set_year('"+ year +"') = '"+ year +"'");
        logger.info("============================查询涉及的树"+sql);
        List<Map<String, Object>> list = this.queryForList(sql.toString());
        List superlist = new ArrayList();
        Map superMap = null;
        String superid = "";
        for (Map temp:list) {
            superid = (String) temp.get("superid");
            if (!"#".equals(superid) && !"0".equals(superid)){
                superMap = new HashMap();
                superMap.put("guid",superid);
                superlist.add(superMap);
            }
            superlist.add(temp);
        }
        this.saveAll(superlist,"PERF_TMP_GUIDS");
        StringBuffer sqlsuper = new StringBuffer();
        sqlsuper.append("select t.*, 'indexdept' as mogamisuperid from (");
        sqlsuper.append(querySql);
        sqlsuper.append(") t where exists (select 1 from PERF_TMP_GUIDS a where a.guid=t.guid ) ");
        logger.debug("----------------查询节点"+sqlsuper.toString());
        list = this.queryForList(sqlsuper.toString());
        //处理一级节点的父级是 固定节点部门整体 indexdept
        String guid = "";
        for (Map<String, Object> map : list) {
            superid = (String) map.get("superid");
            guid = (String) map.get("guid");
            map.put("guid","indexdept" + guid); //通用版本的财政个性与部门个性分类数据源一样，展示树有问题处理
            if ("#".equals(superid) || "0".equals(superid)){
                map.put("superid","indexdept");
                map.put("superguid","indexdept");
            } else {
                map.put("superid","indexdept"+superid);
                map.put("superguid","indexdept"+superid);
            }
        }
        list.addAll(this.deptNodes());
        return list;
    }

    /**
     * 江西部门指标左侧树拼接.
     * @param eleDatas -- 有指标的分类集合
     * @return
     * @throws AppException
     */
    public List finDeptJxTreeData(List<DicRangeDTO> eleDatas) throws AppException {
        this.saveAll(eleDatas,PMKPI_TABLE_TMP_AGENCY);
        String sql = "select * from V_PERF_T_INDEXCLASS t where t.status = 1 and exists (select 1 from " + PMKPI_TABLE_TMP_AGENCY + " k where t.guid = k.guid )";
        List<Map<String, Object>> list = this.queryForList(sql.toString());
        List superlist = new ArrayList();
        Map tempMap = null;
        // INDEXCATEGORIES,INDUSTRYCATEGORY,INDEXCATEGORY,FILED,OCCUPATION
        for (Map temp:list) {
            if (temp.get("indexcategories") != null){
                tempMap = new HashMap();
                tempMap.put("guid",(String)temp.get("indexcategories"));
                superlist.add(tempMap);
            }
            if (temp.get("industrycategory") != null){
                tempMap = new HashMap();
                tempMap.put("guid",(String)temp.get("industrycategory"));
                superlist.add(tempMap);
            }
            if (temp.get("indexcategory") != null){
                tempMap = new HashMap();
                tempMap.put("guid",(String)temp.get("indexcategory"));
                superlist.add(tempMap);
            }
            if (temp.get("filed") != null){
                tempMap = new HashMap();
                tempMap.put("guid",(String)temp.get("filed"));
                superlist.add(tempMap);
            }
            superlist.add(temp);
        }
        this.saveAll(superlist,"PERF_TMP_GUIDS");
        StringBuffer sqlsuper = new StringBuffer(" select guid,code,name,superguid,superguid superid,levelno,isleaf,status, 'indexdept' as mogamisuperid");
        sqlsuper.append(" from V_PERF_T_INDEXCLASS t");
        sqlsuper.append(" where exists (select 1 from PERF_TMP_GUIDS a where a.guid=t.guid ) ");
        sqlsuper.append(" order by code");
        logger.debug("----------------查询节点"+sqlsuper.toString());
        list = this.queryForList(sqlsuper.toString());
        //处理一级节点的父级是 固定节点部门整体 indexdept
        String guid = "";
        String superid = "";
        for (Map<String, Object> map : list) {
            superid = (String) map.get("superid");
            guid = (String) map.get("guid");
            map.put("guid","indexdept" + guid); //通用版本的财政个性与部门个性分类数据源一样，展示树有问题处理
            if ("#".equals(superid) || "0".equals(superid)){
                map.put("superid","indexdept");
                map.put("superguid","indexdept");
            } else {
                map.put("superid","indexdept"+superid);
                map.put("superguid","indexdept"+superid);
            }
            map.put("levelno", Integer.parseInt(String.valueOf(map.get("levelno")))+1);
        }
        list.addAll(this.deptNodes());
        return list;
    }

    /**
     * 通用部门指标查询左侧树。
     * @param elementCode -- 单位编码.
     * @param eleDatas --注册的分类数据源.
     * @return
     * @throws AppException
     */
    public List finDeptTreeData(String elementCode,List<DicRangeDTO> eleDatas) throws AppException {
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        DataSetDTO ds = dss.getDataSetByElementCode(elementCode);
        String querySql = (String) ds.get("datasource");
        //1 优化sql输出,判断来源语句，主要有V_ELE_VD10004, v_perf_enum（安徽，江西） 两种
        String selectsql = " select t.guid,t.superguid as superid ";
        String lefttable = " from V_ELE_VD10004 t where t.status = 1 and t.levelno in (1, 2) and t.is_deleted =2 "; //功能科目
        String order = " order by t.code";
        if (querySql.toUpperCase().indexOf("v_perf_enum".toUpperCase()) > 0) {
            selectsql = " select t.guid,t.superguid as superid ";
            lefttable = " from V_PERF_ENUM t where t.elementcode = 'INDEXCOMFUNC'";
            order = " order by t.ordernum";
        }
        StringBuffer sql = new StringBuffer(selectsql);
        this.saveAll(eleDatas,PMKPI_TABLE_TMP_AGENCY);
        logger.info("============================eleDatas::"+eleDatas.size());
        sql.append(lefttable);
        sql.append(" and exists (select 1 from ")
                .append(PMKPI_TABLE_TMP_AGENCY).append(" k where t.guid = k.guid ) ").append(order);
        logger.info("============================查询涉及的树"+sql);
        List<Map<String, Object>> list = this.queryForList(sql.toString());
        List superlist = new ArrayList();
        Map superMap = null;
        String superid = "";
        for (Map temp:list) {
            superid = (String) temp.get("superid");
            if (!"#".equals(superid) && !"0".equals(superid)){
                superMap = new HashMap();
                superMap.put("guid",superid);
                superlist.add(superMap);
            }
            superlist.add(temp);
        }
        this.saveAll(superlist,"PERF_TMP_GUIDS");
        StringBuffer sqlsuper = new StringBuffer();
        sqlsuper.append("select t.guid,t.code,t.name,t.superguid,t.superguid as superid,t.levelno,t.isleaf,'indexdept' as mogamisuperid ");
        sqlsuper.append(lefttable);
        sqlsuper.append(" and exists (select 1 from PERF_TMP_GUIDS a where a.guid=t.guid ) ");
        sqlsuper.append(order);
        logger.debug("----------------查询节点"+sqlsuper.toString());
        list = this.queryForList(sqlsuper.toString());
        //处理一级节点的父级是 固定节点部门整体 indexdept
        String guid = "";
        for (Map<String, Object> map : list) {
            superid = (String) map.get("superid");
            guid = (String) map.get("guid");
            map.put("guid","indexdept" + guid); //通用版本的财政个性与部门个性分类数据源一样，展示树有问题处理
            if ("#".equals(superid) || "0".equals(superid)){
                map.put("superid","indexdept");
                map.put("superguid","indexdept");
            } else {
                map.put("superid","indexdept"+superid);
                map.put("superguid","indexdept"+superid);
            }
        }
        list.addAll(this.deptNodes());
        return list;
    }

    /**
     * 封装部门左侧树节点数据.
     * @return
     */
    public List deptNodes() {
        List list = new ArrayList();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("guid", "indexdept");
        map.put("code", "03");
        map.put("name", "部门指标");
        map.put("superguid", "#");
        map.put("superid", "#");
        map.put("levelno", "1");
        map.put("status", "1");
        map.put("isleaf", "0");
        map.put("mogamisuperid", "indexdept");
        list.add(map);
        if (PerfUtil.getIS_HUBEI()){
            Map<String, Object> tempMap = new HashMap<String, Object>();
            tempMap.put("guid", "01");
            tempMap.put("code", "01");
            tempMap.put("name", "项目支出");
            tempMap.put("superguid", "indexdept");
            tempMap.put("superid", "indexdept");
            tempMap.put("levelno", "2");
            tempMap.put("status", "1");
            tempMap.put("isleaf", "0");
            tempMap.put("mogamisuperid", "indexdept");
            Map<String, Object> twoMap = new HashMap<String, Object>();
            twoMap.put("guid", "02");
            twoMap.put("code", "02");
            twoMap.put("name", "转移支付");
            twoMap.put("superguid", "indexdept");
            twoMap.put("superid", "indexdept");
            twoMap.put("levelno", "2");
            twoMap.put("status", "1");
            twoMap.put("isleaf", "0");
            twoMap.put("mogamisuperid", "indexdept");
            Map<String, Object> twoMap1 = new HashMap<String, Object>();
            twoMap1.put("guid", "021");
            twoMap1.put("code", "021");
            twoMap1.put("name", "整体绩效目标");
            twoMap1.put("superguid", "02");
            twoMap1.put("superid", "02");
            twoMap1.put("levelno", "3");
            twoMap1.put("status", "1");
            twoMap1.put("isleaf", "0");
            twoMap1.put("mogamisuperid", "indexdept");
            Map<String, Object> twoMap2 = new HashMap<String, Object>();
            twoMap2.put("guid", "022");
            twoMap2.put("code", "022");
            twoMap2.put("name", "区域绩效目标");
            twoMap2.put("superguid", "02");
            twoMap2.put("superid", "02");
            twoMap2.put("levelno", "3");
            twoMap2.put("status", "1");
            twoMap2.put("isleaf", "0");
            twoMap2.put("mogamisuperid", "indexdept");
            Map<String, Object> twoMap3 = new HashMap<String, Object>();
            twoMap3.put("guid", "023");
            twoMap3.put("code", "023");
            twoMap3.put("name", "项目绩效目标");
            twoMap3.put("superguid", "02");
            twoMap3.put("superid", "02");
            twoMap3.put("levelno", "3");
            twoMap3.put("status", "1");
            twoMap3.put("isleaf", "0");
            twoMap3.put("mogamisuperid", "indexdept");
            list.add(tempMap);
            list.add(twoMap);
            list.add(twoMap1);
            list.add(twoMap2);
            list.add(twoMap3);
        }
        if (PerfUtil.getIsSx()){
            StringBuffer commonsql = new StringBuffer(" select t.*,superid as superguid,'1' as rowtype from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87' and proelement in ('sx00','sx01')");
            commonsql.append(" order by t.ordernum");
            List<Map> commdar= this.queryForList(commonsql.toString());
            for (Map com:commdar) {
                String comguid = (String) com.get("guid");
                if("sx01".equals(comguid)||"sx02".equals(comguid)){
                    com.put("superguid", "indexdept");
                    com.put("superid", "indexdept");
                }
                com.put("mogamisuperid", "indexdept");
            }
            list.addAll(commdar);
        }
        return  list;
    }

    //通过模板编码查询模板中的指标数据,根据页签查询数据，如果页签为1需要两份数据，一份yearflag为0的，一份yearflag为1的数据
    public List<Map<String, Object>> findIndexsByTempCode(String proGuid, String procode,String tempCode,String[] tempFilter) {
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearFlag:tempFilter) {
            List<Map<String, Object>> indexlist = new ArrayList<>();
            StringBuffer sql = new StringBuffer();
            sql.append(" select  3 levelno, '" + procode + "' as pro_code, 'add' as rowtype, '" + proGuid + "' as mainguid, '" + yearFlag + "' as yearflag, t.*,SINDEX as superguid,SINDEX as superid,sys_guid()  guid from ").append(PMKPI_PERF_T_CASEMODELINDEX);
            sql.append(" t right join V_PERF_T_MODEL vptm on (t.mainguid = vptm.guid) where vptm.code = '").append(tempCode).append("' ");
            indexlist = this.queryForList(sql.toString());
            list.addAll(indexlist);
            logger.info("获取内置模板指标数据：-------------" + sql.toString());
        }
        return list;
    }

    /**
     * <p>绩效指标逻辑删除</p >
     *
     * @author hw
     * @date 2021/9/24 14:44
     * @param
     */
    public void updateDatasIsDelete(String tablecode, String wheresql) throws AppException {
        tablecode = "pm_perf_indicator";
        String selectSql = "select * from " + tablecode + " t where t.is_deleted = 2 and is_backup=2 and t.sub_mof_div_code is null ";
        if (wheresql != null && !wheresql.isEmpty()) {
            selectSql += " and " + wheresql;
            logger.info("---指标逻辑删除查询sql----------" + selectSql);
            List<Map<String, Object>> mapList = queryForList(selectSql);
            String time = PerfUtil.getServerTimeStamp();
            for(Map<String, Object> map : mapList){
                String uuid = StringUtil.createUUID();
                map.put("is_deleted", 1); // 删除
                map.put("updatetime", time); //UPDATETIME
                map.put("update_time", time); //UPDATETIME
            }
            this.updateAllByPK(mapList, "guid", tablecode); // 更新主键和删除状态
//            String sql = " update "+tablecode+" t set t.guid = t.kpi_id, is_deleted = 1 where t.is_deleted = 2 and is_backup=2 and t.sub_mof_div_code is null  and " +wheresql;
//            logger.info("---指标逻辑删除sql----------" + sql);
//            this.execute(sql); //更新guid
        }
    }

    /**
     * 获取单位的下级数据.
     * @param  guid -- guid.
     * @param  tablecode -- 表名
     * @return --
     */
    public List<Map<String, Object>> getElementDatas(String guid, String tablecode) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct t.* from (" + tablecode + ") ");
        sql.append(" t start with  t.guid='").append(guid).append("'");
        sql.append(" connect by prior t.guid = t.superid");
        sql.append(" order by code ");
        return this.queryForList(sql.toString());
    }

    public List<Map<String, Object>> findIndexsSpecial(String proGuid, String procode, String[] tempFilter) {
        StringBuffer sql = null;
        List<Map<String,Object>> list = new ArrayList<>();
        for (String yearflag : tempFilter) {
            sql = new StringBuffer();
            sql.append("select sys_guid()||'' as guid,code,name,findex,sindex,tindex,findex as kpi_lv1,sindex as kpi_lv2, code as kpi_lv3,sindex as superid," +
                    "indexvalue as indexval,framesystem,computesign,meterunit,weight,kpi_remark,status,createtime,updatetime,creater,province,year," +
                    "sys_guid()||'' as kpi_id,ordernum,'2' as is_deleted,updatetime as update_time,createtime as create_time,province as mof_div_code,year as fiscal_year," +
                    "'2' as is_add,'1' as busi_type_code,'3' as levelno,'"+procode+"' as pro_code,'"+proGuid+"' as proguid,'"+proGuid+"' as mianguid,'rcdtwh' as version,'日常动态维护版本' as version_name,'add' as rowtype,");
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

    /**
     *  获取年度绩效指标.
     * @param province
     * @param year
     * @return  list.
     */
    public List getQueryPerfIndex(final String province, final String year) {
        return (List) getJdbcTemplate().execute(new ConnectionCallback() {
            public Object doInConnection(Connection conn) throws SQLException {
                ResultSet rs = null;
                CallableStatement cstmt = null;
                List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
                try{
                    String sql = "{ call pkg_perf_queryProperf.getPerfIndex(?,?,?)}";
                    cstmt = conn.prepareCall(sql);
                    cstmt.setString(1, province);
                    cstmt.setString(2, year);
                    cstmt.registerOutParameter(3, OracleTypes.CURSOR);
                    cstmt.execute();
                    rs = (ResultSet) cstmt.getObject(3);
                    while (rs.next()) {
                        HashMap<String, Object> m = getHashMapByReS(rs);
                        list.add(m);
                    }
                } catch (SQLException e) {
                    logger.error(e.getMessage(), e);
                } finally {
                    if (rs != null) {
                        rs.close();
                    }
                    if (cstmt != null) {
                        cstmt.close();
                    }
                }
                return list;
            }
        });
    }
}
