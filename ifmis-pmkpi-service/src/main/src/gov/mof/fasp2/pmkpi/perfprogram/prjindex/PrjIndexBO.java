
package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.dto.DataSetDTO;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprogram.beforeview.BeforeviewDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.lang.StringUtils;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;


/**
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-1-6 上午10:41:23
 * @ClassName: PrjIndexBO
 * @Description: Description of this class
 */

public class PrjIndexBO extends PmkpiBO {
    /**
     * prjIndexDAO.
     */
    private PrjIndexDAO prjIndexDAO;

    /**
     * 注入dao.
     *
     * @param prjIndexDAO --prjIndexDAO.
     * @throws
     */
    public void setPrjIndexDAO(PrjIndexDAO prjIndexDAO) {
        this.prjIndexDAO = prjIndexDAO;
    }

    /**
     * 查询各年度数据.
     *
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws --           异常.
     */
    public Map<String, Object> findYearIndexs(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String selectbillguid = (String) params.get("selectbillguid");//调整前的guid
        String adjadd = (String) params.get("adjadd");//是否调整
        List<Map<String, Object>> indexs = null;
        if (adjadd != null && "1".equals(adjadd)) {
            indexs = prjIndexDAO.findIndexs(proguid, "v_pm_perf_indicator", null);
            if (indexs.size() == 0) {
                indexs = prjIndexDAO.findIndexs(selectbillguid, "v_pm_perf_indicator", null);
            }
        } else {
            indexs = prjIndexDAO.findIndexs(proguid, "v_pm_perf_indicator", null);
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
        List<Map<String, Object>> nullTemp = prjIndexDAO.findNullTemp(proguid); //空指标模板
        List<Map<String, Object>> fixedIndexTemp = prjIndexDAO.getProFixedIndexData(proguid,"0"); //获取固化指标
        nullTemp.addAll(fixedIndexTemp);
        List<Map<String, Object>> backindex = new ArrayList<Map<String, Object>>(); //返回指标
        for (Map<String, Object> map : nullTemp) {
            sindex = (String) map.get("sindex");
            map.put("guid", this.getCreateguid());
            map.put("is_add", "2");
            map.put("zqindexval", "");
            map.put("zqmeterunit", "");
            map.put("zqcomputesign", "");
            map.put("adjoption", "");
            map.put("options", "");
            keycode = sindex;
            if (indexMap.containsKey(keycode)) {
                tempList = indexMap.get(keycode);
                backindex.addAll(tempList);
            } else {
                backindex.add(map);
                for (Map<String, Object> bacmap : backindex) {
                    for (int i = 0; i < diccolumn.size(); i++) {
                        String col = (String) diccolumn.get(i);
                        if (!bacmap.containsKey(col)) {
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
     * 挑选指标走此，分页.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     *
     * @param sqlmap
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        StringBuffer sql = new StringBuffer();
        String selectedAuth = (String) sqlmap.get("selectedAuth");
        String filer = (String) sqlmap.get("filter");
        String sindex = (String) sqlmap.get("sindex");//二级指标.
        String saveAgency = (String) sqlmap.get("saveAgency");
        String pagetype = (String) sqlmap.get("pagetype"); //指标查询类型
        String proguid = (String) sqlmap.get("proguid"); //指标查询类型
        String isZJ = PerfUtil.getSystemSet("isZJ");
        String isSx = PerfUtil.getSystemSet("isSX");
        String superguid = (String) sqlmap.get("superguid");
        String mogamisuperid = (String) sqlmap.get("mogamisuperid");
        //String sxflag = (String) sqlmap.get("sxflag");
        String province = CommonUtil.getProvince();//当前登录区划
        String targetprovince = province;
        String year = SecureUtil.getYear();//当前登录年度
        if (selectedAuth != null && "01".equals(selectedAuth)) {
            targetprovince = province.substring(0, 2) + "0000000";//省级区划
        } else if (selectedAuth != null && "02".equals(selectedAuth)) {
            targetprovince = province.substring(0, 4) + "00000";//市级区划
        }
        String procode = (String) sqlmap.get("procode");
        String levelno = sqlmap.get("levelno") == null ? null : sqlmap.get("levelno").toString();
        String agencyguid = (String) sqlmap.get("agencyguid");

        if (pagetype != null && "lastindex".equals(pagetype)) {
            //新增逻辑 根据参数判断是否根据上年项目关系查询
            String ismultipro = (String) sqlmap.get("ismultipro");//多项目
            sql.append(" select t.*,'' as obligate1 from pm_perf_indicator t where t.yearflag = '0' and t.is_backup=2 and t.is_deleted=2 and sub_mof_div_code is null ");
            /*if (StringUtils.isNotBlank(isSx) && "1".equals(isSx)) {
                sql.append(sxsql);
            } else {*/
                sql.append(" and t.province = '").append(SecureUtil.getUserSelectProvince()).append("' ");
            //}
            sql.append(" and year = '").append(SecureUtil.getUserSelectYear() - 1).append("'");
            if (PerfUtil.getProgramIsyear()) {
                sql.append(" and nvl(is_adj, 2) = 2 ");
            }
            //新增逻辑 根据参数判断是否根据上年项目关系查询
            if(!StringUtil.isNullOrEmpty(ismultipro) && "1".equals(ismultipro)){
                List<Map<String, Object>> bgtprolastyearlist = prjIndexDAO.getDatas("v_perf_bgtprolastyear", "pro_code = '"+procode+"'",null);
                List<Map<String, Object>> prolastyearlist = prjIndexDAO.getDatas("v_perf_prolastyear", "pro_code = '"+procode+"'",null);
                prolastyearlist.addAll(bgtprolastyearlist);
                List<String> procodes = prolastyearlist.stream().map(map -> (String) map.get("last_pro_code")).collect(Collectors.toList());
                if(procodes.size()>0){
                    String multiprosql = prjIndexDAO.createInSql("pro_code", procodes);
                    sql.append(" and ").append(multiprosql);
                }else{
                    sql.append(" and 1<>1 ");
                }
            }else{
                sql.append(" and pro_code = '").append(procode).append("'");
            }
        } else if (pagetype != null && "totalindex".equals(pagetype)) {
            sql.append(" select t.*,'' as obligate1 from pm_perf_indicator t where t.yearflag = '1' and t.is_backup=2 and t.is_deleted=2 and sub_mof_div_code is null ");
            sql.append(" and t.province = '").append(SecureUtil.getUserSelectProvince()).append("' ");
            sql.append(" and mainguid = '").append(proguid).append("'");
        } else {
            /*if (StringUtils.isNotBlank(isSx) && "1".equals(isSx)) {
                sql.append(" select * from BAS_PERF_INDICATOR t where t.is_deleted = 2 ");
                sql.append(sxsql);
            } else {*/
                if (selectedAuth != null && ("01".equals(selectedAuth) || "02".equals(selectedAuth))) {//授权共享指标处理
                    sql.append(" select * from BAS_PERF_INDICATOR t where t.is_deleted = 2 ");
                    sql.append(" and province = '" + targetprovince + "'");
                } else {//非授权和本级指标
                    sql.append(" select * from V_BAS_PERF_INDICATOR t where 1=1 ");
                }
            //}
            if ("pickindex".equals(pagetype)) { //挑选指标才添加二级
                sql.append(" and (t.agency_code is null or (t.agency_code = '");
                sql.append(saveAgency);
                sql.append("' and t.wfstatus = '011')  )");
                if (StringUtils.isNotBlank(sindex)) {
                    sql.append(" and t.sindex = '").append(sindex).append("'");
                }
            } else { //指标推荐
                IDataSetService dss = PerfServiceFactory.getIDataSetService();
                String guid = (String) sqlmap.get("guid"); //推荐指标中,左侧树选中节点
                String iscommon = (String) sqlmap.get("iscommon");
                int isleaf = PerfUtil.mapGetInt(sqlmap, "isleaf");//是否末级节点
                DataSetDTO ds = null;
                //通版非末级添加数据源过滤条件
                if ("idexcomcls".equals(guid) || "indexcomfunc".equals(guid) || "indextranpay".equals(guid)) {
                    ds = dss.getDataSetByElementCode(guid.toLowerCase());
                    String dswheresql = "";
                    if (ds != null) {
                        dswheresql = (String) ds.get("datasource");
                    }
                    String col = "";
                    if ("idexcomcls".equals(guid)) {
                        col = "projtype";
                    } else if ("indexcomfunc".equals(guid)){
                        if (PerfUtil.get_IsJiangXi()){
                            col = "occupation"; //活动.
                        } else {
                            col = "industrycategory";
                        }
                    } else if ("indextranpay".equals(guid)){
                        col = "indextranpay";
                    }
                    if (!StringUtil.isEmpty(dswheresql)) {
                        sql.append(" and exists(select 1 from( ").append(dswheresql).append(") a where t.").append(col).append("=a.guid)");
                    }
                }
                if (StringUtils.isNotBlank(iscommon) && "1".equals(iscommon)) {//共性指标
                    sql.append(" and t.is_common_ind = '1'");
                    if (StringUtils.isNotBlank(guid) && !"idexcomcls".equals(guid)) {
                        sql.append(" and t.projtype= '").append(guid).append("'");
                    }
                    sql.append(" and t.agencyguid is null");
                } else { //个性或者部门.
                    sql.append(" and nvl(t.is_common_ind,'0') <> '1'");
                    if (guid.startsWith("indexdept")) {
                        guid = guid.substring(9);
                    }
                    if (StringUtils.isNotBlank(isZJ) && "1".equals(isZJ)) { //浙江湖北只查询子节点，不查询根据上级项目下所有项目的指标.
                        if ("2".equals(levelno)) {
                            sql.append(" and t.agency_code = substr('" + agencyguid + "',0,3) ");
                        } else if ("3".equals(levelno)) {
                            sql.append(" and t.agency_code= '").append(agencyguid).append("'");
                        } else if ("4".equals(levelno)) {
                            sql.append(" and t.indexcategories= '").append(guid).append("'");
                        } else if ("5".equals(levelno)) {
                            sql.append(" and t.industrycategory= '").append(guid).append("'");
                        }
                    } else if (PerfUtil.getIS_HUBEI()) {
                        if ("1".equals(levelno) && "indexdept".equals(mogamisuperid)) { //03-部门指标 节点
                            sql.append(" and t.pro_type is not null ");
                        }else if ("2".equals(levelno) && "indexdept".equals(mogamisuperid)) {
                            if("01".equals(guid)){ //03-01-项目支出 节点
                                sql.append(" and t.pro_type = '").append(guid).append("'");
                            }else if ("02".equals(guid)){ //03-02-转移支付 节点
                                sql.append(" and t.pro_type in ('021','022','023') ");
                            }
                        }else if ("3".equals(levelno) && "indexdept".equals(mogamisuperid) && "02".equals(superguid)) { //03-02-(021/022/023) 节点
                            sql.append(" and t.pro_type = '").append(guid).append("'");
                        }else{
                            sql.append(" and t.pro_name = '").append(guid).append("'");
                        }
                    } else if (PerfUtil.getIsSx()){ //山西 只查询末级节点自定义分类
                        if (isleaf == 1) {
                            sql.append(" and t.industrycategory= '").append(guid).append("'");
                        }else if (!"indexcomfunc".equals(guid) && !"indexdept".equals(guid) && !"indextranpay".equals(guid)){
                            List<Map<String, Object>> elelist = new ArrayList<>();
                            ds = dss.getDataSetByElementCode("INDEXCOMFUNC");
                            String dissql = (String) ds.get("datasource");
                            if(mogamisuperid != null && mogamisuperid.equals("indexdept")){
                                agencyguid = CommonUtil.getCurrentUser().getAgency();
                                dissql = "select t.* from v_perf_t_indexcomfunc_sxall t where perf_fundpay_view.set_agencyguid('"+agencyguid+"')='"+agencyguid+"'";
                            }
                            if(StringUtils.isEmpty(guid)){
                                elelist = prjIndexDAO.queryForList(dissql);
                            }else{
                                elelist = prjIndexDAO.getElementDatas(guid, dissql);
                            }
                            prjIndexDAO.saveAll(elelist, "PERF_TMP_GUIDS");
                            sql.append(" and  exists ( select 1 from PERF_TMP_GUIDS a where a.guid =t.industrycategory) ");
                        }
                    } else if ("indextranpay".equals(superguid)){
                        if (isleaf == 1) {
                            sql.append(" and t.indextranpay= '").append(guid).append("'");
                        }
                    } else if (PerfUtil.get_IsJiangXi()) {
                        if ("2".equals(levelno)) {
                            sql.append(" and t.indexcategories= '").append(guid).append("'");
                        } else if ("3".equals(levelno)) {
                            sql.append(" and t.industrycategory= '").append(guid).append("'");
                        } else if ("4".equals(levelno)) {
                            sql.append(" and t.indexcategory= '").append(guid).append("'");
                        } else if ("5".equals(levelno)) {
                            sql.append(" and t.filed= '").append(guid).append("'");
                        } else if ("6".equals(levelno)) {
                            sql.append(" and t.occupation= '").append(guid).append("'");
                        }
                    } else { //通用版本个性指标+部门指标
                        if (isleaf == 1) {
                            sql.append(" and t.industrycategory= '").append(guid).append("'");
                        } else if (!"indexcomfunc".equals(guid) && !"indexdept".equals(guid) && !"indextranpay".equals(guid)) {
                            String elementCode = "INDEXCOMFUNC";
                            List<Map<String, Object>> elelist = new ArrayList<>();
                            if (selectedAuth != null && ("01".equals(selectedAuth) || "02".equals(selectedAuth))) {//授权共享指标处理-获取授权区划的数据源
                                elementCode = "INDEXCOMFUNCAUTH";
                                ds = dss.getDataSetByElementCode(elementCode);
                                String dissql = (String) ds.get("datasource");
                                StringBuffer rsql = new StringBuffer();
                                rsql.append(" select distinct t.* from (" + dissql + ") t ");
                                rsql.append(" where PERF_AUTHPROVINCE_VIEW.set_province('" + targetprovince + "') = '" + targetprovince + "' and PERF_AUTHPROVINCE_VIEW.set_year('" + year + "') = '" + year + "'");
                                rsql.append(" start with  t.guid='").append(guid).append("'");
                                rsql.append(" connect by prior t.guid = t.superid");
                                rsql.append(" order by code ");
                                elelist = prjIndexDAO.queryForList(rsql.toString());
                            } else {
                                ds = dss.getDataSetByElementCode(elementCode);
                                String dissql = (String) ds.get("datasource");
                                if(StringUtils.isEmpty(guid)){ // 通版-03部门指标：展示所有部门的指标
                                    elelist = prjIndexDAO.queryForList(dissql);
                                }else{
                                    elelist = prjIndexDAO.getElementDatas(guid, dissql);
                                }
                            }
                            prjIndexDAO.saveAll(elelist, "PERF_TMP_GUIDS");
                            sql.append(" and  exists ( select 1 from PERF_TMP_GUIDS a where a.guid =t.industrycategory) ");
                        }
                    }
                    if (mogamisuperid != null && mogamisuperid.equals("indexdept")) {// 部门指标都带有额外的属性mogamisuperid
                        if (selectedAuth != null && ("01".equals(selectedAuth) || "02".equals(selectedAuth))) {//授权共享指标处理-全部权限
                            sql.append(" and 1=1");
                        } else {
                            /*if (StringUtils.isNotBlank(isSx) && "1".equals(isSx)) {
                                if (StringUtils.isNotBlank(sxsql) && sxsql.indexOf(province) == -1) {//非本区划(山西环境 部门指标不可查看非本区划指标  只有财政指标可查看省级 市级指标)
                                    sql.append(" and 1<>1");
                                }
                            }*/
                            String datasql = this.getDataRuleByMenuguid(prjIndexDAO.PMKPI_PRJ_MENUID, "m", null);
                            String tempsql = " and  m.guid = '" + CommonUtil.getCurrentUser().getAgency() + "'";
                            datasql = datasql.replace("m.agencyguid", "m.guid"); //这块是否可以直接优化，替换为agency_code?
                            String datarule = "";
                            if (tempsql.equals(datasql) && !StringUtil.isEmpty(CommonUtil.getCurrentUser().getAgency()) && CommonUtil.getCurrentUser().getAgency().length() > 2) { //本单位权限，处理为，单位以及上级部门.
                                datarule = " and (m.guid = '" + CommonUtil.getCurrentUser().getAgency() + "' or m.guid = '" + CommonUtil.getCurrentUser().getAgency().substring(0, 3) + "') ";
                            } else {
                                datarule = datasql;
                            }
                            sql.append(" and exists(select 1 from pmkpi_fasp_t_pubagency m  where 1=1 ").append(datarule);
                            if ("1".equals(isZJ)) {
                                sql.append(" and m.guid=substr(t.agency_code,0,3)) ");
                            } else {
                                sql.append(" and m.guid=t.agency_code) ");
                            }
                        }
                        sql.append(" and t.wfstatus = '011' ");
                    } else {
                        sql.append(" and t.agencyguid is null");
                    }
                }
            }
        }
        if(!"lastindex".equals(pagetype) && !"totalindex".equals(pagetype)){ // 参考历年指标 不进入
            sql.append(" and t.framesystem = 'PM001'");
        }
        if (!StringUtil.isEmpty(filer)) {
            sql.append("  and ").append(filer);
        }
        sql.append(" order by findex,sindex,ordernum");
        logger.info("部门指标推荐查询列表sql：" + sql);
        return sql.toString();
    }

    /**
     * 推荐指标,查询左侧案例模板指标.
     *
     * @param config --参数配置.
     * @return
     * @throws AppException -- 异常.
     * @throws
     */
    public Map finTreeData(HashMap config) throws AppException {
        String province = CommonUtil.getProvince();//当前登录区划
        String year = SecureUtil.getYear();//当前登录年度
        String selectedAuth = (String) config.get("selectedAuth");//指标库授权类型
        String authTreeString = getAuthTree(province,selectedAuth);
        String tprovince = province.substring(0,2)+"0000000";//省级区划
        String sprovince = province.substring(0,4)+"00000";//市级区划
        String targetprovince = province;
        if("01".equals(selectedAuth)){
            targetprovince = tprovince;
        }else if("02".equals(selectedAuth)){
            targetprovince = sprovince;
        }
        String tabcode = (String) config.get("tabcode");
        String elementcode = "INDEXCOMFUNC";
        String tabfilter = (String) config.get("tabfilter");//页签配置的过滤
        String condition = (String) config.get("condition");//过滤条件
        //String sxflag = (String) config.get("sxflag");//山西查询标识(省级指标，市级指标，县级指标)
        String tablecode = "";
        String wheredatarule = "";
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List listdept = new ArrayList();
        if (tabcode != null && "case".equals(tabcode)) {
            tablecode = "perf_v_case";
            condition = " and t.bustype = 'PM001'";
            //and t.province='" + province + "' and t.wfstatus='011' and t.is_deleted=2 and t.status <> '3'";
            if (!StringUtil.isEmpty(CommonUtil.getCurrentUser().getAgency()) && CommonUtil.getCurrentUser().getAgency().length() > 2) { //本单位权限，处理为，单位以及上级部门.
                condition += " and (t.agencyguid = '"+CommonUtil.getCurrentUser().getAgency()+"' or t.agencyguid = '"+CommonUtil.getCurrentUser().getAgency().substring(0,3)+"') ";
            }
        } else if (tabcode != null && "mode".equals(tabcode)) {
            tablecode = "v_perf_t_model";
            condition = " and framesystem = 'PM001'";
        } else if (tabcode != null && "index".equals(tabcode)) {
            String isZJ = PerfUtil.getSystemSet("isZJ");
            tablecode = "v_perf_t_index";
            String sql = " 1 =1";
            String datasql = this.getDataRuleByMenuguid(prjIndexDAO.PMKPI_PRJ_MENUID, "t", null);
            String tempsql = " and  t.agencyguid = '"+CommonUtil.getCurrentUser().getAgency()+"'";
            if (tempsql.equals(datasql) && !StringUtil.isEmpty(CommonUtil.getCurrentUser().getAgency()) && CommonUtil.getCurrentUser().getAgency().length() > 2) { //本单位权限，处理为，单位以及上级部门.
                sql += " and (t.agencyguid = '"+CommonUtil.getCurrentUser().getAgency()+"' or t.agencyguid = '"+CommonUtil.getCurrentUser().getAgency().substring(0,3)+"') ";
            }else{
                sql += datasql;
            }
            logger.info("============================权限sql"+sql);
            boolean havelistdept = false;//是否处理03部门指标
            if(selectedAuth!=null && ("01".equals(selectedAuth) || "02".equals(selectedAuth))){
                tablecode = "v_perf_t_indexauth";
                //拼接授权的左侧树条件
                condition = " and ((t.code in ("+authTreeString+") and levelno =1) or exists (select a.code from "+tablecode+" a where a.guid = t.guid " +
                        "start with superguid in (select guid from "+tablecode+" where code in ("+authTreeString+") and levelno =1 )connect by prior guid = superguid)";
                condition += ") and PERF_AUTHPROVINCE_VIEW.set_province('"+ targetprovince +"') = '"+ targetprovince +"' and PERF_AUTHPROVINCE_VIEW.set_year('"+ year +"') = '"+ year +"'";
                if(authTreeString!=null && authTreeString.contains("03")){
                    //授权包含03部门
                    havelistdept = true;
                }
            }
            if (StringUtils.isNotBlank(isZJ)  && "1".equals(isZJ)){ //广西和湖北走数据权限,直接查询项目，不根据指标表过滤左侧树.
                List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("INDEXCOMFUNC_ZJ", sql);
                //处理一级节点的父级是部门指标indexdept
                for (Map<String, Object> map : eledatas) {
                    if ("02".equals(map.get("superid"))){
                        map.put("superid","indexdept");
                        map.put("superguid","indexdept");
                    }
                }
                listdept = prjIndexDAO.deptNodes();
                listdept.addAll(eledatas);
            } else if (PerfUtil.getIS_HUBEI()) {
                List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("INDEXCOMFUNC_HuBei", sql);
                listdept = prjIndexDAO.deptNodes();
                listdept.addAll(eledatas);
            }else if (PerfUtil.get_IsJiangXi()) { //江西部门展示分行业领域. --INDEXCATEGORIES,INDUSTRYCATEGORY,INDEXCATEGORY,FILED,OCCUPATION
                StringBuffer elessql = new StringBuffer(" select t.occupation as guid from V_BAS_PERF_INDICATOR t where t.wfstatus = '011'");
                elessql.append(" and t.is_common_ind = '2' and t.occupation is not null ").append(" and ").append(sql);
                List eledatas = prjIndexDAO.queryForList(elessql.toString());
                listdept = prjIndexDAO.finDeptJxTreeData(eledatas);
            } else if (PerfUtil.getIsSx()) {
                List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("INDEXCOMFUNC_SX", sql);
                listdept = prjIndexDAO.deptNodes();
                listdept.addAll(eledatas);
            } else { //通用的
                if(selectedAuth!=null && ("01".equals(selectedAuth) || "02".equals(selectedAuth))){
                    if(havelistdept){//授权部门指标全部权限左侧树
                        listdept = prjIndexDAO.finAuthDeptTreeData(targetprovince,year);
                    }
                }else{//根据指标库权限数据来反推过滤左侧树
                    /*String sysvalue = "PMKPIAGENCYALLPAY"; //没有配置默认单位
                    List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(sysvalue, sql);*/
                    StringBuffer elessql = new StringBuffer(" select t.industrycategory as guid from V_BAS_PERF_INDICATOR t where t.wfstatus = '011'");
                    elessql.append(" and t.IS_COMMON_IND = '2' and t.industrycategory is not null ").append(" and ").append(sql);
                    List eledatas = prjIndexDAO.queryForList(elessql.toString());
                    listdept = prjIndexDAO.finDeptTreeData(elementcode, eledatas);
                }
            }
        } else {
            logger.debug("请配置对应的选择页签!");
        }
        String isSx = PerfUtil.getSystemSet("isSX");
        //String sxsql = prjIndexDAO.getsxsql(province,sxflag);
        //上面的获取condition条件为空时，condition为null，执行下面的+=会变成null + 条件。
        //所以判断是否为null，为null赋值为"";
        if(condition==null){
            condition = "";
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            condition += tabfilter;
        }
        if(!StringUtil.isEmpty(wheredatarule)){
            condition += wheredatarule;
        }
        /*if(StringUtils.isNotBlank(isSx) && "1".equals(isSx) && !StringUtil.isEmpty(sxsql) && tabcode != null && !"index".equals(tabcode)){
            if("case".equals(tabcode)){//案例
                tablecode = "perf_t_case";
            }else if("mode".equals(tabcode)){//模板
                tablecode = "perf_t_model";
            }
            condition += sxsql;
        }*/
        List<Map<String, Object>> list = prjIndexDAO.finTreeData(tablecode, condition);
        //处理财政个性指标分类授权给部门
        String isGiveDept = PerfUtil.getSystemSet("INDEXFINAGIVEDEPT");
        if (StringUtils.isNotBlank(isGiveDept) && "1".equals(isGiveDept) && tabcode != null && "index".equals(tabcode)){
            String  dept = CommonUtil.getCurrentUser().getAgency();
            int usertype = CommonUtil.getCurrentUser().getUsertype();
            if (StringUtils.isNotBlank(isGiveDept) &&( 0 == usertype || 2 == usertype)){
                List backList = new ArrayList(); //返回值
                dept = dept.substring(0,3);
                String tempguid = "";
                String givecode = "";
                String is_common_ind = "";
                //int isleaf = 0;
                String superid =""; //父指标
                List<String> superList = new ArrayList<>();
                List<Map<String, Object>> givecodes = prjIndexDAO.getDatas("V_PERF_T_INDEXFINAGIVE", " agencyguid = '" + dept +"'", null);
                if (givecodes.size() > 0){
                    for (Map<String, Object> map : list) {
                        tempguid = (String) map.get("guid");
                        superid = (String) map.get("superid"); //父级
                        is_common_ind = (String) map.get("is_common_ind"); //1共性 0个性
                        // 推荐指标有isleaf字段。案例、模板都没有isleaf字段
                        //isleaf = PerfUtil.mapGetInt(map,"isleaf");
                        if ("0".equals(is_common_ind) && !StringUtil.isEmpty(superid) && !"indexcomfunc".equals(superid) && !"#".equals(superid)){
                            for (Map<String, Object> givemap : givecodes) {
                                givecode = (String) givemap.get("eltwoguid");
                                if (tempguid.equals(givecode)){
                                    backList.add(map);
                                    superList.add(superid);
                                }
                            }
                        } else if ("1".equals(is_common_ind) || "#".equals(superid)){
                            backList.add(map);
                        }
                    }
                    //从list中拿父节点
                    for (Map<String, Object> map : list) {
                        tempguid = (String) map.get("guid");
                        if (superList.contains(tempguid)){
                            backList.add(map);
                        }
                    }
                    list = backList;
                }
            }
        }
        list.addAll(listdept);
        HashMap map = new HashMap();
        PerfUtil.listMapSort(list, null, "code");
        //如果是江西处理层级>3的不展示编码
        if (PerfUtil.get_IsJiangXi() && "index".equals(tabcode)) { //江西添加项目分类,只能活动去掉编码.
            list.forEach(r->{
                if (Integer.parseInt(r.get("levelno").toString()) > 4){
                    r.put("code","");
                }
            });
        }
        try {
            map.put("datalist", JsonUtils.ListToRecordSet(list));
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
        return map;
    }

    /**
     * 查询案例和模板的明细数据.
     *
     * @param params -- 参数.
     * @return tempMap -- 返回参数.
     * @throws AppException -- 异常.
     * @throws
     */
    public Map<String, Object> findTableData(Map<String, Object> params) throws AppException {
        Map<String, Object> tempMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid"); //主键
        String showtab = (String) params.get("showtab");
        String tabcode = (String) params.get("tabcode");
        //String sxflag = (String) params.get("sxflag");
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        List<Map<String, Object>> indexs = null;
        String filter = (String) params.get("filter");
//        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        //String province = SecureUtil.getUserSelectProvince();//当前登录区划
        //String isSx = PerfUtil.getSystemSet("isSX");
        String wheresql = "";
        //String sxsql = prjIndexDAO.getsxsql(province,sxflag);
        if (showtab != null && ("1".equals(showtab) || "3".equals(showtab))) {
            /*if (StringUtils.isNotBlank(isSx) && "1".equals(isSx)){
                wheresql = " mainguid='" + mainguid + "' " +sxsql;
                tempMap.put("yeargoalinfo",prjIndexDAO.getDataMap("perf_t_casemodelgoal", wheresql));
            }else {*/
                wheresql = " mainguid='" + mainguid + "'";
                tempMap.put("yeargoalinfo",prjIndexDAO.getDataMap("v_perf_t_casemodelgoal", wheresql));
            //}
        }
        if (tabcode != null && "case".equals(tabcode)) {
            wheresql = " nvl(t.status, 2) <> 3";
        }
        if (StringUtil.isEmpty(wheresql) && !StringUtil.isEmpty(filter)){
            wheresql = filter;
        } else if (!StringUtil.isEmpty(filter)) {
            wheresql += " and " + filter;
        }
        /*if (StringUtils.isNotBlank(isSx) && "1".equals(isSx)){
            indexs = prjIndexDAO.findSxIndexs(mainguid, "perf_t_casemodelindex",sxsql);
        }else {*/
            indexs = prjIndexDAO.findIndexs(mainguid, "v_perf_t_casemodelindex", wheresql);
        //}
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
//        List<Map<String, Object>> pmframes = prjIndexDAO.findNullTemp(mainguid); //体系
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

    /**
     * 获取部门guid
     *
     * @param agencyguid
     * @return
     */
    public List<Map<String, Object>> getDeptGuid(String agencyguid) {
        return prjIndexDAO.getDeptGuid(agencyguid);
    }

    /**
     * 获取目标数据
     *
     * @param proguid --项目guid
     * @return
     */
    public List<Map<String, Object>> getGoalByGuid(String proguid) {
        List<Map<String, Object>> goalList = prjIndexDAO.getDatas("v_pm_perf_goal_info", " mainguid='" + proguid + "'", null);
        return goalList;
    }

    /**
     * 查询各年度数据.
     *
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws --           异常.
     */
    public Map<String, Object> findAllIndex(Map<String, Object> params) throws AppException {
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            prjIndexDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String proguid = (String) params.get("proguid");
        String parentproid = (String) params.get("parentproid");//父级项目id
        String showtab = (String) params.get("showtab"); ////页签显示 1总+年2总3年
        String pdmsave = (String) params.get("pdmsave"); //保存还是暂存区分20 暂存
        String selectbillguid = (String) params.get("selectbillguid"); //调整前的项目guid
        String adjustgoalguid = (String) params.get("adjustgoalguid"); //调整前的目标guid
        String adjadd = (String) params.get("adjadd"); //是否调整
        String dataprovince = "";//项目库传递的区划
//        String prolev = (String) params.get("prolev");
        String tempcode = (String) params.get("tempcode");
        String frametype = (String) params.get("frametype");
        String procode = (String) params.get("procode");
        String goalguid = (String) params.get("goalguid");
        String isperform = (String) params.get("isperform");
        String isZJ = PerfUtil.getSystemSet("isZJ");
        String[] tempfilter = new String[2];
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String sindex = "";
        String findex = "";
        String yearflag = "0";
        //配合项目库可以跨地区查询项目基本信息，如果有showall标识时，并且等于1时，执行下查询分区语句，年度是登录年度，区划是传递的区划
        String showall = (String) params.get("showall");
        logger.debug("------showall-------------" + showall);
        if (!StringUtil.isEmpty(showall) && "1".equals(showall)){
            String loginyear = CommonUtil.getYear();  //登录年度
            dataprovince = (String) params.get("dataprovince");//项目库传递的区划
            logger.debug("------------登录年度loginyear："+loginyear+" ---------------- 查询区划："+dataprovince);
            prjIndexDAO.setYearAndProvince(loginyear,dataprovince);
        }
        if (showtab != null && "1".equals(showtab)) {
            tempfilter = new String[]{"1", "0"};
        } else if (showtab != null && "2".equals(showtab)) {
            tempfilter = new String[]{"1"};
        } else {
            tempfilter = new String[]{"0"};
        }
        if (StringUtil.isEmpty(frametype)) {
            frametype = "PM001";
        }
        List<Map<String, Object>> indexs = null;
        if(isperform != null && "1".equals(isperform) && "1".equals(isZJ)){
            indexs = prjIndexDAO.findIndexsSpecial(proguid, procode, tempfilter);
        }else if (adjadd != null && "1".equals(adjadd)) {
            indexs = prjIndexDAO.findIndexsByFilter(proguid, procode, pdmsave, tempfilter,null, dataprovince);
            if (indexs.size() == 0 || (!PerfUtil.getProgramIsyear() && showtab.equals("1"))) { //安徽提出申报一起填报，复制项目（单位）添加判断。
                indexs = prjIndexDAO.findIndexsByFilter(selectbillguid, procode, pdmsave, tempfilter,null, dataprovince);
                //调整项目查询不存在数据，重新生成guid，解决项目库嵌套保存不刷新页面
                for (Map<String, Object> map : indexs) {
                    String guid = this.getCreateguid();
                    map.put("guid", guid);
                    map.put("kpi_id", guid);
                    map.put("version",PerfConstant.PMKPI_VERSION_RCDTWH);//版本号
                    map.put("version_name",PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);//版本号说明
                    if (PerfUtil.get_IsJiangXi()){
                        map.put("is_add","2");
                        map.put("islinked",null);
                        map.put("indexcategories",null);
                        map.put("industrycategory",null);
                        map.put("indexcategory",null);
                        map.put("filed",null);
                        map.put("occupation",null);
                    }
                }
            }
        } else {
            indexs = prjIndexDAO.findIndexsByFilter(proguid, procode, pdmsave, tempfilter,goalguid, dataprovince);
        }
        if(indexs.size() == 0 && StringUtils.isNotBlank(tempcode)){
            //如果查出来的指标数据为空，则获取模板中的指标数据。
            String procatcode = "";
            String isSx = PerfUtil.getSystemSet("isSX");
            if ("1".equals(isSx)){
                String sql = "select pro_cat_code from v_pm_project_info t where pro_id = '"+proguid+"'";
                Map codeMap = prjIndexDAO.queryForMap(sql);
                procatcode = (String) codeMap.get("pro_cat_code");
            }
            logger.debug("--------------项目类型："+procatcode);
            indexs = prjIndexDAO.findIndexsByTempCode(proguid, procode, tempcode, tempfilter);
            for (Map map :indexs) {
                String guid = this.getCreateguid();
                map.put("guid",guid);
                map.put("kpi_id",guid);
                //山西模式，人员类、公用经费 两类项目引用模板时把指标值显示出来
                if ("1".equals(isSx) && ("1".equals(procatcode)  || "21".equals(procatcode))){
                    map.put("indexval",map.get("indexvalue"));
                }
            }
        }
        List<Map<String, Object>> nullTemp = prjIndexDAO.getTempdatas(proguid, frametype); //空指标模板
        List<Map<String, Object>> tempList = null;
        List<Map<String, Object>> totalfixedIndexTemp = new ArrayList<>();//固化总体指标
        List<Map<String, Object>> yearfixedIndexTemp = new ArrayList<>();//固化年度指标
        List<Map<String, Object>> totalParentIndexTemp = new ArrayList<>();//父级项目总体指标
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        // 区分项目多页签指标
        String fsuperid = "";
        String ssuperid = "";
        float sweightsum = 0;
        float fweightsum = 0;
        Map<String, Object> sumMap = new HashMap<String, Object>();
        int totalindexcount = 0;
        int yearindexcount = 0;
        for (Map<String, Object> map : indexs) {
            yearflag = map.get("yearflag") == null ? "0" : (String) map.get("yearflag");
            if("0".equals(yearflag)){
                yearindexcount++;
            }else{
                totalindexcount++;
            }
            sindex = map.get("sindex") + "&" + yearflag;
            findex = map.get("findex") + "&" + yearflag;
            String weight = map.get("weight") == null ? "0" : map.get("weight") + "";
            keycode = sindex;
            if (findex.equals(fsuperid)) {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    Float num = Float.parseFloat(weight);
                    fweightsum = fweightsum + num;
                    fweightsum=(float)(Math.round(fweightsum*100))/100;
                }
            } else {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    if (ssuperid != null && !"null".equals(ssuperid) && !ssuperid.isEmpty()) {
                        if (fsuperid != null && !"null".equals(fsuperid) && !fsuperid.isEmpty()) {
                            fweightsum = 0;
                        }
                    }
                    Float num = Float.parseFloat(weight);
                    fweightsum =  + num;
                    fweightsum=(float)(Math.round(fweightsum*100))/100;
                }
            }
            if (sindex.equals(ssuperid)) {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    Float num = Float.parseFloat(weight);
                    sweightsum = sweightsum + num;
                    sweightsum=(float)(Math.round(sweightsum*100))/100;
                }
            } else {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    if (ssuperid != null && !"null".equals(ssuperid) && !ssuperid.isEmpty()) {
                        if (fsuperid != null && !"null".equals(fsuperid) && !fsuperid.isEmpty()) {
                            sweightsum = 0;
                        }
                    }
                    Float num = Float.parseFloat(weight);
                    sweightsum = num;
                    sweightsum=(float)(Math.round(sweightsum*100))/100;
                }
            }
            if (!indexMap.containsKey(keycode)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(keycode, tempList);
            } else {
                tempList = indexMap.get(keycode);
            }
            map.put("_isleaf", "1");
            tempList.add(map);
            ssuperid = sindex;
            fsuperid = findex;
            sumMap.put(sindex, sweightsum);
            sumMap.put(findex, fweightsum);
        }
        if(totalindexcount == 0) {//存在业务数据或者加载到了模板数据 总体指标index不为空，则不加载固化指标
            totalfixedIndexTemp = prjIndexDAO.getProFixedIndexData(proguid,"1"); //获取固化指标
        }
        if(yearindexcount == 0) {//存在业务数据或者加载到了模板数据 总体指标index不为空，则不加载固化指标
            yearfixedIndexTemp = prjIndexDAO.getProFixedIndexData(proguid,"0"); //获取固化指标
        }
        String isGX = PerfUtil.getSystemSet("IS_GUANGXI");
        if ("1".equals(isGX) && totalindexcount == 0){//广西参数 并且不存在总体指标数据，加载父级项目总体指标
            totalParentIndexTemp  = prjIndexDAO.getParentProIndexData(proguid,parentproid,"1");
        }
        // 区分项目空模板赋值，不然没有共有字段不显示
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode("V_PM_PERF_INDICATOR");
        for (Map<String, Object> map : nullTemp) {
            for (DicColumnDTO dicdto : dicColumnDTOs) {
                if (!map.containsKey(dicdto.getDbcolumncode())) {
                    map.put(dicdto.getDbcolumncode().toLowerCase(), "");
                }
            }
        }
        //处理总体绩效指标
        List<Map<String, Object>> nullindex = null; //空模板
        List<Map<String, Object>> backindex = null; //返回指标
        if (StringUtils.isNotBlank(showtab) && "1".equals(showtab)) {
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            nullindex.addAll(totalfixedIndexTemp);
            nullindex.addAll(totalParentIndexTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                map.put("_isleaf", "1");
                sindex = map.get("sindex") + "&1";
                String levelno = map.get("levelno") + "";
                if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                    map.put("weight",sumMap.get(sindex) == null ? 0 : sumMap.get(sindex));
                } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                    findex = map.get("guid") + "&1";
                    map.put("weight",sumMap.get(findex) == null ? 0 : sumMap.get(findex));
                    sindex = "";
                } else {
                    sindex = "";
                }
                if (indexMap.containsKey(sindex)) {
                    tempList = indexMap.get(sindex);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#total", backindex); //项目总体
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            nullindex.addAll(yearfixedIndexTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                map.put("_isleaf", "1");
                sindex = map.get("sindex") + "&0";
                String levelno = map.get("levelno") + "";
                if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                    map.put("weight",sumMap.get(sindex) == null ? 0 : sumMap.get(sindex));
                } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                    findex = map.get("guid") + "&0";
                    map.put("weight",sumMap.get(findex) == null ? 0 : sumMap.get(findex));
                    sindex = "";
                } else {
                    sindex = "";
                }
                if (indexMap.containsKey(sindex)) {
                    tempList = indexMap.get(sindex);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#year", backindex);//年度
        } else if (StringUtils.isNotBlank(showtab) && "2".equals(showtab)) {
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            nullindex.addAll(totalfixedIndexTemp);
            nullindex.addAll(totalParentIndexTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                sindex = map.get("sindex") + "&1";
                map.put("_isleaf", "1");
                String levelno = map.get("levelno") + "";
                if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                    map.put("weight",sumMap.get(sindex) == null ? 0 : sumMap.get(sindex));
                } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                    findex = map.get("guid") + "&1";
                    map.put("weight",sumMap.get(findex) == null ? 0 : sumMap.get(findex));
                    sindex = "";
                } else {
                    sindex = "";
                }
                if (indexMap.containsKey(sindex)) {
                    tempList = indexMap.get(sindex);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#total", backindex); //项目总体
        } else {
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            nullindex.addAll(yearfixedIndexTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                sindex = map.get("sindex") + "&0";
                map.put("_isleaf", "1");
                String levelno = map.get("levelno") + "";
                if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                    map.put("weight",sumMap.get(sindex) == null ? 0 : sumMap.get(sindex));
                } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                    findex = map.get("guid") + "&0";
                    map.put("weight",sumMap.get(findex) == null ? 0 : sumMap.get(findex));
                    sindex = "";
                } else {
                    sindex = "";
                }
                if (indexMap.containsKey(sindex)) {
                    tempList = indexMap.get(sindex);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#year", backindex);//年度
        }
        return yearsMap;
    }

    /**
     * 绩效制度表树级展示保存.
     *
     * @param params -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> savePrjTreeIndex(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("projguid");
        String busguid = (String) params.get("busguid");
        this.setProAgencyName(params);
        String saveAgency = (String) params.get("saveAgency");
        String showtab = (String) params.get("showtab"); //页签显示 1总+年2总3年
        String procode = (String) params.get("procode"); //项目编码
        String pro_name = (String) params.get("pro_name");//项目名称
        String agency_name = (String) params.get("agency_name");//单位名称
        String pdmsave = (String) params.get("pdmsave"); // 21为暂存,其他为保存
        String isnest = (String) params.get("isnest"); // 嵌套页面跳转过来的
        String adjadd = (String) params.get("adjadd");//是否调整
        String isnzzj = (String) params.get("isnzzj");//是否年中追加
        String midsave = (String) params.get("midsave"); // 是否草稿页面保存，接口获取
        String isedittotal = (String) params.get("isedittotal");
        String isperform = (String) params.get("isperform"); // 是否特殊绩效
        String isZJ = PerfUtil.getSystemSet("isZJ");
        logger.info("--------pro_name:"+ pro_name );
        List<Map<String, Object>> indexList = new ArrayList<>(); //指标集合
        Map<String, Object> tabcomps = (Map<String, Object>) params.get("datas"); //多页签的数据
        logger.info("--------tabcomps:"+ tabcomps );
        List<Map<String, Object>> addList = new ArrayList<>(); //新增
        List<Map<String, Object>> modList = new ArrayList<>(); // 修改
        List<String> delList = new ArrayList<>(); // 删除
        String levelno = "";
        String indexname = "";
        String rowtype = "";
        String tablecode = "pm_perf_indicator";
        // 多次保存的情况，特殊绩效每次取最新保存入库，标注：总体or年度
        String flag = "2";
        if (pdmsave != null && "21".equals(pdmsave)) {
            prjIndexDAO.updateIsDeleteDatas("v_pm_perf_indicator_temp", " mainguid = '"+proguid+"'"); //删除指标暂存表
            tablecode = "v_pm_perf_indicator_temp"; //暂存表
        }
        //草稿页面保存并退出/送审，如果存在业务数据，先删除垃圾数据（保存入业务表如果项目库被拦截，绩效没问题绩效数据会入库，产生垃圾数据，删除数据后进行新增）
        if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {
            logger.info("-----------指标草稿删除----------midsave="+midsave);
            String delsql = " mainguid='" + proguid + "' and t.province='" + CommonUtil.getProvince() + "'";
            prjIndexDAO.updateDatasIsDelete(tablecode, delsql);
        }
        int i = 0;
        int j = 0;
        int k = 0;
        String wheresql = "";
        if (showtab != null && ("1".equals(showtab) || "2".equals(showtab)) && (isedittotal == null || !"1".equals(isedittotal))) { // 总+年
            List<String> delTotalList = (List<String>) tabcomps.get("del#total");
            if (delTotalList != null && delTotalList.size() > 0) {
                delList.addAll(delTotalList);
            }
            List<Map<String, Object>> totalList = (List<Map<String, Object>>) tabcomps.get("#total");
            if (totalList != null && totalList.size() > 0) {
                if (!"21".equals(pdmsave) && PerfUtil.getIsuCheckIndexName()) { // 是否校验三级指标名称重复
                    // 校验指标名称不可重复
                    Map<String, Object> nameDupCheckMap = this.nameDuplicateCheck(totalList);
                    if(nameDupCheckMap != null && !nameDupCheckMap.isEmpty() && nameDupCheckMap.get("success").equals(false)){
                        return nameDupCheckMap;
                    }
                }
                wheresql = " mainguid='" + proguid + "' and yearflag = '1'  and is_deleted = 2 and is_backup=2 and province='" + CommonUtil.getProvince() + "'";
                wheresql += " and sub_mof_div_code is null";//追加条件，查询物理表时过滤掉转移支付数据
                if (pdmsave != null && "21".equals(pdmsave)) {
                    wheresql = " mainguid='" + proguid + "' and yearflag = '1' ";
                }
                k += prjIndexDAO.getDataCount(tablecode, wheresql);
                for (Map tempMap : totalList) {
                    flag = "1";
                    i++;
                    levelno = PerfUtil.mapGetInt(tempMap, "levelno") + "";
                    indexname = (String) tempMap.get("name");
                    rowtype = (String) tempMap.get("rowtype");
                    if (pdmsave != null && "21".equals(pdmsave)) {//如果保存草稿则生成guid
                        tempMap.put("guid",StringUtil.createUUID());
                    }
                    if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {// 草稿保存数据时用新的主键
                        String newguid =this.getCreateguid();
                        tempMap.put("guid",newguid); //只保存草稿时重新生成guid
                        tempMap.put("kpi_id",newguid);
                    }
                    if ("3".equals(levelno) && !StringUtil.isEmpty(indexname)) { //总体指标
                        tempMap.put("mainguid", proguid);
                        tempMap.put("ordernum", i);
                        tempMap.put("yearflag", "1");
                        tempMap.put("kpi_val", tempMap.get("indexval"));
                        tempMap.put("status", "");
                        tempMap.put("kpi_content", tempMap.get("name"));
                        tempMap.put("kpi_evalstd", "1");
                        tempMap.put("agency_code", saveAgency);
                        tempMap.put("agencyguid", saveAgency);
                        tempMap.put("pro_code", procode);
                        tempMap.put("pro_name", pro_name);
                        if ("add".equals(rowtype)) { //新增
                            tempMap.put("agency_name", agency_name);
                            this.setIndexMap(tempMap);
                            if (!StringUtil.isEmpty(adjadd) && "1".equals(adjadd)) {//调整
                                tempMap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                            }
                            if (!StringUtil.isEmpty(isnzzj) && "true".equals(isnzzj)) {//年中追加
                                tempMap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_NZRCDTWH);
                            }
                            addList.add(tempMap);
                        } else {
                            tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
                            tempMap.put("update_time", PerfUtil.getServerTimeStamp());
                            modList.add(tempMap);
                        }
                        indexList.add(tempMap); //用于审核定义
                    }
                }
            }
        }
        if (showtab != null && ("1".equals(showtab) || "3".equals(showtab))) { // 年
            List<String> delYearList = (List<String>) tabcomps.get("del#year");
            if (delYearList != null && delYearList.size() > 0) {
                delList.addAll(delYearList);
            }
            List<Map<String, Object>> yearList = (List<Map<String, Object>>) tabcomps.get("#year");
            if(yearList!=null&&yearList.size()>0){
                if (!"21".equals(pdmsave) && PerfUtil.getIsuCheckIndexName()) { // 是否校验三级指标名称重复
                    // 校验指标名称不可重复
                    Map<String, Object> nameDupCheckMap = this.nameDuplicateCheck(yearList);
                    if(nameDupCheckMap != null && !nameDupCheckMap.isEmpty() && nameDupCheckMap.get("success").equals(false)){
                        return nameDupCheckMap;
                    }
                }
                if ("true".equals(midsave) && !"21".equals(pdmsave)) {//草稿的保存并退出
                    wheresql = " mainguid='" + proguid + "'";
                } else {
                    if (("1".equals(adjadd) && PerfUtil.getProgramIsyear()) || (pdmsave != null && "21".equals(pdmsave))) {//调整年度或者草稿根据proguid+pro_code
                        wheresql = " mainguid='" + proguid + "' and pro_code='" + procode + "' ";
                    } else {
                        wheresql = " pro_code='" + procode + "' ";
                    }
                }
                if (pdmsave != null && "21".equals(pdmsave)) {
                    wheresql += "and yearflag = '0' ";
                }else{
                    wheresql += "and yearflag = '0' and is_deleted = 2 and is_backup=2 and province='" + CommonUtil.getProvince() + "'";
                }
                wheresql += " and year='" + SecureUtil.getUserSelectYear() + "'";
                wheresql += " and sub_mof_div_code is null";//追加条件，查询物理表时过滤掉转移支付数据
                k += prjIndexDAO.getDataCount(tablecode, wheresql);
                for (Map tempMap : yearList) {
                    flag = "0";
                    j++;
                    levelno = PerfUtil.mapGetInt(tempMap, "levelno") + "";
                    indexname = (String) tempMap.get("name");
                    rowtype = (String) tempMap.get("rowtype");
                    if (pdmsave != null && "21".equals(pdmsave)) {//如果保存草稿则生成guid
                        tempMap.put("guid",StringUtil.createUUID());
                    }
                    if (midsave != null && "true".equals(midsave) && !"21".equals(pdmsave)) {// 草稿保存数据时用新的主键
                        String newguid =this.getCreateguid();
                        tempMap.put("guid",newguid); //只保存草稿时重新生成guid
                        tempMap.put("kpi_id",newguid);
                    }
                    if ("3".equals(levelno) && !StringUtil.isEmpty(indexname)) {
                        tempMap.put("mainguid", proguid);
                        tempMap.put("ordernum", j);
                        tempMap.put("yearflag", "0");
                        tempMap.put("kpi_val", tempMap.get("indexval"));
                        tempMap.put("status", "");
                        tempMap.put("kpi_content", tempMap.get("name"));
                        tempMap.put("kpi_evalstd", "1");
                        tempMap.put("agency_code", saveAgency);
                        tempMap.put("agencyguid", saveAgency);
                        tempMap.put("pro_code", procode);
                        tempMap.put("pro_name", pro_name);
                        if ("1".equals(adjadd) && PerfUtil.getProgramIsyear()) {
                            tempMap.put("is_adj", 1);//是否调整，1是 2调整终审，储备阶段为2
                        }
                        if ("add".equals(rowtype)) {
                            tempMap.put("agency_name", agency_name);
                            if (!StringUtil.isEmpty(adjadd) && addList != null &&"1".equals(adjadd)) {//调整
                                tempMap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                            }
                            if (!StringUtil.isEmpty(isnzzj) && "true".equals(isnzzj)) {//年中追加
                                tempMap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_NZRCDTWH);
                            }
                            this.setIndexMap(tempMap);
                            addList.add(tempMap);
                        } else {
                            tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
                            tempMap.put("update_time", PerfUtil.getServerTimeStamp());
                            modList.add(tempMap);
                        }
                        indexList.add(tempMap); //用于审核定义
                    }
                }
            }
        }
        //保存前校验指标填写是否符合规范
        Map<String, Object> returnMap = null;
        if (indexList.size() > 0) {
            if (addList.size() > 0) {
                prjIndexDAO.setIndexCode(addList);
                prjIndexDAO.setIndexDatas(addList,"PM001",false);
            }
            prjIndexDAO.setIndexCode(indexList);
            prjIndexDAO.setIndexDatas(indexList,"PM001",false);
//            logger.info("--------indexList:"+ indexList );
            returnMap = this.checkColLength(indexList, PerfConstant.PMKPI_VPM_INDICATOR);
            //草稿保存不校验必填
            if (!"21".equals(pdmsave)) {
                returnMap.putAll(prjIndexDAO.checkTacleColsIsNull(tablecode, indexList));
            }
            if (!returnMap.isEmpty()) {
                return returnMap;
            }
        }
        if (k <= 0 && indexList.size() > 0) { //判断项目是否存在数据，不存在默认全部新增,调整，保存草稿后保存并退出项目guid会变，没办法区分数据是否为新增状态
            for (Map tempMap : indexList) {
                tempMap.put("agency_code", saveAgency);
                tempMap.put("agencyguid", saveAgency);
                tempMap.put("pro_code", procode);
                tempMap.put("pro_name", pro_name);
                tempMap.put("agency_name", agency_name);
                tempMap.put("proguid", proguid);
                tempMap.put("mainguid", proguid);
                this.setIndexMap(tempMap);
            }
            prjIndexDAO.saveAll(indexList, tablecode);
            return this.auditdefine(indexList, busguid, "perf", null);
        }
        //删除
        if (delList != null && delList.size() > 0) {
            prjIndexDAO.deleteAllByColumn("guid", delList, tablecode);
        }
        //修改
        if (modList != null && modList.size() > 0) {
            prjIndexDAO.setIndexDatas(modList,"PM001",false);
            prjIndexDAO.updateAllByPK(this.getTablecol(tablecode), modList, "guid", tablecode);
        }
        if (addList != null && addList.size() > 0) {
            //嵌套时保存后页面不刷新，新增标识符一直存在问题
            if (isnest != null && "1".equals(isnest)) {
                prjIndexDAO.saveAll(addList, prjIndexDAO.PMKPI_TABLE_TMP_GUIDS);
                String delsql = " exists(select 1 from " + prjIndexDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid) and t.is_backup = 2 and province='" + CommonUtil.getProvince() + "'";
                prjIndexDAO.updateDatasIsDelete(tablecode, delsql);
            }
            if("1".equals(isperform) && "1".equals(isZJ)){
                logger.debug("-----删除历史特殊绩效指标：" +procode+ "---"+proguid+"---" +flag);
                String delsql = null;
                if("0".equals(flag)){
                    delsql = "t.pro_code = '"+procode+"' and t.yearflag = '"+flag+"' ";
//                    prjIndexDAO.delDatas(tablecode,"t.pro_code = '"+procode+"' and t.yearflag = '"+flag+"' ");
                } else if("1".equals(flag)){
                    delsql = "t.mainguid = '"+proguid+"' and t.yearflag = '"+flag+"' ";
//                    prjIndexDAO.delDatas(tablecode,"t.mainguid = '"+proguid+"' and t.yearflag = '"+flag+"' ");
                }
                prjIndexDAO.updateDatasIsDelete(tablecode, delsql);
                //prjIndexDAO.updateDatas(tablecode," set t.is_deleted = '1' where pro_code = '"+procode+"' and t.yearflag = '"+flag+"' ");
            }
            prjIndexDAO.saveAll(addList, tablecode);
        }
        if (pdmsave != null && "21".equals(pdmsave)) { //暂存
            Map<String, Object> tempMap = new HashMap<String, Object>();
            tempMap.put("success", true);
            return tempMap;
        }
        return this.auditdefine(indexList, busguid, "perf", null);
    }

    /**
     * 获取项目名称和单位名称
     * @param params
     */
    public void setProAgencyName(Map<String, Object> params){
        String procode = (String) params.get("procode"); //项目编码
        String proguid = (String) (StringUtil.isEmpty((String) params.get("projguid")) ? params.get("proguid") : params.get("projguid"));
        String pro_name = (String) params.get("pro_name");//项目名称
        String isnzzj = (String) params.get("isnzzj");//是否年中追加
        String adjadd = (String) params.get("adjadd");
        String selectbillguid = (String) params.get("selectbillguid");
        if (StringUtil.isEmpty(procode) || StringUtil.isEmpty(pro_name)) {
            Map<String, Object> proMap = null;
            String wheresql = "";
            if ("true".equals(isnzzj)) {
                wheresql = "t.pro_code = '" + procode + "'";
                proMap = prjIndexDAO.getDataMap(prjIndexDAO.PMKPI_TABLE_PROJECT_INFO, wheresql);
            } else {
                wheresql = "t.guid = '" + proguid + "'";
                proMap = prjIndexDAO.getDataMap(prjIndexDAO.PMKPI_TABLE_ALLPROJECT_INFO, wheresql);
                if ("1".equals(adjadd) && proMap.isEmpty() && !StringUtil.isEmpty(selectbillguid)) {
                    wheresql = "guid='" + selectbillguid + "'";
                    proMap = prjIndexDAO.getDataMap(prjIndexDAO.PMKPI_TABLE_PROJECT_INFO, wheresql);
                }
            }
            if (!proMap.isEmpty()) {
                procode = (String) proMap.get("pro_code");
                pro_name = (String) proMap.get("pro_name");
                String saveAgency = (String) proMap.get("agency_code");
                String agency_name = (String) proMap.get("agency_name");
                params.put("procode", procode);
                params.put("pro_name", pro_name);
                params.put("agency_name", agency_name);
                params.put("saveAgency", saveAgency);
            }
        }
        logger.info("---获取项目名称和单位名称：procode:" + procode + ";proguid:" + proguid+ ";selectbillguid:" + selectbillguid);
        logger.info("---获取项目名称和单位名称：isnzzj:" + isnzzj + ";adjadd:" + adjadd);
        logger.info("---获取项目名称和单位名称：pro_name:" + pro_name + ";agency_code:" + params.get("saveAgency") + ";agency_name:" + params.get("agency_name"));
    }

    /**
     * 项目明细导出指标查询
     * @param proguid
     * @return
     */
    public List<Map<String, Object>> getExportIndex(String proguid) {
        String sql = "select * from v_perf_indicator_export aa where aa.yearflag = '1' and aa.mainguid = '" + proguid + "' order by code";
        List totalList  = prjIndexDAO.queryForList(sql);
        if (PerfUtil.getProgramIsyear()) {
            sql = "select * from v_perf_indicator_export aa where aa.yearflag = '0' " + PerfUtil.yearProvinceSql("aa") + " and aa.mainguid = '" + proguid + "' order by code";
            List yearlist = prjIndexDAO.queryForList(sql);
            totalList.addAll(yearlist);
        }
        return totalList;
    }

    /**
     * 初始化指标规范，只适用于新增数据 rowtype = add
     * @param tempMap
     * @throws AppException
     */
    public void setIndexMap(Map tempMap) {
        this.getBasMap(tempMap,"add");
        tempMap.put("is_last_inst",2);//是否终审
    }

    /**
     * 目标校验失败时调用的方法
     *
     * @param e 错误信息
     * @return
     */
    public Map<String, Object> getExceptionMes(PerfAppException e) {
        Map<String, Object> resultMap = new HashMap<>();
        List<Map<String, Object>> listData = new ArrayList<>();
        List<Map<String, Object>> dataList = (List<Map<String, Object>>) e.getRemap().get("redata");
        for (Map<String, Object> map : dataList) {
            Map<String, Object> mapData = new HashMap<>();
            String proguid = (String) map.get("busguid");      //项目id
            String errormsg = (String) map.get("remark");       //警告信息
            String auditName = (String) map.get("auditname");
            String alarmlevels = (String) map.get("alarmlevels");
            Map<String, Object> locationInfo = new HashMap<>();      //locationInfo
            //封装数据到locationInfo map集合
            locationInfo.putAll(map);
            locationInfo.put("pro_guid", proguid);
            locationInfo.put("errormsg", errormsg);
            //封装map集合数据
            mapData.put("locationInfo", locationInfo);
            //mapData.put("alarmlevels", 1);
            mapData.put("customAudit", "false");  //false:非自定义审核
            mapData.put("auditName",auditName);
            mapData.put("alarmlevels", alarmlevels);
            //map集合添加到list集合中
            listData.add(mapData);
        }
        //最终返回结果
        resultMap.put("error", null);
        resultMap.put("data", listData);
        return resultMap;
    }

    /**
     * 保存引用案例目标.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public void saveGoal(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        this.setProAgencyName(params);
        String saveAgency = (String) params.get("saveAgency");
        String procode = (String) params.get("procode");
        String tablecode = "v_pm_perf_goal_info";
        String pro_name = (String) params.get("pro_name");
        String agency_name = (String) params.get("agency_name");
        Map<String, Object> yeargoalinfo = (Map<String, Object>) params.get("yeargoalinfo");
        String wheresql = " mainguid='" + mainguid + "' and yearflag = '0' ";
        int i = prjIndexDAO.getDataCount(tablecode, wheresql);
        if (i == 0) {
            String newguid =this.getCreateguid();
            yeargoalinfo.put("mainguid", mainguid);
            yeargoalinfo.put("yearflag","0");
            yeargoalinfo.put("guid", newguid);
            yeargoalinfo.put("agencyguid", saveAgency);
            yeargoalinfo.put("pro_code", procode);
            yeargoalinfo.put("pro_name", pro_name);
            yeargoalinfo.put("agency_name", agency_name);
            this.setIndexMap(yeargoalinfo);
            prjIndexDAO.save(yeargoalinfo, tablecode);
        }
    }

    /**
     * 导入指标
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importIndexData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            List<Map<String, Object>> errorlist = this.checkImpColLength(impDatas, impCols);
            errorlist.addAll(this.checkIndexFrame(impDatas));
            errorlist.addAll(this.checkProgramIndex(impDatas));
            if (errorlist.size() > 0) {
                throw new AppException("ANA-ERROR", "指标导入数据错误");
            } else {
                PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexBOTX");
                prjIndexBO.impIndex(prjIndexBO, impDatas, impCols, tablecode, resultList, busParams);
            }
        }
    }

    /**
     * 申报阶段额外的导入校验
     * @return
     */
    public List<Map<String, Object>> checkProgramIndex(List<Map<String, Object>> datas) throws AppException {
        List<Map<String, Object>> errorlist = new ArrayList<>();
        int j = 1;
        StringBuffer error = null;
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto = null;
        for (Map data : datas) {
            error = new StringBuffer();
            ++j;
            String indexval = (String) data.get("indexval");
            if (StringUtil.isEmpty(indexval)) {
                error.append("请填写指标值 ");
            }
            if (!StringUtil.isEmpty(error.toString())) {
                dto = new ImportErrorDTO(FileUploadService.fileguids.get(), j, error.toString());
                errordao.saveErrorMsg(dto);
                errorlist.add(dto);
            }
        }
        return errorlist;
    }

    public void impIndex(PrjIndexBO prjIndexBO, ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        PrjIndexDAO prjIndexDAO = (PrjIndexDAO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexDAO");
        String tabtype = (String) busParams.get("tabtype");
        String proguid = (String) busParams.get("proguid");
        this.setProAgencyName(busParams);
        String procode = (String) busParams.get("procode");
        String proname = (String) busParams.get("pro_name");
        String agency_name = (String) busParams.get("agency_name");
        String agencyguid = (String) (StringUtil.isEmpty((String) busParams.get("agencyguid")) ? busParams.get("saveAgency") : busParams.get("agencyguid"));
        String adjadd = (String) busParams.get("adjadd");
        String isnzzj = (String) busParams.get("isnzzj");
        List<Map<String, Object>> goaldatas = (List<Map<String, Object>>) busParams.get("goaldatas");
        String goalguid = null;
        Map<String, Object> errorMap = new HashMap<>();
        boolean isgoal = false;//湖北和目标有关联关系，目标未保存时，需要保存目标
        if(goaldatas != null && goaldatas.size() > 0){
            Map<String, Object> goalMap = goaldatas.get(0);
            goalguid = (String) goalMap.get("guid");
            String wheresql = "guid=? and is_deleted=2 and is_backup=2";
            int goalnum = prjIndexDAO.getDataCount(PerfConstant.PMKPI_BACKUP_GOAL_INFO, wheresql, new String[]{goalguid});
            if (goalnum == 0) {
                isgoal = true;
            }
        }
        List<Map<String, Object>> indexList = new ArrayList<>();
        for (Object indexMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) indexMap;
            //处理特殊字符
            data.put("name",PerfUtil.replaceSymbols((String) data.get("name")));
            data.put("indexval",PerfUtil.replaceSymbols((String) data.get("indexval")));
            data.put("perf_ind_name",PerfUtil.replaceSymbols((String) data.get("perf_ind_name")));
            data.put("kpi_val",PerfUtil.replaceSymbols((String) data.get("kpi_val")));
            String guid = CommonUtil.createGUID();
            data.put("guid", guid);
            data.put("mainguid", proguid);
            data.put("pro_code", procode);
            data.put("pro_name", proname);
            data.put("agency_code", agencyguid);
            data.put("agencyguid", agencyguid);
            data.put("goalguid", goalguid);
            data.put("agency_name", agency_name);
            if (tabtype != null && "year".equals(tabtype)) {
                data.put("yearflag", "0");
                if (PerfUtil.getProgramIsyear() && "1".equals(adjadd)) {
                    data.put("is_adj", 1);
                }
            }else {
                data.put("yearflag", "1");
            }
            data.put("superid", data.get("sindex"));
            data.put("kpi_val", data.get("indexval"));
            data.put("levelno", 3);
            data.put("is_leaf", 1);
            data.put("isfromparent", 0);//新增 导入指标默认非继承一级项目
            data.put("isapply", 1);//新增 导入指标适用
            data.put("indsource", "1");
            data.put("is_intoindexlib", 2);//新增 是否已纳入指标库为否
            if (!StringUtil.isEmpty(adjadd) && "1".equals(adjadd)) {//调整
                data.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            }
            if (!StringUtil.isEmpty(isnzzj) && "true".equals(isnzzj)) {//年中追加
                data.put("version_name", PerfConstant.PMKPI_VERSION_NAME_NZRCDTWH);
            }
            this.setIndexMap(data);
            indexList.add(data);
        }
        prjIndexBO.setIndexCode(indexList);
        prjIndexDAO.setIndexDatas(indexList, "PM001", false);
        errorMap.putAll(this.checkColLength(indexList, PerfConstant.PMKPI_VPM_INDICATOR));
        if (PerfUtil.getIsuCheckIndexName()) { // 是否校验三级指标名称重复
//            logger.info("---校验导入指标是否重名：" + indexList.toString());
            //校验指标名称不可重复
            String checkSql;
            if (tabtype != null && "year".equals(tabtype)) {  //年度指标
                checkSql = "select * from v_pm_perf_indicator where yearflag = '0' and pro_code = '" + procode + "'";
            } else {
                checkSql = "select * from pm_perf_indicator where is_deleted = 2 and is_backup=2 and yearflag = '1' and mainguid = '" + proguid + "' and sub_mof_div_code is null ";
            }
            List<Map<String, Object>> checkList = prjIndexDAO.queryForList(checkSql);
            checkList.addAll(indexList);
            errorMap.putAll(this.nameDuplicateCheck(checkList));
            if (errorMap != null && !errorMap.isEmpty() && errorMap.get("success").equals(false)) {
                List<Map<String, Object>> redata = (List) errorMap.get("redata");
                String regStr = "";
                for (Map map : redata) {
                    String remark = (String) map.get("remark");
                    regStr += remark;
                }
                logger.info("---有重名---");
                throw new AppException("导入失败", regStr);
            } else {
                logger.info("---无重名---");
                prjIndexDAO.saveAll(indexList, prjIndexDAO.PMKPI_TABLE_PM_INDEX);
            }
        } else {
            logger.info("---不校验三级指标名称重复：" + indexList.toString());
            if (errorMap != null && !errorMap.isEmpty() && errorMap.get("success").equals(false)) {
                List<Map<String, Object>> redata = (List) errorMap.get("redata");
                String regStr = "";
                for (Map map : redata) {
                    String remark = (String) map.get("remark");
                    regStr += remark;
                }
                throw new AppException("导入失败", regStr);
            }
            prjIndexDAO.saveAll(indexList, prjIndexDAO.PMKPI_TABLE_PM_INDEX);
        }
        if (isgoal) {
            for (Map<String, Object> data : goaldatas) {
                data.put("mainguid", proguid);
                data.put("pro_code", procode);
                data.put("pro_name", proname);
                data.put("agency_code", agencyguid);
                data.put("agencyguid", agencyguid);
                data.put("goalguid", goalguid);
                data.put("agency_name", agency_name);
                if (tabtype != null && "year".equals(tabtype)) {
                    data.put("yearflag", "0");
                    if (PerfUtil.getProgramIsyear() && "1".equals(adjadd)) {
                        data.put("is_adj", 1);
                    }
                }else {
                    data.put("yearflag", "1");
                }
                if (!StringUtil.isEmpty(adjadd) && "1".equals(adjadd)) {//调整
                    data.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                }
                if (!StringUtil.isEmpty(isnzzj) && "true".equals(isnzzj)) {//年中追加
                    data.put("version_name", PerfConstant.PMKPI_VERSION_NAME_NZRCDTWH);
                }
                prjIndexDAO.getBasMap(data, "add");
            }
            prjIndexDAO.saveAll(goaldatas, PerfConstant.PMKPI_VPM_GOAL_INFO);
        }
    }

    /**
     * 导入校验项目是否入库
     * @param parms
     * @return
     */
    public String chcekProgram(HashMap<String, Object> parms) {
        String guid = (String)parms.get("mainguid");
        String result = "false";
        Map<String,Object> proMap =  prjIndexDAO.getDataMap(prjIndexDAO.PMKPI_TABLE_ALLPROJECT_INFO, " t.pro_id = '"+guid+"'");
        if (!proMap.isEmpty()) {
            result = "true";
        }
        return result;
    }

    /**
     * 华青指标系统送审校验项目年度绩效是否填写.
     * @param codeList -- 项目编码集合.
     * @param year -- 年度.
     * @param province -- 区划.
     * @return list.
     */
    public List sendbdgcheck(List<String> codeList, String year, String province) {
        List endlist = new ArrayList();
        List midlist = new ArrayList();
        prjIndexDAO.setYearAndProvince(year,province);
        StringBuffer sql = new StringBuffer("SELECT t.agency_code,c.name as agency_name,t.pro_code || '-' ||t.pro_name as remark");
        sql.append(" from v_perf_project_info t left join v_ele_vd00010 c on t.agencyguid = c.guid where ");
        sql.append(prjIndexDAO.createInSql("t.pro_code", codeList));
        sql.append(" and not exists (select 1 from v_pm_perf_indicator k where k.yearflag = '0' and k.pro_code = t.pro_code)");
        if(PerfUtil.getIsGuangXi()){
            sql.append(" and t.pro_cat_code in ('22','3')");
        }else if(PerfUtil.getIsZJ()){
            sql.append(" and t.pro_cat_code not in ('1','21') and t.level_no ='2' and t.is_perform ='2'");
        }
        logger.info("查询sql："+sql.toString());
        endlist =  prjIndexDAO.queryForList(sql.toString());
        String paramsvalues = PerfUtil.getSystemSet("midprowfstatus"); //年中追加项目的终审状态
        String[] arrs = paramsvalues.split(",");
        StringBuffer wfstatus = new StringBuffer();
        for (int j = 0; j < arrs.length; j++) {
            String tempstr = arrs[j];
            if (!StringUtil.isEmpty(tempstr)){
                wfstatus.append("'").append(tempstr).append("',");
            }
        }
        String wflist = "('011')";
        if (wfstatus.length() > 0){
            wfstatus.deleteCharAt(wfstatus.length() - 1);
            wflist = " ("+wfstatus.toString()+") ";
        }
        sql = new StringBuffer("SELECT t.agencyguid as agency_code,c.name as agency_name,t.pro_code ||'-'|| t.pro_name as remark");
        sql.append(" from v_perf_t_deptperfmiddeclare t left join v_ele_vd00010 c on t.agencyguid = c.guid where ");
        sql.append(prjIndexDAO.createInSql("t.pro_code", codeList));
        sql.append(" and nvl(t.wfstatus,'99') not in ");
        sql.append(wflist);
        sql.append(" and exists (select 1 from v_pm_perf_indicator k where k.yearflag = '0' and k.pro_code = t.pro_code)");
        midlist = prjIndexDAO.queryForList(sql.toString());
        logger.info("年中追加未终审sql："+sql.toString());
        endlist.addAll(midlist);
        return endlist;
    }

    /**
     * <p>判断当前部门是否使用新的指标填报页面</p >
     *
     * @param
     * @author hw
     * @date 2022/6/30 14:38
     */
    public String isNewApply() {
        String agencyguid = SecureUtil.getCurrentUser().getAgency();
        logger.info("---判断当前部门是否使用新的指标填报页面：agencyguid="+agencyguid);
        String flag = "false";
//        if (StringUtil.isEmpty(agencyguid)) {
//            String sql = "select agency_code from pm_project_info where pro_id = '" + proguid + "'";
//            logger.info("---sql："+sql);
//            List<Map<String, Object>> list = prjIndexDAO.queryForList(sql);
//            if (list != null && !list.isEmpty()) {
//                agencyguid = (String) list.get(0).get("agency_code");
//            }
//        }
        String newApplyDepts = PerfUtil.getSystemSet("NEWAPPLYDEPTS_PROGRAM");  // 指定部门实行新的指标填报方式
        if (!StringUtils.isEmpty(newApplyDepts) && !StringUtils.isEmpty(agencyguid) && agencyguid.length() >= 3) {
            Map<String, Object> tabMap = JsonUtils.jsonToMap(newApplyDepts);
            String agencys = (String) tabMap.get("agencys");
            String[] split = agencys.split(",");
            List<String> list = Arrays.asList(split);
            agencyguid = agencyguid.substring(0, 3);
            flag = list.contains(agencyguid) + "";
        }
        return flag;
    }

    /**
     * <p>引用指标-查询左侧案例模板指标.</p >
     *
     * @author hw
     * @date 2022/7/11 15:34
     * @param
     */
    public Map finTreeDataNew(HashMap config) throws AppException {
        String tabcode = (String) config.get("tabcode");
        String tabfilter = (String) config.get("tabfilter");//页签配置的过滤
        String condition = (String) config.get("condition");//过滤条件
        String agencyguid = SecureUtil.getCurrentUser().getAgency();
        String menuid = (String) config.get("menuid");
        String tablecode = "";
        String wheredatarule = "";
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List listdept = new ArrayList();
        if (tabcode != null && "case".equals(tabcode)) {
            String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null);
            if ("and  1<>1".equals(datarule.trim())) {
                condition = " and agencyguid like '" + agencyguid.substring(0, 3) + "%'";
            } else {
                condition = datarule;
            }
            HashMap map = new HashMap();
            tablecode = "v_perf_t_case_enum";
            condition += " and bustype = 'PM001' " +
                    " and exists (select * from v_perf_enum e where e.elementcode = 'PERFGXCLASSIFICATION' and e.guid = t.casetype)";
            List<Map<String, Object>> caseList = prjIndexDAO.finTreeData(tablecode, condition);
            try {
                List<DicRangeDTO> treeDatas = dss.getRangesByWhereSql("PERFGXCLASSIFICATION", null);
                Map<String, Object> treeMap = new HashMap<>();
                for (DicRangeDTO dicRangeDTO : treeDatas) {
                    treeMap.put(dicRangeDTO.getGuid(), dicRangeDTO);
                }
                for (Map<String, Object> map1 : caseList) {
                    DicRangeDTO dicRangeDTO = new DicRangeDTO();
                    String casetype = (String) map1.get("casetype");
                    dicRangeDTO.setGuid((String) map1.get("guid"));
                    dicRangeDTO.setName((String) map1.get("name"));
                    dicRangeDTO.setCode((String) map1.get("code"));
                    dicRangeDTO.setSuperguid((String) map1.get("casetype"));
                    dicRangeDTO.setIsleaf("1");
                    if (treeMap.containsKey(casetype)) {
                        DicRangeDTO d = (DicRangeDTO) treeMap.get(casetype);
                        d.setIsleaf("0");
                        Integer levelno = Integer.parseInt(d.getLevelno()) + 1;
                        dicRangeDTO.setLevelno(String.valueOf(levelno));
                        treeDatas.add(dicRangeDTO);
                    }
                }
//                logger.info("---treeDatas："+treeDatas.toString());
                map.put("datalist", JsonUtils.ListToRecordSet(treeDatas));
            } catch (IOException e) {
                logger.error(e.getMessage(), e);
            }
            return map;
        } else if (tabcode != null && "mode".equals(tabcode)) {
            tablecode = "v_perf_t_model";
            condition = " and framesystem = 'PM001'";
        } else {
            logger.error("请配置对应的选择页签!");
        }
        String province = CommonUtil.getProvince();//当前登录区划
        String isSx = PerfUtil.getSystemSet("isSX");
        //String sxsql = prjIndexDAO.getsxsql(province,sxflag);
        //上面的获取condition条件为空时，condition为null，执行下面的+=会变成null + 条件。
        //所以判断是否为null，为null赋值为"";
        if(condition==null){
            condition = "";
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            condition += tabfilter;
        }
        if(!StringUtil.isEmpty(wheredatarule)){
            condition += wheredatarule;
        }
        /*if(StringUtils.isNotBlank(isSx) && "1".equals(isSx) && !StringUtil.isEmpty(sxsql) && tabcode != null && !"index".equals(tabcode)){
            if("case".equals(tabcode)){//案例
                tablecode = "perf_t_case";
            }else if("mode".equals(tabcode)){//模板
                tablecode = "perf_t_model";
            }
            condition += sxsql;
        }*/
        List<Map<String, Object>> list = prjIndexDAO.finTreeData(tablecode, condition);
        //处理财政个性指标分类授权给部门
        String isGiveDept = PerfUtil.getSystemSet("INDEXFINAGIVEDEPT");
        if (StringUtils.isNotBlank(isGiveDept) && "1".equals(isGiveDept) && tabcode != null && "index".equals(tabcode)){
            String  dept = CommonUtil.getCurrentUser().getAgency();
            int usertype = CommonUtil.getCurrentUser().getUsertype();
            if (StringUtils.isNotBlank(isGiveDept) &&( 0 == usertype || 2 == usertype)){
                List backList = new ArrayList(); //返回值
                dept = dept.substring(0,3);
                String tempguid = "";
                String givecode = "";
                String is_common_ind = "";
                //int isleaf = 0;
                String superid =""; //父指标
                List<String> superList = new ArrayList<>();
                List<Map<String, Object>> givecodes = prjIndexDAO.getDatas("V_PERF_T_INDEXFINAGIVE", " agencyguid = '" + dept +"'", null);
                if (givecodes.size() > 0){
                    for (Map<String, Object> map : list) {
                        tempguid = (String) map.get("guid");
                        superid = (String) map.get("superid"); //父级
                        is_common_ind = (String) map.get("is_common_ind"); //1共性 0个性
                        // 推荐指标有isleaf字段。案例、模板都没有isleaf字段
                        //isleaf = PerfUtil.mapGetInt(map,"isleaf");
                        if ("0".equals(is_common_ind) && !StringUtil.isEmpty(superid) && !"indexcomfunc".equals(superid) && !"#".equals(superid)){
                            for (Map<String, Object> givemap : givecodes) {
                                givecode = (String) givemap.get("eltwoguid");
                                if (tempguid.equals(givecode)){
                                    backList.add(map);
                                    superList.add(superid);
                                }
                            }
                        } else if ("1".equals(is_common_ind) || "#".equals(superid)){
                            backList.add(map);
                        }
                    }
                    //从list中拿父节点
                    for (Map<String, Object> map : list) {
                        tempguid = (String) map.get("guid");
                        if (superList.contains(tempguid)){
                            backList.add(map);
                        }
                    }
                    list = backList;
                }
            }
        }
        list.addAll(listdept);
        HashMap map = new HashMap();
        try {
            map.put("datalist", JsonUtils.ListToRecordSet(list));
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        }
        return map;
    }

    /**
     * <p>引用指标-查询案例和模板的明细数据</p >
     *
     * @author hw
     * @date 2022/7/11 15:34
     * @param
     */
    public Map<String, Object> findTableDataNew(Map<String, Object> params) throws AppException {
        Map<String, Object> tempMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid"); //主键
        String showtab = (String) params.get("showtab");
        String filter = (String) params.get("filter");
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        List<Map<String, Object>> indexs = null;
        if (showtab != null && ("1".equals(showtab) || "3".equals(showtab))) {
            String wheresql = " mainguid='" + mainguid + "'";
            tempMap.put("yeargoalinfo",prjIndexDAO.getDataMap("v_perf_t_casemodelgoal", wheresql));
        }
        StringBuffer sql = new StringBuffer();
        sql.append("select t.*,t.indexvalue as indexval from v_perf_t_casemodelindex t where nvl(t.status, 2) <> 3 and t.mainguid = '");
        sql.append(mainguid).append("'");
        if (!StringUtil.isEmpty(filter)) {
            sql.append(" and ").append(filter);
        }
        sql.append(" order by t.sindex,t.findex,t.ordernum");
        logger.info("-------------案例指标查询sql-------------" + sql.toString());
        indexs =  prjIndexDAO.queryForList(sql.toString());
        backdata.addAll(indexs);
        tempMap.put("data", backdata);
        return tempMap;
    }


    /**     * 查询指标授权信息
     * @param authcode
     * @return
     */
    public List<Map<String, Object>> getAuthData(String authcode) throws AppException {
        List<Map<String, Object>> returnList = new ArrayList<>();
        Map<String, Object> map =new HashMap<>();
        map.put("selecttype","00");
        map.put("remark","本级指标");
        returnList.add(map);
        List<Map<String, Object>> indexList = prjIndexDAO.getDatas("PERF_T_INDEXAUTH", " authcode = '" + authcode + "' and status = 1 ", "order by selecttype");
        if(indexList!=null){
            returnList.addAll(indexList);
        }
        return returnList;
    }

    /**
     * 查询指标授权信息
     * @param
     * @return
     */
    public String getAuthTree(String authcode,String selectedAuth) throws AppException {
        String authTreeString = null;
        List<Map<String, Object>> returnList = prjIndexDAO.getDatas("PERF_T_INDEXAUTH", " authcode = '" + authcode + "' and selecttype = '" + selectedAuth + "' and status = 1 ", "order by ordernum");
        if(returnList!=null && returnList.size()>0){
            authTreeString = (String) (returnList.get(0).get("lefttree"));
        }
        return authTreeString;
    }

    /**
     * 查询调整前项目目标及指标.
     *
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws --           异常.
     */
    public Map<String, Object> findAdjustIndex(Map<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        Map<String, Object> totalsMap = new HashMap<String, Object>();
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        //获取调整前项目绩效目标
        Map<String, Object> goaldata = (Map<String, Object>) params.get("goaldata");
        if (goaldata != null && goaldata.size() > 0) {
            //中期指标
            List<Map<String, Object>> totallist = new ArrayList<>();
            List<Map<String, Object>> yearlist = new ArrayList<>();
            if(goaldata.get("#total") != null) {
                totallist = (List<Map<String, Object>>) goaldata.get("#total");
            }
            if(goaldata.get("#year") != null) {
                yearlist = (List<Map<String, Object>>) goaldata.get("#year");
            }
            for (Map<String, Object> map : totallist) {
                //目标id
                String goalguid = (String) map.get("guid");
                String sql = "select * from pm_perf_goal_info where is_backup=2 and is_deleted=2 and guid = '"+goalguid+"'";
                List<Map<String, Object>> goallist = prjIndexDAO.queryForList(sql);
                String year = null;
                if(goallist != null && goallist.size()>0){
                    year = String.valueOf(goallist.get(0).get("year"));
                }
                params.put("goalguid",goalguid);
                Map<String, Object> listmap = findAllIndex(params);
                List<Map<String, Object>> chexklist = (List<Map<String, Object>>) listmap.get("#total");
                Boolean flag = true;
                if(chexklist != null && chexklist.size()>0){
                    for(Map checkmap :chexklist){
                        if(checkmap.get("levelno")!= null && "3".equals(checkmap.get("levelno"))){
                            flag = false;
                            break;
                        }
                    }
                }
                if(flag && !StringUtil.isEmpty(year) && !year.equals(CommonUtil.getYear())){
                    params.remove("goalguid");
                    listmap = findAllIndex(params);
                }
                List<Map<String, Object>> list = new ArrayList<>();
                if(listmap.get("#total") != null) {
                    list = (List<Map<String, Object>>) listmap.get("#total");
                }
                totalsMap.put(goalguid,list);
            }
            //年度指标
           /* for (Map<String, Object> map : yearlist) {
                //目标id
                String goalguid = (String) map.get("guid");
                String year = (String) map.get("year");
                params.put("goalguid",goalguid);
                Map<String, Object> listmap = findAllIndex(params);
                if(listmap.get("#year") == null && !StringUtil.isEmpty(year) && !year.equals(CommonUtil.getYear())){
                    params.remove("goalguid");
                    listmap = findAllIndex(params);
                }
                List<Map<String, Object>> list = new ArrayList<>();
                if(listmap.get("#year") != null) {
                    list = (List<Map<String, Object>>) listmap.get("#year");
                }
                yearsMap.put(goalguid,list);
            }*/
        }
        backMap.put("#total",totalsMap);
        backMap.put("#year",yearsMap);
        return backMap;
    }

    /**
     * 获取项目年度绩效指标包含多少年度.
     * @param params -- 参数。
     * @return
     * @throws AppException
     */
    public List getYearOption(Map<String, Object> params) throws AppException {
        String procode = (String) params.get("procode");
        String province = (String) params.get("province");
        String adjadd = (String) params.get("adjadd");
        StringBuffer sql = new StringBuffer("select t.year from pm_perf_indicator t where");
        sql.append(" t.province = '").append(province).append("'");
        sql.append(" and t.pro_code = '").append(procode).append("'");
        sql.append(" and t.is_deleted = 2 and is_backup =2 and t.yearflag = '0' and sub_mof_div_code is null ");
        //项目库不是调整查询是添加是否调整终审条件
        if (!"1".equals(adjadd) && PerfUtil.getProgramIsyear()) {
            sql.append(" and nvl(is_adj, 2) = 2");
        }
        sql.append(" group by t.year order by year desc");
        List<Map> list = prjIndexDAO.queryForList(sql.toString());
        List elements = new ArrayList();
        list.forEach(e -> {
            Map<String, String> tempMap = new HashMap<>();
            tempMap.put("guid", e.get("year")+"");
            tempMap.put("itemid", e.get("year")+"");
            tempMap.put("code", e.get("year")+"");
            tempMap.put("name", e.get("year")+"");
            tempMap.put("superitemid", "0");
            tempMap.put("levelno", "1");
            tempMap.put("isleaf", "1");
            elements.add(tempMap);
        });
        return elements;
    }

    /**
     * 查看切换年度，获取不同年度绩效指标.
     * @param params -- 区划，年度参数
     * @return
     * @throws AppException
     */
    public Map<String, Object> getYearIndicator(Map<String, Object> params) throws AppException {
        Map backMap = new HashMap();
        String province = (String) params.get("province");
        String year = (String) params.get("year");
        String procode = (String) params.get("procode");
        String adjadd = (String) params.get("adjadd");
        String proguid = (String) params.get("proguid");
        StringBuffer sql = new StringBuffer(" t.province = '").append(province).append("'");
        sql.append(" and t.year = '").append(year).append("'");
        sql.append(" and t.pro_code = '").append(procode).append("'");
        sql.append(" and t.is_deleted = 2 and is_backup =2 and t.yearflag = '0' and sub_mof_div_code is null ");
        //项目库不是调整查询是添加是否调整终审条件
        if (!"1".equals(adjadd) && PerfUtil.getProgramIsyear()) {
            sql.append(" and nvl(is_adj, 2) = 2");
        }
        //获取模板数据
        List<Map<String, Object>> collist = prjIndexDAO.getCol("V_PM_PERF_INDICATOR");
        String tempsql = "select t.ele_code as guid,t.parent_id as superid, t.ele_code as code,t.ele_name as name," +
                " t.level_no as levelno,t.is_leaf as isleaf, '1' as rowtype, weight as frameweight, ordernum " +
                " from perf_t_frame t where frametype='PM001' and t.province = '" + province
                + "' and t.year = '" + year + "' and t.is_deleted = 2 order by ordernum";
        List<Map<String, Object>> flist = prjIndexDAO.queryForList(tempsql);
        List<Map<String, Object>> tempdatas = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : flist) {
            String guid = (String) map.get("guid");
            String superId = (String) map.get("superid");
            String levelNo = map.get("levelno") + "";
            if (levelNo != null && !"1".equals(levelNo)) {
                map.put("findex", superId);
                map.put("sindex", guid);
            }
            tempdatas.add(map);
        }
        //指标数据
        List<Map<String, Object>> indexdatas = prjIndexDAO.getDatas("PM_PERF_INDICATOR", sql.toString(), " order by ordernum");

        List<Map<String,Object>> datas = new ArrayList<>();
        //模板数据
        for (Map<String, Object> tempdata : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = tempdata.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    tempdata.put(col, "");
                }
            }
            tempdata.put("_isleaf", "1");
            datas.add(tempdata);
        }
        if (indexdatas.size() > 0) {
            //项目库阶段填报年度绩效，涉及到调整查询，查寻到数据是多份，进行筛选数据
            if (PerfUtil.getProgramIsyear() && "1".equals(adjadd)) {
                Map<String, Object> proMap = this.getDataMap(prjIndexDAO.PMKPI_TABLE_ALLPROJECT_INFO, "guid=?", new String[]{proguid});
                String proyear = (String) proMap.get("year");//查询调整年度
                List<Map<String, Object>> adjList = new ArrayList<>();
                for (Map<String, Object> data : indexdatas) {
                    String is_adj = data.get("is_adj") + "";
                    String mainguid = (String) data.get("mainguid");
                    if (!"null".equals(is_adj) && proguid.equals(mainguid)) {
                        adjList.add(data);
                    }
                }
                //调整查看，同年项目发生调整，调整存在年度数据，展示调整数据，过滤调前数据
                if (adjList.size() > 0) {
                    datas.addAll(adjList);
                } else if (!year.equals(proyear)) { //调整查看，查看非调整年度数据
                    datas.addAll(indexdatas);
                }
            } else {
                datas.addAll(indexdatas);
            }
        }
        backMap.put("data",datas);
        return  backMap;
    }


    /**
     * 转移支付数据接收
     * @param year
     * @param province
     * @param goalList
     * @param indexList
     * @return
     * @throws AppException
     */
    public Map<String, Object> savetransferdata(String year, String province,Integer type, List<Map<String, Object>> goalList,List<Map<String, Object>> indexList) throws AppException {
        Map<String,Object> resultMap = new HashMap<>();
        if (StringUtil.isEmpty(province) || StringUtil.isEmpty(year) || type == null || goalList == null || goalList.size() == 0 || indexList == null || indexList.size() == 0) {
            resultMap.put("sucess","false");
            resultMap.put("msg", "接口必传参数为空，请检查！");
            return resultMap;
        }
        List<Map<String, Object>> addGoalList = new ArrayList<>();
        List<Map<String, Object>> addIndexList = new ArrayList<>();
        List<String> delcodelist = new ArrayList<>();
        List<String> delidlist = new ArrayList<>();
        HashMap<String,String> proidmap = new HashMap<>();
        //处理目标数据
        if (goalList != null && goalList.size() > 0) {
            for(Map goalmap : goalList){
                //项目id不为空则直接保存 为空则生成项目id 同一个pro_code项目id一致
                String proguid = String.valueOf(goalmap.get("pro_id"));
                String procode = String.valueOf(goalmap.get("pro_code"));
                delcodelist.add(procode);
                if(goalmap.get("pro_id") == null){
                    if(proidmap.containsKey(procode)){
                        proguid = proidmap.get(procode);
                    }else {
                        proguid = this.getCreateguid();
                        proidmap.put(procode, proguid);
                    }
                }
                delidlist.add(proguid);
                goalmap.put("mainguid", proguid);
                goalmap.put("proguid", proguid);
                String guid = this.getCreateguid();
                goalmap.put("guid", goalmap.get("kpi_per_id") == null ? guid : goalmap.get("kpi_per_id"));
                goalmap.put("kpi_per_id", goalmap.get("guid"));
                String perf_obj_type_code = String.valueOf(goalmap.get("perf_obj_type_code"));//项目绩效类型代码(1、项目整体绩效；2、项目年度绩效)
                goalmap.put("yearflag", "1".equals(perf_obj_type_code) ? 1 : 0);
                goalmap.put("version",PerfConstant.PMKPI_VERSION_RCDTWH);//日常动态维护
                goalmap.put("version_name",PerfConstant.PMKPI_VERSION_NAME_RCDTWH+"转移支付接收");
                //来源方财政区划代码,来源方财政区划名称
                goalmap.put("ori_div_code", String.valueOf(goalmap.get("mof_div_code")));
                goalmap.put("ori_div_name", String.valueOf(goalmap.get("mof_div_name")));
                this.setIndexMap(goalmap);
                goalmap.put("is_last_inst", "1");//是否终审
                addGoalList.add(goalmap);
            }
        }

        //处理指标数据
        if(indexList != null && indexList.size() > 0){
            for(Map indexmap : indexList){
                //项目id不为空则直接保存 为空则生成项目id 同一个pro_code项目id一致
                String proguid = String.valueOf(indexmap.get("pro_id"));
                String procode = String.valueOf(indexmap.get("pro_code"));
                if(indexmap.get("pro_id") == null){
                    if(proidmap.containsKey(procode)){
                        proguid = proidmap.get(procode);
                    }
                }
                indexmap.put("mainguid", proguid);
                indexmap.put("proguid", proguid);
                indexmap.put("findex", String.valueOf(indexmap.get("lv1_perf_ind_code")));
                indexmap.put("sindex", String.valueOf(indexmap.get("lv2_perf_ind_code")));
                String guid = this.getCreateguid();
                indexmap.put("guid", indexmap.get("kpi_id")==null ? guid : indexmap.get("kpi_id"));
                indexmap.put("kpi_id", indexmap.get("guid"));
                String perf_obj_type_code = String.valueOf(indexmap.get("perf_obj_type_code"));//项目绩效类型代码(1、项目整体绩效；2、项目年度绩效)
                indexmap.put("yearflag", "1".equals(perf_obj_type_code) ? 1 : 0);
                indexmap.put("version",PerfConstant.PMKPI_VERSION_RCDTWH);//日常动态维护
                indexmap.put("version_name",PerfConstant.PMKPI_VERSION_NAME_RCDTWH+"转移支付接收");
                //来源方财政区划代码,来源方财政区划名称
                indexmap.put("ori_div_code", String.valueOf(indexmap.get("mof_div_code")));
                indexmap.put("ori_div_name", String.valueOf(indexmap.get("mof_div_name")));
                this.setIndexMap(indexmap);
                indexmap.put("is_last_inst", "1");//是否终审
                addIndexList.add(indexmap);
            }
        }
        //保存数据
        String timestamp = PerfUtil.getServerTimeStamp();
        String codeinsql = prjIndexDAO.createInSql("pro_code", delcodelist);
        String proidinsql = prjIndexDAO.createInSql("mainguid", delidlist);
        String updateindexsql = "";
        if(addGoalList.size() > 0){
            //1项目库调用2指标调用
            if(type == 1){
                updateindexsql = "update " + PerfConstant.PMKPI_BACKUP_GOAL_INFO + " t set is_deleted = 1,updatetime = ?,update_time = ? where " +
                        proidinsql + " and is_deleted = 2 and is_backup = 2 and yearflag = '1' and province = ?";
                prjIndexDAO.update(updateindexsql, new String[]{timestamp,timestamp,province});
            }else{
                updateindexsql = "update " + PerfConstant.PMKPI_BACKUP_GOAL_INFO + " t set is_deleted = 1,updatetime = ?,update_time = ? where " +
                        codeinsql + " and is_deleted = 2 and is_backup = 2 and yearflag = '0' and province = ? and year = ?";
                prjIndexDAO.update(updateindexsql, new String[]{timestamp,timestamp,province,year});
            }
            prjIndexDAO.saveAll(addGoalList, PerfConstant.PMKPI_BACKUP_GOAL_INFO);
        }
        if(addIndexList.size() > 0){
            //1项目库调用2指标调用
            if(type == 1){
                updateindexsql = "update " + PerfConstant.PMKPI_BACKUP_INDICATOR + " t set is_deleted = 1,updatetime = ?,update_time = ? where " +
                        proidinsql + " and is_deleted = 2 and is_backup = 2 and yearflag = '1' and province = ?";
                prjIndexDAO.update(updateindexsql, new String[]{timestamp, timestamp, province});
            }else {
                updateindexsql = "update " + PerfConstant.PMKPI_BACKUP_INDICATOR + " t set is_deleted = 1,updatetime = ?,update_time = ? where " +
                        codeinsql + " and is_deleted = 2 and is_backup = 2 and yearflag = '0' and province = ? and year = ?";
                prjIndexDAO.update(updateindexsql, new String[]{timestamp, timestamp, province,year});
            }
            prjIndexDAO.setIndexDatas(addIndexList,"PM001",false);
            prjIndexDAO.saveAll(addIndexList, PerfConstant.PMKPI_BACKUP_INDICATOR);
        }
        resultMap.put("sucess","true");
        resultMap.put("msg", "转移支付数据接收成功");
        return resultMap;
    }

    /**
     * 同步各阶段版本号
     * @param year
     * @param province
     * @param action
     * @param type
     * @param datalist
     * @return
     * @throws AppException
     */
    public Map<String, Object> updateVersion(String year, String province, String action, String type, List<Map<String, Object>> datalist) throws AppException {
        Map<String,Object> resultMap = new HashMap<>();
        //校验参数必填
        if (!StringUtil.isEmpty(action) && !StringUtil.isEmpty(type) && !StringUtil.isEmpty(province) && !StringUtil.isEmpty(year) && datalist != null && datalist.size()>0) {
            List<String> delcodelist = new ArrayList<String>();
            List<String> addcodelist = new ArrayList<String>();
            List<String> addproidlist = new ArrayList<String>();
            HashMap<String, String> versionmap = new HashMap<String, String>();
            for (Map map : datalist) {
                String pro_code = String.valueOf(map.get("pro_code"));
                String proguid = String.valueOf(map.get("pro_id"));
                //项目编码及项目id必填
                if (StringUtil.isEmpty(pro_code) || StringUtil.isEmpty(proguid)) {
                    resultMap.put("result_code","0001");
                    resultMap.put("reason", "项目编码或项目id为空，请检查！");
                    return resultMap;
                }
                String version = String.valueOf(map.get("version"));
                String version_name = String.valueOf(map.get("version_name"));
                if ("1".equals(action)) {//正向（纳入预算编制，取消批复，）
                    //list中存储所有需要同步版本的项目编码和id为获取目标指标做准备
                    addcodelist.add(pro_code);
                    addproidlist.add(proguid);
                    //版本map 处理数据时可以直接根据项目编码获取版本信息
                    versionmap.put(pro_code + "#version", version);
                    versionmap.put(pro_code + "#versionname", version_name);
                }
                //反向（取消纳入预算，取消批复，执行作废）
                delcodelist.add(pro_code);
            }
            List<Map<String, Object>> addGoalList = new ArrayList<Map<String, Object>>();
            List<Map<String, Object>> addIndexList = new ArrayList<Map<String, Object>>();
            if ("1".equals(action)) {
                String codeinsql = prjIndexDAO.createInSql("pro_code", addcodelist);
                String proidinsql = prjIndexDAO.createInSql("mainguid", addproidlist);
                List<Map<String, Object>> goals = new ArrayList<Map<String, Object>>();
                List<Map<String, Object>> indexs = new ArrayList<Map<String, Object>>();
                if("2".equals(type) || "3".equals(type)){//1.预算编制 2.预算批复 3.预算执行
                    //获取业务表年度数据
                    String addgoalsql = "select * from PM_PERF_GOAL_INFO t where " + codeinsql + " and is_backup = 2 and yearflag = '0' and is_deleted=2 and province = '" + province + "' and year = '" + year + "'";
                    goals = prjIndexDAO.queryForList(addgoalsql);
                    String addindexsql = "select * from PM_PERF_INDICATOR t where " + codeinsql + " and is_backup = 2 and yearflag = '0' and is_deleted=2 and province = '" + province + "' and year = '" + year + "'";
                    indexs = prjIndexDAO.queryForList(addindexsql);
                }
                //获取业务表长期数据
                String addtgoalsql = "select * from PM_PERF_GOAL_INFO where " + proidinsql + " and is_deleted = 2 and is_backup = 2 and yearflag = '1' and province = '"+province+"'";
                List<Map<String, Object>> tgoals = prjIndexDAO.queryForList(addtgoalsql);
                String addtindexsql = "select * from PM_PERF_INDICATOR where " + proidinsql + " and is_deleted = 2 and is_backup = 2 and yearflag = '1' and province = '"+province+"'";
                List<Map<String, Object>> tindexs = prjIndexDAO.queryForList(addtindexsql);
                goals.addAll(tgoals);
                indexs.addAll(tindexs);
                //拼装目标数据
                if (goals != null && goals.size() > 0) {
                    for (Map goal : goals) {
                        String pro_code = String.valueOf(goal.get("pro_code"));
                        String version = versionmap.get(pro_code + "#version");
                        String versionname = versionmap.get(pro_code + "#versionname");
                        goal.put("version", version);
                        goal.put("version_name", versionname);
                        String guid = StringUtil.createUUID();
                        goal.put("kpi_per_id", guid);//日志数据重新生成主键id
                        goal.put("guid", guid);
                        goal.put("is_backup", 1);//1 版本记录 2 日常动态
                        goal.put("versiontype", type);//0 日常动态 1 编制 2 批复，3执行
                        goal.get("yearflag");
                        //根据type判断是否终审
                        String yearflag = goal.get("yearflag") == null ? "0" : (String) goal.get("yearflag");
                        //如果是年度指标并且type为预算批复 则is_last_inst为1
                        if(!StringUtil.isEmpty(yearflag) && "0".equals(yearflag)){
                            goal.put("is_last_inst", 1);
                        }
                        goal.put("createtime", PerfUtil.getServerTimeStamp());
                        goal.put("create_time", PerfUtil.getServerTimeStamp());
                        goal.put("updatetime", PerfUtil.getServerTimeStamp());
                        goal.put("update_time", PerfUtil.getServerTimeStamp());
                        addGoalList.add(goal);
                    }
                    //拼装指标数据
                    for (Map index : indexs) {
                        String pro_code = String.valueOf(index.get("pro_code"));
                        String version = versionmap.get(pro_code + "#version");
                        String versionname = versionmap.get(pro_code + "#versionname");
                        index.put("version", version);
                        index.put("version_name", versionname);
                        String guid = StringUtil.createUUID();
                        index.put("kpi_id", guid);//日志数据重新生成主键id
                        index.put("guid", guid);
                        index.put("is_backup", 1);//1 版本记录 2 日常动态
                        index.put("versiontype", type);//0 日常动态 1 编制 2 批复，3执行
                        //根据type判断是否终审
                        String yearflag = (String) index.get("yearflag") == null ? "0" : (String) index.get("yearflag");
                        //如果是年度指标并且type为预算批复 则is_last_inst为1
                        if(!StringUtil.isEmpty(yearflag) && "0".equals(yearflag)){
                            index.put("is_last_inst", 1);
                        }
                        index.put("createtime", PerfUtil.getServerTimeStamp());
                        index.put("create_time", PerfUtil.getServerTimeStamp());
                        index.put("updatetime", PerfUtil.getServerTimeStamp());
                        index.put("update_time", PerfUtil.getServerTimeStamp());
                        addIndexList.add(index);
                    }

                }
            }
            //反向则将数据删除
            String delcodeinsql = prjIndexDAO.createInSql("pro_code", delcodelist);
            String timestamp = PerfUtil.getServerTimeStamp();
            //删除年度数据
            if("2".equals(type) || "3".equals(type)) {
                String updateygoalsql = "update " + PerfConstant.PMKPI_BACKUP_GOAL_INFO + " t set is_deleted = 1,updatetime = ?,update_time = ? where " +
                        delcodeinsql + " and is_deleted = 2 and is_backup = 1 and versiontype = ? and yearflag = '0' and province = ? and year = ?";
                prjIndexDAO.update(updateygoalsql, new String[]{timestamp, timestamp, type, province, year});
                String updateyindexsql = "update " + PerfConstant.PMKPI_BACKUP_INDICATOR + " t set is_deleted = 1,updatetime = ?,update_time = ? where " +
                        delcodeinsql + " and is_deleted = 2 and is_backup = 1 and versiontype = ? and yearflag = '0' and province = ? and year = ?";
                prjIndexDAO.update(updateyindexsql, new String[]{timestamp, timestamp, type, province, year});
            }
            //删除长期数据
            String wheresql = delcodeinsql + " and is_deleted = 2 and is_backup = 1 and versiontype = "+type+" and yearflag = '1' and province = '"+province+"'";
            prjIndexDAO.updateIsDeleteDatas(PerfConstant.PMKPI_BACKUP_GOAL_INFO,wheresql);
            prjIndexDAO.updateIsDeleteDatas(PerfConstant.PMKPI_BACKUP_INDICATOR,wheresql);
            //正向日志数据保存
            if (addGoalList.size() > 0) {
                prjIndexDAO.saveAll(addGoalList, PerfConstant.PMKPI_BACKUP_GOAL_INFO);
            }
            if (addIndexList.size() > 0) {
                prjIndexDAO.saveAll(addIndexList, PerfConstant.PMKPI_BACKUP_INDICATOR);
            }
        }else{
            resultMap.put("result_code","0001");
            resultMap.put("reason", "接口必传参数为空，请检查！");
            return resultMap;
        }
        resultMap.put("result_code","0000");
        return resultMap;
    }

    /**
     * 项目年度绩效相关信息查询
     * @param codeList -- 项目编码集合.
     * @param year -- 年度.
     * @param province -- 区划.
     * @return list.
     */
    public List queryProperf(List<String> codeList, String year, String province) throws AppException {
        List<Map<String, Object>> returnList = new ArrayList<>();
        prjIndexDAO.setYearAndProvince(year,province);
        List<Map<String, Object>> procodelist = new ArrayList<>();
        codeList.forEach(s -> {
            Map m = new HashMap<String,Object>();
            m.put("guid",s);
            procodelist.add(m);
        });
        prjIndexDAO.saveAll(procodelist, prjIndexDAO.PMKPI_TABLE_TMP_GUIDS);
        String sql = " exists(select 1 from " + prjIndexDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code)";
        List<Map<String, Object>> proList = prjIndexDAO.getDatas("v_perf_queryProperf_info", sql, "order by t.pro_code");
        if(proList!=null && proList.size()>0){
            returnList = proList;
            List<Map<String, Object>> indexList = prjIndexDAO.getDatas("v_perf_queryProperf_index", sql, "order by t.pro_code");
            if(indexList.size() == 0){
                proList.forEach(r->{r.put("guid",r.get("pro_code"));});
                prjIndexDAO.saveAll(proList,"PERF_TMP_GUIDS");
                indexList = prjIndexDAO.getQueryPerfIndex(CommonUtil.getProvince(),CommonUtil.getYear());
            }
            Map<String,List<Map<String, Object>>> map = indexList.stream().collect(Collectors.groupingBy(x -> (String)x.get("pro_code")));
            proList.forEach(m -> {
                m.remove("guid");
                String procode = (String) m.get("pro_code");
                m.put("indexs",map.get(procode));
            });
        }
        return returnList;
    }

    /**
     * 项目删除同步删除绩效数据
     * 1、储备删除 2、调整删除 3、调整终审删除 4、取消调整终审，需要还原调整前数据,9、项目终止is_end=1
     * 还有就是项目库取消纳入今年的预算编制的环节删除。
     * @throws AppException
     */
    public Map delGoalAndIndex(String deltype, List<Map<String, Object>> proList) throws AppException {
        Map<String,Object> resultMap = new HashMap<>();
        if("9".equals(deltype)){
            resultMap.put("success", "true");
            resultMap.put("msg", "刪除成功");
            logger.info("---------------项目终止，不处理总体和年度绩效---------------");    //项目guid
            return  resultMap;
        }
        if (proList != null && proList.size() >0) {
            String columnname = "mainguid";
            String adjwheresql = "";
            String wheresql = "";
            String is_adjsql = "";
//            String is_last_inst = "";
            //封装项目id
            List<String> proGuids = new ArrayList<>();
            List<String> adjGuids = new ArrayList<>();
            StringBuffer upsql = new StringBuffer();
            if ("1".equals(deltype) || "2".equals(deltype) || "9".equals(deltype)) {
                upsql.append(" is_deleted = 1, status = null ");
                wheresql = " is_deleted=2 ";
            } else if ("3".equals(deltype) ) {
                upsql.append(" is_deleted = 1, status = 5 ");
                adjwheresql = wheresql = " is_deleted=2 ";
                is_adjsql = " is_adj=2 ";
//                is_last_inst = " is_last_inst = 1";
            } else if ("4".equals(deltype)) {
                upsql.append(" is_deleted = 2, status = null ");
                adjwheresql = " is_deleted=2 ";
                wheresql = " status = 5 ";
                is_adjsql = " is_adj=1 ";
//                is_last_inst = " is_last_inst = 2";
            }
            String proguid = "";
            for (Map<String, Object> proMap : proList) {
                if ("1".equals(deltype) || "3".equals(deltype) || "4".equals(deltype) || "9".equals(deltype)) {
                    proguid = (String) proMap.get("proguid");
                } else if ("2".equals(deltype)) {
                    proguid = (String) proMap.get("adj_proguid");
                }
                adjGuids.add((String) proMap.get("adj_proguid"));
                proGuids.add(proguid);
            }
            prjIndexDAO.updateAllByColumn(columnname, proGuids, "perf_t_assessment", upsql.toString(), wheresql);
            prjIndexDAO.updateAllByColumn(columnname, proGuids, "perf_t_assessmentopinion", upsql.toString(), wheresql);
            prjIndexDAO.updateAllByColumn(columnname, proGuids, BeforeviewDAO.PERF_TABLE_BEFOREVIEW, upsql.toString(), wheresql);
            wheresql += " and is_backup=2 and province='" + CommonUtil.getProvince() + "'";
            adjwheresql += " and is_backup=2 and province='" + CommonUtil.getProvince() + "'";
            String isZJ = PerfUtil.getSystemSet("isZJ");
            String goaltable = "pm_perf_goal_info";
            String indextable = "pm_perf_indicator";
            if("1".equals(isZJ)){ //浙江的一级项目前提：一级项目，调整后，绩效表保存的mianguid 为调整后项目的proid，而不是原来项目的id.
                List list = prjIndexDAO.queryForList("select to_char(level_no) as pro_lev from v_pm_project_info where pro_id = '" + proGuids.get(0) + "'");
                logger.info("项目list:+++++++++++++++++【" + list + "】+++++++++++++isZJ+++++++++++++：" + isZJ);
                if (list.size() > 0){
                    Map map = (Map) list.get(0);
                    String pro_lev = (String) map.get("pro_lev");
                    logger.info("pro_lev:+++++++++++++++++【" + pro_lev + "】");
                    if("1".equals(pro_lev)){ // 浙江一级项目为年度绩效，二级为总体绩效
                        if(!"1".equals(deltype)){// 浙江 一级项目只报年度绩效，调整相关不能删除，只有一份数据，只有deltype=1储备处理
                            resultMap.put("success", "true");
                            resultMap.put("msg", "刪除成功");
                            logger.info("---------------浙江一级项目调整，不做删除处理---------------");
                            return  resultMap;
                        }
                        wheresql += " and yearflag='0' and year = " + CommonUtil.getYear(); //调整每次都变项目guid 3调整终审，跨年调整不能删除上年年度绩效
                    }else if ("2".equals(deltype) || "3".equals(deltype) || "4".equals(deltype) || "9".equals(deltype)) {
                        wheresql += " and yearflag='1' ";
                    }
                    prjIndexDAO.updateAllByColumn(columnname, proGuids, goaltable, upsql.toString(), wheresql);
                    prjIndexDAO.updateAllByColumn(columnname, proGuids, indextable, upsql.toString(), wheresql);
                    //处理调整项目终审状态
//                    if ("3".equals(deltype) || "4".equals(deltype)) {
//                        prjIndexDAO.updateAllByColumn(columnname, adjGuids, goaltable, is_last_inst, adjwheresql);
//                        prjIndexDAO.updateAllByColumn(columnname, adjGuids, indextable, is_last_inst, adjwheresql);
//                    }
                } else {
                    throw new AppException("项目信息不存在！！");
                }
            } else if (PerfUtil.getProgramIsyear()) {
                prjIndexDAO.updateAllByColumn(columnname, proGuids, goaltable, upsql.toString(), wheresql + " and t.year='" + SecureUtil.getUserSelectYear() + "' and yearflag='0'");
                prjIndexDAO.updateAllByColumn(columnname, proGuids, indextable, upsql.toString(), wheresql + " and t.year='" + SecureUtil.getUserSelectYear() + "' and yearflag='0'");
            }
            if(!"1".equals(isZJ)){
                //处理调整项目终审状态
//                if ("3".equals(deltype) || "4".equals(deltype)) {
//                    prjIndexDAO.updateAllByColumn(columnname, adjGuids, goaltable, is_last_inst, adjwheresql + " and yearflag='1'");
//                    prjIndexDAO.updateAllByColumn(columnname, adjGuids, indextable, is_last_inst, adjwheresql + " and yearflag='1'");
//                }
                //处理总体
                String temsql = "";
                if ("2".equals(deltype) || "3".equals(deltype) || "4".equals(deltype) || "9".equals(deltype)) {
                    temsql = " and yearflag='1' ";
                }
                prjIndexDAO.updateAllByColumn(columnname, proGuids, goaltable, upsql.toString(), wheresql + temsql);
                prjIndexDAO.updateAllByColumn(columnname, proGuids, indextable, upsql.toString(), wheresql + temsql);
                if (PerfUtil.getProgramIsyear() && !StringUtil.isEmpty(is_adjsql)) {//调整存储年度数据时，调整终审is_adj=2，取消调整is_adj=1
                    adjwheresql += " and yearflag = '0'";
                    prjIndexDAO.updateAllByColumn(columnname, adjGuids, goaltable, is_adjsql, adjwheresql);
                    prjIndexDAO.updateAllByColumn(columnname, adjGuids, indextable, is_adjsql, adjwheresql);
                }
            }
            /* 申报终审、调整终审还会调用 项目基本信息修改 接口，有重复保存数据到部门指标库的操作
            //江西申报终审，调整终审年度绩效指标进入部门指标库并终审.
            if (PerfUtil.getProendTolib() && "3".equals(deltype) && PerfUtil.get_IsJiangXi()){
                if (adjGuids != null && adjGuids.size() > 0){
                    //处理年度绩效指标转换为部门指标库。并终审.
                    StringBuffer prosql = new StringBuffer(" select * from pm_perf_indicator where ");
                    prosql.append(prjIndexDAO.createInSql("mainguid", adjGuids));
                    prosql.append(" and is_deleted=2 and is_backup=2 and province='").append(SecureUtil.getUserSelectProvince()).append("'")
                            .append("and year=").append(SecureUtil.getUserSelectYear()).append(" and yearflag='0' and islinked = '1' and is_add = '1'"); //入库标识
                    List<Map> indexlist =prjIndexDAO.queryForList(prosql.toString());
                    if (indexlist.size() > 0){
                        prosql = new StringBuffer("select t.pro_id,t.pro_code,t.projectkind from v_perf_allproject_info t where ");
                        prosql.append(prjIndexDAO.createInSql("pro_id", adjGuids));
                        List<Map> list = prjIndexDAO.queryForList(prosql.toString());
                        Map<String,String> proMap = new HashMap<>();
                        list.forEach(r->{
                            String proid = (String) r.get("pro_id");
                            if (!proMap.containsKey(proid)){
                                proMap.put(proid,String.valueOf(r.get("projectkind")));
                            }
                        });
                        logger.info("项目支出类别pro_cat_code：=================="+proMap.toString()+"==================");
                        String tempstamp = PerfUtil.getServerTimeStamp();
                        indexlist.forEach(r->{
                            String tempmainguid = String.valueOf(r.get("mainguid"));
                            r.put("wfid","2F62B0E1A972408B8330D3653F836522");
                            r.put("wfstatus","011");
                            r.put("createtime",tempstamp);
                            r.put("create_time",tempstamp);
                            r.put("updatetime",tempstamp);
                            r.put("update_time",tempstamp);
                            r.put("status",1);
                            r.put("framesystem","PM001");
                            r.put("ind_id",r.get("guid"));
                            r.put("perf_ind_code",r.get("code"));
                            r.put("perf_ind_name",r.get("name"));
                            r.put("is_common_ind", "2");
                            r.put("value_desc",r.get("name"));
                            r.put("parent_id",r.get("sindex"));
                            r.put("level_no",3);
                            r.put("is_leaf",1);
                            r.put("is_enabled",1);
                            r.put("start_date","20230801");
                            r.put("end_date","20991230");
                            r.put("indexvalue",r.get("indexval"));
                            r.put("is_pm_perf_ind",1);
                            r.put("is_last_inst",1);
                            if (proMap.containsKey(tempmainguid) && "32".equals((String) proMap.get(tempmainguid))){
                                r.put("value_change","1");//转移支付项目
                            } else {
                                r.put("value_change","2");//非转移支付项目
                            }
                        });
                        prjIndexDAO.saveAll(indexlist,"V_BAS_PERF_INDICATOR");
                        //将调整的指标的总体+年度的：是否新增，是否入库，is_add,is_linked,INDEXCATEGORIES,INDUSTRYCATEGORY,INDEXCATEGORY,FILED,OCCUPATION 清空
                        //String tepsql = " is_add=2,islinked='2',indexcategories = null,industrycategory=null,indexcategory=null,filed=null,occupation=null ";
                        //prjIndexDAO.updateAllByColumn("mainguid", adjGuids, indextable, tepsql, wheresql);
                    }
                }
            }*/
        }
        resultMap.put("success", "true");
        resultMap.put("msg", "刪除成功");
        logger.info("---------------删除绩效目标、指标結束---------------");    //项目guid
        return  resultMap;
    }

    public Map<String, Object> getparentproindex(Map<String, Object> params) throws AppException {
        Map<String,Object> resultMap = new HashMap<>();
        String proguid = (String) params.get("proguid");
        String parentproid = (String) params.get("parentproid");
        String yearflag = (String) params.get("yearflag");
        List<Map<String, Object>> totalParentIndex = prjIndexDAO.getParentProIndexData(proguid,parentproid,yearflag);
        resultMap.put("parentproindex",totalParentIndex);
        return  resultMap;
    }

    /**
     * 保存项目绩效日志
     */
    public Map<String, Object> saveperflog(Map<String, Object> params) throws AppException {
        Map<String, Object> resultMap = new HashMap<>();
        String province = (String) params.get("province");
        String year = (String) params.get("year");
        List<Map<String, Object>> projectList = (List<Map<String, Object>>) params.get("prolist");

        // 表名常量
        final String GOAL_TABLE = "pm_perf_goal_info";
        final String INDEX_TABLE = "pm_perf_indicator";
        final String ASSESSMENT_TABLE = "v_perf_t_assessment";
        final String GOAL_LOG_TABLE = "pm_perf_goal_info_log";
        final String INDEX_LOG_TABLE = "pm_perf_indicator_log";
        final String ASSESSMENT_LOG_TABLE = "perf_t_assessment_log";

        boolean isProYear = PerfUtil.getProgramIsyear();

        // 查询业务数据
        List<Map<String, Object>> goalList = new ArrayList<>();
        List<Map<String, Object>> indexList = new ArrayList<>();
        List<Map<String, Object>> assessmentList = new ArrayList<>();

        StringBuilder whereClause = new StringBuilder("is_deleted=2 and is_backup=2 and province=?");
        StringBuilder projectIdBuffer = new StringBuilder();
        StringBuilder projectCodeBuffer = new StringBuilder();
        Map<String, Object> logguidMap = new HashMap<>();

        for (int i = 0; i < projectList.size(); i++) {
            Map<String, Object> project = projectList.get(i);
            if (i != 0) {
                projectIdBuffer.append(",");
                projectCodeBuffer.append(",");
            }
            projectIdBuffer.append("'").append(project.get("pro_id")).append("'");
            projectCodeBuffer.append("'").append(project.get("pro_code")).append("'");
            logguidMap.put((String) project.get("pro_id"), project.get("logguid"));
        }

        if (isProYear) {
            //项目录入填报年度，全部根据id查
            String proSql = " and mainguid in (" + projectIdBuffer.toString() + ") ";
            String aWhereSql = whereClause.toString() + proSql;
            goalList = prjIndexDAO.getDatas(GOAL_TABLE, aWhereSql, null, new String[]{province});
            indexList = prjIndexDAO.getDatas(INDEX_TABLE, aWhereSql, null, new String[]{province});
        } else {
            //根据id查总体，根据code查年度
            String tProSql = " and yearflag=? and mainguid in (" + projectIdBuffer.toString() + ") ";
            String tWhereSql = whereClause.toString() + tProSql;
            List<Map<String, Object>> totalGoalList = prjIndexDAO.getDatas(GOAL_TABLE, tWhereSql, null, new String[]{province, "1"});
            List<Map<String, Object>> totalIndexList = prjIndexDAO.getDatas(INDEX_TABLE, tWhereSql, null, new String[]{province, "1"});
            goalList.addAll(totalGoalList);
            indexList.addAll(totalIndexList);

            String yProSql = " and yearflag=? and pro_code in (" + projectCodeBuffer.toString() + ") ";
            String yWhereSql = whereClause.toString() + yProSql;
            List<Map<String, Object>> yearGoalList = prjIndexDAO.getDatas(GOAL_TABLE, yWhereSql, null, new String[]{province, "0"});
            List<Map<String, Object>> yearIndexList = prjIndexDAO.getDatas(INDEX_TABLE, yWhereSql, null, new String[]{province, "0"});
            goalList.addAll(yearGoalList);
            indexList.addAll(yearIndexList);
        }

        // 根据id查事前
        String assSql = " mainguid in (" + projectIdBuffer.toString() + ") ";
        assessmentList = prjIndexDAO.getDatas(ASSESSMENT_TABLE, assSql, null);

        // 处理数据
        processList(goalList, year, logguidMap);
        processList(indexList, year, logguidMap);
        processList(assessmentList, year, logguidMap);

        // 保存到日志
        prjIndexDAO.saveAll(goalList, GOAL_LOG_TABLE);
        prjIndexDAO.saveAll(indexList, INDEX_LOG_TABLE);
        prjIndexDAO.saveAll(assessmentList, ASSESSMENT_LOG_TABLE);

        resultMap.put("result", true);
        resultMap.put("message", "保存成功");
        return resultMap;
    }

    private void processList(List<Map<String, Object>> dataList, String year, Map<String, Object> logguidMap) {
        String time = PerfUtil.getServerTimeStamp();
        dataList.forEach(map -> {
            map.put("year", year);
            map.put("createtime", time);
            map.put("create_time", time);
            map.put("updatetime", time);
            map.put("update_time", time);
            map.put("creater", SecureUtil.getCurrentUserID());
            map.put("logguid", logguidMap.get(map.get("mainguid")));
        });
    }

    /**
     * 获取项目绩效日志
     */
    public Map<String, Object> getperflog(Map<String, Object> params) throws AppException {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.putAll(params);

        // 提取参数
        String province = (String) params.get("province");
        String year = (String) params.get("year");
        String logguid = (String) params.get("logguid");
        String pro_id = (String) params.get("pro_id");
        String pro_code = (String) params.get("pro_code");

        // 表名常量
        final String GOAL_TABLE = "pm_perf_goal_info";
        final String INDEX_TABLE = "pm_perf_indicator";
        final String ASSESSMENT_TABLE = "v_perf_t_assessmentquery";
        final String GOAL_LOG_TABLE = "v_pm_perf_goal_info_log";
        final String INDEX_LOG_TABLE = "v_pm_perf_indicator_log";
        final String ASSESSMENT_LOG_TABLE = "v_perf_t_assessment_log";

        boolean isProYear = PerfUtil.getProgramIsyear();

        // 查询业务数据
        List<Map<String, Object>> goalList = new ArrayList<>();
        List<Map<String, Object>> indexList = new ArrayList<>();
        List<Map<String, Object>> assessmentList = new ArrayList<>();

        StringBuilder whereClause = new StringBuilder("is_deleted=2 and is_backup=2 and province=?");
        if (isProYear) {
            // 项目录入填报年度，全部根据id查
            String aWhereSql = whereClause.toString() + " and mainguid=?";
            goalList = prjIndexDAO.getDatas(GOAL_TABLE, aWhereSql, null, new String[]{province, pro_id});
            indexList = prjIndexDAO.getDatas(INDEX_TABLE, aWhereSql, "order by t.yearflag,t.lv1_perf_ind_code,t.lv2_perf_ind_code,t.ordernum", new String[]{province, pro_id});
        } else {
            // 根据id查总体，根据code查年度
            String tWhereSql = whereClause.toString() + " and mainguid=? and yearflag=?";
            List<Map<String, Object>> totalGoalList = prjIndexDAO.getDatas(GOAL_TABLE, tWhereSql, null, new String[]{province, pro_id, "1"});
            List<Map<String, Object>> totalIndexList = prjIndexDAO.getDatas(INDEX_TABLE, tWhereSql, "order by t.lv1_perf_ind_code,t.lv2_perf_ind_code,t.ordernum", new String[]{province, pro_id, "1"});
            goalList.addAll(totalGoalList);
            indexList.addAll(totalIndexList);

            String yWhereSql = whereClause.toString() + " and pro_code=? and yearflag=?";
            List<Map<String, Object>> yearGoalList = prjIndexDAO.getDatas(GOAL_TABLE, yWhereSql, null, new String[]{province, pro_code, "0"});
            List<Map<String, Object>> yearIndexList = prjIndexDAO.getDatas(INDEX_TABLE, yWhereSql, "order by t.lv1_perf_ind_code,t.lv2_perf_ind_code,t.ordernum", new String[]{province, pro_code, "0"});
            goalList.addAll(yearGoalList);
            indexList.addAll(yearIndexList);
        }

        // 根据id查事前
        String assSql = "mainguid=?";
        assessmentList = prjIndexDAO.getDatas(ASSESSMENT_TABLE, assSql, "order by t.ordernum", new String[]{pro_id});

        // 设置操作类型
        goalList.forEach(m -> m.put("opttype", 10));
        indexList.forEach(m -> m.put("opttype", 10));

        // 查询日志数据
        List<Map<String, Object>> goalLogList = new ArrayList<>();
        List<Map<String, Object>> indexLogList = new ArrayList<>();
        List<Map<String, Object>> assessmentLogList = new ArrayList<>();

        if (isProYear) {
            // 项目录入填报年度，全部根据id查
            String lWhereSql = whereClause.toString() + " and mainguid=? and logguid=?";
            goalLogList = prjIndexDAO.getDatas(GOAL_LOG_TABLE, lWhereSql, null, new String[]{province, pro_id, logguid});
            indexLogList = prjIndexDAO.getDatas(INDEX_LOG_TABLE, lWhereSql, "order by t.yearflag,t.lv1_perf_ind_code,t.lv2_perf_ind_code,t.ordernum", new String[]{province, pro_id, logguid});
        } else {
            // 根据id查总体，根据code查年度
            String ltWhereSql = whereClause.toString() + " and mainguid=? and logguid=? and yearflag=?";
            List<Map<String, Object>> totalGoalLogList = prjIndexDAO.getDatas(GOAL_LOG_TABLE, ltWhereSql, null, new String[]{province, pro_id, logguid, "1"});
            List<Map<String, Object>> totalIndexLogList = prjIndexDAO.getDatas(INDEX_LOG_TABLE, ltWhereSql, "order by t.lv1_perf_ind_code,t.lv2_perf_ind_code,t.ordernum", new String[]{province, pro_id, logguid, "1"});
            goalLogList.addAll(totalGoalLogList);
            indexLogList.addAll(totalIndexLogList);

            String lyWhereSql = whereClause.toString() + " and pro_code=? and logguid=? and yearflag=?";
            List<Map<String, Object>> yearGoalLogList = prjIndexDAO.getDatas(GOAL_LOG_TABLE, lyWhereSql, null, new String[]{province, pro_code, logguid, "0"});
            List<Map<String, Object>> yearIndexLogList = prjIndexDAO.getDatas(INDEX_LOG_TABLE, lyWhereSql, "order by t.lv1_perf_ind_code,t.lv2_perf_ind_code,t.ordernum", new String[]{province, pro_code, logguid, "0"});
            goalLogList.addAll(yearGoalLogList);
            indexLogList.addAll(yearIndexLogList);
        }

        // 根据id查事前日志
        String lAssSql = "mainguid=? and logguid=?";
        assessmentLogList = prjIndexDAO.getDatas(ASSESSMENT_LOG_TABLE, lAssSql, "order by t.ordernum", new String[]{pro_id, logguid});

        // 合并业务数据和日志数据
        List<Map<String, Object>> allGoalList = new ArrayList<>();
        allGoalList.addAll(goalList);
        allGoalList.addAll(goalLogList);

        List<Map<String, Object>> allIndexList = new ArrayList<>();
        allIndexList.addAll(indexList);
        allIndexList.addAll(indexLogList);

        List<Map<String, Object>> allAssessmentList = new ArrayList<>();
        allAssessmentList.addAll(assessmentList);
        allAssessmentList.addAll(assessmentLogList);

        // 返回结果
        resultMap.put("goal", PerfUtil.upperMapKey(allGoalList));
        resultMap.put("indicator", PerfUtil.upperMapKey(allIndexList));
        resultMap.put("assessment", PerfUtil.upperMapKey(allAssessmentList));
        resultMap.put("result", true);
        resultMap.put("message", "查询成功");

        return resultMap;
    }

    /**
     * 获取页面ui配置数据
     */
    public Map<String, Object> getperfuicfg(Map<String, Object> params) throws AppException {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.putAll(params);

        // 提取参数
        String province = (String) params.get("province");
        String year = (String) params.get("year");
        String uiKey = (String) params.get("key");

        prjIndexDAO.setYearAndProvince(year, province);

        // 查询配置信息
        Map<String, Object> dataTableConfig;
        try {
            dataTableConfig = this.getTable(uiKey);
        } catch (Exception e) {
            // 记录日志
            logger.error("查询配置信息失败: key={}", uiKey, e);
            throw new AppException("查询配置信息失败", e.getMessage());
        }

        // 返回结果
        resultMap.put("datatableDTO", dataTableConfig);
        resultMap.put("result", true);
        resultMap.put("message", "查询成功");

        return resultMap;
    }

}
