package gov.mof.fasp2.pmkpi.setting.evaluation.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.fileupload.HtmlFileUploadService;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluation.financial.query.FinancialQueryBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluationQueryBO extends PmkpiBO {
    private EvaluationQueryDAO evaluationQueryDAO;
    protected static Logger logger = Logger.getLogger(FinancialQueryBO.class);
    private HtmlFileUploadService htmlFileUploadService = (HtmlFileUploadService) ServiceFactory.getBean("buscore.fudsclient.htmluploadservice");


    public void setEvaluationQueryDAO(EvaluationQueryDAO evaluationQueryDAO){
        this.evaluationQueryDAO = evaluationQueryDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        StringBuffer returnsql = new StringBuffer("select t.* from ");
        returnsql.append(tablecode).append(" t  where ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1"); //数据权限
        returnsql.append(datarule);
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, evaluationQueryDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }

    /**
     * 查询左侧树。
     * */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String leftmenuid = (String) params.get("leftmenuid");
        String tablecode = (String) params.get("tablecode");
        String tablesql = (String) params.get("tablesql"); //表格配置的sql
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        if (tablesql != null && !tablesql.isEmpty()){
            datarule += " and " + tablesql;
        }
        return evaluationQueryDAO.getLeftTree(tablecode, datarule);
    }

    public String getDataGuid(HashMap<String, Object> params){
        String projguid = (String) params.get("projguid");
        String procode = (String) params.get("procode");
        String wheresql ="";
        if (PerfUtil.getIsHbei()){
            wheresql = " proguid = '"+ projguid +"'";
        }else{
            wheresql = " pro_code = '"+ procode +"'";
        }
        List<Map<String, Object>> datas = this.getDatas("V_PERF_T_EVALUATION", wheresql, null);
        String guid = "";
        if (datas.size() > 0) {
            guid = (String) datas.get(0).get("guid");
        }
        return guid;
    }
}
