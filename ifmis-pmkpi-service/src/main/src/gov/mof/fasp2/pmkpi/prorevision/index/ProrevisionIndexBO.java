package gov.mof.fasp2.pmkpi.prorevision.index;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.prorevision.report.ProrevisionReportDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProrevisionIndexBO extends PmkpiBO {
    private ProrevisionIndexDAO revisionIndexDAO;

    public void setRevisionIndexDAO(ProrevisionIndexDAO revisionIndexDAO) {
        this.revisionIndexDAO = revisionIndexDAO;
    }
    /**
     * 绩效制度表树级展示保存.
     *
     * @param params -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> savePrjTreeIndex(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String showtab = (String) params.get("showtab"); //页签显示 1总+年2总3年
        String procode = (String) params.get("procode"); //项目编码
        String pro_name = (String) params.get("pro_name");
        List<Map<String, Object>> indexList = new ArrayList<>(); //指标集合
        Map<String, Object> tabcomps = (Map<String, Object>) params.get("datas"); //多页签的数据
        List<Map<String, Object>> addList = new ArrayList<>(); //新增
        List<Map<String, Object>> modList = new ArrayList<>(); // 修改
        List<String> delList = new ArrayList<>(); // 删除
        String levelno = "";
        String indexname = "";
        String rowtype = "";
        String tablecode = ProrevisionReportDAO.PERF_TABLE_PROVISIONDINDEX;
        int j = 0;
        if ("1".equals(showtab) || "3".equals(showtab)) { // 年
            List<String> delYearList = (List<String>) tabcomps.get("del#year");
            if (delYearList.size() > 0) {
                delList.addAll(delYearList);
            }
            List<Map<String, Object>> yearList = (List<Map<String, Object>>) tabcomps.get("#year");
            for (Map tempMap : yearList) {
                j++;
                levelno = PerfUtil.mapGetInt(tempMap, "levelno") + "";
                indexname = (String) tempMap.get("name");
                rowtype = (String) tempMap.get("rowtype");
                if ("3".equals(levelno) && !StringUtil.isEmpty(indexname)) {
                    tempMap.put("mainguid", mainguid);
                    tempMap.put("ordernum", j);
                    tempMap.put("yearflag", "0");
                    tempMap.put("kpi_val", tempMap.get("indexval"));
                    tempMap.put("version_name", PerfConstant.PMKPI_VERSION_NAME_XDRCDTWH);
                    tempMap.put("pro_name", pro_name);
                    tempMap.put("agency_code", saveAgency);
                    tempMap.put("pro_code", procode);
                    tempMap.put("proguid", proguid);
                    tempMap.put("agencyguid", saveAgency);
                    tempMap.put("is_last_inst", 2);
                    if ("add".equals(rowtype)) {
                        tempMap.put("status", 3);
                        this.getBasMap(tempMap, "add");
                        addList.add(tempMap);
                    } else {
                        tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
                        tempMap.put("update_time", PerfUtil.getServerTimeStamp());
                        modList.add(tempMap);
                    }
                    indexList.add(tempMap); //用于审核定义
                }
            }
        }
        Map<String, Object> returnMap = this.nameDuplicateCheck(indexList);
        returnMap.putAll(this.checkColLength(indexList, PerfConstant.PMKPI_VPM_INDICATOR));
        if (returnMap.size() > 0) {
            return returnMap;
        }
        //删除
        if (delList.size() > 0) {
            revisionIndexDAO.deleteAllByColumn("guid", delList, tablecode);
        }
        //修改
        if (modList.size() > 0) {
            this.setIndexDatas(modList, "PM001", false);
            revisionIndexDAO.updateAllByPK(this.getTablecol(tablecode), modList, "guid", tablecode);
        }
        if (addList.size() > 0) {
            revisionIndexDAO.setIndexCode(addList);
            this.setIndexDatas(addList, "PM001", false);
            revisionIndexDAO.saveAll(addList, tablecode);
        }
        return this.auditdefine(indexList, busguid, "perf", null);
    }
    /**
     * 查询各年度数据.
     *
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws --           异常.
     */
    public Map<String, Object> findAllIndex(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode");//项目编码
        String showtab = (String) params.get("showtab"); ////页签显示 1总+年2总3年
        String prolev = (String) params.get("prolev");
        String mainguid = (String) params.get("mainguid");
        String tablecode = ProrevisionReportDAO.PERF_TABLE_PROVISIONDINDEX;
        String orderby = " order by ordernum";
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String sindex = "";
        String yearflag = "0";
        String frametype = "";
        String[] tempfilter = null;
        if (prolev != null && ("1".equals(prolev) || "2".equals(prolev))) {
            frametype = "PM002";
        } else {
            frametype = "PM001";
        }
        List<Map<String, Object>> indexs = null;
        String wheresql = " mainguid='" + mainguid + "'";
        indexs = revisionIndexDAO.getDatas(tablecode, wheresql, orderby);
        if ((indexs == null || indexs.size() == 0) && (mainguid != null && !"".equals(mainguid))) {
            tempfilter = new String[]{"0"};
            indexs = revisionIndexDAO.findIndexsByFilter(proguid, procode, tempfilter);
            for (Map map : indexs) {
                map.put("proguid",proguid);
                map.put("mainguid",mainguid);
                map.put("status", "2");
                map.put("rowtype","add");
            }
        }
        if ("1".equals(showtab) || "2".equals(showtab)) {
            //存在修订业务数据时，获取总体绩效
            tempfilter = new String[]{"1"};
            List<Map<String, Object>> totalindexs = revisionIndexDAO.findIndexsByFilter(proguid, procode, tempfilter);
            indexs.addAll(totalindexs);
        }
        List<Map<String, Object>> nullTemp = revisionIndexDAO.getTempdatas(proguid, frametype); //空指标模板
        PrjIndexDAO prjIndexDAO = (PrjIndexDAO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexDAO");
        List<Map<String, Object>> totalfixedIndexTemp = new ArrayList<>(); //获取固化指标
        List<Map<String, Object>> yearfixedIndexTemp = new ArrayList<>(); //获取固化指标
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        int totalindexcount = 0;
        int yearindexcount = 0;
        // 区分项目多页签指标
        for (Map<String, Object> map : indexs) {
            yearflag = map.get("yearflag") == null ? "0" : (String) map.get("yearflag");
            if("0".equals(yearflag)){
                yearindexcount++;
            }else{
                totalindexcount++;
            }
            sindex = (String) map.get("sindex");
            keycode = sindex + "&" + yearflag;
            if (!indexMap.containsKey(keycode)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(keycode, tempList);
            } else {
                tempList = indexMap.get(keycode);
            }
            map.put("_isleaf", "1");
            tempList.add(map);
        }
        if(totalindexcount == 0) {//存在业务数据或者加载到了模板数据 总体指标index不为空，则不加载固化指标
            totalfixedIndexTemp = prjIndexDAO.getProFixedIndexData(proguid,"1"); //获取固化指标
        }
        if(yearindexcount == 0) {//存在业务数据或者加载到了模板数据 总体指标index不为空，则不加载固化指标
            yearfixedIndexTemp = prjIndexDAO.getProFixedIndexData(proguid,"0"); //获取固化指标
        }
        // 区分项目空模板赋值，不然没有共有字段不显示
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode(ProrevisionReportDAO.PERF_TABLE_PROVISIONDINDEX);
        for (Map<String, Object> map : nullTemp) {
            for (DicColumnDTO dicdto : dicColumnDTOs) {
                if (!map.containsKey(dicdto.getDbcolumncode())) {
                    map.put(dicdto.getDbcolumncode().toLowerCase(), "");
                }
            }
        }
        //处理总体绩效指标
        List<Map<String, Object>> nullindex = null; //空模板
        List<Map<String, Object>> backindex = null; //返回指标
        if ("1".equals(showtab)) {
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            nullindex.addAll(totalfixedIndexTemp);
            backindex = new ArrayList<>();
            for (Map<String, Object> map : nullindex) {
                map.put("_isleaf", "1");
                sindex = (String) map.get("sindex");
                //map.put("guid",this.getCreateguid());
                keycode = sindex + "&1";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#total", backindex); //项目总体
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            nullindex.addAll(yearfixedIndexTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                map.put("_isleaf", "1");
                sindex = (String) map.get("sindex");
                //map.put("guid",this.getCreateguid());
                keycode = sindex + "&0";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#year", backindex);//年度
        } else if ("2".equals(showtab)) {
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            nullindex.addAll(totalfixedIndexTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                sindex = (String) map.get("sindex");
                map.put("_isleaf", "1");
                //map.put("guid",this.getCreateguid());
                keycode = sindex + "&1";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#total", backindex); //项目总体
        } else {
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            nullindex.addAll(yearfixedIndexTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                sindex = (String) map.get("sindex");
                map.put("_isleaf", "1");
                //map.put("guid",this.getCreateguid());
                keycode = sindex + "&0";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
                    map.put("isleaf", "0");
                    backindex.add(map);
                    backindex.addAll(tempList);
                } else {
                    backindex.add(map);
                }
            }
            yearsMap.put("#year", backindex);//年度
        }
        return yearsMap;
    }

}
