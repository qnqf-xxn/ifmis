package gov.mof.fasp2.pmkpi.rectification.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddProjDAO;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationQueryDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationQueryBO extends PmkpiBO {

    private RectificationQueryDAO rectificationQueryDAO;

    public void setRectificationQueryDAO(RectificationQueryDAO rectificationQueryDAO) {
        this.rectificationQueryDAO = rectificationQueryDAO;
    }

    /**
     * 根据左侧页签和数据反查左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getLeftTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = RectificationAddProjDAO.PERF_T_RECTIFY;
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        datarule += " and bustype='" + bustype + "' ";
        return rectificationQueryDAO.getLeftTree(tablecode,datarule);
    }
    /**
     * 根据id删除数据
     * @param config
     * @return
     * @throws AppException
     */
    public Map delByGuids(HashMap config) throws AppException {
        List<Map<String, Object>> guids = (List<Map<String, Object>>) config.get("list");
        if (guids != null && guids.size()>0) {
            try{
                rectificationQueryDAO.saveAll(guids, rectificationQueryDAO.PMKPI_TABLE_TMP_AGENCY);
                String delsql = " exists(select 1 from " + rectificationQueryDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
                rectificationQueryDAO.delDatas(RectificationAddProjDAO.PERF_T_RECTIFY, delsql);

            } catch (AppException e) {
                throw new AppException("数据删除失败！");
            }
        }else {
            config.clear();
            config.put("error", "删除报错，操作0行数据！");
        }
        return config;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid,"perf", null);
    }

    /**
     * 表格查询
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public String getVodSql(Map sqlmap) throws AppException {
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(rectificationQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        //页面类型
        String wheresql = (String) sqlmap.get("querySql");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String workflow = (String) sqlmap.get("workflow");
        String tabcode = (String) sqlmap.get("tabcode");
        String bustype = (String) sqlmap.get("bustype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String type = (String) sqlmap.get("type");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        //获取数据权限
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.province='").append(province).append("'");
        sql.append(" and t.year=").append(year);
        sql.append(" and t.bustype=").append(bustype);
        sql.append(" and ").append(datarule);
        //sql.append(" and t.wfstatus<>'011'");
        if (wheresql != null && !wheresql.isEmpty()){
            sql.append(" and ").append(wheresql);
        }
        //type会过滤掉其他类型
        /*if (type != null && !type.isEmpty()){
            sql.append(" and t.type ='").append(type).append("'");
        }*/
        if (tablesql != null && !tablesql.isEmpty()){
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            sql.append(" and ").append(tabfilter);
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, rectificationQueryDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }


    public List<Map<String,Object>> getDataByGuid(HashMap<String,Object> params) {
        String tablecode = (String) params.get("tablecode");
        String guid = (String) params.get("projguid");
        String pro_code = (String) params.get("procode");
        String bustype = (String) params.get("bustype");
        String rectype = (String) params.get("rectype");
        String taskguid = (String) params.get("taskguid");
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from ").append(tablecode);
        if (PerfUtil.getIsHbei() || "3".equals(bustype)){
            sql.append(" where proguid = '").append(guid).append("' ");
        }else{
            sql.append(" where pro_code = '").append(pro_code).append("' ");
        }
        if ("绩效监控".equals(rectype)){
            sql.append(" and taskguid ='").append(taskguid).append("'");
        }
        sql.append(" and rectype ='").append(rectype).append("' and wfstatus <> '011' order by createtime");
        List list = rectificationQueryDAO.queryForList(sql.toString());
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        List<Map<String,Object>> datas = new ArrayList<>();
        datas.add(map);
        return datas;
    }
}
