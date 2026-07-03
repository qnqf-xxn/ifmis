package gov.mof.fasp2.pmkpi.perfprogram.yearquery;

import com.alibaba.fastjson.JSON;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class YearProgramQueryBO extends PmkpiBO {

    private YearProgramQueryDAO yearProgramQueryDAO;

    public void setYearProgramQueryDAO(YearProgramQueryDAO yearProgramQueryDAO) {
        this.yearProgramQueryDAO = yearProgramQueryDAO;
    }

    /**
     * 获取左侧树数据.-临时表
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> getTreeData(HashMap<String, Object> params) throws AppException {
        String menuId = (String) params.get("menuId");
        String type = (String) params.get("type");
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String tablecode = "V_PERF_PROJECT_YEAR";//默认查全部
        if(type != null && "yearprotablist".equals(type)){//项目年度绩效查询(带页签) 获取页签中配置的tablecode
            String tabtablecode = (String) params.get("tablecode");
            if(!StringUtil.isEmpty(tabtablecode)){
                tablecode = tabtablecode;
            }
        }
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //查询单位上级，合成左侧树
        /*List<Map<String, Object>> list = yearProgramQueryDAO.getTreeList(datarule, tablecode);
        yearProgramQueryDAO.saveAll(list, yearProgramQueryDAO.PMKPI_TABLE_TMP_AGENCY);*/
        List<Map<String, Object>> treelist = yearProgramQueryDAO.getLeftTree(tablecode,datarule);
        leftconfig.put("datas", treelist);
        return leftconfig;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String) sqlmap.get("menuid");
        String isleaf = (String) sqlmap.get("isleaf");
        String agency = (String) sqlmap.get("agency");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String type = (String) sqlmap.get("type");
        String prolev = (String) sqlmap.get("prolev");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1");
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where ");
        StringBuffer wsql = new StringBuffer();
        if (type != null && "1".equals(type)) { // 如果是事前绩效评估查询-V_COL12：1-是；2-否；
            wsql.append(" and v_col12 = '1' ");
        }
        if (!StringUtils.isEmpty(prolev)) { // 如果级别字段不为空则加入条件查询
            wsql.append(" and pro_lev = '" + prolev + "' ");
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            wsql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            wsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            wsql.append(" and ").append(tabfilter);
        }
        sql.append(datarule);
        if (wsql.length() > 0) {
            sql.append(wsql);
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, yearProgramQueryDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }
}
