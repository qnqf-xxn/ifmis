package gov.mof.fasp2.pmkpi.perfprotrace.info;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class ProTraceInfoProService extends PmkpiService {
    private ProTraceInfoProBO proTraceInfoProBO;

    public void setProTraceInfoProBO(ProTraceInfoProBO proTraceInfoProBO) {
        this.proTraceInfoProBO = proTraceInfoProBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev"); //项目一二三级
        String mainguid = request.getParameter("mainguid"); //主键
        String proguid = request.getParameter("projguid"); //调整项目guid
        String viewtype = request.getParameter("viewtype"); //页面状态，修改/查看
        String busguid = request.getParameter("busguid"); //审核定义的guid
        String workflow = request.getParameter("workflow"); //审核定义的guid
        String procode = request.getParameter("procode");
        String bustype = request.getParameter("bustype");
        config.put("prolev",prolev);
        config.put("mainguid",mainguid);
        config.put("proguid",proguid);
        config.put("viewtype",viewtype);
        config.put("busguid",busguid);
        config.put("workflow",workflow);
        config.put("procode", procode);
        config.put("bustype", bustype);

        HashMap<String, Object> params = new HashMap<>();
        params.put("mainguid",mainguid);
        params.put("queryYear", request.getParameter("queryYear"));//跨年查询查询年度
        params.put("queryProvince", request.getParameter("queryProvince"));//跨年查询查询区划
        //查监控流程信息
        Map<String, Object> traceInfo = proTraceInfoProBO.getTraceinfo(params);
        //查项目/部门整体基本信息
        params.put("proguid",proguid);
        params.put("procode", procode);
        params.put("bustype", bustype);
        Map<String, Object> infoMap = proTraceInfoProBO.getEditInfo(params);
        if (!traceInfo.isEmpty()) {
            config.put("traceInfo", traceInfo);
            infoMap.put("fillman", traceInfo.get("fillman"));
            infoMap.put("fillcontacttype", traceInfo.get("fillcontacttype"));
        }
        config.put("infoMap", infoMap);
        return config;
    }

    /**
     * 保存
     * @param params
     * @return
     */
    public Map<String, Object> save(HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = proTraceInfoProBO.save(params);
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
