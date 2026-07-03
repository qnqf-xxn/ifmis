package gov.mof.fasp2.pmkpi.projapplyjs.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.projapplyjs.dao.PerfProjAuditDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfProjAuditBO extends PmkpiBO {
    private PerfProjAuditDAO perfProjAuditDAO;

    public void setPerfProjAuditDAO(PerfProjAuditDAO perfProjAuditDAO) {
        this.perfProjAuditDAO = perfProjAuditDAO;
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
        String bustype = (String)params.get("bustype");
//        String tablecode = (String)params.get("tablecode");
        String wheresql = " t.projguid = '" + projguid + "'";
        String tmpsql = "";
        if(bustype!=null && !bustype.isEmpty() && "01".equals(bustype)){
            tmpsql = " t.module_id = 'xmsh'";
        }else{
            tmpsql = " t.module_id = 'bmsh'";
        }
        //审核打分
        List<Map<String, Object>>  data = perfProjAuditDAO.getDatas("V_PERF_T_PROJAUDITINFO", wheresql, "order by ordernum");
        if(data.size()<1){
            data = perfProjAuditDAO.getDatas("V_PERF_T_SCORE_TEMPLATEDETAIL", tmpsql, "order by ordernum");
            for (Map<String, Object> map : data) {
        		map.put("guid", this.getCreateguid());
                map.put("projguid", projguid);
                map.put("audit_info", map.get("adv_eva_info"));
                map.put("audit_point", map.get("evaluate_problem"));
                map.put("option_value1", "");
                map.put("option_value2","");
                map.put("option_value3", "");
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
            }
        }
        backMap.put("data", data);
        //审核意见
        List<Map<String, Object>>  optiondata = perfProjAuditDAO.getDatas("V_PERF_T_ADVEVAINFOOPTION", wheresql, "order by guid");
        backMap.put("optiondata", optiondata);
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

        List<Map<String, Object>>  odata = perfProjAuditDAO.getDatas(tablecode, delsql, "order by ordernum");
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
            perfProjAuditDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            perfProjAuditDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }
}
