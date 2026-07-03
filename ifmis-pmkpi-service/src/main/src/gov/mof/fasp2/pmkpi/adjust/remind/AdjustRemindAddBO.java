package gov.mof.fasp2.pmkpi.adjust.remind;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.adjust.report.AdjustReportBO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AdjustRemindAddBO   extends PmkpiBO {
    private AdjustRemindAddDAO adjustRemindAddDAO;

    public void setAdjustRemindAddDAO(AdjustRemindAddDAO adjustRemindAddDAO) {
        this.adjustRemindAddDAO = adjustRemindAddDAO;
    }

    private AdjustReportBO adjustReportBO;

    public AdjustReportBO getAdjustReportBO() {
        if(adjustReportBO == null){
            adjustReportBO = (AdjustReportBO) ServiceFactory.getBean("pmkpi.adjust.report.AdjustReportBOTX");
        }
        return adjustReportBO;
    }

    /**
     * 基础信息修改
     * @param config --
     * @return
     * @throws AppException
     */
    public Map infosave(HashMap config) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        String mainguid = String.valueOf(config.get("mainguid"));
        String proguid = (String) config.get("proguid");
        String s = "select * from PERF_T_ADJUSTREMIND where mainguid = '"+mainguid +"'";
        List<Map> remindinfo = adjustRemindAddDAO.queryForList(s);
        if (remindinfo !=null && remindinfo.size()>0) {
            Map map = remindinfo.get(0);
//            config.put("guid", this.getCreateguid());
            //当前登录用户
            UserDTO user = SecureUtil.getCurrentUser();
            config.put("creater", user.getGuid());
            config.put("province", user.getProvince());
            config.put("year", CommonUtil.getYear());
            map.putAll(config);
            adjustRemindAddDAO.update(map, "PERF_T_ADJUSTREMIND");
        }
        //如果确认调整的话 则组装数据  将数据推送之绩效目标调整填报页面
        String status = (String) config.get("status");
        if (status!=null && !status.isEmpty() && "1".equals(status)){
            String adjustsql = "select * from v_perf_t_adjust t where t.proguid = '"+ proguid +"' and islast = 1";
            List<Map> adjustList = adjustRemindAddDAO.queryForList(adjustsql);
            if (adjustList !=null && adjustList.size()>0){
                Map adjust = adjustList.get(0);
                String wfstatus = String.valueOf(adjust.get("wfstatus"));
                if (wfstatus != null && !wfstatus.isEmpty() && !"011".equals(wfstatus)){
                    backMap.put("success", false);
                    backMap.put("error", "该数据存在调整");
                    return backMap;
                }
            }
            String sql = "select * from V_PERF_PROJECT_INFO where pro_id = '"+proguid +"'";
            List<Map> proinfo = adjustRemindAddDAO.queryForList(sql);
            HashMap<String,Object> params = new HashMap<String,Object>();
            params.put("bustype","program");
            params.put("saveAgency","treeroot");
            params.put("tablecode","V_PERF_PROJECT_INFO");
            params.put("workflow","B9A12B5D94761164E053B11FA8C0460E");
            List list = new ArrayList<>();
            HashMap<String,Object> map = new HashMap<String,Object>();
            map.put("guid",proguid);
            map.put("agencyguid",config.get("agencyguid"));
            map.put("finintorgguid",config.get("finintorgguid"));
            map.put("adjstatus","2");
            map.put("check","1");
            map.put("create_time", PerfUtil.getServerTimeStamp());
            map.put("creater","2");
            map.put("lastupdatetime",PerfUtil.getServerTimeStamp());
            map.put("mof_dep_code",config.get("finintorgguid"));
            map.put("mof_div_code",SecureUtil.getUserSelectProvince());
            if (proinfo !=null && proinfo.size()>0){
                map.put("pro_code",proinfo.get(0).get("pro_code"));
                map.put("pro_name",proinfo.get(0).get("pro_name"));
                map.put("pro_grade",proinfo.get(0).get("pro_grade"));
            }
            map.put("year",CommonUtil.getYear());
            list.add(map);
            params.put("datas",list);
            getAdjustReportBO().saveProgramadjust(params);
        }
        backMap.put("success", true);
        return backMap;
    }
}
