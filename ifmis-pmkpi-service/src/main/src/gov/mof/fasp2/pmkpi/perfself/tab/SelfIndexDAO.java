package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:45 2020/8/24  chongdayong
 */
public class SelfIndexDAO extends PmkpiDAO {

	/**
	 *  部门绩效目标。
	 */
	public static final String TABLE_GOAL_DEPT = "v_bgt_perf_goal_info";
	/**
	 *  部门绩效指标。
	 */
	public static final String TABLE_INDEX_DEPT = "v_bgt_perf_indicator";
	/**
	 * 自评绩效指标.
	 */
	public static final String TABLE_INDEX_SELF = "v_perf_t_selfperfindex";
	/**
	 * 自评绩效目标.
	 */
	public static final String TABLE_GOAL_SELF = "v_perf_t_selfperfgoal";

	/**
	 * 指标树级获取指标.
	 * @param mainguid -- 项目guid.
	 * @param frametype -- 指标体系
	 * @return list.
	 */
	public List<Map<String, Object>> getTempdatas(String mainguid, String frametype) {
		StringBuffer sql = new StringBuffer("select guid,'");
		sql.append(mainguid).append("' mainguid,t.superid,t.code,t.name,to_char(levelno) as levelno,'0' as isleaf, '1' as rowtype,weight, ordernum,'0' isedit, null as filename,'' as NCINDEXVAL from ");
		sql.append(PMKPI_TABLE_T_FRAME ).append(" t where frametype='").append(frametype).append("' order by ordernum");
		List<Map<String, Object>> flist = queryForList(sql.toString());
		List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
		for (Map<String, Object> map : flist) {
			String guid = (String) map.get("guid");
			String superid = (String) map.get("superid");
			String levelno = map.get("levelno") + "";
			if (!"1".equals(levelno)) {
				map.put("findex", superid);
				map.put("sindex", guid);
			}
			map.put("_isleaf", "0");
			if(PerfUtil.getIsNINGXIA()){
				map.put("actualweight", map.get("weight"));
			}
			temps.add(map);
		}
		return temps;
	}

	/**
	 * 删除树级指标带有删除的.
	 * @param tablecode -- 表格
	 * @param mainguid -- mainguid.
	 */
	public void delIndexByguid(String tablecode, String mainguid) {
		//String sql = "update " + tablecode + " t set t.is_deleted = 1 where t.mainguid = ?";
		String sql = "delete from " + tablecode + " t where t.mainguid = ?";
		this.update(sql, new String[]{mainguid});
	}

	/**
	 * 获取自评固化指标
	 *
	 * @param wheresql
	 * @param frametype
	 * @return
	 */
	public List<Map<String, Object>> getSelfFrameData(String wheresql, String frametype, String mainguid, String filetype) {
		String sql = "select t.*,t.guid as tindex,t.superid as sindex,b.superid as findex,t.weight as actualweight,'selfframe' datatype from v_perf_t_selfframe t " +
                " left join v_perf_t_selfframe b on t.superid=b.guid and t.frametype=b.frametype where t.frametype=? ";
		if (!StringUtil.isEmpty(wheresql)) {
			sql += " and " + wheresql;
		}
		sql += "order by t.ordernum";
		logger.info("---自评固化指标查询sql：" + sql);
		return PerfUtil.lowMapKey(this.queryForList(sql, new String[]{frametype}));
	}

	/**
	 * 获取预算执行率、得分
	 * @param procode
	 * @param proguid
	 * @param mainguid
	 * @return
	 */
	public Map<String, Object> getSource(String procode, String proguid, String mainguid){
		List<Map<String, Object>> bgtfundList = null;
		Map<String, Object> bgtMap = null;
		StringBuffer sqlbufer = new StringBuffer();
		sqlbufer.append("select count(1) from v_perf_t_selfprofund t where mainguid='").append(mainguid).append("'");
		int i = this.queryForInt(sqlbufer.toString());
		if (i > 0) {
			sqlbufer = new StringBuffer();
			sqlbufer.append("select sum(amt3) as amt3,sum(amt4) as amt4 from v_perf_t_selfprofund t where mainguid='").append(mainguid).append("'");
			bgtfundList = this.queryForList(sqlbufer.toString());
		} else {
			sqlbufer = new StringBuffer();
			sqlbufer.append("select sum(amt3) as amt3,sum(amt4) as amt4 from V_PERF_SELFBDGPAY_project_hf where ");
			if (PerfUtil.getIsHbei()){ // 河北按照proguid
				sqlbufer.append(" perf_fundpay_view.set_month('12') = '12' and perf_fundpay_view.set_procode('").append(proguid).append("')='").append(proguid).append("'");
			}else{
				sqlbufer.append(" perf_fundpay_view.set_month('12') = '12' and perf_fundpay_view.set_procode('").append(procode).append("')='").append(procode).append("'");
			}
			bgtfundList = this.queryForList(sqlbufer.toString());
		}
		if (bgtfundList.size() > 0) {
			bgtMap = bgtfundList.get(0);
		}
		return bgtMap;
	}

	/**
	 * 查询数据.
	 *
	 * @param tablecode --表名
	 * @param wheresql  --查询条件
	 * @param orderby   --排序
	 * @return --
	 */
    public List<Map<String, Object>> findIndexs(String bustype, String tablecode, String wheresql, String orderby, String mainguid, String filetype) {
        String sql = "select t.* from " + tablecode + " t ";
		if (PerfUtil.getIsSx() && "program".equals(bustype)) {
			sql = "select t.*,t1.indexval as ncindexval from " + tablecode + " t left join v_perf_bgt_indicatorpf t1 on t.pro_code = t1.pro_code and t.sindex = t1.sindex and t.name = t1.name ";
		}
        if (wheresql != null && !wheresql.isEmpty()) {
            sql += " where " + wheresql;
        }
        if (orderby != null && !orderby.isEmpty()) {
            sql += " " + orderby;
        }
        logger.info("---自评指标sql输出：" + sql);
        return this.queryForList(sql);
    }
}
