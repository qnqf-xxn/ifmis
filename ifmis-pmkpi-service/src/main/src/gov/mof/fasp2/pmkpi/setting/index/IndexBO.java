package gov.mof.fasp2.pmkpi.setting.index;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 14:53 2020/8/17  chongdayong
 */
public class IndexBO extends PmkpiBO {
    private IndexDAO indexDAO;

    public void setIndexDAO(IndexDAO indexDAO) {
        this.indexDAO = indexDAO;
    }

    /**
     * @Description: 指标树.
     * @return Map<String, Object>
     * @throws AppException 异常信息
     */
    @SuppressWarnings("rawtypes")
    public Map<String, Object> getLeftTree() throws AppException {
        List value = new ArrayList();
        List<Map<String, Object>> eledatas = indexDAO.getDeptData();
        value.add(getFinanceIndex());
        value.add(getDeptIndex());
        value.addAll(eledatas);
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", value);
        return leftconfig;
    }

    public Map<String, Object> getFinanceIndex() throws AppException {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("guid", "FINANCE");
        map.put("superguid", "00");
        map.put("levelno", "1");
        map.put("isleaf", "1");
        map.put("code", "0");
        map.put("name", "共性指标");
        return map;
    }

    public Map<String, Object> getDeptIndex() throws AppException {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("guid", "DEPT");
        map.put("superguid", "00");
        map.put("levelno", "1");
        map.put("isleaf", "0");
        map.put("code", "1");
        map.put("name", "部门指标");
        return map;
    }

    /**
     * 显示不同的层次分类
     */
    public List<Map<String, Object>> getFrame(String frametype) {
        return indexDAO.getFrame(frametype);
    }

    /**
     * 保存指标数据.
     * @param params --
     * @return --
     */
    public void save(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String treeid = (String) params.get("treeid");
        String indextype = (String) params.get("indextype");
        String pagetype = (String) params.get("pagetype");
        Map<String, Object> data = (Map<String, Object>) params.get("data");
        data.put("updatetime", PerfUtil.getServerTimeStamp());
        data.put("update_time", PerfUtil.getServerTimeStamp());
        if (pagetype != null && "add".equals(pagetype)) {
            data.put("guid",this.getCreateguid());
            data.put("status", 1);
            data.put("createtime", PerfUtil.getServerTimeStamp());
            data.put("creater", SecureUtil.getCurrentUserID());
            data.put("province", SecureUtil.getUserSelectProvince());
            data.put("year", CommonUtil.getYear());
            data.put("is_common_ind", 1);

            if (indextype != null && "DEPT".equals(indextype)) {
                data.put("agencyguid", treeid);
                data.put("agency_code", treeid);
                data.put("is_common_ind", 2);
            }
            data.put("ind_id", data.get("guid"));
            data.put("perf_ind_name", data.get("name"));
            data.put("kpi_val", data.get("indexvalue"));
            data.put("parent_id", data.get("sindex"));
            data.put("level_no", 3);
            data.put("is_leaf", 1);
            this.getBasMap(data, "add");
            List<Map<String, Object>> addList = new ArrayList<Map<String, Object>>();
            addList.add(data);
            indexDAO.setIndexCode(addList);
            indexDAO.saveAll(addList,tablecode);
            //indexDAO.save(data, tablecode);
        } else {
            indexDAO.update(data, tablecode);
        }
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String tablecode = (String) sqlmap.get("tablecode");
        String treeid = (String) sqlmap.get("treeid");
        String indextype = (String) sqlmap.get("indextype");
        String querySql = (String) sqlmap.get("querySql");
        String isleaf = sqlmap.get("isleaf") + "";
        String wheresql = "";
        if (indextype != null && "DEPT".equals(indextype) && treeid != null && !"DEPT".equals(treeid)) {
            if (isleaf != null && "1".equals(isleaf)) {
                wheresql = " agencyguid='" + treeid + "'";
            } else {
                List<Map<String, Object>> list = indexDAO.getAgencyDatas(treeid);
                indexDAO.saveAll(list, indexDAO.PMKPI_TABLE_TMP_AGENCY);
                wheresql = " exists ( select 1 from " + indexDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid =t.agencyguid) ";
            }
        } else {
            wheresql = " 1=1 ";
        }
        if (querySql != null && !"".equals(querySql)) {
            wheresql += " and (" + querySql + ")";
        }

        String sql = "select t.* from " + tablecode + " t ";
        if (wheresql != null && !"".equals(wheresql)) {
            sql += " where " + wheresql;
        }
        return sql;
    }

    /**
     * 查询
     * @param params
     * @return
     */
    public List<Map<String, Object>> getData(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String treeid = (String) params.get("treeid");
        String indextype = (String) params.get("indextype");
        String querySql = (String) params.get("querySql");
        String isleaf = params.get("isleaf") + "";
        String wheresql = "";
        if (indextype != null && "DEPT".equals(indextype) && treeid != null && !"DEPT".equals(treeid)) {
            if (isleaf != null && "1".equals(isleaf)) {
                wheresql = " agencyguid='" + treeid + "'";
            } else {
                List<Map<String, Object>> list = indexDAO.getAgencyDatas(treeid);
                indexDAO.saveAll(list, indexDAO.PMKPI_TABLE_TMP_AGENCY);
                wheresql = " exists ( select 1 from " + indexDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid =t.agencyguid) ";
            }
        } else {
            wheresql = " 1=1 ";
        }
        if (querySql != null && !"".equals(querySql)) {
            wheresql += " and " + querySql;
        }
        return indexDAO.getDatas(tablecode, wheresql, null);
    }

    /**
     * 编辑查询
     * @param params
     * @return
     */
    public Map<String, Object> getDataByGuid(Map params) {
        String tablecode = (String) params.get("tablecode");
        String guid = (String) params.get("guid");
        String wheresql = " guid='" + guid + "'";
        return indexDAO.getDatas(tablecode, wheresql, null).get(0);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) parms.get("selDatas");
        String tablecode = (String) parms.get("tablecode");
        try {
            indexDAO.saveAll(deldatas, indexDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + indexDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            indexDAO.delDatas(tablecode, delsql);
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }
}
