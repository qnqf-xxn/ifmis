package gov.mof.fasp2.pmkpi.setting.uservagency;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

public class UserVAgencyDAO extends PmkpiDAO {

	/**
	 * 查询用户树
	 * @return
	 */
	public List<Map<String, Object>> getUserTree() {
		String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql =new StringBuffer("select t.*,1 as status from (");
        sql.append(" select  guid,name,code,3 as levelno, 1 as isleaf, agency as parentid from fasp_T_causer where status = '1' and  province= '").append(province).append("' ");
        sql.append(" union select '").append(SecureUtil.getUserSelectProvince()).append("','").append(SecureUtil.getUserProvinceName()).append("','");
		sql.append(SecureUtil.getUserSelectProvince()).append("',1,0,'0' from dual");
		sql.append(" union select guid,to_char(name),code,levelno, 0 as isleaf ,t.superguid as parentid ");
        sql.append(" from pmkpi_fasp_t_pubagency t start with t.guid in(select a.guid from pmkpi_fasp_t_pubagency a where exists(select 1 from fasp_t_causer b where b.agency=a.guid)) connect by t.superguid= prior t.guid)t ");
        sql.append(" order by code");
		logger.debug(sql.toString());
		return this.queryForList(sql.toString());
	}

	/**
	 * 查询单位树
	 * @return
	 */
	public List<Map<String, Object>> getAgencyTree() {
		String sql = "select t.guid,t.name,t.code,t.levelno + 1 levelno,t.isleaf," +
				" case when t.superguid = '#' then 'dept' else t.superguid  end parentid from Fasp_t_Pubagency t " +
				" order by code";
		return this.queryForList(sql);
	}

	/**
	 * 查询处室树
	 * @return
	 */
	public List<Map<String, Object>> getBusofficeTree() {
		String sql = "select 'busoffice' guid,'处室' as name, '00' code, 2 levelno, 0 isleaf, 'dept' parentid from dual " +
				" union all select t.guid,to_char(t.name) as name,t.code," +
				" t.levelno + 2 levelno,t.isleaf, 'busoffice' parentid  from Fasp_t_Pubdepartment t " +
				" order by code";
		return this.queryForList(sql);
	}

	/**
	 * 查询处室用户
	 * @return
	 */
	public List<Map<String, Object>> getBusofficeUser() {
		String province = SecureUtil.getUserSelectProvince();
		StringBuffer sql =new StringBuffer("select t.*,1 as status from ( ");
		sql.append(" select guid, name, code, 3 as levelno, 1 as isleaf, division as parentid from fasp_T_causer where status = '1' and province= '").append(province).append("' ");
		sql.append(" union select guid, name, code, levelno, 0 as isleaf, parentid from ");
		sql.append(" (select * from (select a.guid, to_char(a.name) as name, a.code, a.levelno, 0 as isleaf, a.superguid parentid  from fasp_T_causer c ");
		sql.append(" left join Fasp_t_Pubdepartment a on c.division=a.guid  ");
		sql.append(" where c.status = '1' and c.province= '").append(province).append("' and a.guid is not null and c.division is not null) connect by parentid = prior guid )) t ");
		sql.append(" start with t.levelno =1 ");
		sql.append(" connect by t.parentid = prior t.guid order by code");
		return this.queryForList(sql.toString());
	}

	/**
	 * 查询已选择单位树
	 * @return
	 */
	public List<Map<String, Object>> getselectAgencyTree(String userguid) {
		String sql ="select m.guid,m.name,m.code,m.levelno + 1 levelno,m.isleaf,case when m.superguid = '#' then 'dept'else m.superguid end parentid from  Fasp_t_Pubagency m where exists "
			+ " ( select * from (select p.superguid from Fasp_t_Pubagency p "
			+ " where exists (select 1 from V_PMKPI_T_USERVAGENCY a where a.userguid = '"+userguid+"' and p.guid =a.agency)) n where n.superguid=m.guid ) "
			+ " union select * from "
			+ " (select t.guid,t.name,t.code,t.levelno + 1 levelno,t.isleaf,case when t.superguid = '#' then 'dept' else t.superguid end parentid "
			+ " from Fasp_t_Pubagency t where  exists (select 1 from V_PMKPI_T_USERVAGENCY a where a.userguid = '"+userguid+"' and t.guid =a.agency)) t "
			+ " order by code";
		return this.queryForList(sql);
	}
	
	/**
	 * 查询已选择处室树
	 * @return
	 */
	public List<Map<String, Object>> getselectBusofficeTree(String userguid) {
		String sql ="select * from "
		+ "(select t.guid,t.name,t.code,t.levelno + 2 levelno,t.isleaf, "
		+ "'busoffice' parentid  from Fasp_t_Pubdepartment t where exists (select 1 from V_PMKPI_T_USERVAGENCY a where a.userguid = '"+userguid+"' and t.guid =a.agency)) t "
		+ "  order by code";
		return this.queryForList(sql);
	}

	/**
	 * 查询上年已选择单位树
	 * @return
	 */
	public List<Map<String, Object>> getLastYearselectAgencyTree(String userguid,Integer year) {
		String province = CommonUtil.getProvince();
		String sql ="select m.guid,m.name,m.code,m.levelno + 1 levelno,m.isleaf,case when m.superguid = '#' then 'dept'else m.superguid end parentid from  Fasp_t_Pubagency m where exists "
				+ " ( select * from (select p.superguid from Fasp_t_Pubagency p "
				+ " where exists (select 1 from PMKPI_T_USERVAGENCY a where a.userguid = '"+userguid+"' and p.guid =a.agency and year = "+year+" and province ='"+province+"')) n where n.superguid=m.guid ) "
				+ " union select * from "
				+ " (select t.guid,t.name,t.code,t.levelno + 1 levelno,t.isleaf,case when t.superguid = '#' then 'dept' else t.superguid end parentid "
				+ " from Fasp_t_Pubagency t where  exists (select 1 from PMKPI_T_USERVAGENCY a where a.userguid = '"+userguid+"' and t.guid =a.agency and year = "+year+" and province ='"+province+"')) t "
				+ " order by code";
		return this.queryForList(sql);
	}

	/**
	 * 查询上年已选择处室树
	 * @return
	 */
	public List<Map<String, Object>> getLastYearselectBusofficeTree(String userguid,Integer year) {
		String province = CommonUtil.getProvince();
		String sql ="select * from "
				+ "(select t.guid,to_char(t.name) as name,t.code,t.levelno + 2 levelno,t.isleaf, "
				+ "'busoffice' parentid  from Fasp_t_Pubdepartment t where exists (select 1 from PMKPI_T_USERVAGENCY a where a.userguid = '"+userguid+"' and t.guid =a.agency and year = "+year+" and province ='"+province+"')) t "
				+ "  order by code";
		return this.queryForList(sql);
	}

}
