package gov.mof.fasp2.pmkpi.setting.proagency;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.*;

public class ProagencyBO extends PmkpiBO {
    private ProagencyDAO proagencyDAO;

    public String time = CommonUtil.getTimeStamp();

    public void setProagencyDAO(ProagencyDAO proagencyDAO) {
        this.proagencyDAO = proagencyDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.* from ");
        returnsql.append(tablecode).append(" t where ");
        returnsql.append(" t.province = '").append(CommonUtil.getProvince()).append("'");
        if (wheresql != null && !wheresql.isEmpty()){
            if (wheresql.contains("pro_code") || wheresql.contains("pro_name")){
                wheresql = wheresql.replaceAll("pro_code","t.pro_code");
                wheresql = wheresql.replaceAll("pro_name","t.pro_name");
            }
            returnsql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        return returnsql.toString();
    }

    /**
     * 列表查询数据.
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        String guid = (String) params.get("guid");
        String tablecode = (String) params.get("tablecode");
        String wheresql = "guid = '"+guid+"'";
        List<Map<String, Object>> datas = proagencyDAO.getDatas(tablecode, wheresql, null);
        backMap.put("data",datas);
        return backMap;
    }

    /**
     * 编辑区保存数据.
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode ="PERF_PROJECT_AGENCY";
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("data");
        List<Map<String, Object>> addList = new ArrayList<Map<String, Object>>();
        String datetime =PerfUtil.getServerTimeStamp();
        if (datas != null && datas.size() >= 0) {
            for (Map<String, Object> data : datas) {
                String rowtype = (String) data.get("rowtype");
                if (rowtype != null && "add".equals(rowtype)) {
                    data.put("guid", this.getCreateguid());
                    data.put("createtime", datetime);
                    data.put("updatetime", datetime);
                    data.put("province", SecureUtil.getUserSelectProvince());
                    data.put("year", CommonUtil.getYear());
                    addList.add(data);
                } else {
                    String pro_code = (String) data.get("pro_code");
                    String pro_name = (String) data.get("pro_name");
                    String agency_code = (String) data.get("agency_code");
                    String agency_name = (String) data.get("agency_name");
                    StringBuffer updatesql = new StringBuffer("set agency_code = '"+agency_code+"', updatetime ='"+datetime+"'");
                    if(!StringUtil.isEmpty(pro_name)){
                        updatesql.append(",pro_name ='"+pro_name+"'");
                    }
                    if (!StringUtil.isEmpty(agency_name)){
                        updatesql.append(",agency_name = '"+agency_name+"'");
                    }
                    updatesql.append(" where pro_code = '"+pro_code+"'");
                    proagencyDAO.updateDatas(proagencyDAO.PMKPI_PERF_PROJECT_AGENCY,updatesql.toString());
                }
            }
            if (addList.size() > 0){
                proagencyDAO.saveAll(addList,proagencyDAO.PMKPI_PERF_PROJECT_AGENCY);
            }
        }
        backMap.put("success",true);
        return backMap;
    }

    /**
     * 删除数据
     * @param params --
     * @return
     */
    public Map<String, Object> delDatas(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String,Object>> dellist =  (List<Map<String,Object>>)params.get("datas");
        try {
            proagencyDAO.saveAll(dellist, proagencyDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + proagencyDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            proagencyDAO.delDatas(proagencyDAO.PMKPI_PERF_PROJECT_AGENCY,delsql);
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 校验项目编码是否存在
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> checkData(HashMap<String, Object> params) throws AppException {
        HashMap<String,Object> backmap = new HashMap<>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("data");
        String procodes ="";
        for (Map<String, Object> data : datas) {
            String pro_code = (String) data.get("pro_code");
            String wheresql = " pro_code = '"+pro_code+"'";
            int dataCount = proagencyDAO.getDataCount(proagencyDAO.PMKPI_TABLE_PROJECT_INFO, wheresql);
            if (dataCount == 0){
                procodes += pro_code+",";
            }
        }
        if (!StringUtil.isEmpty(procodes) && procodes.length() > 0){
            procodes = procodes.substring(0,procodes.length()-1);
           backmap.put("procodes",procodes);
           backmap.put("remark","项目编码为 "+procodes+" 的项目不存在，请检查！");
           backmap.put("success",false);
        }else {
            backmap.put("success",true);
        }
        return backmap;
    }

    /**
     * 校验项目当前年度是否存在数据，确认是否更新
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> checkDataUpdate(HashMap<String, Object> params) throws AppException {
        HashMap<String,Object> backmap = new HashMap<>();
        List<Map<String, Object>>  datas = (List<Map<String, Object>>) params.get("data");
        String procodes ="";
        for (Map<String, Object> data : datas) {
            String pro_code = (String) data.get("pro_code");
            String wheresql = " pro_code = '"+pro_code+"'";
            int dataCount = proagencyDAO.getDataCount(proagencyDAO.PMKPI_PERF_PROJECT_AGENCY, wheresql);
            if (dataCount != 0){
                procodes += pro_code+",";
                data.put("rowtype","mod");
            }
        }
        if (!StringUtil.isEmpty(procodes) && procodes.length() > 0){
            procodes = procodes.substring(0,procodes.length()-1);
            backmap.put("data",datas);
            backmap.put("procodes",procodes);
            backmap.put("success",false);
        }else {
            backmap.put("success",true);
        }
        return backmap;
    }

    /**
     * 查询导入数据
     * @return
     */
    public Map<String, Object> getImportData() {
        Map<String, Object> backMap = new HashMap<>();
        String tablecode = "PERF_TEMP_PROAGENCY";
        String wheresql = " timestamp ='"+time+"'";
        List<Map<String, Object>> returndata = proagencyDAO.getDatas(tablecode, wheresql, null);
        for (Map<String, Object> data : returndata) {
            data.put("rowtype", "add");
        }
        backMap.put("data",returndata);
        //获取到导入数据之后，把中间表保存的本次导入数据删除
        proagencyDAO.delDatas(tablecode,wheresql);
        time = CommonUtil.getTimeStamp(); //更新批次号
        return backMap;
    }

    /**
     * 导入数据
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            List<Map<String, Object>> errorlist = this.checkImpColLength(impDatas, impCols);
            if (errorlist.size() > 0) {
                throw new AppException("ANA-ERROR", "项目单位导入数据错误");
            } else {
                ProagencyBO proagencyBO = (ProagencyBO) PerfServiceFactory.getBean("pmkpi.setting.proagency.ProagencyBOTX");
                proagencyBO.impDatas(proagencyBO, impDatas, impCols, tablecode, resultList, busParams);
            }
        }
    }

    public void impDatas(ProagencyBO proagencyBO, ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        List<Map<String, Object>> dataList = new ArrayList<>();
        for (Object datasMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) datasMap;
            data.put("guid", this.getCreateguid());
            data.put("timestamp", time);
            data.put("createtime", PerfUtil.getServerTimeStamp());
            data.put("updatetime", PerfUtil.getServerTimeStamp());
            data.put("province", SecureUtil.getUserSelectProvince());
            data.put("year", CommonUtil.getYear());
            dataList.add(data);
        }
        HashMap<String,Object> backmap = new HashMap<>();
        backmap.put("data",dataList);
        Map<String, Object> checkMap = this.checkData(backmap);
        if (checkMap != null && !checkMap.isEmpty() && checkMap.get("success").equals(false)) {
            String remark = (String) checkMap.get("remark");
            throw new AppException("导入失败", remark);
        }else{
            proagencyDAO.saveAll(dataList, "PERF_TEMP_PROAGENCY");
        }
    }
}
