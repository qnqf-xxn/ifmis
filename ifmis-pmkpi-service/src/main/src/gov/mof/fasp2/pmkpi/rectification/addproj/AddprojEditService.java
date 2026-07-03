package gov.mof.fasp2.pmkpi.rectification.addproj;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


public class AddprojEditService extends PmkpiService {
    private AddprojBO addprojBO;

    public void setAddprojBO(AddprojBO addprojBO) {
        this.addprojBO = addprojBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String workflow = request.getParameter("workflow");
        String mainguid = request.getParameter("mainguid");
        String guid = request.getParameter("guid");
        String viewtype = request.getParameter("viewtype");
        String isedit = request.getParameter("isedit");
        String projguid = request.getParameter("projguid");
        String pro_code = request.getParameter("pro_code");//项目编码
        String bustype = request.getParameter("bustype");
        String rectifyType = request.getParameter("rectifyType");
        String menuid = request.getParameter("menuid");
        String treeid = request.getParameter("treeid");
        String rectype = request.getParameter("rectype");
        String superguid = request.getParameter("superguid");
        String taskguid = request.getParameter("taskguid");
        String taskstage = request.getParameter("taskstage");
        String isfinadd = request.getParameter("isfinadd");  //是否财政评价新增项目
        config.put("rectifys", request.getParameter("rectifys"));
        config.put("treeid", treeid);
        config.put("bustype", bustype);
        config.put("guid", guid);
        config.put("isfinadd", isfinadd);
        config.put("mainguid", mainguid);
        config.put("projguid", projguid);
        config.put("pro_code", pro_code);
        config.put("menuid", menuid);
        config.put("viewtype", viewtype);
        config.put("rectifyType", rectifyType);
        config.put("workflow",workflow);
        config.put("superguid",superguid);
        config.put("isedit", isedit);
        if (rectype != null || rectype ==""){
            config.put("rectype", rectype);
        }else{
            config.put("rectype", superguid);
            if ("00".equals(superguid) && superguid != null) {
                config.put("rectype", treeid);
            }
        }
        config.put("taskguid",taskguid);   //监控任务guid
        config.put("taskstage",taskstage);  //监控任务阶段
        config.put("finmainguid", request.getParameter("finmainguid"));
        return config;
    }
    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return addprojBO.getData(parms);
    }

    /**
     * 编辑区查询
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        return addprojBO.editquery(params);
    }

}
