package gov.mof.fasp2.pmkpi.deptperformance.task;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class DeptTaskBO extends PmkpiBO {

    private DeptTaskDAO deptTaskDAO;

    public void setDeptTaskDAO(DeptTaskDAO deptTaskDAO) {
        this.deptTaskDAO = deptTaskDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        //return super.getVodSql(sqlmap);
        if("edb".equals(DbTypeUtil.getCurrentDBType())){
            createTmpTable(deptTaskDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        String mainguid = (String) sqlmap.get("mainguid");
        String tablecode = (String) sqlmap.get("tablecode");
        String orderby = " order by ordernum";
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode+" where mainguid = '"+ mainguid+"' "+ orderby);
        return  sql.toString();
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        String viewtype = (String) params.get("viewtype");//查询状态
        String indexsql = " t.mainguid = '" + mainguid + "'";
        String orderby = " order by ordernum";
        List<Map<String, Object>> datas = deptTaskDAO.getDatas(tablecode, indexsql, orderby);
        String hidButtons = "";
        if(!"query".equals(viewtype)){//查询状态不加载暂存数据
            if (datas == null || datas.size() <= 0) {
                //业务表无数据，查询有暂存直接返回暂存
                PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
                Map<String, Object> midsavedata = perfMidsaveBO.getMidData(params);
                if(midsavedata!=null && midsavedata.get("result")!=null){
                    datas = (List<Map<String, Object>>) midsavedata.get("result");
                }
                logger.info("---部门整体指标：当前为草稿数据！");
            }else{
                logger.info("---部门整体指标：当前为业务数据！隐藏保存草稿按钮");
                hidButtons = "暂存";
            }
        }
        backMap.put("data", datas);
        backMap.put("hidButtons", hidButtons);
        return backMap;
    }


    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("agency");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("guid",this.getCreateguid());
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("agencyguid", saveAgency);
                map.put("mainguid", mainguid);
                addlist.add(map);
            } else {
                map.put("updatetime", StringUtil.getSysDBDate());
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            deptTaskDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            deptTaskDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            deptTaskDAO.saveAll(deldatas, deptTaskDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + deptTaskDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            deptTaskDAO.delDatas(tablecode, delsql);
        }
        //保存业务数据结束删除暂存数据
        PerfMidsaveBO perfMidsaveBO = PerfServiceFactory.getPerfMidsaveBO();
        perfMidsaveBO.delTabData(params);
        return this.auditdefine(datas, busguid,"perf", null);
    }
}
