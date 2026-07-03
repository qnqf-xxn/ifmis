package gov.mof.fasp2.pmkpi.hbtracereport.upload;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busdic.table.appexception.DicTableAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HbtracereportBO extends PmkpiBO {
    private HbtracereportDAO hbtracereportDAO;

    public void setHbtracereportDAO(HbtracereportDAO hbtracereportDAO) {
        this.hbtracereportDAO = hbtracereportDAO;
    }

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        /*String treesource = PerfUtil.getSystemSet("dept_letftree");
        if (treesource != null && !StringUtils.isEmpty(treesource)){
            leftconfig.put("datas", this.getLeftTree(menuId, treesource));
        }*/
        leftconfig.put("datas", this.getLeftTree(menuId, "PMKPIDEPT"));
        return leftconfig;
    }

    /**
     *  列表的查询方法.
     * @param sqlmap
     * @return
     * @throws AppException
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String agency = (String)sqlmap.get("agency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            //数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "PMKPIAGENCYALLPAY");
            //String sql = "";
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            hbtracereportDAO.saveAll(eledatas, hbtracereportDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid,"PMKPIDEPT");
            hbtracereportDAO.saveAll(treeData, hbtracereportDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" where 1=1");
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            returnsql.append(" and t.agencyguid='").append(agency).append("'");
        } else if ("0".equals(isleaf)) {
            returnsql.append(" and exists(select * from ").append(hbtracereportDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (orderby == null || orderby.isEmpty()) {
            returnsql.append(" order by t.updatetime");
        }
        return returnsql.toString();
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> delDatas(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = (String) parms.get("tablecode");
        try {
            hbtracereportDAO.saveAll(deldatas, hbtracereportDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + hbtracereportDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            hbtracereportDAO.delDatas(tablecode, delsql);
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 编辑区查询
     *
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("agency");
        String tablecode = (String) params.get("tablecode");
        Map<String, Object> map = this.getDataByGuid(tablecode, mainguid);
        if (map.isEmpty()) {
            List<Map<String, Object>> agencyList = this.getAgencyData(saveAgency);
            if (null != agencyList && agencyList.size() != 0) {
                String name = (String) agencyList.get(0).get("name");
                String code = (String) agencyList.get(0).get("code");
                map.put("name", name);
                map.put("code", code);
            }
            map.put("guid", mainguid);
        }
        backMap.put("editdata", map);
        return backMap;
    }
    /**
     * 根据guid查询数据
     *
     * @param guid
     * @return
     * @throws AppException
     * @throws DicTableAppException
     */
    public Map getDataByGuid(String tablecode, String guid){
        List list = hbtracereportDAO.getDataByGuid(tablecode, guid);
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        return map;
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map infosave(HashMap config) throws AppException {
//        Map<String, Object> backMap = new HashMap<String, Object>();
        String guid = (String) config.get("mainguid");
        String tablecode = (String) config.get("tablecode");
        String saveAgency = (String) config.get("saveAgency");
        String busguid = (String) config.get("busguid");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        //根据部门或单位查询处室id
        String finintorgguid = getFinintorgguid(saveAgency);
        if (guid != null && !guid.isEmpty()) {
            Map map = null;
            List<Map> datas = hbtracereportDAO.getByGuid(tablecode, guid);
            if (datas != null && datas.size() > 0) {//修改
                map = datas.get(0);
                map.putAll(infodata);
                infodata.put("updatetime", StringUtil.getSysDBDate());
                List<String> cols = new ArrayList<String>(infodata.keySet());
                //throw new AppException("每个部门每个监控阶段只允许新增一条数据！");
                hbtracereportDAO.update(cols, infodata, tablecode); //修改字段
            } else {//新增
                infodata.put("createtime", PerfUtil.getServerTimeStamp());
                infodata.put("updatetime", PerfUtil.getServerTimeStamp());
                infodata.put("creater", user.getGuid());
                infodata.put("province", "");
                infodata.put("year", "");
                infodata.put("agencyguid", saveAgency);
                infodata.put("finintorgguid", finintorgguid);
                //初始化有效状态
                infodata.put("status", "1");
                this.getBasMap(infodata, "add");
                hbtracereportDAO.save(infodata, tablecode);
            }
        }
        return this.auditdefine(l, busguid, "perf", null);
    }

    /**
     * 根据部门或单位获取处室id
     * @param agency
     * @return
     */
    private String getFinintorgguid(String agency) {
        String wheresql = "";
        List<Map<String, Object>> data = null;
        wheresql = " t.guid = '" + agency + "'";
        data = hbtracereportDAO.getDatas(PmkpiDAO.PMKPI_TABLE_T_AGENCY, wheresql,"order by code");
        String finintorgguid =null;
        if (data!=null && data.size()!=0){
            finintorgguid = (String) data.get(0).get("finintorg");
        }
        return finintorgguid;
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map issave(HashMap config) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String taskguid = (String) config.get("taskguid");
        String tablecode = (String) config.get("tablecode");
        String saveAgency = (String) config.get("saveAgency");
        String sql = " t.agencyguid = '"+saveAgency+"' and t.taskguid='"+taskguid+"'";
        List<Map<String, Object>> list = hbtracereportDAO.getDatas(tablecode, sql, null);
        if(list.size()>0){
            backMap.put("success",false);
        }else {
            backMap.put("success",true);
        }
        return backMap;
    }
}
