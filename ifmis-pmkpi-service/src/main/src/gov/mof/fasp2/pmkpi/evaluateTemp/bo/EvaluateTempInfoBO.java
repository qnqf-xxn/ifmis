package gov.mof.fasp2.pmkpi.evaluateTemp.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluateTemp.dao.EvaluateTempDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluateTempInfoBO extends PmkpiBO  {

    private EvaluateTempDAO evaluateTempDAO;

    public void setEvaluateTempDAO(EvaluateTempDAO evaluateTempDAO) {
        this.evaluateTempDAO = evaluateTempDAO;
    }
    //评价模板表
    private final String tablecode = "V_PERF_T_RANDOMQUALITY";


    /**
     * 查询数据方法
     * @param parms --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String,Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) parms.get("mainguid");
        List<Map<String, Object>> data = evaluateTempDAO.dataByMainGuid(mainguid);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 评价模板新增(一级)
     * @param config --
     * @return
     * @throws AppException
     */
    public Map infosave(HashMap config) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        String mainguid = (String) config.get("mainguid");
        String guid = (String) config.get("guid");
        String busguid = (String) config.get("busguid");
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        if(!StringUtils.isEmpty(mainguid)){
            if (!StringUtils.isEmpty(guid)) {
                List<Map> datas = evaluateTempDAO.getDataByMainguid(tablecode, mainguid, guid);
                Map map = null;
                if (datas != null && datas.size() > 0) { //编辑
                    map = datas.get(0);
                    map.putAll(config);
                    map.put("updatetime", StringUtil.getSysDBDate());
                    config.put("updateuid", user.getGuid());
                    config.put("updateuname", user.getName());
                    evaluateTempDAO.update(map, tablecode);
                    addlist.add(map);
                } else {//新增
                    config.put("createtime", StringUtil.getSysDBDate());
                    config.put("updatetime", StringUtil.getSysDBDate());
                    config.put("guid", StringUtil.createUUID());
                    config.put("createuid", user.getGuid());
                    config.put("createuname", user.getName());
                    config.put("levelno", "1");
                    config.put("isleaf", "0");
                    config.put("province", CommonUtil.getProvince());
                    config.put("year", CommonUtil.getYear());
                    config.put("status", 1);
                    config.put("delstatus", "0");
                    evaluateTempDAO.save(config, tablecode);
                    backMap.put("success", true);
                    addlist.add(config);
                }
            }
        }
        return this.auditdefine(addlist, busguid,"perf", null);
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(evaluateTempDAO.PERF_TABLE_EVALTEMPINFO);
        }
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            map.put("ordernum", i++);
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                Map object = getByGuid(tablecode, (String) map.get("guid"));
                if (object.size() <= 0){
                    addlist.add(map);
                }
            } else {
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            evaluateTempDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            evaluateTempDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            evaluateTempDAO.saveAll(deldatas, evaluateTempDAO.PERF_TABLE_EVALTEMPINFO);
            String delsql = " exists(select 1 from " + evaluateTempDAO.PERF_TABLE_EVALTEMPINFO + " a where a.guid=t.guid)";
            evaluateTempDAO.delDatas(tablecode, delsql);
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }

}
