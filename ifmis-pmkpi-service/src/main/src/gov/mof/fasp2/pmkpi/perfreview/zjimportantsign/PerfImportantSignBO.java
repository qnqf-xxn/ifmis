package gov.mof.fasp2.pmkpi.perfreview.zjimportantsign;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.*;

public class PerfImportantSignBO extends PmkpiBO {
    private PerfImportantSignDAO perfImportantSignDAO;

    public void setPerfImportantSignDAO(PerfImportantSignDAO perfImportantSignDAO) {
        this.perfImportantSignDAO = perfImportantSignDAO;
    }
    public Map<String, Object> getTableDatas(Map sqlmap) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        String menuid = (String)sqlmap.get("menuid");
        String tablecode = (String)sqlmap.get("tablecode");
        String tabcode = (String)sqlmap.get("tabcode");
        String isleaf = (String)sqlmap.get("isleaf");
        String saveAgency = (String)sqlmap.get("saveAgency");
        String lefttype = (String)sqlmap.get("lefttabtype");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        String elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        String ordersql = " order by pro_code ";
        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        //根据menuid获取数据权限
        StringBuffer whereRuleSql = new StringBuffer(" 1 = 1  ");
        //点击部门获取的权限
        if (!"1".equals(isleaf) && !"treeroot".equals(saveAgency)) {
            whereRuleSql.append( " start with superguid='" + saveAgency + "' connect by prior guid = superguid ");
            logger.debug("获取部门权限的："+whereRuleSql.toString());
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,whereRuleSql.toString());
            List list = new ArrayList();
            Map map = new HashMap();
            map.put("guid",saveAgency);
            list.add(map);
            eledatas.addAll(list);
            perfImportantSignDAO.saveAll(eledatas, perfImportantSignDAO.PMKPI_TABLE_TMP_AGENCY);
        //点击页面默认获取全部的数据权限
        } else if("treeroot".equals(saveAgency)){
            String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null);
            logger.debug("获取全部权限的："+datarule);
            whereRuleSql.append(datarule);
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,whereRuleSql.toString());
            perfImportantSignDAO.saveAll(eledatas, perfImportantSignDAO.PMKPI_TABLE_TMP_AGENCY);
        //末级节点的数据权限
        }else if("1".equals(isleaf)){
            whereRuleSql.append(" and agencyguid = '"+saveAgency+"' ");
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,whereRuleSql.toString());
            perfImportantSignDAO.saveAll(eledatas, perfImportantSignDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer returnsql = new StringBuffer("select t.* from ");
        returnsql.append(tablecode).append("  t ");
        if("program".equals(lefttype)){
            //待标识的项目
            if("waitsign".equals(tabcode)){
                //追加排除已标识的项目
                returnsql.append(" where 1=1 ");
                returnsql.append(" and exists (select 1 from V_BGT_PM_ANNUAL vp where vp.pro_code = t.pro_code and vp.is_deleted = '2') ");
                returnsql.append(" and not exists(select 1 from ").append(perfImportantSignDAO.PERF_SIGN_PROGJECT)
                        .append(" a where a.pro_code=t.pro_code) ");
            }else{
                //已标识的项目
                returnsql.append(" where 1=1 ");
            }
        }else if("dept".equals(lefttype)){
            if("waitsign".equals(tabcode)){
                //待标识的部门项目
                returnsql.append(" where 1=1 and t.is_sign = '0' ");
            }else{
                //已经标识的部门项目
                returnsql.append(" where 1=1 and t.is_sign = '1' ");
            }
            ordersql = " order by code ";
        }
        returnsql.append(" and exists(select 1 from ").append(perfImportantSignDAO.PMKPI_TABLE_TMP_AGENCY).append(" a where a.guid=t.agencyguid) ");
        if (wheresql != null && !wheresql.isEmpty()){
            returnsql.append(" and ").append(wheresql);
        }
        if (tablesql != null && !tablesql.isEmpty()){
            returnsql.append(" and ").append(tablesql);
        }
        if (tabfilter != null && !tabfilter.isEmpty()){
            returnsql.append(" and ").append(tabfilter);
        }
        if (ordersql != null && !ordersql.isEmpty()){
            returnsql.append(" ").append(ordersql);
        }
        logger.debug("查询sql语句："+returnsql);
        StringBuffer sql = new StringBuffer();
        sql.append("select pro_code from V_PERF_SIGN_PROJECT_INFO group by pro_code");
//        List<String> signList =  perfImportantSignDAO.queryForList(sql.toString());
        List<Map<String,Object>> data = perfImportantSignDAO.queryForList(returnsql.toString());
        backMap.put("data", data);
        return backMap;
    }
        /*
        查询左侧树
        */
        public Map<String, Object> getTreeData(String menuId,String lefttypes) throws AppException {
            Map leftconfig = new HashMap();
            List<String> dics = new ArrayList<String>();
            if(StringUtils.isEmpty(lefttypes)){
                dics.add("program");
                //dics.add("dept");
            }else{
                String[] leftArry = lefttypes.split(",");
                dics = Arrays.asList(leftArry);
            }
            Object[] tabs = new Object[dics.size()];
            String elementcodes = "PMKPIAGENCYALLPAY";
            StringBuffer wheresql = new StringBuffer("");
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            wheresql.append(" 1 = 1 ");
            for (int i = 0; i < dics.size(); i++) {
                //List<DicRangeDTO> value = null;
                String elementcode = dics.get(i);
                leftconfig = new HashMap();
                if ("program".equals(elementcode)) {
                    String datarule = this.getDataRuleByMenuguidNull(elementcode+perfImportantSignDAO.PERF_STRING_REVIEW, "t", "");
                    //根据权限查询单位
                    wheresql.append(datarule);
                    List<DicRangeDTO> list = dss.getRangesByWhereSql(elementcodes, wheresql.toString());
                    if (list.size() <= 0) {
                        DicRangeDTO map = new DicRangeDTO();
                        map.setGuid("treeroot");
                        map.setName("全部");
                        map.setCode("00");
                        map.setLevelno("1");
                        map.setSuperguid("0");
                        map.setIsleaf("0");
                        list.add(map);
                        leftconfig.put("datas", list);
                    }else{
                        leftconfig.put("datas", list);
                    }
                } else {
                    String datarule = this.getDataRuleByMenuguidNull(elementcode+perfImportantSignDAO.PERF_STRING_REVIEW, "t", "");
                    //根据权限查询单位
                    wheresql.append(datarule);
                    wheresql.append(" and levelno = '1' ");
                    List<DicRangeDTO> list = dss.getRangesByWhereSql(elementcodes, wheresql.toString());
                    if (list.size() <= 0) {
                        DicRangeDTO map = new DicRangeDTO();
                        map.setGuid("treeroot");
                        map.setName("全部");
                        map.setCode("00");
                        map.setLevelno("1");
                        map.setSuperguid("0");
                        map.setIsleaf("0");
                        list.add(map);
                        leftconfig.put("datas", list);
                    }else{
                        leftconfig.put("datas", list);
                    }
                }
                leftconfig.put("showRootNode", Boolean.TRUE);
                leftconfig.put("dosearch", Boolean.FALSE);
                leftconfig.put("outformart", "#code-#name");
                leftconfig.put("expandlevel", 2);
                Map f1 = new HashMap();
                if ("program".equals(elementcode)) {
                    leftconfig.put("name", "项目支出");
                    f1.put("name", "项目支出");
                } else if ("dept".equals(elementcode)) {
                    leftconfig.put("name", "部门整体");
                    f1.put("name", "部门整体");
                }
                f1.put("code", elementcode);
                f1.put("click", "tabChange");
                f1.put("treeinfo", leftconfig);
                tabs[i] = f1;
            }
            Map m = new HashMap();
            m.put("onlydata", Boolean.TRUE);
            m.put("activeTab", 0);
            m.put("dosearch", Boolean.TRUE);
            m.put("tabs", tabs);
            return m;
        }

        //切换页签获取左侧树
        public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
            String lefttype = (String) params.get("lefttabtype");
            String menuId  = lefttype + perfImportantSignDAO.PERF_STRING_REVIEW;
            //根据权限查询单位
            //elementcode
            String elementcode = "PMKPIAGENCYALLPAY";
            StringBuffer wheresql = new StringBuffer("");
            wheresql.append(" 1 = 1 ");
            String datarule = this.getDataRuleByMenuguidNull(menuId, "t", null);
            logger.debug("重点项目标识：获取左侧树："+lefttype+datarule);
            wheresql.append(datarule);
            if("dept".equals(lefttype)){
                wheresql.append(" and levelno = '1' ");
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> value = dss.getRangesByWhereSql(elementcode, wheresql.toString());
            perfImportantSignDAO.saveAll(value, perfImportantSignDAO.PMKPI_TABLE_TMP_AGENCY);
            return perfImportantSignDAO.getLeftTree();
        }
    public Map<String, Object> revisionsign(HashMap<String, Object> parms) {
        String lefttype = (String)parms.get("lefttabtype");
        Map<String, Object> backMap = new HashMap<String, Object>();
        String code = (String)parms.get("code");
        String tablecode = perfImportantSignDAO.PERF_SIGN_PROGJECT;
        List<Map<String,Object>> datas =  (List<Map<String,Object>>)parms.get("deldatas");
        try {
            if("program".equals(lefttype)){
                //授权
                if("sign".equals(code)){
                    //在标识项目表中增加数据
                    if (datas != null && datas.size() >= 0) {
                        List<Map<String, Object>> proList = new ArrayList<Map<String, Object>>();
                        Map<String, Object> adjustMap = null;
                        for (Map<String, Object> map : datas) {
                            adjustMap = new HashMap<String, Object>();
                            adjustMap.putAll(map);
                            adjustMap.put("create_time", StringUtil.getSysDBDate());
                            adjustMap.put("update_time", StringUtil.getSysDBDate());
                            proList.add(adjustMap);
                        }
                        perfImportantSignDAO.saveAll(proList,tablecode);
                    }
                }else if("cancelsign".equals(code)){//取消标识
                    perfImportantSignDAO.saveAll(datas, perfImportantSignDAO.PMKPI_TABLE_TMP_GUIDS);
                    String wheresql = "";
                    //根据项目信息获取调整主单信息
                    wheresql = " exists(select * from "+ perfImportantSignDAO.PMKPI_TABLE_TMP_GUIDS + " a where t.guid=a.guid)";
                    perfImportantSignDAO.delDatas(tablecode,wheresql);
                }
            }else if("dept".equals(lefttype)){
                tablecode = perfImportantSignDAO.PERF_SIGN_DEPT;
                StringBuffer sql = new StringBuffer();
                perfImportantSignDAO.saveAll(datas, perfImportantSignDAO.PMKPI_TABLE_TMP_GUIDS);
                String wheresql = " exists(select * from "+ perfImportantSignDAO.PMKPI_TABLE_TMP_GUIDS + " a where t.guid=a.guid)";

                //授权
                if("sign".equals(code)){
                    sql.append(" update "+tablecode+" t set t.is_sign = '1' where 1=1 and ");
                }else if("cancelsign".equals(code)){//取消授权
                    sql.append(" update "+tablecode+" t set t.is_sign = '0' where 1=1 and ");
                }
                sql.append(wheresql);
                perfImportantSignDAO.update(sql.toString());
            }

            backMap.put("flg","1");
        }catch (AppException e){
            logger.error("更改标记状态时："+e.getMessage());
            backMap.put("flg","2");
            backMap.put("message",e.getMessage());
        }
        return backMap;
    }

}
