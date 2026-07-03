package gov.mof.fasp2.pmkpi.setting.evaluation.editinfo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluationInfoBO extends PmkpiBO {
    private EvaluationInfoDAO evaluationInfoDAO;

    public void setEvaluationInfoDAO (EvaluationInfoDAO evaluationInfoDAO){
        this.evaluationInfoDAO = evaluationInfoDAO;
    }

    /**
     * 查询事前绩效评估信息
     * @param params -- 参数集合.
     * @return datas.
     * @throws -- 异常.
     */
    public Map<String, Object> getDatas(Map<String, Object> params){
        Map<String, Object> backMap = new HashMap<String, Object>();
        String proguid = (String) params.get("proguid"); //项目guid
        String procode = (String) params.get("procode");//项目编码
        String wheresql = "";
        if (PerfUtil.getIsHbei()){
            wheresql = " proguid ='" + proguid + "'";
        }else {
            wheresql = " pro_code ='" + procode + "'";
        }
        Map<String, Object> datas = evaluationInfoDAO.getDataMap("v_perf_t_evaluation",wheresql);
        backMap.put("data",datas);
        return backMap;
    }


    /**
     * 事前绩效评估信息保存
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        String proguid = (String) params.get("projguid");
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String procode = (String) params.get("procode");
        String items = (String) params.get("items");
        String result = (String) params.get("result");
        UserDTO user = SecureUtil.getCurrentUser();
        String guidNew= StringUtil.createUUID();
        Map map = null;
        List<Map<String,Object>> datas = getDatas("v_perf_t_evaluation"," guid = '"+mainguid+"' ",null);
        if (datas != null && datas.size() > 0) {//修改
            map = datas.get(0);
            map.put("items",items);
            map.put("result",result);
            map.put("updateuid", user.getGuid());
            map.put("updateuname", user.getName());
            map.put("updatetime", StringUtil.getSysDBDate());
            evaluationInfoDAO.update(map, "v_perf_t_evaluation");
            backMap.put("datas",datas);
            backMap.put("success", true);
        }
        return backMap;
    }
    public void setData(Map<String, Object> params){
        params.put("creater", SecureUtil.getCurrentUserID());
        params.put("province", SecureUtil.getUserSelectProvince());
        params.put("year", CommonUtil.getYear());
        params.put("createtime", PerfUtil.getServerTimeStamp());
        params.put("kpi_per_id", params.get("guid"));
        params.put("create_time", PerfUtil.getServerTimeStamp());
        params.put("mof_div_code", SecureUtil.getUserSelectProvince());
        params.put("fiscal_year", CommonUtil.getYear());
        this.getBasMap(params, "add");
    }
}
