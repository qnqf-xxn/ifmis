
package gov.mof.fasp2.pmkpi.perfprogram.approvalquery.prjindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.table.dto.DicColumnDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.lang.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author <a href="mailto:gaoming@szlongtu.com">GM</a>于 2020-1-6 上午10:41:23
 * @ClassName: PrjIndexBO
 * @Description: Description of this class
 */

public class ApprovalPrjIndexBO extends PmkpiBO {
    /**
     * prjIndexDAO.
     */
    private ApprovalPrjIndexDAO approvalPrjIndexDAO;

    /**
     * 注入dao.
     *
     * @param approvalPrjIndexDAO --approvalPrjIndexDAO.
     * @throws
     */
    public void setApprovalPrjIndexDAO(ApprovalPrjIndexDAO approvalPrjIndexDAO) {
        this.approvalPrjIndexDAO = approvalPrjIndexDAO;
    }

    /**
     * 获取目标数据
     *
     * @param proguid --项目guid
     * @return
     */
    public List<Map<String, Object>> getGoalByGuid(String proguid) {
        List<Map<String, Object>> goalList = approvalPrjIndexDAO.getDatas("v_pm_perf_goal_info", " mainguid='" + proguid + "'", null);
        return goalList;
    }

    /**
     * 查询各年度数据.
     *
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws --           异常.
     */
    public Map<String, Object> findAllIndex(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String showtab = (String) params.get("showtab"); ////页签显示 1总+年2总3年
        String tempcode = (String) params.get("tempcode");
        String frametype = (String) params.get("frametype");
        String procode = (String) params.get("procode");
        String goalguid = (String) params.get("goalguid");
        String[] tempfilter = new String[2];
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String sindex = "";
        String findex = "";
        String yearflag = "0";
        if (showtab != null && "1".equals(showtab)) {
            tempfilter = new String[]{"1", "0"};
        } else if (showtab != null && "2".equals(showtab)) {
            tempfilter = new String[]{"1"};
        } else {
            tempfilter = new String[]{"0"};
        }
        if (StringUtil.isEmpty(frametype)) {
            frametype = "PM001";
        }
        List<Map<String, Object>> indexs = approvalPrjIndexDAO.findIndexsByFilter(proguid, procode, tempfilter,goalguid);
        if(PerfUtil.getIS_HUBEI() && !StringUtil.isEmpty(goalguid)) {
            //根据目标id查询目标
            String sql = "select * from pm_perf_goal_info where is_backup = 2 and is_deleted=2 and guid = '" + goalguid + "' and province='" + CommonUtil.getProvince() + "'";
            List<Map<String, Object>> goallist = approvalPrjIndexDAO.queryForList(sql);
            String year = null;
            if (goallist != null && goallist.size() > 0) {
                year = String.valueOf(goallist.get(0).get("year"));
            }
            if (indexs.size() == 0 && !StringUtil.isEmpty(year) && !year.equals(CommonUtil.getYear())) {
                indexs = approvalPrjIndexDAO.findIndexsByFilter(proguid, procode, tempfilter, null);
            }
        }

        if(indexs.size() == 0 && StringUtils.isNotBlank(tempcode)){
            //如果查出来的指标数据为空，则获取模板中的指标数据。
            indexs = approvalPrjIndexDAO.findIndexsByTempCode(proguid,tempcode,tempfilter);
            for (Map map :indexs) {
                String guid = this.getCreateguid();
                map.put("guid",guid);
                map.put("kpi_id",guid);
            }
        }
        List<Map<String, Object>> nullTemp = approvalPrjIndexDAO.getTempdatas(proguid, frametype); //空指标模板
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
                    fweightsum=(float)(Math.round(fweightsum*100))/100;
                }
            } else {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    if (ssuperid != null && !"null".equals(ssuperid) && !ssuperid.isEmpty()) {
                        if (fsuperid != null && !"null".equals(fsuperid) && !fsuperid.isEmpty()) {
                            fweightsum = 0;
                        }
                    }
                    Float num = Float.parseFloat(weight);
                    fweightsum =  + num;
                    fweightsum=(float)(Math.round(fweightsum*100))/100;
                }
            }
            if (sindex.equals(ssuperid)) {
                if (weight != null && !"null".equals(weight) && !weight.isEmpty()) {
                    Float num = Float.parseFloat(weight);
                    sweightsum = sweightsum + num;
                    sweightsum=(float)(Math.round(sweightsum*100))/100;
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
                    sweightsum=(float)(Math.round(sweightsum*100))/100;
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
        if (StringUtils.isNotBlank(showtab) && "1".equals(showtab)) {
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                map.put("_isleaf", "1");
                sindex = map.get("sindex") + "&1";
                String levelno = map.get("levelno") + "";
                if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                    map.put("weight",sumMap.get(sindex) == null ? 0 : sumMap.get(sindex));
                } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                    findex = map.get("guid") + "&1";
                    map.put("weight",sumMap.get(findex) == null ? 0 : sumMap.get(findex));
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
            yearsMap.put("#total", backindex); //项目总体
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                map.put("_isleaf", "1");
                sindex = map.get("sindex") + "&0";
                String levelno = map.get("levelno") + "";
                if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                    map.put("weight",sumMap.get(sindex) == null ? 0 : sumMap.get(sindex));
                } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                    findex = map.get("guid") + "&0";
                    map.put("weight",sumMap.get(findex) == null ? 0 : sumMap.get(findex));
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
            yearsMap.put("#year", backindex);//年度
        } else if (StringUtils.isNotBlank(showtab) && "2".equals(showtab)) {
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                sindex = map.get("sindex") + "&1";
                map.put("_isleaf", "1");
                String levelno = map.get("levelno") + "";
                if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                    map.put("weight",sumMap.get(sindex) == null ? 0 : sumMap.get(sindex));
                } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                    findex = map.get("guid") + "&1";
                    map.put("weight",sumMap.get(findex) == null ? 0 : sumMap.get(findex));
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
            yearsMap.put("#total", backindex); //项目总体
        } else {
            nullindex = (List<Map<String, Object>>) PerfUtil.cloneListAndMap(nullTemp);
            backindex = new ArrayList<Map<String, Object>>();
            for (Map<String, Object> map : nullindex) {
                sindex = map.get("sindex") + "&0";
                map.put("_isleaf", "1");
                String levelno = map.get("levelno") + "";
                if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "2".equals(levelno)) {
                    map.put("weight",sumMap.get(sindex) == null ? 0 : sumMap.get(sindex));
                } else if (levelno != null && !levelno.isEmpty() && !"null".equals(levelno) && "1".equals(levelno)) {
                    findex = map.get("guid") + "&0";
                    map.put("weight",sumMap.get(findex) == null ? 0 : sumMap.get(findex));
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
            yearsMap.put("#year", backindex);//年度
        }
        return yearsMap;
    }


    /**
     * 查询页面表格的注册字段
     *
     * @param uikey
     * @return
     */
    public List<Map<String, Object>> getUicolumn(String uikey) {
        List<Map<String, Object>> list = approvalPrjIndexDAO.getUicolumn(uikey);
        return list;
    }
}
