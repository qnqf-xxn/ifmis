package gov.mof.fasp2.pmkpi.setting.buspage;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;

/**
 * @ClassName: BusAppendDAO
 * @Description: Description of this class
 * @author <a href="mailto:zhongdayong@bjinfor.cn">chongdayong</a>于2021-4-12 下午04:11:13
 */
public class BusAppendDAO extends PmkpiDAO {
	/**
	 * 获取左侧树数据.
	 * @return --
	 */
	public List<Map<String, Object>> getTreeData() {
		StringBuffer sql = new StringBuffer();
		sql.append("select * from (select guid,code,name,substr (t.url,0, instr(t.url, '.page', 1, 1) - 1) uikey,");
		sql.append("parentid superguid,levelno,isleaf,t.menuorder ordernum,'' menutype from fasp_t_pubmenu t where t.appid='pmkpi'");
		sql.append(" and name not like'%(隐藏)' and name not like'%（隐藏）'");
		sql.append(" union all ");
		sql.append("select guid,code,name,uikey,superguid,levelno,isleaf,ordernum,'add' menutype from perf_t_pagemenu) order by code,ordernum");
		return this.queryForList(sql.toString());
	}

	/**
	 * 获取列表数据.
	 * @param key --
	 * @return --
	 */
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> getData(String key) {
	    StringBuffer sql = new StringBuffer();
	    sql.append("select t.url, t.componentid, t.config, t.id, t.appid, t.region, ");
	    sql.append("(case ");
	    sql.append("when t.componentid='header' then '头部导航'");
	    sql.append("when t.componentid='bustabpage' then '页签' ");
	    sql.append("when t.componentid='bustoolbutton' then '按钮' ");
	    sql.append("when t.componentid='busqueryform' then '查询区' ");
		sql.append("when t.componentid='buseditform' then '编辑区' ");
	    sql.append("when t.componentid='busdclefttree' then '左侧树' ");
		sql.append("when t.componentid='buslefttree' then '左侧树' ");
	    sql.append("when t.componentid='busuidatatable' then '列表' ");
	    sql.append("else '' END )  componentname ");
	    sql.append("from bus_t_pageconsolecomconfig t ");
        sql.append("where t.url='"+key+"'");
		return this.queryForList(sql.toString());
	}
}
