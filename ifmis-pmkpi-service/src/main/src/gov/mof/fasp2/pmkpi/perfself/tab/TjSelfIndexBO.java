package gov.mof.fasp2.pmkpi.perfself.tab;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.util.StringUtils;

import java.util.*;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:45 2020/8/24  chongdayong
 */
public class TjSelfIndexBO extends PmkpiBO {
    private SelfIndexDAO selfIndexDAO;

    public void setSelfIndexDAO(SelfIndexDAO selfIndexDAO) {
        this.selfIndexDAO = selfIndexDAO;
    }

    /**
     * 查询主表目标数据.
     * @param params -- 参数。
     * @return
     * @throws AppException -- 自定义异常
     */
    public Map<String, Object> getDeptMainDatas(HashMap<String, Object> params) throws AppException {
        Map backMap = new HashMap(); //返回消息
        String mainguid = (String)params.get("mainguid");
        String proguid = (String)params.get("proguid"); // 部门申报主键
        String viewtype = (String) params.get("viewtype");//查询状态
        String orderby = " order by ordernum";
        //1.自评部门目标
        StringBuffer goalSql = new StringBuffer(" t.mainguid = '" + mainguid + "' ");
        List<Map<String, Object>> goals = selfIndexDAO.getDatas(selfIndexDAO.TABLE_GOAL_SELF, goalSql.toString(), orderby);
        if(goals==null||goals.isEmpty()){
            // 如果自评业务没有目标则取部门最新目标
            goalSql = new StringBuffer(" t.mainguid = '" + proguid + "' ");
            goals = selfIndexDAO.getDatas(selfIndexDAO.TABLE_GOAL_DEPT, goalSql.toString(), orderby);
        }
        StringBuffer indexSql = new StringBuffer(" t.mainguid = '" + mainguid + "' and goalguid is not null");
        //2.自评部门指标业务数据
        List<Map<String, Object>> indexs = selfIndexDAO.getDatas(selfIndexDAO.TABLE_INDEX_SELF, indexSql.toString(), orderby);
        if(!"query".equals(viewtype)) {//查询状态不加载暂存数据
            //业务表无数据，查询有暂存返回暂存
            if(indexs == null || indexs.size()==0){
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    indexs = (List<Map<String, Object>>) midsavedata.get("result");
                    backMap.put("yeargoals", indexs);
                    return backMap;
                }
            }else{
                backMap.put("hidButtons", "暂存");
            }
        }
        //3.自评部门指标数据
        if(indexs == null || indexs.isEmpty()){
            indexs = selfIndexDAO.getDatas(selfIndexDAO.TABLE_INDEX_DEPT, goalSql.toString(), orderby);
            if(!indexs.isEmpty()){
                indexs.forEach(r -> {
                    r.put("goalguid", r.get("kpi_dep_id"));
                });
            }
        }
        List<Map<String, Object>> tempdatas = selfIndexDAO.getTempdatas(mainguid,"DEPT"); //模板信息
        List<Map<String, Object>> collist = selfIndexDAO.getCol(selfIndexDAO.TABLE_INDEX_SELF);
        List yeargoals = new ArrayList(); // 年度
        String goalguid;
        String sindex;
        String key;
        List goalindexs; //目标指标对应.
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>(); //
        List tempindex;
        for (Map<String, Object> map : indexs) {
            goalguid = (String) map.get("goalguid");
            sindex = (String) map.get("sindex");
            key = goalguid+"#"+sindex;
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            map.put("superguid", sindex);
            map.put("superid", sindex);
            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            if (indexMap.containsKey(key)){
                tempindex = indexMap.get(key);
                tempindex.add(map);
            } else {
                tempindex = new ArrayList();
                tempindex.add(map);
                indexMap.put(key, tempindex);
            }
        }
        for (Map<String, Object> map : goals) {
            goalguid = (String) map.get("guid");
            goalindexs = new ArrayList();
            List<Map> tempdatalist = new ArrayList();
            JSONArray jsonArray = JSONArray.parseArray(JSONObject.toJSONString(tempdatas));
            List<Map> jsonlist = jsonArray.toJavaList(Map.class);
            tempdatalist.addAll(jsonlist);
            for (Map<String, Object> tepmap : tempdatalist) {
                for (Map<String, Object> colmap : collist) {
                    String col = (String) colmap.get("columncode");
                    String value = tepmap.get(col) + "";
                    if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                        tepmap.put(col, "");
                    }
                }
                String levelno = tepmap.get("levelno") + "";
                goalindexs.add(tepmap);
                if (!StringUtils.isEmpty(levelno) && "2".equals(levelno)) {
                    sindex = (String) tepmap.get("guid");
                    key = goalguid+"#"+sindex;
                    if (indexMap.containsKey(key)) {
                        tempindex = indexMap.get(key);
                        goalindexs.addAll(tempindex);
                    }
                }
                tepmap.put("mainguid", mainguid);
                tepmap.put("goalguid", goalguid);
                tepmap.put("_isleaf", "1");
            }
            map.put("#indexs",goalindexs); //行级数据保存
            yeargoals.add(map);

            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            map.put("#delindex", new ArrayList<>()); //存放子表删除的绩效指标
        }
        backMap.put("yeargoals", yeargoals);
        return backMap;
    }

    /**
     * 根据主表记录查询没有记录的查询默认模板数据
     * @param params --数据
     * @return
     * @throws AppException
     */
    public Map<String, Object> getDeptSubData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String)params.get("mainguid");
        String goalguid = (String)params.get("goalguid");
        List<Map<String, Object>> collist = selfIndexDAO.getCol(selfIndexDAO.TABLE_INDEX_SELF);
        List<Map<String, Object>> tempdatas = selfIndexDAO.getTempdatas(mainguid,"DEPT"); //模板信息
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                    map.put(col, "");
                }
            }
            map.put("mainguid", mainguid);
            map.put("goalguid", goalguid);
            map.put("_isleaf", "1");
            backdata.add(map);
        }
        backMap.put("data", backdata);
        return backMap;
    }

    /**
     * 最终保存方法.(湖北)
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveHbData(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String mainguid = (String) params.get("mainguid");
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        List<Map<String, Object>> maindatas = (List<Map<String, Object>>) params.get("datas");
        int i = 0;
        int j = 0;
        for (Map<String, Object> mainmap : maindatas) {
            mainmap.get("#index");
            List<Map<String, Object>> datas = (List<Map<String, Object>>) mainmap.get("#indexs");
            for (Map<String, Object> map : datas) {
                j++;
                String levelno = map.get("levelno") + "";
                if ("3".equals(levelno)) {
                    map.put("ordernum", j);
                    if(StringUtils.isEmpty(map.get("guid"))){
                        map.put("guid", CommonUtil.createGUID());
                    }
                    map.put("creater", SecureUtil.getCurrentUser().getGuid());
                    map.put("agencyguid", saveAgency);
                    map.put("mainguid", mainguid);
                    map.put("proguid", proguid);
                    map.put("code", map.get("code"));
                    map.put("create_time", PerfUtil.getServerTimeStamp());
                    map.put("update_time", PerfUtil.getServerTimeStamp());
                    map.put("agency_code", saveAgency);
                    map.put("mof_div_code", SecureUtil.getUserSelectProvince());
                    map.put("province", SecureUtil.getUserSelectProvince());
                    map.put("year", CommonUtil.getYear());
                    map.put("fiscal_year", CommonUtil.getYear());
                    indexList.add(map);
                }
            }
            mainmap.put("mainguid", mainguid);
            mainmap.put("create_time", StringUtil.getSysDBDate());
            mainmap.put("createtime", StringUtil.getSysDBDate());
            mainmap.put("updatetime", StringUtil.getSysDBDate());
            mainmap.put("update_time", StringUtil.getSysDBDate());
            mainmap.put("province", SecureUtil.getUserSelectProvince());
            mainmap.put("year", CommonUtil.getYear());
            i++;
            if(StringUtils.isEmpty(mainmap.get("goalname"))){
                mainmap.put("goalname", "目标"+i);
            }
        }
        selfIndexDAO.delIndexByguid(selfIndexDAO.TABLE_GOAL_SELF, mainguid);
        selfIndexDAO.saveAll(maindatas, selfIndexDAO.TABLE_GOAL_SELF);
        selfIndexDAO.delIndexByguid(selfIndexDAO.TABLE_INDEX_SELF, mainguid);
        selfIndexDAO.saveAll(indexList, selfIndexDAO.TABLE_INDEX_SELF);
        //更新得分
        this.updateDescScore(mainguid, "dept");
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(indexList, busguid,"perf", null);
    }

    public void updateDescScore(String mainguid, String bustype) throws AppException {
        HashMap<String, Object> selfMap = new HashMap<>();
        selfMap.put("mainguid",mainguid);
        // 自评结论
        selfMap.put("warmtype", "selfresult" + bustype);
        String selfresult = this.getWarn(selfMap);
        //自评得分
        selfMap.put("warmtype", "selfscore" + bustype);
        String score = this.getWarn(selfMap);
        List<Map<String, Object>> descList = selfIndexDAO.getDatas("V_PERF_T_SELFPERFDESC"," t.mainguid='" + mainguid + "'",null);
        if(descList.size()>0){
            String sql = "update V_PERF_T_SELFPERFDESC t set t.score ='" + score + "', t.selfresult='" + selfresult + "' where t.mainguid='" + mainguid + "'";
            selfIndexDAO.execute(sql);
        }else{
            Map<String, Object> descmap = new HashMap<>();
            descmap.put("guid", this.getCreateguid());
            descmap.put("creater", SecureUtil.getCurrentUserID());
            descmap.put("province", SecureUtil.getUserSelectProvince());
            descmap.put("year", CommonUtil.getYear());
            descmap.put("createtime", PerfUtil.getServerTimeStamp());
            descmap.put("updatetime", PerfUtil.getServerTimeStamp());
            descmap.put("mainguid", mainguid);
            descmap.put("score", score);
            descmap.put("selfresult", selfresult);
            descmap.put("is_deleted", 2);
            selfIndexDAO.save(descmap, "V_PERF_T_SELFPERFDESC");
        }
    }

    /**
     * 获取申报的目标、指标
     * @param params -- 参数集合.
     * @return yeargoals.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> getnewindexAndGoal(Map<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        //获取申报的目标、指标
        String mainguid = (String)params.get("mainguid");
        String proguid = (String)params.get("proguid");
        String procode = (String) params.get("procode");
        String bustype = (String) params.get("bustype");
        String indextablecode = PerfConstant.PMKPI_VPM_INDICATOR; //来源表
        String goaltablecode = PerfConstant.PMKPI_VPM_GOAL_INFO; //来源表
        StringBuffer goalSql = new StringBuffer();
        List<Map<String, Object>> tempdatas = new ArrayList<Map<String, Object>>();
        if(!StringUtil.isEmpty(bustype)){
            if("program".equals(bustype)){//项目支出
                goalSql.append(" t.pro_code = '" + procode + "' and t.yearflag = '0' ");
                tempdatas = selfIndexDAO.getTempdatas(mainguid,"PM001");//模板信息
            }else if ("dept".equals(bustype)) { //部门整体
                goaltablecode = selfIndexDAO.TABLE_GOAL_DEPT;
                indextablecode = selfIndexDAO.TABLE_INDEX_DEPT;
                goalSql.append(" t.mainguid = '" + proguid + "' and t.yearflag = '0' ");
                tempdatas = selfIndexDAO.getTempdatas(mainguid,"DEPT");//模板信息
            }
        }
        String orderby = " order by ordernum";
        List<Map<String, Object>> goals = selfIndexDAO.getDatas(goaltablecode, goalSql.toString(), null);
        List<Map<String, Object>>  indexs = selfIndexDAO.getDatas(indextablecode, goalSql.toString(), orderby);
        if("dept".equals(bustype) && !indexs.isEmpty()){
            indexs.forEach(r -> {
                r.put("goalguid", r.get("kpi_dep_id"));
            });
        }
        List<Map<String, Object>> collist = selfIndexDAO.getCol(selfIndexDAO.TABLE_INDEX_SELF);
        List yeargoals = new ArrayList(); // 年度
        String goalguid;
        String sindex;
        String key;
        List goalindexs; //目标指标对应.
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>(); //
        List tempindex;
        for (Map<String, Object> map : indexs) {
            goalguid = (String) map.get("goalguid");
            sindex = (String) map.get("sindex");
            key = goalguid+"#"+sindex;
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            map.put("superguid", sindex);
            map.put("superid", sindex);
            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            if (indexMap.containsKey(key)){
                tempindex = indexMap.get(key);
                tempindex.add(map);
            } else {
                tempindex = new ArrayList();
                tempindex.add(map);
                indexMap.put(key, tempindex);
            }
        }
        for (Map<String, Object> map : goals) {
            goalguid = (String) map.get("guid");
            goalindexs = new ArrayList();
            List<Map> tempdatalist = new ArrayList();
            JSONArray jsonArray = JSONArray.parseArray(JSONObject.toJSONString(tempdatas));
            List<Map> jsonlist = jsonArray.toJavaList(Map.class);
            tempdatalist.addAll(jsonlist);
            int sortnum = 0;
            int scoresum = 0;
            for (Map<String, Object> tepmap : tempdatalist) {
                for (Map<String, Object> colmap : collist) {
                    String col = (String) colmap.get("columncode");
                    String value = tepmap.get(col) + "";
                    if (value == null || StringUtils.isEmpty(value) || "null".equals(value)) {
                        tepmap.put(col, "");
                    }
                }
                String levelno = tepmap.get("levelno") + "";


                if (!StringUtils.isEmpty(levelno) && "2".equals(levelno)) {
                    sindex = (String) tepmap.get("guid");
                    key = goalguid+"#"+sindex;
                    if (indexMap.containsKey(key)) {
                        tempindex = indexMap.get(key);
                        tepmap.put("_sortid", sortnum);
                        sortnum++;
                        for (int j = 0; j < tempindex.size(); j++){
                            Map<String,Object> indexmap = (Map<String, Object>) tempindex.get(j);
                            indexmap.get("score");
                            int score =  indexmap.get("score") != null ?  Integer.parseInt(String.valueOf(indexmap.get("score"))) : 0;
                            scoresum = scoresum + score;
                            indexmap.put("_sortid", sortnum);
                            sortnum++;
                        }
                        goalindexs.addAll(tempindex);
                    }else{
                        tepmap.put("_sortid", sortnum);
                        sortnum++;
                    }
                }else{
                    tepmap.put("_sortid", sortnum);
                    sortnum++;
                }
                tepmap.put("mainguid", mainguid);
                tepmap.put("goalguid", goalguid);
                tepmap.put("_isleaf", "1");
                goalindexs.add(tepmap);
            }
            map.put("#indexs",goalindexs); //行级数据保存
            yeargoals.add(map);

            if (map.get("rowtype") == null || !"add".equals(map.get("rowtype"))) {
                map.put("rowtype", "mod");
            }
            map.put("#delindex", new ArrayList<>()); //存放子表删除的绩效指标
        }
        backMap.put("yeargoals", yeargoals);
        //删除已填报监控指标目标数据
        StringBuffer wheresql = new StringBuffer();
        wheresql.append("eval_id = '").append(mainguid).append("'");
        selfIndexDAO.delDatas(PerfSelfApplyDAO.SELF_GOAL_TABLE, wheresql.toString());
        selfIndexDAO.delDatas(PerfSelfApplyDAO.SELF_IND_TABLE, wheresql.toString());
        Map delparams = new HashMap();
        StringBuffer missavesql = new StringBuffer();
        missavesql.append("mainguid = '").append(mainguid).append("'");
        delparams.put("delsql",missavesql.toString());
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delData(delparams);
        //将[评价基本信息]页面系统计算得分、评价结论(等级)、百分位值同步清除
        List<String> upcols = new ArrayList<>();
        StringBuffer upsql = new StringBuffer();
        upsql.append("update ").append(PerfSelfApplyDAO.PERF_TABLE_EVALUATEINFO).append(" set ");
        upcols.add("score");
        upcols.add("grade");
        upcols.add("percentile");
        for (String col : upcols) {
            upsql.append(col).append(" = null, ");
        }
        upsql.deleteCharAt(upsql.length() - 2);
        upsql.append(" where mainguid = '").append(mainguid).append("'");
        selfIndexDAO.execute(upsql.toString());
        return backMap;
    }
}