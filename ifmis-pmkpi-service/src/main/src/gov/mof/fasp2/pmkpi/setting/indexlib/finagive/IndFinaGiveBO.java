package gov.mof.fasp2.pmkpi.setting.indexlib.finagive;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class IndFinaGiveBO extends PmkpiBO {
    private IndFinaGiveDAO indFinaGiveDAO;

    public void setIndFinaGiveDAO(IndFinaGiveDAO indFinaGiveDAO) {
        this.indFinaGiveDAO = indFinaGiveDAO;
    }

    /**
     * 获取左侧树数据.
     * @return --
     */
    public Map<String, Object> getTreeData() throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("name", "行业类别");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        leftconfig.put("datas", dss.getRangesByElementcode("INDEXCOMFUNC"));
        return leftconfig;
    }

    /**
     * 分页查询.
     *
     * @param sqlmap -- sql.
     * @return
     * @throws AppException -- 自定义.
     */
    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String elementcode = (String) sqlmap.get("elementcode"); //指标分类
        String treeid = (String) sqlmap.get("treeid"); //选中节点
        String querySql = (String) sqlmap.get("querySql"); //查询区sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格的过滤sql
        String isleaf = sqlmap.get("isleaf") + ""; //选中节点是否末级
        StringBuffer wheresql = new StringBuffer("");
        wheresql.append(" t.elementcode='").append(elementcode).append("' and ");
        if (isleaf != null && "1".equals(isleaf)) {
            wheresql.append(" t.eltwocode='").append(treeid).append("'");
        } else if (treeid != null && !"treeroot".equals(treeid)) {
            wheresql.append(" t.elonecode='").append(treeid).append("'");
        } else {
            wheresql.append(" 1=1 ");
        }
        String sql = "select t.* from V_PERF_T_INDEXFINAGIVE t where ";
        if (querySql != null && !querySql.isEmpty()) {
            wheresql.append(" and (").append(querySql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            wheresql.append(" and ").append(tablesql);
        }
        if (wheresql != null && !wheresql.toString().isEmpty()) {
            sql += wheresql;
        }
        sql += " order by t.elonecode,t.eltwocode,t.agencycode";
        return sql;
    }

    /**
     * 授权获取初始化的表格和树数据。
     * @param config -- 配置
     * @return
     * @throws AppException -- 自定义异常
     */
    public Map getInitData(Map config) throws AppException {
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        List<DicRangeDTO> depts = dss.getRangesByWhereSql("PMKPIDEPT", " 1= 1 order by code");
        depts.forEach(r->{
            r.put("agencycode", r.getCode());
        });
        config.put("depts", depts);
        List<DicRangeDTO> elements = dss.getRangesByElementcode("INDEXCOMFUNC");
        config.put("elements", elements);
        return config;
    }
    /**
     * 查询部门授权的分类有哪些。
     * @param params -- 参数.
     * @return list.
     */
    public List findDeptEles(HashMap<String,Object> params) {
        List elements = new ArrayList();
        String deptcode = (String) params.get("deptcode");
        elements = indFinaGiveDAO.findDeptEles(deptcode);
        if (elements.size() == 0){
            return new ArrayList();
        }
        return  PerfUtil.lowMapKey(elements);
    }

    /**
     * 最終的保存方法.
     * @param params -- 参数。
     * @return list.
     * @throws AppException -- 自定义异常
     */
    public void saveFinaGive(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        Map<String, List<Map>> depteles = (Map<String, List<Map>>) params.get("depteles");
        List depts = new ArrayList();
        List eles = new ArrayList();
        List<Map> templist = null;
        String tempagency = "";
        String finagivelev = PerfUtil.getSystemSet("finagivelev"); //该区划是否分类是一级，默认二级
        for (Map.Entry entry : depteles.entrySet()) {
            tempagency = (String) entry.getKey();
            depts.add(tempagency);
            templist = (List<Map>) entry.getValue();
            //封装保存的一二级数据.
            String finalTempagency = tempagency;
            if (templist.size() > 0){
                templist.forEach(r->{
                    if ("1".equals(finagivelev)){
                        r.put("agencycode", finalTempagency);
                        r.put("agencyguid", finalTempagency);
                        r.put("elonecode", r.get("superguid"));
                        r.put("eloneguid", r.get("superguid"));
                        r.put("eltwocode", r.get("code"));
                        r.put("eltwoname", r.get("name"));
                        r.put("eltwoguid", r.get("guid"));
                        r.put("elementcode", "INDEXCOMFUNC");
                        r.put("is_deleted", 2);
                        r.put("updatetime", PerfUtil.getServerTimeStamp());
                        r.put("createtime", PerfUtil.getServerTimeStamp());
                        r.put("creater", SecureUtil.getCurrentUser().getGuid());
                        r.put("province", CommonUtil.getProvince());
                        r.put("year", CommonUtil.getYear());
                        r.put("guid", StringUtil.createUUID());
                        eles.add(r); //整体保存
                    } else if (!"#".equals(r.get("superguid")) && !"00".equals(r.get("superguid")) &&
                            !"0".equals(r.get("superguid")) && !"".equals(r.get("superguid"))) {
                        r.put("agencycode", finalTempagency);
                        r.put("agencyguid", finalTempagency);
                        r.put("elonecode", r.get("superguid"));
                        r.put("eloneguid", r.get("superguid"));
                        r.put("eltwocode", r.get("code"));
                        r.put("eltwoname", r.get("name"));
                        r.put("eltwoguid", r.get("guid"));
                        r.put("elementcode", "INDEXCOMFUNC");
                        r.put("is_deleted", 2);
                        r.put("updatetime", PerfUtil.getServerTimeStamp());
                        r.put("createtime", PerfUtil.getServerTimeStamp());
                        r.put("creater", SecureUtil.getCurrentUser().getGuid());
                        r.put("province", CommonUtil.getProvince());
                        r.put("year", CommonUtil.getYear());
                        r.put("guid", StringUtil.createUUID());
                        eles.add(r); //整体保存
                    }
                });
            }
        }
        //删除所有部门的
        indFinaGiveDAO.deleteAllByColumn("agencycode", depts, "V_PERF_T_INDEXFINAGIVE");
        //保存现有最新的授权
        indFinaGiveDAO.saveAll(eles, "V_PERF_T_INDEXFINAGIVE");
    }

}
