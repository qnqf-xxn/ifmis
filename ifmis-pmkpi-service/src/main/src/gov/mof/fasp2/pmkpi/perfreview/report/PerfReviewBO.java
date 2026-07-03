package gov.mof.fasp2.pmkpi.perfreview.report;

import com.jspsmart.upload.File;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfcommon.impexp.IImpExpABO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.poi.hssf.usermodel.HSSFCell;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.util.*;
import java.util.stream.Collectors;

public class PerfReviewBO extends PmkpiBO implements IImpExpABO {

    private PerfReviewDAO perfReviewDAO;

    public void setPerfReviewDAO(PerfReviewDAO perfReviewDAO) {
        this.perfReviewDAO = perfReviewDAO;
    }

    public Map<String, Object> getTreeData(String menuId,String lefttypes) throws AppException {
        Map leftconfig = new HashMap();
        List<String> dics = new ArrayList<String>();
        if(StringUtils.isEmpty(lefttypes)){
            dics.add("program");
            dics.add("dept");
        }else{
            String[] leftArry = lefttypes.split(",");
            dics = Arrays.asList(leftArry);
        }
        Object[] tabs = new Object[dics.size()];

        for (int i = 0; i < dics.size(); i++) {
            //List<DicRangeDTO> value = null;
            String elementcode = dics.get(i);
            leftconfig = new HashMap();
            List<Map<String, Object>> list = new ArrayList<>();
            Map<String, Object> map = new HashMap<>();
            map.put("guid","treeroot");
            map.put("code","00");
            map.put("name","全部");
            map.put("superid","0");
            map.put("levelno","1");
            map.put("isleaf","0");
            list.add(map);
            leftconfig.put("datas", list);
            leftconfig.put("showRootNode", Boolean.TRUE);
            leftconfig.put("dosearch", Boolean.FALSE);
            leftconfig.put("outformart", "#code-#name");
            leftconfig.put("expandlevel", 2);
            Map f1 = new HashMap();
            if ("program".equals(elementcode)) {
                leftconfig.put("name", "项目支出");
                f1.put("name", "项目支出");
            } else if ("dept".equals(elementcode)) {
                leftconfig.put("name", "部门整体");
                f1.put("name", "部门整体");
            }else if("zyzfprogram".equals(elementcode)){//转移支付项目支出
                leftconfig.put("name", "转移项目支出");
                f1.put("name", "转移项目支出");
            }
            f1.put("code", elementcode);
            f1.put("click", "tabChange");
            f1.put("treeinfo", leftconfig);
            tabs[i] = f1;
        }
        Map m = new HashMap();
        m.put("onlydata", Boolean.TRUE);
        m.put("activeTab", 0);
        m.put("dosearch", Boolean.TRUE);
        m.put("tabs", tabs);
        return m;
    }

    /**
     * 查询单位树.
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String menuId = (String) params.get("menuid");
        String tablecode = (String) params.get("tablecode");
        String lefttabtype = (String) params.get("lefttabtype");
        String datarule = this.getDataRuleByMenuguid(menuId, "t", " t.type = '" + lefttabtype + "' ");
        //根据权限查询单位
        return perfReviewDAO.getLeftTree(tablecode, datarule);
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String type = (String) (sqlmap.get("type") == null ? sqlmap.get("pagetype") : sqlmap.get("type"));
        if (type != null && "batchadd".equals(type)) {
            return this.getBatchAdd(sqlmap);
        } else if ("expertquery".equals(type) || "expert".equals(type)){//查询专家
            return this.getExpert(sqlmap);
        } else {
            return this.getReport(sqlmap);
        }
    }

    public String getExpert(Map sqlmap){
        String tablecode = (String) sqlmap.get("tablecode");
        StringBuffer wf = new StringBuffer("select * from ").append(tablecode);
        return wf.toString();
    }

    /**
     * 批量提交数据查询
     * @return
     */
    public String getBatchAdd(Map sqlmap) throws AppException {
        String bustype = (String) sqlmap.get("bustype");
        String wheresql = "";
        String deptbgtaudit = PerfUtil.getSystemSet("DEPTBGTAUDIT");
        Map<String, Object> mm = PerfUtil.parseString2Map(deptbgtaudit);
        String czwfstatus = (String) mm.get("czwfstatus");
        if("zyzfprogram".equals(bustype)){
            czwfstatus = (String) mm.get("zyzfczwfstatus");
        }
        String tablecode = "";
        wheresql = " a.pro_code=t.pro_code ";
        if ("dept".equals(bustype)) {
            tablecode = "perf_bgt_dept";
            wheresql = " a.proguid=t.guid ";
        } else if ("program".equals(bustype)){
            tablecode = "perf_pdm_project";
        } else if ("zyzfprogram".equals(bustype)){
            tablecode = "perf_pdm_tranpayproject";
        }
        StringBuffer wf = null;
        if (!StringUtil.isEmpty(czwfstatus)) {
            wf = new StringBuffer();
            String[] wfstatus = czwfstatus.split(",");
            for (String str : wfstatus) {
                wf.append("'").append(str).append("',");
            }
            wf.deleteCharAt(wf.length() - 1);
        } else {
            wf = new StringBuffer("''");
        }
        String agencysql = "";
        if ("dept".equals(bustype)) {
            agencysql = perfReviewDAO.getDeptAgencyDatas(wf.toString());
        } else if("zyzfprogram".equals(bustype)){
            agencysql = perfReviewDAO.getProCodeDatas(wf.toString());
        }else{
            agencysql = perfReviewDAO.getProAgencyDatas(wf.toString());
        }
        wheresql += " and a.type='" + bustype + "'";
        String sql = "select * from " + tablecode + " t where exists(" + agencysql + ") and not exists(select 1 from v_perf_t_review a where " + wheresql + ")";
        if("zyzfprogram".equals(bustype)){
            sql = "select * from " + tablecode + " t where exists(" + agencysql + ") and not exists(select 1 from v_perf_t_review a where " + wheresql + ") and t.taskguid='4B67D882C7AE41CC951D761853827E9C'";
        }
        return sql;
    }

    /**
     * 列表查询
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public String getReport(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String columncode = "agencyguid";
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t where t.type = '").append(lefttabtype).append("'");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
        if (!StringUtil.isEmpty(wheresql)) {
            returnsql.append(" and ").append(wheresql);
        }
        if (!StringUtil.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (!StringUtil.isEmpty(wfsql)) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, perfReviewDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }

    /**
     * 保存评审
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String,Object> savereviewdatas (HashMap<String, Object> params) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        String workflow = (String) params.get("workflow");
        String bustype = (String) params.get("bustype");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> mainList = new ArrayList<>();
        List<Map<String, Object>> subList = new ArrayList<>();
        List<Map<String, Object>> backList = new ArrayList<>();
        List<Map<String, Object>> addList = new ArrayList<>();
        List<String> reGuidList = new ArrayList<>();
        boolean isconfirm = true;//是否确认
        String wheresql = "";
        String tablecode = "v_perf_t_review";
        List<Map<String, Object>> list = new ArrayList<>();
        Map<String, Object> m = null;
        if (datas != null && datas.size() > 0) {
            //判断是否存在评审未终审数据
            for (Map<String, Object> map : datas) {
                m = new HashMap<>();
                String procode = (String) map.get("pro_code");
                String proguid = (String) (map.get("mainguid") == null ? map.get("proguid") : map.get("mainguid"));
                if ("dept".equals(bustype)) {
                    m.put("guid", proguid);
                    list.add(m);
                } else {
                    m.put("guid", procode);
                    list.add(m);
                }
            }
            perfReviewDAO.saveAll(list, perfReviewDAO.PMKPI_TABLE_TMP_GUIDS);
            String qsql =  " t.type = '" + bustype + "' and t.islast = '1' and exists(select 1 from " + perfReviewDAO.PMKPI_TABLE_TMP_GUIDS + " a where ";
            if ("dept".equals(bustype)) {
                wheresql = " t.proguid = a.guid ";
            } else {
                wheresql = " t.pro_code = a.guid";
            }
            qsql += wheresql;
            qsql += ")";

            //获取所有主单数据
            List<Map<String, Object>> reviewList = perfReviewDAO.getDatas(tablecode, qsql, null);
            Map reviewMap = new HashMap();
            for (Map<String, Object> map : reviewList) {
                String reproguid = "";
                if ("dept".equals(bustype)) {
                    reproguid = (String) (map.get("mainguid") == null ? map.get("proguid") : map.get("mainguid"));
                } else {
                    reproguid = (String) map.get("pro_code");
                }
                reviewMap.put(reproguid, map);
            }
            for (Map<String, Object> map : datas) {
                String dataproguid = "";
                if ("dept".equals(bustype)) {
                    dataproguid = (String) (map.get("mainguid") == null ? map.get("proguid") : map.get("mainguid"));
                } else {
                    dataproguid = (String) map.get("pro_code");
                }

                //判断是否已存在评审数据
                if (reviewMap.containsKey(dataproguid)) {//存在
                    Map reMap = (Map) reviewMap.get(dataproguid);
                    //退回
                    if ("1".equals(reMap.get("isback"))) {
                        reMap.put("isback", "2");
                        backList.add(reMap);
                    } else if (!"1".equals(reMap.get("isconfirm"))) { //是否确认
                        isconfirm = false;
                        break;
                    } else {
                        reGuidList.add((String) reMap.get("guid"));
                        addList.add(this.setData(map, bustype, mainList, subList));
                    }
                } else {//不存在进行新增
                    addList.add(this.setData(map, bustype, mainList, subList));
                }
            }
            if (!isconfirm) {
                backMap.put("returnval", "存在未评审完成数据！！");
                backMap.put("success", false);
                return backMap;
            }
            if (addList.size() > 0) {
                if (reGuidList.size() > 0) {
                    //修改项目数据是否最后一次
                    String guids = reGuidList.stream().map(s -> "\'" + s + "\'").collect(Collectors.joining(", "));
                    String usql = " guid in (" + guids + ")";
                    perfReviewDAO.updateislast(usql, bustype);
                }
                this.workflow("create",workflow, "", tablecode, addList);
                this.workflow("sendaudit",workflow, "", tablecode, addList);
            }
            if (backList.size() > 0) {
                this.workflow("sendaudit",workflow, "", tablecode, backList);
                List columns = new ArrayList();
                columns.add("isback");
                perfReviewDAO.updateAllByPK(columns, backList, "guid", tablecode);
            }
            if (mainList.size() > 0) {
                perfReviewDAO.saveAll(mainList, PmkpiDAO.PMKPI_TABLE_T_AUDITMAIN);
            }
            if (subList.size() > 0) {
                perfReviewDAO.saveAll(subList, PmkpiDAO.PMKPI_TABLE_T_AUDITITEMS);
            }
        }
        backMap.put("returnval", "保存成功！！");
        backMap.put("success", true);
        return backMap;
    }

    private Map<String, Object> setData(Map<String, Object> map, String bustype, List<Map<String, Object>> mainList, List<Map<String, Object>> subList){
        String wheresql = "";
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        String procode = (String) map.get("pro_code");
        String mainguid = (String) (map.get("mainguid") == null ? map.get("proguid") : map.get("mainguid"));
        String saveAgency = (String) (map.get("saveAgency") == null ? map.get("agencyguid") : map.get("saveAgency"));
        String guid = this.getCreateguid();
        if ("dept".equals(bustype)) {
            wheresql = " t.proguid = '" + mainguid + "' ";
        } else {
            wheresql = " t.pro_code = '" + procode + "'";
        }
        //查询第几次评审
        int count = perfReviewDAO.findReviewNum(wheresql, bustype);
        map.put("guid", guid);
        map.put("type", bustype);
        map.put("createtime", PerfUtil.getServerTimeStamp());
        map.put("updatetime", PerfUtil.getServerTimeStamp());
        map.put("creater", user.getGuid());
        map.put("province", SecureUtil.getUserSelectProvince());
        map.put("year", CommonUtil.getYear());
        map.put("agencyguid", saveAgency);
        map.put("status", "1");
        map.put("proguid", mainguid);
        map.put("pro_code", procode);
        map.put("islast", 1);
        map.put("reviewnum", count + 1);
        map.put("isconfirm","2");
        map.put("isback","2");
        map.put("wfstatus", "");
        if("zyzfprogram".equals(bustype) || "program".equals(bustype)){//项目
            Map<String,Object> proMap = perfReviewDAO.getDataMap(perfReviewDAO.PMKPI_TABLE_ALLPROJECT_INFO," pro_code = '"+procode+"'");
            if(!proMap.isEmpty()){
                map.put("manage_dept_code",proMap.get("manage_dept_code"));
                map.put("manage_mof_dep_code",proMap.get("manage_mof_dep_code"));
                map.put("mof_dep_code",proMap.get("mof_dep_code"));
                map.put("dept_code",proMap.get("dept_code"));
                map.put("agency_code",proMap.get("agency_code"));
            }
        }
        if (count > 0) {
            //如果不是第一次评审，查询初次评审的意见进行保存
            Map<String, Object> opMap = perfReviewDAO.getFirstReview(wheresql, bustype, count);
            List<Map<String, Object>> mList = (List<Map<String, Object>>) opMap.get("mainlist");
            if (mList != null && mList.size() > 0) {
                for (Map<String, Object> mm : mList) {
                    mm.put("guid", this.getCreateguid());
                    mm.put("mainguid", guid);
                    mm.put("createtime", PerfUtil.getServerTimeStamp());
                    mm.put("updatetime", PerfUtil.getServerTimeStamp());
                    mainList.add(mm);
                }
            }
            List<Map<String, Object>> slist = (List<Map<String, Object>>) opMap.get("sublist");
            if (slist != null && slist.size() > 0) {
                for (Map<String, Object> mm : slist) {
                    mm.put("guid", this.getCreateguid());
                    mm.put("mainguid", guid);
                    mm.put("createtime", PerfUtil.getServerTimeStamp());
                    mm.put("updatetime", PerfUtil.getServerTimeStamp());
                    subList.add(mm);
                }
            }
        }
        return map;
    }

    /**
     * 查询已选专家；
     * @param params
     * @return
     */
    public List<Map<String,Object>> queryselexpert (HashMap<String, Object> params){
        String mainguid = (String) params.get("mainguid");
        String wheresql = " t.mainguid = '" + mainguid + "' ";
        return perfReviewDAO.getDatas("v_perf_selexpert",wheresql,null);
    }

    /**
     * 委托专家保存
     * @param params
     * @return
     */
    public void saveEntrust (HashMap<String, Object> params) throws AppException {
        List<Map<String,Object>> datas = (List<Map<String,Object>>) params.get("datas");//专家数据
        List<Map<String,Object>> prodatas = (List<Map<String,Object>>) params.get("prodatas");//主单数据
        String tablecode = "v_perf_expertreview";
        List<Map<String,Object>> list = new ArrayList<>();
        Map<String,Object> mm = null;
        List<String> mainguids = new ArrayList<>();
        for (Map<String, Object> m : prodatas) {
            String mainguid = (String) m.get("guid");
            for (Map<String, Object> map : datas) {
                mm = new HashMap<>();
                mm.put("guid", this.getCreateguid());
                if (!StringUtil.isEmpty((String) map.get("expertguid"))) {
                    mm.put("expertguid", map.get("expertguid"));
                } else {
                    mm.put("expertguid", map.get("guid"));
                }
                mm.put("mainguid", mainguid);
                mm.put("proguid", m.get("proguid"));
                mm.put("isgroup", map.get("isgroup"));
                mm.put("createtime", PerfUtil.getServerTimeStamp());
                mm.put("updatetime", PerfUtil.getServerTimeStamp());
                mm.put("code", map.get("code"));
                mm.put("name", map.get("name"));
                mm.put("status", 1);
                mm.put("creater", SecureUtil.getCurrentUserID());
                mm.put("year", SecureUtil.getUserSelectYear());
                mm.put("province", SecureUtil.getUserSelectProvince());
                list.add(mm);
            }
            mainguids.add(mainguid);
        }
        String delsql = perfReviewDAO.createInSql("mainguid", mainguids);
        perfReviewDAO.delDatas(tablecode, delsql);
        perfReviewDAO.saveAll(list,tablecode);
    }

    /**
     * 删除选择专家
     * @param params
     * @return
     */
    public void delEntrust (HashMap<String, Object> params) throws AppException{
        List<Map<String,Object>> datas = (List<Map<String,Object>>) params.get("datas");//已选专家数据
        List<Map<String,Object>> prodatas = (List<Map<String,Object>>) params.get("prodatas");//主单数据
        String tablecode = "v_perf_expertreview";
        List<String> mainguids = new ArrayList<>();
        List<String> guids = new ArrayList<>();
        for (Map<String, Object> m : datas) {
            String guid = (String) m.get("guid");
            guids.add(guid);
        }
        for (Map<String, Object> m : prodatas) {
            String mainguid = (String) m.get("guid");
            mainguids.add(mainguid);
        }
        String delsql = perfReviewDAO.createInSql("mainguid", mainguids) + " and " + perfReviewDAO.createInSql("guid", guids);
        perfReviewDAO.delDatas(tablecode, delsql);
    }

    /**
     * 委托专家审核；
     * @param params
     * @return
     */
    public Map<String,Object> auditEntrust (HashMap<String, Object> params) throws AppException {
        String workflow  = (String) params.get("workflow");
        String busguid  = (String) params.get("busguid");
        String remark  = (String) params.get("remark");
        List<Map<String,Object>> prodatas = (List<Map<String,Object>>) params.get("prodatas");//主单数据
        String maintablecode  = (String) params.get("maintablecode");
        if (prodatas != null && !prodatas.isEmpty()) {
            prodatas.forEach(map -> {
                map.put("audittype", "2");
            });
            List<String> cols = new ArrayList<>();
            cols.add("audittype");
            perfReviewDAO.updateAll(cols, prodatas, maintablecode);
            this.workflow("audit", workflow, remark, maintablecode, prodatas);
        }
        return this.auditdefine(prodatas, busguid, "perf", null);
    }

    /**
     * 委托专家保存并审核；
     * @param params
     * @return
     */
    public Map<String,Object> saveauditEntrust (HashMap<String, Object> params) throws AppException {
        this.saveEntrust(params); //保存
        //审核
        return this.auditEntrust(params);
    }

    /**
     * 确认评审
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> confirm (HashMap<String, Object> params) throws AppException {
        List<Map<String,Object>> data = (List<Map<String,Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String busguid = (String) params.get("busguid");
        String tablecode = "v_perf_t_review";
        this.workflow("audit", workflow, null, tablecode, data);
        perfReviewDAO.saveAll(data,perfReviewDAO.PMKPI_TABLE_TMP_AGENCY);
        //查询终审的数据
        String sql = "  exists(select 1 from "+perfReviewDAO.PMKPI_TABLE_TMP_AGENCY+
                "  a where t.guid =a.guid) ";
        perfReviewDAO.updateconfirm(tablecode, "isback", sql, "2");
        sql += "and t.wfstatus='011'";
        List<Map<String, Object>> reviewList = perfReviewDAO.getDatas(tablecode, sql, null);
        if (reviewList.size() > 0) {
            //修改确认标识
            perfReviewDAO.saveAll(reviewList,perfReviewDAO.PERF_TABLE_TMP_PARAM);
            String wheresql = "  exists(select 1 from "+perfReviewDAO.PERF_TABLE_TMP_PARAM+
                    "  a where t.guid =a.guid)";
            perfReviewDAO.updateconfirm(tablecode, "isconfirm", wheresql, "1");
        }
        //同步修改项目库评审结论，先注释掉，目前项目库没有使用该功能
//        String isProview = PerfUtil.getSystemSet("isProview");
//        if ("1".equals(isProview)) {
//            List<Map<String,Object>> list = new ArrayList<>();
//            Map<String,Object> m = null;
//            for (Map<String, Object> map : reviewList) {
//                m = new HashMap<>();
//                String proguid = (String) map.get("proguid");
//                m.put("guid", proguid);
//                list.add(m);
//            }
//            perfReviewDAO.saveAll(list,perfReviewDAO.PMKPI_TABLE_TMP_GUIDS);
//            perfReviewDAO.updateProOpenion("v_pm_project_info");
//        }
        return this.auditdefine(data, busguid, "perf", null);
    }

    /**
     * 取消确认评审
     * @param params
     * @return
     * @throws AppException
     */
    public void unconfirm (HashMap<String, Object> params) throws AppException {
        List<Map<String,Object>> data = (List<Map<String,Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String btncode = (String) params.get("btncode");
        this.workflow(btncode, workflow, null, "v_perf_t_review", data);
        perfReviewDAO.saveAll(data,perfReviewDAO.PMKPI_TABLE_TMP_AGENCY);
        String wheresql = "  exists(select 1 from "+perfReviewDAO.PMKPI_TABLE_TMP_AGENCY+
                "  a where t.guid =a.guid)";
        String col = "";
        String flag = "2";
        if ("back".equals(btncode)) {
            col = "isback";
            flag = "1";
        } else {
            col = "isconfirm";
        }
        perfReviewDAO.updateconfirm("v_perf_t_review", col, wheresql, flag);
        //同步修改项目库评审结论
        String isProview = PerfUtil.getSystemSet("isProview");
        if ("1".equals(isProview)) {
            List<Map<String,Object>> list = new ArrayList<>();
            Map<String,Object> m = null;
            for (Map<String, Object> map : data) {
                m = new HashMap<>();
                String proguid = (String) map.get("proguid");
                m.put("guid", proguid);
                list.add(m);
            }
            perfReviewDAO.saveAll(list,perfReviewDAO.PMKPI_TABLE_TMP_GUIDS);
            perfReviewDAO.updateProOpenion("v_pm_project_info");
        }
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
        return null;
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
        String impexpcode = (String) paras.get("impexpcode");
        if (datas != null && datas.size() > 0) {
            String wheresql = "";
            List<Map<String, Object>> prolist = new ArrayList<>();
            Map<String, Object> proMap = null;
            Map<String, Object> opinionMap = new HashMap<>();
            List<Map<String, Object>> mainList = new ArrayList<>();//主单审核意见
            List<Map<String, Object>> subList = new ArrayList<>();//子单审核意见
            for (Object obj : datas) {
                proMap = new HashMap<>();
                Map<String, Object> map = (Map<String, Object>) obj;
                String str = "";
                if ("dept".equals(impexpcode)) {
                    str = (String) map.get("agencyguid");
                    proMap.put("guid", str);
                } else {
                    str = (String) map.get("pro_code");
                    proMap.put("guid", str);
                }
                opinionMap.put(str, map);
                prolist.add(proMap);
            }
            if ("dept".equals(impexpcode))  {
                wheresql = " and exists(select 1 from v_perf_t_deptperfdeclare a where a.guid=t.proguid ) and exists(select 1 from " + perfReviewDAO.PMKPI_TABLE_TMP_GUIDS + " b where b.guid=t.agencyguid) ";
            } else {
                wheresql = " and exists(select 1 from " + perfReviewDAO.PMKPI_TABLE_ALLPROJECT_INFO + " a where a.pro_code=t.pro_code ) and exists(select 1 from " + perfReviewDAO.PMKPI_TABLE_TMP_GUIDS + " b where b.guid=t.pro_code) ";
            }
            wheresql += " and t.type='" + impexpcode + "' ";
            //保存所有项目
            perfReviewDAO.saveAll(prolist, perfReviewDAO.PMKPI_TABLE_TMP_GUIDS);
            //根据项目查询绩效目标评审在途数据，不包含已确认数据,并删除审核已经
            List<Map<String, Object>> reList = perfReviewDAO.getReviewData(wheresql);
            for (Map<String, Object> reMap : reList) {
                String mainguid = (String) reMap.get("guid");
                String proguid = (String) reMap.get("proguid");
                String agencyguid = (String) reMap.get("agencyguid");
                String procode = (String) reMap.get("pro_code");
                String reviewnum = (String) reMap.get("reviewnum");
                Map<String, Object> impopMap = null;
                if ("dept".equals(impexpcode)) {
                    wheresql = " t.proguid = '" + proguid + "' ";
                    impopMap = (Map<String, Object>) opinionMap.get(agencyguid);
                } else {
                    wheresql = " t.pro_code = '" + procode + "'";
                    impopMap = (Map<String, Object>) opinionMap.get(procode);
                }
                Map<String, Object> mainMap = null;
                Map<String, Object> subMap = null;
                String year = CommonUtil.getYear();
                String province = SecureUtil.getUserSelectProvince();
                String tiem = PerfUtil.getServerTimeStamp();
                if ("1".equals(reviewnum)) { //初审进行新增
                    List<Map<String, Object>> templist = perfReviewDAO.getReviewTemp();
                    for (Map<String, Object> tempMap : templist) {
                        subMap = new HashMap<>();
                        subMap.put("tempguid", tempMap.get("guid"));
                        subMap.put("guid", this.getCreateguid());
                        subMap.put("mainguid", mainguid);
                        subMap.put("year", year);
                        subMap.put("province", province);
                        subMap.put("createtime", tiem);
                        subMap.put("updatetime", tiem);
                        subMap.put("status", 1);
                        subMap.put("type", impexpcode);
                        if (!impopMap.isEmpty()) {
                            subMap.put("freview", impopMap.get("code" + tempMap.get("ordernum")));
                        }
                        subList.add(subMap);
                    }
                    mainMap = new HashMap<>();
                    mainMap.put("guid", this.getCreateguid());
                    mainMap.put("type", impexpcode);
                    mainMap.put("year", year);
                    mainMap.put("mainguid", mainguid);
                    mainMap.put("province", province);
                    mainMap.put("createtime", tiem);
                    mainMap.put("updatetime", tiem);
                    if (!impopMap.isEmpty()) {
                        mainMap.put("fopinion", impopMap.get("opinion"));
                    }
                    mainList.add(mainMap);
                } else { // 复审对初审数据进行查询，把导入的值放到复审字段中
                    //如果不是第一次评审，查询初次评审的意见进行保存
                    Map<String, Object> opMap = perfReviewDAO.getFirstReview(wheresql, impexpcode, Integer.parseInt(reviewnum)-1);
                    List<Map<String, Object>> mList = (List<Map<String, Object>>) opMap.get("mainlist");
                    //是否存在初审意见，不存在就进行新增
                    if (mList != null && mList.size() > 0) {
                        for (Map<String, Object> mm : mList) {
                            mm.put("guid", this.getCreateguid());
                            mm.put("mainguid", mainguid);
                            mm.put("createtime", PerfUtil.getServerTimeStamp());
                            mm.put("updatetime", PerfUtil.getServerTimeStamp());
                            if (!impopMap.isEmpty()) {
                                mm.put("sopinion", impopMap.get("opinion"));
                            }
                            mainList.add(mm);
                        }
                    } else {
                        mainMap = new HashMap<>();
                        mainMap.put("guid", this.getCreateguid());
                        mainMap.put("type", impexpcode);
                        mainMap.put("year", year);
                        mainMap.put("mainguid", mainguid);
                        mainMap.put("province", province);
                        mainMap.put("createtime", tiem);
                        mainMap.put("updatetime", tiem);
                        if (!impopMap.isEmpty()) {
                            mainMap.put("fopinion", impopMap.get("opinion"));
                        }
                        mainList.add(mainMap);
                    }
                    List<Map<String, Object>> slist = (List<Map<String, Object>>) opMap.get("sublist");
                    if (slist != null && slist.size() > 0) {
                        for (Map<String, Object> mm : slist) {
                            if (!impopMap.isEmpty()) {
                                mm.put("sreview", impopMap.get("code" + mm.get("ordernum")));
                            }
                            mm.put("guid", this.getCreateguid());
                            mm.put("mainguid", mainguid);
                            mm.put("createtime", PerfUtil.getServerTimeStamp());
                            mm.put("updatetime", PerfUtil.getServerTimeStamp());
                            subList.add(mm);
                        }
                    } else {
                        List<Map<String, Object>> templist = perfReviewDAO.getReviewTemp();
                        for (Map<String, Object> tempMap : templist) {
                            subMap = new HashMap<>();
                            subMap.put("tempguid", tempMap.get("guid"));
                            subMap.put("guid", this.getCreateguid());
                            subMap.put("mainguid", mainguid);
                            subMap.put("year", year);
                            subMap.put("province", province);
                            subMap.put("createtime", tiem);
                            subMap.put("updatetime", tiem);
                            subMap.put("status", 1);
                            subMap.put("type", impexpcode);
                            if (!impopMap.isEmpty()) {
                                subMap.put("freview", impopMap.get("code" + tempMap.get("ordernum")));
                            }
                            subList.add(subMap);
                        }
                    }
                }
            }
            if (mainList.size() > 0) {
                perfReviewDAO.saveAll(mainList, PmkpiDAO.PMKPI_TABLE_T_AUDITMAIN);
            }
            if (subList.size() > 0) {
                perfReviewDAO.saveAll(subList, PmkpiDAO.PMKPI_TABLE_T_AUDITITEMS);
            }
        }
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
        List<Map<String, Object>> list = this.getDatas("v_perf_t_reviewtemp","","order by ordernum");
        List<Map<String, Object>> collist = new ArrayList<>();
        Map<String, Object> map = null;
        if (list != null && list.size() > 0) {
            for (Map<String, Object> m : list) {
                map = new HashMap<>();
                map.put("columncode", "code"+m.get("ordernum"));
                map.put("name", m.get("name"));
                map.put("head", "审核结论");
                map.put("type", "tree");
                map.put("csid", "PMKPIREVIEW");
                map.put("importds", "1");
                collist.add(map);
            }
        }
        return collist;
    }

    /**
     * 浙江获取所有关于标记过得重点项目的pro_code
     * @return
     */
    public List<String> getSinglist(){
        StringBuffer sql = new StringBuffer();
        sql.append("select pro_code from V_PERF_SIGN_PROJECT_INFO group by pro_code");
        List<String> signList =  perfReviewDAO.queryForList(sql.toString());
        return signList;
    }
    public List<String> getAlreadReview(String type){
        StringBuffer sql = new StringBuffer();
        sql.append("select pro_code from V_perf_t_review where type = '").append(type).append("' group by pro_code");
        List<String> signList =  perfReviewDAO.queryForList(sql.toString());
        return signList;
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

    /**
     * 抓取未评审信息
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String,Object> batchadd (HashMap<String, Object> params) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String bustype = (String) params.get("bustype");
        String workflow = (String) params.get("workflow");
        for (Map<String, Object> map : datas) {
            String procode = (String) map.get("pro_code");
            String mainguid = (String) map.get("guid");
            String saveAgency = (String) map.get("agencyguid");
            //当前登录用户
            UserDTO user = SecureUtil.getCurrentUser();
            map.put("guid", this.getCreateguid());
            map.put("type", bustype);
            map.put("createtime", PerfUtil.getServerTimeStamp());
            map.put("updatetime", PerfUtil.getServerTimeStamp());
            map.put("creater", user.getGuid());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("agencyguid", saveAgency);
            map.put("status", "1");
            map.put("proguid", mainguid);
            map.put("pro_code", procode);
            map.put("islast", 1);
            map.put("reviewnum", 1);
            map.put("isconfirm","2");
            map.put("isback","2");
        }
        if (datas.size() > 0) {
            this.workflow("create",workflow, "", "v_perf_t_review", datas);
            this.workflow("sendaudit",workflow, "", "v_perf_t_review", datas);
        }
        backMap.put("success", true);
        return backMap;
    }
}
