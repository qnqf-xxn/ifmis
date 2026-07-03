package gov.mof.fasp2.pmkpi.perfcommon.auditdefine;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AuditDefineBO extends PmkpiBO {
    /**
     * 日志输出
     */
    private final static Logger logger = Logger.getLogger(AuditDefineBO.class);
    
    private AuditDefineDAO auditDefineDAO;

    public void setauditDefineDAO(AuditDefineDAO auditDefineDAO) {
        this.auditDefineDAO = auditDefineDAO;
    }

    /**
     * 获取审核定义校验数据.
     *
     * @param busguid --
     * @return --
     */
    public List getBusauditdefine(String busguid) {
        return auditDefineDAO.getBusauditdefine(busguid);
    }

    /**
     * 审核定义规则校验
     *
     * @param auditdefine   审核定义规则guid 唯一标识
     * @param wheresql     --数据权限
     * @param busguid--业务类型唯一标识
     * @return
     * @throws AppException
     * @throws
     */
    @SuppressWarnings({"unchecked", "rawtypes"})
    public void checkAuditDefinenew(String guidcode, List buslist, Map map, String auditdefine, String wheresql, String busguid, Map busdefinemap) throws AppException {
        map.put("success", true);
        if (buslist != null && buslist.size() == 0) {
            map.put("success", true);
        } else {
            List datalist = new ArrayList();
            Map datamap = new HashMap();
            // 获取审核定义规则
            logger.error("&&&&&&&&&&&&&&&&&&配置审核定义："+auditdefine+"&&&&&&&&&&&&&&");
            List list = this.getAuditDefineByGuid(auditdefine);
            String time = CommonUtil.getTimeStamp();
            //String curragency = "";
            String userguid = "";
            try {
                //curragency = SecureUtil.getCurrentUser().getAgency();
                userguid = SecureUtil.getCurrentUserID();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
            if (wheresql == null || "".equals(wheresql)) {
                wheresql = " 1=1 ";
            }
            String authsql = "";
            if (list.size() == 1) {
                // 业务定义中数据权限定义
                if (authsql == null || authsql.isEmpty()) {
                    authsql += wheresql;
                } else {
                    authsql = authsql + " and " + wheresql;
                }

                Map definemap = (Map) list.get(0);
                String status = definemap.get("status").toString(); // 启用标识 0、未启用，1、启用
                String checkflag = ""; // 按审核说明提示错误信息
                if (definemap != null && definemap.get("checkflag") != null) {
                    checkflag = definemap.get("checkflag") + "";
                }
                logger.error("&&&&&&&&&&&&&&&&&&配置审核定义状态："+status+"&&&&&&&&&&&&&&");
                String sql ="1";
                if (status.equals(sql)) { // 规则是否启用
                    String explain = ""; // 审核说明，即校验有数据时的提示信息
                    if (definemap.get("explain") != null && !"null".equals(definemap.get("explain"))) {
                        explain = definemap.get("explain").toString();
                    }
                    /** 20181022 增加权限设置语句 **/
                    if (authsql == null || authsql.isEmpty()) {
                        authsql = " 1=1 ";
                    }
                    String auditdetype = (String) definemap.get("auditdetype");
                    String auditsql = (String) definemap.get("auditsql");
                    String isalltable = definemap.get("isalltable") == null ? "2" : definemap.get("isalltable") + "";// 是否全表校验
                    String recordadopt = definemap.get("recordadopt") == null ? "1" : definemap.get("recordadopt") + "";// 是否审核通过
                    logger.error("&&&&&&&&&&&&&&&&&&配置审核定义类型："+auditdetype+"&&&&&&&&&&&&&&");
                    if ("procedure".equals(auditdetype)) {// 存储过程处理的逻辑
                        String procedurenew = (String) definemap.get("procedure");
                        // 存储过程 buslist
                        list = this.auditDefineDAO.callprocedurenew(buslist, busdefinemap, procedurenew);
                        if(list.size() == 0){
                            list = auditDefineDAO.queryForList("select * from perf_tmp_auditerrorinfo");
                            logger.error("-------------list-------------："+list+"----------------");
                        }
                        if ("2".equals(recordadopt)) {// 有数据通过
                            list = new ArrayList();
                        }
                    }
                    if ("singletable".equals(auditdetype)) {// 单表校验
                        if ("1".equals(isalltable)) {
                            auditsql = auditsql.replaceAll("#AUTHRULE#", " 1=1 ");
                        } else if("polardb".equalsIgnoreCase(DbTypeUtil.getPhysicsDbType())){
                            List<String> busguidlist = new ArrayList<>();
                            List<Map<String, Object>> querylist = auditDefineDAO.queryForList(" select * from perf_tmp_guids");
                            logger.info("--------perf_tmp_guids--------" + querylist.toString());
                            for (Map<String, Object> querymap : querylist) {
                                busguidlist.add((String) querymap.get("guid"));
                            }
                            authsql = auditDefineDAO.createInSql("busguid", busguidlist);
                            auditsql = auditsql.replaceAll("#AUTHRULE#", authsql);
                        }else {
                            auditsql = auditsql.replaceAll("#AUTHRULE#", authsql);
                        }
                        list = this.auditDefineDAO.queryForList(auditsql);
                        logger.info("-------------auditsql-------------："+auditsql+"----------------");
                        logger.info("-------------list-------------："+list.size()+"----------------");
                        if ("2".equals(recordadopt)) {// 有数据通过
                            list = new ArrayList();
                        }
                    }
                    if ("auditbeanid".equals(auditdetype)) {
                        String beanid = (String) definemap.get("auditbeanid");
                        if (beanid != null && !"".equals(beanid)) {
                            IAuditDefineService iAuditDefineService = (IAuditDefineService) ServiceFactory.getBean(beanid);
                            Map<String, Object> auditMap = iAuditDefineService.checkAuditDefinenewspec(buslist, busguid, wheresql, busdefinemap);
                            list = (List) auditMap.get("data");
                            if ("2".equals(recordadopt)) {// 有数据通过
                                list = new ArrayList();
                            }
                        }
                    }
                    if (list.size() > 0) {
                        for (int i = 0; i < list.size(); i++) {
                            datamap = (Map) list.get(i);
                            if (!"1".equals(checkflag)) {
                                String errmsg = (String) map.get("errstr") == null ? "" : (String) map.get("errstr");
                                errmsg = "/" + (String) datamap.get("remark");
                                map.put("errstr", errmsg);
                            }
                            if ("1".equals(checkflag)) {
                                datamap.put("remark", explain);// 审核说明
                            }
                            datamap.put("explain", explain);// 审核说明
                            datamap.put("code", definemap.get("code").toString());// 审核编号
                            datamap.put("name", definemap.get("name").toString());// 名称
                            datamap.put("createtime", time);
                            datamap.put("userguid", userguid);
                            datalist.add(datamap);
                        }
                        map.put("redata", datalist);
                        map.put("success", false);
                        if ("1".equals(checkflag)) {
                            map.put("errstr", explain);// 审核说明
                        }
                        logger.info("&&&&&&&&&&&&&&&&&&审核定义结果：不通过"+map.toString()+"&&&&&&&&&&&&&&");
                    }
                }
            } else {
                map.put("success", true);
            }
        }
    }

    /**
     * 获取审核定义值集
     *
     * @param auditcode --审核定义编码
     * @return 审核定义要素map
     * @throws
     * @Description:
     */
    public List getAuditDefineByGuid(String auditcode) {
        return auditDefineDAO.getAuditDefineByGuid(auditcode);
    }
}
