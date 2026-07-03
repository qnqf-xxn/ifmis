package gov.mof.fasp2.pmkpi.workevaluate.score;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WorkEvaluateScoreBO extends PmkpiBO {
    private WorkEvaluateScoreDAO workEvaluateScoreDAO;

    public void setWorkEvaluateScoreDAO(WorkEvaluateScoreDAO workEvaluateScoreDAO) {
        this.workEvaluateScoreDAO = workEvaluateScoreDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            workEvaluateScoreDAO.setYearAndProvince(queryYear, queryProvince);
        }
        //存入临时表
        this.setMap(params);
        List<Map<String, Object>> list = workEvaluateScoreDAO.getScoreDatas(params);
        backMap.put("data", list);
        return backMap;
    }

    /**
     * 参数与工作流数据guid存储到临时表
     * @throws AppException AppException
     */
    private void setMap(HashMap<String, Object> params) throws AppException {
        Map<String, Object> map = null;
        List<Map<String, Object>> list = new ArrayList<>();
        for (Map.Entry<String, Object> entry : params.entrySet()) {
            map = new HashMap<>();
            String entrykey  = entry.getKey();
            Object entryvalue = entry.getValue();
            map.put("key", entrykey);
            map.put("value", entryvalue);
            list.add(map);
        }
        workEvaluateScoreDAO.saveAll(list, "PERF_TMP_AUDITDEFINEWHERESQL");
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = "v_perf_t_deptscore";
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String proguid = (String) params.get("proguid");
        String scoretype = (String) params.get("scoretype");
        String bustype = (String) params.get("bustype");
//        String pagetype = (String) params.get("pagetype");
        String subprovince = (String) params.get("subprovince");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> list = new ArrayList<>();
        List<Map<String, Object>> updatas = new ArrayList<>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            String isedit = (String) map.get("isedit");
            if ((rowtype != null && "add".equals(rowtype)) || (isedit != null && "1".equals(isedit))) {
                map.put("tempguid", map.get("guid"));
                map.put("proguid", proguid);
                map.put("mainguid", mainguid);
                map.put("status", 1);
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                if (bustype != null && "subprovince".equals(bustype)) {
                    map.put("province", subprovince);
                } else {
                    map.put("province", SecureUtil.getCurrentUser().getProvince());
                }
                map.put("agencyguid", saveAgency);
                map.put("year", CommonUtil.getYear());
                map.put("ordernum", i);
                map.put("guid", this.getCreateguid());
                map.put("type", scoretype);
                if ("add".equals(rowtype)) {
                    map.put("isdeptadd", 1);
                }
                i++;
                list.add(map);
            } else {
                updatas.add(map);
            }
        }
        //区县保存
        if (bustype != null && "subprovince".equals(bustype)) {
            tablecode = "perf_t_deptscore";
            //保存并审核时
//            if (pagetype != null && "audit".equals(pagetype)) {
//                String wheresql = " set t.wfstatus='011' where guid='" + mainguid + "'";
//                workEvaluateScoreDAO.updateDatas("perf_t_worktaskassign", wheresql);
//            }
        }
        String delsql = " mainguid='" + mainguid + "' and nvl(isdeptadd,'0') <> 1 and type='" + scoretype + "'";
        workEvaluateScoreDAO.delDatas(tablecode, delsql);
        workEvaluateScoreDAO.saveAll(list, tablecode);
        if (updatas.size()>0) {
            workEvaluateScoreDAO.updateAll(updatas, tablecode);
        }
        return this.auditdefine(list, busguid,"perf", null);
    }
}
