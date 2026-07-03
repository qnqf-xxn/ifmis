
package gov.mof.fasp2.pmkpi.perfprogram.fundCalIndex.adjust;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:41:23
 * @ClassName: PrjIndexBO
 * @Description: Description of this class
 */

public class FundCalAdjustIndexBO extends PmkpiBO {
    /**
     * fundCalIndexDAO.
     */
    private FundCalAdjustIndexDAO fundCalAdjustIndexDAO;

    /**
     * 注入dao.
     *
     * @param fundCalAdjustIndexDAO --prjIndexDAO.
     * @throws
     */
    public void setFundCalAdjustIndexDAO(FundCalAdjustIndexDAO fundCalAdjustIndexDAO) {
        this.fundCalAdjustIndexDAO = fundCalAdjustIndexDAO;
    }


    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        StringBuffer sql = new StringBuffer();
        return sql.toString();
    }
    public Map<String, Object> findYearIndexs(Map<String, Object> params) throws AppException {
        String procode = (String) params.get("procode");
        String sql = " t.pro_code = '"+procode+"' ";
        List<Map<String, Object>> datas = fundCalAdjustIndexDAO.findIndexs(sql, "v_perf_t_fundcaladjustindexview");
        if (datas == null || datas.size() <= 0) {
            datas = fundCalAdjustIndexDAO.findIndexs(sql, "v_perf_T_fundcalindexview");
        }
        for (Map<String, Object> map : datas) {
            map.put("levelno", "3");
            map.put("isleaf", "1");
            map.put("_isleaf", "1");
            String status = map.get("status") + "";
            if ("1".equals(status)) {
                map.put("obligate1", "撤销删除");
            } else if (!"2".equals(status)) {
                map.put("obligate1", "删除");
            }
        }
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        yearsMap.put("index", datas);
        return yearsMap;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = "v_perf_t_adjustindex";
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String proguid = (String) params.get("proguid");
        String saveAgency = (String) params.get("saveAgency");
        String bustype = (String) params.get("bustype");
        String procode = (String) params.get("procode");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> list = new ArrayList<>();
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        int i = 1;
        String date = PerfUtil.getServerTimeStamp();
        for (Map<String, Object> map : datas) {
            String levelno = map.get("levelno") + "";
            if (levelno != null && "3".equals(levelno)) {
                if (bustype != null && ("program".equals(bustype) || "protrace".equals(bustype))) {
                    map.put("pro_code", procode);
                }
                String weight = null;
                String weightindex = map.get("weight") + "";
                if (weightindex != null && !weightindex.isEmpty() && !"null".equals(weightindex)) {
                    weight = map.get("weight").toString();
                    map.put("weight", Float.parseFloat(weight));
                }
                if (weight==null||weight.isEmpty()){
                    map.put("weight", 0);
                }
                String indexguid = (String) map.get("indexguid");
                if (indexguid != null && ! indexguid.isEmpty()) {
                    map.put("tindex", map.get("indexguid"));
                }
                map.put("guid", this.getCreateguid());
                map.put("ordernum", i++);
                map.put("proguid", proguid);
                map.put("mainguid", mainguid);
                map.put("yearflag", 0);
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("agencyguid", saveAgency);
                map.put("dept_code", saveAgency.substring(0,3));
                map.put("year", CommonUtil.getYear());
                this.getBasMap(map,"add");
                map.put("kpi_lv1", map.get("findex"));
                map.put("kpi_lv2", map.get("sindex"));
                map.put("kpi_val", map.get("indexval"));
                map.put("version", date);
                map.put("version_name", "项目绩效指标调整_"+date);
                list.add(map);
            }

            if(!StringUtil.isEmpty((String) map.get("guid"))){
                Map<String, Object> addMap = new HashMap();
                addMap.put("guid", StringUtil.createUUID());
                addMap.put("indexguid",map.get("guid"));
                addMap.put("fundguid",map.get("fundguid"));
                addMap.put("procode",map.get("pro_code"));
                addMap.put("year",map.get("year"));
                addMap.put("province",map.get("province"));
                addMap.put("createtime", PerfUtil.getServerTimeStamp());
                addMap.put("updatetime", PerfUtil.getServerTimeStamp());
                addMap.put("is_deleted","2");
                addMap.put("status","adjust");// 调整标识
                indexList.add(addMap);
            }
        }
        // 处理预算资金关联信息
        fundCalAdjustIndexDAO.delDatas("perf_T_fundcalindex","procode = "+procode+" and t.status = 'adjust' ");
        logger.debug("--------indexList-----"+indexList+"----");
        if(indexList.size() > 0){
            fundCalAdjustIndexDAO.saveAll(indexList,"perf_T_fundcalindex");
        }
        // 处理调整指标信息
        fundCalAdjustIndexDAO.setIndexCode(list);
        String delsql = " mainguid='" + mainguid + "'";
        fundCalAdjustIndexDAO.delDatas(tablecode, delsql);
        fundCalAdjustIndexDAO.saveAll(list, tablecode);
        return this.auditdefine(list, busguid,"perf", null);
    }
}
