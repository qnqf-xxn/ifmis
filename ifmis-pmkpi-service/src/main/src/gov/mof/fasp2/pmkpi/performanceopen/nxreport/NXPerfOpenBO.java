package gov.mof.fasp2.pmkpi.performanceopen.nxreport;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.performanceopen.report.PerfOpenDAO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class NXPerfOpenBO extends PmkpiBO {

    private PerfOpenDAO perfOpenDAO;

    public void setPerfOpenDAO(PerfOpenDAO perfOpenDAO) {
        this.perfOpenDAO = perfOpenDAO;
    }

    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param sqlmap
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String tablecode = (String) sqlmap.get("tablecode");
        String leftcode = (String) sqlmap.get("leftcode");
        String leftguid = (String) sqlmap.get("leftguid");
        String superguid = "00".equals(sqlmap.get("superguid")) ? leftguid : (String) sqlmap.get("superguid");
        String leftisleaf = sqlmap.get("leftisleaf") + ""; //节点是否为末级
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", "1=1"); //数据权限
        StringBuffer returnsql = new StringBuffer("select t.*,a.filename from ").append(tablecode);
        returnsql.append(" t left join (select pf.billguid,listagg(pf.filename, '；') within group (order by pf.filename) as filename from v_perf_file pf where pf.filetype='perfopen' group by pf.billguid) a on a.billguid =t.guid where");
        returnsql.append(datarule);
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and (").append(wheresql).append(") ");
        }
        returnsql.append(" and t.bustype = '").append(superguid).append("'");
        if (!"open".equals(leftguid) && !"self".equals(leftguid)) {
            String columncode = "agencyguid";
            returnsql.append(this.getLeftTreeWheresql(leftisleaf, columncode, leftcode, perfOpenDAO.PMKPI_TABLE_T_AGENCY));
        }
        return returnsql.toString();
    }

    public Map save(HashMap config) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
        List<String> deldatas = (List<String>) config.get("deldatas");
        String tablecode = perfOpenDAO.PERF_TABLE_MANCEOPEN;
        List<Map<String, Object>> addlist = new ArrayList<>();
        List<Map<String, Object>> uplist = new ArrayList<>();
        if (datas != null && !datas.isEmpty()) {
            for (Map<String, Object> map : datas) {
                String time = PerfUtil.getServerTimeStamp();
                String type = (String) map.get("type");
                if ("add".equals(type)) {
                    map.put("createtime", time);
                    map.put("updatetime", time);
                    map.put("creater", SecureUtil.getCurrentUser().getGuid());
                    map.put("province", SecureUtil.getUserSelectProvince());
                    map.put("year", CommonUtil.getYear());
                    map.put("is_deleted", "2");
                    addlist.add(map);
                } else {
                    map.put("updatetime", time);
                    uplist.add(map);
                }
            }
        }
        if (uplist != null && !uplist.isEmpty()) {
            perfOpenDAO.updateAllByPK(uplist,"guid",tablecode);
        }
        if (addlist != null && !addlist.isEmpty()) {
            perfOpenDAO.saveAll(addlist, tablecode);
        }
        if (deldatas != null && !deldatas.isEmpty()) {
            perfOpenDAO.deleteAllByColumn("guid", deldatas, tablecode);
        }
        return this.auditdefine(datas, null,"perf", null);
    }

    /**
     * 新增查询
     * @throws AppException
     */
    public Map<String, Object> getAddData(HashMap params) {
        String leftcode = (String) params.get("leftcode");
        String bustype = (String) params.get("superguid");
        Map<String, Object> map = new HashMap<>();
        if ("open".equals(bustype)) {
            //查询资金
            String wheresql = "dept_code=?";
            map = this.getDataMap("v_perf_openbgtamt", wheresql, new String[]{leftcode});
        } else if ("self".equals(bustype)) {
            //查询自评项目个数
            String wheresql = " agencyguid like'" + leftcode + "%' and t.bustype not in('dept')";
            int evaluatedpronum = this.getDataCount(PerfSelfApplyDAO.SELFEVALTASK_TABLE, wheresql);
            map.put("evaluatedpronum", evaluatedpronum);
        }
        return map;
    }

}
