package gov.mof.fasp2.pmkpi.projapplyjs.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.projapplyjs.dao.DeptPerfInfoDAO;

import java.util.*;

public class DeptPerfFunctionBO extends PmkpiBO {
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
        String tablecode = (String)params.get("tablecode");
        String wheresql = " t.mainguid = '" + mainguid + "'";
        //收入
        List<Map<String, Object>>  data = deptPerfInfoDAO.getDatas(tablecode, wheresql, "order by ordernum");
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
        String tablecode = (String)params.get("tablecode");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        Map<String, Object> rs = saveTable(params,tablecode,datas,deldatas,null);
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
    public Map<String, Object> saveTable(HashMap<String, Object> params,String tablecode,List<Map<String, Object>> datas,List<Map<String, Object>> deldatas,String wheresql) throws AppException {
        //表名
        String busguid = (String) params.get("busguid");
        String mainguid = (String)params.get("mainguid");
        //删除数据
        String delsql = " t.mainguid = '" + mainguid + "'";
        if(wheresql!=null && !wheresql.isEmpty()){
            delsql += wheresql;
        }
        //收入
        List<Map<String, Object>>  odata = deptPerfInfoDAO.getDatas(tablecode, delsql, "order by ordernum");
        String[] oguids = new String[odata.size()];
        for (int i=0;i<odata.size();i++){
            oguids[i] = (String)odata.get(i).get("guid");
        }
        //插入数据
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String guid = (String) map.get("guid");
            boolean isupdate = Arrays.asList(oguids).contains(guid);
            if(isupdate){
                map.put("updatetime", StringUtil.getSysDBDate());
                uplist.add(map);
            }else{
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("ordernum", odata.size()+i);
                i++;
                addlist.add(map);
            }
        }
        if (addlist.size() > 0) {
            deptPerfInfoDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            deptPerfInfoDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            deptPerfInfoDAO.saveAll(deldatas, deptPerfInfoDAO.PMKPI_TABLE_TMP_AGENCY);
            String dsql = " exists(select 1 from " + deptPerfInfoDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptPerfInfoDAO.delDatas(tablecode, dsql);
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }
    /**
     * 清空对应项目
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> clearproject(HashMap<String, Object> params) throws AppException {
        Map<String, Object> map = new HashMap<String, Object>();
        String guid = (String) params.get("guid");
        String tablecode = (String)params.get("tablecode");
        deptPerfInfoDAO.update("update "+ tablecode +" set projects = '' where guid ='"+ guid +"'");
        return map;
    }

}
