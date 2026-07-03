package gov.mof.fasp2.pmkpi.setting.impexpsub;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class PerfTImpexpsubService extends PmkpiService {
    private PerfTImpexpsubBO perfTImpexpsubBO;
    public void setPerfTImpexpsubBO(PerfTImpexpsubBO perfTImpexpsubBO) {
        this.perfTImpexpsubBO = perfTImpexpsubBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    /**
     * 以区划，年度，guid为主键的增删改
     * @param params
     * @return
     */
    public Map<String, Object> savemajorkey(Map<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        try{
            perfTImpexpsubBO.savemajorkey(params);
            remp.put("success", true);
        } catch (PerfAppException e){
            remp = e.getRemap();
            remp.put("code", e.getCode());
        } catch(AppException e){
            logger.error(e.getMessage(), e);
        }
        return remp;
    }
    /**
     * 初始化分区
     * @param params
     * @return
     * @throws Exception
     */
    public Map<String, Object> initset(HashMap<String, Object> params){
        Map<String, Object> remp = new HashMap<String, Object>();
        try{
            Boolean result =  perfTImpexpsubBO.initset(params);
            remp.put("success", result);
            remp.put("msg","初始化");
        }catch (AppException e){
            remp.put("success",false);
            remp.put("msg",e.getMessage());
        }

        return remp;
    }

    /**
     * 删除数据
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return perfTImpexpsubBO.delDatas(parms);
    }

    /**
     * 查询当前模板对应的表数据
     * @param parms
     * @return
     */
    public Map<String, Object> getcol(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> remp = new HashMap<String, Object>();
        remp.put("data", perfTImpexpsubBO.getCol(parms));
        return remp;
    }
}
