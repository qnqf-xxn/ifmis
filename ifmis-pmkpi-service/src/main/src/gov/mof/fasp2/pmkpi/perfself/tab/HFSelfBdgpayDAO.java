package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:45 2020/8/24  chongdayong
 */
public class HFSelfBdgpayDAO extends PmkpiDAO {
    /**
     * 更新指标执行率数据
     * @param bgtget
     * @param mainguid
     */
	public void updateSelfIndex(float bgtget, String mainguid){
        float score = (float)(Math.round(bgtget/10 * 100))/100;
        String sql = "update v_perf_t_selfperfindex t set t.score = '" + score + "' , t.actualvalue='" + bgtget + "' where datatype='selfframe' and t.name='预算执行率' and t.mainguid='" + mainguid + "'";
	    this.execute(sql);
    }
}
