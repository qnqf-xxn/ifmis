package gov.mof.fasp2.pmkpi.externalsys.bim;

import gov.mof.fasp2.buscore.framework.cache.service.CacheManager;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.externalsys.bim.controller.BimModNameChannel;
import gov.mof.fasp2.pmkpi.mqmessage.send.SendMqThread;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class BimModNameBO extends PmkpiBO {
    private BimModNameDAO bimModNameDAO;

    public void setBimModNameDAO(BimModNameDAO bimModNameDAO) {
        this.bimModNameDAO = bimModNameDAO;
    }

    private CacheManager cacheManager;

    private CacheManager getCacheManager() {
        if (cacheManager == null) {
            cacheManager = (CacheManager) ServiceFactory.getBean("buscore.cache.cachemanager");
        }
        return cacheManager;
    }

    /**
     * 修改单位、部门名称
     * @param msg
     * @return
     * @throws AppException
     */
    public int modAgencyName(Map msg) throws AppException {
        String msgid = (String) msg.get("msgid");
        String year = (String) msg.get("year");
        String province = (String) msg.get("province");
        String elecode = (String) msg.get("agencycode");
        String elename = (String) msg.get("newagencyname");
        String isagency = (String) msg.get("isagency");//类型，1：单位 2：部门
        bimModNameDAO.setYearAndProvince(year, province);
        //校验业务数据是否已更新过
        if (this.checkSuccessLog(msgid, year, province)) {
            logger.info("基础库单位名称变更，绩效之前已处理成功， MSG：" + msg);
            return 0;
        }
        //校验中台是否已更新过数据，有延时，校验不通过，注释掉
//        if (!this.checkEleData("V_ELE_VD00010", elecode, elename)) {
//            logger.error("基础库单位名称变更，单位表集未更新，MSG：" + msg);
//            return 2;
//        }
        String wheresql = "";
        //部门修改时，agencyguid存在存储为部门情况，更新全部配置
        if ("1".equals(isagency)) {
            wheresql = " and lower(colcode) in('agencyguid','agency_code')";
        }
        //查询更新业务表配置
        List<Map<String, Object>> configList = bimModNameDAO.queryModConfig(wheresql);
        if (configList.size() == 0) {
            logger.error("基础库单位名称变更，【" + BimModNameDAO.CONFIG_TALBE + "】表未配置，不做数据更新，MSG：" + msg);
            return 3;
        }
        List sqlList = new ArrayList();
        for (Map config : configList) {
            String tableCode = (String) config.get("tablecode");
            String upcolcode = (String) config.get("upcolcode");
            String filtersql = (String) config.get("filtersql");
            String colcode = (String) config.get("colcode");
            String isstand = (String) config.get("isstand");
            String flag = "oracle".equalsIgnoreCase(DbTypeUtil.getCurrentDBType()) ? "N" : "";
            List<String> cols = this.getTablecol(tableCode.toUpperCase());
            String upsql = "";
            String time = PerfUtil.getServerTimeStamp();
            if (cols != null && cols.size() > 0) {
                for (String col : cols) {
                    if ("UPDATE_TIME".equals(col.toUpperCase()) || "UPDATETIME".equals(col.toUpperCase())) {
                        upsql += ", " + col + "='" + time + "'";
                    }
                }
            }
            String sql = "update " + tableCode + " t set " + upcolcode + "=" + flag + "'" + elename + "' ";
            if (!StringUtil.isNullOrEmpty(upsql)) {
                sql += upsql;
            }
            sql += " where " + colcode + "='" + elecode + "'";
            if ("1".equals(isstand)) {
                sql += " and fiscal_year='" + year + "' and mof_div_code='" + province + "'";
            } else if ("2".equals(isstand)){
                sql += " and province='" + province + "'";
            } else {
                sql += " and year='" + year + "' and province='" + province + "'";
            }
            if (!StringUtil.isEmpty(filtersql)) {
                sql += " and (" + filtersql + ") ";
            }
            sqlList.add(sql);
        }
        logger.debug(sqlList.toString());
        bimModNameDAO.batchSingleUpdate(sqlList);
        logger.info("基础库单位名称变更，绩效值集更新完成，更新内容参照【" + BimModNameDAO.CONFIG_TALBE + "】表配置， MSG：" + msg);
        return 1;
    }

    /**
     * 查询日志表，是否已修改
     * @param msgid
     * @param year
     * @param province
     * @return
     */
    private boolean checkSuccessLog(String msgid, String year, String province) {
        return bimModNameDAO.checkSuccessLog(msgid, year, province).size() > 0;
    }

    /**
     * 返回结果到基础库
     * @param resultList
     * @throws AppException
     */
    public void result(List<Map> resultList) throws AppException {
        if (resultList.size() == 0) {
            return;
        }
        String exectime = PerfUtil.getServerTimeStamp();
        List mqMsgList = new ArrayList();
        List saveLogDatas = new ArrayList();
        for (Map resultMap : resultList) {
            String status = resultMap.get("status") + "";
            if (!StringUtil.isNullOrEmpty(status) && !"0".equals(status)) {
                String msgid = (String)resultMap.get("msgid");
                String remark = (String)resultMap.get("remark");
                if ("1".equals(status)) {
                    remark = "执行成功";
                } else if ("3".equals(status)) {
                    remark = "未配置需要更新表";
                }
                resultMap.put("guid", this.getCreateguid());
                resultMap.put("create_time", exectime);
                resultMap.put("remark", remark);
                saveLogDatas.add(resultMap);
                String issuccess = "3".equals(status) ? "2" : "1";
                Map data = new HashMap();
                data.put("msgid", msgid);
                data.put("busname", "预算绩效");
                data.put("issuccess", issuccess);
                data.put("exectime", exectime);
                data.put("remark", remark);
                mqMsgList.add(data);
            }
        }
        if (saveLogDatas.size() > 0) {
            bimModNameDAO.saveLog(saveLogDatas);
            this.sendMq(mqMsgList);
        }
    }

    /**
     * 返回处理消息给基础库
     * @param mqMsgList
     */
    private void sendMq(List mqMsgList) {
        logger.info("基础库单位名称变更，绩效处理完毕，反馈MQ消息给基础库，发送开始，msg：" + mqMsgList);
        Map msgMap = new HashMap();
        msgMap.put("msg", mqMsgList);
        BimModNameChannel channel = (BimModNameChannel) ServiceFactory.getApplicationContext().getBean("gov.mof.fasp2.pmkpi.externalsys.bim.controller.BimModNameChannel");
        new Thread(new SendMqThread(channel.output(), msgMap, "bim_sync_agencyname_feedback")).start();
        logger.info("基础库单位名称变更，绩效处理完毕，反馈MQ消息给基础库，发送结束");
    }

}
