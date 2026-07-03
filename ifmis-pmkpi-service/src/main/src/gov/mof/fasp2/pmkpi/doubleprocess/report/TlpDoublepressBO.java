package gov.mof.fasp2.pmkpi.doubleprocess.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.micro.MicroParamDTO;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.doubleprocess.otherapp.IBdmInterface;
import gov.mof.fasp2.pmkpi.doubleprocess.otherapp.IPdmInterface;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class TlpDoublepressBO extends PmkpiBO {
    /**
     * 日志.
     */
    private final static Logger log = Logger.getLogger(TlpDoublepressBO.class);

    private TlpProgramDAO tlpProgramDAO;

    /**
     * 注入dao.
     *
     * @param tlpProgramDAO --dao.
     * @throws
     */
    public void setTlpProgramDAO(TlpProgramDAO tlpProgramDAO) {
        this.tlpProgramDAO = tlpProgramDAO;
    }

    /**
     * 列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     *
     * @param sqlmap
     * @return
     * @throws AppException
     * @see PmkpiBO#getVodSql(Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
//        List queryConfig = (List) sqlmap.get("queryConfig");
//        Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);//查询去参数
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String) sqlmap.get("menuid");
        String isleaf = (String) sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String) sqlmap.get("nodeguid"); //节点id.
        String tablecode = (String) sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        returnsql.append(" where 1=1");
        returnsql.append(PerfUtil.yearProvinceSql("t"));
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限

        if (!StringUtils.isEmpty(wheresql)) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtils.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtils.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        String wfsql = this.getWfSql(tabcode, workflow);
        if (!StringUtils.isEmpty(wfsql)) {
            returnsql.append(" and (").append(wfsql).append(") ");
        }
        String columncode = "agencyguid";
        returnsql.append(this.getLeftTreeWheresql(isleaf, columncode, nodeguid, tlpProgramDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarule);
        if (StringUtils.isEmpty(orderby)) {
            returnsql.append(" order by t.updatetime");
        }
        logger.debug("======sql===="+returnsql);
        return returnsql.toString();
    }

    /**
     * @param sqlmap
     * @return
     * @throws AppException
     */
    public StringBuffer getDeptfuncQuerySql(Map sqlmap) throws AppException {
        StringBuffer sql = new StringBuffer();
        String mainguid = (String) sqlmap.get("mainguid");
        String tablecode = (String) sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql");
        sql.append(" (select * from ").append(tablecode).append(" where 1=1 ");
        sql.append(" and mainguid='").append(mainguid).append("'");
        if (tablesql != null && !"".equals(tablecode)) {
            sql.append(" and ").append(tablecode);
        }
        sql.append(")");
        return sql;
    }

    /**
     * 获取左侧树数据.
     *
     * @param menuId -- 菜单.
     * @param prolev -- 几级项目.
     * @return --
     */
    @SuppressWarnings({"unchecked"})
    public Map<String, Object> getTreeData(String menuId, String prolev) throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "预算单位");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        if (StringUtils.isEmpty(prolev)) {
            throw new AppException("请在菜单配置是几级项目申报！");
        }
        HashMap<String,Object> map = new HashMap<String,Object>();
        map.put("menuid",menuId);
        leftconfig.put("datas", this.getTreeData(map));
        return leftconfig;
    }

    /**
     * 编辑区保存
     *
     * @param config --
     * @return
     * @throws AppException
     */
    public Map infosave(HashMap config) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String guid = (String) config.get("mainguid");
        String tablecode = "V_PERF_PROJECT_INFODP";
        String saveAgency = (String) config.get("saveAgency");
        String workflow = (String) config.get("workflow");
        String busguid = (String) config.get("busguid");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        infodata.put("pro_id", guid);
        if (!StringUtils.isEmpty(guid)) {
            List<Map<String, Object>> lists = tlpProgramDAO.queryForList("SELECT t.* FROM v_pm_project_info  t  WHERE t.pro_id  = '" + guid + "'");
            Map<String, Object> projMap = lists.get(0);
            List<Map> datas = tlpProgramDAO.getByGuid(tablecode, guid);
            if (datas != null && datas.size() > 0) {//修改
                infodata.put("update_time", StringUtil.getSysDBDate());
                List<String> cols = new ArrayList<String>(infodata.keySet());
                tlpProgramDAO.update(cols, infodata, tablecode); //修改字段
            } else {//新增
                infodata.put("create_time", PerfUtil.getServerTimeStamp());
                infodata.put("update_time", PerfUtil.getServerTimeStamp());
                infodata.put("creater", user.getGuid());
                infodata.put("province", SecureUtil.getUserSelectProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", saveAgency);
                //初始化有效状态
                infodata.put("status", "1");
                infodata.put("guid", guid);
                infodata.put("manage_dept_code", projMap.get("manage_dept_code"));
                infodata.put("manage_mof_dep_code", projMap.get("manage_mof_dep_code"));
                infodata.put("mof_dep_code", projMap.get("mof_dep_code"));
                infodata.put("dept_code", projMap.get("dept_code"));
                infodata.put("agency_code", projMap.get("agency_code"));
                infodata.put("finintorgguid", projMap.get("finintorgguid"));
                this.workflow("create", workflow, "", tablecode, l);
            }
            backMap.put("success", true);
        }
        return this.auditdefine(l, busguid, "perf", null);
    }


    /**
     * 送审/审核/退回/取消审核
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //Map<String, Object> urlparameters = (Map<String, Object>) params.get("urlparameters");
        String workflow = (String) params.get("workflow");
        String actioncode = (String) params.get("actioncode");
        String remark = (String) params.get("remark");
        String tablecode = (String) params.get("tablecode");
        //审核定义
        String busguid = (String) params.get("busguid");
        this.workflow(actioncode, workflow, remark, tablecode, datas);
        return this.auditdefine(datas, busguid, "perf", null);
    }
    /**
     * 编辑区查询.
     *
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        //String agency = (String) params.get("agency");
        //String prolev = (String) params.get("prolev");//等级
        //String uikey = (String) params.get("uikey");//表key做特殊处理
        String tablecode = (String) params.get("tablecode");
        //String iswf = (String) params.get("iswf"); //区分是主编辑区，其他编辑区不要这个参数
        Map<String, Object> map = this.getByGuid(tablecode, mainguid);
        backMap.put("editdata", map);
        return backMap;
    }

    /**
     * 删除
     *
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        String tablecode = (String) parms.get("tablecode");
        List<String> deltables = (List<String>) parms.get("deltables");
        List<String> delcols = (List<String>) parms.get("delcols");
        try {
            tlpProgramDAO.saveAll(deldatas, tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            tlpProgramDAO.delDatas(tablecode, delsql);
            if (deltables != null && deltables.size() > 0) {
                String col = "mainguid";
                int j = 0;
                for (String deltable : deltables) {
                    if (delcols != null && delcols.size() > 0) {
                        col = delcols.get(j);
                    }
                    delsql = " exists(select 1 from " + tlpProgramDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t." + col + ")";
                    tlpProgramDAO.delDatas(deltable, delsql);
                }
            }
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * <p>双流程退回</p >
     *
     * @param
     * @author hw
     * @date 2021/5/16 18:52
     */
    public void dpBack(String remark, List<Map<String, Object>> list) throws AppException {
        /**
         * PERF_PROJECT_INFODP
         */
        for (Map<String, Object> one : list) {
            String mainguid = StringUtil.isEmpty((String) one.get("mainguid")) ? "" : ((String) one.get("mainguid")).trim();
            //String mof_div_code = (String) one.get("mof_div_code");
            //String fiscal_year = (String) one.get("fiscal_year");
            //String taskflag = (String) one.get("taskflag");
            //String protype = (String) one.get("protype");
            List<Map<String, Object>> isExist = tlpProgramDAO.queryForList("SELECT t.* FROM V_PERF_PROJECT_INFODP  t  WHERE t.pro_id  = '" + mainguid + "'");
            if (isExist == null || isExist.isEmpty()) {  // 校验是否存在
                List<Map<String, Object>> lists = tlpProgramDAO.queryForList("SELECT t.* FROM v_pm_project_info  t  WHERE t.pro_id  = '" + mainguid + "'");
                if (lists != null && !lists.isEmpty()) {
                    Map<String, Object> oldOne = lists.get(0);
                    HashMap<String, Object> newOne = new HashMap<>();
                    String guid = this.getCreateguid();
                    String proId = (String) oldOne.get("pro_id");
                    newOne.put("guid", guid);
                    newOne.put("pro_id", proId);
                    newOne.put("pro_code", oldOne.get("pro_code"));
                    newOne.put("pro_name", oldOne.get("pro_name"));
                    newOne.put("pro_lev", oldOne.get("pro_lev"));
                    newOne.put("taskflag", "");
                    newOne.put("agency_code", oldOne.get("agency_code"));
                    newOne.put("province", oldOne.get("province"));
                    //newOne.put("year", oldOne.get("year"));
                    newOne.put("year", CommonUtil.getYear());
                    newOne.put("creater", SecureUtil.getCurrentUser().getGuid());
                    newOne.put("create_time", StringUtil.getSysDBDate());
                    newOne.put("update_time", StringUtil.getSysDBDate());
//                    newOne.put("agencyguid", agencyguid);
                    newOne.put("remark", remark);
                    newOne.put("wfstatus", "000");
                    newOne.put("wfid", "3DC76BC9CDA14F510E6D1B92AA56AAAA");
                    newOne.put("manage_dept_code", oldOne.get("manage_dept_code"));
                    newOne.put("manage_mof_dep_code", oldOne.get("manage_mof_dep_code"));
                    newOne.put("mof_dep_code", oldOne.get("mof_dep_code"));
                    newOne.put("dept_code", oldOne.get("dept_code"));
                    newOne.put("finintorgguid", oldOne.get("finintorgguid"));
                    tlpProgramDAO.save(newOne, "V_PERF_PROJECT_INFODP");
                }
            }
        }
    }


    /**
     * <p>绩效目标审核推送接口</p >
     *
     * @param
     * @author hw
     * @date 2021/5/16 18:52
     */
    public Boolean bdmgoalinfo(List<Map<String, Object>> dataList) throws AppException {
        /**
         * select * from busfw_t_dcworkflowplan
         * select * from busfw_t_dcworkflowbranch
         */

        UserDTO currentUser = SecureUtil.getCurrentUser();
        List<Map<String, Object>> causerrole = tlpProgramDAO.queryForList("select roleguid from fasp_t_causerrole where userguid = '" + currentUser.getGuid() + "'");
        String roleguid = (String) causerrole.get(0).get("roleguid");

        ArrayList<HashMap<String, Object>> wfAudits = new ArrayList<>();
        for (Map<String, Object> map : dataList) {
            List<Map<String, Object>> datas = new ArrayList<>();
            String agencyid = (String) map.get("agencyid"); // 单位guid
            String action = (String) map.get("action"); // 流程操作方向,1:正向（包含新增，送审，审核）;2:反向（退回，取消送审，取消审核）
            if ("1".equals(action)) {
                action = "audit";
            } else if ("2".equals(action)) {
                action = "back";
            }
            String beforwfs = (String) map.get("beforwfs"); // 当前状态
            String lastwfs = (String) map.get("lastwfs"); // 操作后状态
//            String taskflag = (String) map.get("taskflag"); // 可不传，任务标识,1:一上;2:二上
//            String protype = (String) map.get("protype"); // 可不传，任务标识,1:项目;2:部门
            List<Map<String, Object>> infoDps = tlpProgramDAO.queryForList("SELECT t.* FROM V_PERF_PROJECT_INFODP  t  WHERE t.agencyguid  = '" + agencyid + "'");
            if (infoDps == null || infoDps.isEmpty()) {
                return false;
            }
            for (Map<String, Object> proMap : infoDps) { // 当前项目
                String wfid = (String) proMap.get("wfid");
                String beforwfs1 = (String) proMap.get("wfstatus"); // 操作前状态
                String sql = "select * from busfw_t_dcworkflowbranch where roleid = '" + roleguid + "' and wfid = '" + wfid + "' and  action = '" + action + "'";
                List<Map<String, Object>> dcworkflowbranchList = tlpProgramDAO.queryForList(sql);
                Map<String, Object> dcMap = dcworkflowbranchList.get(0); // 当前项目的当前流程节点
                String lastwfs1 = (String) dcMap.get("wfstatus"); // 操作后状态
                if (beforwfs.equals(beforwfs1) && lastwfs.equals(lastwfs1)) {
                    datas.add(proMap);
                } else {
                    return false;
                }
            }
            String wfid = (String) infoDps.get(0).get("wfid");
            //创建当前单位送审数据
            HashMap<String, Object> params = new HashMap<>();
            params.put("datas", datas); // 送审数据集合
            params.put("workflow", wfid);
            params.put("actioncode", action);
            params.put("remark", null);
            params.put("tablecode", "V_PERF_PROJECT_INFODP");
            wfAudits.add(params);
        }
        // 批量送审操作
        for (HashMap<String, Object> params : wfAudits) {
            this.wfAudit(params);
//            System.out.println("-----------------------------------送审" + i + "次！");
        }
        return true;
    }

    /**
     * 获取预算中单位的流程状态，判断接口.
     * @param params -- 前端参数.
     * @return list.
     */
    public Map<String, Object> getBdmWfstatus(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<>();
        log.info("========================bdm开始========================");
        IBdmInterface pmkpiinterface = ServiceFactory.getFeignClient(IBdmInterface.class);
        log.info("========================1========================");
        List<Map<String, Object>> programs = (List<Map<String, Object>>) params.get("programs");
        MicroParamDTO paramDTO = new MicroParamDTO();
        List list = new ArrayList();
        List<String> agencyList = new ArrayList<>();
        String agencyid = "";
        Map temMap = null;
        for (Map<String, Object> temppro: programs) {
            agencyid = (String) temppro.get("agencyguid");
            if (agencyList.contains(agencyid)){
                continue;
            }
            temMap = new HashMap();
            temMap.put("agency_code",agencyid);
            temMap.put("mof_div_code",SecureUtil.getUserSelectProvince());
            temMap.put("fiscal_year",SecureUtil.getUserSelectYear());
            list.add(temMap);
        }
        log.info("=============2===");
        log.info(list.toString());
        log.info("====请求预算服务状态========");
        paramDTO.setList(list);
        MicroParamDTO dto = pmkpiinterface.querytaskflow(paramDTO);
        boolean flag = dto.isBool();
        log.info("============="+flag+"================");
        backMap.put("bool",flag);
        if (!flag){
            backMap.put("mesg",dto.getStr1());
            return  backMap;
        }
        List backAgencys = dto.getList();
        /*List backAgencys = new ArrayList();
        Map temMap1 = new HashMap();
        temMap1.put("agency_code","001001");
        temMap1.put("mof_div_code",SecureUtil.getUserSelectProvince());
        temMap1.put("fiscal_year",SecureUtil.getUserSelectYear());
        temMap1.put("wfstatus","008");
        backAgencys.add(temMap1);*/
        log.info("======= end ======"+backAgencys.toString()+"================");
        Map<String, Object> wfListMap = new HashMap<String, Object>(); //单位对应的项目允许状态
        Map<String, Object> perBdmWfMap = new HashMap<String, Object>(); //预算对应的前状态
        List<Map<String, Object>> wfList = tlpProgramDAO.findPBdmWf(); //工作流对应状态
        String bdmwf = "";
        String perfwf = ""; //绩效状态
        String beforewf = "";
        for (Map<String, Object> tempwf: wfList) {
            bdmwf = (String) tempwf.get("bdmwf");
            perfwf = (String) tempwf.get("perfwf");
            beforewf = (String) tempwf.get("beforewf");
            wfListMap.put(bdmwf,beforewf);
            perBdmWfMap.put(bdmwf,perfwf);
        }
        Map<String, Object> agencyWfMap = new HashMap<String, Object>(); //返回单位状态
        Map temAgencyMap = null;
        String wfstatus = "";
        for (int i = 0; i < backAgencys.size(); i++) {
            temAgencyMap = (Map) backAgencys.get(i);
            agencyid = (String) temAgencyMap.get("agency_code");
            wfstatus = (String) temAgencyMap.get("wfstatus");
            agencyWfMap.put(agencyid,wfstatus);
        }
        //处理项目对应的状态是否可走
        String proname = "";
        String prowfstatus = "";
        String proagency = "";
        String busguid  = "";
        StringBuffer message = new StringBuffer();
        log.info("=======查询的单位状态"+agencyWfMap.toString()+"=====");
        for (Map<String, Object> temppro: programs) {
            busguid = (String) temppro.get("guid");
            proname = (String) temppro.get("pro_name");
            prowfstatus = (String) temppro.get("wfstatus"); //项目状态
            proagency = (String) temppro.get("agencyguid");
            wfstatus  = (String) agencyWfMap.get(proagency);//单位获取的状态.
            beforewf = (String) wfListMap.get(wfstatus); //单位允许的状态
            if (beforewf.indexOf(";"+prowfstatus+";") < 0){
                message.append("[").append(proname).append("]").append("的绩效状态不能早于预算状态！");
            }
            if (prowfstatus.equals(perBdmWfMap.get(wfstatus))){
                String sql = "update V_PERF_PROJECT_INFODP t set t.islast = 0, t.is_deleted = 1 where  t.agencyguid = '" + proagency + "' and t.guid = '" + busguid + "'";
                log.info("=======预算绩效一致，消除退回"+"单位："+proagency+"业务主键"+busguid.toString()+"=====");
                tlpProgramDAO.update(sql);
            }
        }
        if (message.length() > 0){
            backMap.put("bool",false);
        }
        backMap.put("mesg",message.toString());
        return backMap;
    }


    /**
     * 获取项目库中项目的流程状态，判断接口.
     * @param params -- 前端参数.
     * @return list.
     */
    public Map<String, Object> getPmWfstatus(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<>();
        log.info("========================Pm开始========================");
        IPdmInterface pmkpiinterface = gov.mof.fasp2.buscore.framework.util.ServiceFactory.getFeignClient(IPdmInterface.class);
        log.info("========================1========================");
        List<Map<String, Object>> programs = (List<Map<String, Object>>) params.get("programs");
        log.info("========================programs========================"+programs);
        MicroParamDTO paramDTO = new MicroParamDTO();
        List list = new ArrayList();
        List<String> proList = new ArrayList<>();
        String proguid = "";
        Map temMap = null;
        for (Map<String, Object> temppro: programs) {
//            proguid = (String) temppro.get("pro_id");
            String pro_code = (String) temppro.get("pro_code");
            Map<String, Object> infoMap = tlpProgramDAO.getDataMap("v_perf_project_info", " pro_code ='" + pro_code + "'");
            proguid = (String) infoMap.get("pro_id");//项目id
            temppro.put("pro_id",proguid);
            if (proList.contains(proguid)){
                continue;
            }
            temMap = new HashMap();
            temMap.put("proguid",proguid);
            temMap.put("mof_div_code",SecureUtil.getUserSelectProvince());
            temMap.put("fiscal_year",SecureUtil.getUserSelectYear());
            list.add(temMap);
        }
        log.info("=============2===");
        log.info(list.toString());
        log.info("====请求项目库服务状态========"+list);
        paramDTO.setList(list);
        MicroParamDTO dto = pmkpiinterface.querytaskflow(paramDTO);
        boolean flag = dto.isBool();
        log.info("============="+flag+"================");
        backMap.put("bool",flag);
        if (!flag){
            backMap.put("mesg",dto.getStr1());
            return  backMap;
        }
        List backPros = dto.getList();
        /*List backAgencys = new ArrayList();
        Map temMap1 = new HashMap();
        temMap1.put("agency_code","001001");
        temMap1.put("mof_div_code",SecureUtil.getUserSelectProvince());
        temMap1.put("fiscal_year",SecureUtil.getUserSelectYear());
        temMap1.put("wfstatus","008");
        backAgencys.add(temMap1);*/
        log.info("======= end ======"+backPros.toString()+"================");
        Map<String, Object> wfListMap = new HashMap<String, Object>(); //单位对应的项目允许状态
        Map<String, Object> perPdmWfMap = new HashMap<String, Object>(); //预算对应的前状态
        List<Map<String, Object>> wfList = tlpProgramDAO.findPBdmWf(); //工作流对应状态
        log.info("======= 工作流对应状态 ======"+wfList.toString()+"================");
        String bdmwf = "";
        String perfwf = ""; //绩效状态
        String beforewf = "";
        for (Map<String, Object> tempwf: wfList) {
            bdmwf = (String) tempwf.get("bdmwf");
            perfwf = (String) tempwf.get("perfwf");
            beforewf = (String) tempwf.get("beforewf");
            wfListMap.put(bdmwf,beforewf);
            perPdmWfMap.put(bdmwf,perfwf);
        }
        Map<String, Object> agencyWfMap = new HashMap<String, Object>(); //返回单位状态
        Map temAgencyMap = null;
        String wfstatus = "";
        for (int i = 0; i < backPros.size(); i++) {
            temAgencyMap = (Map) backPros.get(i);
            proguid = (String) temAgencyMap.get("proguid");
            wfstatus = (String) temAgencyMap.get("wfstatus");
            agencyWfMap.put(proguid,wfstatus);
        }
        //处理项目对应的状态是否可走
        String proname = "";
        String prowfstatus = "";
        String proagency = "";
        String busguid  = "";
        StringBuffer message = new StringBuffer();
        log.info("=======查询的单位状态"+agencyWfMap.toString()+"=====");
        for (Map<String, Object> temppro: programs) {
            busguid = (String) temppro.get("guid");
            proname = (String) temppro.get("pro_name");
            prowfstatus = (String) temppro.get("wfstatus"); //项目状态
            proagency = (String) temppro.get("pro_id");
            wfstatus  = (String) agencyWfMap.get(proagency);//项目获取的状态.
            beforewf = (String) wfListMap.get(wfstatus); //项目允许的状态
            log.info("======= beforewf ======"+beforewf+"================");
            log.info("======= prowfstatus ======"+prowfstatus+"================");
            log.info("======= perPdmWfMap.get(wfstatus) ======"+String.valueOf(perPdmWfMap.get(wfstatus))+"================");
            if (beforewf.indexOf(";"+prowfstatus+";") < 0){
                message.append("[").append(proname).append("]").append("的绩效状态不能早于项目库状态！");
            }
            if (prowfstatus.equals(perPdmWfMap.get(wfstatus))){
                String sql = "update V_PERF_PROJECT_INFODP t set t.islast = 0, t.is_deleted = 1 where  t.pro_id = '" + proagency + "' and t.guid = '" + busguid + "'";
                log.info("=======预算绩效一致，消除退回"+"项目："+proagency+"业务主键"+busguid.toString()+"=====");
                tlpProgramDAO.update(sql);
            }
        }
        if (message.length() > 0){
            backMap.put("bool",false);
        }
        backMap.put("mesg",message.toString());
        return backMap;
    }


    /**
     * 双流程通过
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String,Object> saveprojdpdatas (HashMap<String, Object> params) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        //山西双流程参数(当流程处于当前系统参数所配置状态时 不做退回操作)
        String sx_doublepress = PerfUtil.getSystemSet("sx_doublepress");
        String workflow = (String) params.get("workflow");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String wheresql = "";
        String reviewSql = "";
        String remark = "";
        for (Map<String, Object> map : datas) {
            String pro_code = (String) map.get("pro_code");
            String mainguid = (String) map.get("mainguid");
            remark = (String) params.get("remark");
            if(StringUtil.isEmpty(pro_code)){
                List<Map<String, Object>> proList = tlpProgramDAO.getProInfo(mainguid);
                if (proList != null && proList.size()>0){
                    pro_code = (String) proList.get(0).get("pro_code");
                }
            }
            wheresql = " t.pro_code = '"+pro_code+"'  and t.islast = '1' ";
            List<Map<String, Object>> list = tlpProgramDAO.getDatas("v_perf_project_infodp",wheresql,null);
            reviewSql = " t.pro_code = '"+pro_code+"' and t.type = 'goal' and t.islast = '1' ";
            List<Map<String, Object>> reviewList = tlpProgramDAO.getDatas("v_perf_t_review",reviewSql,null);
            if(reviewList !=null && reviewList.size()>0){
                tlpProgramDAO.updateislast(pro_code);
            }
            int count = list.size();
            logger.debug("将数据置为无效:"+list.size());
            if (!StringUtils.isEmpty(sx_doublepress)){
//                String wfstatus = "";
//                if (list!=null && list.size()>0){
//                   wfstatus = (String)list.get(0).get("wfstatus");
//                }
//                if (count == 0  || (!StringUtil.isEmpty(wfstatus) && sx_doublepress.indexOf(wfstatus) == -1)){
                    //修改是否最后一次
                    if(count>0){
                        String sql = "update v_perf_project_infodp t set t.islast = 0, t.is_deleted = 1 where  t.pro_code = '"+pro_code+"'";
                        logger.debug("将数据置为无效:"+sql);
                        tlpProgramDAO.update(sql);
                    }
                    List<Map<String, Object>> lists = tlpProgramDAO.queryForList("SELECT t.* FROM V_PM_PROJECT_INFO t  WHERE t.pro_id  = '" + mainguid + "'");
                    Map<String, Object> projMap = new HashMap<>();
                    if (lists != null && !lists.isEmpty()) {
                        projMap = lists.get(0);
                    }
                    map.put("guid", this.getCreateguid());
                    map.put("pro_id", projMap.get("pro_Id"));
                    map.put("pro_code", projMap.get("pro_code"));
                    map.put("pro_name", projMap.get("pro_name"));
                    map.put("pro_lev", projMap.get("pro_lev"));
                    map.put("taskflag", (String) map.get("taskflag"));
                    map.put("agency_code", projMap.get("agency_code"));
                    map.put("lastupdatetime", PerfUtil.getServerTimeStamp());
                    map.put("auditor", SecureUtil.getCurrentUser().getGuid());
                    map.put("province", projMap.get("province"));
                    //map.put("year", projMap.get("year"));
                    map.put("year", CommonUtil.getYear());
                    map.put("creater", SecureUtil.getCurrentUser().getGuid());
                    map.put("create_time", StringUtil.getSysDBDate());
                    map.put("update_time", StringUtil.getSysDBDate());
                    map.put("agencyguid", projMap.get("agency_code"));
                    map.put("remark", remark);
                    map.put("islast", "1");
                    map.put("is_deleted", "2");
                    map.put("manage_dept_code", projMap.get("manage_dept_code"));
                    map.put("manage_mof_dep_code", projMap.get("manage_mof_dep_code"));
                    map.put("mof_dep_code", projMap.get("mof_dep_code"));
                    map.put("dept_code", projMap.get("dept_code"));
                    map.put("finintorgguid", projMap.get("finintorgguid"));
                    try {
                        this.workflow("create",workflow, remark, "v_perf_project_infodp", datas);
                        backMap.put("returnval", "退回成功！！");
                        backMap.put("success", true);
                    }catch (AppException e){
//                        List data = tlpProgramDAO.getByGuid("v_perf_project_infodp",map.get("guid").toString());
                        String sql = "update v_perf_project_infodp set islast = '0',is_deleted = 1 where guid = '"+map.get("guid")+"'";
                        tlpProgramDAO.update(sql);
                        if(reviewList !=null && reviewList.size()>0){
                            Map<String, Object> reviewmap =  reviewList.get(0);
                            String guid = reviewmap.get("guid").toString();
                            if(!StringUtil.isEmpty(guid)){
                                String sql1 = "update v_perf_t_review t set t.islast = 1 where t.guid = '"+guid+"'";
                                tlpProgramDAO.update(sql1);
                            }
                        }
                        backMap.put("returnval", "退回失败！！");
                        backMap.put("success", false);
                    }
//                }
            }
        }
        return backMap;
    }


    /**
     * 保存评审
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String,Object> savereviewdatas (HashMap<String, Object> params) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        String workflow = (String) params.get("workflow");
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //String wheresql = "";,
        for (Map<String, Object> map : datas) {
            String pro_code = (String) map.get("pro_code");
            String mainguid = StringUtil.isEmpty((String) map.get("mainguid")) ? "" : ((String) map.get("mainguid")).trim();
            if(StringUtil.isEmpty(pro_code)){
                List<Map<String, Object>> proList = tlpProgramDAO.getProInfo(mainguid);
                if (proList != null && proList.size()>0){
                    pro_code = (String) proList.get(0).get("pro_code");
                }
            }
            //查询第几次通过
            int count = tlpProgramDAO.findReviewNum(pro_code);
            //wheresql = " t.proguid = '"+mainguid+"' and t.type = 'goal' and t.islast = '1' ";
            //List<Map<String, Object>> list = tlpProgramDAO.getDatas("v_perf_t_review",wheresql,null);
            //修改是否最后一次
            if(count>0){
                tlpProgramDAO.updateislast(pro_code);
            }
            String sql = "update v_perf_project_infodp t set t.islast = 0, t.is_deleted = 1 where  t.pro_code = '" + pro_code + "'";
            tlpProgramDAO.update(sql);
            List<Map<String, Object>> lists = tlpProgramDAO.queryForList("SELECT t.* FROM V_PM_PROJECT_INFO t  WHERE t.pro_id  = '" +mainguid +"'");
            Map<String, Object> projMap = new HashMap<>();
            String agencyguid = "";
            if (lists != null && !lists.isEmpty()) {
                projMap = lists.get(0);
                agencyguid = String.valueOf(projMap.get("agency_code"));
            }
            //当前登录用户
            UserDTO user = SecureUtil.getCurrentUser();
            map.put("guid", this.getCreateguid());
            map.put("createtime", PerfUtil.getServerTimeStamp());
            map.put("updatetime", PerfUtil.getServerTimeStamp());
            map.put("creater", user.getGuid());
            map.put("province", user.getProvince());
            map.put("year", CommonUtil.getYear());
            map.put("agencyguid", agencyguid);
            map.put("status", "1");
            map.put("proguid", mainguid);
            map.put("pro_code", pro_code);
            map.put("islast", 1);
            map.put("reviewnum", count+1);
            map.put("type","goal");
            map.put("isconfirm","2");
            map.put("manage_dept_code",projMap.get("manage_dept_code"));
            map.put("manage_mof_dep_code",projMap.get("manage_mof_dep_code"));
            map.put("mof_dep_code",projMap.get("mof_dep_code"));
            map.put("dept_code",projMap.get("dept_code"));
            map.put("agency_code",projMap.get("agency_code"));
        }
        this.workflow("create",workflow, "", "v_perf_t_review", datas);
        backMap.put("returnval", "保存成功！！");
        backMap.put("success", true);
        return backMap;
    }

    public Map<String, Object> bdmBack(Map<String, Object> params) {
        Map<String,Object> retMap = new HashMap<String, Object>();
        String agencyid = (String) params.get("agencyid");
        //将评审表中符合数据置为无效
        String wheresql = " t.agencyguid = '"+agencyid+"' and t.type = 'goal' and t.islast = '1' ";
        List<Map<String, Object>> list = tlpProgramDAO.getDatas("v_perf_t_review",wheresql,null);
        if(list.size()>0){
            tlpProgramDAO.updateislastByAgency(agencyid);
        }
        //根据预算后状态判断绩效双流程表中数据是否需要置为无效
        String lastwfs = (String) params.get("lastwfs");
        if (!StringUtils.isEmpty(lastwfs)) {
            wheresql = " t.agency_code = '" + agencyid + "'  and t.islast = '1' and wfstatus = '" + lastwfs + "'";
            List<Map<String, Object>> infodplist = tlpProgramDAO.getDatas("v_perf_project_infodp", wheresql, null);
            int count = infodplist.size();
            //修改是否最后一次
            if (count > 0) {
                String sql = "update v_perf_project_infodp t set t.islast = 0, t.is_deleted = 1 where  t.agency_code = '" + agencyid + "' and wfstatus = '" + lastwfs + "'";
                tlpProgramDAO.update(sql);
            }
        }
        retMap.put("result", true);
        retMap.put("reason", "成功");
        return retMap;
    }

    //判断一批项目，是否审核通过
    public List checkAudit(List<Map<String, Object>> list) {
        List result = new ArrayList<Map<String, Object>>();
        if (list != null && list.size()>0){
            for (int i = 0;i<list.size();i++){
                Map<String, Object> map = list.get(i);
                if (map !=null && map.size()>0){
                    String agency_code = String.valueOf(map.get("agency_code"));
                    String mainguid = StringUtil.isEmpty((String) map.get("mainguid")) ? "" : ((String) map.get("mainguid")).trim();
                    String pro_code = String.valueOf(map.get("pro_code"));
                    if(StringUtil.isEmpty(pro_code)){
                        List<Map<String, Object>> proList = tlpProgramDAO.getProInfo(mainguid);
                        if (proList != null && proList.size()>0){
                            pro_code = (String) proList.get(0).get("pro_code");
                        }
                    }
                    if (mainguid !=null && !"".equals(mainguid) && pro_code !=null && !"".equals(pro_code)){
                        String wheresql = " t.agencyguid = '"+agency_code+"' and t.type = 'goal' and t.islast = '1' and t.pro_code = '"+pro_code +"'";
                        List<Map<String, Object>> reviewData = tlpProgramDAO.getDatas("v_perf_t_review",wheresql,null);
                        if (reviewData !=null && reviewData.size()>0){
                            Map resultmap = new HashMap<>();
                            Map<String, Object> reviewMap = reviewData.get(0);
                            String wfstatus = String.valueOf(reviewMap.get("wfstatus"));
                            if(!"212".equals(wfstatus)) {
                                resultmap.put("wfstatus", wfstatus);
                                resultmap.put("mainguid", mainguid);
                                resultmap.put("agency_code", agency_code);
                                List<Map<String, Object>> lists = tlpProgramDAO.queryForList("SELECT t.* FROM V_PM_PROJECT_INFO t  WHERE t.pro_id  = '" +mainguid +"'");
                                String pro_name = "";
                                if (lists !=null && lists.size()>0){
                                    pro_name = String.valueOf(lists.get(0).get("pro_name"));
                                }
                                resultmap.put("pro_name", pro_name);
                                result.add(resultmap);
                            }
                        }
                        wheresql = " t.agency_code = '" + agency_code + "'  and t.islast = '1' and pro_code = '" + pro_code + "'";
                        List<Map<String, Object>> infodplist = tlpProgramDAO.getDatas("v_perf_project_infodp", wheresql, null);
                        if (infodplist !=null && infodplist.size()>0){
                            Map resultmap = new HashMap<>();
                            Map<String, Object> infodpMap = infodplist.get(0);
                            String wfstatus = String.valueOf(infodpMap.get("wfstatus"));
                            String pro_name = String.valueOf(infodpMap.get("pro_name"));
                            if(!"011".equals(wfstatus)) {//绩效处已审核
                                resultmap.put("wfstatus", wfstatus);
                                resultmap.put("mainguid", mainguid);
                                resultmap.put("agency_code", agency_code);
                                resultmap.put("pro_name", pro_name);
                                result.add(resultmap);
                            }
                        }
                    }
                }
            }
        }
        return result;
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String leftmenuid = (String) params.get("menuid");
        String tablecode = "V_PERF_PROJECT_INFODPVIEW";
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        return tlpProgramDAO.getLeftTree(tablecode, datarule);
    }
}
