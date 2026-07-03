package gov.mof.fasp2.pmkpi.adjust.index;

import com.jspsmart.upload.File;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.IImpExpABO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.ImpExpAComponet;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.poi.hssf.usermodel.HSSFCell;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

public class AdjustTraIndexBO extends PmkpiBO implements IImpExpABO {
    private AdjustTraIndexDAO adjustTraIndexDAO;

    public void setAdjustTraIndexDAO(AdjustTraIndexDAO adjustTraIndexDAO) {
        this.adjustTraIndexDAO = adjustTraIndexDAO;
    }

    /**
     * 获取左侧树数据.
     * @return --
     */
    @SuppressWarnings({"unchecked"})
    public Map<String, Object> getTreeData(String procode, String submofdivcodes, String istztj) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 10);
        leftconfig.put("name", "区划");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", adjustTraIndexDAO.getLeftTree(procode, submofdivcodes, istztj));
        return leftconfig;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String procode = (String) params.get("procode");
        String mainguid = (String) params.get("mainguid");
        List<Map<String, Object>> submofDatas = (List<Map<String, Object>>) params.get("submofdatas");
        List<String> submofList = new ArrayList<>();
        List<String> submofs = new ArrayList<>();
        for (Map<String, Object> map : submofDatas) {
            submofList.add((String) map.get("guid"));
        }
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(" t.mainguid = ? ");
        String orderby = " order by sub_mof_div_code,findex,sindex,ordernum";
        String type = "PM001";
        List<Map<String, Object>> collist = adjustTraIndexDAO.getCol(AdjustIndexDAO.TABLE_INDEX);
        List<Map<String, Object>> goals = adjustTraIndexDAO.getDatas(AdjustTraIndexDAO.PERF_TABLE_ADJUSTALLGOAL, wheresql.toString(), null, new String[]{mainguid});
        wheresql.append(" and (status in('2','3') or status is null)");
        List<Map<String, Object>> indexs = adjustTraIndexDAO.getDatas(AdjustTraIndexDAO.PERF_TABLE_ADJUSTALLINDEX, wheresql.toString(), orderby, new String[]{mainguid});
        List<Map<String, Object>> tempdatas = adjustTraIndexDAO.getTempdatas(type);
        for (Map<String, Object> map : tempdatas) {
            map.put("indexguid", "");
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || value.isEmpty() || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            map.put("isleaf", "0");
            map.put("_isleaf", "0");
        }
        boolean isadjgoal = false;
        boolean isadjindex = false;
        HashSet<String> indNameList = new HashSet<>();
        if (indexs.size() > 0) {
            List<Map<String, Object>> list = indexs.stream().filter(map1 -> StringUtil.isNullOrEmpty(map1.get("sub_mof_div_code"))).collect(Collectors.toList());
            if (list.size() > 0) {
                isadjindex = true;
                list.forEach(m->{indNameList.add((String) m.get("name"));});
                list.addAll(tempdatas);
                backMap.put("indexdatas", list);
            }
        }
        if (goals.size() > 0) {
            List<Map<String, Object>> list = goals.stream().filter(map1 -> StringUtil.isNullOrEmpty(map1.get("sub_mof_div_code"))).collect(Collectors.toList());
            if (list.size() > 0) {
                isadjgoal = true;
                backMap.put("goaldata", list.get(0));
            }
        }
        //调整过绩效总的年度目标、指标后才能调整明细
        if (isadjindex && isadjgoal) {
            wheresql = new StringBuffer();
            wheresql.append(" t.is_backup=2 and t.is_deleted=2 and t.pro_code = ? and yearflag = '0' and sub_mof_div_code is not null ").append(PerfUtil.yearProvinceSql("t"));
            List<Map<String, Object>> indexList = null;
            Map<String, Object> goalMap = null;
            Map<String, Object> dataMap = null;
            HashSet<String> subnameList = null;
            for (String submofdiv : submofList) {
                indexList = new ArrayList<>();
                goalMap = new HashMap<>();
                dataMap = new HashMap<>();
                subnameList = new HashSet<>();
                for (Map<String, Object> map : indexs) {
                    map.put("levelno", "3");
                    map.put("isleaf", "1");
                    map.put("_isleaf", "1");
                    String sindex = (String) map.get("sindex");
                    map.put("superid", sindex);
                    String sub_mof_div_code = (String) map.get("sub_mof_div_code");
                    if (submofdiv.equals(sub_mof_div_code)) {
                        indexList.add(map);
                        subnameList.add((String) map.get("name"));
                    }
                }
                for (Map<String, Object> map : goals) {
                    String goal = (String) map.get("adjustndgoal");
                    if (!StringUtil.isNullOrEmpty(goal)) {
                        map.put("kpi_target", goal);
                    }
                    String sub_mof_div_code = (String) map.get("sub_mof_div_code");
                    if (submofdiv.equals(sub_mof_div_code)) {
                        goalMap = map;
                    }
                }
                List<Map<String, Object>> list = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(tempdatas);
                list.forEach(m->{m.put("sub_mof_div_code", submofdiv);});
                indexList.addAll(list);
                //是否填报了绩效
                Map<String, Object> map = null;
                if (goalMap.isEmpty()) {
                    map = (Map<String, Object>) backMap.get("goaldata");
                    String guid = StringUtil.createUUID();
                    map.put("guid", guid);
                    map.put("create_time", "");
                    map.put("sub_mof_div_code", submofdiv);
                }
                if (indexList.size() > 12) {
                    dataMap.put("indexs", indexList);
                    dataMap.put("goal", goalMap.isEmpty() ? map : goalMap);
                    backMap.put(submofdiv, dataMap);
                } else {
                    submofs.add(submofdiv);
                }
            }
            backMap.put("submofs", submofs);
        } else {
            backMap.put("submofs", submofList);
        }
        return backMap;
    }

    /**
     * 绩效制度表树级展示保存.
     *
     * @param params -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> saveGoalAndIndex(HashMap<String, Object> params) throws AppException {
        this.setProAgencyName(params);
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String procode = (String) params.get("procode");
        String pro_name = (String) params.get("pro_name");//项目名称
        String agency_name = (String) params.get("agency_name");//单位名称
        String saveAgency = (String) params.get("saveAgency");//单位编码
        String impdata = (String) params.get("impdata");
        Map<String, Object> dataMap = (Map<String, Object>) params.get("datas"); //多页签的数据
        List<Map<String, Object>> addindexList = new ArrayList<>(); //新增指标
        List<Map<String, Object>> modindexList = new ArrayList<>(); // 修改指标
        List<Map<String, Object>> addgoalList = new ArrayList<>(); //新增指标
        List<Map<String, Object>> modgoalList = new ArrayList<>(); // 修改指标
        StringBuffer wheresql = new StringBuffer();
        List<String> subcodeList = dataMap.keySet().stream().filter(str -> PerfUtil.isNumeric(str)).collect(Collectors.toList());
        if (subcodeList == null || subcodeList.isEmpty()) {
            Map map = new HashMap();
            map.put("success", true);
            return map;
        }
        wheresql.append(adjustTraIndexDAO.createInSql("sub_mof_div_code", subcodeList));
        wheresql.append(" and mainguid = ? ");
        List<Map<String, Object>> goals = adjustTraIndexDAO.getDatas(AdjustTraIndexDAO.PERF_TABLE_ADJUSTALLGOAL, wheresql.toString(), null, new String[]{mainguid});
        wheresql.append(" and (status in('2','3') or status is null)");
        List<Map<String, Object>> indexs = adjustTraIndexDAO.getDatas(AdjustTraIndexDAO.PERF_TABLE_ADJUSTALLINDEX, wheresql.toString(), null, new String[]{mainguid});
        List<Map<String, Object>> indexList = new ArrayList<>();
        List<Map<String, Object>> goalList = new ArrayList<>();
        List<Map<String, Object>> list = null;
        List<Map<String,Object>> provinceList = PerfUtil.getSourceData("MOFDIV", adjustTraIndexDAO.createInSql("code", subcodeList));
        Map<Object, Object> provinceMap = provinceList.stream().collect(Collectors.toMap(l -> l.get("guid"), l -> l.get("name")));
        String submofname = "";
        for (String submofdiv : subcodeList) {
            Map<String, Object> map = (Map<String, Object>) dataMap.get(submofdiv);
            if (map.get("indexs") instanceof String) {
                list = PerfUtil.parseString2List((String) map.get("indexs"));
            } else {
                list = (List<Map<String, Object>>) map.get("indexs");
            }
            indexList.addAll(list);
            submofname = (String) provinceMap.get(submofdiv);
            String finalSubmofname = submofname;
            indexList.stream().forEach(m -> {
                if (submofdiv.equals(m.get("sub_mof_div_code"))) {
                    m.put("sub_mof_div_name", finalSubmofname);
                }
                m.put("kpi_val", m.get("indexval"));
                m.put("agency_name", agency_name);
                m.put("agencyguid", saveAgency);
                m.put("pro_name", pro_name);
                m.put("pro_code", procode);
                m.put("mainguid", mainguid);
                m.put("adjustindexval", "");
                if (StringUtil.isEmpty((String) m.get("create_time"))) {
                    this.getBasMap(m, "add");
                } else {
                    this.getBasMap(m, null);
                }
            });
            goalList.add((Map<String, Object>) map.get("goal"));
            goalList.stream().forEach(m -> {
                if (submofdiv.equals(m.get("sub_mof_div_code"))) {
                    m.put("sub_mof_div_name", finalSubmofname);
                }
                m.put("agency_name", agency_name);
                m.put("agencyguid", saveAgency);
                m.put("pro_name", pro_name);
                m.put("pro_code", procode);
                m.put("mainguid", mainguid);
                m.put("adjustndgoal", "");
                if (StringUtil.isEmpty((String) m.get("create_time"))) {
                    this.getBasMap(m, "add");
                } else {
                    this.getBasMap(m, null);
                }
            });
        }
        if (indexList.size() > 0 && goalList.size() > 0) {
            indexList = indexList.stream().filter(map1 -> "3".equals(map1.get("levelno") + "")).collect(Collectors.toList());
            adjustTraIndexDAO.setIndexCode(indexList);
            adjustTraIndexDAO.setIndexDatas(indexList, "PM001", false);
            if (!"true".equals(impdata)) {
                Map<String, Object> returnMap = this.nameDuplicateCheck(indexList, subcodeList);
                //校验指标数据
                returnMap.putAll(this.checkColLength(indexList, AdjustIndexDAO.TABLE_INDEX));
                returnMap.putAll(adjustTraIndexDAO.checkTacleColsIsNull(AdjustIndexDAO.TABLE_INDEX, indexList));
                //校验目标数据
                returnMap.putAll(this.checkColLength(goalList, AdjustIndexDAO.TABLE_GOAL));
                returnMap.putAll(adjustTraIndexDAO.checkTacleColsIsNull(AdjustIndexDAO.TABLE_GOAL, goalList));
                if (!returnMap.isEmpty()) {
                    return returnMap;
                }
            }
            if (indexs.size() == 0) {
                addindexList = indexList;
            } else {
                addindexList = this.getIdenList(indexList, indexs, "1");
                modindexList = this.getIdenList(indexList, indexs, "0");
            }
            if (goals.size() == 0) {
                addgoalList = goalList;
            } else {
                addgoalList = this.getIdenList(goalList, goals, "1");
                modgoalList = this.getIdenList(goalList, goals, "0");
            }
            if (addindexList.size() > 0) {
                adjustTraIndexDAO.saveAll(addindexList, AdjustTraIndexDAO.PERF_TABLE_ADJUSTALLINDEX);
            }
            if (modindexList.size() > 0) {
                adjustTraIndexDAO.updateAll(modindexList, AdjustTraIndexDAO.PERF_TABLE_ADJUSTALLINDEX);
            }
            if (addgoalList.size() > 0) {
                adjustTraIndexDAO.saveAll(addgoalList, AdjustTraIndexDAO.PERF_TABLE_ADJUSTALLGOAL);
            }
            if (modgoalList.size() > 0) {
                adjustTraIndexDAO.updateAll(modgoalList, AdjustTraIndexDAO.PERF_TABLE_ADJUSTALLGOAL);
            }
        }
        return this.auditdefine(goalList, busguid, "perf", null);
    }

    /**
     * <p>校验指标名称不可重复</p >
     * @param
     */
    public Map<String, Object> nameDuplicateCheck(List<Map<String, Object>> indexList, Collection<String> submofdivList) {
        logger.info("---校验三级指标名称是否重复----start---");
        Map<String, Object> backMap = new HashMap<String, Object>();
        Map<String, Object> errMap = null;
        List<Map<String, Object>> errdata = new ArrayList<>();
        for (String submofdiv : submofdivList) {
            List<Map<String, Object>> list = indexList.stream().filter(myMap -> submofdiv.equals(myMap.get("sub_mof_div_code"))).collect(Collectors.toList());
            for (Map<String, Object> map : list) {
                String name = map.get("name") + "";
                List<Map<String, Object>> totalList1 = list.stream().filter(map1 -> name.equals(map1.get("name"))).collect(Collectors.toList());
                if (totalList1.size() > 1) {
                    errMap = new HashMap<>();
                    errMap.put("remark", "区划：" + submofdiv + "【" + name + "】指标名称重复" + totalList1.size() + "次，无法保存；");
                    errMap.put("code", "002");
                    errMap.put("name", "校验三级指标名称");
                    errMap.put("explain", "三级指标名称不可重复");
                    errdata.add(errMap);
                }
            }
        }

        if (errdata != null && !errdata.isEmpty()) {
            errdata = errdata.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() ->
                    new TreeSet<>(Comparator.comparing((o) -> o.get("remark") + ""))), ArrayList::new)); // 去重
            logger.info("---errdata：" + errdata.toString());
            backMap.put("success", false);
            backMap.put("redata", errdata);
        }
        logger.info("---校验三级指标名称是否重复----end---");
        return backMap;
    }

    /**
     * 获取最新目标、指标.
     *
     * @param params -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public void updaedata(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid"); //项目编码
        List<Map<String, Object>> submofDatas = (List<Map<String, Object>>) params.get("submofdatas");
        List<String> submofList = new ArrayList<>();
        for (Map<String, Object> map : submofDatas) {
            submofList.add((String) map.get("guid"));
        }
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(adjustTraIndexDAO.createInSql("sub_mof_div_code", submofList));
        wheresql.append(" and t.mainguid = '").append(mainguid).append("'");
        adjustTraIndexDAO.updateIsDeleteDatas(AdjustTraIndexDAO.PERF_TABLE_ADJUSTALLGOAL, wheresql.toString());
        adjustTraIndexDAO.updateIsDeleteDatas(AdjustTraIndexDAO.PERF_TABLE_ADJUSTALLINDEX, wheresql.toString());
    }

    /**
     * 获取项目名称和单位名称
     * @param params
     */
    public void setProAgencyName(Map<String, Object> params){
        String procode = (String) params.get("procode"); //项目编码
        String proguid = (String) (StringUtil.isEmpty((String) params.get("projguid")) ? params.get("proguid") : params.get("projguid"));
        String pro_name = (String) params.get("pro_name");//项目名称
        String saveAgency = (String) params.get("saveAgency");//项目名称
        String selectbillguid = (String) params.get("selectbillguid");
        if (StringUtil.isEmpty(procode) || StringUtil.isEmpty(pro_name) || StringUtil.isEmpty(saveAgency)) {
            String wheresql = "t.pro_code = '" + procode + "'";
            Map<String, Object>  proMap = adjustTraIndexDAO.getDataMap(adjustTraIndexDAO.PMKPI_TABLE_PROJECT_INFO, wheresql);
            if (!proMap.isEmpty()) {
                procode = (String) proMap.get("pro_code");
                pro_name = (String) proMap.get("pro_name");
                saveAgency = (String) proMap.get("agency_code");
                String agency_name = (String) proMap.get("agency_name");
                params.put("procode", procode);
                params.put("pro_name", pro_name);
                params.put("agency_name", agency_name);
                params.put("saveAgency", saveAgency);
            }
        }
        logger.info("---获取项目名称和单位名称：procode:" + procode + ";proguid:" + proguid+ ";selectbillguid:" + selectbillguid);
        logger.info("---获取项目名称和单位名称：pro_name:" + pro_name + ";agency_code:" + params.get("saveAgency") + ";agency_name:" + params.get("agency_name"));
    }

    /**
     * 判断数据
     * @param list1
     * @param list2
     * @param isIden
     * @return
     */
    private List getIdenList(List<Map<String, Object>> list1, List<Map<String, Object>> list2, String isIden) {
        List list = new ArrayList();
        for (Map<String, Object> map : list1) {
            String guid = (String) map.get("guid");
            //是否存在相同数据
            List l = list2.stream().filter(map1 -> guid.equals(map1.get("guid"))).collect(Collectors.toList());
            if (l.size() > 0 && "0".equals(isIden)) {//存在
                list.add(map);
            } else if (l.size() == 0 && "1".equals(isIden)){//不存在
                list.add(map);
            }
        }
        return list;
    }

    @Override
    public List busImpDatas(Map paras, String filename, List<? extends Map> datalist) throws AppException {
        return null;
    }

    @Override
    public Map busImpConfirmDatasSave(Map paras, ArrayList datalist) throws AppException {
        return null;
    }

    @Override
    public List busExpDatas(Map paras) throws AppException {
        HashMap params = (HashMap) paras;
        String submofdatas = (String) paras.get("submofdatas");
        String btncode = (String) paras.get("btncode");
        List<Map<String, Object>> subList = new ArrayList<>();
        if (!StringUtil.isNullOrEmpty(submofdatas)) {
            Map<String, Object> subMap = null;
            for (String subcode : submofdatas.split(",")) {
                subMap = new HashMap<>();
                subMap.put("guid", subcode);
                subList.add(subMap);
            }
        }
        params.put("submofdatas", subList);
        Map dataMap = this.getDatas(params);
        List<Map<String, Object>> list = new ArrayList<>();
        if (!StringUtil.isNullOrEmpty(submofdatas)) {
            List colList = (List) paras.get("uitablecolsconfig");
            Map map = null;
            String submofname = "";
            for (String submof : submofdatas.split(",")) {
                List<Map<String, Object>> indexs = null;
                Map<String, Object> goal = null;
                Map<String, Object> m = new HashMap<>();
                Map<String, Object> data = (Map<String, Object>) dataMap.get(submof);
                if (data != null && !data.isEmpty()) {
                    indexs = (List<Map<String, Object>>) data.get("indexs");
                    goal = (Map<String, Object>) data.get("goal");
                } else if (StringUtil.isEmpty(btncode)) {
                    indexs = (List<Map<String, Object>>) dataMap.get("indexdatas");
                    goal = (Map<String, Object>) dataMap.get("goaldata");
                }
                if (StringUtil.isEmpty(btncode)) {
                    if (indexs == null || indexs.isEmpty() || goal == null || goal.isEmpty()) {
                        throw new AppException("ERROR", "请保存调整整体年度绩效后进行导出模版操作！");
                    }
                }
                if (indexs != null && indexs.size() > 0) {
                    for (Map<String, Object> indexMap : indexs) {
                        String levelno = indexMap.get("levelno") + "";
                        if ("3".equals(levelno)) {
                            String adjustindexval = (String) indexMap.get("adjustindexval");
                            String indexval = (String) indexMap.get("indexval");
                            String name = (String) indexMap.get("name");
                            if (!StringUtil.isNullOrEmpty(adjustindexval)) {
                                indexval = adjustindexval;
                            }
                            if (!"1".equals(indexMap.get("isapply") + "")) {
                                indexval = "—";
                            }
                            for (int i = 0; i < colList.size(); i++) {
                                map = (Map) colList.get(i);
                                String columncode = (String) map.get("columncode");
                                if (name != null && columncode != null && name.trim().equals(columncode.trim())) {
                                    m.put(columncode.trim(), indexval);
                                }
                            }
                        }
                    }
                }
                if (goal != null && !goal.isEmpty()) {
                    m.put("kpi_target", goal.get("kpi_target"));
                    submofname = (String) goal.get("sub_mof_div_name");
                }
                if (StringUtil.isNullOrEmpty(submofname)) {
                    submofname = CommonUtil.getProvinceNameByCode(submof);
                }
                m.put("sub_mof_div_code", submof + "-" + submofname);
                list.add(m);
            }
        }
        return list;
    }

    @Override
    public List imp(File file, Map paras) throws Exception {
        return null;
    }

    @Override
    public List impreport(File file, Map paras) throws Exception {
        return null;
    }

    @Override
    public List impData(List datas, Map paras) throws AppException {
        HashMap params = (HashMap) paras;
        String submofdatas = (String) paras.get("submofdatas");
        List<Map<String, Object>> subList = new ArrayList<>();
        if (!StringUtil.isNullOrEmpty(submofdatas)) {
            Map<String, Object> subMap = null;
            for (String subcode : submofdatas.split(",")) {
                subMap = new HashMap<>();
                subMap.put("guid", subcode);
                subList.add(subMap);
            }
        }
        params.put("submofdatas", subList);
        Map dataMap = this.getDatas(params);
        List<Map<String, Object>> indexs = null;
        Map<String, Object> goal = null;
        Map<String, Object> subMap = null;
        Map<String, Object> subdatas = new HashMap<>();
        List<Map<String, Object>> indexList = new ArrayList<>();
        List<Map<String, Object>> goalList = new ArrayList<>();
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        String fileguid = ImpExpAComponet.FILE_GUIDS.get();
        ImportErrorDTO dto = null;
        List<Map<String, Object>> errorlist = new ArrayList<>();
        for (Object obj : datas) {
            Map impMap = (Map) obj;
            subMap = new HashMap<>();
            Integer linenum = (Integer) impMap.get("linenum");
            String submof = (String) impMap.get("sub_mof_div_code");
            submof = submof.split("-")[0];
            boolean isdata = true; //是否存在区划数据
            Map<String, Object> data = (Map<String, Object>) dataMap.get(submof);
            if (data == null || data.isEmpty()) {
                isdata = false;
                indexs = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(dataMap.get("indexdatas"));
                goal = (Map<String, Object>) PerfUtil.cloneListAndMap(dataMap.get("goaldata"));
            } else {
                indexs = (List<Map<String, Object>>) data.get("indexs");
                goal = (Map<String, Object>) data.get("goal");
            }
            for (Map<String, Object> indexMap : indexs) {
                if ("3".equals(indexMap.get("levelno") + "")) {
                    String name = (String) indexMap.get("name");
                    String isallowedit = indexMap.get("isallowedit") + "";
                    if (!isdata) {
                        indexMap.put("guid", StringUtil.createUUID());
                    }
                    if (name == null || !impMap.containsKey(name.trim())) {
                        dto = new ImportErrorDTO(fileguid, linenum, "明细三级指标:" + name + "不存在于年度指标，请检查！");
                        errordao.saveErrorMsg(dto);
                        errorlist.add(dto);
                    }
                    indexMap.put("sub_mof_div_code", submof);
                    String indexval = (String) impMap.get(name.trim());
                    if (!"2".equals(isallowedit)) {
                        if ("—".equals(indexval)) {
                            indexMap.put("indexval", "—");
                        } else {
                            indexMap.put("indexval", indexval);
                        }
                    }
                    if ("—".equals(indexval)) {
                        indexMap.put("isapply", "2");
                    } else {
                        indexMap.put("isapply", "1");
                    }
                    indexMap.put("linenum", linenum);
                }
            }
            if (!isdata) {
                goal.put("guid", StringUtil.createUUID());
            }
            goal.put("linenum", linenum);
            goal.put("sub_mof_div_code", submof);
            goal.put("kpi_target", impMap.get("kpi_target"));
            subMap.put("indexs", indexs);
            subMap.put("goal", goal);
            subdatas.put(submof, subMap);
            indexList.addAll(indexs);
            goalList.add(goal);
        }
        if (errorlist.size() > 0) {
            throw new AppException("ANA-ERROR", "指标导入数据错误");
        }
        params.put("datas", subdatas);
        params.put("impdata", "true");
        List coll = adjustTraIndexDAO.getCol(AdjustIndexDAO.TABLE_INDEX);
        indexList = indexList.stream().filter(map1 -> "3".equals(map1.get("levelno") + "")).collect(Collectors.toList());
        errorlist.addAll(this.checkIndexFrame(indexList));
        errorlist.addAll(this.checkImpColNullable(indexList, coll));
        errorlist.addAll(this.checkImpColLength(indexList, coll));
        coll = adjustTraIndexDAO.getCol(AdjustIndexDAO.TABLE_GOAL);
        errorlist.addAll(this.checkImpColNullable(goalList, coll));
        errorlist.addAll(this.checkImpColLength(goalList, coll));
        if (errorlist.size() > 0) {
            throw new AppException("ANA-ERROR", "指标导入数据错误");
        }
        this.saveGoalAndIndex(params);
        return null;
    }

    @Override
    public List parseFile(Map paras, String filename, InputStream is) throws AppException {
        return null;
    }

    @Override
    public List beforeParseFile(Map paras, String filename, InputStream is) throws AppException {
        return null;
    }

    @Override
    public boolean isBusGetCellValue() {
        return false;
    }

    @Override
    public Object getCellValue(Map paras, Map colconfig, HSSFCell cell, String columncode, boolean istrans) throws AppException {
        return null;
    }

    @Override
    public boolean expImpModel(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {
        return false;
    }

    @Override
    public void beforeExpImpModel(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {

    }

    @Override
    public List beforeExpImpCols(Map paras) throws AppException {
        String mainguid = (String) paras.get("mainguid"); //项目编码
        List<Map<String, Object>> collist = new ArrayList<>();
        Map<String, Object> map = null;
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(" t.mainguid = '").append(mainguid).append("' and (status in('2','3') or status is null)");
        String orderby = " order by findex,sindex,ordernum";
        List<Map<String, Object>> indexList = this.getDatas(AdjustIndexDAO.TABLE_INDEX, wheresql.toString(), orderby);
        if (indexList.size() > 0) {
            Map<String, Object> frameMap = new HashMap<>();
            List<Map<String, Object>> frameList = adjustTraIndexDAO.getTempdatas("PM001");
            for (Map<String, Object> mm : frameList) {
                frameMap.put((String) mm.get("guid"), mm.get("name"));
            }
            for (Map<String, Object> m : indexList) {
                map = new HashMap<>();
                String name = (String) m.get("name");
                int colwidth = name.length() * 15;
                if (colwidth < 100) {
                    colwidth = 100;
                }
                map.put("columncode", name.trim());
                map.put("name", name.trim());
                map.put("head", frameMap.get(m.get("findex")) + "," + frameMap.get(m.get("sindex")));
                map.put("type", "s");
                map.put("importds", "1");
                map.put("colwidth", colwidth);
                collist.add(map);
            }
        }
        return collist;
    }

    @Override
    public Map transExpDatas(Map paras, List<? extends Map> datalist) throws AppException {
        return null;
    }

    @Override
    public boolean setCellValue(Map paras, Map colconfig, HSSFCell cell, String columncode, boolean istrans, Map rowdata, Map trandata, Map cellstylemap) throws AppException {
        return false;
    }

    @Override
    public void exp(Map paras, HttpServletRequest request, HttpServletResponse response) throws AppException {

    }
}
