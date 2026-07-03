package gov.mof.fasp2.pmkpi.performanceopen.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zhangxutao
 * @version 1.0
 * @description: TODO
 * @date 2023/4/18 10:29
 */
public class PerfOpenBO extends PmkpiBO {

    private PerfOpenDAO perfOpenDAO;
    /**
     * 注入dao.
     * @param perfOpenDAO --dao.
     * @throws
     */
    public void setPerfOpenDAO(PerfOpenDAO perfOpenDAO) {
        this.perfOpenDAO = perfOpenDAO;
    }

    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String tablecode = (String) sqlmap.get("tablecode");
        String opencode = (String) sqlmap.get("opencode");
        String agencode = (String) sqlmap.get("agencode");
        String agenisleaf = sqlmap.get("agenisleaf") + ""; //节点是否为末级
        String sql = "";
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1"); //数据权限
        StringBuffer returnsql = new StringBuffer("select * from ");
        if ("waitaudit".equals(tabcode)) {
            tablecode = perfOpenDAO.PERF_VIEW_MANCEOPEN;
        }
        returnsql.append(tablecode).append(" t where ");
        returnsql.append(datarule);
        if (sql != null && !sql.isEmpty()) {
            returnsql.append(" and ").append(sql);
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and (").append(wheresql).append(") ");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (wfsql != null && !wfsql.isEmpty()) {
            if(wfsql.contains("WFSTATUS = '000'") && "waitaudit".equals(tabcode)){ // 如果有保存的权限，默认查全部
                returnsql.append(" and ( wfid is null or ").append(wfsql).append(") ");
            } else {
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        }
        if (opencode != null && !opencode.isEmpty() && !"treeroot".equals(opencode)) {
            returnsql.append(" and t.bustype = '").append(opencode).append("'");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(agenisleaf, columncode, agencode, perfOpenDAO.PMKPI_TABLE_T_AGENCY));
        if (orderby == null || orderby.isEmpty()) {
            returnsql.append(" order by t.updatetime");
        }
        return returnsql.toString();
    }

    /**
     * 获取左侧树数据.
     * @param menuId -- 菜单.
     * @return --
     */
    @SuppressWarnings({"unchecked"})
    public Map<String, Object> getTraceLeftTree(String menuId) throws AppException {
        Map leftconfig = null;
        List<String> types = new ArrayList<String>();
        types.add("perfopen");
        types.add("perfagen");
        Object[] tabs = new Object[types.size()];
        for (int i = 0; i < types.size(); i++) {
            String type = types.get(i);
            leftconfig = new HashMap();
            List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
            if ("perfopen".equals(type)){
                data = perfOpenDAO.getDatas("v_perf_t_datasource", "elementcode='perfopen'", "order by ordernum");
            } else if ("perfagen".equals(type)) {
                String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
                data = perfOpenDAO.getLeftTree(PmkpiDAO.PMKPI_TABLE_T_AGENCY, datarule);
            }
            leftconfig.put("datas", data);
            leftconfig.put("showRootNode", Boolean.TRUE);
            leftconfig.put("dosearch", Boolean.FALSE);
            leftconfig.put("outformart", "#code-#name");
            leftconfig.put("expandlevel", 2);
            Map f1 = new HashMap();

            if ("perfopen".equals(type)){
                leftconfig.put("name", "公开类型");
                f1.put("name", "公开类型");
            } else if ("perfagen".equals(type)){
                leftconfig.put("name", "预算单位");
                f1.put("name", "预算单位");
            }
            f1.put("ordernum", i);
            f1.put("code", type);
            f1.put("click", "tabChange");
            f1.put("treeinfo", leftconfig);
            tabs[i] = f1;
        }
        Map m = new HashMap();
        m.put("onlydata", Boolean.TRUE);
        m.put("activeTab", 0);
        m.put("dosearch", Boolean.TRUE);
        m.put("tabs", tabs);
        return m;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String tablecode = perfOpenDAO.PERF_TABLE_MANCEOPEN;
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        //审核定义
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, "perf", null);
    }

    public Map save(HashMap config) throws AppException{
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("data");
        String tablecode = perfOpenDAO.PERF_TABLE_MANCEOPEN;
        String workflow = (String) config.get("workflow");
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        Map<String, Object> mancMap = new HashMap<>();
        List<String> proList = new ArrayList<>();
        for (Map<String, Object> map : datas) {
            proList.add((String) map.get("pro_code"));
        }
        String wheresql = perfOpenDAO.createInSql("pro_code", proList);
        List<Map<String, Object>> list = perfOpenDAO.getDatas(tablecode, wheresql, null);
        for (Map<String, Object> map : list) {
            mancMap.put(map.get("pro_code") + "-" + map.get("bustype") + "-" + map.get("xmly"), map);
        }
        for (Map<String, Object> map : datas) {
            String pro_code = (String) map.get("pro_code");
            String bustype = (String) map.get("bustype");
            String key = pro_code + "-" + bustype + "-" + map.get("xmly");
            map.put("updatetime", StringUtil.getSysDBDate());
            if (mancMap.keySet().contains(key)) {
                Map data = (Map) mancMap.get(key);
                data.putAll(map);
                uplist.add(data);
            } else {
                map.put("guid", StringUtil.createUUID());
                map.put("mainguid", map.get("projguid"));
                map.put("pro_code", pro_code);
                map.put("agencyguid", map.get("agency_code"));
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("wfid", workflow);
                map.put("is_deleted", "2");
                addlist.add(map);
            }
        }
        if(uplist.size() > 0){
            IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
            List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode(tablecode);
            List diccolumn = new ArrayList<String>();
            String curcolumn = "";
            for (DicColumnDTO dicColumnDTO : dicColumnDTOs) {
                curcolumn = (String) dicColumnDTO.get("dbcolumncode");
                if ("PROVINCE".equals(curcolumn) || "YEAR".equals(curcolumn) || "PROSELECT".equals(curcolumn)) {
                    continue;
                }
                diccolumn.add(curcolumn.toLowerCase());
            }
            perfOpenDAO.updateAllByPK(diccolumn, uplist,"guid",tablecode);
        }
        if(addlist.size() > 0){
            this.workflow("create", workflow, "", tablecode, addlist);
        }
        return this.auditdefine(datas, workflow,"perf", null);
    }

    /**
     * 更新数据到中间表
     */
    public void updateManceOpens(){
        String sql = "";
        perfOpenDAO.delDatas("perf_t_manceopentemp", null);
        sql = "insert into perf_t_manceopentemp select * from v_perf_manceopen_temp";
        perfOpenDAO.execute(sql);
    }
}
