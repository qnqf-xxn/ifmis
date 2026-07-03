package gov.mof.fasp2.pmkpi.setting.indexlib.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.dto.DataSetDTO;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.lang.StringUtils;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 14:53 2020/8/17  chongdayong
 */
public class IndexQueryBO extends PmkpiBO {

    private IndexQueryDAO indexQueryDAO;

    @Resource(name = "pmkpi.setting.indexlib.query.IndexQueryDAO")
    public void setIndexQueryDAO(IndexQueryDAO indexQueryDAO) {
        this.indexQueryDAO = indexQueryDAO;
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
            String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1");
            logger.debug("获取左侧树权限的："+datarule);
            wheresql.append(datarule);
        }
        List<DicRangeDTO> value = PerfUtil.getSourceData(lefttabtype, wheresql.toString());
        if ("INDEXCOMFUNC_HuBei".equals(lefttabtype)){ //湖北添加项目分类.
            StringBuffer commonsql = new StringBuffer(" select t.*,superid as superguid,'1' as rowtype from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87'");
            commonsql.append(" order by t.ordernum");
            List commdar= indexQueryDAO.queryForList(commonsql.toString());
            value.addAll(commdar);
        }
        if ("INDEXCOMFUNC_SX".equals(lefttabtype)){ //山西追加指标模板分类.
            StringBuffer commonsql = new StringBuffer(" select t.*,superid as superguid,'1' as rowtype from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87' and proelement in ('sx00','sx01')");
            commonsql.append(" order by t.ordernum");
            List commdar= indexQueryDAO.queryForList(commonsql.toString());
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
     * 分页查询.
     *
     * @param sqlmap -- sql.
     * @return
     * @throws AppException -- 自定义.
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String tabtype = (String) sqlmap.get("tabtype");
        String menuid = (String) sqlmap.get("menuid"); //菜单guid.
        String treeid = (String) sqlmap.get("treeid");
        String indextype = (String) sqlmap.get("indextype"); //区分财政还是部门
        String querySql = (String) sqlmap.get("querySql");
        String tableSql = (String) sqlmap.get("tablesql");
        String sxflag = (String) sqlmap.get("sxflag");//山西查询标识(省级指标，市级指标，县级指标)
        String isleaf = sqlmap.get("isleaf") + "";
        String isSx = PerfUtil.getSystemSet("isSX");
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
                List<Map<String, Object>> list = indexQueryDAO.getElementDatas(treeid, dissql);
                indexQueryDAO.saveAll(list, indexQueryDAO.PMKPI_TABLE_TMP_AGENCY);
                wheresql.append(" exists ( select 1 from ").append(indexQueryDAO.PMKPI_TABLE_TMP_AGENCY).append(" a where a.guid =t.projtype) ");
            } else {
                wheresql.append(" exists(select 1 from( ").append(dissql).append(") a where t.projtype=a.guid)");
            }
            wheresql.append(" and is_common_ind = '1'");
        } else if (indextype != null && "finance".equals(indextype) && tabtype != null && ("INDEXCOMFUNC_JiangXi".equals(tabtype) || "INDEXCOMFUNC".equals(tabtype) || "INDEXTRANPAY".equals(tabtype))) { //财政个性
            String col = "";
            wheresql.append(" is_common_ind = '2' and ");
            if ("INDEXCOMFUNC".equals(tabtype)) {
                col = "industrycategory";
            } else if ("INDEXTRANPAY".equals(tabtype)){
                col = tabtype;
            } else if ("INDEXCOMFUNC_JiangXi".equals(tabtype)){
                col = "occupation";
            }
            if (isleaf != null && "1".equals(isleaf)) {
                wheresql.append(col).append(" ='").append(treeid).append("' and ");
            } else if (treeid != null && !"treeroot".equals(treeid)) {
                List<Map<String, Object>> list = indexQueryDAO.getElementDatas(treeid, dissql);
                indexQueryDAO.saveAll(list, indexQueryDAO.PMKPI_TABLE_TMP_AGENCY);
                wheresql.append(" exists ( select 1 from ").append(indexQueryDAO.PMKPI_TABLE_TMP_AGENCY).append(" a where a.guid =t.").append(col).append(") and ");
            }
            //else {
                //wheresql.append(" exists(select 1 from (").append(dissql).append(")a where t.").append(col).append("=a.guid)");
            //}
            wheresql.append("  agency_code is null");
        } else { //部门指标库
            if (isleaf != null && "1".equals(isleaf)) {
                if ("PMKPIDEPT".equals(tabtype) || "PMKPIAGENCYALLPAY".equals(tabtype)) {
                    wheresql.append(" agencyguid='").append(treeid).append("'");
                    wheresql.append(" and framesystem = 'DEPT'"); //部门整体的添加过滤
                } else {
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
                    } else {
                        wheresql.append(" pro_name='").append(treeid).append("'");
                    }
                    wheresql.append(" and t.framesystem = 'PM001'");
                } else if (PerfUtil.getIsSx() && tabtype != null && "INDEXCOMFUNC_SX".equals(tabtype)){ //山西
                    String datarule = this.getDataRuleByMenuguid(menuid, "t", "1=1");
                    logger.debug("获取左侧树权限的："+datarule);
                    String disssql = "select t.guid,t.code,t.name,t.SUPERID superguid,t.SUPERID,t.levelno,t.AGENCYGUID,t.isleaf,t.PROVINCE,t.status," +
                            "'indexdept' as mogamisuperid from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87' and proelement in ('sx00','sx01') union all select t.* from v_perf_t_indexcomfunc_sx t where "+datarule;
                    List<Map<String, Object>> elelist = indexQueryDAO.getElementDatas(treeid, disssql);
                    indexQueryDAO.saveAll(elelist, "PERF_TMP_GUIDS");
                    wheresql.append(" exists ( select 1 from PERF_TMP_GUIDS a where a.guid =t.industrycategory) ");
                    wheresql.append(" and t.framesystem = 'PM001'"); //项目支出的添加过滤
                } else {
                    List<Map<String, Object>> list = indexQueryDAO.getElementDatas(treeid, dissql);
                    indexQueryDAO.saveAll(list, indexQueryDAO.PMKPI_TABLE_TMP_AGENCY);
                    wheresql.append(" exists ( select 1 from ").append(indexQueryDAO.PMKPI_TABLE_TMP_AGENCY);
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
            wheresql.append(" and is_common_ind = '2' and agency_code is not null");
            String datarule = this.getDataRuleByMenuguidNull(menuid, "m", null);
            datarule = datarule.replace("m.agencyguid", "m.guid");
            wheresql.append(" and exists(select 1 from pmkpi_fasp_t_pubagency m where m.guid=t.agency_code ").append(datarule).append(") ");
        }
        String province = SecureUtil.getUserSelectProvince();//当前登录区划
        String sxsql = indexQueryDAO.getsxsql(province,sxflag);
        String sql = "select t.* from " + indexQueryDAO.PMKPI_TABLE_BASE_INDEX + " t where ";
        if(PerfUtil.getIS_HUBEI()){
            //湖北指标列表查询失败  报错‘无法解析的成员访问表达式[A.ELE_CODE]’ 达梦给出的解决方案 查询sql添加  /*+VIEW_PULLUP_FLAG(0)*/
            /*BAS_PERF_V_INDICATOR：湖北查询视图*/
            sql = "select /*+VIEW_PULLUP_FLAG(0)*/ t.* from BAS_PERF_V_INDICATOR t where ";
        }
        if (!StringUtil.isEmpty(isSx) && "1".equals(isSx)) {//山西环境查询不分区指标表(区县可查看市级指标,地市可查看省级指标)
            sql = "select t.* from BAS_PERF_INDICATOR t where is_deleted =2 ";
            if (!StringUtil.isEmpty(sxsql)) {
                sql += sxsql + " and ";
            }
        }
        if (querySql != null && !querySql.isEmpty()) {
            wheresql.append(" and (").append(querySql).append(")");
        }
        if (tableSql != null && !tableSql.isEmpty()) {
            wheresql.append(" and ").append(tableSql);
        }
        if (wheresql != null && !wheresql.toString().isEmpty()) {
            sql += wheresql;
        }
        sql += " order by t.findex,t.sindex,t.perf_ind_code";
        return sql;
    }

}
