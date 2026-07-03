package gov.mof.fasp2.pmkpi.perfself.tab;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.jspsmart.upload.File;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.busfw.ui.dto.DataColumnsDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.IImpExpABO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.ImpExpAComponet;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjSumIndexBO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.springframework.util.StringUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.math.BigDecimal;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:45 2020/8/24  chongdayong
 */
public class SelfIndexBO extends PmkpiBO implements IImpExpABO {
    private SelfIndexDAO selfIndexDAO;

    public void setSelfIndexDAO(SelfIndexDAO selfIndexDAO) {
        this.selfIndexDAO = selfIndexDAO;
    }

    /**
     * 查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        String  isZJ = PerfUtil.getSystemSet("isZJ");
        String projguid = (String) params.get("projguid");
        String procode = (String) params.get("procode"); //项目编码
        String mainguid = (String) params.get("mainguid");
        String bustype = (String) params.get("bustype");
        String agencyguid = (String) params.get("agencyguid");
        String viewtype = (String) params.get("viewtype");//查询状态
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            selfIndexDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String sourcetable = "V_PM_PERF_INDICATOR"; //来源表
        String frametype = "PM001";//体系编码
        String selfFrameSql = "";//查询自评固化指标条件
        String tablecode = (String) params.get("tablecode"); //来源表
        String hidButtons = "";
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        if ("dept".equals(bustype)) { //部门整体
            sourcetable = "V_BGT_PERF_INDICATOR";
            frametype = "DEPT";
        }
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(" t.mainguid = '").append(mainguid).append("'");
        // 区分项目空模板赋值，不然没有共有字段不显示
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode(tablecode);
        //固化指标表字段
        dicColumnDTOs.addAll(dicQueryService.getDicColumnByTablecode("V_PERF_T_SELFFRAME"));
        //查询自评指标是否存在（草稿或者业务数据），都不存在，则显示项目指标
        String orderby = "order by t.findex, t.sindex, t.ordernum";
        List<Map<String, Object>> data = selfIndexDAO.findIndexs(bustype, tablecode, wheresql.toString(), orderby,mainguid, bustype + "selfindexfile"); //先查询业务数据
        boolean midsave = false;
        if(!"query".equals(viewtype)){//查询状态不加载暂存数据
            if (data == null || data.size() <= 0) {
                //业务表无数据，查询有暂存直接返回暂存
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    data = (List<Map<String, Object>>) midsavedata.get("result");
                }
                if (data != null && data.size() > 0) {
                    for (Map<String, Object> map : data) {
                        for (DicColumnDTO dicdto : dicColumnDTOs) {
                            if (!map.containsKey(dicdto.getDbcolumncode().toLowerCase())) {
                                map.put(dicdto.getDbcolumncode().toLowerCase(), "");
                            }
                        }
                    }
                    logger.info("---自评指标：当前为草稿数据！");
                    midsave = true;
                }
            }else{
                logger.info("---自评指标：当前为业务数据！隐藏保存草稿按钮");
                hidButtons = "暂存";
            }
        }
        if (data == null || data.size() == 0) {
            if ("parentprogram".equals(bustype)) {
                PrjSumIndexBO prjSumIndexBO = (PrjSumIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjSumIndexBOTX");
                params.put("pro_code", procode);
                Map<String, Object> dataMap = prjSumIndexBO.getDatas(params);
                data = (List<Map<String, Object>>) dataMap.get("datas");
            } else {
                wheresql = new StringBuffer();
                Boolean flag = PerfUtil.getIsHbei();
                if ("dept".equals(bustype) || flag) {
                    wheresql.append(" t.mainguid = '").append(projguid).append("'");
                } else {
                    wheresql.append(" t.pro_code = '").append(procode).append("'");
                }
                if ("program".equals(bustype) || "transprogram".equals(bustype)) {
                    wheresql.append(" and t.yearflag = '0'");
                    if (PerfUtil.getIsGuangXi()) {
                        wheresql.append(" and t.isapply = 1");
                    }
                }
                if("1".equals(isZJ) && "dept".equals(bustype)){
                    // 浙江自评部门整体三级指标动态拼接二级指标；
                    StringBuffer str = new StringBuffer();
                    str.append("select lv2_perf_ind_code as guid,sys_guid() as kpi_id,lv2_perf_ind_code as sindex,null as explain,null as weight," +
                            "null as islinked,null as agencyguid,null as wfstatus,null as status,'管理员' as creater,province,year,null as ordernum," +
                            "null as finintorgguid,null as wfid,mainguid,lv1_perf_ind_code as superid,'2' as levelno,null as rule," +
                            "null as computesign,null as meterunit,null as tindex,null as targetvalue,mof_div_code,fiscal_year,null as dept_code," +
                            "lv1_perf_ind_code,lv2_perf_ind_code,null as lv3_perf_ind_code,null as kpi_content,null as kpi_evalstd," +
                            "null as kpi_val,null as kpi_remark,is_deleted,sname as name,null as code,lv1_perf_ind_code as findex,null as indexval," +
                            "null as adl_batch_no,null as fun_res_code,null as indeximport,null as score,null as scorerule,null as kpi_val1," +
                            "null as kpi_val2,null as kpi_val3,null as proselect,null as isbudget,sname,null as opinion_remark,null as kpivalsource from V_BGT_PERF_INDICATOR t where t.agencyguid = '"+agencyguid+"' and is_deleted = 2");
                    str.append(" group by lv1_perf_ind_code,lv2_perf_ind_code,sname,mainguid,province,year,mof_div_code,fiscal_year,is_deleted ");
                    str.append(" union all ");
                    str.append("select guid,kpi_id,lv2_perf_ind_code as sindex,explain,score as weight,islinked,agencyguid,wfstatus,status,creater,province," +
                            "year,ordernum,finintorgguid,wfid,mainguid,lv2_perf_ind_code as superid,'3' as levelno,rule,computesign,meterunit,tindex,targetvalue," +
                            "mof_div_code,fiscal_year,dept_code,lv1_perf_ind_code,lv2_perf_ind_code,lv3_perf_ind_code,kpi_content,kpi_evalstd,kpi_val,kpi_remark,is_deleted," +
                            "name,code,findex,kpi_val as  indexval,adj_batch_no,fun_res_code,indeximport,score,scorerule,kpi_val1,kpi_val2," +
                            "kpi_val3,proselect,isbudget,sname,opinion_remark,kpivalsource from V_BGT_PERF_INDICATOR t where t.agencyguid = '"+agencyguid+"' and is_deleted = 2");
                    data = selfIndexDAO.queryForList(str.toString());
                } else {
                    if (PerfUtil.getIsSx() && "program".equals(bustype)) {
                        StringBuffer sql = new StringBuffer("select t.*, t1.indexval as NCINDEXVAL, t.is_deleted, t.TARGETVALUE from ").append(sourcetable)
                                .append(" t left join v_perf_bgt_indicatorpf t1 on t.pro_code = t1.pro_code and t.sindex = t1.sindex and t.name = t1.name where ");
                        if (!StringUtil.isEmpty(wheresql.toString())) {
                            sql.append(wheresql);
                        }
                        sql.append(" order by t.sindex,t.findex,t.ordernum");
                        StringBuffer delsql = new StringBuffer("select t.* from v_perf_bgt_indicatorpf t")
                                .append(" where not exists (select 1 from V_PM_PERF_INDICATOR t1 where t.pro_code = t1.pro_code and t.sindex = t1.sindex and t.name = t1.name and t1.yearflag='0') and t.is_deleted <> 1");
                        if (!StringUtil.isEmpty(wheresql.toString())) {
                            delsql.append(" and ").append(wheresql);
                        }
                        logger.info("(山西删除)自评指标查sql+++++++++++++++++" + delsql.toString());
                        List<Map<String, Object>> delindexs = selfIndexDAO.queryForList(delsql.toString());
                        logger.info("(山西)自评指标查sql+++++++++++++++++" + sql.toString());
                        data = selfIndexDAO.queryForList(sql.toString());
                        for (Map<String, Object> map: delindexs) {
//                        map.put("is_deleted", 1);
                            map.put("ncindexval", map.get("indexval"));
                            map.put("indexval", "");
                            map.put("actualvalue", "");
                            data.add(map);//删除指标
                        }
                    }else{
                        data = selfIndexDAO.findIndexs(bustype, sourcetable, wheresql.toString(), orderby, mainguid, bustype + "selfindexfile");
                    }
                }
            }
            Map supmap = new HashMap();
            Boolean b = false;
            boolean isSx = PerfUtil.getIsSx();
            for (Map<String, Object> map : data) {
                map.put("tindex", map.get("guid"));
                if("1".equals(isZJ)){
                    if("dept".equals(bustype) && "2".equals(map.get("levelno"))){
                        supmap.put(map.get("sindex"),map.get("kpi_id"));
                        map.put("guid", map.get("kpi_id"));
                    }
                    if("3".equals(map.get("levelno")) && "4".equals(map.get("findex")) && supmap.containsKey(map.get("sindex"))){
                        map.put("superid", supmap.get(map.get("sindex")));
                    }
                } else {
                    String createguid = this.getCreateguid();
                    map.put("guid", createguid);
                }
                map.put("kpi_remark", "");

                //山西需求：判断产出-成本指标下是否有三级指标
                if (isSx) {
                    String sindex = (String) map.get("sindex");
                    if ("14".equals(sindex)) {
                        b = true;
                    }
                }
            }
            //山西：产出-成本指标下没有三级指标，默认加一条三级指标数据
            if (isSx){
                if (!b){
                    Map dataMap = new HashMap();
                    String guid = this.getCreateguid();
                    dataMap.put("guid",guid);
                    dataMap.put("kpi_id",guid);
                    dataMap.put("agencyguid",agencyguid);
                    dataMap.put("code","1400001");
                    dataMap.put("computesign","6");
                    dataMap.put("superid","14");
                    dataMap.put("levelno","3");
                    dataMap.put("findex","1");
                    dataMap.put("isleaf","1");
                    dataMap.put("sindex","14");
                    dataMap.put("isedit","1");
                    dataMap.put("name","成本指标");
                    dataMap.put("indexval","未填报");
                    dataMap.put("is_deleted","2");
                    dataMap.put("wfstatus","1");  //是否是默认新增的三级指标数据  1：是
                    data.add(dataMap);
                }
            }
        }
        if (PerfUtil.getIsSx() && "program".equals(bustype)) { //山西项目指标
            //根据pro_code sindex name 去重
            data = data.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(
                    Comparator.comparing(x -> (String)x.get("pro_code") + (String)x.get("sindex") + (String)x.get("name") + String.valueOf(x.get("levelno")) + String.valueOf(x.get("indexval"))))), ArrayList::new));
            //暂存数据去重后根据_locationposition重新排序
            if (midsave)
                data = data.stream().sorted(Comparator.comparing(map -> (int)map.get("_locationposition"))).collect(Collectors.toList());
        }
        List<Map<String, Object>> selfTemp = new ArrayList<>();
        if(!PerfUtil.getIsNINGXIA()){
            //获取固化指标
            selfTemp = selfIndexDAO.getSelfFrameData(selfFrameSql, frametype, mainguid, bustype + "selfindexfile");
        }
        float bgtget = 0;
        float score = 0;
        if (selfTemp.size() > 0) {
            //查询预算执行率数据
            Map<String, Object> bgtfundMap = selfIndexDAO.getSource(procode, projguid, mainguid);
            if (!bgtfundMap.isEmpty()) {
                String amt3 = bgtfundMap.get("amt3") == null ? "0.00" : bgtfundMap.get("amt3") + "";
                String amt4 = bgtfundMap.get("amt4") == null ? "0.00": bgtfundMap.get("amt4") + "";
                if (Float.parseFloat(amt3) == 0) {
                    bgtget = 0;
                    score = 0;
                } else {
                    float n = Float.parseFloat(amt4)/Float.parseFloat(amt3) * 100;
                    bgtget = (float)(Math.round(n * 100))/100;
                    score = (float)(Math.round(n/10 * 100))/100;
                }
            }
        }
        if (midsave) {
            if (selfTemp.size() > 0) {
                for (Map<String, Object> map : data) {
                    //固化预算执行率数据，取值范围为预算执行情况
                    if ("预算执行率".equals(map.get("name"))) {
                        map.put("score", score + "");
                        map.put("actualvalue", bgtget + "");
                    }
                }
            }
            yearsMap.put("data", data);//年度
            return yearsMap;
        }
        //空指标模板
        List<Map<String, Object>> nullTemp = selfIndexDAO.getTempdatas(mainguid, frametype);
        selfTemp.addAll(nullTemp);
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        Map<String, Map> dataMap = new HashMap<String, Map>();
        String keycode = "";
        String sindex = "";
        String levelno = "";
        String tindex = "";
        for (Map<String, Object> map : data) {
            if("dept".equals(bustype) && "1".equals(isZJ)){
                levelno = (String) map.get("levelno");
                if("3".equals(levelno)) {
                    map.put("isedit", "1");
                }
            } else {
                sindex = (String) map.get("sindex");
                keycode = sindex + "&0";
                if (!indexMap.containsKey(keycode)) {
                    tempList = new ArrayList<Map<String, Object>>();
                    indexMap.put(keycode, tempList);
                } else {
                    tempList = indexMap.get(keycode);
                }

                tindex = (String) map.get("tindex");
                dataMap.put(tindex, map);
                String datatype = (String) map.get("datatype");
                if (StringUtils.isEmpty(datatype)) {
                    map.put("isedit", "1");
                    tempList.add(map);
                }
            }
            map.put("_isleaf", "1");
            map.put("isleaf", "1");
        }
        for (Map<String, Object> map : selfTemp) {
            int level = PerfUtil.mapGetInt(map, "levelno");
            if ( 3 == level && !dataMap.containsKey(map.get("guid")) ) {
                map.put("guid", this.getCreateguid());
            }
            for (DicColumnDTO dicdto : dicColumnDTOs) {
                if (!map.containsKey(dicdto.getDbcolumncode().toLowerCase())) {
                    map.put(dicdto.getDbcolumncode().toLowerCase(), "");
                }
                if (PerfUtil.getIsSx() && "program".equals(bustype)) {
                    map.put("ncindexval","");
                }
            }
        }
        //空模板
        List<Map<String, Object>> nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(selfTemp);
        //返回指标
        List<Map<String, Object>> backindex = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : nullindex) {
            //判断固化指标是否存在，存在业务数据添加到固化指标对象里
            if (dataMap.containsKey(map.get("guid"))) {
                Map selfdata = dataMap.get(map.get("guid"));
                map.putAll(selfdata);
            }
            //固化预算执行率数据，取值范围为预算执行情况
            if (selfTemp.size() > 0 && "预算执行率".equals(map.get("name"))) {
                map.put("score", score + "");
                map.put("actualvalue", bgtget + "");
            }
            if("dept".equals(bustype) && "1".equals(isZJ)){
            } else {
                sindex = (String) map.get("sindex");
            }
            keycode = sindex + "&0";
            if (indexMap.containsKey(keycode)) {
                tempList = indexMap.get(keycode);
                backindex.add(map);
                backindex.addAll(tempList);
            } else {
                backindex.add(map);
            }
        }
        for (Map<String, Object> map : backindex) {
            if (!StringUtils.isEmpty(map.get("levelno")) && !"3".equals(map.get("levelno"))) {
                map.put("weight1", map.get("weight"));
            }
        }
        if("dept".equals(bustype) && "1".equals(isZJ)){
            backindex.addAll(data);
        }
        yearsMap.put("data", backindex);//年度
        yearsMap.put("hidButtons", hidButtons);
        return yearsMap;
    }

    /**
     * 保存.
     *
     * @param params -- 参数集合.
     * @return -- list.
     */
    public Map<String, Object> saveIndex(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode"); //表明
        String busguid = (String) params.get("busguid"); //审核定义
        String mainguid = (String) params.get("mainguid"); //主键
        String projguid = (String) params.get("projguid"); //项目id.
        String procode = (String) params.get("procode"); //项目code
        String  isZJ = PerfUtil.getSystemSet("isZJ");
        String bustype = (String) params.get("bustype");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> templist = new ArrayList<Map<String, Object>>(); //3级指标数据
        int i = 1;
        int lenelno = 0;
        for (Map<String, Object> map : datas) {
            lenelno = PerfUtil.mapGetInt(map, "levelno");
            // 浙江 部门整体指标 一级产出与效果下 二三级都为动态录入指标
            if((2 == lenelno && "1".equals(isZJ) && "4".equals(map.get("findex"))) || 3 == lenelno){
                if(StringUtils.isEmpty(map.get("province"))){
                    map.put("province", SecureUtil.getUserSelectProvince());
                }
                if(StringUtils.isEmpty(map.get("year"))){
                    map.put("year", CommonUtil.getYear());
                }
                map.put("mainguid", mainguid);
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("projguid", projguid); //项目id.
                map.put("taskguid", mainguid); //任务id.
                map.put("pro_code", procode); //项目code
                map.put("creater", SecureUtil.getCurrentUserID());
                map.put("ordernum", i++);
                //业务表保存固化指标关联关系
//                if ("selfframe".equals(map.get("datatype"))) {
//                    map.put("tindex", map.get("guid"));
//                }
                if (3 == lenelno && StringUtils.isEmpty(map.get("guid"))){
                    map.put("guid", this.getCreateguid());
                }
                templist.add(map);
            }
        }
        selfIndexDAO.delIndexByguid(tablecode, mainguid);
        selfIndexDAO.saveAll(templist, tablecode);
        SelfDescDAO selfDescDAO = (SelfDescDAO) PerfServiceFactory.getBean("pmkpi.perfSelf.SelfDescDAO");
        selfDescDAO.updateDescScore(mainguid, bustype);
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(templist, busguid, "perf", null);
    }

    /**
     * 查询主表目标数据.
     * @param params -- 参数。
     * @return
     * @throws AppException -- 自定义异常
     */
    public Map<String, Object> getDeptMainDatas(HashMap<String, Object> params) throws AppException {
        Map backMap = new HashMap(); //返回消息
        String mainguid = (String)params.get("mainguid");
        String proguid = (String)params.get("proguid"); // 部门申报主键
        String procode = (String) params.get("procode");
        String viewtype = (String) params.get("viewtype");//查询状态
        String orderby = " order by ordernum";
        //1.自评部门目标
        StringBuffer goalSql = new StringBuffer(" t.mainguid = '" + mainguid + "' and t.yearflag = '0' ");
        List<Map<String, Object>> goals = selfIndexDAO.getDatas(selfIndexDAO.TABLE_GOAL_SELF, goalSql.toString(), orderby);
        if(goals==null||goals.isEmpty()){
            // 如果自评业务没有目标则取部门最新目标
            goalSql = new StringBuffer(" t.mainguid = '" + proguid + "' and t.yearflag = '0' ");
            goals = selfIndexDAO.getDatas(selfIndexDAO.TABLE_GOAL_DEPT, goalSql.toString(), orderby);
        }
        StringBuffer indexSql = new StringBuffer(" t.mainguid = '" + mainguid + "' and goalguid is not null");
        //2.自评部门指标业务数据
        List<Map<String, Object>> indexs = selfIndexDAO.getDatas(selfIndexDAO.TABLE_INDEX_SELF, indexSql.toString(), orderby);
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            //业务表无数据，查询有暂存返回暂存
            if(indexs == null || indexs.size()==0){
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    indexs = (List<Map<String, Object>>) midsavedata.get("result");
                    backMap.put("yeargoals", indexs);
                    return backMap;
                }
            }else{
                backMap.put("hidButtons", "暂存");
            }
        }
        //3.自评部门指标数据
        if(indexs == null || indexs.isEmpty()){
            indexs = selfIndexDAO.getDatas(selfIndexDAO.TABLE_INDEX_DEPT, goalSql.toString(), orderby);
            if(!indexs.isEmpty()){
                indexs.forEach(r -> {
                    r.put("goalguid", r.get("kpi_dep_id"));
                });
            }
        }
        List<Map<String, Object>> tempdatas = selfIndexDAO.getTempdatas(mainguid,"DEPT"); //模板信息
        List<Map<String, Object>> collist = selfIndexDAO.getCol(selfIndexDAO.TABLE_INDEX_SELF);
        List yeargoals = new ArrayList(); // 年度
        String goalguid = "";
        String sindex = null;
        String key = "";
        List goalindexs = new ArrayList(); //目标指标对应.
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>(); //
        List tempindex = new ArrayList();
        for (Map<String, Object> map : indexs) {
            goalguid = (String) map.get("goalguid");
            sindex = (String) map.get("sindex");
            key = goalguid+"#"+sindex;
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            map.put("superguid", sindex);
            map.put("superid", sindex);
            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            if (indexMap.containsKey(key)){
                tempindex = indexMap.get(key);
                tempindex.add(map);
            } else {
                tempindex = new ArrayList();
                tempindex.add(map);
                indexMap.put(key, tempindex);
            }
        }
        String yearflag = "";
        for (Map<String, Object> map : goals) {
            goalguid = (String) map.get("guid");
            goalindexs = new ArrayList();
            List<Map> tempdatalist = new ArrayList();
            JSONArray jsonArray = JSONArray.parseArray(JSONObject.toJSONString(tempdatas));
            List<Map> jsonlist = jsonArray.toJavaList(Map.class);
            tempdatalist.addAll(jsonlist);
            for (Map<String, Object> tepmap : tempdatalist) {
                for (Map<String, Object> colmap : collist) {
                    String col = (String) colmap.get("columncode");
                    String value = tepmap.get(col) + "";
                    if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                        tepmap.put(col, "");
                    }
                }
                String levelno = tepmap.get("levelno") + "";
                goalindexs.add(tepmap);
                if (!StringUtils.isEmpty(levelno) && "2".equals(levelno)) {
                    sindex = (String) tepmap.get("guid");
                    key = goalguid+"#"+sindex;
                    if (indexMap.containsKey(key)) {
                        tempindex = indexMap.get(key);
                        goalindexs.addAll(tempindex);
                    }
                }
                tepmap.put("mainguid", mainguid);
                tepmap.put("goalguid", goalguid);
                tepmap.put("_isleaf", "1");
            }
            map.put("#indexs",goalindexs); //行级数据保存
            yeargoals.add(map);

            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            map.put("#delindex", new ArrayList<>()); //存放子表删除的绩效指标
        }
        backMap.put("yeargoals", yeargoals);
        return backMap;
    }

    /**
     * 根据主表记录查询没有记录的查询默认模板数据
     * @param params --数据
     * @return
     * @throws AppException
     */
    public Map<String, Object> getDeptSubData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String goalguid = (String)params.get("goalguid");
        List<Map<String, Object>> collist = selfIndexDAO.getCol(selfIndexDAO.TABLE_INDEX_SELF);
        List<Map<String, Object>> tempdatas = selfIndexDAO.getTempdatas(mainguid,"DEPT"); //模板信息
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            map.put("mainguid", mainguid);
            map.put("goalguid", goalguid);
            map.put("_isleaf", "1");
            backdata.add(map);
        }
        backMap.put("data", backdata);
        return backMap;
    }

    /**
     * 最终保存方法.(湖北)
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveHbData(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String mainguid = (String) params.get("mainguid");
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        List<Map<String, Object>> maindatas = (List<Map<String, Object>>) params.get("datas");
        int j = 0;
        for (Map<String, Object> mainmap : maindatas) {
            mainmap.get("#index");
            List<Map<String, Object>> datas = (List<Map<String, Object>>) mainmap.get("#indexs");
            for (Map<String, Object> map : datas) {
                j++;
                String levelno = map.get("levelno") + "";
                if ("3".equals(levelno)) {
                    map.put("ordernum", j);
                    if(StringUtils.isEmpty(map.get("guid"))){
                        map.put("guid", CommonUtil.createGUID());
                    }
                    map.put("creater", SecureUtil.getCurrentUser().getGuid());
                    map.put("agencyguid", saveAgency);
                    map.put("mainguid", mainguid);
                    map.put("proguid", proguid);
                    map.put("code", map.get("code"));
                    map.put("create_time", PerfUtil.getServerTimeStamp());
                    map.put("update_time", PerfUtil.getServerTimeStamp());
                    map.put("agency_code", saveAgency);
                    map.put("mof_div_code", SecureUtil.getUserSelectProvince());
                    map.put("province", SecureUtil.getUserSelectProvince());
                    map.put("year", CommonUtil.getYear());
                    map.put("fiscal_year", CommonUtil.getYear());
                    indexList.add(map);
                }
            }
            mainmap.put("mainguid", mainguid);
            mainmap.put("create_time", StringUtil.getSysDBDate());
            mainmap.put("createtime", StringUtil.getSysDBDate());
            mainmap.put("updatetime", StringUtil.getSysDBDate());
            mainmap.put("update_time", StringUtil.getSysDBDate());
            mainmap.put("province", SecureUtil.getUserSelectProvince());
            mainmap.put("year", CommonUtil.getYear());
        }
        selfIndexDAO.delIndexByguid(selfIndexDAO.TABLE_GOAL_SELF, mainguid); //自评目标入库
        selfIndexDAO.saveAll(maindatas, selfIndexDAO.TABLE_GOAL_SELF); //自评目标入库
        selfIndexDAO.delIndexByguid(selfIndexDAO.TABLE_INDEX_SELF, mainguid);
        selfIndexDAO.saveAll(indexList, selfIndexDAO.TABLE_INDEX_SELF);
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(indexList, busguid,"perf", null);
    }

    /**
     * 查询主表目标数据.
     * @param params -- 参数。
     * @return
     * @throws AppException -- 自定义异常
     */
    public Map<String, Object> getProMainDatas(HashMap<String, Object> params) throws AppException {
        Map backMap = new HashMap(); //返回消息
        String mainguid = (String)params.get("mainguid");
        String proguid = (String)params.get("proguid");
        String procode = (String) params.get("procode");
        String viewtype = (String) params.get("viewtype");//查询状态
        //1.自评绩效目标
        StringBuffer goalSql = new StringBuffer(" t.mainguid = '" + mainguid + "'");
        String orderby = " order by ordernum";
        List<Map<String, Object>> goals = selfIndexDAO.getDatas(selfIndexDAO.TABLE_GOAL_SELF, goalSql.toString(), null);
        //2.项目绩效目标
        if(goals == null || goals.isEmpty()){
            goalSql = new StringBuffer(" t.pro_code = '" + procode + "' and t.yearflag = '0' ");
            goals = selfIndexDAO.getDatas("V_PM_PERF_GOAL_INFO", goalSql.toString(), null);
        }
        StringBuffer indexSql = new StringBuffer(" t.mainguid = '" + mainguid + "' and goalguid is not null");
        //3.自评绩效指标
        List<Map<String, Object>> indexs = selfIndexDAO.getDatas(selfIndexDAO.TABLE_INDEX_SELF, indexSql.toString(), orderby);
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            //业务表无数据，查询有暂存返回暂存
            if(indexs == null || indexs.size()==0){
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    indexs = (List<Map<String, Object>>) midsavedata.get("result");
                    backMap.put("yeargoals", indexs);
                    return backMap;
                }
            }else{
                backMap.put("hidButtons", "暂存");
            }
        }
        //4.项目绩效指标
        if(indexs == null || indexs.isEmpty()){
            indexSql = new StringBuffer(" t.pro_code = '" + procode + "' and t.yearflag = '0' ");
            indexs = selfIndexDAO.getDatas("V_PM_PERF_INDICATOR", indexSql.toString(), orderby);
        }
        List<Map<String, Object>> tempdatas = selfIndexDAO.getTempdatas(mainguid,"PM001");//模板信息
        List<Map<String, Object>> collist = selfIndexDAO.getCol(selfIndexDAO.TABLE_INDEX_SELF);
        List yeargoals = new ArrayList(); // 年度
        String goalguid = "";
        String sindex = null;
        String key = "";
        List goalindexs = new ArrayList(); //目标指标对应.
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>(); //
        List tempindex = new ArrayList();
        for (Map<String, Object> map : indexs) {
            goalguid = (String) map.get("goalguid");
            sindex = (String) map.get("sindex");
            key = goalguid+"#"+sindex;
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            map.put("superguid", sindex);
            map.put("superid", sindex);
            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            if (indexMap.containsKey(key)){
                tempindex = indexMap.get(key);
                tempindex.add(map);
            } else {
                tempindex = new ArrayList();
                tempindex.add(map);
                indexMap.put(key, tempindex);
            }
        }
        String yearflag = "";
        for (Map<String, Object> map : goals) {
            goalguid = (String) map.get("guid");
            goalindexs = new ArrayList();
            List<Map> tempdatalist = new ArrayList();
            JSONArray jsonArray = JSONArray.parseArray(JSONObject.toJSONString(tempdatas));
            List<Map> jsonlist = jsonArray.toJavaList(Map.class);
            tempdatalist.addAll(jsonlist);
            int sortnum = 0;
            Double scoresum = 0.00;
            for (Map<String, Object> tepmap : tempdatalist) {
                for (Map<String, Object> colmap : collist) {
                    String col = (String) colmap.get("columncode");
                    String value = tepmap.get(col) + "";
                    if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                        tepmap.put(col, "");
                    }
                }
                String levelno = tepmap.get("levelno") + "";


                if (!StringUtils.isEmpty(levelno) && "2".equals(levelno)) {
                    sindex = (String) tepmap.get("guid");
                    key = goalguid+"#"+sindex;
                    if (indexMap.containsKey(key)) {
                        tempindex = indexMap.get(key);
                        tepmap.put("_sortid", sortnum);
                        sortnum++;
                        for (int j = 0; j < tempindex.size(); j++){
                            Map<String,Object> indexmap = (Map<String, Object>) tempindex.get(j);
                            Double score =  indexmap.get("score") != null ?  Double.parseDouble(String.valueOf(indexmap.get("score"))) : 0.00;
                            scoresum = scoresum + score;
                            indexmap.put("_sortid", sortnum);
                            sortnum++;
                        }
                        goalindexs.addAll(tempindex);
                    }else{
                        tepmap.put("_sortid", sortnum);
                        sortnum++;
                    }
                }else{
                    tepmap.put("_sortid", sortnum);
                    sortnum++;
                }
                tepmap.put("mainguid", mainguid);
                tepmap.put("goalguid", goalguid);
                tepmap.put("_isleaf", "1");
                goalindexs.add(tepmap);
            }
            map.put("#indexs",goalindexs); //行级数据保存
            //是否启用权重比例模式
            if(this.isRatio()){
                int ratio =  map.get("ratio") != null ?  Integer.parseInt(String.valueOf(map.get("ratio"))) : 0;
                if(map.get("ratio") == null){
                    map.put("ratio",0);
                }
                //根据权重比例计算指标权重得分
                map.put("weightscore",ratio == 0? 0 : scoresum*ratio/100);
            }
            yeargoals.add(map);

            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            map.put("#delindex", new ArrayList<>()); //存放子表删除的绩效指标
        }
        backMap.put("yeargoals", yeargoals);
        return backMap;
    }

    /**
     * 根据主表记录查询没有记录的查询默认模板数据
     * @param params --数据
     * @return
     * @throws AppException
     */
    public Map<String, Object> getProSubData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String goalguid = (String)params.get("goalguid");
        String procode = (String) params.get("procode");
        List<Map<String, Object>> goals = (List<Map<String, Object>>) params.get("goaldatas");
        StringBuffer indexSql = new StringBuffer(" mainguid = ? and t.goalguid = ?");
        //自评绩效指标
        List<Map<String, Object>> indexs = selfIndexDAO.getDatas(selfIndexDAO.TABLE_INDEX_SELF, indexSql.toString(), null, new String[]{mainguid, goalguid});
        //项目绩效指标
        if(indexs == null || indexs.isEmpty()){
            indexSql = new StringBuffer(" t.pro_code = ? and t.goalguid = ? and t.yearflag = '0' ");
            indexs = selfIndexDAO.getDatas(PerfConstant.PMKPI_VPM_INDICATOR, indexSql.toString(), null, new String[]{procode, goalguid});
        }
        List<Map<String, Object>> tempdatas = selfIndexDAO.getTempdatas(mainguid,"PM001");//模板信息
        List<Map<String, Object>> collist = selfIndexDAO.getCol(selfIndexDAO.TABLE_INDEX_SELF);
        String sindex = null;
        String key = "";
        List goalindexs = new ArrayList(); //目标指标对应.
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>(); //
        List tempindex = new ArrayList();
        for (Map<String, Object> map : indexs) {
            sindex = (String) map.get("sindex");
            key = goalguid+"#"+sindex;
            map.put("goalguid", goalguid);
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            map.put("superguid", sindex);
            map.put("superid", sindex);
            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            if (indexMap.containsKey(key)){
                tempindex = indexMap.get(key);
                tempindex.add(map);
            } else {
                tempindex = new ArrayList();
                tempindex.add(map);
                indexMap.put(key, tempindex);
            }
        }
        for (Map<String, Object> map : goals) {
            goalguid = (String) map.get("guid");
            goalindexs = new ArrayList();
            List<Map> tempdatalist = new ArrayList();
            JSONArray jsonArray = JSONArray.parseArray(JSONObject.toJSONString(tempdatas));
            List<Map> jsonlist = jsonArray.toJavaList(Map.class);
            tempdatalist.addAll(jsonlist);
            int sortnum = 0;
            Double scoresum = 0.00;
            for (Map<String, Object> tepmap : tempdatalist) {
                for (Map<String, Object> colmap : collist) {
                    String col = (String) colmap.get("columncode");
                    String value = tepmap.get(col) + "";
                    if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                        tepmap.put(col, "");
                    }
                }
                String levelno = tepmap.get("levelno") + "";
                if (!StringUtils.isEmpty(levelno) && "2".equals(levelno)) {
                    sindex = (String) tepmap.get("guid");
                    key = goalguid+"#"+sindex;
                    if (indexMap.containsKey(key)) {
                        tempindex = indexMap.get(key);
                        tepmap.put("_sortid", sortnum);
                        sortnum++;
                        for (int j = 0; j < tempindex.size(); j++){
                            Map<String,Object> indexmap = (Map<String, Object>) tempindex.get(j);
                            Double score =  indexmap.get("score") != null ?  Double.parseDouble(String.valueOf(indexmap.get("score"))) : 0.00;
                            scoresum = scoresum + score;
                            indexmap.put("_sortid", sortnum);
                            sortnum++;
                        }
                        goalindexs.addAll(tempindex);
                    }else{
                        tepmap.put("_sortid", sortnum);
                        sortnum++;
                    }
                }else{
                    tepmap.put("_sortid", sortnum);
                    sortnum++;
                }
                tepmap.put("mainguid", mainguid);
                tepmap.put("goalguid", goalguid);
                tepmap.put("_isleaf", "1");
                goalindexs.add(tepmap);
            }
            map.put("#indexs",goalindexs); //行级数据保存
        }
        backMap.put("yeargoals", goals);
        return backMap;
    }

    /**
     * 最终保存方法.(湖北)
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveHbProData(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode");
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String mainguid = (String) params.get("mainguid");
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        List<Map<String, Object>> maindatas = (List<Map<String, Object>>) params.get("datas");
        int i = 1;
        for (Map<String, Object> mainmap : maindatas) {
            List<Map<String, Object>> datas = (List<Map<String, Object>>) mainmap.get("#indexs");
            for (Map<String, Object> map : datas) {
                i++;
                String levelno = map.get("levelno") + "";
                if ("3".equals(levelno)) {
                    map.put("ordernum", i);
                    if(StringUtils.isEmpty(map.get("guid"))){
                        map.put("guid", CommonUtil.createGUID());
                    }
                    map.put("mainguid", mainguid);
                    map.put("create_time", PerfUtil.getServerTimeStamp());
                    map.put("createtime", PerfUtil.getServerTimeStamp());
                    map.put("updatetime", PerfUtil.getServerTimeStamp());
                    map.put("projguid", proguid); //项目id.
                    map.put("taskguid", mainguid); //任务id.
                    map.put("pro_code", procode); //项目code
                    map.put("creater", SecureUtil.getCurrentUserID());
                    map.put("ordernum", i++);
                    map.put("agencyguid", saveAgency);
                    map.put("proguid", proguid);
                    map.put("code", map.get("code"));
                    map.put("update_time", PerfUtil.getServerTimeStamp());
                    map.put("agency_code", saveAgency);
                    map.put("mof_div_code", SecureUtil.getUserSelectProvince());
                    map.put("province", SecureUtil.getUserSelectProvince());
                    map.put("year", CommonUtil.getYear());
                    map.put("fiscal_year", CommonUtil.getYear());
                    indexList.add(map);
                }
            }
            mainmap.put("mainguid", mainguid);
            mainmap.put("projguid", proguid);
            mainmap.put("pro_code", procode);
            mainmap.put("create_time", StringUtil.getSysDBDate());
            mainmap.put("createtime", StringUtil.getSysDBDate());
            mainmap.put("updatetime", StringUtil.getSysDBDate());
            mainmap.put("update_time", StringUtil.getSysDBDate());
            mainmap.put("province", SecureUtil.getUserSelectProvince());
            mainmap.put("year", CommonUtil.getYear());
        }
        selfIndexDAO.delIndexByguid(selfIndexDAO.TABLE_GOAL_SELF, mainguid);
        selfIndexDAO.saveAll(maindatas, selfIndexDAO.TABLE_GOAL_SELF);
        selfIndexDAO.delIndexByguid(selfIndexDAO.TABLE_INDEX_SELF, mainguid);
        selfIndexDAO.saveAll(indexList, selfIndexDAO.TABLE_INDEX_SELF);
        SelfDescDAO selfDescDAO = (SelfDescDAO) PerfServiceFactory.getBean("pmkpi.perfSelf.SelfDescDAO");
        selfDescDAO.updateDescScore(mainguid, "program");
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(indexList, busguid,"perf", null);
    }

    public String getFrameCode(HashMap<String, Object> params) {
        String frametype = (String) params.get("frametype");//预警类型
        String name = (String) params.get("name");//任务guid
        String sql = "select guid from v_perf_t_frame where frametype = '" + frametype + "' and name = '" + name + "'";
        logger.info("---getFrameCodeSql---:" + sql);
        List<Map<String, Object>> frameCodes = selfIndexDAO.queryForList(sql);
        if (frameCodes != null && frameCodes.size() > 0) {
            return frameCodes.get(0).get("guid") + "";
        }
        return "";
    }

    /**
     * 判断当前是否启用了权重比例模式
     * @return
     * @throws AppException
     */
    public Boolean isRatio() throws AppException{
        List colList = this.getCols("/pmkpi/perfself/apply/edit/hbprogoal");
        for(int i=0;i<colList.size();i++){
            DataColumnsDTO coldto = (DataColumnsDTO)colList.get(i);
            String columncode = coldto.getColcode();
            Integer isvisiable = coldto.getIsvisiable();
            if("ratio".equals(columncode) && isvisiable == 1){
                return true;
            }
        }
        return false;
    }

    /**
     * 查询各年度数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> getindexAndGoal(Map<String, Object> params) throws AppException {
        String  isZJ = PerfUtil.getSystemSet("isZJ");
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode"); //项目编码
        String mainguid = (String) params.get("mainguid");
        String bustype = (String) params.get("bustype");
        String agencyguid = (String) params.get("agencyguid");
        String sourcetable = PerfConstant.PMKPI_VPM_INDICATOR; //来源表
        String goaltablecode = PerfConstant.PMKPI_VPM_GOAL_INFO; //来源表
        String frametype = "PM001";//体系编码
        String selfFrameSql = "";//查询自评固化指标条件
        String tablecode = (String) params.get("tablecode"); //来源表
        String hidButtons = "";
        Map<String, Object> backMap = new HashMap<>();
        if ("dept".equals(bustype)) { //部门整体
            sourcetable = PerfConstant.BGT_V_TABLE_INDICATOR;
            goaltablecode = PerfConstant.BGT_V_TABLE_GOAL;
            frametype = "DEPT";
        }
        StringBuffer wheresql = new StringBuffer();
        // 区分项目空模板赋值，不然没有共有字段不显示
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode(tablecode);
        //固化指标表字段
        dicColumnDTOs.addAll(dicQueryService.getDicColumnByTablecode("V_PERF_T_SELFFRAME"));
        List<Map<String, Object>> data = null;
        Boolean flag = PerfUtil.getIsHbei();
        if ("dept".equals(bustype) || flag || "parentprogram".equals(bustype)) {
            wheresql.append(" t.mainguid = '").append(proguid).append("'");
        } else {
            wheresql.append(" t.pro_code = '").append(procode).append("'");
        }
        if ("program".equals(bustype) || "transprogram".equals(bustype)) {
            wheresql.append(" and t.yearflag = '0'");
        }
        if ("parentprogram".equals(bustype)) {
            goaltablecode = PerfConstant.PMKPI_BACKUP_GOAL_INFO;
            wheresql.append(" and t.yearflag = '1' and is_deleted=2 and is_backup=2 and province='").append(SecureUtil.getUserSelectProvince()).append("'");
        }
        //查询绩效目标
        Map<String, Object> goalMap = this.getDataMap(goaltablecode, wheresql.toString());
        if("1".equals(isZJ) && "dept".equals(bustype)){
            // 浙江自评部门整体三级指标动态拼接二级指标；
            StringBuffer str = new StringBuffer();
            str.append("select lv2_perf_ind_code as guid,sys_guid() as kpi_id,lv2_perf_ind_code as sindex,null as explain,null as weight," +
                    "null as islinked,null as agencyguid,null as wfstatus,null as status,'管理员' as creater,province,year,null as ordernum," +
                    "null as finintorgguid,null as wfid,mainguid,lv1_perf_ind_code as superid,'2' as levelno,null as rule," +
                    "null as computesign,null as meterunit,null as tindex,null as targetvalue,mof_div_code,fiscal_year,null as dept_code," +
                    "lv1_perf_ind_code,lv2_perf_ind_code,null as lv3_perf_ind_code,null as kpi_content,null as kpi_evalstd," +
                    "null as kpi_val,null as kpi_remark,is_deleted,sname as name,null as code,lv1_perf_ind_code as findex,null as indexval," +
                    "null as adl_batch_no,null as fun_res_code,null as indeximport,null as score,null as scorerule,null as kpi_val1," +
                    "null as kpi_val2,null as kpi_val3,null as proselect,null as isbudget,sname,null as opinion_remark,null as kpivalsource from V_BGT_PERF_INDICATOR t where t.agencyguid = '"+agencyguid+"' and is_deleted = 2");
            str.append(" group by lv1_perf_ind_code,lv2_perf_ind_code,sname,mainguid,province,year,mof_div_code,fiscal_year,is_deleted ");
            str.append(" union all ");
            str.append("select guid,kpi_id,lv2_perf_ind_code as sindex,explain,score as weight,islinked,agencyguid,wfstatus,status,creater,province," +
                    "year,ordernum,finintorgguid,wfid,mainguid,lv2_perf_ind_code as superid,'3' as levelno,rule,computesign,meterunit,tindex,targetvalue," +
                    "mof_div_code,fiscal_year,dept_code,lv1_perf_ind_code,lv2_perf_ind_code,lv3_perf_ind_code,kpi_content,kpi_evalstd,kpi_val,kpi_remark,is_deleted," +
                    "name,code,findex,kpi_val as  indexval,adj_batch_no,fun_res_code,indeximport,score,scorerule,kpi_val1,kpi_val2," +
                    "kpi_val3,proselect,isbudget,sname,opinion_remark,kpivalsource from V_BGT_PERF_INDICATOR t where t.agencyguid = '"+agencyguid+"' and is_deleted = 2");
            data = selfIndexDAO.queryForList(str.toString());
        } else {
            if (PerfUtil.getIsSx() && "program".equals(bustype)) {
                StringBuffer sql = new StringBuffer("select t.*, t1.indexval as NCINDEXVAL, t.is_deleted, t.TARGETVALUE from ").append(sourcetable)
                        .append(" t left join v_perf_bgt_indicatorpf t1 on t.pro_code = t1.pro_code and t.sindex = t1.sindex and t.name = t1.name where ");
                if (!StringUtil.isEmpty(wheresql.toString())) {
                    sql.append(wheresql);
                }
                sql.append(" order by t.sindex,t.findex,t.ordernum");
                StringBuffer delsql = new StringBuffer("select t.* from v_perf_bgt_indicatorpf t")
                        .append(" where not exists (select 1 from V_PM_PERF_INDICATOR t1 where t.pro_code = t1.pro_code and t.sindex = t1.sindex and t.name = t1.name and t1.yearflag='0') and t.is_deleted <> 1");
                if (!StringUtil.isEmpty(wheresql.toString())) {
                    delsql.append(" and ").append(wheresql);
                }
                logger.info("(山西删除)自评指标查sql+++++++++++++++++" + delsql.toString());
                List<Map<String, Object>> delindexs = selfIndexDAO.queryForList(delsql.toString());
                logger.info("(山西)自评指标查sql+++++++++++++++++" + sql.toString());
                data = selfIndexDAO.queryForList(sql.toString());
                for (Map<String, Object> map: delindexs) {
                    map.put("ncindexval", map.get("indexval"));
                    map.put("indexval", "");
                    map.put("actualvalue", "");
                    data.add(map);//删除指标
                }
            } else {
                if ("parentprogram".equals(bustype)) {
                    PrjSumIndexBO prjSumIndexBO = (PrjSumIndexBO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjSumIndexBOTX");
                    params.put("pro_code", procode);
                    HashMap map = (HashMap) params;
                    Map<String, Object> dataMap = prjSumIndexBO.getDatas(map);
                    data = (List<Map<String, Object>>) dataMap.get("datas");
                } else {
                    if (PerfUtil.getIsGuangXi() && !"dept".equals(bustype)) {
                        wheresql.append(" and t.isapply = 1");
                    }
                    data = selfIndexDAO.findIndexs(bustype, sourcetable, wheresql.toString(), "order by t.ordernum", mainguid, bustype + "selfindexfile");
                }
            }
        }
        Map supmap = new HashMap();
        Boolean b = false;
        boolean isSx = PerfUtil.getIsSx();
        for (Map<String, Object> map : data) {
            map.put("tindex", map.get("guid"));
            if ("1".equals(isZJ)) {
                if("dept".equals(bustype) && "2".equals(map.get("levelno"))){
                    supmap.put(map.get("kpi_lv2"),map.get("kpi_id"));
                    map.put("guid", map.get("kpi_id"));
                }
                if("3".equals(map.get("levelno")) && "4".equals(map.get("findex")) && supmap.containsKey(map.get("sindex"))){
                    map.put("superid", supmap.get(map.get("sindex")));
                }
            } else {
                String createguid = this.getCreateguid();
                map.put("guid", createguid);
            }
            map.put("kpi_remark", "");

            //山西需求：判断产出-成本指标下是否有三级指标
            if (isSx) {
                String sindex = (String) map.get("sindex");
                if ("14".equals(sindex)) {
                    b = true;
                }
            }
        }
        //山西：产出-成本指标下没有三级指标，默认加一条三级指标数据
        if (isSx){
            if (!b) {
                Map dataMap = new HashMap();
                String guid = this.getCreateguid();
                dataMap.put("guid",guid);
                dataMap.put("kpi_id",guid);
                dataMap.put("agencyguid",agencyguid);
                dataMap.put("code","1400001");
                dataMap.put("computesign","6");
                dataMap.put("superid","14");
                dataMap.put("levelno","3");
                dataMap.put("findex","1");
                dataMap.put("isleaf","1");
                dataMap.put("sindex","14");
                dataMap.put("isedit","1");
                dataMap.put("name","成本指标");
                dataMap.put("indexval","未填报");
                dataMap.put("is_deleted","2");
                dataMap.put("wfstatus","1");  //是否是默认新增的三级指标数据  1：是
                data.add(dataMap);
            }
        }
        if (PerfUtil.getIsSx() && "program".equals(bustype)) { //山西项目指标
            //根据pro_code sindex name 去重
            data = data.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() -> new TreeSet<>(
                    Comparator.comparing(x -> x.get("pro_code") + (String)x.get("sindex") + x.get("name") + x.get("levelno") + x.get("indexval")))), ArrayList::new));
        }
        List<Map<String, Object>> selfTemp = new ArrayList<>();
        if(!PerfUtil.getIsNINGXIA()){
            //获取固化指标
            selfTemp = selfIndexDAO.getSelfFrameData(selfFrameSql, frametype, mainguid, bustype + "selfindexfile");
        }
        float bgtget = 0;
        float score = 0;
        if (selfTemp.size() > 0) {
            //查询预算执行率数据
            Map<String, Object> bgtfundMap = selfIndexDAO.getSource(procode, proguid, mainguid);
            if (!bgtfundMap.isEmpty()) {
                String amt3 = bgtfundMap.get("amt3") == null ? "0.00" : bgtfundMap.get("amt3") + "";
                String amt4 = bgtfundMap.get("amt4") == null ? "0.00": bgtfundMap.get("amt4") + "";
                if (Float.parseFloat(amt3) == 0) {
                    bgtget = 0;
                    score = 0;
                } else {
                    float n = Float.parseFloat(amt4)/Float.parseFloat(amt3) * 100;
                    bgtget = (float)(Math.round(n * 100))/100;
                    score = (float)(Math.round(n/10 * 100))/100;
                }
            }
        }
        //空指标模板
        List<Map<String, Object>> nullTemp = selfIndexDAO.getTempdatas(mainguid, frametype);
        selfTemp.addAll(nullTemp);
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<>();
        Map<String, Map> dataMap = new HashMap<>();
        String keycode = "";
        String sindex = "";
        String levelno = "";
        String tindex = "";
        for (Map<String, Object> map : data) {
            if ("dept".equals(bustype) && "1".equals(isZJ)) {
                levelno = (String) map.get("levelno");
                if("3".equals(levelno)) {
                    map.put("isedit", "1");
                }
            } else {
                sindex = (String) map.get("sindex");
                keycode = sindex + "&0";
                if (!indexMap.containsKey(keycode)) {
                    tempList = new ArrayList<>();
                    indexMap.put(keycode, tempList);
                } else {
                    tempList = indexMap.get(keycode);
                }

                tindex = (String) map.get("tindex");
                dataMap.put(tindex, map);
                String datatype = (String) map.get("datatype");
                if (StringUtils.isEmpty(datatype)) {
                    map.put("isedit", "1");
                    tempList.add(map);
                }
            }
            map.put("_isleaf", "1");
            map.put("isleaf", "1");
        }
        for (Map<String, Object> map : selfTemp) {
            int level = PerfUtil.mapGetInt(map, "levelno");
            if ( 3 == level && !dataMap.containsKey(map.get("guid")) ) {
                map.put("guid", this.getCreateguid());
            }
            for (DicColumnDTO dicdto : dicColumnDTOs) {
                if (!map.containsKey(dicdto.getDbcolumncode().toLowerCase())) {
                    map.put(dicdto.getDbcolumncode().toLowerCase(), "");
                }
                if (PerfUtil.getIsSx() && "program".equals(bustype)) {
                    map.put("ncindexval","");
                }
            }
        }
        //空模板
        List<Map<String, Object>> nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(selfTemp);
        //返回指标
        List<Map<String, Object>> backindex = new ArrayList<>();
        for (Map<String, Object> map : nullindex) {
            //判断固化指标是否存在，存在业务数据添加到固化指标对象里
            if (dataMap.containsKey(map.get("guid"))) {
                Map selfdata = dataMap.get(map.get("guid"));
                map.putAll(selfdata);
            }
            //固化预算执行率数据，取值范围为预算执行情况
            if (selfTemp.size() > 0 && "预算执行率".equals(map.get("name"))) {
                map.put("score", score + "");
                map.put("actualvalue", bgtget + "");
            }
            if ("dept".equals(bustype) && "1".equals(isZJ)) {
            } else {
                sindex = (String) map.get("sindex");
            }
            keycode = sindex + "&0";
            if (indexMap.containsKey(keycode)) {
                tempList = indexMap.get(keycode);
                backindex.add(map);
                backindex.addAll(tempList);
            } else {
                backindex.add(map);
            }
        }
        for (Map<String, Object> map : backindex) {
            if (!StringUtils.isEmpty(map.get("levelno")) && !"3".equals(map.get("levelno"))) {
                map.put("weight1", map.get("weight"));
            }
        }
        if ("dept".equals(bustype) && "1".equals(isZJ)) {
            backindex.addAll(data);
        }
        backMap.put("datas", backindex);//年度
        backMap.put("hidButtons", hidButtons);
        //删除已填报监控指标数据
        wheresql = new StringBuffer();
        wheresql.append("mainguid = '").append(mainguid).append("'");
        selfIndexDAO.delDatas(tablecode, wheresql.toString());
        //处理暂存数据
        //查询自评补充信息暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        Map<String, Object> midMap = new HashMap();
        String url1 = "";
        String url2 = "";
        if ("dept".equals(bustype)) {
            url1 = "/pmkpi/perfself/apply/editdept/selfdesc";
            url2 = "/pmkpi/perfself/apply/editdept/selfindex";
        } else {
            url1 = "/pmkpi/perfself/apply/edit/selfdesc";
            url2 = "/pmkpi/perfself/apply/edit/selfindex";
        }
        midMap.put("url", url1);
        midMap.put("mainguid", mainguid);
        midMap.put("compconfigid", "editform");
        midMap.put("componentid", "buscommon.ui.editform");
        Map<String, Object> querymidMap = perfMidsaveBO.getMidData(midMap);
        Map<String, Object> descMap = (Map<String, Object>) querymidMap.get("result");
        //删除指标暂存数据
        Map<String, Object>  delparams = new HashMap();
        delparams.put("mainguid", mainguid);
        delparams.put("url", url2);
        delparams.put("compconfigid", "datatable");
        perfMidsaveBO.delTabData(delparams);
        //更新自评得分、自评结论
        List<String> upcols = new ArrayList<>();
        StringBuffer upsql = new StringBuffer();
        upsql.append("update ").append(PerfSelfApplyDAO.PERF_TABLE_SELFPERFDESC).append(" set ");
        upcols.add("score");
        upcols.add("selfresult");
        for (String col : upcols) {
            upsql.append(col).append(" = null, ");
        }
        if (!goalMap.isEmpty()) {
            upsql.append("yeargoal = '").append(goalMap.get("kpi_target")).append("'");
        } else {
            upsql.append("yeargoal = null");
        }
        upsql.append(" where mainguid = '").append(mainguid).append("'");
        selfIndexDAO.execute(upsql.toString());
        if (PerfUtil.getIS_HUBEI()) {
            upcols = new ArrayList<>();
            upsql = new StringBuffer();
            upsql.append("update ").append(PerfSelfApplyDAO.PERF_TABLE_EVALUATEINFO).append(" set ");
            upcols.add("score");
            upcols.add("grade");
            upcols.add("percentile");
            for (String col : upcols) {
                upsql.append(col).append(" = null, ");
            }
            upsql.deleteCharAt(upsql.length() - 2);
            upsql.append(" where mainguid = '").append(mainguid).append("'");
            selfIndexDAO.execute(upsql.toString());
        }
        //处理自评补充信息暂存数据
        if (descMap != null && !descMap.isEmpty()) {
            descMap.put("score", null);
            descMap.put("selfresult", null);
            if (!goalMap.isEmpty()) {
                descMap.put("yeargoal", goalMap.get("kpi_target"));
            } else {
                descMap.put("yeargoal", null);
            }
            midMap.put("data", descMap);
            perfMidsaveBO.saveData(midMap);
        }
        return backMap;
    }




    /**
     * 获取申报的目标、指标(湖北)
     * @param params -- 参数集合.
     * @return yeargoals.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> getnewindexAndGoal(Map<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        //获取申报的目标、指标
        String mainguid = (String)params.get("mainguid");
        String proguid = (String)params.get("proguid");
        String procode = (String) params.get("procode");
        String viewtype = (String) params.get("viewtype");//查询状态
        String bustype = (String) params.get("bustype");
        String indextablecode = PerfConstant.PMKPI_VPM_INDICATOR; //来源表
        String goaltablecode = PerfConstant.PMKPI_VPM_GOAL_INFO; //来源表
        StringBuffer goalSql = new StringBuffer();
        List<Map<String, Object>> tempdatas = new ArrayList<Map<String, Object>>();
        if(!StringUtil.isEmpty(bustype)){
            if("program".equals(bustype)){//项目支出
                goalSql.append(" t.pro_code = '" + procode + "' and t.yearflag = '0' ");
                tempdatas = selfIndexDAO.getTempdatas(mainguid,"PM001");//模板信息
            }else if ("dept".equals(bustype)) { //部门整体
                goaltablecode = selfIndexDAO.TABLE_GOAL_DEPT;
                indextablecode = selfIndexDAO.TABLE_INDEX_DEPT;
                goalSql.append(" t.mainguid = '" + proguid + "' and t.yearflag = '0' ");
                tempdatas = selfIndexDAO.getTempdatas(mainguid,"DEPT");//模板信息
            }
        }
        String orderby = " order by ordernum";
        List<Map<String, Object>> goals = selfIndexDAO.getDatas(goaltablecode, goalSql.toString(), null);
        List<Map<String, Object>>  indexs = selfIndexDAO.getDatas(indextablecode, goalSql.toString(), orderby);
        if("dept".equals(bustype) && !indexs.isEmpty()){
            indexs.forEach(r -> {
                r.put("goalguid", r.get("kpi_dep_id"));
            });
        }
        List<Map<String, Object>> collist = selfIndexDAO.getCol(selfIndexDAO.TABLE_INDEX_SELF);
        List yeargoals = new ArrayList(); // 年度
        String goalguid = "";
        String sindex = null;
        String key = "";
        List goalindexs = new ArrayList(); //目标指标对应.
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>(); //
        List tempindex = new ArrayList();
        for (Map<String, Object> map : indexs) {
            goalguid = (String) map.get("goalguid");
            sindex = (String) map.get("sindex");
            key = goalguid+"#"+sindex;
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            map.put("superguid", sindex);
            map.put("superid", sindex);
            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            if (indexMap.containsKey(key)){
                tempindex = indexMap.get(key);
                tempindex.add(map);
            } else {
                tempindex = new ArrayList();
                tempindex.add(map);
                indexMap.put(key, tempindex);
            }
        }
        String yearflag = "";
        for (Map<String, Object> map : goals) {
            goalguid = (String) map.get("guid");
            goalindexs = new ArrayList();
            List<Map> tempdatalist = new ArrayList();
            JSONArray jsonArray = JSONArray.parseArray(JSONObject.toJSONString(tempdatas));
            List<Map> jsonlist = jsonArray.toJavaList(Map.class);
            tempdatalist.addAll(jsonlist);
            int sortnum = 0;
            int scoresum = 0;
            for (Map<String, Object> tepmap : tempdatalist) {
                for (Map<String, Object> colmap : collist) {
                    String col = (String) colmap.get("columncode");
                    String value = tepmap.get(col) + "";
                    if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                        tepmap.put(col, "");
                    }
                }
                String levelno = tepmap.get("levelno") + "";


                if (!StringUtils.isEmpty(levelno) && "2".equals(levelno)) {
                    sindex = (String) tepmap.get("guid");
                    key = goalguid+"#"+sindex;
                    if (indexMap.containsKey(key)) {
                        tempindex = indexMap.get(key);
                        tepmap.put("_sortid", sortnum);
                        sortnum++;
                        for (int j = 0; j < tempindex.size(); j++){
                            Map<String,Object> indexmap = (Map<String, Object>) tempindex.get(j);
                            indexmap.get("score");
                            int score =  indexmap.get("score") != null ?  Integer.parseInt(String.valueOf(indexmap.get("score"))) : 0;
                            scoresum = scoresum + score;
                            indexmap.put("_sortid", sortnum);
                            sortnum++;
                        }
                        goalindexs.addAll(tempindex);
                    }else{
                        tepmap.put("_sortid", sortnum);
                        sortnum++;
                    }
                }else{
                    tepmap.put("_sortid", sortnum);
                    sortnum++;
                }
                tepmap.put("mainguid", mainguid);
                tepmap.put("goalguid", goalguid);
                tepmap.put("_isleaf", "1");
                goalindexs.add(tepmap);
            }
            map.put("#indexs",goalindexs); //行级数据保存
            //是否启用权重比例模式
            if("dept".equals(bustype) && this.isRatio()){
                int ratio =  map.get("ratio") != null ?  Integer.parseInt(String.valueOf(map.get("ratio"))) : 0;
                if(map.get("ratio") == null){
                    map.put("ratio",0);
                }
                //根据权重比例计算指标权重得分
                map.put("weightscore",ratio == 0? 0 : scoresum*ratio/100);
            }
            yeargoals.add(map);

            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            map.put("#delindex", new ArrayList<>()); //存放子表删除的绩效指标
        }
        backMap.put("yeargoals", yeargoals);
        //删除已填报监控指标目标数据
        StringBuffer wheresql = new StringBuffer();
        wheresql.append("eval_id = '").append(mainguid).append("'");
        selfIndexDAO.delDatas(PerfSelfApplyDAO.SELF_GOAL_TABLE, wheresql.toString());
        selfIndexDAO.delDatas(PerfSelfApplyDAO.SELF_IND_TABLE, wheresql.toString());
        Map delparams = new HashMap();
        StringBuffer missavesql = new StringBuffer();
        missavesql.append("mainguid = '").append(mainguid).append("'");
        delparams.put("delsql",missavesql.toString());
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delData(delparams);
        //将[评价基本信息]页面系统计算得分、评价结论(等级)、百分位值同步清除
        List<String> upcols = new ArrayList<>();
        StringBuffer upsql = new StringBuffer();
        upsql.append("update ").append(PerfSelfApplyDAO.PERF_TABLE_EVALUATEINFO).append(" set ");
        upcols.add("score");
        upcols.add("grade");
        upcols.add("percentile");
        for (String col : upcols) {
            upsql.append(col).append(" = null, ");
        }
        upsql.deleteCharAt(upsql.length() - 2);
        upsql.append(" where mainguid = '").append(mainguid).append("'");
        selfIndexDAO.execute(upsql.toString());
        return backMap;
    }

    @Override
    public List busImpDatas(Map paras, String filename, List<? extends Map> datalist) throws AppException {
        return Collections.emptyList();
    }

    @Override
    public Map busImpConfirmDatasSave(Map paras, ArrayList datalist) throws AppException {
        return Collections.emptyMap();
    }

    @Override
    public List busExpDatas(Map paras) throws AppException {
        HashMap params = (HashMap) paras;
        Map dataMap = this.getData(params);
        List<Map<String, Object>> indexs = (List<Map<String, Object>>) dataMap.get("data");
        if (indexs != null && !indexs.isEmpty()) {
            indexs = indexs.stream().filter(m-> "1".equals(m.get("isleaf"))).collect(Collectors.toList());
        }
        List<Map<String, Object>> list = PerfUtil.getSourceData("PMKPISELFINDEXVAL", null);
        Map<String, Object> m = new HashMap<>();
        for (Map<String, Object> mm : list) {
            m.put((String) mm.get("code"), mm.get("guid"));
        }
        Map<String, Object> map = new HashMap<>();
        map.put((String) m.get("1"), "达成");
        map.put((String) m.get("2"), "部分达成");
        map.put((String) m.get("3"), "未达成");
        for (Map<String, Object> data : indexs) {
            String computesign = (String) data.get("computesign");
            if ("6".equals(computesign)) {
                String actualvalue = (String) data.get("actualvalue");
                actualvalue = (String) map.get(actualvalue);
                data.put("actualvalue", actualvalue);
            }
        }
        return indexs;
    }

    @Override
    public List imp(File file, Map paras) throws Exception {
        return Collections.emptyList();
    }

    @Override
    public List impreport(File file, Map paras) throws Exception {
        return Collections.emptyList();
    }

    @Override
    public List impData(List datas, Map paras) throws AppException {
        String mainguid = (String) paras.get("mainguid");
        String tablecode = (String) paras.get("tablecode");
        String bustype = (String) paras.get("bustype");
        String projguid = (String) paras.get("projguid");
        String pro_code = (String) paras.get("procode");
        String impguid = (String) paras.get("impguid");
        String wheresql = " mainguid=? ";
        String itablecode = PerfConstant.PMKPI_VPM_INDICATOR;
        List<Map<String, Object>> indexList = selfIndexDAO.getDatas(tablecode, wheresql, null, new String[]{mainguid});
        if (indexList == null || indexList.isEmpty()) {
            if ("program".equals(bustype)) {
                wheresql = " pro_code=? and yearflag='0'";
            }
            indexList = selfIndexDAO.getDatas(itablecode, wheresql, null, new String[]{pro_code});
            for (Map<String, Object> map : indexList) {
                map.put("tindex", map.get("guid"));
                String createguid = this.getCreateguid();
                map.put("guid", createguid);
                map.put("kpi_remark", "");
            }
        }
        if (datas == null || datas.isEmpty() || indexList == null || indexList.isEmpty()) {
            return indexList;
        }
        Map<String, Map<String, Object>> dataMap = new HashMap<>();
        for (Object obj : datas) {
            if (obj instanceof Map) {
                Map<String, Object> dataItem = (Map<String, Object>) obj;
                Object nameObj = dataItem.get("name");
                if (nameObj != null) {
                    dataMap.put(nameObj.toString(), dataItem);
                }
            }
        }
        List<Map<String, Object>> errorlist = new ArrayList<>();
        StringBuffer error = null;
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto = null;
        String fileguid = "";
        if (FileUploadService.fileguids.get() != null) {//框架导入功能
            fileguid = FileUploadService.fileguids.get();
        } else {//绩效导入功能
            fileguid = ImpExpAComponet.FILE_GUIDS.get();
        }
        Pattern valpattern = Pattern.compile("[*_-]");
        if(PerfUtil.get_isCheckSpace()){
            valpattern = Pattern.compile("[ 　*_-]");
        }
        Matcher matcher = null;
        List<Map<String, Object>> list = PerfUtil.getSourceData("PMKPISELFINDEXVAL", null);
        Map<String, Object> m = new HashMap<>();
        for (Map<String, Object> mm : list) {
            m.put((String) mm.get("code"), mm.get("guid"));
        }
        Map<String, Object> map = new HashMap<>();
        map.put("达成", m.get("1"));
        map.put("部分达成", m.get("2"));
        map.put("未达成", m.get("3"));
        map.put((String) m.get("1"), m.get("1"));
        map.put((String) m.get("2"), m.get("2"));
        map.put((String) m.get("3"), m.get("3"));
        for (Map<String, Object> data : indexList) {
            String name = (String) data.get("name");
            if("dept".equals(bustype) && PerfUtil.getIsZJ()){
                data.put("isedit", "1");
            } else {
                String datatype = (String) data.get("datatype");
                if (StringUtils.isEmpty(datatype)) {
                    data.put("isedit", "1");
                }
            }
            data.put("_isleaf", "1");
            data.put("isleaf", "1");
            if (!StringUtil.isNullOrEmpty(name)) {
                if (dataMap.containsKey(name)) {
                    error = new StringBuffer();
                    Map<String, Object> impData = (Map<String, Object>) PerfUtil.cloneListAndMap(dataMap.get(name));
                    Integer linenum = (Integer) impData.get("linenum");
                    String computesign = (String) impData.get("computesign");
                    String actualvalue = (String) impData.get("actualvalue");
                    String score_remark = (String) impData.get("score_remark");
                    String actualweight = impData.get("actualweight") + "";
                    String score = impData.get("score") + "";
                    String deduct_score = impData.get("deduct_score") + "";
                    if ("NULL".equals(actualvalue) || "null".equals(actualvalue)) {
                        error.append("实际完成值不能为").append(actualvalue).append("，请重新填写 ");
                    } else if (!"6".equals(computesign) && !PerfUtil.isNumeric(actualvalue)) {
                        error.append("定量指标实际完成值填数字。");
                    } else if ("6".equals(computesign) && StringUtil.isNullOrEmpty(map.get(actualvalue))) {
                            error.append("定性指标实际完成值请填写‘达成’，‘部分达成’，‘未达成’三项中的一个。");
                    } else if ("6".equals(computesign)) {
                        actualvalue = (String) map.get(actualvalue);
                        impData.put("actualvalue", actualvalue);
                    }
                    if ("6".equals(computesign) && StringUtil.isNullOrEmpty(score_remark)) {
                        error.append("定性指标完成情况简要描述不能为空。");
                    }
                    if (!PerfUtil.isNumeric(actualweight)) {
                        error.append("分值只能填数字。");
                    } else if (!PerfUtil.isNumeric(score)) {
                        error.append("得分只能填数字。");
                    } else if (!StringUtil.isNullOrEmpty(deduct_score) && !PerfUtil.isNumeric(deduct_score)) {
                        error.append("扣减分数只能填数字。");
                    } else {
                        BigDecimal w = new BigDecimal(actualweight);
                        BigDecimal s = new BigDecimal(score);
                        if (w.compareTo(s) < 0) {
                            error.append("得分不能大于分值。");
                        }
                    }
                    if (!StringUtil.isEmpty(actualvalue)) {
                        matcher = valpattern.matcher(actualvalue);
                        if (matcher.find()) {
                            String msg = "定性指标值填写不支持特殊字符，请重新填写 ";
                            if(PerfUtil.get_isCheckSpace()){
                                msg = "定性指标值填写不支持特殊字符和空格，请重新填写 ";
                            }
                            error.append(msg);
                        }
                    }
                    impData.remove("findex");
                    impData.remove("sindex");
                    impData.remove("name");
                    impData.remove("computesign");
                    impData.remove("meterunit");
                    impData.remove("indexval");
                    data.putAll(impData);
                    if (!StringUtil.isEmpty(error.toString())) {
                        error.insert(0,"三级指标：" + name);
                        dto = new ImportErrorDTO(fileguid, linenum, error.toString());
                        errordao.saveErrorMsg(dto);
                        errorlist.add(dto);
                    }
                }
            }
        }
        if (errorlist.size() > 0) {
            throw new AppException("ANA-ERROR", "指标导入数据错误");
        }
        for (Map<String, Object> data : indexList) {
            String computesign = (String) data.get("computesign");
            BigDecimal deduct_score = new BigDecimal(StringUtil.isNullOrEmpty(data.get("deduct_score")) ? "0" : data.get("deduct_score") + "");
            BigDecimal score = new BigDecimal(StringUtil.isNullOrEmpty(data.get("score")) ? "0" : data.get("score") + "");
            if (Arrays.asList("1", "2", "3", "4", "5").contains(computesign)) {
                BigDecimal actualvalue = new BigDecimal(StringUtil.isNullOrEmpty(data.get("actualvalue")) ? "0" : data.get("actualvalue") + "");
                BigDecimal indexval = new BigDecimal(StringUtil.isNullOrEmpty(data.get("indexval")) ? "0" : data.get("indexval") + "");
                BigDecimal actualweight = new BigDecimal(StringUtil.isNullOrEmpty(data.get("actualweight")) ? "0" : data.get("actualweight") + "");
                HashMap<String, Object> params = new HashMap<>();
                String warmtype = "";
                if ("1".equals(computesign) || "2".equals(computesign)) {
                    warmtype = "selfpositiveindex"; //正向指标
                } else if ("3".equals(computesign)) { //等于指标
                    if (indexval.compareTo(BigDecimal.ZERO) == 0) {
                        warmtype = "selfindexequalzero";
                    } else {
                        warmtype = "selfequalindex";
                    }
                } else if ("4".equals(computesign) || "5".equals(computesign)) { //反向指标
                    warmtype = "selfreverseindex";
                }
                params.put("warmtype", warmtype);
                params.put("indexval", indexval + "");  //指标值
                params.put("actualvalue", actualvalue.compareTo(BigDecimal.ZERO) < 0 ? "0": actualvalue + "");//实际完成值
                params.put("weight", actualweight + "");//实际权重值
                String value = this.getWarn(params);
                score = new BigDecimal(value);
                data.put("score", value);
            }
            if (deduct_score.compareTo(BigDecimal.ZERO) != 0) {
                BigDecimal s = PerfUtil.substrTwoNum(score, deduct_score);
                data.put("score", s.compareTo(BigDecimal.ZERO) <= 0 ? BigDecimal.ZERO : s);
            }
        }
        Map<String, Object> saveMap = new HashMap<>();
        saveMap.put("guid", impguid);
        saveMap.put("data", PerfUtil.parse2Json(indexList));
        this.getBasMap(saveMap, "add");
        selfIndexDAO.save(saveMap, PerfMidsaveBO.MIDSAVE_TABLE);
        return null;
    }

    @Override
    public List parseFile(Map paras, String filename, InputStream is) throws AppException {
        return Collections.emptyList();
    }

    @Override
    public List beforeParseFile(Map paras, String filename, InputStream is) throws AppException {
        return Collections.emptyList();
    }

    @Override
    public boolean isBusGetCellValue() {
        return false;
    }

    @Override
    public Object getCellValue(Map paras, Map colconfig, HSSFCell cell, String columncode, boolean istrans) throws AppException {
        return null;
    }

    @Override
    public boolean expImpModel(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {
        return false;
    }

    @Override
    public void beforeExpImpModel(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {

    }

    @Override
    public List beforeExpImpCols(Map paras) throws AppException {
        return Collections.emptyList();
    }

    @Override
    public Map transExpDatas(Map paras, List<? extends Map> datalist) throws AppException {
        return Collections.emptyMap();
    }

    @Override
    public boolean setCellValue(Map paras, Map colconfig, HSSFCell cell, String columncode, boolean istrans, Map rowdata, Map trandata, Map cellstylemap) throws AppException {
        return false;
    }

    @Override
    public void exp(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {

    }
}