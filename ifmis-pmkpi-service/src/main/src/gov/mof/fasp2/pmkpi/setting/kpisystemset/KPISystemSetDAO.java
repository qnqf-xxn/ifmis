package gov.mof.fasp2.pmkpi.setting.kpisystemset;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class KPISystemSetDAO extends PmkpiDAO {

	/**
     * 临时表.
     */
    public static final String PMKPI_TABLE_TMP_GUIDS = "PERF_TMP_GUIDS";
    
    /**
     * 查询数据.
     * @param tablecode --表名
     * @param wheresql --查询条件
     * @param orderby --排序
     * @return --
     */
    public List<Map<String, Object>> getTableDatas(String tablecode, String wheresql, String orderby) {
    	String province = SecureUtil.getUserSelectProvince();
        String year = CommonUtil.getYear();
    	String sql = "select t.* from " + tablecode + " t where t.year = "+ year + " and t.province = " + province ;
        if (wheresql != null && !wheresql.isEmpty()){
            sql += " and " + wheresql;
        }
        if (orderby != null && !orderby.isEmpty()){
            sql += " " + orderby;
        } else {
            sql += " order by t.updatetime";
        }
        return this.queryForList(sql);
    }
	
}
