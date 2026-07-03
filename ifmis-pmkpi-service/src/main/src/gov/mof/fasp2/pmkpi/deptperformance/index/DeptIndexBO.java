package gov.mof.fasp2.pmkpi.deptperformance.index;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:18 2020/8/24  chongdayong
 */
public class DeptIndexBO extends PmkpiBO {
    private DeptIndexDAO deptIndexDAO;

    public void setDeptIndexDAO(DeptIndexDAO deptIndexDAO) {
        this.deptIndexDAO = deptIndexDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        String modelguid = (String) params.get("modelguid");
        String isnewapply = (String) params.get("isnewapply");
        String saveAgency = (String) params.get("saveAgency");
        String viewtype = (String) params.get("viewtype");//查询状态
        String indexsql = " t.mainguid = '" + mainguid + "'";
        String orderby = " order by ordernum";
        List<Map<String, Object>> collist = deptIndexDAO.getCol(tablecode);
        List<Map<String, Object>> indexs = deptIndexDAO.getDatas(tablecode, indexsql, orderby);
        String hidButtons = "";
        boolean midsave = false;
        if(!"query".equals(viewtype)){//查询状态不加载暂存数据
            if (indexs == null || indexs.size() <= 0) {
                //业务表无数据，查询有暂存直接返回暂存
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    indexs = (List<Map<String, Object>>) midsavedata.get("result");
                    logger.info("---部门整体指标：当前为草稿数据！");
                    midsave = true;
                }
            }else{
                logger.info("---部门整体指标：当前为业务数据！隐藏保存草稿按钮");
                hidButtons = "暂存";
            }
        }
        if (!StringUtils.isEmpty(isnewapply) && "true".equals(isnewapply)) {
            if(indexs.isEmpty()){
                String caseSql = "select t.* from v_perf_t_case_enum t where t.bustype = 'DEPT' and t.agencyguid = '" + saveAgency + "'";
                List<Map<String, Object>> caseList = deptIndexDAO.queryForList(caseSql);
                if (caseList != null && !caseList.isEmpty()) {
                    String caseguid = (String) caseList.get(0).get("guid");
                    String caseIndexSql = "select t.*, t.indexvalue as indexval,'add' as rowtype from v_perf_t_casemodelindex t where nvl(t.status, 2) <> 3 and t.mainguid = '" + caseguid + "'  order by t.sindex,t.findex,t.ordernum";
                    indexs = deptIndexDAO.queryForList(caseIndexSql);
                    for (Map<String, Object> map : indexs) {
                        map.put("tindex", map.get("guid"));
                        map.put("guid", this.getCreateguid());
                        map.put("mainguid", mainguid);
                    }
                }
            }
        }
        List<Map<String, Object>> tempdatas = deptIndexDAO.getTempdatas();
        List<Map<String, Object>> modeldatas = deptIndexDAO.getModeldatas(modelguid, tablecode, mainguid);
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        Map<String, Object> sumMap = new HashMap<String, Object>();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        List<Map<String, Object>> tempList = null;
        String sindex = "";
        String findex = "";
        String fsuperid = "";
        String ssuperid = "";
        float sweightsum = 0;
        float fweightsum = 0;
        for (Map<String, Object> map : modeldatas) {
            map.put("tindex", map.get("guid"));
            map.put("guid", this.getCreateguid());
            map.put("mainguid", mainguid);
            indexs.add(map);
        }
        if(midsave){//只过滤暂存数据中的三级指标，层级和模板后面拼接
            indexs = indexs.stream().filter(m -> "3".equals(String.valueOf(m.get("levelno")))).collect(Collectors.toList());
        }
        for (Map<String, Object> map : indexs) {
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            findex = (String) map.get("findex");
            sindex = (String) map.get("sindex");
            String weight = map.get("weight") + "";
            if (findex.equals(fsuperid)) {
                if (weight != null && !"null".equals(weight) && !StringUtils.isEmpty(weight)) {
                	Float num = Float.parseFloat(weight);
                    fweightsum = fweightsum + num;
                	fweightsum=(float)(Math.round(fweightsum*100))/100;
                }
            } else {
                if (weight != null && !"null".equals(weight) && !StringUtils.isEmpty(weight)) {
                    if (ssuperid != null && !"null".equals(ssuperid) && !StringUtils.isEmpty(ssuperid)) {
                        if (fsuperid != null && !"null".equals(fsuperid) && !StringUtils.isEmpty(fsuperid)) {
                            fweightsum = 0;
                        }
                    }
                	Float num = Float.parseFloat(weight);
                    fweightsum =  + num;
                    fweightsum=(float)(Math.round(fweightsum*100))/100;
                }
            }
            if (sindex.equals(ssuperid)) {
                if (weight != null && !"null".equals(weight) && !StringUtils.isEmpty(weight)) {
                	Float num = Float.parseFloat(weight);
                    sweightsum = sweightsum + num;
                    sweightsum=(float)(Math.round(sweightsum*100))/100;
                }
            } else {
                if (weight != null && !"null".equals(weight) && !StringUtils.isEmpty(weight)) {
                    if (ssuperid != null && !"null".equals(ssuperid) && !StringUtils.isEmpty(ssuperid)) {
                        if (fsuperid != null && !"null".equals(fsuperid) && !StringUtils.isEmpty(fsuperid)) {
                            sweightsum = 0;
                        }
                    }
                    Float num = Float.parseFloat(weight);
                    sweightsum = num;
                    sweightsum=(float)(Math.round(sweightsum*100))/100;
                }
            }
            map.put("superid", sindex);
            if (!indexMap.containsKey(sindex)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(sindex, tempList);
            } else {
                tempList = indexMap.get(sindex);
            }
            tempList.add(map);

            ssuperid = sindex;
            fsuperid = findex;
            sumMap.put(sindex, sweightsum);
            sumMap.put(findex, fweightsum);

        }
        sindex = "";
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    map.put(col, null);
                }
            }
            map.put("_isleaf", "1");
            String levelno = map.get("levelno") + "";
            if (levelno != null && !StringUtils.isEmpty(levelno) && !"null".equals(levelno) && "2".equals(levelno)) {
                sindex = (String) map.get("guid");
                map.put("weight",sumMap.get(sindex));
            } else if (levelno != null && !StringUtils.isEmpty(levelno) && !"null".equals(levelno) && "1".equals(levelno)) {
                findex = (String) map.get("guid");
                map.put("weight",sumMap.get(findex));
                sindex = "";
            }
            backdata.add(map);
            if (indexMap.containsKey(sindex)) {
                tempList = indexMap.get(sindex);
                backdata.addAll(tempList);
            }
        }
        backMap.put("data", backdata);
        backMap.put("hidButtons", hidButtons);
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
        String mainguid = (String) params.get("mainguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> list = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(deptIndexDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        List<Map<String, Object>> indexList = new ArrayList<>();
        for (Map<String, Object> map : datas) {
            String levelno = map.get("levelno") + "";
            String name = (String) map.get("name");
            if ("3".equals(levelno) && !StringUtil.isEmpty(name)) {
                String rowtype = (String) map.get("rowtype");
                map.put("ordernum", i++);
                String weight = map.get("weight") + "";
                if (weight != null && !StringUtils.isEmpty(weight) && !"null".equals(weight)) {
                    weight = map.get("weight").toString();
                    map.put("weight", Float.parseFloat(weight));
                }
                if (weight==null||StringUtils.isEmpty(weight)){
                    map.put("weight", 0);
                }
                if (rowtype != null && "add".equals(rowtype)) {
                    map.put("agencyguid", saveAgency);
                    map.put("mainguid", mainguid);
                    map.put("kpi_val", map.get("indexval"));
                    map.put("status", "");
                    if(StringUtil.isNullOrEmpty((String) map.get("kpi_content"))){
                        map.put("kpi_content",map.get("name")); //指标内容如果没有默认给指标名称
                    }
                    this.getBasMap(map,"add");
                    map.put("is_last_inst",2);//是否终审
                    addlist.add(map);
                } else {
                    map.put("updatetime", PerfUtil.getServerTimeStamp());
                    map.put("update_time", PerfUtil.getServerTimeStamp());
                    uplist.add(map);
                }
                indexList.add(map);
            }
        }
        if (PerfUtil.getIsuCheckIndexName()) { // 是否校验三级指标名称重复
            //校验指标名称不可重复
            Map<String, Object> nameDupCheckMap = this.nameDuplicateCheck(indexList);
            if(nameDupCheckMap != null && !nameDupCheckMap.isEmpty() && nameDupCheckMap.get("success").equals(false)){
                return nameDupCheckMap;
            }
        }
        if (addlist.size() > 0) {
            deptIndexDAO.setIndexCode(addlist);
            deptIndexDAO.setIndexDatas(addlist,"DEPT",false);
            deptIndexDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            deptIndexDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            deptIndexDAO.saveAll(deldatas, deptIndexDAO.PMKPI_TABLE_TMP_GUIDS);
            String upsql = " exists(select 1 from " + deptIndexDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            deptIndexDAO.updateIsDeleteDatas(tablecode, upsql);
        }
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable("PERF_TMP_AUDITERRORINFO");
            createTmpTable("PERF_TMP_DEPTFUNCERROR");
            createTmpTable("PERF_TMP_AUDITINDEXERROR");
        }
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(list, busguid,"perf", null);
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
        List<Map<String, Object>> indexlib = deptIndexDAO.getDatas("perf_t_indexlib", indexWhereSql, null);
        indexWhereSql = " t.sindex = '" + sindex + "' and t.agencyguid = '" + agencyguid + "'";
        List<Map<String, Object>> deptindexlib = deptIndexDAO.getDatas("perf_t_deptindexlib", indexWhereSql, null);
        if (indexlib != null && indexlib.size() > 0) {
            data.addAll(indexlib);
        }
        if (deptindexlib != null && deptindexlib.size() > 0) {
            data.addAll(deptindexlib);
        }
        backMap.put("data", data);
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
    public void importIndexData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            List<Map<String, Object>> errorlist = this.checkImpColLength(impDatas, impCols);
            errorlist.addAll(this.checkIndexFrame(impDatas));
            errorlist.addAll(this.checkDeptIndex(impDatas));
            if (errorlist.size() > 0) {
                throw new AppException("ANA-ERROR", "指标导入数据错误");
            } else {
                DeptIndexBO deptIndexBO = (DeptIndexBO) PerfServiceFactory.getBean("pmkpi.deptperformance.index.DeptIndexBOTX");
                deptIndexBO.impIndex(deptIndexBO, impDatas, impCols, tablecode, resultList, busParams);
            }
        }
    }

    /**
     * 申报阶段额外的导入校验
     * @return
     */
    public List<Map<String, Object>> checkDeptIndex(List<Map<String, Object>> datas) throws AppException {
        List<Map<String, Object>> errorlist = new ArrayList<>();
        int j = 1;
        StringBuffer error = null;
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto = null;
        for (Map data : datas) {
            error = new StringBuffer();
            ++j;
            String indexval = (String) data.get("indexval");
            if (StringUtil.isEmpty(indexval)) {
                error.append("请填写指标值 ");
            }
            if (!StringUtil.isEmpty(error.toString())) {
                dto = new ImportErrorDTO(FileUploadService.fileguids.get(), j, error.toString());
                errordao.saveErrorMsg(dto);
                errorlist.add(dto);
            }
        }
        return errorlist;
    }

    public void impIndex(DeptIndexBO deptIndexBO, ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        DeptIndexDAO deptIndexDAO = (DeptIndexDAO) PerfServiceFactory.getBean("pmkpi.deptperformance.index.DeptIndexDAO");
        String tabtype = (String) busParams.get("tabtype");
        String proguid = (String) busParams.get("proguid");
        String agencyguid = (String) busParams.get("agencyguid");
        List<Map<String, Object>> indexList = new ArrayList<>();
        for (Object indexMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) indexMap;
            //处理特殊字符
            data.put("name",PerfUtil.replaceSymbols((String) data.get("name")));
            data.put("indexval",PerfUtil.replaceSymbols((String) data.get("indexval")));
            data.put("perf_ind_name",PerfUtil.replaceSymbols((String) data.get("perf_ind_name")));
            data.put("kpi_val",PerfUtil.replaceSymbols((String) data.get("kpi_val")));
            String guid = CommonUtil.createGUID();
            data.put("guid", guid);
            data.put("kpi_id", guid);
            data.put("mainguid", proguid);
            data.put("agency_code", agencyguid);
            data.put("agencyguid", agencyguid);
            data.put("findex", data.get("findex"));
            data.put("superid", data.get("sindex"));
            data.put("sindex", data.get("sindex"));
            data.put("name", data.get("name"));
            data.put("indexval", data.get("indexval"));
            data.put("kpi_val", data.get("indexval"));
            data.put("meterunit", data.get("meterunit"));
            data.put("computesign", data.get("computesign"));
            data.put("kpi_remark", data.get("kpi_remark"));
            data.put("levelno", 3);
            data.put("is_leaf", 1);
            this.getBasMap(data,"add");
            data.put("is_last_inst",2);//是否终审
            indexList.add(data);
        }
        deptIndexDAO.setIndexDatas(indexList,"DEPT",false);
        deptIndexBO.setIndexCode(indexList);
        deptIndexDAO.saveAll(indexList, "v_bgt_perf_indicator");
    }

    /**
     * <p>判断当前部门是否使用新的指标填报页面</p >
     *
     * @author hw
     * @date 2022/6/30 14:38
     * @param
     */
    public String isNewApply() {
        String flag = "false";
        String agencyguid = SecureUtil.getCurrentUser().getAgency();
        String newApplyDepts = PerfUtil.getSystemSet("NEWAPPLYDEPTS_DEPT");  // 部门整体-指定部门实行新的指标填报方式
        if (!StringUtils.isEmpty(newApplyDepts) && !StringUtils.isEmpty(agencyguid) && agencyguid.length() >= 3) {
            Map<String, Object> tabMap = JsonUtils.jsonToMap(newApplyDepts);
            String agencys = (String) tabMap.get("agencys");
            String[] split = agencys.split(",");
            List<String> list = Arrays.asList(split);
            agencyguid = agencyguid.substring(0, 3);
            flag = list.contains(agencyguid) + "";
        }
        return flag;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getProIndexs(Map<String, Object> params) throws AppException {
        String agency_code = (String) params.get("agency_code");
        String querySql = (String) params.get("querySql");
        String defquery = (String) params.get("defquery");
        String treesource = PerfUtil.getSystemSet("dept_letftree");
        StringBuffer wheresql = new StringBuffer();
        if ("PMKPIDEPT".equals(treesource)) {
            wheresql.append(" dept_code=?");
        } else {
            wheresql.append(" agency_code=?");
        }
        if (!StringUtil.isEmpty(querySql)) {
            wheresql.append(" and ").append(querySql);
        }
        if (!StringUtil.isEmpty(defquery)) {
            wheresql.append(" and ").append(defquery);
        }
        List<Map<String, Object>> proList = this.getDatas(deptIndexDAO.PMKPI_TABLE_PROJECT_INFO, wheresql.toString(), null, new String[]{agency_code});
        List<String> procodeList = proList.stream().map(row -> row.get("pro_code")).filter(Objects::nonNull).map(Object::toString).collect(Collectors.toList());
        List<Map<String, Object>> indexList = new ArrayList<>();
        if (procodeList != null && !procodeList.isEmpty()) {
            wheresql = new StringBuffer();
            wheresql.append(" perf_obj_type_code='2'");
            wheresql.append(" and ").append(deptIndexDAO.createInSql("pro_code", procodeList));
            String orderby = " order by pro_code, lv1_perf_ind_code, lv2_perf_ind_code";
            indexList = this.getDatas(PerfConstant.PMKPI_VPM_INDICATOR, wheresql.toString(), orderby);
            Set<String> procodes = new HashSet<>();
            for (Map<String, Object> map : indexList) {
                String pro_code = (String) map.get("pro_code");
                map.put("superguid", pro_code);
                map.put("pro_name", null);
                map.put("pro_code", null);
                map.put("version_name", null);
                map.put("levelno", "2");
                procodes.add(pro_code);
            }
            proList = proList.stream().filter(m -> procodes.contains(m.get("pro_code"))).collect(Collectors.toList());
            indexList.addAll(proList);
        }
        return indexList;
    }

}
