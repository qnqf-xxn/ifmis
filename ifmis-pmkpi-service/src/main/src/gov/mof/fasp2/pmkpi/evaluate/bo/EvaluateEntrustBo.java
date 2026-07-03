package gov.mof.fasp2.pmkpi.evaluate.bo;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluate.dao.EvaluateEntrustDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EvaluateEntrustBo extends PmkpiBO {

    private EvaluateEntrustDAO evaluateEntrustDAO;

    public void setEvaluateEntrustDAO(EvaluateEntrustDAO evaluateEntrustDAO) {
        this.evaluateEntrustDAO = evaluateEntrustDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String tablecode = (String)sqlmap.get("tablecode");
        String querySql = (String)sqlmap.get("querySql");
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        if(!StringUtils.isEmpty(querySql)){
            returnsql.append(" where (").append(querySql).append(") ");
        }
        return returnsql.toString();
    }

    /**
     * 查询已选中介；
     * @param params
     * @return
     */
    public List<Map<String,Object>> queryselintermediary (HashMap<String, Object> params){
        String mainguid = (String) params.get("mainguid");
        String wheresql = " t.review = '" + mainguid + "' ";
        return evaluateEntrustDAO.getDatas("v_perf_selintermediary",wheresql,null);
    }

    /**
     * 委托专家保存
     * @param params
     * @return
     */
    public void saveEntrust (HashMap<String, Object> params) throws AppException {
        List<Map<String,Object>> datas = (List<Map<String,Object>>) params.get("datas");//专家数据
        List<Map<String,Object>> prodatas = (List<Map<String,Object>>) params.get("prodatas");//主单数据
        String tablecode = "v_perf_reviewintermediary";
        List<Map<String,Object>> list = new ArrayList<>();
        Map<String,Object> mm = null;
        List<String> mainguids = new ArrayList<>();
        for (Map<String, Object> m : prodatas) {
            String mainguid = (String) m.get("guid");
            for (Map<String, Object> map : datas) {
                mm = new HashMap<>();
                mm.put("guid", this.getCreateguid());
                if (!StringUtil.isEmpty((String) map.get("intermediary"))){
                    mm.put("intermediary", map.get("intermediary"));
                }else{
                    mm.put("intermediary", map.get("guid"));
                }
                mm.put("review", mainguid);
                mm.put("year", SecureUtil.getUserSelectYear());
                mm.put("province", SecureUtil.getUserSelectProvince());
                list.add(mm);
            }
            mainguids.add(mainguid);
        }
        String delsql = evaluateEntrustDAO.createInSql("review", mainguids);
        evaluateEntrustDAO.delDatas(tablecode, delsql);
        evaluateEntrustDAO.saveAll(list,tablecode);
    }

    /**
     * 删除选择专家
     * @param params
     * @return
     */
    public void delEntrust (HashMap<String, Object> params) throws AppException {
        List<Map<String,Object>> datas = (List<Map<String,Object>>) params.get("datas");//已选专家数据
        List<Map<String,Object>> prodatas = (List<Map<String,Object>>) params.get("prodatas");//主单数据
        String tablecode = "v_perf_reviewintermediary";
        List<String> mainguids = new ArrayList<>();
        List<String> guids = new ArrayList<>();
        for (Map<String, Object> m : datas) {
            String guid = (String) m.get("guid");
            guids.add(guid);
        }
        for (Map<String, Object> m : prodatas) {
            String mainguid = (String) m.get("guid");
            mainguids.add(mainguid);
        }
        String delsql = evaluateEntrustDAO.createInSql("review", mainguids) + " and " + evaluateEntrustDAO.createInSql("guid", guids);
        evaluateEntrustDAO.delDatas(tablecode, delsql);
    }

    /**
     * 委托专家审核；
     * @param params
     * @return
     */
    public Map<String,Object> auditEntrust (HashMap<String, Object> params) throws AppException {
        String workflow  = (String) params.get("workflow");
        String busguid  = (String) params.get("busguid");
        String remark  = (String) params.get("remark");
        List<Map<String,Object>> prodatas = (List<Map<String,Object>>) params.get("prodatas");//主单数据
        String maintablecode  = (String) params.get("maintablecode");
        if (prodatas != null && !prodatas.isEmpty()) {
            prodatas.forEach(map -> {
                map.put("audittype", "2");
            });
            List<String> cols = new ArrayList<>();
            cols.add("audittype");
            evaluateEntrustDAO.updateAll(cols, prodatas, maintablecode);
            this.workflow("audit", workflow, remark, maintablecode, prodatas);
        }
        return this.auditdefine(prodatas, busguid, "perf", null);
    }

    /**
     * 委托专家保存并审核；
     * @param params
     * @return
     */
    public Map<String,Object> saveauditEntrust (HashMap<String, Object> params) throws AppException {
        this.saveEntrust(params); //保存
        //审核
        return this.auditEntrust(params);
    }
}
