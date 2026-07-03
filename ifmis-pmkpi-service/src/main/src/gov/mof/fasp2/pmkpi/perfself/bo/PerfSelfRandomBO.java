package gov.mof.fasp2.pmkpi.perfself.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfcommon.expdoc.IExpDocABO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.math.BigInteger;
import java.util.*;

public class PerfSelfRandomBO extends PmkpiBO {
    private PerfSelfApplyDAO perfSelfApplyDAO;

    public void setPerfSelfApplyDAO(PerfSelfApplyDAO perfSelfApplyDAO) {
        this.perfSelfApplyDAO = perfSelfApplyDAO;
    }

    /**
     * 表格的查询语句.
     *
     * @param sqlmap -- map.
     * @return
     * @throws AppException -- 自定义异常.
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String defquery = (String) sqlmap.get("defquery");
        String menuId = (String) sqlmap.get("menuId");
        String isleaf = (String) sqlmap.get("isleaf");
        String saveAgency = (String) sqlmap.get("saveAgency");
        String dept_code = (String) sqlmap.get("dept_code");
        //获取数据权限
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", null); //数据权限
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where 1 = 1 ");
//        if (type != null && "check".equals(type)) {
//            if ("waitaudit".equals(tabcode)) {
//                sql.append(" and (is_extract is null or is_extract = '') ");
//            } else if ("alreadyaudit".equals(tabcode)) {
//                sql.append(" and is_extract = '1' ");
//            }
//        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and (").append(tabfilter).append(")");
        }
        if (defquery != null && !defquery.isEmpty()){
            sql.append(" and ").append(defquery);
        }
        if (dept_code != null && !dept_code.isEmpty()) {
            sql.append(" and ( dept_code ='").append(dept_code).append("')");
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, perfSelfApplyDAO.PMKPI_TABLE_T_AGENCY));
        sql.append(datarule);
        return sql.toString();
    }

    /**
     * 获取左侧树数据.
     * @param menuId -- 菜单.
     * @return --
     */
    @SuppressWarnings({"unchecked"})
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String sql = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        List datas = perfSelfApplyDAO.getLeftTree("PERF_V_SELFRANDOM", sql);
        leftconfig.put("datas", datas);
        return leftconfig;
    }

    public Map<String, Object> getLeftData(String menuId,String dept_code) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        StringBuffer wheresql = new StringBuffer();
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        wheresql.append(datarule);
        wheresql.append(" and ( dept_code ='").append(dept_code).append("')");
        wheresql.append(" and ( is_extract is null or is_extract = '' or is_extract = '2')");
        List datas = perfSelfApplyDAO.getLeftTree("V_PERF_T_SELFEVALTASK", wheresql.toString());
        leftconfig.put("datas", datas);
        return leftconfig;
    }

    public List<Map<String, Object>> getTreeData(HashMap params) throws AppException {
        String menuId = (String) params.get("menuId");
        String dept_code = (String) params.get("dept_code");
        String tabfilter = (String) params.get("tabfilter");
        StringBuffer wheresql = new StringBuffer();
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        wheresql.append(datarule);
        wheresql.append(" and ( dept_code ='").append(dept_code).append("')");
        if (tabfilter != null && !tabfilter.isEmpty()) {
            wheresql.append(" and (").append(tabfilter).append(")");
        }
        return perfSelfApplyDAO.getLeftTree("V_PERF_T_SELFEVALTASK", wheresql.toString());
    }

    public Map selfRandom(HashMap config) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String) config.get("tablecode");
        String busguid = (String) config.get("busguid");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
        List<Map<String, Object>> randomDatas = new ArrayList<>();
        for (Map<String, Object> data : datas) {
            List<Map<String, Object>> list = perfSelfApplyDAO.getDatas("V_PERF_T_SELFEVALTASK", " dept_code = '"+data.get("dept_code")+"'","");
            for (Map<String, Object> map : list) {
                map.put("is_extract","2"); // 2-非抽取项目
                map.put("extract_type","");
                map.put("updatetime",PerfUtil.getServerTimeStamp());
            }
            perfSelfApplyDAO.updateAll(list,"V_PERF_T_SELFEVALTASK");
            List<Map<String, Object>> randomElements = getRandomElements(list, (Integer) data.get("self_count2"));
            for (Map<String, Object> map : randomElements) {
                map.put("is_extract","1"); // 1-抽取项目
                map.put("extract_type","1"); // 1-自动抽取；2-人工选取
                map.put("updatetime",PerfUtil.getServerTimeStamp());
            }
            randomDatas.addAll(randomElements);
        }
        perfSelfApplyDAO.updateAll(randomDatas,"V_PERF_T_SELFEVALTASK");
        backMap.put("success", true);
        return backMap;
    }

    public Map selfsue(HashMap config) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
        List<Map<String, Object>> randomDatas = new ArrayList<>();
        for (Map<String, Object> data : datas) {
            String wheresql = "dept_code = '"+data.get("dept_code")+"' and is_deleted = 2 ";
            List<Map<String, Object>> list = perfSelfApplyDAO.getDatas("V_PERF_T_SELFEVALTASK", wheresql,"");
            for (Map<String, Object> map : list) {
                map.put("is_sue","1"); // 1-已下发；2-未下发
                map.put("updatetime",PerfUtil.getServerTimeStamp());

            }
            randomDatas.addAll(list);
        }
        perfSelfApplyDAO.updateAll(randomDatas,"V_PERF_T_SELFEVALTASK");
        backMap.put("success", true);
        return backMap;
    }

    public Map selfsueoff(HashMap config) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
        List<Map<String, Object>> randomDatas = new ArrayList<>();
        for (Map<String, Object> data : datas) {
            String wheresql = "dept_code = '"+data.get("dept_code")+"' and is_sue = '1' and is_deleted = 2 ";
            List<Map<String, Object>> list = perfSelfApplyDAO.getDatas("V_PERF_T_SELFEVALTASK", wheresql,"");
            for (Map<String, Object> map : list) {
                String str = (String) map.get("wfstatus");
                if(str != null && str != ""){
                    backMap.put("success", false);
                    backMap.put("error", data.get("dept_name")+"部门中存在已填报的数据，无法取消下发！");
                    return backMap;
                }
                map.put("is_sue","2"); // 1-已下发；2-未下发
                map.put("updatetime",PerfUtil.getServerTimeStamp());
            }
            randomDatas.addAll(list);
        }
        perfSelfApplyDAO.updateAll(randomDatas,"V_PERF_T_SELFEVALTASK");
        backMap.put("success", true);
        return backMap;
    }

    public Map<String, Object> addrandom(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = (String) parms.get("tablecode");
        for (Map<String, Object> map : datas) {
            map.put("is_extract","1"); // 1-抽取项目
            map.put("extract_type","2"); // 1-自动抽取；2-人工选取
            map.put("updatetime",PerfUtil.getServerTimeStamp());
        }
        perfSelfApplyDAO.updateAll(datas,tablecode);
        backMap.put("success", true);
        return backMap;
    }


    public Map<String, Object> delrandom(HashMap<String, Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) parms.get("datas");
        String tablecode = (String) parms.get("tablecode");
        for (Map<String, Object> map : datas) {
            map.put("is_extract","2");
            map.put("extract_type",""); // 1-自动抽取；2-人工选取
            map.put("updatetime",PerfUtil.getServerTimeStamp());
        }
        perfSelfApplyDAO.updateAll(datas,tablecode);
        backMap.put("success", true);
        return backMap;
    }

    /**
     * 从List中随机抽取指定数量的不重复元素
     * @param data 原始List
     * @param count 需要抽取的数量
     * @return 抽取后的List
     */
    public static List<Map<String, Object>> getRandomElements(List<Map<String, Object>> data, int count) {
        List<Map<String, Object>> randomElements = new ArrayList<>();
        Random random = new Random();
        // 处理边界情况
        if (data == null || data.isEmpty() || count <= 0) {
            return randomElements;
        }
        if (count >= data.size()) {
            // 如果要抽取的数量大于等于原始列表大小，则返回原列表的副本
            return new ArrayList<>(data);
        }
        // 使用Set来确保抽取的元素不重复
        Set<Integer> selectedIndices = new HashSet<>();
        while (selectedIndices.size() < count) {
            int index = random.nextInt(data.size());
            selectedIndices.add(index);
        }
        // 根据选中的索引获取元素
        for (int index : selectedIndices) {
            randomElements.add(data.get(index));
        }
        return randomElements;
    }

}
