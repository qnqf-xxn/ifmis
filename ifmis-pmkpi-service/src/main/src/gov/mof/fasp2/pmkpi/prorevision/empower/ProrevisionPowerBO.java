package gov.mof.fasp2.pmkpi.prorevision.empower;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProrevisionPowerBO extends PmkpiBO {
    private ProrevisionPowerDAO revisionPowerDAO;

    public void setRevisionPowerDAO(ProrevisionPowerDAO revisionPowerDAO) {
        this.revisionPowerDAO = revisionPowerDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabcode = (String)sqlmap.get("tabcode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String ordersql = " order by code ";
        StringBuffer returnsql = new StringBuffer("select t.* from ");
        returnsql.append(tablecode).append("  t ");
        returnsql.append(" where 1=1 ");
        //根据menuid获取数据权限
        String datarulestr = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
        if("waitpower".equals(tabcode)){
            //追加排除已授权单位条件
            returnsql.append(" and not exists(select 1 from ").append(revisionPowerDAO.PERF_PROREVISION_AGENCY).append(" a where a.guid=t.guid and length(a.guid)>3) ");
        }
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        String columncode = "guid";
        returnsql.append(this.getLeftTreeWheresql("0", columncode, "treeroot", revisionPowerDAO.PMKPI_TABLE_T_AGENCY));
        returnsql.append(datarulestr);
        if (ordersql != null && !ordersql.isEmpty()){
            returnsql.append(" ").append(ordersql);
        }
        return returnsql.toString();
    }

    public Map<String, Object> revisionpower(HashMap<String, Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String code = (String)parms.get("code");
        String tablecode = "PERF_PROREVISION_AGENCY";
        List<Map<String,Object>> datas =  (List<Map<String,Object>>)parms.get("deldatas");
        try {
            //授权
            if("power".equals(code)){
                //在单位关联表中增加数据
                if (datas != null && datas.size() >= 0) {
                    List<Map<String, Object>> adjustList = new ArrayList<Map<String, Object>>();
                    Map<String, Object> adjustMap = null;
                    for (Map<String, Object> map : datas) {
                        adjustMap = new HashMap<String, Object>();
                        adjustMap.put("guid",  map.get("guid"));
                        adjustMap.put("create_time", StringUtil.getSysDBDate());
                        adjustMap.put("update_time", StringUtil.getSysDBDate());
                        adjustMap.put("creater", SecureUtil.getCurrentUser().getGuid());
                        adjustMap.put("code",map.get("code"));
                        adjustMap.put("name",map.get("name"));
                        adjustMap.put("superid",map.get("superid"));
                        adjustMap.put("levelno",map.get("levelno"));
                        adjustMap.put("province", SecureUtil.getUserSelectProvince());
                        adjustMap.put("year", CommonUtil.getYear());
                        adjustMap.put("status","1");
                        adjustMap.put("finintorgguid", map.get("finintorgguid"));
                        if(map.get("code").toString().length()>3){
                            adjustList.add(adjustMap);
                        }
                    }
                    revisionPowerDAO.saveAll(adjustList,tablecode);
                }
            }else if("cancelpower".equals(code)){//取消授权
                //先删除，不处理验证修订在途数据，只控制授权数据
                revisionPowerDAO.saveAll(datas, revisionPowerDAO.PMKPI_TABLE_TMP_GUIDS);
                String wheresql = "";
                //根据项目信息获取调整主单信息
                wheresql = " exists(select * from "+ revisionPowerDAO.PMKPI_TABLE_TMP_GUIDS + " a where t.guid=a.guid)";
                revisionPowerDAO.delDatas(tablecode,wheresql);
            }
            backMap.put("flg","1");
        }catch (AppException e){
            logger.error("更改授权权限时："+e.getMessage());
            backMap.put("flg","2");
            backMap.put("message",e.getMessage());
        }
        return backMap;
    }
    private List<Map<String,Object>> getRevisionData(List<Map<String,Object>> datas) throws AppException {

        revisionPowerDAO.saveAll(datas, revisionPowerDAO.PMKPI_TABLE_TMP_AGENCY);
        String wheresql = "";
        //根据项目信息获取调整主单信息
        wheresql = " exists(select * from "+ revisionPowerDAO.PMKPI_TABLE_TMP_AGENCY + " a where t.agencyguid=a.guid)";
        //logger.info(revisionPowerDAO.queryForList("select * from "+revisionPowerDAO.PMKPI_TABLE_TMP_AGENCY).toString());
        List<Map<String,Object>> list = new ArrayList<>();
        StringBuffer sql = new StringBuffer();
        sql.append(" select * from ").append(" V_PERF_T_PROVISIONDECLARE ");
        sql.append(" t where 1=1 and t.wfstatus <> '011' ");
        if(wheresql!=null&&!wheresql.isEmpty()){
            sql.append(" and ").append(wheresql);
        }
        list = revisionPowerDAO.queryForList(sql.toString());
        return list;
    }
}
