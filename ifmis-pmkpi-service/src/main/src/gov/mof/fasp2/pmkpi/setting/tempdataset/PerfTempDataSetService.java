package gov.mof.fasp2.pmkpi.setting.tempdataset;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;


public class PerfTempDataSetService extends PmkpiService {

    private PerfTempDataSetBO perfTempDataBO;

    public void setPerfTempDataBO(PerfTempDataSetBO perfTempDataBO) {
        this.perfTempDataBO = perfTempDataBO;
    }

    //评价模板表
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String tokenid = request.getParameter("tokenid");// 登录凭证
        String tabcode = request.getParameter("tabcode");
        config.put("tokenid", tokenid);
        config.put("tabcode", tabcode);
        return config;
    }

    /**
     * 保存.
     * @param parms --
     * @return --
     */
    public Map<String, Object> save(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            perfTempDataBO.save(parms);
            rs.put("success", true);
            rs.put("code","保存成功！");
        } catch (PerfAppException e) {
            rs.put("success", "false");
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * .复制上年数据
     * @param parms --
     * @return --
     */
    public Map<String, Object> copyIndex(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        try {
            perfTempDataBO.copyIndex(parms);
            backMap.put("success", true);
            backMap.put("code","复制成功！");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
    /**
     * 以区划，年度，guid为主键的增删改
     * @param params
     * @return
     */
    public Map<String, Object> savemajorkey(Map<String, Object> params){
        Map<String, Object> remp = new HashMap<String, Object>();
        try{
            perfTempDataBO.savemajorkey(params);
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
     * 左侧树初始化分区
     * @param params
     * @return
     * @throws Exception
     */
    public Map<String, Object> initleftset(HashMap<String, Object> params) {
        Map<String, Object> remp = new HashMap<String, Object>();
        Boolean result  = null;
        try{
            result =  perfTempDataBO.initleftset(params);
        }catch (Exception e){
            result = false;
        }

        remp.put("success", result);
        remp.put("msg","初始化");
        return remp;
    }
    /**
     * 查询数据.
     * @param params
     * @return
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params){
        return perfTempDataBO.getDatas(params);
    }


    /**
     * .复制本区划数据到其他区划
     * @param parms --
     * @return --
     */
    public Map<String, Object> copyDatas(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        Boolean result  = null;
        try {
            result = perfTempDataBO.copyDatas(parms);
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        backMap.put("success", result);
        backMap.put("msg","复制");
        return backMap;
    }

}
