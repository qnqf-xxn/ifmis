package gov.mof.fasp2.pmkpi.setting.baseinfo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class BasereviewerService extends PmkpiService {

    private BaseinfoBO baseinfoBO;

    public void setBaseinfoBO(BaseinfoBO baseinfoBO) {
        this.baseinfoBO = baseinfoBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String viewtype = request.getParameter("viewtype");
        String tablecode = request.getParameter("tablecode");
        String type = request.getParameter("type");
        String guid = request.getParameter("guid");
        String mainguid = request.getParameter("mainguid");
        String isSx = request.getParameter("isSx");
        config.put("viewtype", viewtype);
        config.put("tablecode", tablecode);
        config.put("guid", guid);
        config.put("mainguid", mainguid);
        config.put("type", type);
        String uikey = (String) config.get("pageurl"); //获取配置了多少页签
        if(!StringUtil.isEmpty(isSx) &&"isSx".equals(isSx)){
            config.put("isSx","isSx");
        }
        config.put("tabData", baseinfoBO.getTabData(uikey));
        return config;
    }


    /**
     * 列表查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return baseinfoBO.getData(parms);
    }



    /**
     * 保存
     * @param params --
     * @return
     * @throws AppException
     */
    public Map save(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = baseinfoBO.save(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }
}
