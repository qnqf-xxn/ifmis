package gov.mof.fasp2.pmkpi.setting.index;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 21:14 2020/8/17  chongdayong
 */
public class IndexEditService extends PmkpiService {
    private IndexBO indexBO;

    public void setIndexBO(IndexBO indexBO) {
        this.indexBO = indexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String treeid = request.getParameter("treeid");
        String indextype = request.getParameter("indextype");
        String tablecode = request.getParameter("tablecode");
        String pagetype = request.getParameter("pagetype");
        String guid = request.getParameter("guid");
        config.put("treeid", treeid);
        config.put("indextype", indextype);
        config.put("tablecode", tablecode);
        config.put("pagetype", pagetype);
        config.put("framedata", this.getFrame(indextype));
        config.put("guid", guid);
        if (pagetype != null && "mod".equals(pagetype)) {
            config.put("indexdata", indexBO.getDataByGuid(config));
        }
        config.put("isSX", PerfUtil.getIsSx());
        return config;
    }

    /**
     * 显示不同的层次分类
     */
    public List<Map<String, Object>> getFrame(String frametype) {
        return indexBO.getFrame(frametype);
    }

    /**
     * 保存指标数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        try {
            indexBO.save(params);
            backMap.put("success", true);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
}
