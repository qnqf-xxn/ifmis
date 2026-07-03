package gov.mof.fasp2.pmkpi.evaluation.financial.evaluresult;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;

/**
 * <p></p >
 *
 * @author hw
 * @date 2022/11/18 10:50
 */
public class EvaluResultDAO extends PmkpiDAO {
	
	/**
	 * 根据guid查询数据
	 * @param guid
	 * @return
	 */
	public List getByGuid(String tablecode, String guid){
		StringBuffer sql = new StringBuffer();
		sql.append(" select * from ");
		sql.append(tablecode).append(" where mainguid = '").append(guid).append("'");
		return this.queryForList(sql.toString());
	}

}
