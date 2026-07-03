package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:45 2020/8/24  chongdayong
 */
public class SelfProjinfoBO extends PmkpiBO {
    private SelfProjinfoDAO selfProjinfoDAO;

    public void setSelfProjinfoDAO(SelfProjinfoDAO selfProjinfoDAO) {
        this.selfProjinfoDAO = selfProjinfoDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String projguid = (String)params.get("projguid");
        String procode = (String)params.get("procode"); //项目编码
        String mainguid = (String)params.get("mainguid");
        String agencyguid = (String)params.get("agencyguid");
        String bustype = (String)params.get("bustype");
        String uptable = (String)params.get("uptable"); //项目信息表
        String downtable = (String)params.get("downtable");//自评有关信息表
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        StringBuffer wheresql = new StringBuffer();
        if("dept".equals(bustype)){
            wheresql.append(" t.agencyguid = '").append(agencyguid).append("'");
        } else {
            Boolean flag = PerfUtil.getIsHbei();
            if (!flag){
                wheresql.append(" t.pro_code = '").append(procode).append("'");
            } else {
                wheresql.append(" t.guid = '").append(projguid).append("'");
            }
        }
        List<Map<String, Object>>  updata = selfProjinfoDAO.getDatas(uptable, wheresql.toString(), null);
        backMap.put("upinfo", updata);
        if (downtable != null && !downtable.isEmpty()){
            String sql = " t.bustype = ? and t.guid = ?";
            if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
                selfProjinfoDAO.setYearAndProvince(queryYear, queryProvince);
            }
            List<Map<String, Object>>  downdata = selfProjinfoDAO.getDatas(downtable, sql, null, new String[]{bustype, mainguid});

            backMap.put("downinfo", downdata);
        }
        return backMap;
    }
    
    /**
     * 保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
    	String tablecode = (String)params.get("tablecode");
        String busguid = (String) params.get("busguid");
        //全部数据
        Map<String, Object> datas = (Map<String, Object>) params.get("datas");
        String mainguid = (String) params.get("mainguid");
        String workflow = (String) params.get("workflow");
        if (StringUtil.isEmpty(tablecode)){
            tablecode = "V_PERF_T_SELFEVALTASK"; //自评任务表
        }
        Map map = null;
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        List<Map> updatas = selfProjinfoDAO.getByGuid(tablecode, mainguid);
		if (updatas != null && updatas.size() > 0) {//修改  WFSTATUS
            map = updatas.get(0);
		    String wfstatus = (String) map.get("wfstatus"); //工作流状态
            datas.put("guid", mainguid);
            datas.put("updatetime", PerfUtil.getServerTimeStamp());
            //datas.put("province", SecureUtil.getUserSelectProvince());
            //datas.put("year", CommonUtil.getYear());
            l.add(datas);
            if (StringUtil.isEmpty(wfstatus)) {
                this.workflow("createnosave", workflow, "", tablecode, l);
            } else {
                List<String> cols = new ArrayList<String>(datas.keySet());
                selfProjinfoDAO.update(cols, datas, tablecode); //更新修改信息
            }
		}
        return this.auditdefine(l, busguid,"perf", null);
    }

}
