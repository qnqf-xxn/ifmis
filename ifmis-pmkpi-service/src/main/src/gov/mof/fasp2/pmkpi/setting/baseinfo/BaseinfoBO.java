package gov.mof.fasp2.pmkpi.setting.baseinfo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BaseinfoBO extends PmkpiBO {

    private BaseinfoDAO baseinfoDAO;

    public void setBaseinfoDAO(BaseinfoDAO baseinfoDAO) {
        this.baseinfoDAO = baseinfoDAO;
    }

    /**
     * 获取左侧树数据.
     *
     * @return --
     */
    public Map<String, Object> getTreeData(String leftflag) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 2);
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> signs = dss.getRangesByWhereSql(leftflag, "");
        leftconfig.put("datas", signs);
        return leftconfig;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String querySql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String) sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String) sqlmap.get("nodeguid"); //节点id.
        String tablecode = (String) sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String querycol = (String) sqlmap.get("querycol");
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        StringBuffer wheresql = new StringBuffer();
        if ("1".equals(isleaf)) {
            wheresql.append(" t.").append(querycol).append("='").append(nodeguid).append("' and ");
        }
        if (!StringUtil.isEmpty(querySql)) {
            wheresql.append("(").append(querySql).append(") and ");
        }
        if (!StringUtil.isEmpty(tablesql)) {
            wheresql.append(tablesql).append(" and ");
        }
        if (!StringUtil.isEmpty(wheresql.toString())) {
            returnsql.append(" where ").append(wheresql.delete(wheresql.length() - 4, wheresql.length()));
        }
        if (StringUtil.isEmpty(orderby)) {
            returnsql.append(" order by t.updatetime");
        }
        return returnsql.toString();
    }

    /**
     * 删除
     *
     * @param parms --
     * @return
     */
    public Map<String, Object> delDatas(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = (String) parms.get("tablecode");
        try {
            baseinfoDAO.saveAll(deldatas, baseinfoDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + baseinfoDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            baseinfoDAO.delDatas(tablecode, delsql);
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 编辑区保存数据.
     *
     * @param params --
     * @return --
     */
    public void saveDatas(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String viewtype = (String) params.get("viewtype");
        String isSX = PerfUtil.getSystemSet("isSX");
        Map<String, Object> data = new HashMap<String, Object>();
        data = (Map<String, Object>) params.get("data");
        if (data == null || data.isEmpty()) {
            data = (Map<String, Object>) params.get("infodata");
        }
        data.put("updatetime", PerfUtil.getServerTimeStamp());
        String guid = (String) params.get("guid");
        String mainguid = (String) params.get("mainguid");
        String guids = (String) data.get("guid");
        List<Map> datas = new ArrayList<>();
        if(viewtype != null && "add".equals(viewtype)){
            //guid为页面选择的人员guid
            if (tablecode != null && !"V_PERF_EXPERTINIFO".equals(tablecode)) {
                data.put("guid", guid);
            }
            if(guids == null || guids.isEmpty()){
                data.put("guid", guid);
            }
        }else{
            if (tablecode == null || "V_PERF_EXPERTINIFO".equals(tablecode)) {
                if(guids == null || guids.isEmpty()){
                    data.put("guid", guid);
                }
            }
        }
        guid = (String) data.get("guid");
        //山西模式新增时调用公用保存方法，没有传递viewtype参数，guid会为空，导致保存报错
        if ((guid == null || guid.isEmpty()) && "1".equals(isSX)){
            guid = (String) params.get("guid");
            data.put("guid", guid);
        }
        datas = baseinfoDAO.getByGuid(tablecode, guid);
        if(null == datas || datas.size() == 0){
            if(!StringUtil.isEmpty(mainguid)){
                data.put("mainguid",mainguid);
            }
            data.put("status", 1);
            data.put("createtime", PerfUtil.getServerTimeStamp());
            data.put("creater", SecureUtil.getCurrentUserID());
            data.put("province", SecureUtil.getUserSelectProvince());
            data.put("year", CommonUtil.getYear());
            baseinfoDAO.save(data, tablecode);
        }else{
            if (tablecode != null && !"V_PERF_EXPERTINIFO".equals(tablecode)) {
                baseinfoDAO.update(data.keySet(), data, tablecode);
            } else {
                //删除原有数据
                baseinfoDAO.delDatas(tablecode, " guid='" + guid + "'");
                //重新新增专家数据
                data.put("province", SecureUtil.getUserSelectProvince());
                data.put("year", CommonUtil.getYear());
                baseinfoDAO.save(data, tablecode);
            }
        }

 /*       if ((null == datas || datas.size() == 0) || (viewtype != null && "add".equals(viewtype))) {
            //guid为页面选择的人员guid
            if (tablecode != null && !"V_PERF_EXPERTINIFO".equals(tablecode)) {
                data.put("guid", guid);
            }
            if(guids == null || guids.isEmpty()){
                data.put("guid", guid);
            }
            data.put("status", 1);
            data.put("createtime", PerfUtil.getServerTimeStamp());
            data.put("creater", SecureUtil.getCurrentUserID());
            baseinfoDAO.save(data, tablecode);
        } else {
            if (tablecode != null && !"V_PERF_EXPERTINIFO".equals(tablecode)) {
                baseinfoDAO.update(data, tablecode);
            } else {
                if(guids == null || guids.isEmpty()){
                    data.put("guid", guid);
                }
                //删除原有数据
                baseinfoDAO.delDatas(tablecode, " guid='" + guid + "'");
                //重新新增专家数据
                baseinfoDAO.save(data, tablecode);
            }
        }*/
    }

    /**
     * 根据guid查询编辑区数据
     *
     * @param tablecode 表名
     * @param guid      guid
     * @return
     */
    public Map<String, Object> getDatasByGuid(String tablecode, String guid) {
        String wheresql = " guid='" + guid + "'";
        List list = baseinfoDAO.getDatas(tablecode, wheresql, null);
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        return map;
    }

    /**
     * 编辑区查询.
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");//
        String iswf = (String) params.get("iswf");
        Map<String, Object> map = this.getByGuid(tablecode, mainguid, iswf);
        backMap.put("editdata", map);
        backMap.put("flg", "1");
        return backMap;
    }

    /**
     * 列表查询.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String orderby = (String) params.get("orderby");
        String wheresql = "";
        List<Map<String, Object>> data = null;
        String mainguid = (String)params.get("mainguid");
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String)params.get("tablesql");
        String defquery = (String)params.get("defquery");
        wheresql = " t.mainguid = '" + mainguid + "'";
        if (tablesql != null && !tablesql.isEmpty()) {
            wheresql += tablesql;
        }
        if (defquery != null && !defquery.isEmpty()) {
            wheresql += defquery;
        }
        data = baseinfoDAO.getDatas(tablecode, wheresql, orderby);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public void tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        String mainguid = (String) params.get("mainguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //修改数据
//        List<Map<String, Object>> updatas = (List<Map<String, Object>>) params.get("updatas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            map.put("ordernum", i++);
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("guid", this.getCreateguid());
                map.put("status", "1");
                map.put("mainguid", mainguid);
                addlist.add(map);
            } else {
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            baseinfoDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            baseinfoDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            baseinfoDAO.saveAll(deldatas, baseinfoDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + baseinfoDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            baseinfoDAO.delDatas(tablecode, delsql);
            delsql = " exists(select 1 from " + baseinfoDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid)";
            baseinfoDAO.delDatas(tablecode, delsql);
        }
    }


    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        String type = (String) params.get("type");
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("agency");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("guid",this.getCreateguid());
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("agencyguid", saveAgency);
                map.put("mainguid", mainguid);
                map.put("type", type);
                addlist.add(map);
            } else {
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            baseinfoDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            baseinfoDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            baseinfoDAO.saveAll(deldatas, baseinfoDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + baseinfoDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            baseinfoDAO.delDatas(tablecode, delsql);
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }
}
