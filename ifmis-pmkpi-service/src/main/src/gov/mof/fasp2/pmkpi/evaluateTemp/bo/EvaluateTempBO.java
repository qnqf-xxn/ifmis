package gov.mof.fasp2.pmkpi.evaluateTemp.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluateTemp.dao.EvaluateTempDAO;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluateTempBO extends PmkpiBO  {

    private EvaluateTempDAO evaluateTempDAO;

    public void setEvaluateTempDAO(EvaluateTempDAO evaluateTempDAO) {
        this.evaluateTempDAO = evaluateTempDAO;
    }
    //评价类型表
    private final String tablecode = "PERF_T_RANDOMQUALITY_TYPE";
    //评价模板表
    private final String evalTempTable = "PERF_T_RANDOMQUALITY";
    //评价模板菜单关联表
    private final String evalTempMenuTable = "PERF_T_RANDOMQUALITY_MENU";
    //评价类型临时表
    public static final String PERF_TABLE_EVALUATETEMP = "PERF_TMP_EVALUATETEMP";
    //评价类型临时表
    public static final String PERF_TABLE_EVALUATETEMPMENU = "PERF_TMP_EVALUATETEMPMENU";

    /**
     * 查询数据方法
     * @param parms --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String,Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> data = evaluateTempDAO.getData(parms);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 基础信息修改
     * @param config --
     * @return
     * @throws AppException
     */
    public Map infosave(HashMap config) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        String mainguid = (String) config.get("mainguid");
        String busguid = (String) config.get("busguid");
        String menuid = (String) config.get("menuid");
        String code = (String) config.get("code");
        String bustype = (String) config.get("bustype");
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        if(null != mainguid && !"".equals(mainguid)){
            List<Map> datas = evaluateTempDAO.getByGuid(tablecode,mainguid);
            Map map = null;
            if (datas != null && datas.size() > 0) { //编辑
                map = datas.get(0);
                map.putAll(config);
                map.put("updatetime", StringUtil.getSysDBDate());
                map.remove("menuid");
                evaluateTempDAO.updateData(map, tablecode);
                addlist.add(map);
            }else{//新增
                config.put("createtime", StringUtil.getSysDBDate());
                config.put("updatetime", StringUtil.getSysDBDate());
                config.put("guid", mainguid);
                config.put("creater", user.getGuid());
                config.put("province", CommonUtil.getProvince());
                config.put("year", CommonUtil.getYear());
                config.put("status", 1);
                config.put("delstatus", 0);
                evaluateTempDAO.saveData(config, tablecode);
                backMap.put("success", true);
                addlist.add(config);
            }
            //保存评价模板与菜单关系
            if(!StringUtils.isEmpty(code) || !StringUtils.isEmpty(menuid) || !StringUtils.isEmpty(bustype)){
                this.saveEvalTempMenu(code,menuid,bustype);
            }
        }
        return this.auditdefine(addlist, busguid,"perf", null);
    }

    /**
     * 删除数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> deldatas(HashMap<String, Object> params)  throws AppException{
        //需要删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        try{
            if (deldatas.size() > 0) {
                evaluateTempDAO.saveAll(deldatas, PERF_TABLE_EVALUATETEMP);
                //删除评价类型数据
                String delsql = " exists(select 1 from " + PERF_TABLE_EVALUATETEMP + " a where a.guid=t.guid)";
                evaluateTempDAO.delDatas(tablecode, delsql);
                //关联删除评价模板表数据
                String delTempsql = " exists(select 1 from " + PERF_TABLE_EVALUATETEMP + " a where a.guid=t.mainguid)";
                evaluateTempDAO.delDatas(evalTempTable, delTempsql);
                //关联删除模板菜单关系
                String delTempMenu = " exists(select 1 from " + PERF_TABLE_EVALUATETEMP + " a where a.code=t.code)";
                evaluateTempDAO.delDatas(evalTempMenuTable, delTempMenu);
            }
        }catch(Exception e){
            logger.error(e.getMessage(), e);
            params.put("error", "删除报错，操作0行数据！");
        }

        return params;
    }

    /**
     * 保存评价模板与菜单关系
     * @param code
     * @param menuid
     * @param bustype
     * @throws AppException
     */
    public void saveEvalTempMenu(String code,String menuid,String bustype)  throws AppException{
        if (null != code && !"".equals(code)){
            //删除模板和菜单的关系
            this.delTempMenu(code);
            String[] menuids = menuid.split(",");
            for (int i = 0, length = menuids.length; i < length; i++) {
                Map<String, Object> evalTempMenu = new HashMap<String, Object>();
                evalTempMenu.put("guid",StringUtil.createUUID());
                evalTempMenu.put("code",code);
                evalTempMenu.put("menuid",menuids[i]);
                evalTempMenu.put("bustype",bustype);
                evalTempMenu.put("province", CommonUtil.getProvince());
                evalTempMenu.put("year", CommonUtil.getYear());
                evaluateTempDAO.save(evalTempMenu, evalTempMenuTable);
            }
        }
    }

    /**
     * 删除模板和菜单的关系
     * @param code
     * @throws AppException
     */
    public void delTempMenu(String code)  throws AppException{
        List<Map> menuDatas = this.getDateByCode(code,evalTempMenuTable);
        if(menuDatas != null && menuDatas.size() > 0){
            evaluateTempDAO.saveAll(menuDatas, PERF_TABLE_EVALUATETEMPMENU);
            //删除评价模板及菜单关联数据
            String delsql = " exists(select 1 from " + PERF_TABLE_EVALUATETEMPMENU + " a where a.guid=t.guid)";
            evaluateTempDAO.delDatas(evalTempMenuTable, delsql);
        }
    }

    /**
     * 根据code查询模板和菜单关系
     * @param code
     * @param tablecode
     * @return
     * @throws AppException
     */
    public List<Map> getDateByCode(String code,String tablecode)  throws AppException{
        List<Map> menuDatas = evaluateTempDAO.getDateByCode(code,tablecode);
        return menuDatas;
    }
}
