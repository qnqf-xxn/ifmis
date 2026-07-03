package gov.mof.fasp2.pmkpi.setting.casepage.info;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class CaseInfoService extends PmkpiService {
    private CaseInfoBO caseInfoBO;

    public void setCaseInfoBO(CaseInfoBO caseInfoBO) {
        this.caseInfoBO = caseInfoBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid"); //主键
        String viewtype = request.getParameter("viewtype"); //页面状态，修改/查看
        String busguid = request.getParameter("busguid"); //审核定义的guid
        String workflow = request.getParameter("workflow"); //审核定义的guid
        String bustype = request.getParameter("bustype");
        String finintorgguid = request.getParameter("finintorgguid");
        String saveAgency = request.getParameter("saveAgency");
        String casetype = request.getParameter("nodeguid");//案例类型
        config.put("mainguid",mainguid);
        config.put("viewtype",viewtype);
        config.put("busguid",busguid);
        config.put("workflow",workflow);
        config.put("bustype", bustype);
        config.put("finintorgguid", finintorgguid);
        config.put("saveAgency", saveAgency);
        config.put("casetype", casetype);
        return config;
    }

    /**
     * 获取主单基本信息
     * @return
     */
    public Map<String, Object> getMaininfo(HashMap<String, Object> params){
        return caseInfoBO.getMaininfo(params);
    }

    /**
     * 保存
     * @param params
     * @return
     */
    public Map<String, Object> save(HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = caseInfoBO.save(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            rs.put("msg", e.getMessageNoCode().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
