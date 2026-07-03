package gov.mof.fasp2.pmkpi.workevaluate.audit;

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

public class WorkEvaluateAuditDAO extends PmkpiDAO {
    public String PERF_TABLE_WORKEVALUATE = "V_PERF_T_WORKTASKASSIGN";

    /**
     * 绩效考核评价表 PERF_MANAGE_EVAL
     */
    public static final String PERF_TABLE_MANAGE_EVAL = "V_PERF_MANAGE_EVAL";

    /**
     * 绩效考核指标表 PERF_MANAGE_EVAL_SCORE
     */
    public static final String  PERF_TABLE_MANAGE_SCORE = "V_PERF_MANAGE_EVAL_SCORE";

    /**
     * 绩效考核附件表 PERF_MANAGE_FILE
     */
    public static final String PERF_FILE_TABLE = "V_PERF_MANAGE_FILE";
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
        if (datas != null && datas.size() > 0) {
            List<Map> mainlist = new ArrayList<Map>();
            List<Map> mainscorelist = new ArrayList<Map>();
            List<Map> filelist = new ArrayList<Map>();
            List<String> addguids = new ArrayList<>();
            List<String> delguids = new ArrayList<>();
            List<String> codelist1 = new ArrayList<>();
            List<String> codelist2 = new ArrayList<>();
            List<String> codelist3 = new ArrayList<>();
            String querysql="";
            String delsql="";
            for (Map<String, Object> data : datas) {
                String guid = (String) data.get("guid");
                String wfstatus = (String) data.get("wfstatus");
                String bustype = (String) data.get("bustype");
                String dept_code = (String) data.get("agencyguid");  //部门名称
                String mof_div_code = (String) data.get("province");//区划
                String fiscal_year = (String) data.get("year");//年度
                String sub_mof_div_code = (String) data.get("subprovince");  //下级财政区划编码

                if ("audit".equals(actioncode) || "auditbatch".equals(actioncode)) {
                    if (!StringUtil.isEmpty(wfstatus) && "011".equals(wfstatus)) {//终审
                        addguids.add(guid);
                        codelist1.add(dept_code);
                        codelist2.add(mof_div_code);
                        codelist3.add(sub_mof_div_code);
                    }
                } else if ("cancelaudit".equals(actioncode) || "cancelsendaudit".equals(actioncode)) {
                    if (!"011".equals(wfstatus)) {//取消终审
                        delguids.add(guid);
                        codelist1.add(dept_code);
                        codelist2.add(mof_div_code);
                        codelist3.add(sub_mof_div_code);
                    }
                }
                //删除sql条件
                String sql1 = this.createInSql("dept_code",codelist1);
                String sql2 = this.createInSql("mof_div_code",codelist2);
                String sql3 = this.createInSql("sub_mof_div_code",codelist3);
                if (!StringUtil.isEmpty(bustype) && "dept".equals(bustype)){ //本级部门考核删除条件
                    delsql = sql1 +" and "+ sql2 +" and fiscal_year='"+fiscal_year+"'";
                    querysql = sql2.replaceAll("mof_div_code","province") +" and year='"+fiscal_year+"'";
                }else if (!StringUtil.isEmpty(bustype) && "subprovince".equals(bustype)){//下级财政考核删除条件
                    delsql = sql3 + " and fiscal_year='"+fiscal_year+"'";
                    querysql = sql3.replaceAll("sub_mof_div_code","province") + " and year='"+fiscal_year+"'";
                }
            }
            String scoresql = this.createInSql("mainguid",addguids);
            String filesql = this.createInSql("billguid",addguids);
            scoresql += " and " + querysql;
            if (addguids.size() > 0) {
                //查询评分表要同步的数据
                List<Map<String, Object>> maindata = this.getDatas("perf_t_deptscore", scoresql, null);
                if (maindata != null && maindata.size() > 0) {
                    for (Map<String, Object> datamap : maindata) {
                        datamap.put("eval_dtl_id", datamap.get("guid"));
                        datamap.put("parent_id", datamap.get("superid")); //父级id
                        datamap.put("level_no", datamap.get("levelno")); //级次
                        datamap.put("is_leaf", datamap.get("isleaf")); //是否末级
                        datamap.put("ind_code", datamap.get("ordernum"));   //指标编码
                        datamap.put("ind_name", datamap.get("name"));   //指标名称
                        datamap.put("ind_desc", datamap.get("explain"));   //指标说明
                        datamap.put("kpi_evalstd", datamap.get("evalstd"));   //评(扣)分标准
                        datamap.put("ind_weight", datamap.get("score"));   //分值
                        datamap.put("remark", datamap.get("remark"));   //备注
                        this.setDataMap(datamap,datas);
                        mainscorelist.add(datamap);
                    }
                }

                //评分表需要同步的数据
                List<Map<String, Object>> evaldata = this.getDatas("perf_t_deptscore", scoresql, null);
                if (evaldata != null && evaldata.size() > 0) {
                    for (Map<String, Object> evalmap : evaldata) {
                        evalmap.put("eval_id", evalmap.get("guid"));
                        evalmap.put("ind_code", evalmap.get("ordernum"));   //指标编码
                        evalmap.put("ind_name", evalmap.get("name"));   //指标名称
                        evalmap.put("ind_score", evalmap.get("selfscore"));   //自评得分
                        evalmap.put("eval_score", evalmap.get("ratiscore"));  //评定分数
                        evalmap.put("kpi_evalstd", evalmap.get("evalstd"));   //评(扣)分标准
                        evalmap.put("ind_weight", evalmap.get("score"));   //分值
                        evalmap.put("exist_problems", ""); //存在问题
                        evalmap.put("rectify_step", ""); //整改意见
                        evalmap.put("mof_aud_opinion", "");   //财政审核意见
                        evalmap.put("remark", evalmap.get("remark"));   //备注
                        this.setDataMap(evalmap,datas);
                        mainlist.add(evalmap);
                    }
                }

                //附件表需要同步的数据
                List<Map<String, Object>> filedata = this.getDatas("perf_file", filesql, null);
                if (filedata != null && filedata.size() > 0) {
                    for (Map filemap : filedata) {
                        filemap.put("file_id", filemap.get("guid"));
                        filemap.put("file_name", filemap.get("filename"));//附件名称
                        filemap.put("full_path", "无");//附件路径
                        this.setDataMap(filemap, datas);
                        filelist.add(filemap);
                    }
                }
                if (mainscorelist.size() > 0) {
                    this.saveAll(mainscorelist, PERF_TABLE_MANAGE_SCORE);
                }
                if (mainlist.size() > 0) {
                    this.saveAll(mainlist, PERF_TABLE_MANAGE_EVAL);
                }
                if (filelist.size() > 0) {
                    this.saveAll(filelist, PERF_FILE_TABLE);
                }
            }
            //取消终审
            if (delguids.size() > 0) {
                Integer year = SecureUtil.getUserSelectYear();
                String province = SecureUtil.getUserSelectProvince();
                this.updateDatas(PERF_TABLE_MANAGE_EVAL,"set eval_id = sys_guid(),is_last_inst=2,is_deleted = 1,update_time='"+PerfUtil.getServerTimeStamp()+"' where "+delsql);
                this.updateDatas(PERF_TABLE_MANAGE_SCORE,"set eval_dtl_id = sys_guid(),is_last_inst=2,is_deleted = 1,update_time='"+PerfUtil.getServerTimeStamp()+"' where "+delsql);
                String wheresql = " exists(select 1 from perf_file b where b.guid=t.file_id) and fiscal_year = "+year+" and mof_div_code = '"+province+"'";
                this.updateAllByColumn(null, null, this.PERF_FILE_TABLE, "file_id = sys_guid(),is_last_inst=2,is_deleted = 1", wheresql);
            }
        }
    }

    /**
     * 基础字段赋值
     * @param map
     * @return
     */
    public Map<String, Object> setDataMap(Map<String, Object> map,List<Map<String, Object>> datas){
        if (map != null){
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            map.put("fiscal_year", SecureUtil.getUserSelectYear());
            map.put("mof_div_code", SecureUtil.getUserSelectProvince());
            map.put("mof_div_name", CommonUtil.getProvinceNameByCode((String) map.get("mof_div_code")));
            map.put("create_time", PerfUtil.getServerTimeStamp());
            map.put("update_time", PerfUtil.getServerTimeStamp());
            map.put("is_last_inst", 1);//是否终审
            map.put("is_deleted", 2);
            String guid = (String) map.get("mainguid");
            if (guid == null || guid == ""){
                guid = (String) map.get("billguid");
            }
            for (Map<String, Object> data : datas) {
                if (guid.equals(data.get("guid"))){
                    String bustype = (String) data.get("bustype");
                    if (!StringUtil.isEmpty(bustype) && "subprovince".equals(bustype)){
                        map.put("examinee_type_code", "1");       //考核对象类型代码  1下级财政  2本级部门  3本级财政
                        map.put("examinee_type_name", "下级财政"); //考核对象类型名称

                        String sub_mof_div_code = (String) data.get("subprovince");  //下级财政区划编码
                        String sub_mof_div_name = (String) data.get("sub_mof_div_name");  //下级财政区划名称
                        map.put("sub_mof_div_code", sub_mof_div_code);
                        if (StringUtil.isEmpty(sub_mof_div_name)){
                            String wheresql = " guid = '"+sub_mof_div_code+"'";
                            List<Map<String, Object>> prodatas = this.getDatas("V_ELE_VD08001", wheresql, "");
                            String name = (String) prodatas.get(0).get("name");
                            map.put("sub_mof_div_name", name);
                        }

                        //规范表处室代码和处室名称字段必填，对下级财政进行考核时主管处室字段为空
                        //暂时先存当前登录人所属的处室编码和名称，后续完善规范表后再改
                        String mof_dep_code = (String) data.get("finintorgguid");  //主管处室代码
                        String mof_dep_name = ""; //主管处室名称
                        if (StringUtil.isEmpty(mof_dep_code)){
                            mof_dep_code = CommonUtil.getCurrentUser().getDivision();
                            map.put("mof_dep_code", mof_dep_code);
                            logger.debug("------当前登录用户所属的处室编码："+mof_dep_code);
                            List<DicRangeDTO> eledatas = null;
                            try {
                                eledatas = dss.getRangesByWhereSql("DEPARTMENT", "code='" + mof_dep_code + "'");
                            } catch (AppException e) {
                                e.printStackTrace();
                            }
                            if (eledatas.size() > 0) {
                                map.put("mof_dep_name", eledatas.get(0).get("name"));
                            }
                        }

                    }else if (!StringUtil.isEmpty(bustype) && "dept".equals(bustype)){
                        map.put("examinee_type_code", "2");       //考核对象类型代码  1下级财政  2本级部门  3本级财政
                        map.put("examinee_type_name", "本级部门"); //考核对象类型名称

                        String dept_code = (String) data.get("agencyguid"); //单位
                        map.put("dept_code", dept_code);  //部门编码
                        String dept_name = (String) map.get("dept_name");
                        if (StringUtil.isEmpty(dept_name)) {
                            List<DicRangeDTO> eledatas = null;
                            try {
                                eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY", "guid='" + dept_code + "'");
                            } catch (AppException e) {
                                e.printStackTrace();
                            }
                            if (eledatas.size() > 0) {
                                map.put("dept_name", eledatas.get(0).get("name")); //部门名称
                            }
                        }

                        String mof_dep_code = (String) data.get("finintorgguid");  //主管处室代码
                        String mof_dep_name = (String) data.get("mof_dep_name");  //主管处室名称
                        map.put("mof_dep_code", mof_dep_code);
                        if (StringUtil.isEmpty(mof_dep_name)){
                            List<DicRangeDTO> eledatas = null;
                            try {
                                eledatas = dss.getRangesByWhereSql("DEPARTMENT", "guid='" + mof_dep_code + "'");
                            } catch (AppException e) {
                                e.printStackTrace();
                            }
                            if (eledatas.size() > 0) {
                                map.put("mof_dep_name", eledatas.get(0).get("name"));
                            }
                        }

                    }else{
                        map.put("examinee_type_code", "3");       //考核对象类型代码  1下级财政  2本级部门  3本级财政
                        map.put("examinee_type_name", "本级财政"); //考核对象类型名称

                        //当考核对象类型为3本级财政时，不能为空
                        map.put("ori_div_code",SecureUtil.getUserSelectProvince());
                        map.put("ori_div_name", CommonUtil.getProvinceNameByCode((String) map.get("ori_div_code")));

                        String mof_dep_code = (String) data.get("finintorgguid");  //主管处室代码
                        String mof_dep_name = (String) data.get("mof_dep_name");  //主管处室名称
                        map.put("mof_dep_code", mof_dep_code);
                        if (StringUtil.isEmpty(mof_dep_name)){
                            List<DicRangeDTO> eledatas = null;
                            try {
                                eledatas = dss.getRangesByWhereSql("DEPARTMENT", "guid='" + mof_dep_code + "'");
                            } catch (AppException e) {
                                e.printStackTrace();
                            }
                            if (eledatas.size() > 0) {
                                map.put("mof_dep_name", eledatas.get(0).get("name"));
                            }
                        }
                    }
                }
            }
        }
        return map;
    }
}
