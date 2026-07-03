package gov.mof.fasp2.pmkpi.perfpromod.info;

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
 * @Revision 17:42 2020/9/9  chongdayong
 */
public class ProModInfoService extends PmkpiService {
    
    private ProModInfoBO proModInfoBO;

    public void setProModInfoBO(ProModInfoBO proModInfoBO) {
        this.proModInfoBO = proModInfoBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev"); //项目一二三级
        String mainguid = request.getParameter("mainguid"); //主键
        String proguid = request.getParameter("projguid"); //调整项目guid
        String viewtype = request.getParameter("viewtype"); //页面状态，修改/查看
        String busguid = request.getParameter("busguid"); //审核定义的guid
        config.put("prolev",prolev);
        config.put("mainguid",mainguid);
        config.put("proguid",proguid);
        config.put("viewtype",viewtype);
        config.put("busguid",busguid);
        config.put("programinfo", proModInfoBO.getProgramInfo(proguid, prolev));
        return config;
    }

    /**
     * 获取调整/监审基本信息
     * @return*/

    public Map<String, Object> getAdjustinfo(HashMap<String, Object> params){
        return proModInfoBO.getAdjustinfo(params);
    }

    /**
     * 保存
     * @param params
     * @return*/

    public Map<String, Object> save(HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = proModInfoBO.save(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
