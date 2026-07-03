package gov.mof.fasp2.pmkpi.setting.indexlib.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.EncryptUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.dto.DataSetDTO;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busdic.table.dto.DicTableDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.setting.zjtempdata.ZjTempDataBO;
import org.springframework.util.StringUtils;

import javax.annotation.Resource;
import java.text.DecimalFormat;
import java.util.*;

/**
 * @Description:
 * @Revision History:
 * @Revision 14:53 2020/8/17  chongdayong
 */
public class IndexRpBO extends PmkpiBO {
    private IndexRpDAO indexRpDAO;

    @Resource(name = "pmkpi.setting.indexlib.report.IndexRpDAO")
    public void setIndexRpDAO(IndexRpDAO indexRpDAO) {
        this.indexRpDAO = indexRpDAO;
    }

    /**
     * 左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<DicRangeDTO> getTreeData(HashMap<String, Object> params) throws AppException {
        String lefttabtype = (String) params.get("lefttabtype");
        String menuid = (String) params.get("menuid");
        StringBuffer wheresql = new StringBuffer();
        if ("INDEXCOMFUNC_SX".equals(lefttabtype) || "INDEXCOMFUNC_ZJ".equals(lefttabtype) || "INDEXCOMFUNC_HuBei".equals(lefttabtype) || "PMKPIDEPT".equals(lefttabtype) || "PMKPIAGENCYALLPAY".equals(lefttabtype)) { //湖北浙江走权限
            String datarule = this.getDataRuleByMenuguid(menuid, "t", "1=1");
            logger.debug("获取左侧树权限的："+datarule);
            wheresql.append(datarule);
        }
        List<DicRangeDTO> value = PerfUtil.getSourceData(lefttabtype, wheresql.toString());
        if ("INDEXCOMFUNC_HuBei".equals(lefttabtype)){ //湖北添加项目分类.
            StringBuffer commonsql = new StringBuffer(" select t.*,superid as superguid,'1' as rowtype from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87'");
            commonsql.append(" order by t.ordernum");
            List commdar= indexRpDAO.queryForList(commonsql.toString());
            value.addAll(commdar);
        }
        if ("INDEXCOMFUNC_SX".equals(lefttabtype)){ //山西追加指标模板分类.
            StringBuffer commonsql = new StringBuffer(" select t.*,superid as superguid,'1' as rowtype from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87' and proelement in ('sx00','sx01')");
            commonsql.append(" order by t.ordernum");
            List commdar= indexRpDAO.queryForList(commonsql.toString());
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
     * 保存指标数据.
     *
     * @param params --
     * @return --
     */
    public void save(HashMap<String, Object> params) throws AppException {
        String tabtype = (String) params.get("tabtype");
        String indextype = (String) params.get("indextype");
        String pagetype = (String) params.get("pagetype");
        String agencycode = (String) params.get("agency");
        Map<String, Object> data = (Map<String, Object>) params.get("data");
        if (pagetype != null && "add".equals(pagetype)) {
            String workflow = (String) params.get("workflow");  //工作流
            String indexcategories = (String) data.get("indexcategories");
            if("#".equals(indexcategories) || "0".equals(indexcategories)){
                data.put("indexcategories", data.get("industrycategory"));
            }
            if (PerfUtil.getIS_HUBEI()) {//湖北模式
                if("dept".equals(indextype) && "INDEXCOMFUNC_HuBei".equals(tabtype)) {
                    //处理项目类型
                    String protype = (String) data.get("pro_type");
                    if(StringUtil.isNullOrEmpty(protype) || protype.length()>3){
                        String sql = "select * from v_perf_indexcomfunc t where length(t.superguid)<4 start with t.guid ='" + data.get("pro_name") + "' connect by t.guid = prior t.superid";
                        logger.debug("项目查询sql：" + sql);
                        List<Map<String, Object>> list = indexRpDAO.queryForList(sql);
                        if (list.size() > 0) {
                            data.put("pro_type", list.get(0).get("superguid"));
                        }
                    }
                }
            }
            data.put("guid", this.getCreateguid());
            data.put("status", 1);
            data.put("is_common_ind", 1);
            data.put("apply_status", 1);
            data.put("is_pm_perf_ind", 1);
            data.put("is_last_inst", 1);
            if (indextype != null && "finance".equals(indextype) && tabtype != null && ("INDEXCOMFUNC_JiangXi".equals(tabtype) || "INDEXCOMFUNC".equals(tabtype) || "INDEXTRANPAY".equals(tabtype))) {
                data.put("is_common_ind", 2);
                data.put("agencyguid", null);
                data.put("agency_code", null);
                data.put("agency_name", null);
            }
            // 处理江西部门，个性化 根据活动 反推上5级的内容
            if (tabtype != null && "INDEXCOMFUNC_JiangXi".equals(tabtype)) {
                String occupation = (String) data.get("occupation");
                List dtos = indexRpDAO.getElementDatas(occupation);
                if (dtos.size() > 0){
                    Map dto = (Map) dtos.get(0);
                    data.put("indexcategories", dto.get("indexcategories"));
                    data.put("industrycategory", dto.get("industrycategory"));
                    data.put("indexcategory", dto.get("indexcategory"));
                    data.put("filed", dto.get("filed"));
                } else {
                    throw  new AppException("当前活动属性无效，请联系管理员！！");
                }
            }
            if (indextype != null && "dept".equals(indextype)) {
                if (!"PMKPIDEPT".equals(tabtype) && !"PMKPIAGENCYALLPAY".equals(tabtype)) {
                    if(tabtype != null && ("INDEXCOMFUNC_ZJ".equals(tabtype) || "INDEXCOMFUNC_HuBei".equals(tabtype))){//湖北，浙江左侧树为项目 agency保存为项目的agency
                        data.put("agencyguid", agencycode);
                        data.put("agency_code", agencycode);
                        String elementcode = "PMKPIAGENCYALLPAY";
                        String wheresql = "guid in ('" + agencycode + "')";
                        List<DicRangeDTO> eledatas = PerfUtil.getSourceData(elementcode, wheresql);
                        if (eledatas != null && eledatas.size() > 0) {
                            data.put("agency_name", eledatas.get(0).get("name"));
                        }
                    }else {
                        String upagency = SecureUtil.getCurrentUser().getUpagencyid();
                        String agency = SecureUtil.getCurrentUser().getAgency();
                        String agencyname = SecureUtil.getUserAgencyName();
                        String upagencyname = SecureUtil.getUserUPAgencyName();
                        if (!StringUtil.isEmpty(upagency) && !upagency.equals(agency)) { //提级用户保存的是提级
                            data.put("agencyguid", upagency);
                            data.put("agency_code", upagency);
                            data.put("agency_name", upagencyname);
                        } else {
                            data.put("agencyguid", agency);
                            data.put("agency_code", agency);
                            data.put("agency_name", agencyname);
                        }
                    }
                } else {
                    data.put("is_pm_perf_ind", 2);
                }
                data.put("is_common_ind", 2);
                data.put("is_last_inst", 2);
            }
            data.put("ind_id", data.get("guid"));
            data.put("name", data.get("perf_ind_name"));
            data.put("indexvalue", data.get("kpi_val"));
            data.put("parent_id", data.get("sindex"));
            data.put("level_no", 3);
            data.put("is_leaf", 1);
            data.put("adjuststatus",1);  //数据状态：1新增
            this.getBasMap(data, "add");
            if(StringUtil.isNullOrEmpty((String) data.get("value_desc"))){
                data.put("value_desc", data.get("perf_ind_name"));
            }
            data.put("biz_key", null); // 业务唯一标识
            List<Map<String, Object>> list = new ArrayList<>();
            list.add(data);
            indexRpDAO.setIndexCode(list);
            data = list.get(0);
            if (indextype != null && "dept".equals(indextype)) {
                List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
                l.add(data);
                this.workflow("create", workflow, "", indexRpDAO.PMKPI_TABLE_BASE_INDEX, l);
            } else {
                indexRpDAO.save(data, indexRpDAO.PMKPI_TABLE_BASE_INDEX);
            }
        } else {
            String timestimps = StringUtil.getSysDBDate();
            data.put("updatetime", timestimps);
            data.put("update_time", timestimps);
            data.put("name", data.get("perf_ind_name"));
            data.put("indexvalue", data.get("kpi_val"));
            if(StringUtil.isNullOrEmpty((String) data.get("value_desc"))){
                data.put("value_desc", data.get("perf_ind_name"));
            }
            List cols = Arrays.asList(data.keySet().toArray());
            indexRpDAO.update(cols, data, indexRpDAO.PMKPI_TABLE_BASE_INDEX);
        }
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
        String indextype = (String) sqlmap.get("indextype"); //区分财政还是部门
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
        String dissql = (String) ds.get("datasource");
        if (indextype != null && "finance".equals(indextype) && tabtype != null && "IDEXCOMCLS".equals(tabtype)) { // 财政共性
            if (isleaf != null && "1".equals(isleaf)) {
                wheresql.append(" projtype='").append(treeid).append("'");
            } else if (treeid != null && !"treeroot".equals(treeid)) {
                List<Map<String, Object>> list = indexRpDAO.getElementDatas(treeid, dissql);
                indexRpDAO.saveAll(list, indexRpDAO.PMKPI_TABLE_TMP_AGENCY);
                wheresql.append(" exists ( select 1 from ").append(indexRpDAO.PMKPI_TABLE_TMP_AGENCY).append(" a where a.guid =t.projtype) ");
            } else {
                wheresql.append(" exists(select 1 from( ").append(dissql).append(") a where t.projtype=a.guid)");
            }
            wheresql.append(" and is_common_ind = 1");
        } else if (indextype != null && "finance".equals(indextype) && tabtype != null && ("INDEXCOMFUNC".equals(tabtype) || "INDEXTRANPAY".equals(tabtype) || "INDEXCOMFUNC_JiangXi".equals(tabtype))) { //财政个性
            String col = "";
            wheresql.append(" is_common_ind = 2 and ");
            if ("INDEXCOMFUNC".equals(tabtype)) {
                col = "industrycategory";
            } else if ("INDEXTRANPAY".equals(tabtype)){
                col = tabtype;
            } else if ("INDEXCOMFUNC_JiangXi".equals(tabtype)){
                col = "occupation"; //活动
            }
            if (isleaf != null && "1".equals(isleaf)) {
                wheresql.append(col).append(" ='").append(treeid).append("' and ");
            } else if (treeid != null && !"treeroot".equals(treeid)) {
                List<Map<String, Object>> list = indexRpDAO.getElementDatas(treeid, dissql);
                indexRpDAO.saveAll(list, indexRpDAO.PMKPI_TABLE_TMP_AGENCY);
                wheresql.append(" exists ( select 1 from ").append(indexRpDAO.PMKPI_TABLE_TMP_AGENCY).append(" a where a.guid =t.").append(col).append(") and ");
            }
            /*else {
                wheresql.append(" exists(select 1 from (").append(dissql).append(")a where t.").append(col).append("=a.guid)");
            }*/
            wheresql.append(" agency_code is null");
        } else { //部门指标库
            if (isleaf != null && "1".equals(isleaf)) {
                if ("PMKPIDEPT".equals(tabtype) || "PMKPIAGENCYALLPAY".equals(tabtype)) {
                    wheresql.append(" agencyguid='").append(treeid).append("'");
                    wheresql.append(" and framesystem = 'DEPT'"); //部门整体的添加过滤
                } else {
                    if(org.apache.commons.lang.StringUtils.isNotBlank(isZJ) && "1".equals(isZJ)){
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
                    wheresql.append(" and framesystem = 'PM001'"); //项目支出的添加过滤
                }
            } else if (treeid != null && !"treeroot".equals(treeid)) {
                if ("PMKPIDEPT".equals(tabtype)) { //部门整体
                    wheresql.append(" t.agencyguid='").append(treeid).append("'");
                    wheresql.append(" and framesystem = 'DEPT'");
                } else if ("PMKPIAGENCYALLPAY".equals(tabtype)) {
                    wheresql.append(" t.agencyguid like '").append(treeid).append("%'");
                    wheresql.append(" and framesystem = 'DEPT'");
                } else if (tabtype != null && ("INDEXCOMFUNC_ZJ".equals(tabtype) || "INDEXCOMFUNC_HuBei".equals(tabtype))){ //湖北和浙江直接插叙当前项目下的展示
                    if(org.apache.commons.lang.StringUtils.isNotBlank(isZJ) && "1".equals(isZJ)){
                        if("2".equals(levelno)){
                            wheresql.append(" agency_code = substr('"+treeid+"',0,3) ");
                        }else if("3".equals(levelno)){
                            wheresql.append(" agency_code= '").append(treeid).append("'");
                        }else if("4".equals(levelno)){
                            wheresql.append(" indexcategories= '").append(treeid).append("'");
                        }else if("5".equals(levelno)){
                            wheresql.append(" industrycategory= '").append(treeid).append("'");
                        }
                    } else {
                        //湖北
                        wheresql.append(" pro_name='").append(treeid).append("'");//项目id
                    }
                    wheresql.append(" and t.framesystem = 'PM001'");
                } else if (PerfUtil.getIsSx() && tabtype != null && "INDEXCOMFUNC_SX".equals(tabtype)){ //山西
                    String datarule = this.getDataRuleByMenuguid(menuid, "t", "1=1");
                    logger.debug("获取左侧树权限的："+datarule);
                    String disssql = "select t.guid,t.code,t.name,t.SUPERID superguid,t.SUPERID,t.levelno,t.AGENCYGUID,t.isleaf,t.PROVINCE,t.status," +
                            "'indexdept' as mogamisuperid from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87' and proelement in ('sx00','sx01') union all select t.* from v_perf_t_indexcomfunc_sx t where "+datarule;
                    List<Map<String, Object>> elelist = indexRpDAO.getElementDatas(treeid, disssql);
                    indexRpDAO.saveAll(elelist, "PERF_TMP_GUIDS");
                    wheresql.append(" exists ( select 1 from PERF_TMP_GUIDS a where a.guid =t.industrycategory) ");
                    wheresql.append(" and t.framesystem = 'PM001'"); //项目支出的添加过滤
                }else {
                    List<Map<String, Object>> list = indexRpDAO.getElementDatas(treeid, dissql);
                    indexRpDAO.saveAll(list, indexRpDAO.PMKPI_TABLE_TMP_AGENCY);
                    wheresql.append(" exists ( select 1 from ").append(indexRpDAO.PMKPI_TABLE_TMP_AGENCY);
                    if(tabtype != null && ("INDEXCOMFUNC_JiangXi".equals(tabtype))){
                        wheresql.append(" a where a.guid =t.occupation) ");
                    } else {
                        wheresql.append(" a where a.guid =t.industrycategory) ");
                    }
                    wheresql.append(" and t.framesystem = 'PM001'"); //项目支出的添加过滤
                }
            } else {
                if ("PMKPIDEPT".equals(tabtype) || "PMKPIAGENCYALLPAY".equals(tabtype)) {
                    wheresql.append(" t.framesystem = 'DEPT'");
                } else {
                    wheresql.append(" t.framesystem = 'PM001'");
                    if (!"INDEXCOMFUNC_SX".equals(tabtype) && !"INDEXCOMFUNC_ZJ".equals(tabtype) && !"INDEXCOMFUNC_HuBei".equals(tabtype)) { //湖北和浙江直接插叙当前项目下的展示
                        wheresql.append(" and exists(select 1 from (").append(dissql).append(")a where t.industrycategory=a.guid)");
                    }
                }
            }
            //处理区分部门指标与项目指标
            wheresql.append(" and is_common_ind <> 1 and agency_code is not null");
            String datarule = this.getDataRuleByMenuguid(menuid, "m", null);
            datarule = datarule.replace("m.agencyguid", "m.guid"); //这块是否可以直接优化，替换为agency_code?
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
        String sql = "select t.* from " + indexRpDAO.PMKPI_TABLE_BASE_INDEX + " t where ";
        if(PerfUtil.getIS_HUBEI()){
            //湖北指标列表查询失败  报错‘无法解析的成员访问表达式[A.ELE_CODE]’ 达梦给出的解决方案 查询sql添加  /*+VIEW_PULLUP_FLAG(0)*/
            /*BAS_PERF_V_INDICATOR：湖北查询视图*/
            sql = "select /*+VIEW_PULLUP_FLAG(0)*/ t.* from BAS_PERF_V_INDICATOR t where ";
        }
        if (wheresql != null && !wheresql.toString().isEmpty()) {
            sql += wheresql;
        }
        sql += " order by t.findex,t.sindex,t.perf_ind_code";
        logger.debug("查询列表sql："+sql);
        return sql;
    }

    /**
     * 删除
     *
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        try {
            List<String> guids = new ArrayList<>();
            for (Map<String, Object> data : deldatas) {
                guids.add((String) data.get("guid"));
            }
            indexRpDAO.deleteAllByColumn("guid", guids, indexRpDAO.PMKPI_TABLE_BASE_INDEX);
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        /**
         * 调整和删除指标申请逻辑
         */
        if (!StringUtils.isEmpty(params.get("workflowtype"))) {
            String workflowtype = (String) params.get("workflowtype");
            if ("3".equals(workflowtype)) {
                /**
                 *    APPLY_STATUS 申请状态：1-新增申请；2-调整申请；3-删除申请；
                 *    1.V_BAS_PERF_INDICATOR 表 APPLY_STATUS 字段改为3
                 *    2.送入删除申请流程
                 */
                for (Map<String, Object> map : datas) {
                    String sql = "UPDATE " + IndexRpDAO.PMKPI_TABLE_BASE_INDEX + " SET APPLY_STATUS = '" + workflowtype + "' WHERE IND_ID = '" + map.get("guid") + "'";
                    indexRpDAO.update(sql);
                    map.put("wfid", null);
                    map.put("wfstatus", null);
                }
            } else if ("2".equals(workflowtype)) {
                /**
                 *    APPLY_STATUS 申请状态：1-新增申请；2-调整申请；3-删除申请；
                 *    1.复制一份相同的数据出来并且把 APPLY_STATUS 字段改为2-原数据不做更改
                 *    2.送入调整申请流程
                 */
                for (Map<String, Object> map : datas) {
                    String oldGuid = (String) map.get("guid");
                    List getOne = indexRpDAO.queryForList("SELECT t.* FROM " + IndexRpDAO.PMKPI_TABLE_BASE_INDEX + " t  WHERE t.IND_ID  = '" + oldGuid + "'");
                    Map<String, Object> oldOne = (Map<String, Object>) getOne.get(0);
                    String guid = this.getCreateguid();
                    oldOne.put("oldguid", oldGuid); // 流程走完根据此id假删一条数据,IS_DELETED 改为1
                    oldOne.put("guid", guid);
                    oldOne.put("ind_id", guid);
                    oldOne.put("wfid", null);
                    oldOne.put("wfstatus", null);
                    oldOne.put("apply_status", workflowtype);
                    indexRpDAO.save(oldOne, IndexRpDAO.PMKPI_TABLE_BASE_INDEX);
                    map.put("guid", guid);
                }
            }
        }
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        //审核定义
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, IndexRpDAO.PMKPI_TABLE_BASE_INDEX, datas);
        return this.auditdefine(datas, busguid, actioncode, null);
    }


    /**
     * 导入财政指标
     *
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importIndexlibData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            List<Map<String, Object>> errorlist = this.checkIndexFrame(impDatas);
            if (errorlist.size() > 0) {
                throw new AppException("ANA-ERROR", "指标导入数据错误");
            } else {
                IndexRpBO indexRpBO = (IndexRpBO) PerfServiceFactory.getBean("pmkpi.setting.indexlib.report.IndexRpBOTx");
                indexRpBO.impIndex(indexRpBO, impDatas, impCols, tablecode, resultList, busParams);
            }
        }
    }

    public void impIndex(IndexRpBO indexRpBO, ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        IndexRpDAO indexRpDAO = (IndexRpDAO) PerfServiceFactory.getBean("pmkpi.setting.indexlib.report.IndexRpDAO");
        String tabtype = (String) busParams.get("tabtype");
        String indextype = (String) busParams.get("indextype");
        String menuid = (String) busParams.get("menuid");
        List<Map<String, Object>> indexList = new ArrayList<>();
        List<Map<String, Object>> agencyList = null;
        List<String> agencys = new ArrayList<>();
        if ("dept".equals(indextype)) {
            String datarule = indexRpBO.getDataRuleByMenuguid(menuid, "t", "1=1");
            agencyList = PerfUtil.getSourceData("PMKPIAGENCYALLPAY", datarule);
            agencyList.forEach(m->{
                agencys.add((String) m.get("guid"));
            });
        }
        for (Object indexMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) indexMap;
            //处理特殊字符
            data.put("name",PerfUtil.replaceSymbols((String) data.get("name")));
            data.put("indexval",PerfUtil.replaceSymbols((String) data.get("indexval")));
            data.put("perf_ind_name",PerfUtil.replaceSymbols((String) data.get("perf_ind_name")));
            data.put("kpi_val",PerfUtil.replaceSymbols((String) data.get("kpi_val")));
            data.put("guid", this.getCreateguid());
            data.put("status", 1);
            data.put("perf_ind_name", !StringUtil.isEmpty((String) data.get("name"))  ? data.get("name") : data.get("perf_ind_name"));
            data.put("kpi_val", !StringUtil.isEmpty((String) data.get("indexval"))  ? data.get("indexval") : data.get("kpi_val"));
            data.put("is_common_ind", 1);
            data.put("is_pm_perf_ind", 1);
            data.put("is_last_inst", 1);
            if (("finance".equals(indextype) && ("INDEXCOMFUNC_JiangXi".equals(tabtype) || "INDEXCOMFUNC".equals(tabtype) || "INDEXTRANPAY".equals(tabtype)))
                    || ("dept".equals(indextype))) {
                data.put("is_common_ind", 2);
            }
            if ("PMKPIDEPT".equals(tabtype) || "PMKPIAGENCYALLPAY".equals(tabtype)) {
                data.put("framesystem", "DEPT");
                data.put("is_pm_perf_ind", 2);
            } else {
                data.put("framesystem", "PM001");
            }
            String agencyguid = "";
            if (indextype != null && "dept".equals(indextype)) {
                agencyguid = (String) data.get("agency_code");  //预算单位
                data.put("agencyguid", data.get("agency_code"));
                if(StringUtil.isEmpty(agencyguid) || "null".equals(agencyguid)){ //判断导入模板里面的预算单位是否有值
                    String upagency = SecureUtil.getCurrentUser().getUpagencyid();
                    String agency = SecureUtil.getCurrentUser().getAgency();
                    String agencyname = SecureUtil.getUserAgencyName();
                    String upagencyname = SecureUtil.getUserUPAgencyName();
                    if (!StringUtil.isEmpty(upagency) && !upagency.equals(agency)){ //提级用户保存的是提级
                        data.put("agencyguid", upagency);
                        data.put("agency_code", upagency);
                        data.put("agency_name", upagencyname);
                        agencyguid = upagency;
                    } else {
                        data.put("agencyguid", agency);
                        data.put("agency_code", agency);
                        data.put("agency_name", agencyname);
                        agencyguid = agency;
                    }
                } else {
                    if (agencys.size() > 0) {
                        if (!agencys.contains(agencyguid)) {
                            throw new AppException("ERROR", "没有单位：" + agencyguid + data.get("agency_name") + "的权限，请检查后导入！");
                        }
                    }
                }
                data.put("is_last_inst", 2);
            }
            //湖北模式
            if (PerfUtil.getIS_HUBEI() && "dept".equals(indextype)){
                String pro_type = (String) data.get("pro_type");//目标类型
                String pro_name = (String) data.get("pro_name");  //项目名称
                logger.debug("湖北模式--- 目标类型："+pro_type+"-----项目名称："+pro_name+"-----预算单位："+agencyguid);
                //根据项目名称去查询项目的guid
                String sql ="select guid from v_perf_indexcomfunc t where t.superguid ='"+pro_type+"' and agencyguid ='"+agencyguid+"'";
                logger.debug("项目guid查询sql："+sql);
                List<Map<String, Object>> list = indexRpDAO.queryForList(sql);
                String guids;
                String guid ="";
                for (Map<String, Object> map : list) {
                    guids = (String) map.get("guid");
                    String wheresql =" t.superguid ='"+guids+"' and t.name ='"+pro_name+"'";
                    int dataCount = indexRpDAO.getDataCount("v_perf_indexcomfunc", wheresql);
                    String sql2 ="";
                    if (dataCount > 0){
                        sql2="select guid from v_perf_indexcomfunc t where t.superguid ='"+guids+"' and t.name ='"+pro_name+"' and agencyguid ='"+agencyguid+"'";
                    }else{
                        sql2 ="select guid from v_perf_indexcomfunc t where t.superguid ='"+pro_type+"' and t.name ='"+pro_name+"' and agencyguid ='"+agencyguid+"'";
                    }
                    List<Map<String, Object>> listdata = indexRpDAO.queryForList(sql2);
                    if (listdata.size() > 0) {
                        guid = (String) listdata.get(0).get("guid");
                    }
                }
                data.put("pro_type",pro_type);
                data.put("pro_name",pro_name);
                data.put("industrycategory",guid);  //存项目名称的guid
            }
            String value_desc = (String) data.get("value_desc");
            if(StringUtil.isNullOrEmpty(value_desc)){
                data.put("value_desc", data.get("perf_ind_name"));
            }
            data.put("ind_id", data.get("guid"));
            data.put("name", data.get("perf_ind_name"));
            data.put("indexvalue", data.get("kpi_val"));
            data.put("parent_id", data.get("sindex"));
            data.put("level_no", 3);
            data.put("is_leaf", 1);
            this.getBasMap(data, "add");
            indexList.add(data);
        }
        indexRpBO.setIndexCode(indexList);
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        DicTableDTO dicTableDTO = dicQueryService.getDicTable(tablecode.toLowerCase());
        List coll = (List) dicTableDTO.getListCol();
        List error = this.checkImpColNullable(indexList, coll);
        error.addAll(this.checkImpColLength(indexList, coll));
        if (error.size() > 0){
            throw new AppException("ANA-ERROR", "导入数据不规范，请检查");
        }
        if (indextype != null && "dept".equals(indextype)) {
            String workflow = (String) busParams.get("workflow");
            this.workflow("create", workflow, "", IndexRpDAO.PMKPI_TABLE_BASE_INDEX, indexList);
        } else {
            indexRpDAO.saveAll(indexList, indexRpDAO.PMKPI_TABLE_BASE_INDEX);
        }
    }

    /**
     * 广西通过密匙控制基础指标导入按钮的校验.
     * @param parms -- 参数
     * @return
     * @throws AppException -- 自定义异常.
     */
    public boolean checkImpkey(HashMap<String, Object> parms) throws AppException {
        String impkeyency = PerfUtil.getSystemSet("impdesckey");
        if (StringUtil.isEmpty(impkeyency) || !EncryptUtil.encrypt(CommonUtil.getProvince()).equals(impkeyency)){
            return false;
        }
        return true;
    }

    /**
     * 湖北部门指标导入
     *
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importHubeiIndexData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            List<Map<String, Object>> errorlist = this.checkIndexFrame(impDatas);
            //校验项目名称特殊符号
            errorlist.addAll(this.checkSpecialCharacters(impDatas));
            if (errorlist.size() > 0) {
                throw new AppException("ANA-ERROR", "指标导入数据错误");
            } else {
                IndexRpBO indexRpBO = (IndexRpBO) PerfServiceFactory.getBean("pmkpi.setting.indexlib.report.IndexRpBOTx");
                indexRpBO.impHubeiIndex(indexRpBO, impDatas, impCols, tablecode, resultList, busParams);
            }
        }
    }


    /**
     * 校验导入文件中项目名称不能含有特殊字符
     * @return
     */
    public List<Map<String, Object>> checkSpecialCharacters(List<Map<String, Object>> datas) throws AppException {
        List<Map<String, Object>> errorlist = new ArrayList<>();
        int j = 1;
        StringBuffer error = null;
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto = null;
        for (Map data : datas) {
            error = new StringBuffer();
            ++j;
            String pro_name = (String) data.get("pro_name");
            String specialCharacters = "[《》\\s\\t!@#$%^&*?？!￥<>\"]";
            if (!StringUtil.isEmpty(pro_name)) {
                boolean containsSpecialCharacters = pro_name.matches(".*"+specialCharacters+".*");
                if(containsSpecialCharacters) {
                    error.append("项目名称不得含有特殊字符 ");
                }
            }
            if (!StringUtil.isEmpty(error.toString())) {
                dto = new ImportErrorDTO(FileUploadService.fileguids.get(), j, error.toString());
                errordao.saveErrorMsg(dto);
                errorlist.add(dto);
            }
        }
        return errorlist;
    }

    public void impHubeiIndex(IndexRpBO indexRpBO, ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        IndexRpDAO indexRpDAO = (IndexRpDAO) PerfServiceFactory.getBean("pmkpi.setting.indexlib.report.IndexRpDAO");
        String indextype = (String) busParams.get("indextype");
        String tabtype = (String) busParams.get("tabtype");
        String menuid = (String) busParams.get("menuid"); //菜单guid.
        List<Map<String, Object>> indexList = new ArrayList<>();
        //校验数据
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto = null;
        List errorlist = new ArrayList();
        //导入之前先判断码表中是否有项目,没有项目保存一份
        this.checkProgram(impDatas);
        for (Object indexMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) indexMap;
            Integer linenum = (Integer) data.get("linenum");
            //处理特殊字符
            data.put("name",PerfUtil.replaceSymbols((String) data.get("name")));
            data.put("indexval",PerfUtil.replaceSymbols((String) data.get("indexval")));
            data.put("perf_ind_name",PerfUtil.replaceSymbols((String) data.get("perf_ind_name")));
            data.put("kpi_val",PerfUtil.replaceSymbols((String) data.get("kpi_val")));
            //标红字段必填
            for (Object impCol : impCols) {
                HashMap<String, Object> colMap = (HashMap<String, Object>) impCol;
                String columncode = (String) colMap.get("columncode");
                String redden = (String) colMap.get("redden");
                String showname = StringUtil.isEmpty((String) colMap.get("showname")) ? (String) colMap.get("name") : (String) colMap.get("showname");
                columncode = columncode.toLowerCase();
                String value = (String) data.get(columncode);
                //标红，不能为空
                if ("checked".equals(redden) && StringUtil.isEmpty(value)) {
                    dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, showname+"必填！");
                    errordao.saveErrorMsg(dto);
                    errorlist.add(errordao);
                }
            }

            data.put("guid", this.getCreateguid());
            data.put("status", 1);
            data.put("perf_ind_name", data.get("name"));
            data.put("is_common_ind", 1);
            data.put("is_pm_perf_ind", 1);
            data.put("is_last_inst", 1);
            data.put("framesystem", "PM001");  //湖北只有 PM001-项目指标体系
            if (("finance".equals(indextype) && ("INDEXCOMFUNC".equals(tabtype) || "INDEXTRANPAY".equals(tabtype)))
                    || ("dept".equals(indextype))) {
                data.put("is_common_ind", 2);
            }
            String agencyguid = "";
            if (indextype != null && "dept".equals(indextype)) {
                agencyguid = (String) data.get("agencyguid");  //预算单位
                if(!StringUtil.isEmpty(agencyguid) || !"null".equals(agencyguid)){ //判断导入模板里面的预算单位是否有值
                    //获取数据权限条件
                    String datarule = this.getDataRuleByMenuguid(menuid, "t", "1=1");
                    datarule = datarule.replace("t.agencyguid", "t.guid");
                    String agencysql ="select t.code,t.name from "+PmkpiDAO.PMKPI_TABLE_T_AGENCY +" t where "+ datarule +" order by code";
                    List<Map<String, Object>> agencydatas = indexRpDAO.queryForList(agencysql);
                    logger.debug("当前页面的权限数据："+agencydatas);
                    String agencyname ="";
                    boolean b = true;
                    for (Map<String, Object> agencydata : agencydatas) {
                        b = agencydata.containsValue(agencyguid);
                        if (b){
                            agencyname = (String) agencydata.get("name");
                            break;
                        }
                    }
                    //导入时校验预算单位是否在权限内
                    if (!b){
                        dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, agencyguid+"单位不在权限范围内！");
                        errordao.saveErrorMsg(dto);
                        errorlist.add(errordao);
                        continue;
                    }
                    data.put("agency_code", agencyguid);
                    data.put("agency_name", agencyname);
                }
                data.put("is_last_inst", 2);
                String pro_lev = (String) data.get("pro_lev");//目标级次
                String pro_type = (String) data.get("pro_type");//目标类型
                String pro_name = (String) data.get("pro_name");  //项目名称
                String pro_parent = (String) data.get("pro_parent"); //上级项目
                String sql ="select guid from v_perf_indexcomfunc t where name = '"+pro_name+"' and agencyguid ='"+agencyguid+"' ";
                if ("1".equals(pro_lev)) {
                    sql += " and t.superguid ='" + pro_type + "'";
                } else {
                    sql += " and t.superguid ='" + pro_parent + "'";
                }
                logger.debug("湖北模式--- 目标类型："+pro_type+"-----上级项目："+pro_parent+"-----项目名称："+pro_name+"-----预算单位："+agencyguid);
                //根据项目名称去查询项目的guid
                logger.debug("项目guid查询sql："+sql);
                List<Map<String, Object>> list = indexRpDAO.queryForList(sql);
                String guid ="";
                for (Map<String, Object> map : list) {
                    guid = (String) map.get("guid");
                }
                data.put("pro_type",pro_type);
                data.put("pro_name",guid);  //存码表的项目guid
            }
            String value_desc = (String) data.get("value_desc");
            if(StringUtil.isNullOrEmpty(value_desc)){
                data.put("value_desc", data.get("perf_ind_name"));
            }
            data.put("ind_id", data.get("guid"));
            data.put("name", data.get("perf_ind_name")); //指标名称
            data.put("indexvalue", data.get("kpi_val"));
            data.put("kpi_val", data.get("kpi_val")); //参考值
            data.put("parent_id", data.get("sindex"));
            data.put("adjuststatus",1);  //数据状态：1新增
            data.put("level_no", 3);
            data.put("is_leaf", 1);
            this.getBasMap(data, "add");
            indexList.add(data);
        }
        indexRpBO.setIndexCode(indexList);
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        DicTableDTO dicTableDTO = null;
        dicTableDTO = dicQueryService.getDicTable(tablecode.toLowerCase());
        List coll = (List) dicTableDTO.getListCol();
        errorlist.addAll(this.checkImpColNullable(indexList, coll));
        errorlist.addAll(this.checkImpColLength(indexList, coll));
        errorlist.addAll(this.importCheckData(indexList));
        if (errorlist.size() > 0){
            throw new AppException("ANA-ERROR", "导入数据不规范，请检查");
        }
        if (indextype != null && "dept".equals(indextype)) {
            String workflow = (String) busParams.get("workflow");
            this.workflow("create", workflow, "", IndexRpDAO.PMKPI_TABLE_BASE_INDEX, indexList);
        } else {
            indexRpDAO.saveAll(indexList, indexRpDAO.PMKPI_TABLE_BASE_INDEX);
        }
    }

    public List<Map<String, Object>> importCheckData(List<Map<String, Object>> indexList) throws AppException {
        List<Map<String, Object>> errorlist = new ArrayList<>();
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto;
        Map datamap = new HashMap();
        for (Map<String, Object> map : indexList) {
            Integer linenum = (Integer) map.get("linenum");
            String agencyguid = (String) map.get("agencyguid"); //预算单位
            String pro_lev = (String) map.get("pro_lev"); //项目级次
            String pro_name = (String) map.get("pro_name"); //项目名称
            String name = (String) map.get("name"); //指标名称
            String pro_parent = (String) map.get("pro_parent"); //上级项目
            String deptcode = agencyguid.substring(0,3);
            if (agencyguid.length() == 3){
                if (!"1".equals(pro_lev)){
                    dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum,  " 项目级次 选择有误，主管部门只能导入一级项目指标！");
                    errordao.saveErrorMsg(dto);
                    errorlist.add(dto);
                }
            }else{
                if (!"2".equals(pro_lev)){
                    dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum,  " 项目级次 选择有误，预算单位只能导入二级项目指标！");
                    errordao.saveErrorMsg(dto);
                    errorlist.add(dto);
                }
            }
            if ("2".equals(pro_lev) && (pro_parent == null || pro_parent.length() <= 0)){
                dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum,  " 上级项目 必填！");
                errordao.saveErrorMsg(dto);
                errorlist.add(dto);
            }

            String wheresql = "name ='" + name + "' and pro_name ='" + pro_name + "' and agencyguid ='" + agencyguid + "' ";
            String key = name+"#"+pro_name+"#"+agencyguid;
            int count = this.getDataCount(PmkpiDAO.PMKPI_TABLE_BAS_PERF_INDICATOR, wheresql);
            if (count > 0 || datamap.containsKey(key)) {
                dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, " 指标名称 重复！");
                errordao.saveErrorMsg(dto);
                errorlist.add(dto);
            }
            if (pro_parent != null && pro_parent.length() > 0){
                String sql = "select dept from v_perf_t_indexcomfunc t where guid ='"+pro_parent+"'";
                Map map1 = indexRpDAO.queryForMap(sql);
                if (!map1.get("dept").equals(deptcode)) {
                    dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, " 上级项目 只能选择本部门" + deptcode + "下的数据！");
                    errordao.saveErrorMsg(dto);
                    errorlist.add(dto);
                }
            }
            datamap.put(key,map);
        }
        return errorlist;
    }

    //判断码表中是否有项目,没有项目保存一份到码表
    public void checkProgram(List<Map<String, Object>> indexList) throws AppException {
        List<Map<String, Object>> datalist = new ArrayList<>();
        Map datasmap = new HashMap();
        int i = 1;
        for (Map<String, Object> map : indexList) {
            i++;
            String agencyguid = (String) map.get("agencyguid"); //预算单位
            String pro_parent = (String) map.get("pro_parent"); //上级项目
            String pro_name = (String) map.get("pro_name"); //项目名称
            String pro_type = (String) map.get("pro_type"); //目标类型
            String pro_lev = (String) map.get("pro_lev"); //项目级次
            String deptcode = agencyguid.substring(0, 3);
            //2、当预算单位+目标类型+项目级次+项目名称不存在项目码表时，导入指标时同时新增项目码表信息
            String levelno = "";
            String superid = "";
            String proelement = "02";
            String querysql = "t.agencyguid ='" + agencyguid + "' and t.name ='" + pro_name + "'";
            if ("1".equals(pro_lev)) {
                superid = pro_type;  //项目类型有值, 赋值给父级编码
                if (pro_type.length() == 2) {
                    levelno = "2";
                } else if (pro_type.length() == 3) {
                    levelno = "3";
                }
            } else {
                superid = pro_parent;  ////上级项目字段有值, 赋值给父级编码
                if (pro_type.length() == 2) {
                    levelno = "3";
                } else if (pro_type.length() == 3) {
                    levelno = "4";
                }
            }
            if ("01".equals(pro_type)) {
                proelement = "01";
            }
            querysql += " and t.superid ='" + superid + "' and levelno ='"+levelno+"'";
            String key = agencyguid+"#"+pro_name+"#"+superid+"#"+levelno;
            if (datasmap.containsKey(key)){
                continue;
            }else {
                List<Map<String, Object>> datas = this.getDatas("v_perf_t_indexcomfunc", querysql, "");
                if (datas.size() <= 0) {
                    String province = CommonUtil.getProvince();
                    String year = CommonUtil.getYear();
                    String timestamps = PerfUtil.getServerTimeStamp();
                    ZjTempDataBO zjTempDataBO = (ZjTempDataBO) ServiceFactory.getBean("pmkpi.setting.zjdataset.ZjTempDataBOTX");
                    HashMap<String, Object> params = new HashMap<>();
                    HashMap<String, Object> datamap = new HashMap<>();
                    params.put("agency", agencyguid);
                    String code = zjTempDataBO.getMaxcode(params);
                    int num = Integer.valueOf(code).intValue();
                    num = num+(i-2);
                    code = new DecimalFormat("00000").format(num);
                    code = province + agencyguid + code;
                    datamap.put("guid", this.getCreateguid());
                    datamap.put("code", code);
                    datamap.put("name", pro_name);
                    datamap.put("ordernum", code.substring(code.length() - 5));
                    datamap.put("superid", superid);
                    datamap.put("levelno", levelno);
                    datamap.put("proelement", proelement);
                    datamap.put("dept", deptcode);
                    datamap.put("agencyguid", agencyguid);
                    datamap.put("createtime", timestamps);
                    datamap.put("updatetime", timestamps);
                    datamap.put("province", province);
                    datamap.put("year", year);
                    datamap.put("status", 1);
                    datalist.add(datamap);
                    datasmap.put(key, datalist);
                }
            }
        }
        //数据保存到码表
        if (datalist.size() > 0) {
            indexRpDAO.saveAll(datalist, "v_perf_t_indexcomfunc");
        }
    }

    /**
     * 删除项目
     *
     * @param parms --
     * @return
     */
    public Map<String, Object> delpro(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<>();
        String treeid = (String) parms.get("treeid");
        try {
            List<String> guids = new ArrayList<>();
            //删除所有下级 如删除一级项目包括二级项目和二级项目下指标
            String sql = "select distinct t.guid from v_perf_t_indexcomfunc t start with guid = '" + treeid + "' CONNECT BY PRIOR guid = superid";
            List<Map<String, Object>> list = indexRpDAO.queryForList(sql);
            if (list != null && list.size()>0){
                for (int i = 0;i<list.size();i++){
                    Map<String, Object> map = list.get(i);
                    //需要删除的项目guid
                    String guid = (String) map.get("guid");
                    guids.add(guid);
                }
            }
            //删除项目
            String insql = indexRpDAO.createInSql("guid", guids);
            indexRpDAO.delDatas("v_perf_t_indexcomfunc",insql);
            //删除项目下指标
            insql = indexRpDAO.createInSql("pro_name", guids);
            StringBuffer sb = new StringBuffer();
            sb.append(" framesystem = 'PM001' and is_common_ind <> 1 and agency_code is not null");
            sb.append(" and ").append(insql);
            indexRpDAO.updateIsDeleteDatas(indexRpDAO.PMKPI_TABLE_BASE_INDEX,sb.toString());
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

}
