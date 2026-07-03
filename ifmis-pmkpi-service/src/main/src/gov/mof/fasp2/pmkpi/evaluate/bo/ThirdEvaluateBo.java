package gov.mof.fasp2.pmkpi.evaluate.bo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.evaluate.dao.ThirdEvaluateDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ThirdEvaluateBo extends PmkpiBO {

    private ThirdEvaluateDAO thirdEvaluateDAO;

    public void setThirdEvaluateDAO(ThirdEvaluateDAO thirdEvaluateDAO) {
        this.thirdEvaluateDAO = thirdEvaluateDAO;
    }


    private final PmkpiDAO pmkpiDAO = (PmkpiDAO) ServiceFactory
            .getBean("pmkpi.common.PmkpiDAO");

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        //String menuid = (String)sqlmap.get("menuid");
        String tablecode = (String)sqlmap.get("tablecode");
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        //String nodecode = (String) sqlmap.get("nodecode"); //树节点
        //String nodetable = (String) sqlmap.get("nodetable"); //树节点表名
        //String nodeguid = (String) sqlmap.get("nodeguid"); //树节点id
        //String reviewtype = (String) sqlmap.get("reviewtype"); //评审类型
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String columncode = "agencyguid";
        String elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        StringBuffer returnsql = new StringBuffer("select t.*,a.audittypename from ");
        returnsql.append(tablecode).append(" t left join (select b.*,c.name audittypename from v_perf_t_evaluateaudit b left join v_perf_enum c on c.elementcode='AUDITTYPE' and c.guid=b.audittype)a on a.proguid=t.proguid");
        returnsql.append(" where type = 'assessment' ");
        String datarule = this.getDataRuleByMenuguid(lefttabtype+thirdEvaluateDAO.PERF_STRING_HIDEMENU, "t", null); //数据权限
        datarule = datarule.replace("t.agencyguid","t.guid");
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        if (!"1".equals(isleaf) && !"treeroot".equals(saveAgency)) {
            datarule += " start with superguid='" + saveAgency + "' connect by prior guid = superguid";
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            List list = new ArrayList();
            Map map = new HashMap();
            map.put("guid",saveAgency);
            list.add(map);
            eledatas.addAll(list);
            thirdEvaluateDAO.saveAll(eledatas, thirdEvaluateDAO.PMKPI_TABLE_TMP_AGENCY);
        } else {
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            thirdEvaluateDAO.saveAll(eledatas, thirdEvaluateDAO.PMKPI_TABLE_TMP_AGENCY);
        }

        if (!StringUtils.isEmpty(wheresql)){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtils.isEmpty(tablesql)){
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtils.isEmpty(tabfilter)){
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (!StringUtils.isEmpty(wfsql)) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        if ("1".equals(isleaf)) {
            returnsql.append(" and t.agencyguid='").append(saveAgency).append("'");
        } else {
            returnsql.append(" and exists(select 1 from ").append(thirdEvaluateDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.").append(columncode).append(")");
        }
        return returnsql.toString();
    }

    /**
     * 查询左侧树。
     * @param menuId -- 菜单.
     * @return
     * @throws AppException
     */
    public Map getLeftTree(String menuId) throws Exception {
        Map leftconfig = new HashMap();
        List<String> types = new ArrayList<String>();
        types.add("program");
        types.add("dept");
        Object[] tabs = new Object[types.size()];
        String tablecode = "";
        for (int i = 0; i < types.size(); i++) {
            String type = types.get(i);
            leftconfig = new HashMap();
            String datarule = this.getDataRuleByMenuguid(type + thirdEvaluateDAO.PERF_STRING_HIDEMENU, "t", "1=1");
            if ("program".equals(type)) {
                tablecode = thirdEvaluateDAO.PMKPI_TABLE_PROJECT_INFO;
            } else if ("dept".equals(type)) {
                tablecode = thirdEvaluateDAO.PMKPI_TABLE_DEPTPERFDECLARE;
            }
            //根据权限查询单位
            List<Map<String, Object>> list = thirdEvaluateDAO.getLeftTree(tablecode, datarule);
            if (list != null && list.size() == 0) {
                Map<String, Object> map = new HashMap<>();
                map.put("guid","treeroot");
                map.put("code","00");
                map.put("name","");
                map.put("superid","0");
                map.put("levelno","1");
                map.put("isleaf","0");
                list.add(map);
                leftconfig.put("datas", list);
            } else {
                if ("program".equals(type)){
                    leftconfig.put("datas", list);
                } else if ("dept".equals(type)) {
                    leftconfig.put("datas", list);
                }
            }
            leftconfig.put("showRootNode", Boolean.TRUE);
            leftconfig.put("dosearch", Boolean.FALSE);
            leftconfig.put("outformart", "#code-#name");
            leftconfig.put("expandlevel", 2);
            Map f1 = new HashMap();
            if ("program".equals(type)){
                leftconfig.put("name", "项目支出");
                f1.put("name", "项目支出");
            } else if ("dept".equals(type)){
                leftconfig.put("name", "部门整体");
                f1.put("name", "部门整体");
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
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        //审核定义
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, ThirdEvaluateDAO.PERF_REVIEW_SOURCE, datas);
        for (Map<String, Object> item : datas) {
            String itemguid = (String) item.get("guid");
            thirdEvaluateDAO.update("delete from PERF_REVIEWINTERMEDIARY where review = '"+itemguid+"' ");
        }
        return this.auditdefine(datas, busguid, "perf", null);
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        //String menuId = (String) params.get("menuid");
        String tablecode = (String) params.get("tablecode");
        String lefttabtype = (String) params.get("lefttabtype");
        String datarule = this.getDataRuleByMenuguid(lefttabtype + thirdEvaluateDAO.PERF_STRING_HIDEMENU, "t", "1=1");
        //根据权限查询单位
        datarule += " and type = 'assessment' ";
        return thirdEvaluateDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 是否确认第三方机构评审
     * @param params
     * @return
     */
    public Map<String, Object> isConfirm(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String type = (String) params.get("type");
        List<Map<String, Object>> list = new ArrayList<>();
        Map<String, Object> m = null;
        for (Map<String, Object> map : datas) {
            m = new HashMap<>();
            String proguid = (String) map.get("proguid");
            m.put("guid", proguid);
            list.add(m);
        }
        thirdEvaluateDAO.saveAll(list, thirdEvaluateDAO.PMKPI_TABLE_TMP_GUIDS);
        if (type != null && "confirm".equals(type)) {
            thirdEvaluateDAO.evaluateOpention(type);
        } else if (type != null && "unconfirm".equals(type)) {
            thirdEvaluateDAO.evaluateOpention(type);
        } else if (type != null && "back".equals(type)) {
            thirdEvaluateDAO.evaluateOpention(type);
            String delsql = " exists (select 1 from " + thirdEvaluateDAO.PMKPI_TABLE_TMP_GUIDS + " a where t.proguid=a.guid) and type = 'assessment'";
            thirdEvaluateDAO.delDatas("perf_t_review", delsql);
        }
        String isProview = PerfUtil.getSystemSet("isProview");
        if (isProview != null && "1".equals(isProview)) {
            List<Map<String,Object>> l = new ArrayList<>();
            Map<String,Object> proMap = null;
            for (Map<String, Object> map : datas) {
                proMap = new HashMap<>();
                String proguid = (String) map.get("proguid");
                proMap.put("guid", proguid);
                l.add(proMap);
            }
            thirdEvaluateDAO.saveAll(l,thirdEvaluateDAO.PMKPI_TABLE_TMP_GUIDS);
            thirdEvaluateDAO.updateProOpenion("v_pm_project_info");
        }
        backMap.put("success", true);
        return backMap;
    }

}
