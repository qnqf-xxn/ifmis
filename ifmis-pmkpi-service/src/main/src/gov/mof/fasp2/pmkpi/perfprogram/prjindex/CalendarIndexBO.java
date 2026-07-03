package gov.mof.fasp2.pmkpi.perfprogram.prjindex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 参考历年指标
 */
public class CalendarIndexBO extends PmkpiBO {
    private CalendarIndexDAO calendarIndexDAO;

    public void setCalendarIndexDAO(CalendarIndexDAO calendarIndexDAO) {
        this.calendarIndexDAO = calendarIndexDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        return super.getVodSql(sqlmap);
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getData(HashMap<String, Object> params) throws AppException {
        String proguid = (String)params.get("proguid");
        String procode = (String) params.get("procode");
        String querysql = (String) params.get("querySql");
        List<Integer> years = (List<Integer>) params.get("years");
        String wheresql = " and pro_code='" + procode +"'";
        Map<String, Object> backMap = calendarIndexDAO.getIndexDatas(years, wheresql, querysql);
        //所有指标数据
        List<Map<String, Object>> allIndexList  = (List<Map<String, Object>>) backMap.get("allIndexList");
        //页面展示指标数据
        List<Map<String, Object>> dataList  = (List<Map<String, Object>>) backMap.get("dataList");
        dataList.stream().forEach(indexMap -> {
            String findex = (String) indexMap.get("findex");
            String sindex = (String) indexMap.get("sindex");
            String name = (String) indexMap.get("name");
            String computesign = (String) indexMap.get("computesign");
            String meterunit = (String) indexMap.get("meterunit");
            allIndexList.stream().forEach(map -> {
                String f = (String) map.get("newfindex");
                String s = (String) map.get("newsindex");
                String n = (String) map.get("name");
                String c = (String) map.get("computesign");
                String m = (String) map.get("meterunit");
                String y = map.get("year") + "";
                String indexval = (String) map.get("indexval");
                if (findex.equals(f) && sindex.equals(s) && name.equals(n) && computesign.equals(c)) {
                    if ("1".equals(computesign) || "2".equals(computesign) || "3".equals(computesign) || "4".equals(computesign) || "5".equals(computesign)) {
                        if (meterunit.equals(m)) {
                            for (int i = 0; i < years.size(); i++) {
                                if (y.equals(years.get(i) + "")) {
                                    indexMap.put("indexval" + i, indexval);
                                    break;
                                }
                            }
                        }
                    } else {
                        indexMap.put("averageval", null);
                        for (int i = 0; i < years.size(); i++) {
                            if (y.equals(years.get(i) + "")) {
                                indexMap.put("indexval" + i, indexval);
                                break;
                            }
                        }
                    }
                }
            });
        });
        return dataList;
    }
}
