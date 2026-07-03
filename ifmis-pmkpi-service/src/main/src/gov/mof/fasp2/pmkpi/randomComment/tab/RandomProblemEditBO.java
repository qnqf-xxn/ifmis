package gov.mof.fasp2.pmkpi.randomComment.tab;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RandomProblemEditBO extends PmkpiBO {

    private RandomProblemEditDAO randomProblemEditDAO;

    public void setRandomProblemEditDAO(RandomProblemEditDAO randomProblemEditDAO) {
        this.randomProblemEditDAO = randomProblemEditDAO;
    }
    

    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
    	String mainguid = (String)params.get("mainguid");
        String procode = (String)params.get("procode");
        String wheresql = " t.selfguid = '" + mainguid + "'";
        List<Map<String, Object>> data = randomProblemEditDAO.getDatas("V_PERF_RANDOMPROBLEM", wheresql, "order by guid");
        List<Map<String, Object>> scoredata = randomProblemEditDAO.getDatas("V_PERF_T_RANDOMCOMMENT_PROJ", " t.selfguid = '" + mainguid + "'", "order by guid");
        Map<String, Object> backMap = new HashMap<String, Object>();
        if(data.size() > 0){
        	backMap = data.get(0);
        }
        if(scoredata.size() > 0){
        	backMap.put("meachname", scoredata.get(0).get("meachname"));
        	backMap.put("actualscore", scoredata.get(0).get("actualscore"));
        	backMap.put("randomresult", scoredata.get(0).get("randomresult"));
        }
        return backMap;
    }
  
    public Map<String, Object> savePro(HashMap<String, Object> params) throws AppException {
   	 //表名
        String tablecode = (String) params.get("tablecode");
        String mainguid = (String) params.get("mainguid");
        String procode = (String) params.get("procode");
        String busguid = (String) params.get("busguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String guid = (String) map.get("guid");
            if (StringUtil.isEmpty(guid)) {
                map.put("guid", StringUtil.createUUID());
                map.put("mainguid", mainguid);
                map.put("pro_code", procode);
                map.put("vclo1", map.get("vcol1"));
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                addlist.add(map);
            } else {
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            randomProblemEditDAO.delDatas(tablecode," t.mainguid = '"+mainguid+"'");
        	randomProblemEditDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
        	randomProblemEditDAO.updateAllByPK(uplist, "guid", tablecode);
        }
    	return this.auditdefine(datas, busguid,"perf", null);
    }
    
}
