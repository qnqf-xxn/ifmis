/**
 * @Title: PrjIndexDAO.java
 * @Copyright (C) 2020
 * @Description:
 * @Revision History:
 * @Revision 1.0 2020-1-6  GM
 */


package gov.mof.fasp2.pmkpi.perfprogram.fundCalIndex.adjust;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.List;
import java.util.Map;


/**
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:42:14
 * @ClassName: PrjIndexDAO
 * @Description: Description of this class
 */

public class FundCalAdjustIndexDAO extends PmkpiDAO {

    /**
     * 根据项目，年度，查询年度明细指标.
     *
     * @param proGuid   -- 项目guid.
     * @param tableCode -- 查询案例表或项目指标表
     * @return list.
     * @throws
     */
    public List<Map<String, Object>> findIndexs(String whsql, String tableCode) {
//        String isZJ = PerfUtil.getSystemSet("isZJ"); //是否是浙江环境
        StringBuffer sql = new StringBuffer();
        sql.append("select * from ").append(tableCode).append(" t where 1=1 and");
        sql.append(whsql);
        sql.append(" order by t.xmmxnr,t.sindex,t.findex,t.ordernum");
        logger.debug("-------------指标查询sql-------------" + sql.toString());
        return this.queryForList(sql.toString());
    }

}
