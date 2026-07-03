package gov.mof.fasp2.pmkpi.perfcommon.filelist;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.util.GlobalConfig;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiPage;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Map;

public class UploadFilePage extends PmkpiPage {

    public Map index(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        String viewtype = request.getParameter("viewtype");
        String bustype = request.getParameter("bustype");
        String mainguid = request.getParameter("mainguid");
        String filebustype = request.getParameter("filebustype");
        String subprovince = request.getParameter("subprovince");
        String systemStyle = GlobalConfig.getConfigData("SYSTEM_STYLE");
        request.setAttribute("SYSTEM_STYLE", systemStyle);
        config.put("viewtype", viewtype);
        config.put("bustype", bustype);
        config.put("mainguid", mainguid);
        config.put("filebustype",filebustype);
        config.put("subprovince",subprovince);
        //evaluatereport:事前绩效评估附件页面  findeptevaproresult:部门评价成果申报-【评价成果上传】-评价成果(处室)页面
        if ("evaluatereport".equals(filebustype) || "findeptevaproresult".equals(filebustype)){
            String str = PerfUtil.getSystemSet("EVALUATIONFILE");
            if("findeptevaproresult".equals(filebustype)){
                str = PerfUtil.getSystemSet("DEPTEVALUATIONFILE");
            }
            Map<String, Object> mm = PerfUtil.parseString2Map(str);
            String isedit = mm.get("isedit") == null ? "" : (String) mm.get("isedit");
            String[] editrole = isedit.split(",");
            UserDTO user = SecureUtil.getCurrentUser();
            List roles = (List) user.get("roles");
            if (!Collections.disjoint(roles, Arrays.asList(editrole))) {
                config.put("viewtype", "mod"); //页面可编辑
            }else if("findeptevaproresult".equals(filebustype)){
                config.put("viewtype", "query"); //页面不可编辑
            }
        }
        String taskyear = request.getParameter("taskyear");
        String taskprovince = request.getParameter("taskprovince");
        config.put("taskyear", taskyear);
        config.put("taskprovince", taskprovince);
        return config;
    }
}
