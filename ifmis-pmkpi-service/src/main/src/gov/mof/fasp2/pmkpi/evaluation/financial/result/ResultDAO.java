package gov.mof.fasp2.pmkpi.evaluation.financial.result;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class ResultDAO extends PmkpiDAO {

    public static final String PERF_TABLE_PROCONFIRM = "v_perf_t_finevaluation";

    /**
     * 财政评价规范表 PM_PERF_GOV_EVAL
     */
    public static final String PERF_TABLE_GOV_EVAL = "V_PM_PERF_GOV_EVAL";

    /**
     * 绩效评价附件表
     */
    public static final String PERF_FILE_TABLE = "V_PERF_PUBLIC_FILE";

    /**
     * 根据权限获取单位
     * @param wheresql
     * @return
     */
    public List<Map<String, Object>> getTreeList(String wheresql, String tablecode) {
        String sql = "select * from PMKPI_FASP_T_PUBAGENCY m where 1=1 and exists "
                + "(select 1 from (select * from " + tablecode + " t where "
                + wheresql
                + " ) n where m.guid = n.agencyguid ) order by code";
        return this.queryForList(sql);
    }

    /**
     * 处理规范表数据
     * @param datas
     * @param actioncode
     * @throws AppException
     */
    public void updateDeptEvalTabelDatas (List<Map<String, Object>> datas, String actioncode) throws AppException {
        if(datas != null && datas.size()>0) {
            List<Map> mainlist = new ArrayList<Map>();
            List<Map> filelist = new ArrayList<Map>();
            List<String> addguids = new ArrayList<>();
            List<String> delguids = new ArrayList<>();
            for (Map<String, Object> data : datas) {
                String guid = (String) data.get("guid");
                String wfstatus = (String) data.get("wfstatus");
                if ("audit".equals(actioncode) || "auditbatch".equals(actioncode) || "sendaudit".equals(actioncode)) {
                    if (!StringUtil.isEmpty(wfstatus) && "011".equals(wfstatus)) {//终审
                        addguids.add(guid);
                    }
                } else if ("cancelaudit".equals(actioncode) || "cancelsendaudit".equals(actioncode)) {
                    if (!"011".equals(wfstatus)) {//取消终审
                        delguids.add(guid);
                    }
                }
            }
            String sql = this.createInSql("guid", addguids);
            String filewheresql = this.createInSql("billguid", addguids);
            if(addguids.size() > 0) {
                //查询需要同步的数据
                List<Map<String, Object>> maindata = this.getDatas(PERF_TABLE_PROCONFIRM, sql,null);
                List<Map<String, Object>> filedata = this.getDatas("perf_file", filewheresql, null);

                //处理部门评价主表信息
                if (maindata != null && maindata.size() > 0) {
                    for (Map deptmap : maindata) {
                        deptmap.put("eval_id", deptmap.get("guid"));
                        deptmap.put("pro_code", deptmap.get("code"));
                        deptmap.put("pro_name", deptmap.get("name"));
                        deptmap.put("mof_aud_opinion", deptmap.get("opinion"));//财政审核意见
                        deptmap.put("eval_report", 1); //部门评价报告，默认值1
                        deptmap.put("is_last_inst", 1);//是否终审
                        deptmap.put("is_deleted", 2);
                        deptmap.put("fiscal_year", SecureUtil.getUserSelectYear());
                        deptmap.put("mof_div_code", SecureUtil.getUserSelectProvince());
                        deptmap.put("mof_div_name", CommonUtil.getProvinceNameByCode((String) deptmap.get("mof_div_code")));
                        deptmap.put("update_time", PerfUtil.getServerTimeStamp());
                        deptmap.put("create_time", PerfUtil.getServerTimeStamp());
                        this.setDataMap(deptmap);
                        mainlist.add(deptmap);
                    }
                }
                //处理附件信息
                if (filedata != null && filedata.size() > 0) {
                    for (Map filemap : filedata) {
                        filemap.put("file_id", filemap.get("guid"));
                        filemap.put("eval_id", filemap.get("billguid"));
                        filemap.put("file_name", filemap.get("filename"));//附件名称
                        filemap.put("full_path", "无");//附件路径
                        filemap.put("report_type_code", "3");//绩效评价报告类型代码 1.单位自评 2.部门评价 3.财政评价
                        filemap.put("report_type_name", "财政评价");//绩效评价报告类型名称
                        filemap.put("is_last_inst", 1);//是否终审
                        filemap.put("is_deleted", 2);
                        filemap.put("fiscal_year", SecureUtil.getUserSelectYear());
                        filemap.put("mof_div_code", SecureUtil.getUserSelectProvince());
                        filemap.put("mof_div_name", CommonUtil.getProvinceNameByCode((String) filemap.get("mof_div_code")));
                        filemap.put("update_time", PerfUtil.getServerTimeStamp());
                        filemap.put("create_time", PerfUtil.getServerTimeStamp());
                        filelist.add(filemap);
                    }
                }
                if (mainlist.size() > 0) {
                    this.saveAll(mainlist, PERF_TABLE_GOV_EVAL);
                }
                if (filelist.size() > 0) {
                    this.saveAll(filelist, PERF_FILE_TABLE);
                }
            }
            //取消终审
            if(delguids.size()>0){
                String delsql = "is_last_inst=2,is_deleted = 1";
                this.updateAllByColumn("eval_id", delguids, this.PERF_TABLE_GOV_EVAL, " eval_id = sys_guid(),"+delsql, null);
                this.updateAllByColumn("eval_id", delguids, this.PERF_FILE_TABLE, " file_id = sys_guid(),"+delsql, null);
            }

        }
    }

    /**
     * 基础字段赋值
     * @param map
     * @return
     */
    public Map<String, Object> setDataMap(Map<String, Object> map){
        if (map != null){
            String agencyguid = (String) map.get("agencyguid");  //单位编码
            map.put("agency_code", agencyguid);
            if (!StringUtil.isEmpty(agencyguid) && agencyguid.length() >= 3) {
                IDataSetService dss = PerfServiceFactory.getIDataSetService();
                if (agencyguid.length() > 0) {
                    String dept_code = agencyguid.length() == 3 ? agencyguid : agencyguid.substring(0, agencyguid.length() - 3);
                    map.put("dept_code", dept_code);  //部门编码
                    String dept_name = (String) map.get("dept_name");  //部门名称
                    if (StringUtil.isEmpty(dept_name)) {
                        List<DicRangeDTO> eledatas = null;
                        try {
                            eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY", "guid='" + dept_code + "'");
                        } catch (AppException e) {
                            e.printStackTrace();
                        }
                        if (eledatas.size() > 0) {
                            map.put("dept_name", eledatas.get(0).get("name"));
                        }
                    }
                }
                String agency_name = (String) map.get("agency_name"); //单位名称
                if (StringUtil.isEmpty(agency_name)) {
                    List<DicRangeDTO> eledatas = null;
                    try {
                        eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY", "guid='" + agencyguid + "'");
                    } catch (AppException e) {
                        e.printStackTrace();
                    }
                    if (eledatas.size() > 0) {
                        map.put("agency_name", eledatas.get(0).get("name"));
                    }
                }
                String bgt_mof_dep_code = (String) map.get("manage_mof_dep_code"); //资金管理处室代码
                if (bgt_mof_dep_code == null){ //财政评价新增项目资金管理处室代码为空，保存finintorgguid字段的值
                    bgt_mof_dep_code = (String) map.get("finintorgguid");
                }
                map.put("bgt_mof_dep_code", bgt_mof_dep_code);
                String bgt_mof_dep_name = (String) map.get("bgt_mof_dep_name");  //资金管理处室名称
                if (StringUtil.isEmpty(bgt_mof_dep_name)) {
                    List<DicRangeDTO> eledatas = null;
                    try {
                        eledatas = dss.getRangesByWhereSql("DEPARTMENT", "guid='" + bgt_mof_dep_code + "'");
                    } catch (AppException e) {
                        e.printStackTrace();
                    }
                    if (eledatas.size() > 0) {
                        map.put("bgt_mof_dep_name", eledatas.get(0).get("name"));
                    }
                }
            }
        }
        return map;
    }
}
