package gov.mof.fasp2.pmkpi.perfself.opinion;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfcommon.filelist.UploadFileBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

public class SelfOpinionService extends PmkpiService {
    private SelfOpinionBO selfOpinionBO;

    public void setSelfOpinionBO(SelfOpinionBO selfOpinionBO) {
        this.selfOpinionBO = selfOpinionBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String bustype = request.getParameter("bustype");
        String viewtype = request.getParameter("viewtype");
        String busguid = request.getParameter("busguid");
        String wfstatus = request.getParameter("wfstatus");
        String pagetype = request.getParameter("pagetype");
        config.put("mainguid", mainguid);
        config.put("bustype", bustype);
        config.put("viewtype", viewtype); //查询还是编辑
        config.put("busguid", busguid);
        config.put("pagetype", pagetype); //页面类型：查询、审核
        UploadFileBO uploadFileBO = (UploadFileBO) PerfServiceFactory.getBean("pmkpi.perfcommon.UploadFileBOTX");
        HashMap<String, Object> params = new HashMap<>();
        params.put("filebustype", "perfselfopinion");
        params.put("mainguid", mainguid);
        List<Map<String, Object>> filedatas = uploadFileBO.queryFiletype(params);
        config.put("filedatas", filedatas);
//        //评审意见编辑区配置
//        String str = PerfUtil.getSystemSet("PERFSELFOPINION");
//        Map<String, Object> mm = PerfUtil.parseString2Map(str);
//        String isedit = mm.get("isedit") == null ? "" : (String) mm.get("isedit");
//        String[] edit = isedit.split(",");
//        if (Arrays.asList(edit).contains(wfstatus)) {
//            config.put("issave", "true");
//        }
        //评审意见编辑区配置
        String str = PerfUtil.getSystemSet("PERFSELFOPINION");
        Map<String, Object> mm = PerfUtil.parseString2Map(str);
        String isedit = mm.get("isedit") == null ? "" : (String) mm.get("isedit");
        String[] editrole = isedit.split(",");
        UserDTO user = SecureUtil.getCurrentUser();
        List roles = (List) user.get("roles");
        if (!Collections.disjoint(roles, Arrays.asList(editrole))) {
            config.put("issave", "true");
        }
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = selfOpinionBO.getData(parms);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) {
        Map<String, Object> backmap = new HashMap<String, Object>();
        try {
            backmap = selfOpinionBO.save(parms);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backmap;
    }
}
