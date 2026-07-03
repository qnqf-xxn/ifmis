package gov.mof.fasp2.pmkpi.setting.modelcase;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.setting.casepage.report.CaseReportDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:46 2020/8/18  chongdayong
 */
public class ModelCaseBO extends PmkpiBO {
    private ModelCaseDAO modelCaseDAO;

    public void setModelCaseDAO(ModelCaseDAO modelCaseDAO) {
        this.modelCaseDAO = modelCaseDAO;
    }

    /**
     * 获取左侧树数据.
     * @return --
     */
    public Map<String, Object> getTreeData() throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("datas", modelCaseDAO.getLeftTree());
        return leftconfig;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        String tablecode = (String) parms.get("tablecode");
        String goaltablecode = CaseReportDAO.TABLECODE_T_CASEMODELGOAL;
        String indextablecode = CaseReportDAO.TABLECODE_T_CASEMODELINDEX;
        try {
            if (deldatas.size() > 0) {
                List<String> delguids = new ArrayList<>();
                for (Map<String, Object> map : deldatas) {
                    String guid = (String) map.get("guid");
                    delguids.add(guid);
                }
                modelCaseDAO.deleteAllByColumn("guid", delguids, tablecode);
                modelCaseDAO.deleteAllByColumn("mainguid", delguids, goaltablecode);
                modelCaseDAO.deleteAllByColumn("mainguid", delguids, indextablecode);
            }
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String)sqlmap.get("nodeguid"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        StringBuffer wsql = new StringBuffer();
        if(isleaf != null && "1".equals(isleaf)){
            wsql.append(" t.framesystem").append("='").append(nodeguid).append("' and ");
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
        if (orderby == null || orderby.isEmpty()){
            returnsql.append(" order by t.updatetime");
        }
        return returnsql.toString();
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map<String,Object> infosave(HashMap config) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String guid = (String) config.get("mainguid");
        String tablecode = (String) config.get("tablecode");
        String iswf = (String) config.get("iswf");
        String framesystem = (String) config.get("framesystem");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        if (null != guid && !"".equals(guid)) {
            Map map = null;
            List<Map> datas = modelCaseDAO.getByGuid(tablecode, guid, iswf);
            if (datas != null && datas.size() > 0) {//修改
                map = datas.get(0);
                map.putAll(infodata);
                map.put("updatetime", StringUtil.getSysDBDate());
                modelCaseDAO.update(map, tablecode);
            } else {//新增
                infodata.put("framesystem",framesystem);
                infodata.put("createtime", PerfUtil.getServerTimeStamp());
                infodata.put("updatetime", PerfUtil.getServerTimeStamp());
                infodata.put("creater", user.getGuid());
                infodata.put("province", user.getProvince());
                infodata.put("year", CommonUtil.getYear());
                //初始化有效状态
                infodata.put("status", "1");
                infodata.put("is_deleted", 2);
                this.getBasMap(infodata, "add");
                if(iswf != null && "true".equals(iswf)){ //只有主表编辑区才会新增工作流，其他
                    infodata.put("guid", guid);
                } else {
                    infodata.put("guid", getCreateguid());
                    infodata.put("mainguid", guid);
                }
                modelCaseDAO.save(infodata, tablecode);
            }
            backMap.put("success", true);
        }
        return  backMap;
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
     * 列表保存.
     * @param params --
     * @return --
     */
    public void tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //修改数据
//        List<Map<String, Object>> updatas = (List<Map<String, Object>>) params.get("updatas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        String framesystem = (String) params.get("framesystem");
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
                map.put("framesystem", framesystem);
                map.put("is_deleted", 2);
                addlist.add(map);
            } else {
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            modelCaseDAO.setIndexCode(addlist);
            modelCaseDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            modelCaseDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            List<String> delguids = new ArrayList<>();
            for (Map<String, Object> map : deldatas) {
                String guid = (String) map.get("guid");
                delguids.add(guid);
            }
            modelCaseDAO.deleteAllByColumn("guid", delguids, tablecode);
        }
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
        wheresql = " t.mainguid = '" + mainguid + "'";
        if (tablesql != null && !tablesql.isEmpty()) {
            wheresql += tablesql;
        }
        data = modelCaseDAO.getDatas(tablecode, wheresql, orderby);
        backMap.put("data", data);
        backMap.put("flg", "1");
        return backMap;
    }


    /**
     * 编辑查询
     * @param params
     * @return
     */
    public Map<String, Object> getDataByGuid(Map params) {
        String tablecode = (String) params.get("tablecode");
        String guid = (String) params.get("guid");
        String wheresql = " guid='" + guid + "'";
        return modelCaseDAO.getDatas(tablecode, wheresql, null).get(0);
    }
}
