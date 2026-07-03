package gov.mof.fasp2.pmkpi.setting.casepage.index;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CaseIndexBO extends PmkpiBO {
    private CaseIndexDAO caseIndexDAO;

    public void setCaseIndexDAO(CaseIndexDAO caseIndexDAO) {
        this.caseIndexDAO = caseIndexDAO;
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
        String tablesql = (String)params.get("tablesql");
        String bustype = (String)params.get("bustype");
        String indexsql = " t.mainguid = '" + mainguid + "'";
        String orderby = " order by ordernum";
        List<Map<String, Object>> collist = caseIndexDAO.getCol(tablecode);
        List<Map<String, Object>> indexs = caseIndexDAO.getDatas(tablecode, indexsql, orderby);
        List<Map<String, Object>> tempdatas = caseIndexDAO.getTempdatas(bustype);
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        List<Map<String, Object>> tempList = null;
        String sindex = "";
        for (Map<String, Object> map : indexs) {
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            String status = map.get("status") + "";
            if ("3".equals(status)) {
                map.put("obligate1", "撤销删除");
            } else if (!"3".equals(status)) {
                map.put("obligate1", "删除");
            }
            sindex = (String) map.get("sindex");
            map.put("superid", sindex);
            if (!indexMap.containsKey(sindex)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(sindex, tempList);
            } else {
                tempList = indexMap.get(sindex);
            }
            tempList.add(map);
        }
        for (Map<String, Object> map : tempdatas) {
            map.put("indexguid", "");
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || value.isEmpty() || "null".equals(value)) {
                    map.put(col, null);
                }
            }
            map.put("isleaf", "0");
            map.put("_isleaf", "0");
            String levelno = map.get("levelno") + "";
            if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                sindex = (String) map.get("guid");
                map.put("obligate1", "新增");
            } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                map.put("obligate1", "");
                sindex = "";
            } else {
                sindex = "";
            }
            if (indexMap.containsKey(sindex)) {
                tempList = indexMap.get(sindex);
                backdata.addAll(tempList);
            }
            backdata.add(map);
        }
        backMap.put("data", backdata);
        return backMap;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String finintorgguid = (String) params.get("finintorgguid");
        String bustype = (String) params.get("bustype");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> addlist = new ArrayList<>();
        List<Map<String, Object>> uplist = new ArrayList<>();
        List<String> delguids = (List<String>) params.get("delguids");
        List<Map<String, Object>> list = new ArrayList<>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String levelno = map.get("levelno") + "";
            if (levelno != null && "3".equals(levelno)) {
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                String rowtype = (String) map.get("rowtype");
                if ("add".equals(rowtype)) {
                    String weight = null;
                    String weightindex = map.get("weight") + "";
                    if (weightindex != null && !weightindex.isEmpty() && !"null".equals(weightindex)) {
                        weight = map.get("weight").toString();
                        map.put("weight", Float.parseFloat(weight));
                    }
                    if (weight==null||weight.isEmpty()){
                        map.put("weight", 0);
                    }
                    map.put("guid", this.getCreateguid());
                    map.put("ordernum", i++);
                    map.put("mainguid", mainguid);
                    map.put("createtime", PerfUtil.getServerTimeStamp());
                    map.put("creater", SecureUtil.getCurrentUser().getGuid());
                    map.put("province", SecureUtil.getUserSelectProvince());
                    map.put("agencyguid", saveAgency);
                    map.put("year", CommonUtil.getYear());
                    map.put("finintorgguid", finintorgguid);
                    map.put("framesystem", bustype);
                    map.put("is_deleted", 2);
                    addlist.add(map);
                } else {
                    map.put("ordernum", i++);
                    uplist.add(map);
                }
            }
        }
        if (delguids.size() > 0) {
            caseIndexDAO.deleteAllByColumn("guid", delguids, tablecode);
        }
        if (addlist.size() > 0) {
            caseIndexDAO.setIndexCode(addlist);
            caseIndexDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            caseIndexDAO.updateAll(uplist, tablecode);
        }
        return this.auditdefine(list, busguid,"perf", null);
    }
    
}
