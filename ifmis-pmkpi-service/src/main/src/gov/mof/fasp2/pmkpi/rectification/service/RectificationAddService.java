package gov.mof.fasp2.pmkpi.rectification.service;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmDAO;
import gov.mof.fasp2.pmkpi.rectification.bo.RectificationAddBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

public class RectificationAddService   extends PmkpiService {
    private RectificationAddBO rectificationAddBO;


    public void setRectificationAddBO(RectificationAddBO rectificationAddBO) {
        this.rectificationAddBO = rectificationAddBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String proguid = request.getParameter("projguid");
        String pro_code = request.getParameter("pro_code");  //项目编码
        String bustype = request.getParameter("bustype");
        String type = request.getParameter("rectifyType");
        String mainguid = request.getParameter("mainguid");
        String proworkflow = request.getParameter("proworkflow");
        String deptworkflow = request.getParameter("deptworkflow");
        String isfinadd = request.getParameter("isfinadd");  //是否财政评价新增项目
        String taskstage = request.getParameter("taskstage");
        String tablecode = "";
        String name = "";
        String agency = "";
        String workflow ="";
        if(bustype != null && "1".equals(bustype)){
            tablecode = "V_PERF_PROJECT_INFO";
            name = "pro_name";
            agency = "agency_code";
            workflow = proworkflow;
            if ("1".equals(isfinadd)){  //查询财政评价主表
                name = "name";
                agency = "agencyguid";
                tablecode = ProConfirmDAO.PERF_TABLE_PROCONFIRM;
            }
        }else if(bustype != null && "3".equals(bustype)){
            tablecode = "V_PERF_T_DEPTPERFDECLARE";
            name = "name";
            agency = "agencyguid";
            workflow = deptworkflow;
        }
        String queryYear = (String) config.get("queryYear");//跨年查询查询年度
        String queryProvince = (String) config.get("queryProvince");//跨年查询查询区划
        Map<String, Object> params = new HashMap<>();
        params.put("tablecode", tablecode);
        params.put("pro_code", pro_code);
        params.put("proguid", proguid);
        params.put("bustype", bustype);
        params.put("queryYear", queryYear);
        params.put("queryProvince", queryProvince);
        Map<String,Object> promap = rectificationAddBO.getProjInfo(params);
        if (!promap.isEmpty()) {
            String proname = (String)promap.get(name);
            String agencyguid = (String)promap.get(agency);
            params.put("proname", proname);
            params.put("agencyguid", agencyguid);
            params.put("taskstage", taskstage);
            config.put("rectifyinfo", rectificationAddBO.getRecityContent(params));
        }
        String datas = request.getParameter("datas");
        config.put("datas",datas);
        config.put("rectification", agency);
        config.put("bustype",bustype);
        config.put("type", type);
        config.put("proguid", proguid);
        config.put("pro_code", pro_code);
        config.put("mainguid",mainguid);
        /*if ("FINEVALUATION".equals(type)){ //财政重点评价
            Map projMap = getFinevaluation(projguid);
            projname =(String)projMap.get("pro_name");
            config.put("rectification", projMap);
            config.put("rectifyinfo", rectificationAddBO.getRecityContent(projname,agency));
        }
       if(projcode!=null && !projcode.equals("")){
           Map projInfo = getProjInfo(projcode);
           projname =(String)projInfo.get("pro_name");
           config.put("rectification", projInfo);
           config.put("rectifyinfo", rectificationAddBO.getRecityContent(projname,agency));
       }*/
        //config.put("projname", projname);
        config.put("workflow",workflow);
        return config;

    }

    /**
     * 获取财政重点评价项目信息
     * @return
     */
    public Map getFinevaluation(String projguid){
        return rectificationAddBO.getFinevaluation(projguid);
    }

    public Map save(HashMap config) throws AppException, ParseException {
        return rectificationAddBO.save(config);
    }

    public Map getText(Map config) throws AppException{
        Map configMap = rectificationAddBO.getText(config);
        return configMap;
    }

}
