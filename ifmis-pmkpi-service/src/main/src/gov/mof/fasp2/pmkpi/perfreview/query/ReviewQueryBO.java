package gov.mof.fasp2.pmkpi.perfreview.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReviewQueryBO extends PmkpiBO {

    private ReviewQueryDAO reviewQueryDAO;

    public void setReviewQueryDAO(ReviewQueryDAO reviewQueryDAO) {
        this.reviewQueryDAO = reviewQueryDAO;
    }

    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        List<String> dics = new ArrayList<String>();
        dics.add("PMKPIAGENCYPROGRAM");
        dics.add("PMKPIAGENCYEDIT");
        Object[] tabs = new Object[dics.size()];
        for (int i = 0; i < dics.size(); i++) {
            //List<DicRangeDTO> value = null;
            String elementcode = dics.get(i);
            leftconfig = new HashMap();
            if ("PMKPIAGENCYPROGRAM".equals(elementcode)) {
                String datarule = this.getDataRuleByMenuguid(menuId, "t", "1=1");
                //根据权限查询单位
                List<Map<String, Object>> list = reviewQueryDAO.getTreeList(datarule, reviewQueryDAO.PMKPI_TABLE_ALLPROJECT_INFO);
                reviewQueryDAO.saveAll(list, reviewQueryDAO.PMKPI_TABLE_TMP_AGENCY);
                //查询单位上级，合成左侧树
                List<Map<String, Object>> treelist = reviewQueryDAO.getLeftTree();
                leftconfig.put("datas", treelist);
            } else {
                String datarule = this.getDataRuleByMenuguid(menuId, "t", "1=1");
                //根据权限查询单位
                List<Map<String, Object>> list = reviewQueryDAO.getTreeList(datarule, "v_perf_t_deptperfdeclare");
                reviewQueryDAO.saveAll(list, reviewQueryDAO.PMKPI_TABLE_TMP_AGENCY);
                //查询单位上级，合成左侧树
                leftconfig.put("datas", list);
            }
            leftconfig.put("showRootNode", Boolean.TRUE);
            leftconfig.put("dosearch", Boolean.FALSE);
            leftconfig.put("outformart", "#code-#name");
            Map f1 = new HashMap();
            if ("PMKPIAGENCYPROGRAM".equals(elementcode)) {
                leftconfig.put("name", "项目支出");
                f1.put("name", "项目支出");
            } else if ("PMKPIAGENCYEDIT".equals(elementcode)) {
                leftconfig.put("name", "部门整体");
                f1.put("name", "部门整体");
            }
            f1.put("code", elementcode);
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
     * 查询单位树.
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String menuId = (String) params.get("menuid");
        String tablecode = (String) params.get("tablecode");
        String datarule = this.getDataRuleByMenuguid(menuId, "t", "1=1");
        //根据权限查询单位
        List<Map<String, Object>> list = reviewQueryDAO.getTreeList(datarule, tablecode);
        reviewQueryDAO.saveAll(list, reviewQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        return reviewQueryDAO.getLeftTree();
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        String columncode = "agencyguid";
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" where 1=1");
        String datarule = this.getDataRuleByMenuguid(menuid, "t", null); //数据权限
        datarule = datarule.replace("t.agencyguid","t.guid");
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        if (!"treeroot".equals(saveAgency) && !"1".equals(isleaf)) {
            datarule += " start with superguid='" + saveAgency + "' connect by prior guid = superguid";
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            List list = new ArrayList();
            Map map = new HashMap();
            map.put("guid",saveAgency);
            list.add(map);
            eledatas.addAll(list);
            reviewQueryDAO.saveAll(eledatas, reviewQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        } else {
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            reviewQueryDAO.saveAll(eledatas, reviewQueryDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        if (!StringUtil.isEmpty(wheresql)) {
            returnsql.append(" and ").append(wheresql);
        }
        if (!StringUtil.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        if (!StringUtil.isEmpty(isleaf) && "1".equals(isleaf)) {
            returnsql.append(" and t.").append(columncode).append("='").append(saveAgency).append("'");
        } else {
            returnsql.append(" and exists(select 1 from ").append(reviewQueryDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.").append(columncode).append(")");
        }
        return returnsql.toString();
    }
}
