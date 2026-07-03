package gov.mof.fasp2.pmkpi.common.pendingtask;

import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PmkpiPendingDAO extends PmkpiDAO {

    //获取待办页面查询参数
    public List<Map<String, Object>> getPendingtask(String key) {
        String sql = "select * from V_PERF_PENDINGTASK where key in('" + key +"') order by key, beanid";
        return this.queryForList(sql);
    }

    /**
     * 批量查询待办sql待办数量
     * @param sqlList 待办sql集合
     * @param markindexList markindex集合，作为key关联区分每个待办
     * @return
     */
    public Map<String, Integer> batchGetDataCount(List<String> sqlList, List<String> markindexList) {
        Map<String, Integer> results = new HashMap<>();
        if(sqlList.size()!= markindexList.size()){
            return results;
        }
        List<String> modifiedSqlList = new ArrayList<>();
        // 统一返回查询值pendingcount
        for (String sql : sqlList) {
            String replacesql = sql.replaceAll("\\s+", " ");  // 将空白字符替换为单个空格
            replacesql = sql.replaceFirst("(?i)\\bselect\\b.*?\\bfrom\\b", "select count(1) as pendingcount,? as markindex from");
            String pattern = "(?i)\\s+ORDER\\s+BY\\s+[^;)]+?(?:;|$)";
            replacesql = replacesql.replaceAll(pattern, "");
            modifiedSqlList.add(replacesql);
        }
        List<Map<String, Object>> batchResults = new ArrayList<>();
        int batchSize = 10;
        if(modifiedSqlList.size() > batchSize){
            // 待办数量分批次
            for (int i = 0; i < modifiedSqlList.size(); i += batchSize) {
                List<String> batch = modifiedSqlList.subList(i, Math.min(i + batchSize, modifiedSqlList.size()));
                List<String> markindex = markindexList.subList(i, Math.min(i + batchSize, markindexList.size()));
                String batchSql = String.join(" union all ", batch);
                logger.info("批量查询数据个数sql----------" + batchSql);
                List<Map<String, Object>> bresults = (List<Map<String, Object>>) PerfUtil.lowMapKey(this.queryForList(batchSql,markindex));
                batchResults.addAll(bresults);
            }
        }else{
            // 构建批量查询SQL
            String batchSql = String.join(" union all ", modifiedSqlList);
            logger.info("批量查询数据个数sql----------" + batchSql);
            batchResults = (List<Map<String, Object>>) PerfUtil.lowMapKey(this.queryForList(batchSql,markindexList));
        }
        // 将结果映射回原始请求
        for (int i = 0; i < batchResults.size(); i++) {
            Map<String, Object> resultMap = batchResults.get(i);
            int count = ((BigDecimal) resultMap.get("pendingcount")).intValue();
            String markindex = (String) resultMap.get("markindex");
            results.put(markindex, count);
        }
        return results;
    }

}
