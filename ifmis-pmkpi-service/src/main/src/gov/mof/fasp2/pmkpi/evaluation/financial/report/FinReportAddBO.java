package gov.mof.fasp2.pmkpi.evaluation.financial.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class FinReportAddBO extends PmkpiBO {
    private FinReportAddDAO finReportAddDAO;
    public void setFinReportAddDAO(FinReportAddDAO finReportAddDAO){
        this.finReportAddDAO = finReportAddDAO;
    }

    /**
     * 编辑页查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        String pro_code = (String) params.get("projcode");
        String tablecode = (String) params.get("tablecode");
        List<Map<String, Object>> list = finReportAddDAO.getDatas(tablecode, "t.pro_code = '" + pro_code + "'", null);
        if (list == null || list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

    /**
     * 查询项目编码
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public String getProCode(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String tablecode = (String) params.get("tablecode");
        List<Map<String, Object>> list = finReportAddDAO.getByGuid(tablecode, proguid);
        if (list == null || list.size() == 0) {
            return null;
        }
        return (String) list.get(0).get("pro_code");
    }


    /**
     * 基础信息修改
     *
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) throws AppException {
        String guid = "";
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String) config.get("tablecode");
        String agency = (String) config.get("saveAgency");
        String workflow = (String) config.get("workflow");
        String busguid = (String) config.get("busguid");
        String iswf = (String) config.get("iswf");
        String bustype = (String) config.get("bustype");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        if (iswf == null || "".equals(iswf)) {
            guid = (String) infodata.get("guid");
        } else {
            guid = (String) config.get("mainguid");
        }
        infodata.put("bustype", bustype);
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        if (null != guid && !guid.isEmpty()) {
            Map map = null;
            List<Map> datas = finReportAddDAO.getDataByGuid(tablecode, guid);
            if (datas != null && datas.size() > 0) {//修改
                map = datas.get(0);
                infodata.remove("year");
                infodata.remove("province");
                map.putAll(infodata);
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("agencyguid", map.get("dept_code"));
                map.put("mainguid", config.get("mainguid"));
                finReportAddDAO.update(map, tablecode);
            } else {//新增
                BigInteger initOrderOn = BigInteger.ONE;
                String newguid = this.getCreateguid();
                Map<String, Object> count = finReportAddDAO.getCount(tablecode);
                if (count.get("code") != null && count.get("code") !=""){
                    String code = count.get("code").toString();
                    BigInteger bigInteger = new BigInteger(code);
                    initOrderOn = bigInteger.add(BigInteger.ONE);
                    infodata.put("pro_code",initOrderOn);
                    infodata.put("code",initOrderOn);
                }else {
                    infodata.put("pro_code",initOrderOn);
                    infodata.put("code",initOrderOn);
                }
                infodata.put("createtime", PerfUtil.getServerTimeStamp());
                infodata.put("updatetime", PerfUtil.getServerTimeStamp());
                infodata.put("creater", user.getGuid());
                infodata.put("province", user.getProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", infodata.get("dept_code"));
                infodata.put("isadd", 1); //是否新增项目 1：是   0：否
                infodata.put("status", "1");
                if (iswf != null && "true".equals(iswf)) {
                    infodata.put("guid", guid);
                    infodata.put("proguid", guid);//财政新增项目proguid赋值
                    this.workflow("create", workflow, "", tablecode, l);
                } else {
                    infodata.put("guid", newguid);
                    infodata.put("mainguid", config.get("mainguid"));
                    finReportAddDAO.save(infodata, tablecode);
                }
            }
            backMap.put("success", true);
        }
        return this.auditdefine(l, busguid, "perf", null);
    }



    /**
     * 根据部门或单位获取处室id
     * @param agency
     * @return
     */
    private String getFinintorgguid(String agency) {
        String wheresql = "";
        List<Map<String, Object>> data = null;
        wheresql = " t.guid = '" + agency + "'";
        data = finReportAddDAO.getDatas(PmkpiDAO.PMKPI_TABLE_T_AGENCY, wheresql,"order by code");
        String finintorgguid =null;
        if (data!=null && data.size()!=0){
            finintorgguid = (String) data.get(0).get("finintorg");
        }
        return finintorgguid;
    }

    /**
     * 编辑页查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getdeptData(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        List<Map<String, Object>> list = finReportAddDAO.getDatas(tablecode, "t.guid = '" + mainguid + "'", null);
        if (list == null || list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

}
