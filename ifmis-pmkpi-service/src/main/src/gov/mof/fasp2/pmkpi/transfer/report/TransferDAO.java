package gov.mof.fasp2.pmkpi.transfer.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import oracle.jdbc.OracleTypes;
import org.springframework.jdbc.core.ConnectionCallback;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class TransferDAO extends PmkpiDAO {

    /**
     * 1.结转项目关联表
     */
    public static final String PMKPI_TABLE_T_TRANSFER_PROJECT = "v_perf_transfer_project";

    /**
     * 2.结转项目绩效年度目标表
     */
    public static final String PMKPI_TABLE_T_TRANSFER_GOAL = "v_perf_transfer_goal";

    /**
     * 3.结转项目绩效年度指标表
     */
    public static final String PMKPI_TABLE_T_TRANSFER_INDICATOR = "v_perf_transfer_indicator";

    /**
     * 根据条件查询目标数据
     *
     * @param proguid
     * @param procode
     * @param tempfilter
     * @return
     */
    public List<Map<String, Object>> getGoalsByFilter(String proguid, String procode, String[] tempfilter, String year) {
        String tablecode = "";
        StringBuffer wheresql = null;
        StringBuffer sql = null;
        List<Map<String, Object>> list = new ArrayList<>();
        for (String yearflag : tempfilter) {
            if (yearflag != null && "1".equals(yearflag)) {
                //长期绩效目标查询项目绩效表
                tablecode = "pm_perf_goal_info";
            } else if ("0".equals(yearflag)) {
                //年度绩效目标查询结转表
                tablecode = this.PMKPI_TABLE_T_TRANSFER_GOAL;
            }
            wheresql = new StringBuffer();
            if ("1".equals(yearflag)) {
                wheresql.append(" yearflag = '1' and is_backup=2 and is_deleted = 2 and  t.mainguid ='").append(proguid).append("'");
                wheresql.append(" and province='").append(CommonUtil.getProvince()).append("'");
            } else if ("0".equals(yearflag)) {
                wheresql.append(" t.pro_code='").append(procode).append("' and t.year = '").append(year).append("'");
            }
            sql = new StringBuffer("select t.* from ").append(tablecode).append(" t ");
            if (!StringUtil.isEmpty(wheresql.toString())) {
                sql.append(" where ");
                sql.append(wheresql);
            }
            sql.append(" and rownum=1 order by update_time desc");
            logger.info("查询绩效目标sql----------" + sql.toString());
            list.addAll(this.queryForList(sql.toString()));
        }
        return list;
    }


    public String getCreateguid() {
        return StringUtil.createUUID(); // 获取guid信息;
    }

    /**
     * 根据条件查询指标数据
     *
     * @param proguid
     * @param procode
     * @param tempfilter
     * @return
     */
    public Map<String, Object> findIndexList(String proguid, String procode, String[] tempfilter, String year) throws AppException {
        Map<String, Object> resultMap = new HashMap<String, Object>();
        String tablecode = "";
        StringBuffer wheresql = null;
        StringBuffer sql = null;
        List<Map<String, Object>> indexs = new ArrayList<>();
        List<Map<String, Object>> totallist = new ArrayList<>();
        List<Map<String, Object>> yearlist = new ArrayList<>();
        for (String yearflag : tempfilter) {
            if (yearflag != null && "1".equals(yearflag)) {
                //长期绩效目标查询项目绩效表
                tablecode = "pm_perf_indicator";
            } else if ("0".equals(yearflag)) {
                //年度绩效目标查询结转表
                tablecode = "v_perf_transfer_indicator";
            }
            wheresql = new StringBuffer();
            if ("1".equals(yearflag)) {
                wheresql.append(" yearflag = '1' and is_backup=2 and is_deleted = 2 and  t.mainguid ='").append(proguid).append("'");
            } else if ("0".equals(yearflag)) {
                wheresql.append(" t.pro_code='").append(procode).append("' and t.year = '").append(year).append("'");
            }
            sql = new StringBuffer("select t.* from ").append(tablecode).append(" t ");
            if (!StringUtil.isEmpty(wheresql.toString())) {
                sql.append(" where ");
                sql.append(wheresql);
            }
            sql.append(" order by update_time desc");
            logger.info("查询绩效指标sql----------" + sql.toString());
            indexs.addAll(this.queryForList(sql.toString()));
        }

        String sindex = "";
        String findex = "";
        String yearflag = "0";
        List<Map<String, Object>> nullTemp = this.getTempdatas(proguid, "PM001"); //空指标模板
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        // 区分项目多页签指标
        String fsuperid = "";
        String ssuperid = "";
        float sweightsum = 0;
        float fweightsum = 0;
        Map<String, Object> sumMap = new HashMap<String, Object>();
        for (Map<String, Object> map : indexs) {
            yearflag = map.get("yearflag") == null ? "0" : (String) map.get("yearflag");
            sindex = map.get("sindex") + "&" + yearflag;
            findex = map.get("findex") + "&" + yearflag;
            String weight = map.get("weight") == null ? "0" : map.get("weight") + "";
            keycode = sindex;
            if (findex.equals(fsuperid)) {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    Float num = Float.parseFloat(weight);
                    fweightsum = fweightsum + num;
                    fweightsum = (float) (Math.round(fweightsum * 100)) / 100;
                }
            } else {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    if (ssuperid != null && !"null".equals(ssuperid) && !ssuperid.isEmpty()) {
                        if (fsuperid != null && !"null".equals(fsuperid) && !fsuperid.isEmpty()) {
                            fweightsum = 0;
                        }
                    }
                    Float num = Float.parseFloat(weight);
                    fweightsum = +num;
                    fweightsum = (float) (Math.round(fweightsum * 100)) / 100;
                }
            }
            if (sindex.equals(ssuperid)) {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    Float num = Float.parseFloat(weight);
                    sweightsum = sweightsum + num;
                    sweightsum = (float) (Math.round(sweightsum * 100)) / 100;
                }
            } else {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    if (ssuperid != null && !"null".equals(ssuperid) && !ssuperid.isEmpty()) {
                        if (fsuperid != null && !"null".equals(fsuperid) && !fsuperid.isEmpty()) {
                            sweightsum = 0;
                        }
                    }
                    Float num = Float.parseFloat(weight);
                    sweightsum = num;
                    sweightsum = (float) (Math.round(sweightsum * 100)) / 100;
                }
            }
            if (!indexMap.containsKey(keycode)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(keycode, tempList);
            } else {
                tempList = indexMap.get(keycode);
            }
            map.put("_isleaf", "1");
            tempList.add(map);
            ssuperid = sindex;
            fsuperid = findex;
            sumMap.put(sindex, sweightsum);
            sumMap.put(findex, fweightsum);
        }
        // 区分项目空模板赋值，不然没有共有字段不显示
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        List<DicColumnDTO> dicColumnDTOs = dicQueryService.getDicColumnByTablecode("V_PM_PERF_INDICATOR");
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
        nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
        backindex = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : nullindex) {
            map.put("_isleaf", "1");
            sindex = map.get("sindex") + "&1";
            String levelno = map.get("levelno") + "";
            if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                map.put("weight", sumMap.get(sindex) == null ? 0 : sumMap.get(sindex));
            } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                findex = map.get("guid") + "&1";
                map.put("weight", sumMap.get(findex) == null ? 0 : sumMap.get(findex));
                sindex = "";
            } else {
                sindex = "";
            }
            if (indexMap.containsKey(sindex)) {
                tempList = indexMap.get(sindex);
                map.put("isleaf", "0");
                backindex.add(map);
                backindex.addAll(tempList);
            } else {
                backindex.add(map);
            }
        }
        resultMap.put("#total", backindex); //项目总体
        nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
        backindex = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : nullindex) {
            map.put("_isleaf", "1");
            sindex = map.get("sindex") + "&0";
            String levelno = map.get("levelno") + "";
            if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                map.put("weight", sumMap.get(sindex) == null ? 0 : sumMap.get(sindex));
            } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                findex = map.get("guid") + "&0";
                map.put("weight", sumMap.get(findex) == null ? 0 : sumMap.get(findex));
                sindex = "";
            } else {
                sindex = "";
            }
            if (indexMap.containsKey(sindex)) {
                tempList = indexMap.get(sindex);
                map.put("isleaf", "0");
                backindex.add(map);
                backindex.addAll(tempList);
            } else {
                backindex.add(map);
            }
        }
        resultMap.put("#year", backindex);//年度
        return resultMap;
    }

    /**
     * 指标树级获取指标.
     *
     * @param mainGuid -- 项目guid.
     * @return list.
     */
    public List<Map<String, Object>> getTempdatas(String mainGuid, String frameType) {
        String sql = "select guid,'" + mainGuid + "' mainguid,t.superid,t.code,t.name,levelno,isleaf, '1' as rowtype, ordernum from " + PMKPI_TABLE_T_FRAME + " t where frametype='" + frameType + "' order by ordernum";
        List<Map<String, Object>> flist = queryForList(sql);
        List<Map<String, Object>> temps = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : flist) {
            String guid = (String) map.get("guid");
            String superId = (String) map.get("superid");
            String levelNo = map.get("levelno") + "";
            if (levelNo != null && !"1".equals(levelNo)) {
                map.put("findex", superId);
                map.put("sindex", guid);
            }
            map.put("is_add", "0");
            map.put("zqindexval", "");
            map.put("zqmeterunit", "");
            map.put("zqcomputesign", "");
            map.put("adjoption", "");
            map.put("options", "");
            map.put("qnindexval", "");//前年指标值
            map.put("snindexval", "");//上年指标值
            temps.add(map);
        }
        return temps;
    }

}
