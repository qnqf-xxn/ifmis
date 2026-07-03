package gov.mof.fasp2.pmkpi.setting.typicalcase;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.busfw.util.ServiceFactory;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:46 2020/8/18  chongdayong
 */
public class TypicalCaseBO extends PmkpiBO {
    private TypicalCaseDAO typicalCaseDAO;

    public void setTypicalCaseDAO(TypicalCaseDAO typicalCaseDAO) {
        this.typicalCaseDAO = typicalCaseDAO;
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
            if (deldatas.size() > 0) {
                typicalCaseDAO.saveAll(deldatas, typicalCaseDAO.PMKPI_TABLE_TMP_AGENCY);
                String delsql = " exists(select 1 from " + typicalCaseDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
                typicalCaseDAO.updateIsDeleteDatas(tablecode,delsql);
            }
            backMap.put("flg","1");
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String isleaf = (String)sqlmap.get("isleaf"); //节点是否为末级
        String nodeguid = (String)sqlmap.get("nodeguid"); //节点id.
        String tablecode = (String)sqlmap.get("tablecode");
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String orderby = (String) sqlmap.get("orderby"); //排序
        String viewtype = (String) sqlmap.get("viewtype"); //查询
        if (viewtype!=null && "query".equals(viewtype)){
            tablecode =typicalCaseDAO.TABLE_PERF_TYPICALCASEALL;
        }
        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t ");
        StringBuffer wsql = new StringBuffer();
        if(isleaf != null && "1".equals(isleaf)){
            wsql.append(" t.casetype").append("='").append(nodeguid).append("' and ");
        }
        if (wheresql != null && !wheresql.isEmpty()){
            wsql.append(" (").append(wheresql).append(") and ");
        }
        if (tablesql != null && !tablesql.isEmpty()){
            wsql.append(tablesql).append(" and ");
        }
        if (viewtype!=null && "query".equals(viewtype)){//本级加省市已授权
            String province = CommonUtil.getProvince();//本级区划
            String tprovince = province.substring(0,2)+"0000000";//省级区划
            String sprovince = province.substring(0,4)+"00000";//市级区划
            if(province.contains("0000000")){//省级条件 查询本区划数据
                wsql.append(" (province ='"+province+"') and ");
            }else if(province.contains("00000")){//市级条件 查询本区划数据+省级数据（已授权）
                wsql.append(" (province ='"+province+"' or (status = '1' and province ='"+tprovince+"')) and ");
            }else{//区县条件 查询本区划数据+省级数据（已授权）+该区县对应的市级数据（已授权）
                wsql.append(" (province ='"+province+"' or (status = '1' and province in('"+tprovince+"','"+sprovince+"'))) and ");
            }
        }
        if (wsql.length() > 0) {
            returnsql.append(" where ").append(wsql.substring(0, wsql.length() - 4));
        }
        if (orderby == null || orderby.isEmpty()){
            returnsql.append(" order by t.updatetime");
        }
        return returnsql.toString();
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map<String,Object> infosave(HashMap config) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String guid = (String) config.get("mainguid");
        String tablecode = typicalCaseDAO.TABLE_PERF_TYPICALCASE;
        String iswf = (String) config.get("iswf");
        String casetype = (String) config.get("casetype");
        Map<String, Object> infodata = (Map<String, Object>) config.get("data");
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        if (null != guid && !"".equals(guid)) {
            Map map = null;
            List<Map> datas = typicalCaseDAO.getByGuid(tablecode, guid);
            if (datas != null && datas.size() > 0) {//修改
                map = datas.get(0);
                map.putAll(infodata);
                map.put("updatetime", StringUtil.getSysDBDate());
                typicalCaseDAO.update(map, tablecode);
            } else {//新增
                this.getBasMap(infodata, "add");
                infodata.put("casetype",casetype);
                infodata.put("createtime", PerfUtil.getServerTimeStamp());
                infodata.put("updatetime", PerfUtil.getServerTimeStamp());
                infodata.put("creater", user.getGuid());
                infodata.put("province", user.getProvince());
                infodata.put("year", CommonUtil.getYear());
                //初始化 授权状态
                infodata.put("status", "0");
                infodata.put("is_deleted", 2);
                if(iswf != null && "true".equals(iswf)){
                    infodata.put("guid", guid);
                } else {
                    infodata.put("guid", guid);
                    infodata.put("mainguid", guid);
                }
                typicalCaseDAO.save(infodata, tablecode);
            }
            backMap.put("success", true);
        }
        return  backMap;
    }

    /**
     * 编辑区查询.
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String tablecode = typicalCaseDAO.TABLE_PERF_TYPICALCASEALL;//
        Map<String, Object> map = this.getByGuid(tablecode, mainguid);
        backMap.put("editdata", map);
        backMap.put("flg", "1");
        return backMap;
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
        return typicalCaseDAO.getDatas(tablecode, wheresql, null).get(0);
    }

    public List<DicRangeDTO> getTreeData(HashMap<String, Object> params) throws AppException {
        String leftsource = (String) params.get("leftsource");
        String code = (String) params.get("code");
        IDataSetService dss = (IDataSetService) ServiceFactory.getBean("bus.dic.datasetmanagerange.service");
        List<DicRangeDTO> backMap = dss.getRangesByWhereSql(leftsource, code==null?null:"code='"+code+"'");
        return backMap;
    }

    /**
     * 更改授权状态
     * @param params
     * @throws AppException
     */
    public void auth(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = typicalCaseDAO.TABLE_PERF_TYPICALCASE;
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //是否启用
        String status = (String) params.get("status");
        if (datas.size() > 0) {
            for (Map<String, Object> map : datas) {
                map.put("status", status);
                map.put("updatetime", PerfUtil.getServerTimeStamp());
            }
            List<String> cols = new ArrayList<String>();
            cols.add("status");
            cols.add("updatetime");
            typicalCaseDAO.updateAll(cols,datas,tablecode);
        }
    }
}
