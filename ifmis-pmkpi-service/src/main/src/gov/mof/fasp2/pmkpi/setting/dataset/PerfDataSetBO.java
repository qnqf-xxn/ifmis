package gov.mof.fasp2.pmkpi.setting.dataset;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.daosupport.cache.Fasp2DaoCacheUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfDataSetBO extends PmkpiBO {
    private PerfDataSetDAO perfDataSetDAO;

    public void setPerfDataSetDAO(PerfDataSetDAO perfDataSetDAO) {
        this.perfDataSetDAO = perfDataSetDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String year = (String) sqlmap.get("year");
        String province = (String) sqlmap.get("province");
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select * from ").append(tablecode).append(" t where 1=1 ");
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if(year != null && !year.isEmpty()){
            returnsql.append(" and ").append("year='"+year+"'");
        }
        if(province != null && !province.isEmpty()){
            returnsql.append(" and ").append("province='"+province+"'");
        }
        return returnsql.toString();
    }

    /**
     * 保存
     * @param params
     * @throws AppException
     */
    @SuppressWarnings("unchecked")
    public void save(Map<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        String tablecode = (String) params.get("tablecode");
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        if(year == null || year.isEmpty()){
            year = CommonUtil.getYear();
        }
        if(province == null || province.isEmpty()){
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
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", province);
                map.put("year", year);
                map.put("status", 1);
                addlist.add(map);
            } else {
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            perfDataSetDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            perfDataSetDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            List<String> delguids = new ArrayList<>();
            for (Map<String, Object> map : deldatas) {
                delguids.add((String) map.get("guid"));
            }
            String delsql = perfDataSetDAO.createInSql("guid", delguids);
            perfDataSetDAO.delDatas(tablecode, delsql);
        }
    }
    /**
     * 初始化数据，将2016年，87分区的数据复制一份当前年度，当前区划的数据
     * @param params
     * @throws AppException
     */
    public Boolean initset(HashMap<String, Object> params) throws AppException {
        //全部数据
        return perfDataSetDAO.initset(params);
    }

    /**
     * 左侧树初始化
     * @param params
     * @return
     */
    public Boolean initleftset(HashMap<String, Object> params) throws AppException {
        //全部数据
        return perfDataSetDAO.initleftset(params);
    }
    /**
     * 保存.
     * @param params
     * @throws Exception
     */
    public void savemajorkey(Map<String, Object> params) throws Exception {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        String tablecode = (String) params.get("tablecode");
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        List<String> updatecols = (List) params.get("updatecols");
        if(updatecols == null){
            updatecols = new ArrayList<>();
        }
        List<String> delcols =  (List)params.get("delcols");
        if(delcols == null){
            delcols = new ArrayList<>();
        }
        if(year == null || year.isEmpty()){
            year = CommonUtil.getYear();
        }
        if(province == null || province.equals(province)){
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
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", province);
                map.put("year", year);
                map.put("status", 1);
                addlist.add(map);
            } else {
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                uplist.add(map);
            }
        }
        delcols.remove("guid");
        if (deldatas.size() > 0) { //先删后增
            List<String> delguids = new ArrayList<>();
            for (Map<String, Object> map : deldatas) {
                delguids.add((String) map.get("guid"));
            }
            StringBuffer delsql = new StringBuffer(perfDataSetDAO.createInSql("guid", delguids));
            Map<String,Object> map1 = (Map)(((List)deldatas).get(0));
            for (String str: delcols) {
                delsql.append(" and ").append(str).append("='").append(map1.get(str)).append("'");
            }
            perfDataSetDAO.delDatas(tablecode, delsql.toString());
        }
        if (addlist.size() > 0) {
            perfDataSetDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            perfDataSetDAO.updateAllByMajorPK(Fasp2DaoCacheUtil.getTableColumn(tablecode),uplist, "guid", tablecode,updatecols);
        }
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
            leftconfig.put("datas", perfDataSetDAO.getLeftTree(tablecode));
        }
        return leftconfig;
    }

    /**
     * 编辑区保存.
     * @param params
     * @throws Exception
     */
    public void editSave(HashMap<String, Object> params) throws Exception {
        //表名
        String tablecode = (String) params.get("tablecode");
        String guid = (String) params.get("guid");
        //全部数据
        Map<String, Object> infodata = (Map<String, Object>) params.get("infodata");
        String province = (String) params.get("province");
        String year = params.get("year") + "";
        StringBuffer wheresql = new StringBuffer(" guid ='").append(guid).append("'");
        if(!StringUtil.isEmpty(year) && !"null".equals(year)){
            wheresql.append(" and ").append("year='").append(year).append("'");
        }
        if(!StringUtil.isEmpty(province)){
            wheresql.append(" and ").append("province='").append(province).append("'");
        }
        Map<String, Object> dataMap = this.getDataMap(tablecode, wheresql.toString());
        dataMap.putAll(infodata);
        dataMap.put("appid", "pmkpi");
        List<String> cols = new ArrayList<>();
        cols.add("year");
        cols.add("province");
        List list = new ArrayList();
        list.add(dataMap);
        perfDataSetDAO.updateAllByMajorPK(Fasp2DaoCacheUtil.getTableColumn(tablecode), list, "guid", tablecode, cols);
        if ("PERF_T_WARNSET".equals(tablecode.toUpperCase())) {
            String code = (String) dataMap.get("type");
            String status = (String) dataMap.get("status");
            String warnsql = (String) dataMap.get("warnsql");
            String cacheKey = perfDataSetDAO.PMKPI_CACHE_WARN + code;
            if ("1".equals(status)) { //启用参数，更新缓存信息
                PerfUtil.reflashSynCacheData(cacheKey, StringUtil.isEmpty(warnsql) ? "unwarn" : warnsql, false);
            } else { //不启用缓存
                PerfUtil.reflashSynCacheData(cacheKey, "unwarn", false);
            }
        }
    }
}
