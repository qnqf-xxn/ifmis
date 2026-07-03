package gov.mof.fasp2.pmkpi.common;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.service.IUserService;
import gov.mof.fasp2.buscore.framework.daosupport.Fasp2DaoSupport;
import gov.mof.fasp2.buscore.framework.daosupport.appexception.DaoAppException;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.LogFactory;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.dto.DicTableDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.cloud.framework.security.util.SecurityUtils;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import oracle.jdbc.OracleTypes;
import org.apache.commons.lang.StringUtils;
import org.springframework.jdbc.core.ConnectionCallback;

import java.sql.*;
import java.util.*;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

public class PmkpiDAO extends Fasp2DaoSupport {

    public static final String APPID = "pmkpi";//系统表示


    /**
     * 审核意见主单表
     */
    public static final String PMKPI_TABLE_T_AUDITMAIN = "V_PERF_T_AUDITMAIN";

    /**
     * 审核意见子单表
     */
    public static final String PMKPI_TABLE_T_AUDITITEMS = "PERF_T_AUDITITEMS";

    /**
     * 绩效预警规则表
     */
    public static final String PMKPI_TABLE_T_WARNSET = "V_PERF_T_WARNSET";

    /**
     * 绩效任务表
     */
    public static final String PMKPI_TABLE_T_TAKSSET = "V_PERF_T_TASKSET";

    /**
     * 单位表.
     */
    public static final String PMKPI_TABLE_T_AGENCY = "PMKPI_FASP_T_PUBAGENCY";

    /**
     * 层次分类表（一、二级指标表）
     */
    public static final String PMKPI_TABLE_T_FRAME = "V_PERF_T_FRAME";

    /**
     * 层次分类表（一、二级指标表），87,2016
     */
    public static final String PMKPI_TABLE_T_INDEXFRAME = "V_PERF_T_INDEXFRAME";

    /**
     * 层次分类类型
     */
    public static final String PMKPI_TABLE_T_FRAMESYSTEM = "V_PERF_T_FRAMESYSTEM";

    /**
     * 单位临时表.
     */
    public static final String PMKPI_TABLE_TMP_AGENCY = "PERF_TMP_AGENCY";

    /**
     * 日志.
     */
    protected Logger logger = LogFactory.getLog(this.getClass());


    /**
     * 单位临时表.
     */
    public static final String PMKPI_TABLE_TMP_GUIDS = "PERF_TMP_GUIDS";

    /**
     * 单位临时表.
     */
    public static final String PERF_TABLE_TMP_PARAM = "PERF_TMP_PARAM";

    /**
     * 导入错误信息表
     */
    public static final String FW_TABLE_T_IMPORTRESULT = "FW_T_IMPORTRESULT";

    /**
     * 项目视图--终审
     */
    public static final String PMKPI_TABLE_PROJECT_INFO = "V_PERF_PROJECT_INFO";

    /**
     * 调整选择项目视图
     */
    public static final String PMKPI_TABLE_ADJUSTPROJECT_INFO = "V_PERF_ADJUSTPROJECT_INFO";

    /**
     * 自评包含一级项目视图
     */
    public static final String PMKPI_TABLE_PERFSELFPROJECT_INFO = "V_PERF_PERFSELFPROJECT_INFO";

    /**
     * 自评选择项目视图
     */
    public static final String PMKPI_TABLE_SELFPROJECT_CHECK = "V_PERF_SELFPROJECT_CHECK";

    /**
     * 自评选择项目视图(宁夏)
     */
    public static final String PMKPI_TABLE_SELFPROJECT_CHECK_NX = "V_PERF_SELFPROJECT_CHECK_NX";

    /**
     * 监控选择项目视图
     */
    public static final String PMKPI_TABLE_TRACEPROJECT_CHECK = "V_PERF_TRACEPROJECT_INFO";

    /**
     * 项目视图--有效
     */
    public static final String PMKPI_TABLE_ALLPROJECT_INFO = "V_PERF_ALLPROJECT_INFO";

    /**
     * 结转项目
     */
    public static final String PERF_TABLE_TRANSPROJECT = "v_perf_self_transproject";

    /**
     * 部门整体
     */
    public static final String PMKPI_TABLE_DEPTPERFDECLARE = "V_PERF_T_DEPTPERFDECLARE";

    /**
     * 一级项目
     */
    public static final String PERF_TABLE_SELFPARENTPROJECT_CHECK = "v_perf_selfparentproject_check";

    /**
     * 指标库
     */
    public static final String PMKPI_TABLE_BAS_PERF_INDICATOR = "V_BAS_PERF_INDICATOR";

    public static final String PMKPI_TMP_AUDITDEFINEWHERESQL = "PERF_TMP_AUDITDEFINEWHERESQL";

    /**
     * 绩效不分区不分年度枚举表
     */
    public static final String PMKPI_TABLE_PERF_DATASOURCE = "V_PERF_T_DATASOURCE";

    /**
     * 绩效分区不分年度枚举表
     */
    public static final String PMKPI_TABLE_PERF_ENUM = "V_PERF_ENUM";


    public String getSystemDepttree() {
        return PerfUtil.getSystemSet("dept_letftree");
    }

    public String getSystemAgencytree() {
        return PerfUtil.getSystemSet("agency_lefttree");
    }

    /**
     * 处室表
     */
    public static final String PMKPI_TABLE_PUBDEPARTMENT = "fasp_t_pubdepartment";

    /**
     * 组件权限缓存前缀
     */
    public static final String PMKPI_CACHE_COMPONETPOWER = "PMKPI_COMPONETPOWER_";

    /**
     * 校验页签是否必填缓存前缀
     */
    public static final String PMKPI_CACHE_UITABPAGEDATA = "PMKPI_UITABPAGECHEC_";

    /**
     * 导出报告（excel,doc）缓存前缀
     */
    public static final String PMKPI_CACHE_EXPEOC = "PMKPI_EXPDOC_";

    /**
     * 系统参数配置缓存前缀
     */
    public static final String PMKPI_CACHE_SYSTEM = "PMKPI_SYSTEM_";

    /**
     * 系统待办配置缓存前缀
     */
    public static final String PMKPI_CACHE_PENDINGTASK = "PMKPI_PENDINGTASK_";

    /**
     * 系统预警配置缓存前缀
     */
    public static final String PMKPI_CACHE_WARN = "PMKPI_WARN_";

    /**
     * 左侧树页签配置缓存前缀
     */
    public static final String PMKPI_CACHE_LEFTTAB = "PMKPI_LEFTTAB_";

    /**
     * 审核详情表
     */
    public static final String AUDITMAIN_TABLE = "perf_t_auditmain";

    /**
     * 获取左侧树数据.
     *
     * @return --
     */
    public List<Map<String, Object>> getLeftTree() {
        StringBuffer sql = new StringBuffer();
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(this.PMKPI_TABLE_TMP_AGENCY);
        }
        sql.append(" select distinct t.guid,t.code,t.name,t.superguid,t.superid,t.isleaf,t.levelno,t.agencyguid from ").append(PMKPI_TABLE_T_AGENCY);
        sql.append(" t start with exists (select 1 from ").append(this.PMKPI_TABLE_TMP_AGENCY).append(" c where t.guid = c.guid) ");
        sql.append(" connect by prior t.superguid = t.guid");
        sql.append(" order by code ");
        return this.queryForList(sql.toString());
    }

    /**
     * 获取左侧树数据.
     * @param datarule 数据权限
     * @return --
     */
    public List<Map<String, Object>> getLeftTree(String datarule) {
        StringBuffer sql = new StringBuffer();
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(this.PMKPI_TABLE_TMP_AGENCY);
        }
        if (StringUtil.isEmpty(datarule)) {
            datarule = "1<>1";
        }
        sql.append(" select distinct t.guid,t.code,t.name,t.superguid,t.superid,t.isleaf,t.levelno,t.agencyguid from ").append(PMKPI_TABLE_T_AGENCY);
        sql.append(" t start with ").append(datarule);
        sql.append(" connect by prior t.superguid = t.guid");
        sql.append(" order by code ");
        return this.queryForList(sql.toString());
    }

    /**
     * <p>获取左侧树数据-不走临时表</p >
     *
     * @param tablecode:数据表（必须有 agencyguid 字段）
     * @author hw
     * @date 2021/7/26 9:52
     */
    public List<Map<String, Object>> getLeftTree(String tablecode, String datarule) {
        StringBuffer bussql = new StringBuffer(" select distinct t.agencyguid from "); //业务sql
        bussql.append(tablecode).append(" t ");
        if (!StringUtil.isEmpty(datarule)) {
            bussql.append(" where ");
            bussql.append(datarule);
        }
        logger.info("---获取左侧树数据-不走临时表：" + bussql.toString());
        List tempagencys =  this.queryForList(bussql.toString());
        StringBuffer filter = new StringBuffer();
        int inNum = 1; //已拼装IN条件数量
        Map tempMap = new HashMap();
        for (int i = 0; i < tempagencys.size(); i++) {
            tempMap = (Map) tempagencys.get(i);
            if (i == (tempagencys.size() - 1)) {
                filter.append("'" + tempMap.get("agencyguid") + "'"); //SQL拼装，最后一条不加“,”。
            } else if (inNum == 1000 && i > 0) {
                filter.append("'" + tempMap.get("agencyguid") + "' ) or a.guid in ( ");
                inNum = 1;
            } else {
                filter.append("'" + tempMap.get("agencyguid") + "', ");
                inNum++;
            }
        }
        if (filter.length() > 0){
            StringBuffer sql = new StringBuffer();
            sql.append(" select distinct a.guid,a.code,a.name,a.superguid,a.superid,a.isleaf,a.levelno,a.agencyguid from ");
            sql.append(PMKPI_TABLE_T_AGENCY);
            sql.append(" a start with ");
            sql.append(" (a.guid in(" + filter.toString() + "))");
            sql.append(" connect by prior a.superguid = a.guid");
            sql.append(" order by code ");
            return this.queryForList(sql.toString());
        } else {
            return new ArrayList<>();
        }
    }

    /**
     * <p>获取左侧树数据-不走临时表</p >
     * @param tablecode:数据表
     * @param leftTablecode 左侧树表
     * @param col 业务表对应左侧树guid字段
     */
    public List<Map<String, Object>> getLeftTree(String tablecode, String datarule, String leftTablecode, String col) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct a.guid,a.code,a.name,a.superguid,a.superid,a.isleaf,a.levelno,a.agencyguid from ").append(leftTablecode);
        sql.append(" a start with a.guid in (select t."+col+" from ").append(tablecode).append(" t ");
        if (!StringUtil.isEmpty(datarule)) {
            sql.append(" where ");
            sql.append(datarule);
        }
        sql.append(" ) ");
        sql.append(" connect by prior a.superguid = a.guid");
        sql.append(" order by code ");
        logger.info("---获取左侧树数据-不走临时表：" + sql.toString());
        return this.queryForList(sql.toString());
    }

    /**
     * <p>获取左侧树数据-下级财政区划</p >
     *
     * @param tablecode:数据表（必须有 subprovince 字段）
     * @author hw
     * @date 2021/7/26 9:52
     */
    public List<Map<String, Object>> getLeftTreeProvince(String tablecode, String datarule, String columncode) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select distinct a.* from ").append("V_ELE_VD08001");
        sql.append(" a start with exists (select 1 from ").append(tablecode).append(" t where ");
        if (!StringUtil.isEmpty(datarule)) {
            sql.append(datarule).append(" and a.guid = t.").append(columncode).append(") ");
        }
        else {
            sql.append("  a.guid = t.").append(columncode).append(") ");
        }
        sql.append(" connect by prior a.superguid = a.guid");
        sql.append(" order by code ");
        logger.info("---获取左侧树数据-不走临时表：" + sql.toString());
        return this.queryForList(sql.toString());
    }

    /**
     * 查询数据个数.
     *
     * @param tablecode --表名
     * @param wheresql  --查询条件
     * @return --
     */
    public int getDataCount(String tablecode, String wheresql) {
        String sql = "select count(1) from " + tablecode + " t ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " where " + wheresql;
        }
        logger.info("查询数据个数sql----------" + sql);
        return this.queryForInt(sql);
    }

    /**
     * 查询数据个数.
     *
     * @param tablecode --表名
     * @param wheresql  --查询条件
     * @return --
     */
    public int getDataCount(String tablecode, String wheresql, String[] strs) {
        String sql = "select count(1) from " + tablecode + " t ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " where " + wheresql;
        }
        logger.info("查询数据个数sql----------" + sql);
        return this.queryForInt(sql, strs);
    }

    /**
     * 查询数据.
     *
     * @param tablecode --表名
     * @param wheresql  --查询条件
     * @param orderby   --排序
     * @return --
     */
    public List<Map<String, Object>> getDatas(String tablecode, String wheresql, String orderby) {
        String sql = "select t.* from " + tablecode + " t ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " where (" + wheresql + ")";
        }
        if (orderby != null && !orderby.isEmpty()) {
            sql += " " + orderby;
        }
        logger.info("查询sql输出----------" + sql);
        return this.queryForList(sql);
    }

    /**
     * 查询数据.
     * @param tablecode --表名
     * @param wheresql  --查询条件
     * @return --
     */
    public Map<String, Object> getDataMap(String tablecode, String wheresql) {
        String sql = "select t.* from " + tablecode + " t ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " where " + wheresql;
        }
        logger.info("查询sql输出----------" + sql);
        List list = (List) PerfUtil.lowMapKey(this.queryForList(sql));
        if (list.size() > 0) {
            return (Map<String, Object>) list.get(0);
        } else {
            return new HashMap<>();
        }
    }

    /**
     * 查询数据.
     * @param tablecode --表名
     * @param wheresql  --查询条件
     * @return --
     */
    public Map<String, Object> getDataMap(String tablecode, String wheresql, String[] str) {
        String sql = "select t.* from " + tablecode + " t ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " where " + wheresql;
        }
        logger.info("查询sql输出----------" + sql);
        List list = (List) PerfUtil.lowMapKey(this.queryForList(sql, str));
        if (list.size() > 0) {
            return (Map<String, Object>) list.get(0);
        } else {
            return new HashMap<>();
        }
    }

    /**
     * 查询数据.
     *
     * @param tablecode --表名
     * @param wheresql  --查询条件
     * @param str       --参数值集合
     * @return --
     */
    public List<Map<String, Object>> getDatas(String tablecode, String wheresql, String orderby, String[] str) {
        String sql = "select * from " + tablecode + " t ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " where " + wheresql;
        }
        if (orderby != null && !orderby.isEmpty()) {
            sql += " " + orderby;
        }
        logger.info("查询sql输出----------" + sql);
        return PerfUtil.lowMapKey(this.queryForList(sql, str));
    }

    /**
     * 删除数据.
     *
     * @param tablecode --表名
     * @param wheresql  --条件
     * @return --
     */
    public void delDatas(String tablecode, String wheresql) {
        String sql = "delete from " + tablecode + " t ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " where " + wheresql;
        }
        logger.info("删除sql----------" + sql);
        this.execute(sql);
    }

    /**
     * 删除数据.
     * @param tablecode --表名
     * @param wheresql  --条件
     * @return --
     */
    public void updateDatas(String tablecode, String wheresql) {
        String sql = "update " + tablecode + " t ";
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += wheresql;
        }
        logger.info("修改sql----------" + sql);
        this.execute(sql);
    }

    /**
     * 逻辑删除数据.
     * @param tablecode --表名
     * @param wheresql  --条件
     * @return --
     */
    public void updateIsDeleteDatas(String tablecode, String wheresql) throws AppException {
        String sql = "update " + tablecode + " t set t.is_deleted = 1";
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        String time = PerfUtil.getServerTimeStamp();
        DicTableDTO dicTableDTO = dicQueryService.getDicTable(tablecode.toLowerCase());
        int i = 0;
        if (dicTableDTO != null) {
            List coll = (List) dicTableDTO.getListCol();
            for (Object obj : coll) {
                Map map = (Map) obj;
                if ("UPDATE_TIME".equals(map.get("columncode"))) {
                    sql += " , t.update_time=?";
                    i++;
                }
                if ("UPDATETIME".equals(map.get("columncode"))) {
                    sql += " , t.updatetime=?";
                    i++;
                }
            }
        }
        String[] str = new String[i];
        for (int j = 0; j < i; j++) {
            str[j] = time;
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " where " + wheresql;
        }
        logger.info("修改sql----------" + sql);
        this.update(sql, str);
    }

    /**
     * 获取agency数据
     *
     * @return
     */
    public List<Map<String, Object>> getAgencyData(String agency) {
        StringBuffer sql = new StringBuffer();
        sql.append(" select  t.* from pmkpi_fasp_t_pubagency ");
        sql.append(" t where t.guid = '" + agency + "'");
        sql.append(" and t.year='" + CommonUtil.getYear() + "'");
        return this.queryForList(sql.toString());
    }

    /**
     * 获取配置字段
     *
     * @param tablecode --业务表
     * @return
     */
    public List<Map<String, Object>> getCol(String tablecode) {
        IDicTableQueryService iDicTableQueryService = PerfServiceFactory.getIDicTableQueryService();
        try {
            List colList = iDicTableQueryService.getDicColumnByTablecode(tablecode.toUpperCase());
            for (Object obj : colList) {
                DicColumnDTO dicColumnDTO = (DicColumnDTO) obj;
                dicColumnDTO.put("columncode", dicColumnDTO.getColumncode().toLowerCase());
            }
            return colList;
        } catch (AppException e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    /**
     * 获取表字段,审核状态进行特殊处理
     * @param tablecode --业务表
     * @return
     */
    public String getColumncodes(String tablecode, String alias) {
        if ("_HB".equals(tablecode.substring(tablecode.length() - 3, tablecode.length()))) {
            tablecode = tablecode.substring(0, tablecode.length() - 3);
        }
        IDicTableQueryService iDicTableQueryService = PerfServiceFactory.getIDicTableQueryService();
        try {
            List<DicColumnDTO> colList = iDicTableQueryService.getDicColumnByTablecode(tablecode.toUpperCase());
            StringBuffer str = new StringBuffer();
            for (DicColumnDTO dicColumnDTO : colList) {
                if (!dicColumnDTO.getColumncode().toLowerCase().equals("wfstatus")) {
                    if (!StringUtil.isEmpty(alias)) {
                        str.append(alias).append(".");
                    }
                    str.append(dicColumnDTO.getColumncode().toLowerCase()).append(",");
                }
            }
            if (str.length() > 0) {
                str.deleteCharAt(str.length() - 1);
            }
            return str.toString();
        } catch (AppException e) {
            e.printStackTrace();
        }
        return "";
    }


    /**
     * 查询节点审核类型
     *
     * @param workflow     工作流
     * @param prevwfstatus --当前数据状态
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> queryPrevAuditType(String workflow, String prevwfstatus) throws AppException {
        Map<String, Object> map = this.getHandoverCurrentUserRoles();
        String users = (String) map.get("users");
        String sql = "select nvl(a.audittype,'opinion') as audittype,t.stepid as nodeguid from busfw_t_dcworkflowbranch t left join v_perf_t_audittypecfg a on t.wfid=a.wfid and t.stepid=a.nodeguid where t.wfid=?" +
                "and t.prevwfstatus=? and t.action='audit' and t.roleid in(select roleguid from fasp_t_causerrole c where c.userguid in ("+users+"))";
        return PerfUtil.lowMapKey(this.queryForList(sql, new String[]{workflow, prevwfstatus}));
    }

    /**
     * 查询当前数据状态的结果状态
     *
     * @param workflow     工作流
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> queryWfstatusType(String workflow) throws AppException {
        Map<String, Object> map = this.getHandoverCurrentUserRoles();
        List<String> roles = (List<String>) map.get("rolelist");
        String roleguids = this.createInSql("roleid", roles);
        String sql = "select t.prevwfstatus from busfw_t_dcworkflowbranch t where t.wfid= '" +workflow+
                "' and t.wfstatus='011' and t.action='audit' and " + roleguids;
        logger.debug("===================审核状态查询sql：============"+sql);
        List<Map<String, Object>> returndate = this.queryForList(sql);
        return returndate;
    }

    protected HashMap<String, Object> getHashMapByReS(ResultSet rs) {
        HashMap result = new HashMap();

        try {
            ResultSetMetaData rsmd = rs.getMetaData();
            int cols = rsmd.getColumnCount();
            String sColumName = null;

            for(int i = 1; i <= cols; ++i) {
                sColumName = rsmd.getColumnName(i).toLowerCase();
                Object value = rs.getString(sColumName);
                result.put(sColumName, value);
            }
        } catch (SQLException var8) {
            logger.error(var8.getMessage());
        }

        return result;
    }

    /**
     * 创建临时表.
     *
     * @param tablecode --表名
     * @return --
     */
    public void createTmpTable(String tablecode) {
        String countSql = "";
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            if("polardb".equalsIgnoreCase(DbTypeUtil.getPhysicsDbType())){
                countSql = "select * from pg_class t where t.relname = '" + tablecode.toLowerCase() + "'";
            }else {
                countSql = "select * from user_tables t where t.TABLE_NAME = '" + tablecode + "'";
            }
        } else {
            countSql = "select * from user_tables t where t.TABLE_NAME = '" + tablecode + "'";
        }

        List list = this.queryForList(countSql);
        logger.info("------"+tablecode+"-------------"+list.size()+"----");

        if(null == list || list.size() ==0 ){
            String sql = "";
            if("polardb".equalsIgnoreCase(DbTypeUtil.getPhysicsDbType())){
                sql = "create GLOBAL TEMPORARY table " + tablecode + " ( guid VARCHAR2(40),province VARCHAR2(2000),busguid VARCHAR2(40),remark VARCHAR2(500),key   VARCHAR2(100),value VARCHAR2(500)) on commit delete rows";
            } else {
                sql = "create temp table " + tablecode + " ( guid VARCHAR2(40),province VARCHAR2(2000),busguid VARCHAR2(40),remark VARCHAR2(500),key   VARCHAR2(100),value VARCHAR2(500)) on commit delete rows";
            }
            this.execute(sql);
        }
    }

    /**
     * 创建表.
     *   创建表 与A表结构一样
     * @param newTable --新建表的表名
     * @param oldTable --依据的表名
     * @return --
     */
    public void createTable(String newTable,String oldTable) {
        String countSql = "";
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            if("polardb".equalsIgnoreCase(DbTypeUtil.getPhysicsDbType())){
                countSql = "select * from pg_class t where t.relname = '" + newTable.toLowerCase() + "'";
            }else {
                countSql = "select * from all_tables t where t.TABLE_NAME = '" + newTable + "'";
            }
        } else {
            countSql = "select * from all_tables t where t.TABLE_NAME = '" + newTable + "'";
        }
        List list = this.queryForList(countSql);
        logger.info("------"+newTable+"-------------"+list.size()+"----");

        if(null == list || list.size() ==0 ){
            String createsql = "create table "+ newTable +" as select * from "+oldTable+" where 1=2";
            logger.debug("建表语句："+createsql);
            this.execute(createsql);
        }
    }

    /**
     * 根据guid查询数据
     * @param guid
     * @return
     */
    public List getByGuid(String tablecode, String guid){
        String wheresql = " guid=? ";
        return this.getDatas(tablecode, wheresql, null, new String[]{guid});
    }

    /**
     * 根据guid查询数据
     * @param guid
     * @return
     */
    public List getByGuid(String tablecode, String guid, String procode, String bustype){
        StringBuffer sql = new StringBuffer();
        if (PerfUtil.getIsHbei() || "dept".equals(bustype) || "depttrace".equals(bustype)) {
            sql.append(" guid = '").append(guid).append("'");
        } else {
            sql.append(" pro_code = '").append(procode).append("'");
        }
        return this.getDatas(tablecode, sql.toString(), null);
    }

    /**
     * 根据guid查询数据
     * @param guid -- mainguid/guid.
     * @param  -- 页面类型.
     * @return
     */
    public List getByGuid(String tablecode, String guid, String iswf){
        StringBuffer sql = new StringBuffer();
        if (iswf != null && "true".equals(iswf)) {
            sql.append(" guid = '");
        } else {
            sql.append(" mainguid = '");
        }
        sql.append(guid).append("'");
        return this.getDatas(tablecode, sql.toString(), null);
    }

    /**
     * 三级指标编码赋值
     * @return
     */
    public List<Map<String, Object>> setIndexCode(List<Map<String, Object>> indexdata) throws AppException {
        if (indexdata == null || indexdata.size() == 0) {
            return indexdata;
        }
        //指标编码中间表
        String tablecode = "v_perf_index_code";
        List<Map<String, Object>> datalist = null;
        String sql = "select * from " + tablecode + " a /*where exists(select 1 from v_perf_t_frame t where t.levelno=2 and a.findex=t.superid and a.sindex=t.guid)*/ order by a.findex,a.sindex";
        datalist = this.queryForList(sql);
        int indexcodenum = 4;
        String indexcodes = PerfUtil.getSystemSet("indexcoderule");//指标编码规则
        if (indexcodes != null && !indexcodes.isEmpty()) {
            indexcodenum = Integer.parseInt(indexcodes.split("-")[2]);
        }
        if (datalist != null && datalist.size() > 0) {
            datalist = PerfUtil.lowMapKey(datalist);
        } else {
            int finalIndexcodenum = indexcodenum;
            datalist = (List<Map<String, Object>>) this.getJdbcTemplate().execute(new ConnectionCallback() {
                public Object doInConnection(Connection conn) throws SQLException {
                    String sql = "{ call pkg_perf_refreshindex.setIndexCode(?,?)}";
                    List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
                    CallableStatement cstmt = null;
                    ResultSet rs = null;
                    try {
                        cstmt = conn.prepareCall(sql);
                        cstmt.setInt(1, finalIndexcodenum);
                        cstmt.registerOutParameter(2, OracleTypes.CURSOR);
                        cstmt.execute();
                        rs = (ResultSet) cstmt.getObject(2);
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
        for (Map<String, Object> map : datalist) {
            map.put("oldupdatetime", map.get("updatetime"));
            map.put("updatetime", "");
        }
        List<Map<String, Object>> list = new ArrayList<>();
        //加锁
        this.lockAndCheckUpdatetime(datalist, tablecode);
        //外层循环三级指标数据，内层循环给三级指标赋值，同时对三级指标进行更新处理
        for (Map<String, Object> map : indexdata) {
            String findex = (String) map.get("findex");
            String sindex = (String) map.get("sindex");
            String code = (String) map.get("code");
            //不存在指标编码
            if (StringUtil.isEmpty(code)) {
                for (Map<String, Object> m : datalist) {
                    String f = (String) m.get("findex");
                    String s = (String) m.get("sindex");
                    String tindex = m.get("tindex") == null ? "" : String.valueOf(m.get("tindex"));
                    if (findex != null && f != null && f.equals(findex) && sindex != null && s != null && s.equals(sindex)) {
                        //能够获取最大指标值
                        if (!StringUtil.isEmpty(tindex) && !"null".equals(tindex)) {
                            tindex = tindex.substring(sindex.length(), tindex.length());
                            long tcode = Long.parseLong(tindex) + 1;
                            String l = "%0" + indexcodenum + "d";
                            String t = sindex + String.format(l, tcode);
                            map.put("code", t);
                            map.put("lv3_perf_ind_code", t);
                            map.put("perf_ind_code", t);
                            m.put("tindex", t);
                            m.put("updatetime", PerfUtil.getServerTimeStamp());
                            list.add(m);
                        }
                        break;
                    }
                }
            } else {
                map.put("perf_ind_code", code);
                map.put("lv3_perf_ind_code", code);
            }
        }
        List<String> colList = new ArrayList<>();
        colList.add("tindex");
        colList.add("updatetime");
        this.updateAll(colList, list, tablecode);
        return indexdata;
    }

    public void lockAndCheckUpdatetime(List updatelist, String tablecode) throws AppException {
        List<String> cols = new ArrayList();
        cols.add("guid");
        cols.add("oldupdatetime");
        cols.add("updatetime");
        this.saveAll (cols, updatelist, "perf_tmp_checkupdatetime");
        logger.info(this.queryForList("select * from perf_tmp_checkupdatetime").toString());
        int num = this.queryForInt("select count(1) from perf_tmp_checkupdatetime where oldupdatetime is null or oldupdatetime=updatetime");
        if (num > 0) {
            throw new AppException("0", "异常：并发校验oldupdatetime不能为空并且不能等于updatetime！");
        } else {
            StringBuilder s = new StringBuilder();
            s.append("   select ''  ");
            s.append("   from ").append(tablecode).append(" t  ");
            s.append("  where exists (select 1  ");
            s.append("           from perf_tmp_checkupdatetime a  ");
            s.append("         where t.guid = a.guid  ");
            s.append("           and t.updatetime = a.oldupdatetime)  for update nowait");
            logger.info("并发sql+++++++++++" + s.toString());
            List l = this.queryForList(s.toString());
            if (l.size() != updatelist.size()) {
                throw new AppException("0", "并发异常：请刷新页面后再试！");
            }
        }
    }

    /**
     * 复制数据
     * @param tablecode
     * @param wheresql
     */
    public void copyDatas(String tablecode, String wheresql, String columncode, String mainguid) throws AppException {
        String sql = "select * from " + tablecode ;
        if (!StringUtil.isEmpty(wheresql)) {
            sql += " where " + wheresql;
        }
        logger.info("复制数据查询数据sql++++++++++++++++++" + sql);
        List<Map<String, Object>> datas = this.queryForList(sql);
        for (Map<String, Object> map : datas) {
            String guid = StringUtil.createUUID();
            for (String key: map.keySet()){
                if ("guid".equals(key) || (columncode != null && columncode.equals(key))) {
                    map.put(key, guid);
                }
                if ("mainguid".equals(key)) {
                    map.put(key, mainguid);
                }
            }
        }
        this.saveAll(datas, tablecode);
    }

    /**
     * 校验字段是否可为空
     * @return
     */
    public Map<String, Object> checkTacleColsIsNull(String tablecode, List<Map<String, Object>> list) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //查询不可为空表字段
        StringBuffer sql = new StringBuffer();
        //缓存中获取表字段u
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        List<DicColumnDTO> colsList = dicQueryService.getDicColumnByTablecode(tablecode.toUpperCase());
        if (colsList.size() <= 0) {
            sql.append("select a.columncode from user_tab_columns t left join fasp_t_diccolumn a on a.tablecode=t.table_name and t.column_name=a.columncode where");
            sql.append(" t.table_name='").append(tablecode.toUpperCase()).append("' and t.nullable='N'");
            colsList = this.queryForList(sql.toString());
        }else {
            HashMap maps;
            List listdata = new ArrayList();
            for (DicColumnDTO diccolumns : colsList) {
                String nullable = diccolumns.getNullable()+ "";
                if (!"1".equals(nullable)) {
                    maps = new HashMap();
                    maps.put("columncode",diccolumns.getColumncode());
                    maps.put("name",diccolumns.getName());
                    listdata.add(maps);
                }
            }
            colsList = listdata;
        }
        if (colsList != null && colsList.size() > 0 && list != null && list.size() > 0) {
            List<Map<String, Object>> errdata = new ArrayList<>();
            Map<String, Object> errMap = null;
            for (Map<String, Object> colMap : colsList) {
                String columncode = (String) colMap.get("columncode");
                String name = (String) colMap.get("name");
                for (Map<String, Object> dataMap : list) {
                    String vaule = dataMap.get(columncode.toLowerCase()) + "";
                    if (StringUtil.isEmpty(vaule) || "null".equals(vaule)) {
                        errMap = new HashMap<String, Object>();
                        errMap.put("remark",  "字段：【" + name +" "+ columncode + "】不能为空");
                        errMap.put("code", "001");
                        errMap.put("name", "校验字段值不能为空");
                        errMap.put("explain", "校验字段值不能为空");
                        errdata.add(errMap);
                        backMap.put("success", false);
                        backMap.put("redata", errdata);
                        return backMap;
                    }
                }
            }
        }
        return backMap;
    }

    /**
     * 查询工作流流程配置config
     * @param workflow 工作流id
     * @param wfstatus 前状态
     * @param action 动作
     * @return
     */
    public List<Map<String, Object>> getWfBranchConfig(String workflow, String wfstatus, String action){
        String tion = "";
        if ("cancelsendaudit".equals(action) || "cancelaudit".equals(action)){
            tion = "back";
        }
        if ("create".equals(action) || "sendaudit".equals(action) || "audit".equals(action)) {
            tion = "audit";
        }
        String sql = "select * from Busfw_t_Dcworkflowbranch t where t.wfid='"
                + workflow + "' and t.prevwfstatus = '" + wfstatus + "' and t.action = '" + tion
                + "' and t.config is not null" ;
        return this.queryForList(sql);
    }

    /**
     * 查询省级指标，市级指标sql
     * @param province
     * @param sxflag
     * @return
     */
    public String getsxsql(String province,String sxflag){
        StringBuffer sxsql = new StringBuffer("");
        String isSx = PerfUtil.getSystemSet("isSX");
        if (!StringUtil.isEmpty(isSx) && "1".equals(isSx)) {//山西环境
            String tprovince = province.substring(0,2)+"0000000";//省级区划
            String sprovince = province.substring(0,4)+"00000";//市级区划
            String level_no = "";
            if(province.indexOf("0000000") != -1){
                level_no = "1";
            }else if(province.indexOf("00000") != -1){
                level_no = "2";
            }else{
                level_no = "3";
            }
            if (StringUtils.isNotBlank(sxflag)){
                if ("province".equals(sxflag)){//省级指标
                    if ("1".equals(level_no)){//省级查看省级
                        sxsql.append(" and province = '"+province+"'");
                    }else{//市县查看省级
                        sxsql.append(" and province = '"+tprovince+"'");
                    }
                }else if("city".equals(sxflag)){//市级指标
                    if ("1".equals(level_no)){//省级查看市级
                        sxsql.append(" and 1<>1");
                    }else if("2".equals(level_no)){//市级查看市级
                        sxsql.append(" and province = '"+province+"'");
                    }else if("3".equals(level_no) || "4".equals(level_no)){//区县查看市级
                        sxsql.append(" and province = '"+sprovince+"'");
                    }
                }else if("county".equals(sxflag)){//县级指标
                    if ("1".equals(level_no)){//省级查看县级
                        sxsql.append(" and 1<>1");
                    }else if("2".equals(level_no)){//市级查看县级
                        sxsql.append(" and 1<>1");
                    }else if("3".equals(level_no) || "4".equals(level_no)){//区县查看县级
                        sxsql.append(" and province = '"+province+"'");
                    }
                }else{
                    sxsql.append(" and province = '"+province+"'");
                }
            }else{
                sxsql.append(" and province = '"+province+"'");
            }
        }
        return sxsql.toString();
    }

    /**
     * 批量删除，根据表的某个字段删除。
     * @param columnname -- 表字段
     * @param guid --- 字段值集集合
     * @param tabcode -- 注册表
     * @return
     * @throws AppException
     */
    public int deleteAllByColumn(String columnname, Collection<String> guid, String tabcode) throws AppException {
        if (tabcode == null) {
            throw new AppException(DaoAppException.C11000200, DaoAppException.M11000200);
        }
        String tablename = this.getTableName(tabcode);
        if (guid == null || guid.size() == 0) {
            throw new AppException(DaoAppException.C11000201, DaoAppException.M11000201);
        }
        StringBuilder vchsql = new StringBuilder(guid.size() * 32 + 100);
        vchsql.append("update ").append(tablename).append(" t set is_deleted=1");
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        String time = PerfUtil.getServerTimeStamp();
        DicTableDTO dicTableDTO = dicQueryService.getDicTable(tabcode.toLowerCase());
        List coll = (List) dicTableDTO.getListCol();
        int i = 0;
        for (Object obj : coll) {
            Map map = (Map) obj;
            if ("UPDATE_TIME".equals(map.get("columncode"))) {
                vchsql.append(", t.update_time=?");
                i++;
            }
            if ("UPDATETIME".equals(map.get("columncode"))) {
                vchsql.append(", t.updatetime=?");
                i++;
            }
        }
        String[] str = new String[i];
        for (int j = 0; j < i; j++) {
            str[j] = time;
        }
        vchsql.append(" where ").append(this.createInSql(columnname, guid));
        return super.update(vchsql.toString(), str);
    }

    /**
     * 批量处理数据，根据表的某个字段删除。
     * @param columnname -- 表字段
     * @param guid --- 字段值集集合
     * @param tabcode -- 注册表
     * @param upsql --修改字段
     * @param wheresql --条件语句
     * @return
     * @throws AppException
     */
    public int updateAllByColumn(String columnname, Collection<String> guid, String tabcode, String upsql, String wheresql) throws AppException {
        if (tabcode == null) {
            throw new AppException(DaoAppException.C11000200, DaoAppException.M11000200);
        }
        String tablename = this.getTableName(tabcode);
        StringBuilder vchsql = new StringBuilder();
        vchsql.append("update ").append(tablename).append(" t set ");
        vchsql.append(upsql);
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        String time = PerfUtil.getServerTimeStamp();
        DicTableDTO dicTableDTO = dicQueryService.getDicTable(tabcode.toLowerCase());
        List coll = (List) dicTableDTO.getListCol();
        int i = 0;
        for (Object obj : coll) {
            Map map = (Map) obj;
            if ("UPDATE_TIME".equals(map.get("columncode"))) {
                vchsql.append(", t.update_time=?");
                i++;
            }
            if ("UPDATETIME".equals(map.get("columncode"))) {
                vchsql.append(", t.updatetime=?");
                i++;
            }
        }
        String[] str = new String[i];
        for (int j = 0; j < i; j++) {
            str[j] = time;
        }
        StringBuffer wsql = new StringBuffer();
        if (!StringUtil.isEmpty(columnname) && guid != null && guid.size() > 0) {
            wsql.append(this.createInSql(columnname, guid)).append(" and ");
        }
        if (!StringUtil.isEmpty(wheresql)) {
            wsql.append(wheresql).append(" and ");
        }
        if (!StringUtil.isEmpty(wsql.toString())) {
            vchsql.append(" where ").append(wsql.delete(wsql.length() - 4, wsql.length()));
        }
        logger.info("修改sql++++++++" + vchsql.toString());
        return super.update(vchsql.toString(), str);
    }

    /**
     * <p>查询当前key的非必填校验页签</p >
     *
     * @author hw
     * @date 2022/7/7 9:58
     * @param
     */
    public List<Map<String, Object>> getCheckTabs(String uikey) throws AppException {
        if (StringUtils.isEmpty(uikey)) {
            return null;
        }
        String cacheKey = this.PMKPI_CACHE_UITABPAGEDATA + uikey;
        String cacheData = PerfUtil.getCacheJSONData(cacheKey);
        List<Map<String, Object>> datas;
        if (!StringUtil.isEmpty(cacheData)) {
            datas = PerfUtil.parseString2List(cacheData);
        } else {
            String getCheckTabSql = "select t.* from v_perf_t_uitabpage_chec t where t.key = ? and (t.ischecktab = 2 or (t.ischecktab = 1 and t.checktable = 'v_perf_file' ))";
            datas = PerfUtil.lowMapKey(this.queryForList(getCheckTabSql, new String[]{uikey}));
            PerfUtil.reflashCacheJSONData(cacheKey, PerfUtil.parse2Json(datas), false);
        }
        return datas;
    }

    /**
     * 基础规范字段赋值
     * @param map
     * @return
     */
    public Map<String, Object> getBasMap(Map<String, Object> map, String type) throws AppException {
        if (map != null) {
            String queryYear = (String) map.get("queryYear");
            String queryProvince = (String) map.get("queryProvince");
            if (!StringUtil.isNullOrEmpty(queryYear) && !StringUtil.isNullOrEmpty(queryProvince)) {
                this.setYearAndProvince(queryYear, queryProvince);
            }
            String agencyguid = (String) map.get("agencyguid");
            if (!StringUtil.isEmpty(agencyguid) && agencyguid.length() >= 3) {
                String dept_code = agencyguid.length() == 3 ? agencyguid : agencyguid.substring(0, agencyguid.length() - 3);
                map.put("dept_code", dept_code);
                String elementcode = "PMKPIAGENCYALLPAY";
                String dept_name = (String) map.get("dept_name");
                String agency_name = (String) map.get("agency_name");
                if (StringUtil.isEmpty(dept_name) || StringUtil.isEmpty(agency_name)) {
                    String wheresql = "guid in ('" + dept_code + "', '" + agencyguid + "')";
                    List<DicRangeDTO> eledatas = PerfUtil.getSourceData(elementcode, wheresql);
                    if (eledatas != null && eledatas.size() > 0) {
                        for (DicRangeDTO dicRangeDTO : eledatas) {
                            String code = dicRangeDTO.getCode();
                            if (code.equals(dept_code)) {
                                map.put("dept_name", dicRangeDTO.getName());
                            }
                            if (code.equals(agencyguid)) {
                                map.put("agency_name", dicRangeDTO.getName());
                            }
                        }
                    }
                }
            }
            map.put("kpi_per_id", map.get("guid"));//项目目标主键
            //河北、天津部门整体指标中该字段用于存储目标guid，不为空不重新赋值
            if (PerfUtil.getIsHbei() || PerfUtil.getIsTianJin() || PerfUtil.getIS_HUBEI()) {
                if (StringUtil.isEmpty((String) map.get("kpi_dep_id"))) {
                    map.put("kpi_dep_id", map.get("guid"));//部门整体目标主键
                }
            } else {
                map.put("kpi_dep_id", map.get("guid"));//部门整体目标主键
            }
            map.put("kpi_id", map.get("guid"));//指标主键
            map.put("ind_id", map.get("guid"));//指标库指标主键
            map.put("is_deleted", 2);
            map.put("is_enabled", 1);
            map.put("mof_div_code", StringUtil.isNullOrEmpty(queryProvince) ? SecureUtil.getUserSelectProvince() : queryProvince);
            if (StringUtil.isNullOrEmpty(map.get("mof_div_name"))) {
                map.put("mof_div_name", CommonUtil.getProvinceNameByCode((String) map.get("mof_div_code")));
            }
            map.put("start_date", PerfUtil.getServerTimeStamp("yyyyMMdd"));
            map.put("end_date", "20991230");
            map.put("year", StringUtil.isNullOrEmpty(queryYear) ? SecureUtil.getUserSelectYear() : queryYear);
            map.put("fiscal_year", StringUtil.isNullOrEmpty(queryYear) ? SecureUtil.getUserSelectYear() : queryYear);
            map.put("province", StringUtil.isNullOrEmpty(queryProvince) ? SecureUtil.getUserSelectProvince() : queryProvince);
            map.put("agency_code", map.get("agencyguid"));
            map.put("kpi_per_id", map.get("guid"));
            if (map.get("kpi_evalstd") == null) {
                map.put("kpi_evalstd", 1); //评扣分标准
            }
            if (map.get("kpi_content") == null) {
                map.put("kpi_content", map.get("name")); //指标内容
            }
            if (type != null && "add".equals(type)) {
                map.put("create_time", PerfUtil.getServerTimeStamp());
                map.put("createtime", PerfUtil.getServerTimeStamp());
            }
            String yearflag = map.get("yearflag") + ""; //修改年度的获取类型
            if ("1".equals(yearflag)) {
                map.put("perf_obj_type_code", PerfConstant.PMKPI_ONE);
                map.put("perf_obj_type_name", PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME);
            } else {
                map.put("perf_obj_type_code", PerfConstant.PMKPI_TOW);
                map.put("perf_obj_type_name", PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME_YEAR);
            }
            map.put("update_time", PerfUtil.getServerTimeStamp());
            map.put("updatetime", PerfUtil.getServerTimeStamp());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            if (StringUtil.isEmpty((String) map.get("version"))) {
                map.put("version", PerfConstant.PMKPI_VERSION_RCDTWH);
            } else {
                Pattern pattern = Pattern.compile("[0-9]*");
                if (pattern.matcher((CharSequence) map.get("version")).matches()){
                    map.put("version", PerfConstant.PMKPI_VERSION_RCDTWH);
                }
            }
            if (StringUtil.isEmpty((String) map.get("version_name"))) {
                map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_RCDTWH);
            }
            if ("null".equals(map.get("versiontype") + "")) {
                map.put("versiontype", 0);
            }
            if ("null".equals(map.get("is_backup") + "")) {
                map.put("is_backup", 2);
            }
            if (StringUtil.isNullOrEmpty(map.get("is_last_inst") + "")) {
                map.put("is_last_inst", 2);
            }
        }
        return map;
    }

    /**
     * 查询节点审核类型
     * @param workflow 工作流
     * @param prevwfstatus --当前数据状态
     */
    @SuppressWarnings("unchecked")
    public List<Map<String, Object>> queryAuditType(String workflow , String prevwfstatus) throws AppException {
        Map<String, Object> map = this.getHandoverCurrentUserRoles();
        String users = (String) map.get("users");
        String sql = "select nvl(a.audittype,'opinion') as audittype,t.stepid as nodeguid from busfw_t_dcworkflowbranch t left join v_perf_t_audittypecfg a on t.wfid=a.wfid and t.stepid=a.nodeguid where t.wfid=?" +
                "and t.wfstatus=? and t.action='audit' and t.roleid in(select roleguid from fasp_t_causerrole c where c.userguid in("+users+"))";
        return PerfUtil.lowMapKey(this.queryForList(sql, new String[]{workflow, prevwfstatus}));
    }

    /**
     * 获取层次分类数据
     * @param type --
     * @return
     */
    public List<Map<String, Object>> getFrameDatas(String type) {
        StringBuffer sql = new StringBuffer("select guid,t.code,t.name from " + PMKPI_TABLE_T_FRAME + " t  where frametype=? order by ordernum");
        return PerfUtil.lowMapKey(queryForList(sql.toString(), new String[]{type}));
    }

    /**
     * 处理一二三级指标数据
     * @param indexList
     * @param frametype
     * @param isSelfTemp--是否自评固话指标
     */
    public void setIndexDatas(List<Map<String, Object>> indexList, String frametype, boolean isSelfTemp) {
        //查询层次分类
        List<Map<String, Object>> tempdatas = this.getFrameDatas(frametype);
        Map<Object, Object> tempMap = tempdatas.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
        if (isSelfTemp) {
            List<Map<String, Object>> selfTemp = this.getDatas("v_perf_t_selfframe", " frametype = '" + frametype + "'", null);
            Map<Object, Object> selfTempMap = selfTemp.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
            tempMap.putAll(selfTempMap);
        }
        for (Map<String, Object> indexMap : indexList) {
            String findex = (String) indexMap.get("findex");
            String sindex = (String) indexMap.get("sindex");
            //数据二级指标名称
            String lv2_perf_ind_name = (String) indexMap.get("lv2_perf_ind_name");
            //层次分类二级指标名称
            String frameSindexName = (String) tempMap.get(sindex);
            indexMap.put("lv1_perf_ind_code", findex);
            indexMap.put("lv2_perf_ind_code", sindex);
            indexMap.put("lv1_perf_ind_name", tempMap.get(findex));
            if (StringUtil.isNullOrEmpty(lv2_perf_ind_name) || (!StringUtil.isEmpty(frameSindexName) && !frameSindexName.equals(lv2_perf_ind_name))) {
                indexMap.put("lv2_perf_ind_name", StringUtil.isEmpty(frameSindexName) ? indexMap.get("name") : frameSindexName);
            }
            if (isSelfTemp && indexMap.get("code") == null) {//自评固化指标无code
                indexMap.put("lv3_perf_ind_code", "1");
            } else {
                indexMap.put("lv3_perf_ind_code", indexMap.get("code"));
            }
            indexMap.put("lv3_perf_ind_name", indexMap.get("name"));
        }
    }

    /**
     * 设置查询数据年度、区划
     * @param year
     * @param province
     */
    public void setYearAndProvince(String year, String province) {
        if (!StringUtil.isNullOrEmpty(year) && !StringUtil.isNullOrEmpty(province)) {
            String sql = "select global_multyear_cz.Secu_f_Global_Setparm(?,?,?,?) from dual";
            logger.info(sql+";【设置查询数据的年度{}区划{}】",year,province);
            this.queryForMap(sql, new String[]{"", province, year, ""});
        }
    }

    /**
     * 设置查询数据年度、区划
     * @param pro_code
     * @param proguid
     */
    public void setProfundParams(String pro_code, String proguid, String agencyguid, String month) {
        String sql = "select perf_fundpay_view.Secu_f_Global_Setparm(?,?,?,?) from dual";
        logger.info(sql);
        this.queryForMap(sql, new String[]{pro_code, proguid, agencyguid, month});
    }

    /**
     * @param nodeguid --
     * @description 获取审核主表数据.
     * @return map
     */
    public List<Map<String, Object>> getAuditData(String mainguid, String audittype, String nodeguid) throws AppException {
        Map<String, Object> map = this.getHandoverCurrentUserRoles();
        String users = (String) map.get("users");
        String sql = "select * from " + AUDITMAIN_TABLE + " where mainguid= ? and nodeguid= ? and type = ? and userguid in(" + users + ")";
        return this.queryForList(sql,new String[]{mainguid, nodeguid, audittype});
    }

    /**
     * 根据当前登录用户获取交接用户角色信息
     * @return
     * @throws AppException
     */
    public Map<String, Object> getHandoverCurrentUserRoles() throws AppException {
        Map<String, Object> returnmap = new HashMap<>();
        String users = CommonUtil.getCurrentUserID();
        String roles = null;
        List<String> userlist = new ArrayList<>();userlist.add(users);//默认 当前登录用户
        List<String> rolelist = CommonUtil.getCurrentUserRoles();//默认 当前登录用户角色
        List<String> handoverUserList = SecurityUtils.getHandoverlist();// 获取当前登录用户交接用户id列表
        if(handoverUserList != null && !handoverUserList.isEmpty()){
            userlist.addAll(handoverUserList);// 加入交接用户id列表
            rolelist = CommonUtil.getCurrentUserRoles();
            IUserService userService = (IUserService) ServiceFactory.getBean("buscore.ca.user.service");
            List<String> handoverRolelists = new ArrayList<>();
            for (String handoveruserid : handoverUserList) {
                List<String> handoverRolelist = userService.getRoleGuidsByUserGuid(handoveruserid);
                handoverRolelists.addAll(handoverRolelist);
            }
            rolelist.addAll(handoverRolelists);// 加入交接用户角色列表
        }
        if(userlist != null && !userlist.isEmpty()){
            StringBuffer tempusers = new StringBuffer("'");
            for(String a :userlist){
                tempusers.append(a).append("','");
            };
            users = tempusers.substring(0,tempusers.length()-2);
        }
        if(rolelist != null && !rolelist.isEmpty()){
            StringBuffer temproles = new StringBuffer("'");
            for(String a :rolelist){
                temproles.append(a).append("','");
            };
            roles = temproles.substring(0,temproles.length()-2);
        }
        returnmap.put("userlist",userlist);//userlist 用户idlist
        returnmap.put("users",users);//users 拼接好的用户id串，用来in()
        returnmap.put("rolelist",rolelist);//rolelist 角色list
        returnmap.put("roles",roles);//roles 拼接好的角色id串，用来in()
        return returnmap;
    }

    /**
     * 大批量更新数据。
     * @param tabcode -- 注册表
     * @param upsql --修改字段
     * @param wheresql --条件语句
     * @return
     * @throws AppException
     */
    public int batchUpdate(String tabcode, String upsql, String wheresql) throws AppException {
        if (tabcode == null) {
            throw new AppException(DaoAppException.C11000200, DaoAppException.M11000200);
        }
        StringBuilder vchsql = new StringBuilder();
        String wsql = wheresql.replace("#tablecode#", tabcode);
        vchsql.append("merge into ").append(tabcode).append(" t using").append(wsql);
        vchsql.append(" when matched then update set");
        vchsql.append(upsql);
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        String time = PerfUtil.getServerTimeStamp();
        DicTableDTO dicTableDTO = dicQueryService.getDicTable(tabcode.toLowerCase());
        List coll = (List) dicTableDTO.getListCol();
        int i = 0;
        for (Object obj : coll) {
            Map map = (Map) obj;
            if ("UPDATE_TIME".equals(map.get("columncode"))) {
                vchsql.append(", t.update_time=?");
                i++;
            }
            if ("UPDATETIME".equals(map.get("columncode"))) {
                vchsql.append(", t.updatetime=?");
                i++;
            }
        }
        String[] str = new String[i];
        for (int j = 0; j < i; j++) {
            str[j] = time;
        }
        logger.info("修改sql++++++++" + vchsql.toString());
        return super.update(vchsql.toString(), str);
    }
}
