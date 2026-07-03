package gov.mof.fasp2.pmkpi.evaluate.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluate.dao.PreEvaluateProGoalDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PreEvaluateProGoalBo extends PmkpiBO {

    private PreEvaluateProGoalDAO preEvaluateProGoalDAO;

    public void setPreEvaluateProGoalDAO(PreEvaluateProGoalDAO preEvaluateProGoalDAO) {
        this.preEvaluateProGoalDAO = preEvaluateProGoalDAO;
    }

    /**
     * 获取目标数据
     * @param proguid --项目guid
     * @return
     */
    public List<Map<String, Object>> getGoalByGuid(String proguid){
        return preEvaluateProGoalDAO.getDatas("v_pm_perf_goal_info", " mainguid='" + proguid + "'", null);
    }

    /**
     * 查询各年度数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> findYearIndexs(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String sindex = "";
        List<Map<String, Object>> indexs = preEvaluateProGoalDAO.findIndexs(proguid,"v_pm_perf_indicator");
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode("PM_PERF_INDICATOR");
        List diccolumn = new ArrayList<String>();
        for (DicColumnDTO dicColumnDTO : dicColumnDTOs) {
            diccolumn.add(dicColumnDTO.get("dbcolumncode"));
        }
        for (Map<String, Object> map : indexs) {
            sindex = (String) map.get("sindex");
            keycode = sindex;
            if (!indexMap.containsKey(keycode)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(keycode, tempList);
            } else {
                tempList = indexMap.get(keycode);
            }
            tempList.add(map);
        }
        List<Map<String, Object>> nullTemp = preEvaluateProGoalDAO.findNullTemp(proguid); //空指标模板
        List<Map<String, Object>> backindex = new ArrayList<Map<String,Object>>(); //返回指标
        for (Map<String, Object> map : nullTemp) {
            sindex = (String) map.get("sindex");
            map.put("guid",this.getCreateguid());
            keycode = sindex;
            if (indexMap.containsKey(keycode)) {
                tempList = indexMap.get(keycode);
                backindex.addAll(tempList);
            } else {
                backindex.add(map);
                for (Map<String, Object> bacmap : backindex) {
                    for (int i = 0;i< diccolumn.size();i++) {
                        String col = (String) diccolumn.get(i);
                        if(!bacmap.containsKey(col)){
                            bacmap.put(col.toLowerCase(), null);
                        }
                    }
                }

            }
        }
        yearsMap.put("#index", backindex);
        return yearsMap;
    }
    /**
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("projguid");
//        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
//        String isshowindex = (String) params.get("isshowindex");
        String procode = (String) params.get("procode");
        String tablecode = "";
        tablecode = "v_pm_perf_goal_info";
        Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
        String wheresql = " mainguid='" + proguid + "'";
        int i = preEvaluateProGoalDAO.getDataCount(tablecode, wheresql);
        editinfo.put("updatetime", PerfUtil.getServerTimeStamp());
        editinfo.put("update_time", PerfUtil.getServerTimeStamp());
        if (i > 0) {
            List<String> cols = new ArrayList<String>(editinfo.keySet());
            preEvaluateProGoalDAO.update(cols, editinfo, tablecode);
        } else {
            editinfo.put("guid", this.getCreateguid());
            editinfo.put("creater", SecureUtil.getCurrentUserID());
            editinfo.put("province", SecureUtil.getUserSelectProvince());
            editinfo.put("year", CommonUtil.getYear());
            editinfo.put("createtime", PerfUtil.getServerTimeStamp());
            editinfo.put("agencyguid", saveAgency);
            editinfo.put("mainguid", proguid);
            editinfo.put("kpi_per_id", editinfo.get("guid"));
            editinfo.put("pro_code", procode);
            editinfo.put("create_time", PerfUtil.getServerTimeStamp());
            editinfo.put("agency_code", saveAgency);
            editinfo.put("mof_div_code", SecureUtil.getUserSelectProvince());
            editinfo.put("fiscal_year", CommonUtil.getYear());
            preEvaluateProGoalDAO.save(editinfo, tablecode);
        }
        Map remap = new HashMap();
        remap.put("redata",new ArrayList());
        remap.put("success", true);
        remap.put("msg", "Y");
        remap.put("errmsg", "Y");
        remap.put("errtype", "tips");
        return remap;
    }
}
