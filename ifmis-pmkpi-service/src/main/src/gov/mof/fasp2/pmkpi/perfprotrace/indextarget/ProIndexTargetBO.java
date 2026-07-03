package gov.mof.fasp2.pmkpi.perfprotrace.indextarget;

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
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.IImpExpABO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.ImpExpAComponet;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfprotrace.manage.ProTraceManageDAO;
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

public class ProIndexTargetBO extends PmkpiBO implements IImpExpABO {
    private ProIndexTargetDAO proIndexTargetDAO;

    public void setProIndexTargetDAO(ProIndexTargetDAO proIndexTargetDAO) {
        this.proIndexTargetDAO = proIndexTargetDAO;
    }

    /**
     * 查询各年度数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> getData(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String mainguid = (String) params.get("mainguid");
        String bustype = (String)params.get("bustype");
        String procode = (String) params.get("procode");
        String viewtype = (String) params.get("viewtype");//查询状态
        String ismarkpro = (String) params.get("ismarkpro");
        String tablecode = "";
        String querytablecode = "V_PERF_T_PROINDEXTRACE";
        String type = "";
        String filter = " t.mainguid='" + mainguid + "'";
        String filetype = bustype + "traceindexfile";
        String hidButtons = "";
        if (bustype != null && "depttrace".equals(bustype)) {
            type = "DEPT";
            tablecode = "V_BGT_PERF_INDICATOR";
        } else if (bustype != null && "protrace".equals(bustype)) {
            type = "PM001";
            tablecode = "V_PM_PERF_INDICATOR";
        }
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            proIndexTargetDAO.setYearAndProvince(queryYear, queryProvince);
        }
        //查询监控指标是否存在（草稿或者业务数据），都不存在，则显示项目指标
        List<Map<String, Object>> indexs = getIndex(bustype, querytablecode, filter, mainguid, filetype); //先查询业务数据
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            if (indexs == null || indexs.size() <= 0) {
//            indexs = getIndex(bustype, querytablecodetemp, filter, mainguid, filetype);
                //业务表无数据，查询有暂存返回暂存
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    indexs = (List<Map<String, Object>>) midsavedata.get("result");
                }
                logger.info("---监控指标：当前为草稿数据！");
            }else{
                logger.info("---监控指标：当前为业务数据！隐藏保存草稿按钮");
                hidButtons = "暂存";
            }
        }
        if (indexs == null || indexs.size() <= 0) {
            if (PerfUtil.getIsHbei() || "depttrace".equals(bustype)) {
                filter = " t.mainguid='" + proguid + "'";
            } else {
                filter = " t.pro_code='" + procode + "'";
            }
            if ("protrace".equals(bustype)) {
                filter += " and t.yearflag = '0'";
                if (PerfUtil.getIsGuangXi()) {
                    filter += " and t.isapply = 1";
                }
            }
            if (PerfUtil.getIsSx() && "protrace".equals(bustype)) {
                StringBuffer sql = new StringBuffer("select t.*, t1.indexval as NCINDEXVAL, t.is_deleted, t.TARGETVALUE from ").append(tablecode)
                        .append(" t left join v_perf_bgt_indicatorpf t1 on t.pro_code = t1.pro_code and t.name = t1.name and t.sindex = t1.sindex ");
                if (!StringUtil.isEmpty(filter)) {
                    sql.append(" where ").append(filter);
                }
                sql.append(" order by t.sindex,t.findex,t.ordernum");
                StringBuffer delsql = new StringBuffer("select t.* from v_perf_bgt_indicatorpf t")
                        .append(" where not exists (select 1 from V_PM_PERF_INDICATOR t1 where t.pro_code = t1.pro_code and t.name = t1.name and t.sindex = t1.sindex) and t.is_deleted <> 1");
                if (!StringUtil.isEmpty(filter)) {
                    delsql.append(" and ").append(filter);
                }
                logger.info("(山西删除)监控指标查sql+++++++++++++++++" + delsql.toString());
                List<Map<String, Object>> delindexs = proIndexTargetDAO.queryForList(delsql.toString());
                logger.info("(山西)监控指标查sql+++++++++++++++++" + sql.toString());
                indexs = proIndexTargetDAO.queryForList(sql.toString());
                for (Map<String, Object> map: delindexs) {
                    map.put("is_deleted", 1);
                    map.put("targetvalue", "");
                    map.put("ncindexval", map.get("indexval"));
                    map.put("indexval", "");
                    indexs.add(map);//删除指标
                }
            }else {
                indexs = proIndexTargetDAO.findIndexs(tablecode, filter, mainguid, filetype);
            }
            for (Map<String, Object> map: indexs) {
                map.put("targetvalue", map.get("indexval"));
                map.put("indexval", "");
                map.put("tindex", map.get("guid"));
                map.put("guid", this.getCreateguid());
            }
            if((!StringUtil.isNullOrEmpty(ismarkpro) && "1".equals(ismarkpro)) || PerfUtil.getIsNINGXIA()){// 标记项目 或 宁夏 需要汇总支付填报的数量指标完成情况（定量）
                List<Map<String, Object>> quantityindex = proIndexTargetDAO.getDatas("V_PM_PERF_INDICATORPAYQUANTITY", " pro_code = '" + procode + "' ",null);
                Map<String, Object> streamResult = quantityindex.stream().filter(item -> item.get("code") != null && item.get("indexval") != null)
                        .collect(Collectors.groupingBy(
                                item -> (String) item.get("code"),
                                Collectors.mapping(
                                        item -> (String) item.get("indexval"),
                                        Collectors.collectingAndThen(
                                                Collectors.toList(),
                                                values -> {
                                                    double total = values.stream()
                                                            .mapToDouble(value -> {
                                                                try {
                                                                    return Double.parseDouble(value);
                                                                } catch (NumberFormatException e) {
                                                                    return 0.00;
                                                                }
                                                            }).sum();
                                                    String result = String.valueOf(total);
                                                    if (total == (long) total) {
                                                        result = result.replaceAll("\\.0$", "");
                                                    }
                                                    return result;
                                                }
                                        )
                                )
                        ));
                for (Map<String, Object> map: indexs) {
                    if("11".equals(map.get("sindex"))){
                        map.put("indexval", streamResult.get(map.get("code")));
                    }
                }
            }
        }
        List<Map<String, Object>> tempList = null;
        List<Map<String, Object>> cols = proIndexTargetDAO.getCol(querytablecode);
        Map<String, Object> backMap = new HashMap<String, Object>();
        String sindex = "";
        List<Map<String, Object>> tempdatas = proIndexTargetDAO.getTempdatas(type,null);
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        for (Map<String, Object> map : indexs) {
            sindex = (String) map.get("sindex");
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            map.put("superid", sindex);
            if (!indexMap.containsKey(sindex)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(sindex, tempList);
            } else {
                tempList = indexMap.get(sindex);
            }
            tempList.add(map);
        }
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : cols) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (StringUtil.isEmpty(value) || "null".equals(value)) {
                    map.put(col, null);
                }
            }
            String levelno = map.get("levelno") + "";
            if ("2".equals(levelno)) {
                sindex = (String) map.get("guid");
            } else {
                sindex = "";
            }
            map.put("_isleaf", "0");
            map.put("isleaf", "0");
            map.put("filename", null);
            backdata.add(map);
            if (indexMap.containsKey(sindex)) {
                tempList = indexMap.get(sindex);
                backdata.addAll(tempList);
            }
        }
        backMap.put("#index", backdata);
        backMap.put("hidButtons", hidButtons);
        return backMap;
    }

    /**
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String mainguid = (String) params.get("mainguid");
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = "";
        int j = 0;
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
        //删除保存
        tablecode = "v_perf_t_proindextrace";
        proIndexTargetDAO.delDatas(tablecode, "mainguid='" + mainguid + "'");
        proIndexTargetDAO.saveAll(indexList,tablecode);
        //预警规则进行处理
        params.put("warmtype","goalwarn");
        String goalwarn = this.getWarn(params);
        proIndexTargetDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.goalwarn='" + goalwarn + "' where t.guid='" + mainguid + "'");
        //偏离度
        params.put("warmtype","gzdeviate");
        String gzdeviate = this.getWarn(params);
        proIndexTargetDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.gzdeviate='" + gzdeviate + "' where t.guid='" + mainguid + "'");
        if(PerfUtil.getIsHbei()){
            proIndexTargetDAO.update("update V_PERF_T_PROTRACEANALYSIS t set t.goaldeviate='" + gzdeviate + "' where t.mainguid='" + mainguid + "'");
            proIndexTargetDAO.update("update V_PERF_T_PROTRACEANALYSIS t set t.goalwarn='" + goalwarn + "' where t.mainguid='" + mainguid + "'");
        }
        if(PerfUtil.getIsTianJin()){
            //预警规则进行处理-全年预计完成情况偏离度预警
            params.put("warmtype","tracecompdeviate");
            String compdeviate = this.getWarn(params);
            proIndexTargetDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.compdeviate='" + compdeviate + "' where t.guid='" + mainguid + "'");
            params.put("warmtype","tracecomplatewarn");
            String compwarn = this.getWarn(params);
            proIndexTargetDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.compwarn='" + compwarn + "' where t.guid='" + mainguid + "'");
        }
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(indexList, busguid,"perf", null);
    }

    /**
     * <p>查询监控业务指标sql提取出来</p >
     *
     * @author hw
     * @date 2022/8/1 14:07
     * @param
     */
    public List<Map<String,Object>> getIndex(String bustype, String querytablecode, String filter, String mainguid, String filetype){
        List<Map<String, Object>> indexs = new ArrayList<Map<String, Object>>();
        if (PerfUtil.getIsSx() && "protrace".equals(bustype)) {
            StringBuffer sql = new StringBuffer("select t.*,t1.indexval as NCINDEXVAL,(select replace(wm_concat(vpf.filename), ',', '；') as filename from v_perf_file vpf where vpf.billguid = t.guid||'")
                    .append(mainguid).append("' and vpf.filetype = '").append(filetype).append("') as filename from (select t.*,tt.pro_code from ")
                    .append(querytablecode).append(" t left join v_perf_t_promonitor tt on t.mainguid = tt.guid) t left join v_perf_bgt_indicatorpf t1 on t.name = t1.name and t.sindex = t1.sindex and t.pro_code = t1.pro_code ");
            if (!StringUtil.isEmpty(filter)) {
                sql.append(" where ").append(filter);
            }
            sql.append(" order by t.sindex,t.findex,t.ordernum");
            logger.info("(山西)监控指标查sql+++++++++++++++++" + sql.toString());
            indexs = proIndexTargetDAO.queryForList(sql.toString());
        }else {
            indexs = proIndexTargetDAO.findIndexs(querytablecode, filter, mainguid, filetype);
        }
        return indexs;
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
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            proIndexTargetDAO.setYearAndProvince(queryYear, queryProvince);
        }
        List yeargoals = new ArrayList(); // 年度
        StringBuffer sql = new StringBuffer(" t.mainguid = '" + mainguid + "'");
        List<Map<String, Object>> indexs = proIndexTargetDAO.getDatas(proIndexTargetDAO.TABLE_INDEX, sql.toString(), null); //监控指标
        StringBuffer pmsql = new StringBuffer(" t.pro_code = '" + procode + "' and yearflag = '0' ");
        List<Map<String, Object>> goals = proIndexTargetDAO.getDatas(proIndexTargetDAO.TABLE_GOAL, pmsql.toString(), null); //项目目标
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
        if (indexs == null || indexs.size() <= 0) {//如果不存在数据  则查询项目申报表
            indexs = proIndexTargetDAO.getDatas("v_pm_perf_indicator", pmsql.toString(), null); //指标
            for (Map<String, Object> map: indexs) {
                map.put("targetvalue", map.get("indexval"));
                map.put("indexval", "");
                map.put("tindex", map.get("guid"));
                map.put("guid", this.getCreateguid());
            }
        }
        //需要监控的层次分类(一级)
        String hubeitraceindex = PerfUtil.getSystemSet("HUBEITRACEINDEX");
        String whereSql = "";
        if (!StringUtil.isEmpty(hubeitraceindex)) {
            Map<String, Object> map = PerfUtil.parseString2Map(hubeitraceindex);
            String framecode = (String) map.get("frame");
            if(!StringUtils.isEmpty(framecode)){
                whereSql = " (code in ("+framecode+") or superid in ("+framecode+"))";
            }
        }
        List<Map<String, Object>> tempdatas = proIndexTargetDAO.getTempdatas("PM001",whereSql); //模板信息
        List<Map<String, Object>> collist = proIndexTargetDAO.getCol(proIndexTargetDAO.TABLE_INDEX);
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
    public Map<String, Object> getProSubData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String goalguid = (String)params.get("goalguid");
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            proIndexTargetDAO.setYearAndProvince(queryYear, queryProvince);
        }
        List<Map<String, Object>> collist = proIndexTargetDAO.getCol(proIndexTargetDAO.TABLE_INDEX);
        //需要监控的层次分类(一级)
        String hubeitraceindex = PerfUtil.getSystemSet("HUBEITRACEINDEX");
        String whereSql = "";
        if (!StringUtil.isEmpty(hubeitraceindex)) {
            Map<String, Object> map = PerfUtil.parseString2Map(hubeitraceindex);
            String framecode = (String) map.get("frame");
            if(!StringUtils.isEmpty(framecode)){
                whereSql = " (code in ("+framecode+") or superid in ("+framecode+"))";
            }
        }
        List<Map<String, Object>> tempdatas = proIndexTargetDAO.getTempdatas("PM001",whereSql); //模板信息
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
        String tablecode = "";
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
            //删除保存
            tablecode = "v_perf_t_proindextrace";
            proIndexTargetDAO.delDatas(tablecode, "mainguid='" + mainguid + "'");
            proIndexTargetDAO.saveAll(indexList,tablecode);
            //预警规则进行处理
            params.put("warmtype","goalwarn");
            String goalwarn = this.getWarn(params);
            proIndexTargetDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.goalwarn='" + goalwarn + "' where t.guid='" + mainguid + "'");
            //偏离度
            params.put("warmtype","gzdeviate");
            String gzdeviate = this.getWarn(params);
            proIndexTargetDAO.update("update " + ProTraceManageDAO.PERF_TABLE_TRACEMANAGE + " t set t.gzdeviate='" + gzdeviate + "' where t.guid='" + mainguid + "'");
        }
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(indexList, busguid,"perf", null);
    }

    /**
     * 查询各年度数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> getindexAndGoal(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String bustype = (String)params.get("bustype");
        String procode = (String) params.get("procode");
        String mainguid = (String) params.get("mainguid");
        String tablecode = "";
        String querytablecode = "V_PERF_T_PROINDEXTRACE";
        String type = "";
        String filter = "";
        String filetype = bustype + "traceindexfile";
        String hidButtons = "";
        if (bustype != null && "depttrace".equals(bustype)) {
            type = "DEPT";
            tablecode = "V_BGT_PERF_INDICATOR";
        } else if (bustype != null && "protrace".equals(bustype)) {
            type = "PM001";
            tablecode = "V_PM_PERF_INDICATOR";
        }
        //查询监控指标是否存在（草稿或者业务数据），都不存在，则显示项目指标
        List<Map<String, Object>> indexs = null;
        if (PerfUtil.getIsHbei() || "depttrace".equals(bustype)) {
            filter = " t.mainguid='" + proguid + "'";
        } else {
            filter = " t.pro_code='" + procode + "'";
            if (PerfUtil.getIsGuangXi()) {
                filter += " and t.isapply = 1";
            }
        }
        if ("protrace".equals(bustype)) {
            filter += " and t.yearflag = '0'";
        }
        if (PerfUtil.getIsSx() && "protrace".equals(bustype)) {
            StringBuffer sql = new StringBuffer("select t.*, t1.indexval as NCINDEXVAL, t.is_deleted, t.TARGETVALUE from ").append(tablecode)
                    .append(" t left join v_perf_bgt_indicatorpf t1 on t.pro_code = t1.pro_code and t.name = t1.name and t.sindex = t1.sindex ");
            if (!StringUtil.isEmpty(filter)) {
                sql.append(" where ").append(filter);
            }
            sql.append(" order by t.sindex,t.findex,t.ordernum");
            StringBuffer delsql = new StringBuffer("select t.* from v_perf_bgt_indicatorpf t")
                    .append(" where not exists (select 1 from V_PM_PERF_INDICATOR t1 where t.pro_code = t1.pro_code and t.name = t1.name and t.sindex = t1.sindex) and t.is_deleted <> 1");
            if (!StringUtil.isEmpty(filter)) {
                delsql.append(" and ").append(filter);
            }
            logger.info("(山西删除)监控指标查sql+++++++++++++++++" + delsql.toString());
            List<Map<String, Object>> delindexs = proIndexTargetDAO.queryForList(delsql.toString());
            logger.info("(山西)监控指标查sql+++++++++++++++++" + sql.toString());
            indexs = proIndexTargetDAO.queryForList(sql.toString());
            for (Map<String, Object> map: delindexs) {
                map.put("is_deleted", 1);
                map.put("targetvalue", "");
                map.put("ncindexval", map.get("indexval"));
                map.put("indexval", "");
                indexs.add(map);//删除指标
            }
        } else {
            indexs = proIndexTargetDAO.findIndexs(tablecode, filter, proguid, filetype);
        }
        for (Map<String, Object> map: indexs) {
            map.put("targetvalue", map.get("indexval"));
            map.put("indexval", "");
            map.put("tindex", map.get("guid"));
            map.put("guid", this.getCreateguid());
        }
        List<Map<String, Object>> tempList = null;
        List<Map<String, Object>> cols = proIndexTargetDAO.getCol(querytablecode);
        Map<String, Object> backMap = new HashMap<String, Object>();
        String sindex = "";
        List<Map<String, Object>> tempdatas = proIndexTargetDAO.getTempdatas(type,null);
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        for (Map<String, Object> map : indexs) {
            sindex = (String) map.get("sindex");
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            map.put("superid", sindex);
            if (!indexMap.containsKey(sindex)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(sindex, tempList);
            } else {
                tempList = indexMap.get(sindex);
            }
            tempList.add(map);
        }
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : cols) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (StringUtil.isEmpty(value) || "null".equals(value)) {
                    map.put(col, null);
                }
            }
            String levelno = map.get("levelno") + "";
            if ("2".equals(levelno)) {
                sindex = (String) map.get("guid");
            } else {
                sindex = "";
            }
            map.put("_isleaf", "0");
            map.put("isleaf", "0");
            map.put("filename", null);
            backdata.add(map);
            if (indexMap.containsKey(sindex)) {
                tempList = indexMap.get(sindex);
                backdata.addAll(tempList);
            }
        }
        backMap.put("#index", backdata);
        backMap.put("hidButtons", hidButtons);
        //删除已填报监控指标数据
        String wheresql = "mainguid='" + mainguid + "'";
        proIndexTargetDAO.delDatas(querytablecode, wheresql);
        //处理监控分析暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        Map<String, Object> midMap = new HashMap();
        String url1 = "";
        String url2 = "";
        if ("depttrace".equals(bustype)) {
            url1 = "/pmkpi/trace/report/deptedit";
            url2 = "/pmkpi/trace/report/deptedit/indextarget";
        } else {
            url1 = "/pmkpi/program/trace/report/edit";
            url2 = "/pmkpi/program/trace/report/edit/indextarget";
        }
        midMap.put("url", url1);
        midMap.put("mainguid", mainguid);
        midMap.put("compconfigid", "analysisformaleditform");
        midMap.put("componentid", "buscommon.ui.editform");
        Map<String, Object> querymidMap = perfMidsaveBO.getMidData(midMap);
        Map<String, Object> analysisMap = (Map<String, Object>) querymidMap.get("result");
        //删除指标暂存数据
        Map<String, Object>  delparams = new HashMap();
        delparams.put("mainguid", mainguid);
        delparams.put("url", url2);
        delparams.put("compconfigid", "datatable");
        perfMidsaveBO.delTabData(delparams);
        //更新监控主表信息
        List<String> upcols = new ArrayList<>();
        StringBuffer upsql = new StringBuffer();
        upsql.append("update ").append(ProTraceManageDAO.PERF_TABLE_TRACEMANAGE).append(" set ");
        upcols.add("goalwarn");
        upcols.add("gzdeviate");
        if (PerfUtil.getIsTianJin()) {
            upcols.add("compdeviate");
            upcols.add("compwarn");
        }
        for (String col : upcols) {
            upsql.append(col).append(" = null, ");
        }
        upsql.deleteCharAt(upsql.length() - 2);
        upsql.append(" where guid = '").append(mainguid).append("'");
        proIndexTargetDAO.execute(upsql.toString());
        //更新监控分析
        if (PerfUtil.getIsHbei()) {
            upcols = new ArrayList<>();
            upsql = new StringBuffer();
            upsql.append("update ").append(ProTraceManageDAO.PERF_TABLE_PROTRACEANALYSIS).append(" set ");
            upcols.add("goalwarn");
            upcols.add("goaldeviate");
            for (String col : upcols) {
                upsql.append(col).append(" = null, ");
            }
            upsql.deleteCharAt(upsql.length() - 2);
            upsql.append(" where mainguid = '").append(mainguid).append("'");
            proIndexTargetDAO.execute(upsql.toString());
            // 更新监控分析暂存数据
            if (analysisMap != null && !analysisMap.isEmpty()) {
                analysisMap.put("goalwarn", null);
                analysisMap.put("goaldeviate", null);
                midMap.put("data", analysisMap);
                perfMidsaveBO.saveData(midMap);
            }
        }
        return backMap;
    }


    /**
     * 获取最新申报的目标、指标.(湖北)
     * @param params -- 参数集合.
     * @return yeargoals.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> getnewindexAndGoal(Map<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String procode = (String) params.get("procode");
        String mainguid = (String) params.get("mainguid");
        //获取最新申报数据
        List yeargoals = new ArrayList(); // 年度
        StringBuffer pmsql = new StringBuffer(" t.pro_code = '" + procode + "' and yearflag = '0' ");
        List<Map<String, Object>> goals = proIndexTargetDAO.getDatas(proIndexTargetDAO.TABLE_GOAL, pmsql.toString(), null); //项目目标
        List<Map<String, Object>> indexs = proIndexTargetDAO.getDatas("v_pm_perf_indicator", pmsql.toString(), null); //项目指标
        for (Map<String, Object> map: indexs) {
            map.put("targetvalue", map.get("indexval"));
            map.put("indexval", "");
            map.put("tindex", map.get("guid"));
            map.put("guid", this.getCreateguid());
        }
        //需要监控的层次分类(一级)
        String hubeitraceindex = PerfUtil.getSystemSet("HUBEITRACEINDEX");
        String whereSql = "";
        if (!StringUtil.isEmpty(hubeitraceindex)) {
            Map<String, Object> map = PerfUtil.parseString2Map(hubeitraceindex);
            String framecode = (String) map.get("frame");
            if(!StringUtils.isEmpty(framecode)){
                whereSql = " (code in ("+framecode+") or superid in ("+framecode+"))";
            }
        }
        List<Map<String, Object>> tempdatas = proIndexTargetDAO.getTempdatas("PM001",whereSql); //模板信息
        List<Map<String, Object>> collist = proIndexTargetDAO.getCol(proIndexTargetDAO.TABLE_INDEX);
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
        //删除已填报的监控指标业务数据(包括暂存)
        String wheresql = "mainguid='" + mainguid + "'";
        proIndexTargetDAO.delDatas(proIndexTargetDAO.TABLE_INDEX, wheresql);
        Map delparams = new HashMap();
        delparams.put("delsql",wheresql);
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delData(delparams);
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
        List<Map<String, Object>> indexs = (List<Map<String, Object>>) dataMap.get("#index");
        if (indexs != null && !indexs.isEmpty()) {
            indexs = indexs.stream().filter(m-> "1".equals(m.get("isleaf"))).collect(Collectors.toList());
        }
        List<Map<String, Object>> list = PerfUtil.getSourceData(ProIndexTargetDAO.INDEX_DATASOURCE, null);
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
                String indexval = (String) data.get("indexval");
                indexval = (String) map.get(indexval);
                data.put("indexval", indexval);
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
        String pro_code = (String) paras.get("procode");
        String impguid = (String) paras.get("impguid");
        String taskguid = (String) paras.get("taskguid");
        String taskstage = (String) paras.get("taskstage");
        String wheresql = " mainguid=? ";
        String itablecode = PerfConstant.PMKPI_VPM_INDICATOR;
        List<Map<String, Object>> indexList = proIndexTargetDAO.getDatas(tablecode, wheresql, null, new String[]{mainguid});
        if (indexList == null || indexList.isEmpty()) {
            if ("protrace".equals(bustype)) {
                wheresql = " pro_code=? and yearflag='0'";
            }
            indexList = proIndexTargetDAO.getDatas(itablecode, wheresql, null, new String[]{pro_code});
            for (Map<String, Object> map: indexList) {
                map.put("targetvalue", map.get("indexval"));
                map.put("indexval", "");
                map.put("tindex", map.get("guid"));
                map.put("guid", this.getCreateguid());
            }
        } else {
            for (Map<String, Object> map: indexList) {
                String sindex = (String) map.get("sindex");
                map.put("levelno", "3");
                map.put("isleaf", "1");
                map.put("_isleaf", "1");
                map.put("superid", sindex);
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
        if (PerfUtil.get_isCheckSpace()) {
            valpattern = Pattern.compile("[ 　*_-]");
        }
        List<Map<String, Object>> list = PerfUtil.getSourceData(ProIndexTargetDAO.INDEX_DATASOURCE, null);
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
        Matcher matcher = null;
        for (Map<String, Object> data : indexList) {
            String name = (String) data.get("name");
            if("depttrace".equals(bustype) && PerfUtil.getIsZJ()){
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
                    String indexval = (String) impData.get("indexval");
                    if ("NULL".equals(indexval) || "null".equals(indexval)) {
                        error.append("实际完成值不能为").append(indexval).append("，请重新填写 ");
                    } else if (!"6".equals(computesign) && !PerfUtil.isNumeric(indexval)) {
                        error.append("定量指标实际完成值填数字。");
                    } else if ("6".equals(computesign) && StringUtil.isNullOrEmpty(map.get(indexval))) {
                        error.append("定性指标实际完成值请填写‘达成’，‘部分达成’，‘未达成’三项中的一个。");
                    } else if ("6".equals(computesign)) {
                        indexval = (String) map.get(indexval);
                        impData.put("indexval", indexval);
                    }
                    if (!StringUtil.isEmpty(indexval)) {
                        matcher = valpattern.matcher(indexval);
                        if (matcher.find()) {
                            String msg = "定性指标值填写不支持特殊字符，请重新填写 ";
                            if (PerfUtil.get_isCheckSpace()) {
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
                    impData.remove("targetvalue");
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
            String indexval = (String) data.get("indexval");
            String targetvalue = (String) data.get("targetvalue");
            BigDecimal ind = null;
            if (Arrays.asList("1", "2", "3", "4", "5").contains(computesign)) {
                ind = new BigDecimal(StringUtil.isNullOrEmpty(indexval) ? "0" : indexval);
            }
            String findex = (String) data.get("findex");
            String sindex = (String) data.get("sindex");
            HashMap<String, Object> params = new HashMap<>();
            String warmtype = "";
            if ("1".equals(computesign) || "2".equals(computesign)) {
                warmtype = "positiveindex"; //正向指标
            } else if ("3".equals(computesign)) { //等于指标
                if (ind.compareTo(BigDecimal.ZERO) == 0) {
                    warmtype = "traceindexequalzero";
                } else {
                    warmtype = "positiveindex";
                }
            } else if ("4".equals(computesign)) {
                warmtype = "reverselessindex";
            } else if ("5".equals(computesign)) {
                warmtype = "reverseindex";
            } else {
                warmtype = "qualitativeindex";
            }
            params.put("warmtype", warmtype);
            params.put("taskguid", taskguid);
            params.put("mainguid", mainguid);
            params.put("taskstage", taskstage);
            params.put("findex", findex);
            params.put("sindex", sindex);
            params.put("targetvalue", targetvalue);
            params.put("indexval", indexval);
            String value = this.getWarn(params);
            data.put("warn", value);
        }
        Map<String, Object> saveMap = new HashMap<>();
        saveMap.put("guid", impguid);
        saveMap.put("data", PerfUtil.parse2Json(indexList));
        this.getBasMap(saveMap, "add");
        proIndexTargetDAO.save(saveMap, PerfMidsaveBO.MIDSAVE_TABLE);
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
