package gov.mof.fasp2.pmkpi.deptperformance.hnindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2020/8/24  chongdayong
 */
public class DeptHNIndexBO extends PmkpiBO {
    private DeptHNIndexDAO deptHNIndexDAO;

    public void setDeptHNIndexDAO(DeptHNIndexDAO deptHNIndexDAO) {
        this.deptHNIndexDAO = deptHNIndexDAO;
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
        //String modelguid = (String)params.get("modelguid");
        String indexsql = " t.mainguid = '" + mainguid + "'";
        String orderby = " order by ordernum";
        List<Map<String, Object>> collist = deptHNIndexDAO.getCol(tablecode);
        tablecode = "V_"+ tablecode;
        List<Map<String, Object>> indexs = deptHNIndexDAO.getDatas(tablecode, indexsql, orderby);
        List<Map<String, Object>> tempdatas = deptHNIndexDAO.getTempdatas();//获取层次分类表
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        //Map<String, Object> sumMap = new HashMap<String, Object>();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        List<Map<String, Object>> tempList = null;
        String findex = "";
        for (Map<String, Object> map : indexs) {
            map.put("levelno", "2");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            findex = (String) map.get("findex");
            map.put("superid", findex);
            if (!indexMap.containsKey(findex)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(findex, tempList);
            } else {
                tempList = indexMap.get(findex);
            }
            tempList.add(map);
        }
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            map.put("_isleaf", "0");
            backdata.add(map);
            findex = (String) map.get("guid");
            if (indexMap.containsKey(findex)) {
                tempList = indexMap.get(findex);
                backdata.addAll(tempList);
            }
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
        String saveAgency = (String) params.get("saveAgency");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");

        //20230606 部标2.0
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> nullTemp = dss.getRangesByWhereSql("PMKPIFRAME", "frametype='DEPT'");
        Map<Object, Object> tempMap = nullTemp.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
        List<DicRangeDTO> eledatas = null;
        String deptCode = saveAgency.substring(0,3);
        try {
            eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY", "guid='" + deptCode + "'");
        } catch (AppException e) {
            e.printStackTrace();
        }
        String deptName = "";
        if (eledatas.size() > 0) {
            deptName = (String)eledatas.get(0).get("name");
        }

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        tablecode = "V_"+ tablecode;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            map.put("ordernum", i++);
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("agencyguid", saveAgency);
                map.put("kpi_val", map.get("indexval"));
                this.getBasMap(map, "add");
                map.put("is_last_inst",2);//是否终审
                addlist.add(map);
            } else {
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("update_time", StringUtil.getSysDBDate());
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            deptHNIndexDAO.setIndexDatas(addlist,"DEPT",false);
            deptHNIndexDAO.setIndexCode(addlist);
            deptHNIndexDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            deptHNIndexDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            deptHNIndexDAO.saveAll(deldatas, deptHNIndexDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptHNIndexDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptHNIndexDAO.delDatas(tablecode, delsql);
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }
    
    /**
     * 获取选择指标
     * @param parms
     * @return
     */
	public Map<String, Object> indexcheck(HashMap<String, Object> parms) {
        String sindex = (String) parms.get("sindex");
        String agencyguid = (String) parms.get("saveAgency");
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
        String indexWhereSql = " t.sindex = '" + sindex + "' and t.framesystem = 'DEPT'";
        List<Map<String, Object>> indexlib = deptHNIndexDAO.getDatas("perf_t_indexlib", indexWhereSql, null);
        indexWhereSql = " t.sindex = '" + sindex + "' and t.agencyguid = '" + agencyguid + "'";
        List<Map<String, Object>> deptindexlib = deptHNIndexDAO.getDatas("perf_t_deptindexlib", indexWhereSql, null);
        if (indexlib != null && indexlib.size() > 0) {
            data.addAll(indexlib);
        }
        if (deptindexlib != null && deptindexlib.size() > 0) {
            data.addAll(deptindexlib);
        }
        backMap.put("data", data);
        return backMap;
	}

}
