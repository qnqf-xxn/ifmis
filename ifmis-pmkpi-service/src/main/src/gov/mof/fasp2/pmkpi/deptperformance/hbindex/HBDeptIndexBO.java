package gov.mof.fasp2.pmkpi.deptperformance.hbindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;
import java.util.stream.Collectors;

public class HBDeptIndexBO extends PmkpiBO {
    private HBDeptIndexDAO hbDeptIndexDAO;

    public void sethbDeptIndexDAO(HBDeptIndexDAO hbDeptIndexDAO) {
        this.hbDeptIndexDAO = hbDeptIndexDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        String tablecode = PerfConstant.BGT_V_TABLE_INDICATOR;
        Map<String, Object> backMap = new HashMap<>();
        String mainguid = (String) params.get("mainguid");
        String yearflag = (String) params.get("yearflag");
        String viewtype = (String) params.get("viewtype");
        String indexsql = " t.mainguid = ? and yearflag = ?";
        List<Map<String, Object>> collist = hbDeptIndexDAO.getCol(tablecode);
        List<Map<String, Object>> indexs = hbDeptIndexDAO.getDatas(tablecode, indexsql, "order by findex, isfixed, sindex, ordernum", new String[]{mainguid, yearflag});
        List<Map<String, Object>> tempdatas = hbDeptIndexDAO.getTempdatas();
        List<Map<String, Object>> fixedindexList = hbDeptIndexDAO.getFixedindex();
        boolean midsave = false;
        String hidButtons = "";
        if (indexs.size() == 0) {
            if (!"query".equals(viewtype)) {
                //业务表无数据，查询有暂存直接返回暂存
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if (midsavedata != null && midsavedata.get("result") != null){
                    indexs = (List<Map<String, Object>>) midsavedata.get("result");
                }
                if (indexs != null && indexs.size() > 0) {
                    for (Map<String, Object> map : indexs) {
                        for (Map<String, Object> dicdto : collist) {
                            String col = (String) dicdto.get("columncode");
                            String value = map.get(col) + "";
                            if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                                map.put(col, null);
                            }
                        }
                    }
                    logger.info("---指标：当前为草稿数据！");
                    midsave = true;
                }
            }
        } else {
            hidButtons = "暂存";
        }
        for (Map<String, Object> map : fixedindexList) {
            //固化指标和业务/草稿数据做对比,固化有，业务没存，展示出来
            String name = (String) map.get("name");
            List<Map<String, Object>> list = indexs.stream().filter(mm -> name.equals(mm.get("name"))).collect(Collectors.toList());
            if (list.size() == 0) {
                map.put("tindex", map.get("guid"));
                map.put("guid", this.getCreateguid());
                map.put("mainguid", mainguid);
                map.put("isfixed", 1);
                map.put("levelno", 3);
                map.put("yearflag", yearflag);
                indexs.add(map);
            }
        }
        if (!midsave) {
            for (Map<String, Object> map : tempdatas) {
                for (Map<String, Object> colmap : collist) {
                    String col = (String) colmap.get("columncode");
                    String value = map.get(col) + "";
                    if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                        map.put(col, null);
                    }
                }
            }
            if (indexs.size() > 0) {
                PerfUtil.listMapSort(indexs, null, "ordernum");
                tempdatas.addAll(indexs);
            }
            backMap.put("data", tempdatas);
        } else {
            backMap.put("data", indexs);
        }
        backMap.put("hidButtons", hidButtons);
        return backMap;
    }

    /**
     * 查询长期绩效指标
     * @param params --
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getIndexs(HashMap<String, Object> params) throws AppException {
        String tablecode = PerfConstant.BGT_V_TABLE_INDICATOR;
        String mainguid = (String) params.get("mainguid");
        String yearflag = (String) params.get("yearflag");
        String type = (String) params.get("type");
        String indexsql = " t.mainguid = ? and yearflag = ?";
        String orderby = " order by ordernum";
        String[] strs = new String[]{mainguid, yearflag};
        List<Map<String, Object>> indexs = hbDeptIndexDAO.getDatas(tablecode, indexsql, orderby, strs);
        if (StringUtil.isEmpty(type)) {//不是导入
            if (indexs.size() == 0) {
                //业务表无数据，查询有暂存直接返回暂存
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    indexs = (List<Map<String, Object>>) midsavedata.get("result");
                    indexs = indexs.stream().filter(mm -> "3".equals(mm.get("levelno") + "") || ("2".equals(mm.get("levelno") + "") && "6".equals(mm.get("findex")))).collect(Collectors.toList());
                }
            }
            for (Map<String, Object> ind : indexs) {
                ind.put("rowtype", "add");
                ind.put("yearflag", "0");
                String guid = StringUtil.createUUID();
                ind.put("guid", guid);
                ind.put("kpi_id", guid);
            }
        }
        return indexs;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String tablecode = PerfConstant.BGT_V_TABLE_INDICATOR;
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String mainguid = (String) params.get("mainguid");
        String yearflag = (String) params.get("yearflag");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> list = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        List<Map<String, Object>> addlist = new ArrayList<>();
        List<Map<String, Object>> uplist = new ArrayList<>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            String levelno = map.get("levelno") + "";
            map.put("ordernum", i++);
            map.put("yearflag", yearflag);
            if (rowtype != null && "add".equals(rowtype)) {
                if ("2".equals(levelno)) {
                    map.put("indexval", map.get("name"));
                }
                map.put("agencyguid", saveAgency);
                map.put("mainguid", mainguid);
                map.put("kpi_val", map.get("indexval"));
                if(StringUtil.isNullOrEmpty((String) map.get("kpi_content"))){
                    map.put("kpi_content",map.get("name")); //指标内容如果没有默认给指标名称
                }
                this.getBasMap(map,"add");
                addlist.add(map);
            } else if ("2".equals(levelno) && ("6".equals(map.get("findex"))) || "3".equals(levelno)){
                if ("2".equals(levelno)) {
                    map.put("indexval", map.get("name"));
                }
                map.put("agencyguid", saveAgency);
                map.put("mainguid", mainguid);
                map.put("kpi_val", map.get("indexval"));
                if(StringUtil.isNullOrEmpty((String) map.get("kpi_content"))){
                    map.put("kpi_content",map.get("name")); //指标内容如果没有默认给指标名称
                }
                this.getBasMap(map,null);
                uplist.add(map);
            }
        }
        Map<String, Object> nameDupCheckMap = this.checkNameDuplicate(datas);
        if(nameDupCheckMap != null && !nameDupCheckMap.isEmpty() && nameDupCheckMap.get("success").equals(false)){
            return nameDupCheckMap;
        }
        if (addlist.size() > 0) {
            hbDeptIndexDAO.setIndexCode(addlist);
            hbDeptIndexDAO.setIndexDatas(addlist,"DEPT",false);
            backMap = hbDeptIndexDAO.checkTacleColsIsNull(tablecode, addlist);
            backMap.putAll(this.checkColLength(addlist, tablecode));
            if (!backMap.isEmpty()) {
                return backMap;
            }
            hbDeptIndexDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            hbDeptIndexDAO.setIndexDatas(uplist,"DEPT",false);
            hbDeptIndexDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            StringBuffer delsql = new StringBuffer();
            List<String> delguids = new ArrayList<>();
            for (Map<String, Object> map : deldatas) {
                delguids.add((String) map.get("guid"));
            }
            delsql.append(hbDeptIndexDAO.createInSql("guid", delguids));
            hbDeptIndexDAO.updateIsDeleteDatas(tablecode, delsql.toString());
        }
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(list, busguid,"perf", null);
    }

    /**
     * <p>校验指标名称不可重复</p >
     * @param
     */
    public Map<String, Object> checkNameDuplicate(List<Map<String, Object>> indexList) {
        logger.info("---校验指标名称是否重复----start---");
        Map<String, Object> backMap = new HashMap<String, Object>();
        Map<String, Object> errMap = null;
        List<Map<String, Object>> errdata = new ArrayList<>();
        for (Map<String, Object> map : indexList) {
            String name = StringUtil.isNullOrEmpty(map.get("name")) ? "" : (String) map.get("name");
            List<Map<String, Object>> totalList1 = indexList.stream().filter(map1 -> name.equals(map1.get("name"))).collect(Collectors.toList());
            if (totalList1.size() > 1) {
                errMap = new HashMap<String, Object>();
                errMap.put("remark", "【" + name + "】指标名称重复" + totalList1.size() + "次，无法保存；");
                errMap.put("code", "002");
                errMap.put("name", "校验指标名称");
                errMap.put("explain", "指标名称不可重复");
                errdata.add(errMap);
            }
        }
        if (errdata != null && !errdata.isEmpty()) {
            errdata = errdata.stream().collect(Collectors.collectingAndThen(Collectors.toCollection(() ->
                    new TreeSet<>(Comparator.comparing((o) -> o.get("remark") + ""))), ArrayList::new)); // 去重
            logger.info("---errdata：" + errdata.toString());
            backMap.put("success", false);
            backMap.put("redata", errdata);
        }
        logger.info("---校验指标名称是否重复----end---");
        return backMap;
    }

    /**
     * 导入指标
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importIndexData(ArrayList<Map<String, Object>> impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            String type = (String) busParams.get("type");
            List<Map<String, Object>> errorlist = new ArrayList<>();
            if ("importfunc".equals(type)) {//二级指标不做校验
                ArrayList<Map<String, Object>> impindList = (ArrayList) impDatas.stream().filter(mm -> !StringUtil.isNullOrEmpty(mm.get("name"))).collect(Collectors.toList());
                errorlist.addAll(this.checkImpColNullable(impindList, impCols));
                StringBuffer error = null;
                FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
                for (Map<String, Object> data : impindList) {
                    error = new StringBuffer();
                    Integer linenum = (Integer) data.get("linenum");
                    String computesign = (String) data.get("computesign");
                    String indexval = (String) data.get("indexval");
                    String qnindexval = (String) data.get("qnindexval");
                    String snindexval = (String) data.get("snindexval");
                    String meterunit = (String) data.get("meterunit");
                    if ("1".equals(computesign) || "2".equals(computesign) || "3".equals(computesign) || "4".equals(computesign) || "5".equals(computesign)) {
                        if (!StringUtil.isNullOrEmpty(qnindexval) && !PerfUtil.isNumeric(qnindexval)) {
                            error.append("定量指标，前年指标值为数字 ");
                        }
                        if (!StringUtil.isNullOrEmpty(snindexval) && !PerfUtil.isNumeric(snindexval)) {
                            error.append("定量指标，上年指标值为数字 ");
                        }
                        if (!StringUtil.isNullOrEmpty(indexval) && !PerfUtil.isNumeric(indexval)) {
                            error.append("定量指标，指标值为数字 ");
                        }
                        if (StringUtil.isNullOrEmpty(meterunit)) {
                            error.append("定量指标，请填写计量单位 ");
                        }
                        if (!StringUtil.isEmpty(error.toString())) {
                            ImportErrorDTO dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, error.toString());
                            errordao.saveErrorMsg(dto);
                            errorlist.add(dto);
                        }
                    }
                }
            } else {
                errorlist.addAll(this.checkImpColNullable(impDatas, impCols));
                errorlist.addAll(this.checkIndexFrame(impDatas));
            }
            errorlist.addAll(this.checkImpColLength(impDatas, impCols));
            if (errorlist.size() > 0) {
                throw new AppException("ANA-ERROR", "指标导入数据错误");
            } else {
                HBDeptIndexBO hbDeptIndexBO = (HBDeptIndexBO) PerfServiceFactory.getBean("pmkpi.hbindex.HBDeptIndexBOTX");
                hbDeptIndexBO.impIndex(impDatas, impCols, tablecode, resultList, busParams);
            }
        }
    }

    public void impIndex( List<Map<String, Object>> impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        HBDeptIndexDAO hbDeptIndexDAO1 = (HBDeptIndexDAO) PerfServiceFactory.getBean("pmkpi.hbindex.HBDeptIndexDAO");
        String mainguid = (String) busParams.get("mainguid");
        String yearflag = (String) busParams.get("yearflag");
        String agencyguid = (String) busParams.get("agencyguid");
        String type = (String) busParams.get("type");
        List<Map<String, Object>> addList = new ArrayList<>();
        List<Map<String, Object>> indexs = this.getIndexs(busParams);
        List<Map<String, Object>> upList = new ArrayList<>();
        // 是否校验三级指标名称重复
        List<Map<String, Object>> errdata = new ArrayList<>();
        Map<String, Object> errMap = null;
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        for (Map<String, Object> data : impDatas) {
            //处理特殊字符
            data.put("name",PerfUtil.replaceSymbols((String) data.get("name")));
            data.put("indexval",PerfUtil.replaceSymbols((String) data.get("indexval")));
            data.put("perf_ind_name",PerfUtil.replaceSymbols((String) data.get("perf_ind_name")));
            data.put("kpi_val",PerfUtil.replaceSymbols((String) data.get("kpi_val")));
            if (StringUtil.isNullOrEmpty(data.get("name"))) {
                data.put("name", data.get("lv2_perf_ind_code"));
                data.put("levelno", 2);
                data.put("is_leaf", 0);
            } else {
                data.put("levelno", 3);
                data.put("is_leaf", 1);
            }
        }
        Map<String, Object> nameDupCheckMap = this.checkNameDuplicate(impDatas);
        if(nameDupCheckMap != null && !nameDupCheckMap.isEmpty() && nameDupCheckMap.get("success").equals(false)){
            errdata = (List<Map<String, Object>>) nameDupCheckMap.get("redata");
            ImportErrorDTO dto = null;
            for (Map<String, Object> err : errdata) {
                dto = new ImportErrorDTO(FileUploadService.fileguids.get(), 0, (String) err.get("remark"));
                errordao.saveErrorMsg(dto);
            }
            throw new AppException("ANA-ERROR", "指标名称重复，请检查");
        }
        Integer ordernum = 0;
        Map<String, Object> fixMap = new HashMap<>();
        List<Map<String, Object>> fixedindexList = hbDeptIndexDAO1.getFixedindex();
        for (Map<String, Object> map : fixedindexList) {
            Integer num = PerfUtil.mapGetInt(map, "ordernum");
            if (num > ordernum) {
                ordernum = num;
            }
            fixMap.put((String) map.get("name"), map);
        }
        Map<String, Object> indMap = new HashMap<>();
        for (Map<String, Object> map : indexs) {
            Integer num = PerfUtil.mapGetInt(map, "ordernum");
            if (num > ordernum) {
                ordernum = num;
            }
            indMap.put((String) map.get("name"), map);
        }
        //导入的和库中的做对比，存在修改，不存在，新增
        String sname = "";
        String sindexguid = "";
        String errorMsg = "";
        for (Map<String, Object> map : impDatas) {
            String name = (String) map.get("name");
            String findex = (String) map.get("findex");
            String sindex = (String) (StringUtil.isNullOrEmpty(map.get("sindex")) ? map.get("lv2_perf_ind_code") : map.get("sindex"));
            String isfixed = (String) map.get("isfixed");
            Integer linenum = (Integer) map.get("linenum");
            if (!"6".equals(findex) && "importfunc".equals(type)) {
                throw new AppException("ERROR", "请选择相应类型的导入文件，请检查");
            } else if ("6".equals(findex) && "import".equals(type)) {
                throw new AppException("ERROR", "请选择相应类型的导入文件，请检查");
            }
            Map<String, Object> data = (Map<String, Object>) indMap.get(name);
            if (data != null && !data.isEmpty()) { //修改
                String f = (String) data.get("findex");
                String s = null;
                if ("import".equals(type)) {
                    s = (String) data.get("sindex");
                } else {
                    isfixed = "2";
                    map.put("isfixed", isfixed);//修改时，只判断层级
                    String levelno = data.get("levelno") + "";
                    Map<String, Object> sMap = (Map<String, Object>) indMap.get(sindex);
                    if ("2".equals(levelno)) {
                        s = (String) data.get("name");
                        if (sMap != null && !sMap.isEmpty()) {
                            map = sMap;
                        }
                    } else {
                        if (sMap != null && !sMap.isEmpty()) {
                            if ("2".equals(sMap.get("levelno") + "")) {
                                s = (String) sMap.get("name");
                            } else {
                                errMap = new HashMap<>();
                                errMap.put("linenum", linenum);
                                errMap.put("remark", "二级指标：" + sindex + "不存在，请检查！");
                                errdata.add(errMap);
                                continue;
                            }
                        } else {
                            s = "";
                        }
                    }
                }
                if (findex.equals(f) && sindex.equals(s) && isfixed.equals(data.get("isfixed") + "")) {
                    data.putAll(map);
                    data.put("kpi_val", data.get("indexval"));
                    data.put("updatetime", PerfUtil.getServerTimeStamp());
                    data.put("update_time", PerfUtil.getServerTimeStamp());
                    upList.add(data);
                } else {
                    errorMsg = "三级指标名称：" + name + "与系统中现有的指标层级或固化类型不匹配，请核实修改后再进行导入";
                }
            } else { //不存在，新增
                Map<String, Object> m = null;
                if ("import".equals(type)) {
                    map.put("superid", sindex);
                    String guid = CommonUtil.createGUID();
                    m = (Map<String, Object>) fixMap.get(name);
                    if ("1".equals(isfixed)) {
                        if (m != null && !m.isEmpty()) {
                            String f = (String) m.get("findex");
                            String s = (String) m.get("sindex");
                            if (findex.equals(f) && sindex.equals(s)) {
                                m.put("tindex", m.get("guid"));
                                m.put("guid", guid);
                                m.put("isfixed", 1);
                                m.putAll(map);
                                addList.add(m);
                            } else {
                                errorMsg = "三级指标名称：" + name + "与系统中现有的指标层级不匹配，请核实修改后再进行导入";
                            }
                        } else {
                            errorMsg = "三级指标名称：" + name + "在固话指标未查找到，请核实修改后再进行导入";
                        }
                    } else {
                        if (m == null || m.isEmpty()) {
                            map.put("guid", guid);
                            map.put("isfixed", 2);
                            map.put("ordernum", ++ordernum);
                            addList.add(map);
                        } else {
                            errorMsg = "三级指标名称：" + name + "在固化指标中存在，请核实修改后再进行导入";
                        }
                    }
                } else if ("importfunc".equals(type)) {
                    //二级指标
                    m = (Map<String, Object>) indMap.get(sindex);
                    if ("2".equals(map.get("levelno") + "")) {
                        sname = sindex;
                        sindexguid = StringUtil.createUUID();
                        map.put("guid", sindexguid);
                        map.put("name", sname);
                        map.put("indexval", sname);
                        map.put("sindex", sindexguid);
                        map.put("lv2_perf_ind_code", sindexguid);
                        map.put("code", sindexguid);
                        map.put("superid", map.get("findex"));
                        map.put("isfixed", 2);
                        map.put("ordernum", ++ordernum);
                        addList.add(map);
                    } else {
                        String findexguid = "";
                        if (m != null && !m.isEmpty()) {
                            sindexguid = (String) m.get("sindex");
                            sname =  (String) m.get("name");
                            findexguid = (String) m.get("findex");
                        }
                        if (((!StringUtil.isNullOrEmpty(findexguid) && findex.equals(findexguid)) ||
                                (StringUtil.isNullOrEmpty(findexguid) && "6".equals(findex)))
                                && sname.equals(sindex)) {
                            map.put("guid", StringUtil.createUUID());
                            map.put("isfixed", 2);
                            map.put("sindex", sindexguid);
                            map.put("lv2_perf_ind_code", sindexguid);
                            map.put("ordernum", ++ordernum);
                            map.put("superid", map.get("sindex"));
                            map.put("code", "619999");
                            addList.add(map);
                        } else {
                            errorMsg = "二级指标：" + sindex + "不存在，请检查！";
                        }
                    }
                }
            }
            if (!StringUtil.isNullOrEmpty(errorMsg)) {
                errMap = new HashMap<>();
                errMap.put("linenum", linenum);
                errMap.put("remark", errorMsg);
                errdata.add(errMap);
                errorMsg = "";
            }
        }
        if (errdata.size() > 0) {
            ImportErrorDTO dto = null;
            for (Map<String, Object> err : errdata) {
                dto = new ImportErrorDTO(FileUploadService.fileguids.get(), (Integer) err.get("linenum"), (String) err.get("remark"));
                errordao.saveErrorMsg(dto);
            }
            throw new AppException("ANA-ERROR", "指标层级不匹配，请检查");
        }
        if (addList.size() > 0) {
            for (Map<String, Object> data : addList) {
                String guid = CommonUtil.createGUID();
                data.put("mainguid", mainguid);
                data.put("agencyguid", agencyguid);
                data.put("kpi_val", data.get("indexval"));
                data.put("yearflag", yearflag);
                if(StringUtil.isNullOrEmpty((String) data.get("kpi_content"))){
                    data.put("kpi_content", data.get("name")); //指标内容如果没有默认给指标名称
                }
                this.getBasMap(data,"add");
            }
            this.setIndexDatas(addList,"DEPT",false);
            this.setIndexCode(addList);
            hbDeptIndexDAO1.saveAll(addList, PerfConstant.BGT_V_TABLE_INDICATOR);
        }
        if (upList.size() > 0) {
            hbDeptIndexDAO1.updateAll(upList, PerfConstant.BGT_V_TABLE_INDICATOR);
        }

    }
}
