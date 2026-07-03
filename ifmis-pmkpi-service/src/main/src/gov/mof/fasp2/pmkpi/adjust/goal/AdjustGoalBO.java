package gov.mof.fasp2.pmkpi.adjust.goal;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.adjust.deptadjperf.DtPerfAdjDAO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdjustGoalBO extends PmkpiBO {
    private AdjustGoalDAO adjustGoalDAO;

    public void setAdjustGoalDAO(AdjustGoalDAO adjustGoalDAO) {
        this.adjustGoalDAO = adjustGoalDAO;
    }

    /**
     * 查询目标.
     * @param params --
     * @return --
     */
    public Map<String, Object> queryGoal(HashMap<String, Object> params) {
        String proguid = (String) params.get("proguid");
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        String bustype = (String) params.get("bustype");
        String procode = (String) params.get("procode");
        String queryYear = (String) params.get("queryYear");
        String queryProvince = (String) params.get("queryProvince");
        if (!StringUtil.isNullOrEmpty(queryYear) && !StringUtil.isNullOrEmpty(queryProvince)) {
            this.setYearAndProvince(queryYear, queryProvince);
        }
        String wheresql = "";
        wheresql = " mainguid='" + mainguid + "'";
        Map<String, Object> goalMap = adjustGoalDAO.getDataMap("v_perf_t_adjustgoal", wheresql);
        if (!goalMap.isEmpty()) {
            return goalMap;
        } else {
            wheresql = " mainguid='" + proguid + "'";
            if (bustype != null && ("program".equals(bustype) || "protrace".equals(bustype))) {
                if (!PerfUtil.getIsHbei()) {
                    wheresql = " pro_code='" + procode + "'";
                }
                wheresql += " and yearflag='0' ";
            }
            return adjustGoalDAO.getDataMap(tablecode, wheresql);
        }
    }

    /**
     * 查询目标.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveGoal(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String mainguid = (String) params.get("mainguid");
        String busguid = (String) params.get("busguid");
        String goaltablecode = "v_perf_t_adjustgoal";
        String queryYear = (String) params.get("queryYear");
        String queryProvince = (String) params.get("queryProvince");
        if (!StringUtil.isNullOrEmpty(queryYear) && !StringUtil.isNullOrEmpty(queryProvince)) {
            this.setYearAndProvince(queryYear, queryProvince);
        }
        this.setProAgencyName(params);
        String procode = (String) params.get("procode");
        String pro_name = (String) params.get("pro_name");
        String bustype = (String) params.get("bustype");
        String saveAgency = (String) params.get("saveAgency");
        String agency_name = (String) params.get("agency_name");
        Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
        String wheresql = " mainguid='" + mainguid + "'";
        editinfo.put("mainguid", mainguid);
        editinfo.put("proguid", proguid);
        List<Map<String, Object>> adjustdatas = adjustGoalDAO.getDatas(goaltablecode, wheresql, "order by update_time");
        if (adjustdatas.size() > 0) {//批量修改
            for(Map<String, Object> goalmap : adjustdatas){
                goalmap.put("applyfinamt", editinfo.get("applyfinamt"));
                goalmap.put("adjustremark", editinfo.get("adjustremark"));
                goalmap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
                if(editinfo.get("adjustndgoal") != null){
                    goalmap.put("adjustndgoal", editinfo.get("adjustndgoal"));
                }
                if ("program".equals(bustype) || "protrace".equals(bustype)) {
                    goalmap.put("pro_code", procode);
                    goalmap.put("pro_name", pro_name);
                }
                if (!StringUtil.isNullOrEmpty(agency_name)) {
                    goalmap.put("agency_name", agency_name);
                }
                goalmap.put("update_time", PerfUtil.getServerTimeStamp());
                goalmap.put("updatetime", PerfUtil.getServerTimeStamp());
                if(editinfo.get("adjreason") != null){
                    goalmap.put("adjreason", editinfo.get("adjreason"));
                }
            }
            adjustGoalDAO.updateAll(adjustdatas, goaltablecode);
        } else {//新增
            if ("program".equals(bustype) || "protrace".equals(bustype)) {
                editinfo.put("pro_code", procode);
                editinfo.put("pro_name", pro_name);
            }
            if (!StringUtil.isNullOrEmpty(agency_name)) {
                editinfo.put("agency_name", agency_name);
            }
            editinfo.put("guid", this.getCreateguid());
            editinfo.put("agencyguid", saveAgency);
            editinfo.put("pro_code", procode);
            editinfo.put("pro_name", pro_name);
            editinfo.put("yearflag", "0");
            editinfo.put("is_last_inst", 2);
            editinfo.put("kpi_target", StringUtil.isNullOrEmpty(editinfo.get("kpi_target")) ? "无目标" : editinfo.get("kpi_target"));
            editinfo.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            editinfo.put("queryYear", queryYear);
            editinfo.put("queryProvince", queryProvince);
            this.getBasMap(editinfo, "add");
            adjustGoalDAO.save(editinfo, goaltablecode);
            adjustdatas = new ArrayList<>();
            adjustdatas.add(editinfo);
        }
        return this.auditdefine(adjustdatas, busguid,"perf", null);
    }

    /**
     * 获取项目名称和单位名称
     * @param params
     */
    public void setProAgencyName(Map<String, Object> params){
        String procode = (String) params.get("procode"); //项目编码
        String pro_name = (String) params.get("pro_name");//项目名称
        if (!StringUtil.isEmpty(procode) && StringUtil.isEmpty(pro_name)) {
            String wheresql = "t.pro_code = '" + procode + "'";
            Map<String, Object> proMap = adjustGoalDAO.getDataMap(adjustGoalDAO.PMKPI_TABLE_PROJECT_INFO, wheresql);
            if (!proMap.isEmpty()) {
                pro_name = (String) proMap.get("pro_name");
                String saveAgency = (String) proMap.get("agency_code");
                String agency_name = (String) proMap.get("agency_name");
                params.put("pro_name", pro_name);
                params.put("agency_name", agency_name);
                params.put("saveAgency", saveAgency);
            }
        }
    }

    /**
     * 查询目标数据.
     * @param params -- 参数。
     * @return
     * @throws AppException -- 自定义异常
     */
    public Map<String, Object> getGoalList(HashMap<String, Object> params) throws AppException {
        Map backMap = new HashMap(); //返回消息
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String) params.get("tablesql");
        String proguid = (String) params.get("proguid");
        String mainguid = (String)params.get("mainguid"); //主键
        //调整-绩效目标列表页签 先查调整目标表
        StringBuffer sql = new StringBuffer(" t.mainguid = '" + mainguid + "'");
        List<Map<String,Object>> list = adjustGoalDAO.getDatas(tablecode,sql.toString(),null);
        if (list.size() <= 0){
            //没有数据查询申报目标主表
            sql = new StringBuffer(" t.mainguid = '" + proguid + "'");
            list = adjustGoalDAO.getDatas(AdjustGoalDAO.TABLE_GOAL,sql.toString(),null);
        }
        if(list !=null && list.size()>0){
            for(int i=0;i<list.size();i++) {
                Map<String,Object> map = list.get(i);
                if(map.get("adjustndgoal") == null){
                    map.put("adjustndgoal",map.get("kpi_target"));
                }
            }
        }
        backMap.put("data", list);
        return backMap;
    }


    /**
     * 保存目标数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> saveGoalList(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String mainguid = (String) params.get("mainguid");
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String agency_name = (String) params.get("agency_name");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        int i = 1;
        for (Map<String, Object> map : datas) {
            map.put("guid", StringUtil.createUUID());
            map.put("ordernum", i++);
            map.put("mainguid", mainguid);
            map.put("proguid", proguid);
            map.put("agencyguid", saveAgency);
            map.put("agency_name", agency_name);
            map.put("dept_code", saveAgency.substring(0,3));
            map.put("is_last_inst", 2);
            map.put("yearflag", "0");
            map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_TZRCDTWH);
            if(StringUtil.isNullOrEmpty(map.get("kpi_target"))){
                map.put("kpi_target", "无目标");
            }
            this.getBasMap(map, "add");
        }
        String delsql = " mainguid='" + mainguid + "'";
        adjustGoalDAO.delDatas(DtPerfAdjDAO.BGT_TABLE_GOAL, delsql);
        adjustGoalDAO.saveAll(datas, DtPerfAdjDAO.BGT_TABLE_GOAL);
        return auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 复制上年目标.
     * @param params --
     * @return --
     */
    public Map<String, Object> copyGoal(Map<String, Object> params) throws AppException {
        String procode = (String) params.get("procode");
        String mainguid = (String) params.get("mainguid");
        String queryYear = (String) params.get("queryYear");
        String queryProvince = (String) params.get("queryProvince");
        if (!StringUtil.isNullOrEmpty(queryYear) && !StringUtil.isNullOrEmpty(queryProvince)) {
            this.setYearAndProvince(queryYear, queryProvince);
        }
        Integer year = Integer.parseInt(StringUtil.isNullOrEmpty(queryYear) ? CommonUtil.getYear() : queryYear) -1;
        Map<String, Object> backMap = new HashMap();
        String wheresql = " pro_code = ? and t.yearflag='0' and is_deleted = 2 and is_backup = 2 and t.year = ? and sub_mof_div_code is null ";
        if (PerfUtil.getProgramIsyear()) {
            wheresql += " and nvl(is_adj, 2) = 2";
        }
        Map<String, Object> map = adjustGoalDAO.getDataMap(PerfConstant.PMKPI_BACKUP_GOAL_INFO, wheresql, new String[]{procode, String.valueOf(year)});
        Map<String, Object> maps = adjustGoalDAO.getDataMap(PerfConstant.PMKPI_BACKUP_GOAL_INFO, wheresql, new String[]{procode, CommonUtil.getYear()});
        Map<String, Object> goalMap = adjustGoalDAO.getDataMap("v_perf_t_adjustgoal", " mainguid='" + mainguid + "'");
        if (!map.isEmpty() && !goalMap.isEmpty()) {
            maps = goalMap;
            maps.put("adjustndgoal",map.get("kpi_target"));
        } else if (!map.isEmpty() && !maps.isEmpty()) {
            maps.put("adjustndgoal",map.get("kpi_target"));
        } else if (!map.isEmpty()) {
            maps = map;
            String guid = CommonUtil.createGUID();
            maps.put("guid",guid);
            maps.put("kpi_per_id",guid);
            maps.put("fiscal_year", StringUtil.isNullOrEmpty(queryYear) ? CommonUtil.getYear() : queryYear);
            maps.put("year", StringUtil.isNullOrEmpty(queryYear) ? CommonUtil.getYear() : queryYear);
            maps.put("adjustndgoal",map.get("kpi_target"));
        }
        if (!StringUtil.isEmpty((String) maps.get("adjustndgoal"))) {
            backMap.put("success",true);
            backMap.put("data", maps);
        } else {
            backMap.put("success",false);
            backMap.put("error","该项目上年绩效目标值不存在!");
        }
        return backMap;
    }
}
