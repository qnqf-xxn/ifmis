package gov.mof.fasp2.pmkpi.performanceopen.nxreport;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class NXPerfOpenService extends PmkpiService {

    private NXPerfOpenBO nxPerfOpenBO;

    public void setNxPerfOpenBO(NXPerfOpenBO nxPerfOpenBO) {
        this.nxPerfOpenBO = nxPerfOpenBO;
    }

    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menuid = request.getParameter("menuId");
        String dtsql = nxPerfOpenBO.getDataRuleByMenuguidNull(menuid, "t", "1=1");
        List<Map<String, Object>> agencys = PerfUtil.getSourceData("PMKPIDEPT", dtsql);
        List<Map<String, Object>> datas = PerfUtil.getSourceData("PERFOPEN", null);
        List<Map<String, Object>> tempDatas = datas.stream().flatMap(m -> {
            List<Map<String, Object>> result = new ArrayList<>();
            result.add(m); // 添加 m
            String guid = (String) m.get("guid");
            List<Map<String, Object>> list = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(agencys);
            list.forEach(agency -> {
                agency.put("guid", agency.get("guid") + guid);
                agency.put("isleaf", "1");
                agency.put("superguid", guid);
                result.add(agency); // 添加修改后的 agency
            });
            return result.stream();
        }).collect(Collectors.toList());
        config.put("leftdatas", tempDatas);
        config.put("agencys", agencys);
        return config;
    }

    /**
     * 保存
     * @param config
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) throws AppException {
        return nxPerfOpenBO.save(config);
    }

    /**
     * 新增查询
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> getAddData(HashMap params) throws AppException {
        return nxPerfOpenBO.getAddData(params);
    }

}
