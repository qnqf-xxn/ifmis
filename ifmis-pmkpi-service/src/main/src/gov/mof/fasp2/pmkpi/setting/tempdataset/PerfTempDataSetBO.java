package gov.mof.fasp2.pmkpi.setting.tempdataset;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.cache.service.CacheManager;
import gov.mof.fasp2.buscore.framework.daosupport.cache.Fasp2DaoCacheUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;
import java.util.stream.Collectors;

public class PerfTempDataSetBO extends PmkpiBO {

    private PerfTempDataSetDAO perfTempDataSetDAO;

    public void setPerfTempDataSetDAO(PerfTempDataSetDAO perfTempDataSetDAO) {
        this.perfTempDataSetDAO = perfTempDataSetDAO;
    }
    private CacheManager cacheManager;

    private CacheManager getCacheManager() {
        if (cacheManager == null) {
            cacheManager = (CacheManager) ServiceFactory.getBean("buscore.cache.cachemanager");
        }
        return cacheManager;
    }
    /**
     * 查询数据方法
     * @param parms --
     * @return
     * @throws AppException
     */
    @Override
    public String getVodSql(Map parms) throws AppException{
        String wheresql = (String) parms.get("querySql"); //查询区封装的参数
        String tablecode = (String)parms.get("tablecode");
        String tablesql = (String) parms.get("tablesql"); //表格配置的sql
        String leftcodevalue = (String)parms.get("leftcodevalue"); //左侧树选中区划
        StringBuffer returnsql = new StringBuffer();
        String leftcode = (String)parms.get("leftcode");
        returnsql.append("select * from ").append(tablecode).append(" t ");
        StringBuffer wsql = new StringBuffer();
        if (leftcodevalue != null && !leftcodevalue.isEmpty()){
            wsql.append(leftcode).append(" in("+leftcodevalue+") and ");
        }
        if (wheresql != null && !wheresql.isEmpty()){
            wsql.append(" (").append(wheresql).append(") and ");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            wsql.append(tablesql).append(" and ");
        }
        if (wsql.length() > 0) {
            returnsql.append(" where ").append(wsql.substring(0, wsql.length() - 4));
        }
        return returnsql.toString();
    }

    /**
     * 保存.
     * @param params
     * @throws Exception
     */
    public void savemajorkey(Map<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
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
        int i = 0;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            i++;
            if (map.get("ordernum") == null || "".equals(map.get("ordernum"))) {
                map.put("ordernum", i);
            }
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("province", province);
                map.put("year", year);
                map.put("status", 1);
                map.put("appid", "pmkpi");
                if(leftcode!=null&&!"".equals(leftcode)){
                    map.put(leftcode,leftcodevalue);
                }
                addlist.add(map);
            } else {
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                uplist.add(map);
            }
        }
        delcols.remove("guid");
        if (addlist.size() > 0) {
            perfTempDataSetDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            perfTempDataSetDAO.updateAllByMajorPK(Fasp2DaoCacheUtil.getTableColumn(tablecode),uplist, "guid", tablecode,updatecols);
        }
        if (deldatas.size() > 0) {
            perfTempDataSetDAO.saveAll(deldatas, perfTempDataSetDAO.PMKPI_TABLE_TMP_GUIDS);
            Map<String,Object> map1 = (Map)(((List)deldatas).get(0));
            StringBuffer delsql = new StringBuffer(" exists(select 1 from ");
            delsql.append(perfTempDataSetDAO.PMKPI_TABLE_TMP_GUIDS).append(" a where a.guid=t.guid) ");
            for (String str:delcols) {
                delsql.append(" and ").append(str).append("='").append(map1.get(str)).append("'");
            }
            perfTempDataSetDAO.delDatas(tablecode, delsql.toString());
        }
        List<String> cachenames = new ArrayList();
        if ((addlist.size() > 0 || uplist.size() > 0 || deldatas.size() > 0) && "PERF_ENUM".equals(tablecode)) {
            cachenames.add("busfw.cache.ui.dataSetMapper");
            getCacheManager().refreshCache(cachenames);
        }
    }

    public void save(Map<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        String tablecode = (String) params.get("tablecode");
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        if(year==null||year.isEmpty()){
            year = CommonUtil.getYear();
        }
        if(province==null||province.isEmpty()){
            province = SecureUtil.getUserSelectProvince();
        }
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 0;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            i = i++;
            String ordernum = map.get("ordernum") + "";
            if (ordernum == null || ordernum.isEmpty() || "null".equals(ordernum)) {
                map.put("ordernum", i);
            }
            if (rowtype != null && "add".equals(rowtype)) {
                String levelno = (String) map.get("levelno") + "";
                if ("1".equals(levelno)) {
                    map.put("superid", "0");
                }
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("province", province);
                map.put("year", year);
                addlist.add(map);
            } else {
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            perfTempDataSetDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            perfTempDataSetDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            perfTempDataSetDAO.saveAll(deldatas, perfTempDataSetDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + perfTempDataSetDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            perfTempDataSetDAO.delDatas(tablecode, delsql);
        }
    }
    /**
     * 初始化当年指标数据，赋值上一年的数据到当前年度，如果上年度没有的话就去赋值2016年87年度的数据
     * @param params --
     * @return --
     */
    public void copyIndex(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        List<Map<String,Object>> indexs = new ArrayList<>();
        String province = CommonUtil.getProvince();
        //先查询上年数据，没有查询87,2016的数据
        int lastyear = Integer.parseInt(CommonUtil.getYear()) - 1;
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(" t.year='").append(lastyear)
                .append("' and t.province='").
                append(province).append("'");
        indexs = perfTempDataSetDAO.getData(wheresql.toString(),tablecode);
        if(indexs.size()<= 0 || indexs == null){
            wheresql = new StringBuffer();
            wheresql.append(" t.year=2016 ").append(" and t.province='87'");
            indexs= perfTempDataSetDAO.getData(wheresql.toString(),tablecode);
        }
        String sql1 = "select guid from "+ tablecode + " t where t.year= '"+ CommonUtil.getYear()+"' and t.province = '"+SecureUtil.getUserSelectProvince()+"'";
        List<Map<String,Object>> already = perfTempDataSetDAO.queryForList(sql1);
        List<String> resultlist = new ArrayList<>();
        for (Map map:already) {
            resultlist.add((String) map.get("guid"));
        }
        //将每一条数据的年度改为当前年度，区划改为当前区划
        Iterator<Map<String,Object>> li = indexs.iterator();
        while (li.hasNext()){
            Map<String,Object> map =  li.next();
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            if(resultlist.contains(map.get("guid"))){
                li.remove();
            }
        }
        /*for (Map map :indexs) {
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
        }*/
        //当查询的数据都为空，则不删除原有的数据。
        /*if(indexs.size()>0&&indexs!=null){
            String delsql = "t.province = '"+SecureUtil.getUserSelectProvince()+
                    "' and "+" t.year = " + CommonUtil.getYear();
            perfTempDataSetDAO.delDatas(tablecode, delsql);
        }*/
        //保存数据
        perfTempDataSetDAO.saveAll(indexs, tablecode);
    }
    /**
     * 左侧树初始化
     * @param params
     * @return
     */
    public Boolean initleftset(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        //全部数据
        List<Map<String, Object>> alldatas = perfTempDataSetDAO.initleftset(params);
        perfTempDataSetDAO.saveAll(alldatas,tablecode);
        List<String> cachenames = new ArrayList();
        if (alldatas.size() > 0 && "PERF_ENUM".equals(tablecode)) {
            cachenames.add("busfw.cache.ui.dataSetMapper");
            getCacheManager().refreshCache(cachenames);
        }
        return true;
    }
    /**
     * 获取左侧树数据.
     * @param tablecode --
     * @return --
     */
    public Map<String, Object> getTreeData(String tablecode) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String treesource = PerfUtil.getSystemSet("dept_letftree");
        if (treesource != null && !treesource.isEmpty()){
            leftconfig.put("datas", perfTempDataSetDAO.getLeftTree(tablecode));
        }
        return leftconfig;
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
        String bustype = (String)params.get("bustype");
        String querySql = (String)params.get("querySql");
        String leftcode = (String)params.get("leftcode");
        String leftcodevalue = (String)params.get("leftcodevalue"); //左侧树选中区划
        String wheresql = "";
        if (leftcodevalue != null && !leftcodevalue.isEmpty()){
            wheresql += leftcode +" in("+leftcodevalue+") and ";
        }
        if(tablesql != null && !tablesql.isEmpty()){
            wheresql += tablesql + " and ";
        }
        if(querySql != null && !querySql.isEmpty()){
            wheresql += querySql + " and ";
        }
        if(bustype != null && !bustype.isEmpty()){
            wheresql += " bustype='" + bustype + "' and ";
        }
        if (!StringUtil.isEmpty(wheresql)) {
            wheresql = wheresql.substring(0, wheresql.length() - 4);
        }
        List<Map<String, Object>> data = perfTempDataSetDAO.getTableDatas(tablecode, wheresql, "order by ordernum");
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 左侧树信息
     */
    @SuppressWarnings("rawtypes")
    public Map<String, Object> getLeftTree() throws AppException {
        List<Map<String, Object>> eledatas = perfTempDataSetDAO.getDatas("v_perf_t_datasource", "elementcode='scoretype'", "order by ordernum");
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("name", "业务类型");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", eledatas);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 2);
        return leftconfig;
    }


    /**
     * 复制本区划的数据到其他区划，当前区划有的其他数据没有的数据复制到其他区划
     * @param params --
     * @return --
     */
    public Boolean copyDatas(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String leftcode = (String) params.get("leftcoe");
        String leftcodevalue = (String) params.get("leftcodevalue"); //左侧树选中的区划
        String province = SecureUtil.getUserSelectProvince();
        List<Map<String, Object>> alldatas = new ArrayList<>();
        String[] leftvalue = leftcodevalue.split(",");
        String sql = "select t.* from " + tablecode + " t where t.province = '"+province+"'";
        for (String provinces : leftvalue) {
            //查询当前区划的数据（不分年度）
            List<Map<String, Object>> newDatas = perfTempDataSetDAO.queryForList(sql);
            //循环查询选中区划的数据
            String sql1 = "select guid,elementcode from "+ tablecode + " t where t."+leftcode+" in('"+provinces+"')";
            List<Map<String,Object>> already = perfTempDataSetDAO.queryForList(sql1);
            for (Map map:already) {
                String guid = map.get("guid") + "@-@" + map.get("elementcode");
                //过滤要复制的数据(过滤掉重复的数据)
                newDatas = newDatas.stream().filter(map1 -> !guid.equals(map1.get("guid") + "@-@" + map1.get("elementcode"))).collect(Collectors.toList());
            }
            //循环当前区划的数据，更新修改时间和区划字段
            Iterator<Map<String,Object>> li = newDatas.iterator();
            while (li.hasNext()){
                Map<String,Object> map =  li.next();
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("year", CommonUtil.getYear());
                map.put(leftcode,provinces);
            }
            alldatas.addAll(newDatas);
        }
        try{
            perfTempDataSetDAO.saveAll(alldatas,tablecode);  //保存方法
            List<String> cachenames = new ArrayList();
            if (alldatas.size() > 0 && "PERF_ENUM".equals(tablecode)) {
                cachenames.add("busfw.cache.ui.dataSetMapper");
                getCacheManager().refreshCache(cachenames);
            }
            return true;
        }catch (Exception e){
            return false;
        }
    }
}
