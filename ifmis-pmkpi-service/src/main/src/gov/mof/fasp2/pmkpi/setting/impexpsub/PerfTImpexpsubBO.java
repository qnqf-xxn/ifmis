package gov.mof.fasp2.pmkpi.setting.impexpsub;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.appexception.DataSetAppException;
import gov.mof.fasp2.busdic.table.dto.DicTableDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfTImpexpsubBO extends PmkpiBO {
    private PerfTImpexpsubDAO perfTImpexpsubDAO;

    public void setPerfTImpexpsubDAO(PerfTImpexpsubDAO perfTImpexpsubDAO) {
        this.perfTImpexpsubDAO = perfTImpexpsubDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select * from ").append(tablecode).append(" t ");
        StringBuffer wsql = new StringBuffer();
        if (wheresql != null && !wheresql.isEmpty()){
            wsql.append(" (").append(wheresql).append(") and ");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            wsql.append(tablesql).append(" and ");
        }
        if (wsql.length() > 0) {
            returnsql.append(" where ").append(wsql.substring(0, wsql.length() - 4));
        }
        return returnsql.toString();
    }

    /**
     * 初始化数据，将2016年，87分区的数据复制一份当前年度，当前区划的数据
     * @param params
     * @throws AppException
     */
    public Boolean initset(HashMap<String, Object> params) throws AppException {
        //全部数据
        return perfTImpexpsubDAO.initset(params);
    }
    /**
     * 保存.
     * @param params
     * @throws Exception
     */
    public void savemajorkey(Map<String, Object> params) throws AppException {
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");
        String tablecode = (String) params.get("tablecode");
        String treeCode=(String) params.get("treecode");
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        int i = 0;
        String year = CommonUtil.getYear();
        String province = SecureUtil.getUserSelectProvince();
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            i++;
            String ordernum = map.get("ordernum") + "";
            if (ordernum == null || ordernum.isEmpty() || "null".equals(ordernum)) {
                map.put("ordernum", i);
            }
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", province);
                map.put("mainguid", treeCode);
                map.put("year", year);
                map.put("status", 1);
                addlist.add(map);
            } else {
                map.put("updatetime", PerfUtil.getServerTimeStamp());
                uplist.add(map);
            }
        }
        if (addlist.size() > 0) {
            perfTImpexpsubDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            perfTImpexpsubDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            StringBuffer delsql = new StringBuffer(" guid in(");
            for (Map<String, Object> map : deldatas) {
                delsql.append("'").append(map.get("guid")).append("',");
            }
            delsql.deleteCharAt(delsql.length() - 1).append(")");
            perfTImpexpsubDAO.delDatas(tablecode, delsql.toString());
        }
    }

    /**
     * 左侧树查询方法
     * @return
     * @throws DataSetAppException
     * @throws AppException
     */
    public Object getLeftTree() {
        List value = perfTImpexpsubDAO.getLeftTree(perfTImpexpsubDAO.V_PERF_T_IMPEXPMAIN);
        Map<String, Object> leftconfig = new HashMap<String, Object>();
        leftconfig.put("name", "导出模板");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("datas", value);
        return leftconfig;
    }

    /**
     * 编辑区保存模板数据.
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> saveDatas(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String) params.get("tablecode");
        Map<String, Object> data = (Map<String, Object>) params.get("data");
        String guid = (String) data.get("guid");
        String code = (String) data.get("code");
        Map<String, Object> dataMap = perfTImpexpsubDAO.getDataMap(tablecode, "guid = ?", new String[]{guid});
        if (StringUtil.isEmpty((String) data.get("tablecode"))) {
            data.put("tablecode", "dual");
        }
        //如果是新增，则返回模板code存在一存在不可保存
        if(dataMap.isEmpty()){
            int i = perfTImpexpsubDAO.getDataCount(tablecode, "code=?", new String[]{code});
            if (i > 0) {
                backMap.put("success",false);
                backMap.put("msg", "模板编码不可重复！");
            } else {
                data.put("province", SecureUtil.getUserSelectProvince());
                data.put("year", CommonUtil.getYear());
                data.put("guid", this.getCreateguid());
                perfTImpexpsubDAO.save(data, tablecode);
                backMap.put("success",true);
            }
        } else {
            List list = new ArrayList();
            list.add(data);
            perfTImpexpsubDAO.updateAllByPK(this.getTablecol(tablecode), list,"guid", tablecode);
            backMap.put("success",true);
        }
        return backMap;
    }

    public Map<String, Object> delDatas(HashMap<String, Object> params) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String guid=(String) params.get("guid");
        String tablecode = (String) params.get("tablecode");
        String lefttablecode = (String) params.get("lefttablecode");
        String treecode = (String) params.get("treecode");
        List<Map<String, Object>> deldatas = perfTImpexpsubDAO.getDatas(tablecode," mainguid='"+treecode+"'","");
        try {
            perfTImpexpsubDAO.saveAll(deldatas, perfTImpexpsubDAO.PMKPI_TABLE_TMP_GUIDS);
            String delsql = " exists(select 1 from " + perfTImpexpsubDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.guid)";
            //删除配置数据
            perfTImpexpsubDAO.delDatas(tablecode, delsql);
            //删除配置模板
            perfTImpexpsubDAO.delDatas(lefttablecode," guid='"+guid+"'");
            backMap.put("flg", "1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 根据模板code查询这个模板表对应的字段
     * @param params
     * @return
     */
    public List getCol(HashMap<String, Object> params) throws AppException {
        String colTablecode = (String) params.get("colTablecode");
        //根据code查询对应的表名
        if (!StringUtil.isEmpty(colTablecode) && !"dual".equals(colTablecode)) {
            IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
            DicTableDTO dicTableDTO = dicQueryService.getDicTable(colTablecode);
            List<Map<String, Object>> colList = (List) dicTableDTO.getListCol();
            for (Map<String, Object> map : colList) {
                String columncode = (String) map.get("columncode");
                if (!StringUtil.isEmpty(columncode)) {
                    map.put("columncode", columncode.toLowerCase());
                    map.put("guid", columncode.toLowerCase());
                    map.put("code", columncode.toLowerCase());
                }
            }
            return colList;
        }
        return new ArrayList<>();
    }

}
