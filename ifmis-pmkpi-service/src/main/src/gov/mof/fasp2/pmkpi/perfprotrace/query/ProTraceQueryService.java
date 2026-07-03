package gov.mof.fasp2.pmkpi.perfprotrace.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProTraceQueryService extends PmkpiService {

	private ProTraceQueryBO proTraceQueryBO;

    public void setProTraceQueryBO(ProTraceQueryBO proTraceQueryBO) {
        this.proTraceQueryBO = proTraceQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        logger.info("---绩效监控service查询 start---");
        long st = System.currentTimeMillis();
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev");
        config.put("prolev", prolev);
        String bustype = request.getParameter("bustype");
        String istraceinitiateadjust = PerfUtil.getSystemSet("ISTRACEINITIATEADJUST");//调整是否走工作流
        Map<String, Object> mm = PerfUtil.parseString2Map(istraceinitiateadjust);
        String deptwfststus = (String) mm.get("deptwfststus");
        String jxwfststus = (String) mm.get("jxwfststus");
        config.put("deptwfststus", deptwfststus);
        config.put("jxwfststus", jxwfststus);
        String procode = request.getParameter("procode");
        config.put("procode", procode);
        config.put("bustype", bustype);
        String deptcode = request.getParameter("deptcode");//数据分析大屏跳转-只查询本部门数据
        config.put("deptcode", deptcode);
        long usetime = (System.currentTimeMillis() - st);
        logger.info("绩效监控service查询耗时：" + usetime + "ms");
        logger.info("---绩效监控service查询 end---");
        return config;
    }

    public List<Map<String, Object>> getTreeData (HashMap<String, Object> params) throws AppException {
        return proTraceQueryBO.getTreeData(params);
    }

    /**
     * 判断发起整改的数据表中是否存在
     * @param params
     * @return
     */
    public Integer getDatas(HashMap<String, Object> params){
        return proTraceQueryBO.getDatas(params);
    }

    /**
     * 根据项目编码查询整改主表中的数据(项目第一次发起整改的数据)
     * @param params
     * @return
     */
    public  List<Map<String, Object>> getDataList(HashMap<String, Object> params){
        return proTraceQueryBO.getDataList(params);
    }


    /**
     * 查看监控历史记录.
     * @param parms -- 参数。
     * @return --
     */
    public Map<String, Object> showHisTrace(HashMap<String,Object> parms) throws AppException {
        return proTraceQueryBO.showHisTrace(parms);
    }
}
