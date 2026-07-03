package gov.mof.fasp2.pmkpi.perfreview.opinion;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
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

public class PerfReviewOpinionBO extends PmkpiBO {
    private PerfReviewOpinionDAO perfReviewOpinionDAO;

    public void setPerfReviewOpinionDAO(PerfReviewOpinionDAO perfReviewOpinionDAO) {
        this.perfReviewOpinionDAO = perfReviewOpinionDAO;
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
//        String prolev = (String) params.get("prolev");
        String frametype = (String) params.get("frametype");
        String bustype = (String) params.get("bustype");
        String procode = (String) params.get("procode");
        String[] tempfilter = new String[2];
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String sindex = "";
        String yearflag = "0";
        if (showtab != null && "1".equals(showtab)) {
            tempfilter = new String[]{"0", "1"};
        } else if (showtab != null && "2".equals(showtab)) {
            tempfilter = new String[]{"1"};
        } else {
            tempfilter = new String[]{"0"};
        }
        List<Map<String, Object>> indexs = null;
        if (StringUtil.isEmpty(frametype)) {
            if (bustype != null && "dept".equals(bustype)) {
                frametype = "DEPT";
                showtab = "3";
                indexs = perfReviewOpinionDAO.getDeptIndex(proguid);
            } else {
                frametype = "PM001";
                indexs = perfReviewOpinionDAO.getProIndex(proguid, procode, tempfilter);
            }
        }
        List<Map<String, Object>> nullTemp = perfReviewOpinionDAO.getTempdatas(proguid, frametype); //空指标模板
        List<Map<String, Object>> tempList = null;
        Map<String, List<Map<String, Object>>> indexMap = new HashMap<String, List<Map<String, Object>>>();
        String keycode = "";
        // 区分项目多页签指标
        for (Map<String, Object> map : indexs) {
            yearflag = (String) map.get("yearflag") == null ? "0" : (String) map.get("yearflag");
            sindex = (String) map.get("sindex");
            keycode = sindex + "&" + yearflag;
            if (!indexMap.containsKey(keycode)) {
                tempList = new ArrayList<Map<String, Object>>();
                indexMap.put(keycode, tempList);
            } else {
                tempList = indexMap.get(keycode);
            }
            map.put("_isleaf", "1");
            tempList.add(map);
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
                sindex = (String) map.get("sindex");
                //map.put("guid",this.getCreateguid());
                keycode = sindex + "&1";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
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
                sindex = (String) map.get("sindex");
                //map.put("guid",this.getCreateguid());
                keycode = sindex + "&0";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
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
                sindex = (String) map.get("sindex");
                map.put("_isleaf", "1");
                //map.put("guid",this.getCreateguid());
                keycode = sindex + "&1";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
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
                sindex = (String) map.get("sindex");
                map.put("_isleaf", "1");
                //map.put("guid",this.getCreateguid());
                keycode = sindex + "&0";
                if (indexMap.containsKey(keycode)) {
                    tempList = indexMap.get(keycode);
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
     * 绩效制度表树级展示保存.
     *
     * @param params -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        String showtab = (String) params.get("showtab"); //页签显示 1总+年2总3年
        String busguid = (String) params.get("busguid"); //项目编码
        String mainguid = (String) params.get("mainguid");
        String bustype = (String) params.get("bustype");
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        Map<String, Object> tabcomps = (Map<String, Object>) params.get("datas"); //多页签的数据
        Map<String, Object> editinfo = (Map<String, Object>) params.get("editdatas");
        List<Map<String, Object>> modList = new ArrayList<Map<String, Object>>(); // 修改
        List<String> cols = null;
        String levelno = "";
        String indexname = "";
        String opinion_remark = "";
        String tablecode = "pm_perf_indicator";
        if (bustype != null && "dept".equals(bustype)) {
            tablecode = "v_bgt_perf_indicator";
            showtab = "3";
        } else {
            tablecode = "pm_perf_indicator";
        }
        if (showtab != null && ("1".equals(showtab) || "2".equals(showtab))) { // 总+年
            List<Map<String, Object>> totalList = (List<Map<String, Object>>) tabcomps.get("#total");
            if (totalList != null && totalList.size() > 0) {
                for (Map tempMap : totalList) {
                    levelno = PerfUtil.mapGetInt(tempMap, "levelno") + "";
                    indexname = (String) tempMap.get("name");
                    opinion_remark = (String) tempMap.get("opinion_remark");
                    if ("3".equals(levelno) && !StringUtil.isEmpty(indexname) && !StringUtil.isEmpty(opinion_remark)) {
                        tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
                        tempMap.put("update_time", PerfUtil.getServerTimeStamp());
                        modList.add(tempMap);
                    }
                }
            }
        }
        if (showtab != null && ("1".equals(showtab) || "3".equals(showtab))) { // 年
            List<Map<String, Object>> yearList = (List<Map<String, Object>>) tabcomps.get("#year");
            if(yearList != null && yearList.size()>0){
                for (Map tempMap : yearList) {
                    levelno = PerfUtil.mapGetInt(tempMap, "levelno") + "";
                    indexname = (String) tempMap.get("name");
                    opinion_remark = (String) tempMap.get("opinion_remark");
                    if ("3".equals(levelno) && !StringUtil.isEmpty(indexname) && !StringUtil.isEmpty(opinion_remark)) {
                        tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
                        tempMap.put("update_time", PerfUtil.getServerTimeStamp());
                        modList.add(tempMap);
                    }
                }
            }
        }
        //修改
        if (modList != null && modList.size() > 0) {
            cols = new ArrayList<String>();
            cols.add("opinion_remark");
            perfReviewOpinionDAO.updateAllByPK(cols, modList,"guid", tablecode);
        }
        String guid = (String) editinfo.get("guid");
        if (StringUtil.isEmpty(guid)) {
            editinfo.put("guid", this.getCreateguid());
            editinfo.put("province", CommonUtil.getProvince());
            editinfo.put("createtime", PerfUtil.getServerTimeStamp());
            editinfo.put("updatetime", PerfUtil.getServerTimeStamp());
            editinfo.put("creater", SecureUtil.getCurrentUser().getGuid());
            editinfo.put("year", CommonUtil.getYear());
            editinfo.put("type", "reviewopinion");
            editinfo.put("mainguid", mainguid);
            perfReviewOpinionDAO.save(editinfo, perfReviewOpinionDAO.PMKPI_TABLE_T_AUDITMAIN);
        } else {
            String wheresql = " mainguid = '" + mainguid + "'";
            Map<String, Object> data = this.getDataMap(perfReviewOpinionDAO.PMKPI_TABLE_T_AUDITMAIN, wheresql);
            if (!data.isEmpty()) {
                data.putAll(editinfo);
                perfReviewOpinionDAO.update(data, perfReviewOpinionDAO.PMKPI_TABLE_T_AUDITMAIN);
            }
        }
        return this.auditdefine(indexList, busguid, "perf", null);
    }

    /**
     * 查询审核意见
     * @param mainguid
     * @return
     */
    public Map<String, Object> getOpinionData(String mainguid) {
        String wheresql = " mainguid = '" + mainguid + "'";
        return this.getDataMap(perfReviewOpinionDAO.PMKPI_TABLE_T_AUDITMAIN, wheresql);
    }
}
