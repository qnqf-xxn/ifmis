package gov.mof.fasp2.pmkpi.setting.zjtempdata;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ZjTempDataBO extends PmkpiBO {
    private ZjTempDataDAO zjTempDataDAO;

    public void setZjTempDataDAO(ZjTempDataDAO zjTempDataDAO) {
        this.zjTempDataDAO = zjTempDataDAO;
    }

    /**
     *根据数据权限过滤左侧树
     * @param menuid
     * @return
     * @throws AppException
     */
    public Map<String, Object> getTreeData(String menuid) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.FALSE);
        leftconfig.put("dosearch", Boolean.FALSE);
        String elementcode = "PMKPIAGENCYALLPAY"; //查询挂载单位
        boolean isSx = PerfUtil.getIsSx();
        elementcode = isSx ? "PMKPIDEPT" : elementcode;
        StringBuffer wheresql = new StringBuffer("");
        wheresql.append(" 1 = 1 ");
        String datarule = this.getDataRuleByMenuguid(menuid, "t", null);
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        logger.debug("获取左侧树权限的-->："+datarule);
        wheresql.append(datarule);
        List<DicRangeDTO> value = dss.getRangesByWhereSql(elementcode, wheresql.toString());
        leftconfig.put("datas", value);
        return leftconfig;
    }
    /**
     * 查询表格数据.
     * @param sqlmap
     * @return
     */
    public Map<String, Object> getDatas(HashMap<String, Object> sqlmap) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String treeid = (String) sqlmap.get("treeid");
        int isleaf = (int) sqlmap.get("isleaf");
        String tablesql = (String) sqlmap.get("tablesql");
        String querySql = (String) sqlmap.get("querySql");
        String isZJ = PerfUtil.getSystemSet("isZJ");
        Boolean isHuBei = PerfUtil.getIS_HUBEI();
        Boolean isSx = PerfUtil.getIsSx();
        StringBuffer wheresql = new StringBuffer("");
        if("1".equals(isZJ) && isleaf == 0){
            wheresql.append(" dept='").append(treeid).append("'");
        } else if (isHuBei) { //湖北新增需求，单位要求展示部门录入的项目，单位再在扩展下级项目,支持上级数据展示
            StringBuffer tempagencys = new StringBuffer();
            if (treeid.length() > 3) {
                tempagencys.append("'").append(treeid.substring(0,3)).append("',");
            }
            /*if (treeid.length() > 6) {
                tempagencys.append("'").append(treeid.substring(0,6)).append("',");
            }
            if (treeid.length() > 9) {
                tempagencys.append("'").append(treeid.substring(0,9)).append("',");
            }
            if (treeid.length() > 12) {
                tempagencys.append("'").append(treeid.substring(0,12)).append("',");
            }
            if (treeid.length() > 15) {
                tempagencys.append("'").append(treeid.substring(0,15)).append("',");
            }*/
            tempagencys.append("'").append(treeid).append("'");
            wheresql.append(" agencyguid in (").append(tempagencys).append(")");
        }else {
            wheresql.append(" agencyguid='").append(treeid).append("'");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            wheresql.append(" and ").append(tablesql);
        }
        if (querySql != null && !querySql.isEmpty()) {
            wheresql.append(" and (").append(querySql).append(")");
        }
        //根据排序字段进行排序
        wheresql.append(" order by ordernum ");
        String sql = " select t.*,'1' as rowtype from V_PERF_T_INDEXCOMFUNC t where ";
        if (wheresql != null && !wheresql.toString().isEmpty()) {
            sql += wheresql.toString();
        }
        logger.debug("查询语句："+sql);
        List<Map<String, Object>> data = zjTempDataDAO.queryForList(sql);
        //if (data.size() == 0) { //查询模板给默认
            StringBuffer commonsql = new StringBuffer(" select t.*, '1' as rowtype from perf_t_indexcomfunc t where t.year = '2016' and t.province = '87'");
            if ("1".equals(isZJ)) {
                commonsql.append(" and t.proelement = '01'");
            }
            if (isSx) {
                commonsql.append(" and t.proelement in ('sx00','sx01')");
            }
            commonsql.append(" order by t.ordernum");
            List commdar= zjTempDataDAO.queryForList(commonsql.toString());
            data.addAll(commdar);
        //}
        backMap.put("data", data);
        return backMap;
    }
    /**
     * 保存.
     * @param params
     * @throws Exception
     */
    public void savemajorkey(Map<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String agency = (String) params.get("agency"); //单位数据.
        String rowtype = "1";
        String proelement = "";
        String province = CommonUtil.getProvince();
        String year = CommonUtil.getYear();
        String timestamps = PerfUtil.getServerTimeStamp();
        boolean is_hubei = PerfUtil.getIS_HUBEI();
        boolean isSx = PerfUtil.getIsSx();
        List savedata = new ArrayList();
        int levnon = 0;
        for (Map<String, Object> map : datas) {
            rowtype = (String) map.get("rowtype");
            proelement = (String) map.get("proelement");
            levnon = PerfUtil.mapGetInt(map,"_levelno");
            if (is_hubei) {
                if ("02".equals(proelement) && (levnon == 1 || levnon == 2)) {
                    continue;
                }else if ("01".equals(proelement) && levnon == 1){
                    continue;
                } else if (map.get("agencyguid") != null && !agency.equals((String) map.get("agencyguid"))){
                    //湖北地区要求一级分类部门录，单位可以显示部门录入的一级下录入二级 所以保存根据单位判断
                    continue;
                }
            }else if (isSx) {
                if ("sx00".equals(proelement) && (levnon == 1 || levnon == 2)) {
                    continue;
                }else if ("sx01".equals(proelement) && (levnon == 1 || levnon == 2 || levnon == 3)){
                    continue;
                }
            }else{
                if (levnon == 1){
                    continue;
                }
            }
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("dept", map.get("agencyguid").toString().substring(0,3));
                map.put("createtime", timestamps);
                map.put("updatetime", timestamps);
                map.put("province", province);
                map.put("year", year);
                map.put("status", 1);
            } else {
                map.put("updatetime", timestamps);
            }
            savedata.add(map);
        }
        zjTempDataDAO.delDatas("V_PERF_T_INDEXCOMFUNC", " t.agencyguid = '"+agency+"'");
        zjTempDataDAO.saveAll(savedata, "V_PERF_T_INDEXCOMFUNC");
    }

    /**
     * 获取自动生成生产的编码.
     * @param params  -- 参数
     * @return
     * @throws AppException -- 自定义异常.
     */
    public String getMaxcode(HashMap<String, Object> params) throws AppException {
        String agencyguid = (String) params.get("agency");
        return zjTempDataDAO.getMaxCode(agencyguid);
    }

    /**
     * 判断分类是否可以删除
     * @param params  -- 参数
     * @return
     * @throws AppException -- 自定义异常.
     */
    public int isCanDelete(HashMap<String, Object> params) throws AppException {
        String tempguid = (String) params.get("superid");
        String sql = " SELECT count(1) FROM V_PERF_T_INDEXCOMFUNC t where t.superid = ?";
        return zjTempDataDAO.queryForInt(sql, new String[]{tempguid});
    }
}
