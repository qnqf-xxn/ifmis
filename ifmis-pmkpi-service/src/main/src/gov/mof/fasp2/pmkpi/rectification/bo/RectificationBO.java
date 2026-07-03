package gov.mof.fasp2.pmkpi.rectification.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddProjDAO;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationDAO;
import org.apache.commons.lang.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationBO  extends PmkpiBO {

    private RectificationDAO rectificationDAO;

    public void setRectificationDAO(RectificationDAO rectificationDAO) {
        this.rectificationDAO = rectificationDAO;
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
        return rectificationDAO.getLeftTree(tablecode,datarule);
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
                rectificationDAO.saveAll(guids, rectificationDAO.PMKPI_TABLE_TMP_AGENCY);
                String delsql = " exists(select 1 from " + rectificationDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
                rectificationDAO.delDatas(RectificationAddProjDAO.PERF_T_RECTIFY, delsql);

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
        //根据数据的业务阶段选择对应的工作流    绩效监控、绩效自评、部门评价、财政评价
        if (workflow.length() > 32) {
            String rectype = (String) datas.get(0).get("rectype");
            workflow = workflow.substring(1, workflow.length() - 1);  //去掉字符串首尾的大括号{}
            String[] str = workflow.split(",");
            for (String wfid : str) {
                String[] entry = wfid.split(":");
                entry[1] = StringUtils.substringBetween(entry[1], "'", "'"); //去掉字符串首尾的单引号''
                if (rectype != null && entry[0].trim().equals(rectype)) {
                    workflow = entry[1];
                    break;
                }
            }
        }
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
            createTmpTable(rectificationDAO.PMKPI_TABLE_TMP_AGENCY);
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
            sql.append(" and (").append(wheresql).append(")");
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

        String wfsql = " ";
        String[] str = null;
        if (workflow != null && !workflow.isEmpty()) {
            workflow = workflow.substring(1, workflow.length() - 1);  //去掉字符串首尾的大括号{}
            str = workflow.split(",");
            for (int i = 0; i < str.length; i++) {
                int index = str[i].indexOf("'");
                str[i] = str[i].substring(index + 1, str[i].length() - 1);
                wfsql += this.getWfSql(tabcode, str[i]);
                if (i < str.length - 1) {
                    wfsql += " or ";
                }
            }
            if (wfsql != null && !wfsql.isEmpty()) {
                sql.append("  and (").append(wfsql).append(")");
            }
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, rectificationDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    public Map<String, Object> getRectificationByProcode(String pro_code, String queryYear, String queryProvince)  throws AppException {
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            rectificationDAO.setYearAndProvince(queryYear, queryProvince);
        }
        //通过项目code查询自评价、财政评价整改主数据-获取最新终审时间数据
        String wheresql = " exists(select 1 from (select a.rectype,max(a.lastupdatetime) as lastupdatetime from " + RectificationAddProjDAO.PERF_T_RECTIFY + " a where a.rectype in('rectifyperfself','rectifyfinancialeval') and a.pro_code=? group by a.rectype) b where t.rectype=b.rectype and t.lastupdatetime=b.lastupdatetime and t.pro_code=?)";
        List<Map<String, Object>> list = rectificationDAO.getDatas(RectificationAddProjDAO.PERF_T_RECTIFY, wheresql, null, new String[]{pro_code, pro_code});
        Map<String, Object> backMap = new HashMap<>();
        backMap.put("list", list);
        return backMap;
    }

}