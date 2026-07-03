package gov.mof.fasp2.pmkpi.perfreview.opinion;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class PerfReviewOpinionService extends PmkpiService {
    private PerfReviewOpinionBO perfReviewOpinionBO;

    public void setPerfReviewOpinionBO(PerfReviewOpinionBO perfReviewOpinionBO) {
        this.perfReviewOpinionBO = perfReviewOpinionBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String busguid = request.getParameter("busguid");//审核定义guid
        String showtab = request.getParameter("showtab"); //页签显示 1总+年2总3年
        String mainguid = request.getParameter("mainguid");//主单guid
        String proguid = request.getParameter("proguid");//项目guid
//        String frametype = request.getParameter("frametype");//指标类型
        String bustype = request.getParameter("bustype");
        String procode = request.getParameter("procode");
        config.put("busguid", busguid);
        config.put("showtab", showtab); //指标页签显示
        config.put("mainguid", mainguid);
        config.put("proguid", proguid);
        config.put("bustype", bustype);
        config.put("procode", procode);
        HashMap params = (HashMap) config;
        config.put("datas", this.findAllIndex(params));
        return config;
    }

    /**
     * 查询项目全部的指标数据.
     * @param parms -- 前端参数.
     * @return -- list.
     */
    public Map<String, Object> findAllIndex(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> map = new HashMap<>();
        String mainguid = (String) parms.get("mainguid");
        map.put("indexdata", perfReviewOpinionBO.findAllIndex(parms));
        map.put("editinfo", perfReviewOpinionBO.getOpinionData(mainguid));
        return map;
    }

    /**
     * 触发绩效保存方法.
     * @param params --参数集合
     * @return backmap.
     * @throws AppException -- 自定义异常
     * @throws
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = perfReviewOpinionBO.save(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
