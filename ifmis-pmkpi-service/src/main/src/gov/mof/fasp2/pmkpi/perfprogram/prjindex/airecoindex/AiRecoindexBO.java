package gov.mof.fasp2.pmkpi.perfprogram.prjindex.airecoindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AiRecoindexBO extends PmkpiBO {

    private AiRecoindexDAO aiRecoindexDAO;

    public void setAiRecoindexDAO(AiRecoindexDAO aiRecoindexDAO) {
        this.aiRecoindexDAO = aiRecoindexDAO;
    }

    /**
     * 保存新的实时辅助审核结果
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveNewAIRecoindexDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<>();
        String procode = (String) params.get("procode");
        String proguid = (String) params.get("proguid");
        String prompt = (String) params.get("prompt");
        String yearflag = (String) params.get("yearflag");
        procode = "1".equals(yearflag) ? proguid : procode;
        String thinkingprocess = (String) params.get("thinkingprocess");
        List<Map<String, Object>> airecoindexList = (List<Map<String, Object>>) params.get("datas");
        String timestamps = PerfUtil.getServerTimeStamp();
        String province = SecureUtil.getUserSelectProvince();
        String year = String.valueOf(SecureUtil.getUserSelectYear());
        int i = 1;
        for (Map<String, Object> airecoindexmap : airecoindexList) {
            airecoindexmap.put("guid", this.getCreateguid());
            airecoindexmap.put("province", province);
            airecoindexmap.put("year", year);
            airecoindexmap.put("create_time", timestamps);
            airecoindexmap.put("pro_code",procode);
            airecoindexmap.put("yearflag",yearflag);
            airecoindexmap.put("ordernum",i++);
        }
        if (airecoindexList != null && !airecoindexList.isEmpty()) {
            aiRecoindexDAO.saveAll(airecoindexList, "PERF_T_AIRECOINDEX");
        }
        if (StringUtils.isNotEmpty(thinkingprocess)) {
            Map<String, Object> mainmap = new HashMap<>();
            mainmap.put("guid", this.getCreateguid());
            mainmap.put("province", province);
            mainmap.put("year", year);
            mainmap.put("create_time", timestamps);
            mainmap.put("pro_code",procode);
            mainmap.put("yearflag",yearflag);
            mainmap.put("prompt",prompt);
            mainmap.put("thinkingprocess",thinkingprocess);
            aiRecoindexDAO.save(mainmap,"PERF_T_AIRECOINDEXMAIN");
        }
        backmap.put("success",true);
        return backmap;
    }

    public Map<String, Object> getAIRecoindexDatas(HashMap<String, Object> params) throws AppException{
        Map<String, Object> result = new HashMap<>();
        String procode = (String) params.get("procode");
        String proguid = (String) params.get("proguid");
        String yearflag = (String) params.get("yearflag");
        procode = "1".equals(yearflag) ? proguid : procode;
        String wheresql = "pro_code= ? and yearflag = ?";
        Map<String, Object> dataMap = this.getDataMap("PERF_V_AIRECOINDEXMAIN", wheresql,new String[]{procode,yearflag});
        List<Map<String, Object>> airecoindexList = this.getDatas("PERF_V_AIRECOINDEX",wheresql," order by t.findex,t.sindex,t.ordernum",new String[]{procode,yearflag});
        result.putAll(dataMap);
        result.put("airecoindex",airecoindexList);
        result.put("success",true);
        return result;
    }

}
