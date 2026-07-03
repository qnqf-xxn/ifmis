package gov.mof.fasp2.pmkpi.evaluation.financial.result;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class ResultBO extends PmkpiBO {
    private ResultDAO resultDAO;

    public void setResultDAO(ResultDAO resultDAO) {
        this.resultDAO = resultDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        //String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        //String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        //String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String type = (String) sqlmap.get("type"); //项目调整选择项目
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String finhide = (String) sqlmap.get("finhide");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.* from ").append(ProConfirmDAO.PERF_TABLE_PROCONFIRM).append(" t where t.bustype='").append(lefttabtype).append("' ");
        if (finhide != null && "finacceptnoticehide".equals(finhide)) {
            returnsql.append(" and t.isrelease = 1 ");
        }
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtils.isEmpty(wheresql)){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtils.isEmpty(tablesql)){
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtils.isEmpty(tabfilter)){
            returnsql.append(" and ").append(tabfilter);
        }
        if (StringUtils.isEmpty(type)) {
            String wfsql = this.getWfSql(tabcode, workflow);
            if (!StringUtils.isEmpty(wfsql)) {
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, resultDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        return returnsql.toString();
    }



    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode="v_perf_t_finevaluation";
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='" + bustype + "' ";
        return resultDAO.getLeftTree(tablecode, datarule);
    }

    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, ProConfirmDAO.PERF_TABLE_PROCONFIRM, datas);
        if (actioncode != null && "cancelaudit".equals(actioncode)) {
            resultDAO.saveAll(datas, resultDAO.PMKPI_TABLE_TMP_GUIDS);
            String wheresql = " exists (select 1 from " + resultDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.mainguid) ";
            resultDAO.delDatas("v_perf_expertreview", wheresql);
            wheresql = " exists (select 1 from " + resultDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.review) ";
            resultDAO.delDatas("perf_reviewintermediary", wheresql);
        }
        //处理规范表数据
        this.updateDeptEvalTabelDatas(datas, actioncode);
        return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 获取数据
     * @param mainguid --
     * @return
     */
    public Map<String, Object> getDataById(String mainguid) {
        String sql = " proguid='" + mainguid + "'";
        return resultDAO.getDataMap("v_perf_t_evaluateaudit", sql);
    }

    /**
     * 保存审核意见
     * @param params
     * @return
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        Map<String, Object> editinfo = (Map<String, Object>) params.get("editinfo");
        editinfo.put("guid", this.getCreateguid());
        editinfo.put("createtime", PerfUtil.getServerTimeStamp());
        editinfo.put("updatetime", PerfUtil.getServerTimeStamp());
        editinfo.put("creater", SecureUtil.getCurrentUserID());
        editinfo.put("province", SecureUtil.getUserSelectProvince());
        editinfo.put("year", SecureUtil.getUserSelectYear());
        editinfo.put("status", "1");
        editinfo.put("proguid", mainguid);
        editinfo.put("agencyguid", saveAgency);
        String wheresql = " t.proguid = '"+mainguid+"'";
        resultDAO.delDatas("V_PERF_T_EVALUATEAUDIT",wheresql);
        resultDAO.save(editinfo, "V_PERF_T_EVALUATEAUDIT");
        String remark = (String) editinfo.get("opinion");
        String ordinarytype = (String) editinfo.get("ordinarytype");
        List<Map<String, Object>> datas = this.getDatas(ProConfirmDAO.PERF_TABLE_PROCONFIRM, " guid='" + mainguid + "' ", "");
        Map<String, Object> workflowdata = this.workflow(ordinarytype, workflow, remark, ProConfirmDAO.PERF_TABLE_PROCONFIRM, datas);
        //处理规范表数据
        this.updateDeptEvalTabelDatas(datas, actioncode);
        return workflowdata;    }

    /**
     * 接收通知
     * @param params --
     * @return --
     */
    public Map<String, Object> acceptNotice(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas"); //选中数据
        String type = (String) params.get("type"); //按钮类型 取消2，接收1
        String wheresql = "";
        if (type != null && "acceptnotice".equals(type)) { //接收
            wheresql = " set t.isnotice = 1 ";
        } else if (type != null && "unacceptnotice".equals(type)) { //取消接收
            wheresql = " set t.isnotice = 2";
        }
        resultDAO.saveAll(datas, resultDAO.PMKPI_TABLE_TMP_GUIDS);
        wheresql += " where exists(select 1 from " + resultDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
        resultDAO.updateDatas(ProConfirmDAO.PERF_TABLE_PROCONFIRM, wheresql);
        backMap.put("success", true);
        return backMap;
    }


    /**
     * 判断发起整改的数据表中是否存在
     * @param params
     * @return
     */
    public Integer getDataByGuid(HashMap<String, Object> params){
        String lefttabtype = (String) params.get("lefttabtype");
        String projguid = (String) params.get("projguid");
        String rectype = (String) params.get("rectype");
        String pro_code = (String) params.get("pro_code");
        StringBuffer sql = new StringBuffer("select count(*) from V_PERF_T_RECTIFY t where 1=1 ");
        if ("program".equals(lefttabtype)) { //项目支出
            sql.append(" and pro_code = '"+pro_code+"'");
        } else if ("dept".equals(lefttabtype)) { //部门整体
            sql.append(" and proguid = '"+projguid+"'");
        }
        sql.append(" and rectype = '"+rectype+"'  and wfstatus <> '011'");
        int i = resultDAO.queryForInt(sql.toString());
        return i;
    }

    /**
     * 处理规范表数据
     * @param data
     * @param actioncode
     * @throws AppException
     */
    public void updateDeptEvalTabelDatas ( List<Map<String, Object>> data, String actioncode) throws AppException {
        resultDAO.updateDeptEvalTabelDatas(data,actioncode);
    }

    /**
     * 编辑页查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        List<Map<String, Object>> list = resultDAO.getDatas(tablecode, "t.guid = '" + mainguid + "'", null);
        if (list == null || list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

    /**
     * 评价成果修改
     *
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String) config.get("tablecode");
        String busguid = (String) config.get("busguid");
        String iswf = (String) config.get("iswf");
        String bustype = (String) config.get("bustype");
        String mainguid = (String) config.get("mainguid");
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        infodata.put("guid", mainguid);
        infodata.put("updatetime", PerfUtil.getServerTimeStamp());
        if(!mainguid.isEmpty()){
            List<Map<String, Object>> list = resultDAO.getDatas(tablecode, "t.guid = '" + mainguid + "'", null);
            if(list.size() > 0){
                uplist = list.stream()
                        .map(map -> {
                            Map<String, Object> newMap = new HashMap<>(map);
                            infodata.forEach(newMap::put);
                            return newMap;
                        })
                        .collect(Collectors.toList());
            }
            resultDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        return this.auditdefine(uplist, busguid, "perf", null);
    }
}
