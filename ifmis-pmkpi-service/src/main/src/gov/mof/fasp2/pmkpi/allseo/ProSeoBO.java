package gov.mof.fasp2.pmkpi.allseo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProSeoBO extends PmkpiBO {

    private ProSeoDAO proSeoDAO;

    public void setProSeoDAO(ProSeoDAO proSeoDAO) {
        this.proSeoDAO = proSeoDAO;
    }

    /**
     * 获取左侧树数据.-临时表
     *
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        String tablecode = "V_PERF_PROJECT_YEAR";
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        //查询单位上级，合成左侧树
        List<Map<String, Object>> list = proSeoDAO.getLeftTree(tablecode, datarule);
        leftconfig.put("datas", list);
        return leftconfig;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String menuid = (String) sqlmap.get("menuid");
        String isleaf = (String) sqlmap.get("isleaf");
        String agency = (String) sqlmap.get("agency");
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter");
        String tablesql = (String) sqlmap.get("tablesql");
        String type = (String) sqlmap.get("type");
        String prolev = (String) sqlmap.get("prolev");
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null);
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t where 1=1 ");
        if (type != null && "1".equals(type)) { // 如果是事前绩效评估查询-V_COL12：1-是；2-否；
            sql.append(" and v_col12 = '1'");
        }
        if (!StringUtils.isEmpty(prolev)) { // 如果级别字段不为空则加入条件查询
            sql.append(" and pro_lev = '" + prolev + "'");
        }
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and ").append(tabfilter);
        }
        String columncode = "agencyguid";
        String leftwheresql = "";
        if("1".equals(isleaf)) {
            leftwheresql = " and t." + columncode + " ='" + agency + "' ";
        } else if (!"1".equals(isleaf) && !"treeroot".equals(agency)){
            leftwheresql = " and t." + columncode + " like'" + agency.substring(0,3) + "%' ";  //或者对 or 加括号
//            leftwheresql = " and exists (select * from (select guid from " + yearProgramQueryDAO.PMKPI_TABLE_T_AGENCY + " aaa start with aaa.superguid='" + agency + "' connect by prior aaa.guid = aaa.superguid)bbb where bbb.guid=t." + columncode + ") or t." + columncode + " ='" + agency + "' ";
        }
        sql.append(leftwheresql).append(datarule);
        return sql.toString();
    }


    /**
     * 列表查询.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String guid = (String) params.get("guid"); //节点组件id
        String pro_code = (String) params.get("pro_code");
        String proguid = (String) params.get("proguid");
        String  tablecode = "";
        String  filter = "";
        if ("totaldatatable".equals(guid)){
            tablecode = "PM_PERF_INDICATOR";
            filter = " mainguid = '" +proguid+ "' and yearflag = '1' and is_deleted = 2 and is_backup=2";
        }
        if ("yeardatatable".equals(guid)){
            tablecode = "V_PM_PERF_INDICATOR";
            filter = "  PRO_CODE = '" +pro_code+ "' and yearflag = '0'";
        }
        HashMap tempMap = new HashMap();
        tempMap.put("filter",filter);
        tempMap.put("tablecode",tablecode);
        tempMap.put("nodeguid", guid);
        tempMap.put("procode",pro_code);
        backMap = this.getIndexData(tempMap);
        return backMap;
    }

    /**
     * 对应的指标信息.
     * @param params -- 前端参数
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String,Object> getIndexData(HashMap<String,Object> params) throws AppException{
        Map<String, Object> backMap = new HashMap<String, Object>();
        String filter = (String)params.get("filter");
        String tablecode = (String)params.get("tablecode");
        String nodeguid = (String)params.get("nodeguid");
        String procode = (String)params.get("procode");
        //获取模板数据
        List<Map<String, Object>> collist = proSeoDAO.getCol("V_PM_PERF_INDICATOR");
        List<Map<String, Object>> tempdatas = proSeoDAO.getTempdatas();
        //指标数据
        List<Map<String, Object>> indexdatas = proSeoDAO.getDatas(tablecode, filter, " order by ordernum");
        List<Map<String,Object>> datas = new ArrayList<>();
        //模板数据
        for (Map<String, Object> tempdata : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = tempdata.get(col) + "";
                if (value == null || gov.mof.fasp2.buscore.framework.util.StringUtils.isEmpty(value) || "null".equals(value)) {
                    tempdata.put(col, "");
                }
            }
            tempdata.put("_isleaf", "1");
            tempdata.put("actualvalue", "");
            datas.add(tempdata);
        }
        //年度绩效处理自评完成值
        List<Map<String,Object>> selfList = null;
        Map<String,String> selfValue = new HashMap<>();
        if ("yeardatatable".equals(nodeguid)) {
            StringBuffer sql = new StringBuffer("select t.actualvalue,t.code from v_perf_t_selfperfindex t where ");
            sql.append(" exists (select 1 from v_perf_t_selfevaltask c where c.bustype = 'program' and c.pro_code = '");
            sql.append(procode);
            sql.append("' and c.guid = t.mainguid)");
            selfList = proSeoDAO.queryForList(sql.toString());
            selfList.forEach(r->{
                selfValue.put((String) r.get("code"), (String) r.get("actualvalue"));
            });
        }
        //指标数据
        String tmpcode = "";
        for (Map<String, Object> indexdata : indexdatas) {
            tmpcode = (String) indexdata.get("code");
            if (selfValue.containsKey(tmpcode)){
                indexdata.put("actualvalue", selfValue.get(tmpcode));
            }
            datas.add(indexdata);
        }
        backMap.put("data",datas);
        return  backMap;
    }

    /**
     * 编辑区查询.
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String guid = (String) params.get("guid"); //节点组件id
        String code = (String) params.get("code"); //多次监控,code是监控的任务id.
        String pro_code = (String) params.get("pro_code");
        String proguid = (String) params.get("proguid");
        String  tablecode = "";
        String  filter = "";
        String  order = "";
        if ("baseditform".equals(guid)) { //项目的基本信息.
            tablecode = "V_PERF_PROJECT_INFO";
            filter = "  PRO_CODE = '" + pro_code + "'";
        }
        if ("totaleditform".equals(guid)) { //总体目标
            tablecode = "PM_PERF_GOAL_INFO";
            filter = "  mainguid = '" + proguid + "' and yearflag = '1' and is_deleted = 2 and is_backup=2";
        }
        if ("yeareditform".equals(guid)) { //年度目标
            tablecode = "V_PM_PERF_GOAL_INFO";
            filter = "  PRO_CODE = '" + pro_code + "' and yearflag = '0'";
        }
        if (guid.startsWith("monitoreditform")){ //监控结论
            tablecode = "V_PERF_T_PROTRACEANALYSIS";
            filter = "  mainguid = '" + code + "'";
        }
        if ("selfeditform".equals(guid)) { //自评价
            tablecode = "V_PERF_T_SELFPERFDESC";
            filter = "  PRO_CODE = '" + pro_code + "'";
        }
        if ("deptevaleditform".equals(guid)) { //部门评价
            tablecode = "V_PERF_T_DEPTEVALUATION";
            filter = "  PRO_CODE = '" + pro_code + "'";
        }
        if ("finaneditform".equals(guid)) { //财政评价
            tablecode = "V_PERF_T_FINEVALUATION";
            filter = "  PRO_CODE = '" + pro_code + "'";
        }
        List list =  proSeoDAO.getDatas(tablecode, filter, order);
        Map map = new HashMap();
        if (list.size() > 0){
            map = (Map) list.get(0);
        }
        if (guid.startsWith("monitoreditform")) { //监控结论
            String bgtwarn = (String) map.get("bgtwarn");
            String goalwarn = (String) map.get("goalwarn");
            if(StringUtils.isEmpty(bgtwarn) || StringUtils.isEmpty(goalwarn)){
                List promonitorlist =  proSeoDAO.getDatas("V_PERF_T_PROMONITOR", " guid = '" + code + "'", order);
                if (promonitorlist.size() > 0){
                    Map promonitormap = (Map) promonitorlist.get(0);
                    bgtwarn = !StringUtils.isEmpty(promonitormap.get("bgtwarn")) ? (String) promonitormap.get("bgtwarn") : bgtwarn;
                    goalwarn = !StringUtils.isEmpty(promonitormap.get("goalwarn")) ? (String) promonitormap.get("goalwarn") : goalwarn;
                }
            }
            if ("red".equals(bgtwarn)) {
                bgtwarn = "红色";
            } else if ("yellow".equals(bgtwarn)) {
                bgtwarn = "黄色";
            } else if ("green".equals(bgtwarn)) {
                bgtwarn = "绿色";
            } else if ("blue".equals(bgtwarn)) {
                bgtwarn = "蓝色";
            }else{
                bgtwarn = "";
            }
            if ("red".equals(goalwarn)) {
                goalwarn = "红色";
            } else if ("yellow".equals(goalwarn)) {
                goalwarn = "黄色";
            } else if ("green".equals(goalwarn)) {
                goalwarn = "绿色";
            } else if ("blue".equals(goalwarn)) {
                goalwarn = "蓝色";
            }else{
                goalwarn = "";
            }
            map.put("bgtwarn",bgtwarn);
            map.put("goalwarn",goalwarn);
        }
        backMap.put("data", map);
        return backMap;
    }

    /**
     * 获取项目全流程节点.
     * @param  pro_code -- 项目编码
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> getProNodes(String pro_code) throws AppException {
        List<Map<String, Object>> eledatas = proSeoDAO.getDatas("v_perf_t_datasource", "elementcode='proallseo'", "order by ordernum");
        List<Map<String, Object>> taskdata = proSeoDAO.getMainGuid(pro_code);
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        List<Map<String, Object>> data = new ArrayList<>();
        for (Map<String, Object> eledata : eledatas) {
            data.add(eledata);
        }
        Map tempMap = null;
        int i = 0;
        for (Map<String, Object> taskdatum : taskdata) {
            i++;
            tempMap = new HashMap();
            tempMap.put("guid","monitoreditform"+i);
            tempMap.put("code",taskdatum.get("guid"));
            tempMap.put("name",taskdatum.get("name"));
            tempMap.put("superguid","protrace");
            tempMap.put("levelno","2");
            tempMap.put("isleaf","1");
            data.add(tempMap);
        }
        leftconfig.put("name", "业务阶段");
        //leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.FALSE);
        leftconfig.put("datas", data);
        leftconfig.put("outformart", "#name");
        leftconfig.put("expandlevel", 2);
        return leftconfig;
    }
}
