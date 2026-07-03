package gov.mof.fasp2.pmkpi.setting.indexlib.report;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.annotation.Resource;
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
public class IndexRpEditService extends PmkpiService {
    private IndexRpBO indexRpBO;

    @Resource(name = "pmkpi.setting.indexlib.report.IndexRpBOTx")
    public void setIndexRpBO(IndexRpBO indexRpBO) {
        this.indexRpBO = indexRpBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String treeid = request.getParameter("treeid");
        String indextype = request.getParameter("indextype"); //财政还是部门
        String tabtype = request.getParameter("tabtype");
        String pagetype = request.getParameter("pagetype"); //mod or add
        String viewtype = request.getParameter("viewtype"); //query
        String guid = request.getParameter("guid");
        String superid = request.getParameter("superid"); //父级
        String workflow = request.getParameter("workflow");
        if (tabtype != null && ("INDEXCOMFUNC_ZJ".equals(tabtype) || "INDEXCOMFUNC_HuBei".equals(tabtype))) {//湖北，浙江环境左侧树为项目
            String agency = request.getParameter("agency");//所选项目的agency
            config.put("agency", agency);
        }
        config.put("workflow",workflow);
        config.put("treeid", treeid);
        config.put("indextype", indextype);
        config.put("tabtype", tabtype);
        config.put("pagetype", pagetype);
        config.put("superid", superid);
        config.put("guid", guid);
        config.put("treename", request.getParameter("treename"));
        config.put("viewtype", viewtype);
        if (pagetype != null && "mod".equals(pagetype)) {
            String wheresql = " guid='" + guid + "'";
            Map<String, Object> indexMap = indexRpBO.getDataMap(IndexRpDAO.PMKPI_TABLE_BASE_INDEX, wheresql);
            config.put("indexdata", indexMap);
            String framesystem = (String) indexMap.get("framesystem");
            List<DicRangeDTO> indexframe = PerfUtil.getSourceData("PMKPIINDEXFRAME", "frametype='" + framesystem + "'");
            config.put("indexframe", indexframe);
        }
        config.put("isSX", PerfUtil.getIsSx());
        return config;
    }

    /**
     * 保存指标数据.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<>();
        try {
            indexRpBO.save(params);
            backMap.put("success", true);
        } catch (AppException e) {
            backMap.put("message", e.getMessage().replaceAll("-null", ""));
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
}
