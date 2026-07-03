package gov.mof.fasp2.pmkpi.evaluate.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.evaluate.dao.PreEvaluateDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PreEvaluateBo extends PmkpiBO {

    private PreEvaluateDAO preEvaluateDAO;

    public void setPreEvaluateDAO(PreEvaluateDAO preEvaluateDAO) {
        this.preEvaluateDAO = preEvaluateDAO;
    }

    private final PmkpiDAO pmkpiDAO = (PmkpiDAO) ServiceFactory
            .getBean("pmkpi.common.PmkpiDAO");

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String menuid = (String)sqlmap.get("menuid");
        String tablecode = (String)sqlmap.get("tablecode");
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String)sqlmap.get("saveAgency"); //节点id.
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t where ");
        String datarule = this.getDataRuleByMenuguid(menuid, "t", "1=1"); //数据权限
        returnsql.append(datarule);
        if (!StringUtils.isEmpty(wheresql)){
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtils.isEmpty(tablesql)){
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtils.isEmpty(tabfilter)){
            returnsql.append(" and ").append(tabfilter);
        }
        if (tabcode != null && !"waitaudit".equals(tabcode)) {
            String wfsql = this.getWfSql(tabcode, workflow);
            if (!StringUtils.isEmpty(wfsql)) {
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, saveAgency, preEvaluateDAO.PMKPI_TABLE_T_AGENCY));
        return returnsql.toString();
    }

    /**
     * 获取左侧树数据.
     * @param menuId --
     * @return --
     */
    public Map<String, Object> getTreeData(String menuId) throws AppException {

        Map leftconfig = new HashMap();
        List<String> dics = new ArrayList<String>();
        dics.add("program");
        dics.add("dept");
        Object[] tabs = new Object[dics.size()];
        for (int i = 0; i < dics.size(); i++) {
            //List<DicRangeDTO> value = null;
            String elementcode = dics.get(i);
            leftconfig = new HashMap();
            List<Map<String, Object>> treelist = new ArrayList<>();
            if (treelist.size() == 0) {
                Map<String, Object> map = new HashMap<>();
                map.put("guid","treeroot");
                map.put("superid","0");
                map.put("levelno","1");
                map.put("isleaf","0");
                treelist.add(map);
            }
            leftconfig.put("datas", treelist);
            leftconfig.put("showRootNode", Boolean.TRUE);
            leftconfig.put("dosearch", Boolean.FALSE);
            leftconfig.put("outformart", "#code-#name");
            Map f1 = new HashMap();
            if("program".equals(elementcode)){
                leftconfig.put("name", "项目支出");
                f1.put("name", "项目支出");
            }else if ("dept".equals(elementcode)){
                leftconfig.put("name", "部门整体");
                f1.put("name", "部门整体");
            }
            f1.put("code", elementcode);
            f1.put("click", "tabChange");
            f1.put("treeinfo", leftconfig);
            tabs[i] = f1;
        }
        Map m = new HashMap();
        m.put("onlydata", Boolean.TRUE);
        m.put("activeTab", 0);
        m.put("dosearch", Boolean.TRUE);
        m.put("tabs", tabs);
        return m;
    }

    /**
     * 送审/审核/退回/取消审核
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        //审核定义
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, preEvaluateDAO.PERF_REVIEW_SOURCE, datas);
        return this.auditdefine(datas, busguid, "perf", null);
    }

    /**
     * 列表查询.
     * @param params -- 参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String orderby = (String) params.get("orderby");
        String wheresql = "";
        List<Map<String, Object>> data = null;
        String mainguid = (String)params.get("mainguid");
        String tablecode = (String)params.get("tablecode");
        String tablesql = (String)params.get("tablesql");
        //String agency = (String) params.get("agency");
        //String prolev = (String) params.get("prolev");//等级
        //String uikey = (String) params.get("uikey");//表key做特殊处理
        wheresql = " t.mainguid = '" + mainguid + "'";
        if (!StringUtils.isEmpty(tablesql)) {
            wheresql += tablesql;
        }
        data = preEvaluateDAO.getDatas(tablecode, wheresql, orderby);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 编辑区查询.
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        String iswf = (String) params.get("iswf"); //区分是主编辑区，其他编辑区不要这个参数
        List list = preEvaluateDAO.getByGuid(tablecode, mainguid, iswf);
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        backMap.put("editdata", map);
        return backMap;
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map infosave(HashMap config) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        String guid = (String) config.get("mainguid");
        String iswf = (String) config.get("iswf");
        String tablecode = (String) config.get("tablecode");
        String saveAgency = (String) config.get("saveAgency");
        String busguid = (String) config.get("busguid");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        infodata.put("pro_id", guid);
        if(!StringUtils.isEmpty(guid)){
            Map map = null;
            List<Map> datas = preEvaluateDAO.getByGuid(tablecode, guid, iswf);
            if (datas != null && datas.size() > 0) {//修改
                map = datas.get(0);
                map.putAll(infodata);
                map.put("updatetime", StringUtil.getSysDBDate());
                preEvaluateDAO.update(map, tablecode);
            } else {//新增
                infodata.put("createtime", PerfUtil.getServerTimeStamp());
                infodata.put("updatetime", PerfUtil.getServerTimeStamp());
                infodata.put("creater", user.getGuid());
                infodata.put("province", user.getProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", saveAgency);
                //初始化有效状态
                infodata.put("status", "1");
                this.getBasMap(infodata,"add");
                if(iswf != null && "true".equals(iswf)){ //只有主表编辑区才会新增工作流，其他
                    infodata.put("guid", guid);
                    //this.workflow("create",workflow, "", tablecode, l);
                } else {
                    infodata.put("mainguid", guid);
                    preEvaluateDAO.save(infodata, tablecode);
                }
            }
            backMap.put("success", true);
        }
        return this.auditdefine(l, busguid,"perf", null);
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> tablesave(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //关联字段
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String busguid = (String) params.get("busguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //修改数据
        //List<Map<String, Object>> updatas = (List<Map<String, Object>>) params.get("updatas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        List<String> deltables = (List<String>) params.get("deltables");
        List<String> delcols = (List<String>) params.get("delcols");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            //String guid = (String) map.get("guid");
            map.put("ordernum", i++);
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("agencyguid", saveAgency); //这个考虑一级项目挂在处室处理?以后处理,页面得传递columncode
                map.put("mainguid", mainguid);
                addlist.add(map);
            } else {
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            preEvaluateDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            preEvaluateDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            preEvaluateDAO.saveAll(deldatas, preEvaluateDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + preEvaluateDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            preEvaluateDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + preEvaluateDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    preEvaluateDAO.delDatas(deltable, delsql);
                }
            }
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }


    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String menuId = (String) params.get("menuid");
        String tablecode = (String) params.get("tablecode");
        String datarule = this.getDataRuleByMenuguid(menuId, "t", "1=1");
        //根据权限查询单位
        datarule += " and type='assessment'";
        return preEvaluateDAO.getLeftTree(tablecode, datarule);
    }

}
