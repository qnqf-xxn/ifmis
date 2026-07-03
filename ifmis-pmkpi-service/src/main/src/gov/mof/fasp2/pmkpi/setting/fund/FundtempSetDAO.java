package gov.mof.fasp2.pmkpi.setting.fund;

import java.util.List;
import java.util.Map;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

public class FundtempSetDAO extends PmkpiDAO {
	
	/**
	 * 表名
	 */
	public static final String TABLE_FUNDTEMP = "PERF_T_FUNDTEMP";

	/**
	 * 查询
	 * @return
	 */
	public List<Map<String, Object>> getFundData() {
		String province = SecureUtil.getUserSelectProvince();
		String year = CommonUtil.getYear();
		String sql = "select * from " + TABLE_FUNDTEMP +" t where t.province = '" + province + "' and t.year = " + year + " order by t.ordernum";
		return this.queryForList(sql);
	}

}
