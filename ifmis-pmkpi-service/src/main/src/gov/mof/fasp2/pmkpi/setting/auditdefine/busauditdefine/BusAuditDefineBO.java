package gov.mof.fasp2.pmkpi.setting.auditdefine.busauditdefine;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 9:24 2020/9/19  chongdayong
 */
public class BusAuditDefineBO extends PmkpiBO {
    private BusAuditDefineDAO busAuditDefineDAO;

    public void setBusAuditDefineDAO(BusAuditDefineDAO busAuditDefineDAO) {
        this.busAuditDefineDAO = busAuditDefineDAO;
    }

    /**
     * 获取菜单树数据.
     * @return --
     */
    public List<Map<String, Object>> getMenuTree() {
        return busAuditDefineDAO.getMenuTree();
    }

    /**
     * 获取工作流状态数据
     * @param params --
     * @return --
     */
    public List<Map<String, Object>> getWfStatusTree(HashMap<String, Object> params) {
        return busAuditDefineDAO.getWfStatusTree();
    }

    /**
     * 查询修改数据方法
     * @param guid
     * @return
     * @throws AppException
     */
    public Map<String, Object> getEditData(String guid) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String wheresql = " t.guid = '" + guid + "'";
        List<Map<String, Object>>  data = busAuditDefineDAO.getDatas("perf_t_auditdefinemenu", wheresql, "order by ordernum");
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String busguid = (String)params.get("busguid");
        String wheresql = " t.busguid = '" + busguid + "'";
        List<Map<String, Object>>  data = busAuditDefineDAO.getDatas("v_perf_t_busauditdefine", wheresql, "order by ordernum");
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public void save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = "v_perf_t_busauditdefine";
        String province =SecureUtil.getUserSelectProvince();
        Integer year = SecureUtil.getUserPartitionYear();
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            map.put("ordernum", i++);
            map.put("province",province);
            map.put("year",year);
            if (rowtype != null && "add".equals(rowtype)) {
//                map.put("createtime", StringUtil.getSysDBDate());
//                map.put("updatetime", StringUtil.getSysDBDate());
//                map.put("creater", SecureUtil.getCurrentUser().getGuid());
//                map.put("province", SecureUtil.getUserSelectProvince());
//                map.put("year", CommonUtil.getYear());
                addlist.add(map);
            } else {
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            busAuditDefineDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            busAuditDefineDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            busAuditDefineDAO.saveAll(deldatas, busAuditDefineDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + busAuditDefineDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            busAuditDefineDAO.delDatas(tablecode, delsql);
        }
    }

    /**
     *菜单信息保存 /修改
     * @param config --
     * @return
     * @throws AppException
     */
    public void infosave(HashMap config) throws AppException {
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        String guid = (String) infodata.get("guid");
        String tablecode = "perf_t_auditdefinemenu";
        infodata.put("updatetime", StringUtil.getSysDBDate());
        infodata.put("agencyguid", SecureUtil.getCurrentUser().getAgency());
        infodata.put("status", "1");
        int i = this.getDataCount(tablecode, "guid='" + guid + "'");
        if (i > 0) {//修改
            infodata.put("updatetime", StringUtil.getSysDBDate());
            busAuditDefineDAO.update(infodata, tablecode);
        } else {//新增
            infodata.put("createtime", StringUtil.getSysDBDate());
            infodata.put("creater", SecureUtil.getCurrentUserID());
            infodata.put("province", SecureUtil.getUserSelectProvince());
            infodata.put("year", SecureUtil.getUserSelectYear());
            busAuditDefineDAO.save(infodata, tablecode);
        }
    }

    /**
     * 删除扩展菜单.
     * @param parms --
     */
    public Map<String, Object> delMenu(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String menuid = (String) parms.get("menuid");
        try {
            busAuditDefineDAO.delMenuByGuid(menuid);
            backMap.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 查询左侧扩展树
     * @param menuid --菜单id
     * @return
     */
    public Map<String, Object> getBudMenuByGuid(String menuid) {
        List<Map<String, Object>> list = busAuditDefineDAO.getDatas("perf_t_auditdefinemenu", "guid='" + menuid + "'", null);
        if (list != null && list.size()>0) {
            return list.get(0);
        }
        return null;
    }
}
