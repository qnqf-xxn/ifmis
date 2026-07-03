package gov.mof.fasp2.pmkpi.policyapi;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.*;

public class PolicyapiBO extends PmkpiBO {

    private PolicyapiDAO policyapiDAO;

    public void setPolicyapiDAO(PolicyapiDAO policyapiDAO) {
        this.policyapiDAO = policyapiDAO;
    }

    public String getResult(List<String> procodes, String mofdivcode, String fiscalyear, String tabletype) {
        //成功返回0000
        String resultCode = "0000";
        Map<String,Object> resultMap = new HashMap<>();
        List<Map<String,Object>> resultList = new ArrayList<>();
        try{
            //遍历项目code
            List<Map<String,Object>> codeList = new ArrayList<>();
            for (String ss : procodes) {
                Map<String,Object> codeMap = new HashMap<>();
                codeMap.put("guid",ss);
                codeList.add(codeMap);
            }
            //项目code存到临时表中PMKPI_TABLE_TMP_GUIDS
            policyapiDAO.saveAll(codeList, PmkpiDAO.PMKPI_TABLE_TMP_GUIDS);
            //查询条件：关联临时表
            String wheresql = " exists(select a.guid from "+ PmkpiDAO.PMKPI_TABLE_TMP_GUIDS + " a where t.PRO_CODE = a.guid) and t.mof_div_code = "+mofdivcode+" and t.fiscal_year = "+fiscalyear;
            if("pmgoalinfo".equals(tabletype)){
                //获取当前区划年度下的绩效目标
                resultList = policyapiDAO.getDatas("v_pm_perf_goal_info", wheresql, "order by t.PRO_CODE");
            }else if("pmindicator".equals(tabletype)){
                //获取当前区划年度下的绩效指标
                resultList = policyapiDAO.getDatas("v_pm_perf_indicator", wheresql, "order by PRO_CODE");
            }
            resultMap.put("data",resultList);
        }catch (AppException e){
            //失败返回0001,
            resultCode = "0001";
            resultMap.put("reason",e.getMessage());     //错误信息
            logger.error(e.getMessage(), e);
        }
        resultMap.put("result_code",resultCode);    //结果编码
        return createJSONString(resultMap);
    }

    protected String createJSONString(Object obj) {
        net.sf.json.JSONObject jo = net.sf.json.JSONObject.fromObject(obj);
        String json = jo.toString();
        return json;
    }
}
