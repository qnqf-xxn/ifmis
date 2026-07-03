package gov.mof.fasp2.pmkpi.perfreview.proindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReviewProindexService extends PmkpiService {

    private ReviewProindexBO reviewProindexBO;

    public void setReviewProindexBO(ReviewProindexBO reviewProindexBO) {
        this.reviewProindexBO = reviewProindexBO;
    }

    /**
     * 初始化页面.
     * <p>Title: loadComponent</p>
     * <p>Description: </p>
     * @param request -- 请求.
     * @param response -- 响应.
     * @param config -- 配置.
     * @return config -- 参数.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws AppException {
        String mainguid = request.getParameter("mainguid");//主单guid
        String proguid = request.getParameter("proguid");//项目guid
        String viewtype = request.getParameter("viewtype");
        String saveAgency = request.getParameter("saveAgency"); //单位
        String busguid = request.getParameter("busguid");//审核定义guid
        String workflow = request.getParameter("workflow");
        String bustype = request.getParameter("bustype");
        String showtab = PerfUtil.getSystemSet("REVIEWSHOWTAB");
        String procode = request.getParameter("procode");
        String reviewnum = request.getParameter("reviewnum");
        //项目指标页展示数据mainguid为空
        if (StringUtil.isEmpty(mainguid)) {
            String wheresql = "";
            if ("program".equals(bustype)) {
                wheresql = " t.islast=1 and t.pro_code='" + procode + "'";
            } else {
                wheresql = " t.islast=1 and t.proguid='" + proguid + "'";
            }
            Map<String, Object> reMap = reviewProindexBO.getDataMap("v_perf_t_review", wheresql);
            mainguid = (String) reMap.get("guid");
        }
        config.put("proguid", proguid);
        config.put("mainguid", mainguid);
        config.put("viewtype", viewtype);
        config.put("saveAgency", saveAgency); //单位
        config.put("reviewdatas", reviewProindexBO.findReview(mainguid));
        config.put("editdatas", reviewProindexBO.findauditmain(mainguid));
        config.put("busguid", busguid);
        config.put("workflow", workflow);
        config.put("reviewnum", reviewnum);
        config.put("showtab",showtab);
        config.put("bustype",bustype);
        config.put("procode", procode);
        return config;
    }

    /**
     * 查询指标.
     * @param params
     * @return
     */
    public List<Map<String, Object>> findIndex(HashMap<String, Object> params){
        return reviewProindexBO.findIndex(params);
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map savedatas(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = reviewProindexBO.savedatas(config);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

}
