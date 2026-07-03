package gov.mof.fasp2.pmkpi.projapplyjs.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.projapplyjs.dao.PerfAdvEvalDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfAdvEvalBO extends PmkpiBO {
    private PerfAdvEvalDAO perfAdvEvalDAO;

    public void setPerfAdvEvalDAO(PerfAdvEvalDAO perfAdvEvalDAO) {
        this.perfAdvEvalDAO = perfAdvEvalDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String projguid = (String)params.get("projguid");
//        String tablecode = (String)params.get("tablecode");
        String wheresql = " t.projguid = '" + projguid + "'";
        List<Map<String, Object>>  data = perfAdvEvalDAO.getDatas("V_PERF_T_ADVEVAINFO", wheresql, "order by ordernum");
        if(data.size()<1){
            data = perfAdvEvalDAO.getDatas("V_PERF_T_SCORE_TEMPLATEDETAIL", " t.module_id = 'sqpg'", "order by ordernum");
            for (Map<String, Object> map : data) {
           		map.put("guid", this.getCreateguid());
                map.put("projguid", projguid);
                map.put("option_value", "");
                map.put("unit_since_score","");
                map.put("score_shows", "");
                map.put("eval_option_value", "");
                map.put("eval_score", "");
                map.put("eval_score_shows", "");
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
            }
        }
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        String projguid = (String) params.get("projguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");

        //删除数据
        String delsql = " t.projguid = '" + projguid + "'";

        List<Map<String, Object>>  odata = perfAdvEvalDAO.getDatas(tablecode, delsql, "order by ordernum");
        //插入数据
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : datas) {
            if(odata.size()>0){
                map.put("updatetime", StringUtil.getSysDBDate());
                uplist.add(map);
            }else{
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                addlist.add(map);
            }
        }
        if (addlist.size() > 0) {
//            perfAdvEvalDAO.delDatas("PERF_T_ADVEVAINFO", delsql);
            perfAdvEvalDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            perfAdvEvalDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }
}
