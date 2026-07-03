package gov.mof.fasp2.pmkpi.transpaypro;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.daosupport.cache.Fasp2DaoCacheUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;
import java.util.stream.Collectors;

public class TranspayProIndexBO extends PmkpiBO {

    private TranspayProIndexDAO transpayProIndexDAO;

    public void setTranspayProIndexDAO(TranspayProIndexDAO transpayProIndexDAO) {
        this.transpayProIndexDAO = transpayProIndexDAO;
    }

    /**
     * 保存.
     * @param params
     * @throws Exception
     */
    public Map<String, Object> savemajorkey(Map<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        this.getWarns(datas);
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        String busguid = (String) params.get("busguid");
        String tablecode = (String) params.get("tablecode");
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        List<String> updatecols = (List)params.get("updatecols");
        String leftcode = (String)params.get("leftcode");
        String leftcodevalue = (String)params.get("leftcodevalue");
        if(updatecols==null){
            updatecols = new ArrayList<>();
        }
        List<String> delcols =  (List)params.get("delcols");
        if(delcols==null){
            delcols = new ArrayList<>();
        }
        if(year==null||year.isEmpty()){
            year = CommonUtil.getYear();
        }
        if(province==null||province.isEmpty()){
            province = SecureUtil.getUserSelectProvince();
        }
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            if(map.get("ordernum") == null || StringUtil.isEmpty(map.get("ordernum")+"")){
                map.put("ordernum", i++);
            }
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("create_time", PerfUtil.getServerTimeStamp());
                map.put("update_time", PerfUtil.getServerTimeStamp());
                map.put("province", province);
                map.put("is_deleted", "2");
                map.put("year", year);
                if(leftcode!=null&&!"".equals(leftcode)){
                    map.put(leftcode,leftcodevalue);
                }
                addlist.add(map);
            } else {
                map.put("update_time", PerfUtil.getServerTimeStamp());
                uplist.add(map);
            }
        }
        delcols.remove("guid");
        if (addlist.size() > 0) {
            transpayProIndexDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            transpayProIndexDAO.updateAllByMajorPK(Fasp2DaoCacheUtil.getTableColumn(tablecode),uplist, "guid", tablecode,updatecols);
        }
        if (deldatas.size() > 0) {
            transpayProIndexDAO.saveAll(deldatas, transpayProIndexDAO.PMKPI_TABLE_TMP_GUIDS);
            Map<String,Object> map1 = (Map)(((List)deldatas).get(0));
            StringBuffer delsql = new StringBuffer(" exists(select 1 from ");
            delsql.append(transpayProIndexDAO.PMKPI_TABLE_TMP_GUIDS).append(" a where a.guid=t.guid) ");
            for (String str:delcols) {
                delsql.append(" and ").append(str).append("='").append(map1.get(str)).append("'");
            }
            transpayProIndexDAO.updateIsDeleteDatas(tablecode, delsql.toString());
        }
//        Map<String, Object> checkMap  = this.checkData(datas);
//        if(checkMap != null && !checkMap.isEmpty() && checkMap.get("success").equals(false)){
//            throw new PerfAppException("checkAuditDefine", "force", checkMap);
//        }
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 校验数据，上传附件必填
     * @param datas
     */
    public Map<String, Object> checkData(List<Map<String, Object>> datas){
        Map<String, Object> backMap = new HashMap<String, Object>();
        Map<String, Object> errMap = null;
        List<Map<String, Object>> errdata = new ArrayList<>();
        for (Map<String, Object> map : datas) {
            String mainguid = (String) map.get("guid");
            String proname = (String) map.get("pro_name");
            List<Map<String, Object>> filelist =  transpayProIndexDAO.getDatas("v_perf_file"," t.billguid = '"+mainguid+"' and t.filetype = 'fundmanagefile' ",null);
            if (filelist.size() < 1) {//本轮资金管理文件
                errMap = new HashMap<String, Object>();
                errMap.put("remark", "【" + proname + "】本轮资金管理文件必须上传；");
                errMap.put("code", "001");
                errMap.put("name", "校验到本轮资金管理文件");
                errMap.put("explain", "校验本轮资金管理文件");
                errdata.add(errMap);
            }
            int yearE = StringUtil.isNullOrEmpty((String) map.get("yearcol5")) ? 0 : Integer.valueOf((String) map.get("yearcol5"));
            if(yearE!=0){//最近开展到期绩效评价的年份 不为空，到期绩效评价报告附件必须上传
                filelist =  transpayProIndexDAO.getDatas("v_perf_file"," t.billguid = '"+mainguid+"' and t.filetype = 'evalreportfile' ",null);
                if (filelist.size() < 1) {
                    errMap = new HashMap<String, Object>();
                    errMap.put("remark", "【" + proname + "】最近开展到期绩效评价的年份不为空,到期绩效评价报告附件必须上传；");
                    errMap.put("code", "001");
                    errMap.put("name", "校验到期绩效评价报告");
                    errMap.put("explain", "校验到期绩效评价报告");
                    errdata.add(errMap);
                }
            }
        }
        if (errdata != null && !errdata.isEmpty()) {
            errdata = errdata.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() ->
                    new TreeSet<>(Comparator.comparing((o) -> o.get("remark") + ""))), ArrayList::new)); // 去重
            logger.info("---errdata：" + errdata.toString());
            backMap.put("success", false);
            backMap.put("redata", errdata);
        }
        return backMap;
    }

    /**
     * 获取预警灯规则
     * C或D为空
     * 绿灯：(sysdate <B)
     * 黄灯：(b+3>sysdate >=B)
     * 红灯：(sysdate >=3+b)
     * C,D都不为空
     * 绿灯：(G>=B and F<=A) or ( G>=D and F<=C and sysdate < B)
     * 黄灯：(G>=D and F<=C and sysdate > = B )
     * 红灯：(G<D and F<C) or (G IS NULL OR F IS NULL  )
     * @param datas
     */
    public void getWarns(List<Map<String, Object>> datas){
        int dbyear =Integer.valueOf(StringUtil.getSysDBYear());
        for (Map<String, Object> map : datas) {
            int yearA = StringUtil.isNullOrEmpty((String) map.get("yearcol1")) ? 0 : Integer.valueOf((String) map.get("yearcol1"));
            int yearB = StringUtil.isNullOrEmpty((String) map.get("yearcol2")) ? 0 : Integer.valueOf((String) map.get("yearcol2"));
            int yearC = StringUtil.isNullOrEmpty((String) map.get("yearcol3")) ? 0 : Integer.valueOf((String) map.get("yearcol3"));
            int yearD = StringUtil.isNullOrEmpty((String) map.get("yearcol4")) ? 0 : Integer.valueOf((String) map.get("yearcol4"));
            int yearE = StringUtil.isNullOrEmpty((String) map.get("yearcol5")) ? 0 : Integer.valueOf((String) map.get("yearcol5"));
            int yearF = StringUtil.isNullOrEmpty((String) map.get("yearcol6")) ? 0 : Integer.valueOf((String) map.get("yearcol6"));
            int yearG = StringUtil.isNullOrEmpty((String) map.get("yearcol7")) ? 0 : Integer.valueOf((String) map.get("yearcol7"));
            if(yearC==0 || yearD==0 ){
                if(dbyear<yearB){
                    map.put("warn","green");
                }else if(yearB<=dbyear){
                    map.put("warn","yellow");
                }else if(dbyear>=(yearB+3)){
                    //map.put("warn","red");
                    map.put("warn","");
                }else{
                    map.put("warn","");
                }
            }else if(yearG==0 || yearF==0){
                map.put("warn","red");
            }else{
                if((yearG>=yearB && yearF<=yearA) || (yearG>=yearD && yearF<=yearC && dbyear< yearB)){
                    map.put("warn","green");
                }else if(yearG>=yearD && yearF<=yearC && dbyear>=yearB){
                    map.put("warn","yellow");
                }else if((yearG<yearD && yearF<yearC)){
                    map.put("warn","red");
                }else{
                    map.put("warn","");
                }
            }
        }
    }

    /**
     * 查询数据.
     * @param params
     * @return
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String)params.get("tablesql");
        String querySql = (String)params.get("querySql");
        String wheresql = " 1=1 ";
        if(tablesql != null && !tablesql.isEmpty()){
            wheresql += " and " + tablesql;
        }
        if(querySql != null && !querySql.isEmpty()){
            wheresql += " and " + querySql;
        }
        List<Map<String, Object>> data = transpayProIndexDAO.getTableDatas(tablecode, wheresql, "order by ordernum");
        backMap.put("data", data);
        return backMap;
    }

    @Override
    public String getVodSql(Map params) throws AppException {
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String)params.get("tablesql");
        String querySql = (String)params.get("querySql");
        String menuid = (String) params.get("menuid");
        String type = (String) params.get("type");
        String wheresql = this.getDataRuleByMenuguidNull(menuid, "t", "1=1"); //数据权限
        if(!StringUtil.isNullOrEmpty(type) && "selectpro".equals(type)){
            String cfgquerysql = (String)params.get("cfgquerysql");
            tablecode = "v_perf_project_selfresult";
            if(cfgquerysql != null && !cfgquerysql.isEmpty()){
                wheresql += " and " + cfgquerysql;
            }
        }
        if(tablesql != null && !tablesql.isEmpty()){
            wheresql += " and " + tablesql;
        }
        if(querySql != null && !querySql.isEmpty()){
            wheresql += " and " + querySql;
        }
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        sql.append(wheresql);
        return sql.toString();
    }
}
