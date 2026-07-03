package gov.mof.fasp2.pmkpi.workevaluate.performance;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static gov.mof.fasp2.pmkpi.common.PmkpiDAO.PMKPI_TABLE_T_AGENCY;

public class PerformanceBO extends PmkpiBO {

    private PerformanceDAO performanceDAO;

    public void setPerformanceDAO(PerformanceDAO performanceDAO) {
        this.performanceDAO = performanceDAO;
    }

    /**
     * @return Map<String, Object>
     * @throws AppException 异常信息
     * @Description: 预算单位
     */
    public Object getLeftTree(HashMap<String, Object> params) throws AppException {
        String leftmenuid = (String) params.get("menuId");
        List value = getDeptValues(leftmenuid," 1=1 ");
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("name", "本级部门");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", value);
        return leftconfig;
    }

    public List getDeptValues(String leftmenuid,String filter) throws AppException {
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        if (" 1<>1 ".equals(datarule)) {
            datarule = " 1=1 ";
        } else {
            datarule = datarule.replaceAll("t.agencyguid", "t.guid");
        }
        datarule = datarule+" and "+filter;
        IDataSetService dataService = (IDataSetService) ServiceFactory.getBean("bus.dic.datasetmanagerange.service");
        return dataService.getRangesByWhereSql("PMKPIDEPT", datarule);
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        HashMap<String, Object> params = (HashMap<String, Object>) sqlmap;
        return this.getDatas(params);
    }

    /**
     * 查询数据.
     *
     * @param params --
     * @return --
     */
    public String getDatas(HashMap<String, Object> params) throws AppException {

        String leftmenuid = (String) params.get("menuId");
        String filter = (String) params.get("filter");
        String querySql = (String) params.get("querySql");

        StringBuffer sql = new StringBuffer("select * from (select (case when a.guid is null then '2' else '1' end) iseval,a.guid,a.MONITORSCORE,a.PUBLICTARGETSCORE,a.SELFEVALSCORE,a.GOALACHIEVESCORE,a.TOTALSCORE,a.RATING,pm.guid as oldguid,pm.code,pm.name,pm.finintorgguid from (select distinct * from ");
            sql.append(PMKPI_TABLE_T_AGENCY).append(" where length(code)=3 and isleaf = 0)pm left join V_PERF_T_WORKTASKASSIGN a on pm.code=a.code ) t").append(" where ");

        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        if (" 1<>1 ".equals(datarule)) {
            datarule = " 1=1 ";
        } else {
            datarule = datarule.replaceAll("t.agencyguid", "t.oldguid");
        }

        if(querySql!=null&&querySql.length()>0){
            datarule += " and "+querySql;
        }
        if(filter!=null&&filter.length()>0){
            datarule += " and "+filter;
        }
        sql.append(datarule);
        sql.append(" order by code");

        return sql.toString();
    }
}
