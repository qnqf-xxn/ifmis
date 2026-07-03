package gov.mof.fasp2.pmkpi.perfprogram.assessment;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfAssessmentBO extends PmkpiBO {
    private PerfAssessmentDAO perfAssessmentDAO;

    public void setPerfAssessmentDAO(PerfAssessmentDAO perfAssessmentDAO) {
        this.perfAssessmentDAO = perfAssessmentDAO;
    }

    /**
     * 查询数据.
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws -- 异常.
     */
    public Map<String, Object> getDatas(Map<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String proguid = (String) params.get("proguid");
        String selectbillguid = (String) params.get("selectbillguid"); //调整前的guid
        String adjadd = (String) params.get("adjadd"); //是否调整
        boolean isselAssessment = (boolean) params.get("isselAssessment");//是否需要显示下拉数据，多个模板类型数据true
        String bustype = (String) params.get("bustype");
        List<Map<String, Object>> dataList = null;
        String wheresql = " mainguid = ? ";

        //配合项目库可以跨地区查询项目基本信息，如果有showall标识时，并且等于1时，执行下查询分区语句，年度是登录年度，区划是传递的区划
        String showall = (String) params.get("showall");
        logger.debug("-------------showall-------------" + showall);
        if (!StringUtil.isEmpty(showall) && "1".equals(showall)){
            String loginyear = CommonUtil.getYear();  //登录年度
            String dataprovince = (String) params.get("dataprovince"); //项目库传递的区划
            logger.debug("------------登录年度loginyear："+loginyear+" ---------------- 查询区划："+dataprovince);
            perfAssessmentDAO.setYearAndProvince(loginyear,dataprovince);
        }

        Map<String, Object>  dataInfo = perfAssessmentDAO.getDataMap(perfAssessmentDAO.PERF_TABLE_ASSESSMENTOPINION, wheresql, new String[]{proguid});
        //查询项目事前绩效评估业务数据
        dataList = perfAssessmentDAO.getDatas(proguid, bustype);
        //调整
        if (adjadd != null && "1".equals(adjadd)) {
            logger.debug("调整数据不存在，查询调整前数据：调整前项目guid:" + proguid + "，调整后项目guid:" + selectbillguid);
            if(dataList == null || dataList.size() == 0){
                //不存在调整数据，查询调整前数据
                dataList = perfAssessmentDAO.getDatas(selectbillguid, bustype);
            }
            if(dataInfo.isEmpty()) {
                dataInfo = perfAssessmentDAO.getDataMap(perfAssessmentDAO.PERF_TABLE_ASSESSMENTOPINION, wheresql, new String[]{selectbillguid});
            }
        }
        //不存在业务数据，查询模板数据
        if ((dataList == null || dataList.size() == 0)) {
            if (!isselAssessment) {
                params.put("bustype", null);
                dataList = this.getAssessmentTemp(params);
            } else if (!StringUtil.isEmpty(bustype)){ //多个模板，选择后查询
                dataList = this.getAssessmentTemp(params);
            }
            backMap.put("issave", false);
        } else {
            backMap.put("issave", true);
        }
        backMap.put("dataList", dataList);
        backMap.put("dataInfo", dataInfo);
        return backMap;
    }

    /**
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String busguid = (String) params.get("busguid");
        String saveAgency = (String) params.get("saveAgency");
        String pro_code = (String) params.get("pro_code");
        List<Map<String, Object>> list = new ArrayList<>(); //指标集合
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        Map<String, Object> edifinfo = (Map<String, Object>) params.get("edifinfo");
        String totalnum = "0";
        for (Map<String, Object> map : datas) {
            if ("合计".equals(map.get("name")) || "总得分".equals(map.get("name"))) {
                totalnum = map.get("scorenum") + "";
            }
        }
        for (Map<String, Object> map : datas) {
            String scorenum = map.get("scorenum") + "";
            if (StringUtils.isEmpty(scorenum) || "null".equals(scorenum) || !isNumeric(scorenum)) {
                scorenum = "0";
            }
            if ("评分等级".equals(map.get("name"))) {
                map.put("scorenum", Float.parseFloat(isNumeric(totalnum) ? totalnum : "0"));
            } else {
                map.put("scorenum", Float.parseFloat(scorenum));
            }
            map.put("province", CommonUtil.getProvince());
            map.put("tempguid", map.get("guid"));
            map.put("guid", CommonUtil.createGUID());
            map.put("createtime", StringUtil.getSysDBDate());
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("year", CommonUtil.getYear());
            map.put("agencyguid", saveAgency);
            map.put("mainguid", proguid);
            map.put("pro_code", pro_code);
            map.put("is_deleted", 2);
            list.add(map);
        }
        //删除保存
        String wheresql = " mainguid = '" + proguid + "'";
        perfAssessmentDAO.updateIsDeleteDatas(perfAssessmentDAO.PERF_TABLE_ASSESSMENT, wheresql);
        perfAssessmentDAO.saveAll(list,perfAssessmentDAO.PERF_TABLE_ASSESSMENT);
        if (edifinfo != null && !edifinfo.isEmpty()) {
            Map<String, Object> infodata = perfAssessmentDAO.getDataMap(perfAssessmentDAO.PERF_TABLE_ASSESSMENTOPINION, wheresql);
            if (infodata.isEmpty()) {
                edifinfo.put("pro_code", pro_code);
                edifinfo.put("province", CommonUtil.getProvince());
                edifinfo.put("guid", CommonUtil.createGUID());
                edifinfo.put("createtime", StringUtil.getSysDBDate());
                edifinfo.put("updatetime", StringUtil.getSysDBDate());
                edifinfo.put("creater", SecureUtil.getCurrentUser().getGuid());
                edifinfo.put("year", CommonUtil.getYear());
                edifinfo.put("agencyguid", saveAgency);
                edifinfo.put("mainguid", proguid);
                edifinfo.put("is_deleted", 2);
                perfAssessmentDAO.save(edifinfo, perfAssessmentDAO.PERF_TABLE_ASSESSMENTOPINION);
            } else {
                infodata.putAll(edifinfo);
                infodata.put("mainguid", proguid);
                infodata.put("pro_code", pro_code);
                infodata.put("updatetime", StringUtil.getSysDBDate());
                perfAssessmentDAO.update(infodata, perfAssessmentDAO.PERF_TABLE_ASSESSMENTOPINION);
            }
        }
        return this.auditdefine(list, busguid,"perf", null);
    }

    /**
     * 查询导出数据
     * @param proguid
     * @return
     */
    public List<Map<String, Object>> getExportDatas(String proguid) throws AppException {
        Map<String, Object> params = new HashMap<>();
        boolean isselAssessment = this.isAssessment();
        params.put("isselAssessment", isselAssessment);
        params.put("proguid", proguid);
        if (isselAssessment) { //多个类型模板数据，查询类型
            params.put("bustype", this.getSelAssessment(proguid, null, null));
        }
        Map<String, Object> dataMap = this.getDatas(params);
        return (List<Map<String, Object>>) dataMap.get("dataList");
    }

    /**
     * 根据选择类型查询模板数据.
     * @param params -- 参数。
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getAssessmentTemp(Map<String, Object> params) {
        String bustype = (String) params.get("bustype");
        String wheresql = "";
        String orderby = " order by ordernum";
        String sql = "(select a.*,a.guid as tguid from "+perfAssessmentDAO.PERF_TABLE_ASSESSMENTTEMP+" a)";
        if (StringUtil.isEmpty(bustype)) {//空或通版类型
            wheresql = " nvl(bustype, 'assessment') = 'assessment'";
            return perfAssessmentDAO.getDatas(sql, wheresql, orderby);
        } else {
            wheresql = " bustype = ? ";
            return perfAssessmentDAO.getDatas(sql, wheresql, orderby, new String[]{bustype});
        }
    }

    /**
     * 根据模板类型，查询是否需要显示下拉数据.
     * @return true显示 false不显示
     * @throws AppException
     */
    public boolean isAssessment() {
        String sql = "select bustype from " + perfAssessmentDAO.PERF_TABLE_ASSESSMENTTEMP + " group by bustype";
        List<Map<String, Object>> list = perfAssessmentDAO.queryForList(sql);
        if (list.size() > 1) {
            return true;
        }
        return false;
    }

    /**
     * 下拉类型时，初始化页面查询业务数据类型
     * @param proguid
     * @param adjadd
     * @param selectbillguid
     * @return
     */
    public String getSelAssessment(String proguid, String adjadd, String selectbillguid){
        String wheresql = "mainguid=?";
        String bustype = "";
        Map<String, Object> assessmentMap = perfAssessmentDAO.getDataMap(perfAssessmentDAO.PERF_TABLE_ASSESSMENT, wheresql, new String[]{proguid});
        if (!assessmentMap.isEmpty()) {
            bustype = (String) assessmentMap.get("bustype");
        }
        //调整阶段，调整数据没有时，查询调整前数据
        if (adjadd != null && "1".equals(adjadd) && assessmentMap.isEmpty()) {
            logger.debug("调整数据不存在，查询调整前数据：调整前项目guid:" + proguid + "，调整后项目guid:" + selectbillguid);
            //不存在调整数据，查询调整前数据
            assessmentMap = perfAssessmentDAO.getDataMap(perfAssessmentDAO.PERF_TABLE_ASSESSMENT, wheresql, new String[]{selectbillguid});
            if (!assessmentMap.isEmpty()) {
                bustype = (String) assessmentMap.get("bustype");
            }
        }
        return bustype;
    }
}
