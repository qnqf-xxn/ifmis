package gov.mof.fasp2.pmkpi.setting.indexlib.audit;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.dataset.dto.DataSetDTO;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.lang.StringUtils;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 14:53 2020/8/17  chongdayong
 */
public class IndexAuditBO extends PmkpiBO {

    private IndexAuditDAO indexAuditDAO;

    @Resource(name = "pmkpi.setting.indexlib.audit.IndexAuditDAO")
    public void setIndexAuditDAO(IndexAuditDAO indexAuditDAO) {
        this.indexAuditDAO = indexAuditDAO;
    }

    /**
     * 左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<DicRangeDTO> getTreeData(HashMap<String, Object> params) throws AppException {
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        String lefttabtype = (String) params.get("lefttabtype");
        String menuid = (String) params.get("menuid");
        StringBuffer wheresql = new StringBuffer();
        if ("INDEXCOMFUNC_SX".equals(lefttabtype) || "INDEXCOMFUNC_ZJ".equals(lefttabtype) || "INDEXCOMFUNC_HuBei".equals(lefttabtype) || "PMKPIDEPT".equals(lefttabtype) || "PMKPIAGENCYALLPAY".equals(lefttabtype)) { //湖北浙江走权限
            String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1");
            logger.debug("获取左侧树权限的："+datarule);
            wheresql.append(datarule);
        }
        List<DicRangeDTO> value;
        if ("PMKPIAGENCYALLPAY".equals(lefttabtype)) {
            List datas = indexAuditDAO.getLeftTree(PmkpiDAO.PMKPI_TABLE_T_AGENCY, wheresql.toString());
            value = datas;
        } else {
            value = dss.getRangesByWhereSql(lefttabtype, wheresql.toString());
        }
        if ("INDEXCOMFUNC_HuBei".equals(lefttabtype)){ //湖北添加项目分类.
            StringBuffer commonsql = new StringBuffer(" select t.*,superid as superguid,'1' as rowtype from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87'");
            commonsql.append(" order by t.ordernum");
            List commdar= indexAuditDAO.queryForList(commonsql.toString());
            value.addAll(commdar);
        }
        if ("INDEXCOMFUNC_SX".equals(lefttabtype)){ //山西追加指标模板分类.
            StringBuffer commonsql = new StringBuffer(" select t.*,superid as superguid,'1' as rowtype from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87' and proelement in ('sx00','sx01')");
            commonsql.append(" order by t.ordernum");
            List commdar= indexAuditDAO.queryForList(commonsql.toString());
            value.addAll(commdar);
        }
        if ("INDEXCOMFUNC_JiangXi".equals(lefttabtype)) { //江西添加项目分类.
            value.forEach(r->{
                if (Integer.parseInt(r.get("levelno").toString()) > 3){
                    r.put("code","");
                }
            });
        }
        return value;
    }

    /**
     * 查询指标层次.
     *
     * @param sqlmap -- sql.
     * @return
     * @throws AppException -- 异常.
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String tabtype = (String) sqlmap.get("tabtype");
        String menuid = (String) sqlmap.get("menuid"); //菜单guid.
        String treeid = (String) sqlmap.get("treeid");
        String querySql = (String) sqlmap.get("querySql");
        String isleaf = sqlmap.get("isleaf") + "";
        String tabcode = (String) sqlmap.get("tabcode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String isZJ = PerfUtil.getSystemSet("isZJ");
        String levelno = sqlmap.get("levelno") == null ? null : sqlmap.get("levelno").toString();
        StringBuffer wheresql = new StringBuffer();
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        DataSetDTO ds = dss.getDataSetByElementCode(tabtype);
        String dissql = "";
        if (ds != null) {
            dissql = (String) ds.get("datasource");
            if ("3".equals(ds.get("sourcetype"))) {
                dissql = " select * from " + dissql;
            }
        }
        String datarule = this.getDataRuleByMenuguidNull(menuid, "m", null);
        datarule = datarule.replace("m.agencyguid", "m.guid");
        if ("PMKPIDEPT".equals(tabtype) || "PMKPIAGENCYALLPAY".equals(tabtype)) { //部门整体
            if("1".equals(isleaf)){
                wheresql.append(" t.agencyguid ='").append(treeid).append("' and ");
            } else if (!"treeroot".equals(treeid)){
                wheresql.append(" t.agencyguid like '").append(treeid).append("%' and ");
            }
            wheresql.append(" t.framesystem = 'DEPT'"); //部门整体的添加过滤
            wheresql.append(" and exists(select 1 from pmkpi_fasp_t_pubagency m where m.guid=t.agency_code ").append(datarule).append(") ");
            String wfsql = this.getWfSql(tabcode, workflow);
            if (wfsql != null && !wfsql.isEmpty()) {
                wheresql.append(" and (").append(wfsql).append(") ");
            }
            if (tabfilter != null && !tabfilter.isEmpty()) {
                wheresql.append(" and ").append(tabfilter);
            }
        } else { //项目行业分类
            if (isleaf != null && "1".equals(isleaf)) {
                if(StringUtils.isNotBlank(isZJ) && "1".equals(isZJ)){
                    if("2".equals(levelno)){
                        wheresql.append(" agency_code = substr('"+treeid+"',0,3) ");
                    }else if("3".equals(levelno)){
                        wheresql.append(" agency_code= '").append(treeid).append("'");
                    }else if("4".equals(levelno)){
                        wheresql.append(" indexcategories= '").append(treeid).append("'");
                    }else if("5".equals(levelno)){
                        wheresql.append(" industrycategory= '").append(treeid).append("'");
                    }
                } else if ("INDEXCOMFUNC_JiangXi".equals(tabtype)){//江西到活动
                    wheresql.append(" occupation='").append(treeid).append("'");
                } else if ("INDEXCOMFUNC_HuBei".equals(tabtype)){//湖北查询项目
                    wheresql.append(" pro_name ='").append(treeid).append("'");
                } else {
                    wheresql.append(" industrycategory='").append(treeid).append("'");
                }
            } else if (treeid != null && !"treeroot".equals(treeid)) {
                if (PerfUtil.getIsSx() && tabtype != null && "INDEXCOMFUNC_SX".equals(tabtype)){ //山西
                    String funcdatarule = this.getDataRuleByMenuguid(menuid, "t", "1=1");
                    logger.debug("获取左侧树权限的："+funcdatarule);
                    String disssql = "select t.guid,t.code,t.name,t.SUPERID superguid,t.SUPERID,t.levelno,t.AGENCYGUID,t.isleaf,t.PROVINCE,t.status," +
                            "'indexdept' as mogamisuperid from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87' and proelement in ('sx00','sx01') union all select t.* from v_perf_t_indexcomfunc_sx t where "+funcdatarule;
                    List<Map<String, Object>> elelist = indexAuditDAO.getElementDatas(treeid, disssql);
                    indexAuditDAO.saveAll(elelist, "PERF_TMP_GUIDS");
                    wheresql.append(" exists ( select 1 from PERF_TMP_GUIDS a where a.guid =t.industrycategory) ");
                }else{
                    List<Map<String, Object>> list = indexAuditDAO.getElementDatas(treeid, dissql);
                    indexAuditDAO.saveAll(list, indexAuditDAO.PMKPI_TABLE_TMP_AGENCY);
                    wheresql.append(" exists ( select 1 from ").append(indexAuditDAO.PMKPI_TABLE_TMP_AGENCY);
                    if(tabtype != null && ("INDEXCOMFUNC_JiangXi".equals(tabtype))){
                        wheresql.append(" a where a.guid =t.occupation) ");
                    } else if (tabtype != null && "INDEXCOMFUNC_HuBei".equals(tabtype)){
                        wheresql.append(" a where a.guid =t.pro_name) ");
                    } else {
                        wheresql.append(" a where a.guid =t.industrycategory) ");
                    }
                }
                if (tabtype != null && "INDEXCOMFUNC_ZJ".equals(tabtype) && StringUtils.isNotBlank(isZJ) && "1".equals(isZJ)){
                    if("2".equals(levelno)){
                        wheresql.append(" and agency_code = substr('"+treeid+"',0,3) ");
                    }else if("3".equals(levelno)){
                        wheresql.append(" and agency_code= '").append(treeid).append("'");
                    }else if("4".equals(levelno)){
                        wheresql.append(" and indexcategories= '").append(treeid).append("'");
                    }else if("5".equals(levelno)){
                        wheresql.append(" and industrycategory= '").append(treeid).append("'");
                    }
                }
            } else {
                wheresql.append(" 1=1 ");
                if (!"INDEXCOMFUNC_SX".equals(tabtype) && !"INDEXCOMFUNC_ZJ".equals(tabtype) && !"INDEXCOMFUNC_HuBei".equals(tabtype)) { //湖北和浙江直接插叙当前项目下的展示
                    wheresql.append(" and exists(select 1 from (").append(dissql).append(")a where t.industrycategory=a.guid)");
                }
            }
            wheresql.append(" and t.framesystem = 'PM001'");
            wheresql.append(" and is_common_ind <> 1 and agency_code is not null");
            wheresql.append(" and exists(select 1 from pmkpi_fasp_t_pubagency m where m.guid=t.agency_code ").append(datarule).append(") ");
            String wfsql = this.getWfSql(tabcode, workflow);
            if (wfsql != null && !wfsql.isEmpty()) {
                wheresql.append(" and (").append(wfsql).append(") ");
            }
            if (tabfilter != null && !tabfilter.isEmpty()) {
                wheresql.append(" and ").append(tabfilter);
            }
        }
        if (querySql != null && !querySql.isEmpty()) {
            wheresql.append(" and (").append(querySql).append(")");
        }
        String sql = "select t.* from " + indexAuditDAO.PMKPI_TABLE_BASE_INDEX + " t where ";
        if(PerfUtil.getIS_HUBEI()){
            //湖北指标列表查询失败  报错‘无法解析的成员访问表达式[A.ELE_CODE]’ 达梦给出的解决方案 查询sql添加  /*+VIEW_PULLUP_FLAG(0)*/
            /*BAS_PERF_V_INDICATOR：湖北查询视图*/
            sql = "select /*+VIEW_PULLUP_FLAG(0)*/ t.* from BAS_PERF_V_INDICATOR t where ";
        }
        if (wheresql != null && !wheresql.toString().isEmpty()) {
            sql += wheresql;
        }
        sql += " order by t.findex,t.sindex,t.perf_ind_code";
        return sql;
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        //审核定义
        String busguid = (String) params.get("busguid");
        //取消审核
        if ("cancelaudit".equals(actioncode)) {
            this.adjustBeforeDatas(datas, "cancel");
        }
        this.workflow(actioncode, workflow, remark, indexAuditDAO.PMKPI_TABLE_BASE_INDEX, datas);
        //调整和删除指标申请逻辑
        List<String> odlguis = new ArrayList();
        List<String> guids = new ArrayList();
        List<String> auditguids = new ArrayList();
        List<String> unauditguids = new ArrayList();
        for (Map<String, Object> map : datas) {
            String guid = (String) map.get("guid");
            String wfstatus = (String) map.get("wfstatus");
            String applyStatus = (String) map.get("apply_status");
            String oldGuid = (String) map.get("oldguid");
            if ("011".equals(wfstatus)) { // 已终审
                if ("2".equals(applyStatus)) { // 调整当前申请-假删旧数据
                    odlguis.add(oldGuid);
                } else if ("3".equals(applyStatus)) { // 执行假删当前数据操作
                    guids.add(guid);
                }
                auditguids.add(guid);
            } else {
                unauditguids.add(guid);
            }
        }
        if (odlguis.size() > 0) {
            indexAuditDAO.deleteAllByColumn("ind_id", odlguis, indexAuditDAO.PMKPI_PERF_BASE_INDEX);
        }
        if (guids.size() > 0) {
            indexAuditDAO.deleteAllByColumn("ind_id", guids, indexAuditDAO.PMKPI_PERF_BASE_INDEX);
        }
        String upsql = "";
        if (auditguids.size() > 0) {
            upsql = "is_last_inst=1";
            indexAuditDAO.updateAllByColumn("ind_id", auditguids, indexAuditDAO.PMKPI_PERF_BASE_INDEX, upsql, null);
        }
        if (unauditguids.size() > 0) {
            upsql = "is_last_inst=2";
            indexAuditDAO.updateAllByColumn("ind_id", unauditguids, indexAuditDAO.PMKPI_PERF_BASE_INDEX, upsql, null);
        }
        //审核
        if ("audit".equals(actioncode) || "auditbatch".equals(actioncode)) {
            //处理调整前指标状态
            adjustBeforeDatas(datas,"");
        }
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 处理调整前数据的状态，调整数据的状态
     */
    public void adjustBeforeDatas(List<Map<String, Object>> datas,String type) throws AppException {
        StringBuffer beforeAdjustGuids = new StringBuffer();//调整前guid
        String time = PerfUtil.getServerTimeStamp();
        List<String> guids = new ArrayList<>();
        for (Map<String, Object> data : datas) {
            String guid = (String) data.get("guid");
            String wfstatus = (String) data.get("wfstatus");
            String adjustguid = (String) data.get("adjustguid");
            String adjuststatus = (String) data.get("adjuststatus");
            //判断指标数据是否已终审
            if ("011".equals(wfstatus)) {
                //是否是选择调整的指标
                if (!StringUtil.isEmpty(adjustguid)){
                    beforeAdjustGuids.append("'").append(adjustguid).append("',");
                }
                if ("3".equals(adjuststatus)){ //调整数据是删除状态,更新is_delete的值
                    guids.add(guid);
                }
            }
        }
        //是否存在选择的指标，并且是已终审的
        if (beforeAdjustGuids.length() > 0) {
            int is_deleted = 1; //默认状态，终审删除
            if ("cancel".equals(type)) {  //取消终审，把调整前数据状态还原
                is_deleted = 2;
            }
            beforeAdjustGuids.deleteCharAt(beforeAdjustGuids.length() - 1);
            //处理选择调整前指标，取消终审进行数据状态恢复/终审进行数据删除
            String wheresql = " set is_deleted = " + is_deleted + ", updatetime='" + time + "' where guid in(" + beforeAdjustGuids.toString() + ") ";
            indexAuditDAO.updateDatas(indexAuditDAO.PMKPI_PERF_BASE_INDEX, wheresql);
        }
        if (guids.size() > 0) {
            indexAuditDAO.deleteAllByColumn("ind_id", guids, indexAuditDAO.PMKPI_PERF_BASE_INDEX);
        }
    }
}
