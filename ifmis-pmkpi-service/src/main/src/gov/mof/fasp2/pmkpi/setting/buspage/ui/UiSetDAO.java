package gov.mof.fasp2.pmkpi.setting.buspage.ui;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * @ClassName: UiDAO
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午05:33:27
 */
public class UiSetDAO extends PmkpiDAO {
	/**
	 * 查询数据.
	 * @param key --
	 * @return --
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getData(String tablecode, String key) {
		String sql = "select * from " + tablecode + " where key = ? order by year,ordernum";
		return this.queryForList(sql, new String[]{key});
	}

	public List<Map<String, Object>> getData(String tablecode, String wheresql,
			String ordernum) {
		String sql = "select * from " + tablecode + " where 1=1 ";
		if (wheresql != null && !wheresql.isEmpty()) {
			sql += wheresql;
		}
		if (ordernum != null && !ordernum.isEmpty()) {
			sql += ordernum;
		}
		return this.queryForList(sql);
	}

    /**
     * 获取编辑区表格数据.
     * @param key --
     * @return --
     */
	public List<Map<String,Object>> getUIData(String key, String tablecode) {
		String sql = "";
		if("busfw_t_uitable".equals(tablecode) || "BUSFW_T_UITABLE".equals(tablecode) ){
			sql = "select * from "+tablecode+" t where key='"+key+"'";
		}else{
			sql = "select * from "+tablecode+" t where key='"+key+"' order by t.ordernum";
		}
		return this.queryForList(sql);
	}
}
