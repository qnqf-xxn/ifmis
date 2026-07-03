package gov.mof.fasp2.pmkpi.projapplyjs.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.projapplyjs.dao.DeptPerfInfoDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DeptPerfBudgetBO extends PmkpiBO {
    private DeptPerfInfoDAO deptPerfInfoDAO;

    public void setDeptPerfInfoDAO(DeptPerfInfoDAO deptPerfInfoDAO) {
        this.deptPerfInfoDAO = deptPerfInfoDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
//        String tablecode = (String)params.get("tablecode");
        String wheresql = " t.mainguid = '" + mainguid + "'";
        //收入
        List<Map<String, Object>>  incomdata = deptPerfInfoDAO.getDatas("V_PERF_T_DEPTBUDGET_INCOME", wheresql, "order by guid");
        if(incomdata == null){
            incomdata = new ArrayList<>();
        }
        if(incomdata.size()<1){
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("guid", this.getCreateguid());
            map.put("mainguid", mainguid);
            map.put("createtime", StringUtil.getSysDBDate());
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            incomdata.add(map);
        }
        backMap.put("incomdata", incomdata);
        //支出
        List<Map<String, Object>>  paydata = deptPerfInfoDAO.getDatas("V_PERF_T_DEPTBUDGET_PAY", wheresql + " and t.is_prodetail = 0", "order by ordernum");
        if(paydata == null){
            paydata = new ArrayList<>();
        }
        if(paydata.size()<1){
            Map<String, Object> map1 = new HashMap<String, Object>();//基本支出
            map1.put("guid", this.getCreateguid());
            map1.put("mainguid", mainguid);
            map1.put("name", "基本支出");
            map1.put("is_prodetail", 0);
            map1.put("ordernum", 1);
            map1.put("createtime", StringUtil.getSysDBDate());
            map1.put("updatetime", StringUtil.getSysDBDate());
            map1.put("creater", SecureUtil.getCurrentUser().getGuid());
            map1.put("province", SecureUtil.getUserSelectProvince());
            map1.put("year", CommonUtil.getYear());
            paydata.add(map1);
            Map<String, Object> map2 = new HashMap<String, Object>();//项目支出
            map2.put("guid", this.getCreateguid());
            map2.put("mainguid", mainguid);
            map2.put("name", "项目支出");
            map2.put("is_prodetail", 0);
            map2.put("ordernum", 2);
            map2.put("createtime", StringUtil.getSysDBDate());
            map2.put("updatetime", StringUtil.getSysDBDate());
            map2.put("creater", SecureUtil.getCurrentUser().getGuid());
            map2.put("province", SecureUtil.getUserSelectProvince());
            map2.put("year", CommonUtil.getYear());
            paydata.add(map2);
        }
        backMap.put("paydata", paydata);
        //支出明细
        List<Map<String, Object>>  payprojdata = deptPerfInfoDAO.getDatas("V_PERF_T_DEPTBUDGET_PAY", wheresql + " and t.is_prodetail = 1", "order by ordernum");
        if(payprojdata == null){
            payprojdata = new ArrayList<>();
        }
        if(payprojdata.size()<1){
            //根据单位查询项目
            String projsql = " t.agencyguid = '" + mainguid + "'";
            payprojdata = deptPerfInfoDAO.getDatas("V_PERF_T_PROJAGENCYINFO", projsql, "order by guid");
            int i = 1;
            for (Map<String, Object> map : payprojdata) {
        		map.put("guid", this.getCreateguid());
                map.put("mainguid", mainguid);
                map.put("guid", map.get("guid"));
                map.put("name", map.get("name"));
                map.put("is_prodetail", 1);
                map.put("ordernum", i);
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                i++;
            }
        }
        backMap.put("payprojdata", payprojdata);
        return backMap;
    }

    /**
     * 保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //全部数据
        List<Map<String, Object>> incomdata = (List<Map<String, Object>>) params.get("incomdata");
        List<Map<String, Object>> paydata = (List<Map<String, Object>>) params.get("paydata");
        List<Map<String, Object>> payprojdata = (List<Map<String, Object>>) params.get("payprojdata");
        //收入
        Map<String, Object> rs1 = saveTable(params,"PERF_T_DEPTBUDGET_INCOME",incomdata,null);
        //支出
        Map<String, Object> rs2 = saveTable(params,"PERF_T_DEPTBUDGET_PAY",paydata,"and t.is_prodetail =0");
        //支出项目明细
        Map<String, Object> rs3 = saveTable(params,"PERF_T_DEPTBUDGET_PAY",payprojdata,"and t.is_prodetail =1");
        Map<String, Object> rs = new HashMap<String, Object>();
        rs.putAll(rs1);
        rs.putAll(rs2);
        rs.putAll(rs3);
        return rs;
    }

    /**
     * 保存列表数据
     * @param params
     * @param tablecode
     * @param datas
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveTable(HashMap<String, Object> params,String tablecode,List<Map<String, Object>> datas,String wheresql) throws AppException {
        //表名
        String busguid = (String) params.get("busguid");
        String mainguid = (String)params.get("mainguid");
        //删除数据
        String delsql = " t.mainguid = '" + mainguid + "'";
        if(wheresql!=null && !wheresql.isEmpty()){
            delsql += wheresql;
        }
        //收入
        List<Map<String, Object>>  odata = deptPerfInfoDAO.getDatas(tablecode, delsql, "order by guid");
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
            deptPerfInfoDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            deptPerfInfoDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }
}
