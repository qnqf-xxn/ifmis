package gov.mof.fasp2.pmkpi.evaluation.dept.relation;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProRelationBO extends PmkpiBO {
    protected static Logger logger = Logger.getLogger(ProRelationBO.class);

    private ProRelationDAO proRelationDAO;

    public void setProRelationDAO(ProRelationDAO proRelationDAO) {
        this.proRelationDAO = proRelationDAO;
    }


    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String type = (String) sqlmap.get("type");   //查询区
        String querySql = (String) sqlmap.get("querySql");   //查询区
        String mainguid = (String) sqlmap.get("mainguid");
        String tablecode = (String) sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql");
        String defquery = (String) sqlmap.get("defquery");   //uitable.defquery
        String treeid = (String) sqlmap.get("treeid"); //单位id
        String isleaf = sqlmap.get("isleaf") + ""; //是否末级
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        StringBuffer sql = new StringBuffer("select t.* from ");
        sql.append(tablecode).append(" t where 1 = 1 ");
        if (!StringUtils.isEmpty(type) && "check".equals(type)) { //选择项目
            String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
            if (!StringUtils.isEmpty(defquery)) {
                sql.append(" and ").append(defquery);
            }
            if (!StringUtil.isEmpty(querySql)) {
                sql.append(" and ").append(querySql);
            }
            sql.append(this.getLeftTreeWheresql(isleaf, "agencyguid", treeid, proRelationDAO.PMKPI_TABLE_T_AGENCY));
            sql.append(datarule);
        } else { // 关联项目
            if (!StringUtils.isEmpty(mainguid)) {
                sql.append(" and t.mainguid = '").append(mainguid).append("' ");
            }
            if (!StringUtil.isEmpty(querySql)) {
                sql.append(" and ").append(querySql);
            }
            if (tablesql != null && !StringUtils.isEmpty(tablesql)) {
                sql.append(" and ").append(tablesql);
            }
        }
        return sql.toString();
    }


    public Map<String, Object> del(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) parms.get("datas");
        try {
            for (Map map : datas) {
                map.put("is_deleted", 1);
            }
            List<String> columns = new ArrayList<>();
            columns.add("guid");
            columns.add("is_deleted");
            proRelationDAO.updateAllByPK(columns, datas, "guid", proRelationDAO.PERF_TABLE_DEPTEVARELATION);
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }


    public Map<String, Object> saveProRelation(HashMap<String, Object> params) throws AppException {
        Map remap = new HashMap();
        String mainguid = (String) params.get("mainguid");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        for (Map<String, Object> map : datas) {
            map.put("guid", this.getCreateguid());
            map.put("mainguid", mainguid);
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("create_time", StringUtil.getSysDBDate());
            map.put("update_time", StringUtil.getSysDBDate());
            map.put("is_deleted", 2);
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
        }
        proRelationDAO.saveAll(datas, proRelationDAO.PERF_TABLE_DEPTEVARELATION);
        return remap;
    }


    public Map<String, Object> getTreeData(String leftmenuid) throws AppException {
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        List<Map<String, Object>> leftTree = proRelationDAO.getLeftTree(proRelationDAO.PMKPI_TABLE_PROJECT_INFO, datarule);
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("name", "单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", leftTree);
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        return leftconfig;
    }


}
