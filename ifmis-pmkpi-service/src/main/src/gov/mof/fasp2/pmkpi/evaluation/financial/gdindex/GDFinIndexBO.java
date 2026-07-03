package gov.mof.fasp2.pmkpi.evaluation.financial.gdindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class GDFinIndexBO extends PmkpiBO {
    private GDFinIndexDAO GDFinIndexDAO;

    public void setGDFinIndexDAO(GDFinIndexDAO GDFinIndexDAO) {
        this.GDFinIndexDAO = GDFinIndexDAO;
    }

    /**
     * 查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        String  isZJ = PerfUtil.getSystemSet("isZJ");
        String projguid = (String) params.get("projguid");
        String procode = (String) params.get("procode"); //项目编码
        String mainguid = (String) params.get("mainguid");
        String bustype = (String) params.get("bustype");
        String agencyguid = (String) params.get("agencyguid");
        String viewtype = (String) params.get("viewtype");//查询状态
        String sourcetable = "V_PM_PERF_INDICATOR"; //来源表
        String frametype = "PM001";//体系编码
        String tablecode = (String) params.get("tablecode"); //来源表
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        if ("dept".equals(bustype)) { //部门整体
            sourcetable = "V_BGT_PERF_INDICATOR";
            frametype = "DEPT";
        }
        //查询债券重点明细表
        List<Map<String, Object>> data = GDFinIndexDAO.queryForList("select * from V_GD_PERF_EVAL_DTL where pro_code = '"+procode+"' and  is_deleted = 2 ");
        if(data.size() > 0){
            data = GDFinIndexDAO.queryForList("select * from v_perf_eval_indicator_ind where pro_code = '"+procode+"' ");
        } else {
            data = GDFinIndexDAO.queryForList("select * from v_perf_eval_indicator where pro_code = '"+procode+"' ");
        }
        List<Map<String, Object>> nullTemp = GDFinIndexDAO.getTempdatas(projguid, "PM001"); //空指标模板
        data.addAll(nullTemp);
        yearsMap.put("data", data);
        return yearsMap;
    }

    /**
     * 保存.
     *
     * @param params -- 参数集合.
     * @return -- list.
     */
    public Map<String, Object> saveIndex(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid"); //审核定义
        String saveAgency = (String) params.get("saveAgency");
        String procode = (String) params.get("procode"); //项目code
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> templist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> implist = new ArrayList<Map<String, Object>>();
        Double score = 0.00;
        Integer lenelno = 0;
        String eval_id = this.getCreateguid();
        Map<String, Object> impopMap = new HashMap<>(); // 主表信息
        for (Map<String, Object> map : datas) {
            Map<String, Object> impopsMap = new HashMap<>(); // 附表信息
            lenelno = PerfUtil.mapGetInt(map, "levelno");
            String eval_dtl_id = this.getCreateguid();
            if(3 == lenelno){
                String eval_value = String.valueOf(map.get("eval_value"));
                //String eval_value = (String) map.get("eval_value");
                score += Double.parseDouble(eval_value != null ? eval_value : "0.00");
                impopsMap.put("eval_dtl_id", eval_dtl_id);
                impopsMap.put("guid", eval_dtl_id);
                impopsMap.put("eval_id", eval_id);
                impopsMap.put("kpi_id", map.get("kpi_id"));
                impopsMap.put("pro_code", procode);
                impopsMap.put("fiscal_year", CommonUtil.getYear());
                impopsMap.put("mof_div_code", SecureUtil.getUserSelectProvince());
                impopsMap.put("mof_div_name", CommonUtil.getProvinceNameByCode((String) impopsMap.get("mof_div_code")));
                impopsMap.put("ind_weight", map.get("weight"));
                impopsMap.put("eval_value", map.get("eval_value"));
                impopsMap.put("devi_analy", map.get("devi_analy"));
                impopsMap.put("is_last_inst",1);
                impopsMap.put("is_deleted", 2);
                impopsMap.put("create_time", PerfUtil.getServerTimeStamp());
                impopsMap.put("update_time", PerfUtil.getServerTimeStamp());
                impopsMap.put("year", CommonUtil.getYear());
                impopsMap.put("province", SecureUtil.getUserSelectProvince());
                impopsMap.put("createtime", PerfUtil.getServerTimeStamp());
                impopsMap.put("updatetime", PerfUtil.getServerTimeStamp());
                impopsMap.put("creater", SecureUtil.getCurrentUserID());
                impopsMap.put("wfid", null);
                impopsMap.put("wfstatus", null);
                impopsMap.put("auditor", null);
                impopsMap.put("lastupdatetime", null);
                templist.add(impopsMap);
            }
        }
        Map<String, Object>  propMap = GDFinIndexDAO.queryForMap("select * from v_perf_project_info where pro_code = '"+procode+"' ");
        Map<String, Object>  agenMap = GDFinIndexDAO.queryForMap("select * from fasp_T_pubagency where code = '"+saveAgency+"' ");
        impopMap.put("eval_id", eval_id);
        impopMap.put("guid", eval_id);
        impopMap.put("fiscal_year", CommonUtil.getYear());
        impopMap.put("mof_div_code", SecureUtil.getUserSelectProvince());
        impopMap.put("mof_div_name", CommonUtil.getProvinceNameByCode((String) impopMap.get("mof_div_code")));
        impopMap.put("agency_code", saveAgency);
        impopMap.put("agency_name", agenMap.get("name"));
        impopMap.put("pro_code", procode);
        impopMap.put("pro_name", propMap.get("pro_name"));
        impopMap.put("total_eval_val", score);
        impopMap.put("eval_file", null);
        impopMap.put("file_name", null);
        impopMap.put("full_path", null);
        impopMap.put("is_last_inst",1);
        impopMap.put("is_deleted", 2);
        impopMap.put("create_time", PerfUtil.getServerTimeStamp());
        impopMap.put("update_time", PerfUtil.getServerTimeStamp());
        impopMap.put("year", CommonUtil.getYear());
        impopMap.put("province", SecureUtil.getUserSelectProvince());
        impopMap.put("createtime", PerfUtil.getServerTimeStamp());
        impopMap.put("updatetime", PerfUtil.getServerTimeStamp());
        impopMap.put("creater", SecureUtil.getCurrentUserID());
        impopMap.put("wfid", null);
        impopMap.put("wfstatus", null);
        impopMap.put("auditor", null);
        impopMap.put("lastupdatetime", null);
        implist.add(impopMap);
        // 删除主表信息
        //String wheresql = " set t.is_deleted = 1 where t.pro_code = '"+procode+"'";
        //GDFinIndexDAO.updateDatas("V_GD_PERF_EVAL", wheresql);
        GDFinIndexDAO.delDatas("V_GD_PERF_EVAL"," pro_code = '"+procode+"'");
        GDFinIndexDAO.delDatas("V_GD_PERF_EVAL_DTL"," pro_code = '"+procode+"'");
        //删除附表信息
        //GDFinIndexDAO.updateDatas("V_GD_PERF_EVAL_DTL", wheresql);
        GDFinIndexDAO.saveAll(implist, "V_GD_PERF_EVAL");
        GDFinIndexDAO.saveAll(templist, "V_GD_PERF_EVAL_DTL");
        return this.auditdefine(templist, busguid, "perf", null);
    }

    public String getISGD(String procode) throws AppException {
        String flag = "edit";
        List<Map<String, Object>>  list = GDFinIndexDAO.queryForList("select gd_bond from v_perf_project_info where pro_code= '" + procode + "'");
        if(list.size() >= 0){
            BigDecimal gd_bond = (BigDecimal) list.get(0).get("gd_bond");
            if("2".equals(gd_bond.toString())){
                flag = "query";
            }
        }
        return flag;

    }

}