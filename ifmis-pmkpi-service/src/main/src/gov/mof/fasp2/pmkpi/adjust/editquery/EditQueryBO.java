package gov.mof.fasp2.pmkpi.adjust.editquery;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EditQueryBO extends PmkpiBO {
    private EditQueryDAO editQueryDAO;

    public void setEditQueryDAO(EditQueryDAO editQueryDAO) {
        this.editQueryDAO = editQueryDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql");
        String proguid = (String) sqlmap.get("proguid");
        String mainguid = (String)sqlmap.get("mainguid"); //主键
        String returnsql = "";
        if ("V_PERF_T_ADJDEPTTASK".equals(tablecode)){
            //调整-年度任务页签 先查调整任务表
            returnsql = "select t.* from "+tablecode+" t where mainguid = '"+mainguid+"'";
            List<Map<String,Object>> list = editQueryDAO.queryForList(returnsql);
            if (list.size() <= 0){
                //没有数据查询申报任务主表
                returnsql = "select t.* from v_perf_t_depttask t where mainguid = '"+proguid+"'";
            }
        }else{
            returnsql = "select t.* from "+tablecode+" t where mainguid = '"+proguid+"'";
        }
        if (tablesql != null && ! tablesql.isEmpty()) {
            returnsql += " and " + tablesql;
        }
        return returnsql;
    }

    /**R
     * 最终保存方法.
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        String tablecode = (String) params.get("tablecode");
        String saveAgency = (String) params.get("saveAgency");
        String proguid = (String)params.get("proguid"); //项目guid
        String mainguid = (String)params.get("mainguid"); //主键
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        List<Map<String, Object>> addlist = new ArrayList();
        List<Map<String, Object>> uplist =  new ArrayList<>();
        if ("V_PERF_T_DEPTTASK".equals(tablecode)){
            tablecode = "V_PERF_T_DEPTTASK";
            for (Map<String, Object> map : datas) {
                String isedit = (String) map.get("add");
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("agencyguid",saveAgency);
                map.put("mainguid",proguid);
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                if ((isedit != null && "1".equals(isedit))) { //新增
                    addlist.add(map);
                }else{  //修改
                    uplist.add(map);
                }
            }
            if (addlist.size() > 0) {
                editQueryDAO.saveAll(addlist, tablecode);
            }
        }else {
            for (Map<String, Object> map : datas) {
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                map.put("agencyguid",saveAgency);
                map.put("mainguid",mainguid);
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                addlist.add(map);
            }
            if (addlist.size() > 0) {
                editQueryDAO.delDatas(tablecode,"mainguid = '"+mainguid+"'");
                editQueryDAO.saveAll(addlist, tablecode);
            }
        }

        if (uplist.size() > 0) {
            editQueryDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            editQueryDAO.saveAll(deldatas, editQueryDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + editQueryDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            editQueryDAO.delDatas(tablecode, delsql);
        }
        return auditdefine(datas, busguid, "perf", null);
    }
}
