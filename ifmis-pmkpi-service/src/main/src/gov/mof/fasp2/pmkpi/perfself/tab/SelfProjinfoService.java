package gov.mof.fasp2.pmkpi.perfself.tab;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:44 2020/8/24  chongdayong
 */
public class SelfProjinfoService extends PmkpiService {
    private SelfProjinfoBO selfProjinfoBO;

    public void setSelfProjinfoBO(SelfProjinfoBO selfProjinfoBO) {
        this.selfProjinfoBO = selfProjinfoBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String projguid = request.getParameter("projguid");
        config.put("projguid", projguid);
        String saveAgency = request.getParameter("saveAgency");
        config.put("saveAgency", saveAgency);
        String bustype = request.getParameter("bustype");
        config.put("bustype", bustype);
        String mainguid = request.getParameter("mainguid");
        config.put("mainguid", mainguid);
        String workflow = request.getParameter("workflow");
        config.put("workflow", workflow); //工作流
        String viewtype = request.getParameter("viewtype");
        config.put("viewtype", viewtype); //查询还是编辑
        String busguid = request.getParameter("busguid");
        config.put("busguid", busguid);
        String procode = request.getParameter("procode");
        config.put("procode", procode);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return selfProjinfoBO.getData(parms);
    }
    
    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = selfProjinfoBO.save(parms);
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
