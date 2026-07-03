package gov.mof.fasp2.pmkpi.setting.arrangement;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.cache.service.CacheManager;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.*;

public class ArrangementBO extends PmkpiBO {

    private ArrangementDAO arrangementDAO;

    public void setArrangementDAO(ArrangementDAO arrangementDAO) {
        this.arrangementDAO = arrangementDAO;
    }

    private CacheManager cacheManager;

    private CacheManager getCacheManager() {
        if (cacheManager == null) {
            cacheManager = (CacheManager) ServiceFactory.getBean("buscore.cache.cachemanager");
        }
        return cacheManager;
    }
    /**
     * 查询数据方法
     * @param parms --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String,Object> parms) {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String code = (String) parms.get("code");
        String wheresql = " frametype = '"+code+"'and t.province = '"+SecureUtil.getUserSelectProvince()+"' and "+" t.year = " + CommonUtil.getYear();
        List<Map<String, Object>> data = arrangementDAO.getDatas(ArrangementDAO.PERF_TABLE_T_FRAME, wheresql, " order by ordernum");
        for (Map<String, Object> map : data) {
            map.put("guid", map.get("ele_id"));
            map.put("code", map.get("ele_code"));
            map.put("name", map.get("ele_name"));
            map.put("superid", map.get("parent_id"));
            map.put("levelno", map.get("level_no"));
            map.put("isleaf", map.get("is_leaf"));
        }
        backMap.put("data", data);
        return backMap;
    }


    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        String tablecode = (String) params.get("tablecode");
        String code = (String) params.get("code");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        StringBuffer cods = new StringBuffer();
        arrangementDAO.saveAll(datas, arrangementDAO.PMKPI_TABLE_TMP_GUIDS);
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            map.put("ordernum", i++);
            if (rowtype != null && "add".equals(rowtype)) {
                String newcode = (String) map.get("code");
                cods.append("'").append(newcode).append("',");
            }
            map.put("createtime", StringUtil.getSysDBDate());
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("create_time", StringUtil.getSysDBDate());
            map.put("update_time", StringUtil.getSysDBDate());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("mof_div_code", SecureUtil.getUserSelectProvince());
            map.put("fiscal_year", CommonUtil.getYear());
            map.put("frametype", code);
            map.put("ele_id", map.get("guid"));
            map.put("ele_code", map.get("code"));
            map.put("ele_name", map.get("name"));
            map.put("parent_id", map.get("superid"));
            map.put("level_no", map.get("levelno"));
            map.put("is_leaf", map.get("isleaf"));
            map.put("is_deleted", "2");
            addlist.add(map);
        }
        if (cods.length() > 0) {
            cods.deleteCharAt(cods.length() - 1);
        } else {
            cods.append("''");
        }
        List<Map<String, Object>> list = arrangementDAO.getcodenum(cods.toString());
        if(list.size()>=1){
            throw new PerfAppException("编码重复!!");
        }
        String delsql = " t.frametype='"+code+"' and t.province = '"+SecureUtil.getUserSelectProvince()+"' and "+" t.year = " + CommonUtil.getYear();
        arrangementDAO.delDatas(tablecode, delsql);
        arrangementDAO.saveAll(addlist, tablecode);
        arrangementDAO.setIndexCode();
        List<String> cachenames = new ArrayList();
        cachenames.add("busfw.cache.ui.dataSetMapper");
        getCacheManager().refreshCache(cachenames);
        return this.auditdefine(datas, busguid,"perf", null);
    }

    public Map<String, Object> init(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        String tablecode = arrangementDAO.PERF_TABLE_T_FRAME;
        String code = (String) params.get("code");
        String wheresql = "frametype = '" + code + "' and year='"+CommonUtil.getYear()+"' and province='"+ SecureUtil.getUserSelectProvince() +"'";
        arrangementDAO.delDatas(tablecode, wheresql);
        wheresql = " frametype = '" + code + "' and province = '87' and year = '2016'";

        //全部数据
        List<Map<String, Object>> datas = arrangementDAO.getDatas(tablecode, wheresql, " order by ordernum");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : datas) {
            map.put("update_time", StringUtil.getSysDBDate());
            map.put("create_time", StringUtil.getSysDBDate());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("mof_div_code", SecureUtil.getUserSelectProvince());
            map.put("fiscal_year", CommonUtil.getYear());
            addlist.add(map);
        }
        if (addlist.size() > 0) {
            arrangementDAO.saveAll(addlist, tablecode);
        }
        arrangementDAO.setIndexCode();
        List<String> cachenames = new ArrayList();
        cachenames.add("busfw.cache.ui.dataSetMapper");
        getCacheManager().refreshCache(cachenames);
        return this.auditdefine(datas, busguid,"perf", null);
    }

    /**
     * 获取左侧树数据.
     * @return --
     */
    public Map<String, Object> getTreeData() throws AppException {
        Map leftconfig = new HashMap();
        leftconfig.put("name", "查询");
        leftconfig.put("showRootNode", Boolean.TRUE);
        leftconfig.put("dosearch", Boolean.TRUE);
        leftconfig.put("outformart", "#code-#name");
        leftconfig.put("expandlevel", 2);
        leftconfig.put("datas", arrangementDAO.getLeftTree());
        return leftconfig;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    public void copyIndex(HashMap<String, Object> params) throws AppException {
        String code = (String) params.get("code");
        List<Map<String,Object>> indexs = new ArrayList<>();
        String province = CommonUtil.getProvince();
        //先查询上年数据，没有查询87,2016的数据
        int lastyear = Integer.parseInt(CommonUtil.getYear()) - 1;
        StringBuffer wheresql = new StringBuffer();
        wheresql.append(" t.year='").append(lastyear)
                .append("' and t.frametype='").append(code).append("' and t.province='").
                append(province).append("'");
        indexs = arrangementDAO.getDatas(arrangementDAO.PERF_TABLE_T_FRAME, wheresql.toString(), " order by ordernum");
        if(indexs == null || indexs.size()<= 0){
            wheresql.delete(0, wheresql.length());
            wheresql.append(" t.year=2016 and t.frametype='").append(code).append("' and t.province='87'");
            indexs= arrangementDAO.getDatas(arrangementDAO.PERF_TABLE_T_FRAME, wheresql.toString(), " order by ordernum");
        }
        String sql1 = "select ele_id from  PERF_T_FRAME t where t.year= '"+CommonUtil.getYear()+"' and t.province = '"+SecureUtil.getUserSelectProvince()+"' and t.frametype='"
                +code+"'";
        List<Map<String,Object>> already = arrangementDAO.queryForList(sql1);
        List<String> resultlist = new ArrayList<>();
        for (Map map:already) {
            resultlist.add((String) map.get("ele_id"));
        }
        Iterator<Map<String,Object>> li = indexs.iterator();
        while (li.hasNext()){
            Map<String,Object> map =  li.next();
            map.put("update_time", StringUtil.getSysDBDate());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("mof_div_code", SecureUtil.getUserSelectProvince());
            map.put("fiscal_year", CommonUtil.getYear());
            if(resultlist.contains(map.get("ele_id"))){
                li.remove();
            }
        }
        /*for (Map map :indexs) {
            map.put("update_time", StringUtil.getSysDBDate());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("mof_div_code", SecureUtil.getUserSelectProvince());
            map.put("fiscal_year", CommonUtil.getYear());
            guidstr.append(" '").append(map.get("ele_id")).append("',");
        }*/
        arrangementDAO.setIndexCode();
        //保存数据
        arrangementDAO.saveAll(indexs, arrangementDAO.PERF_TABLE_T_FRAME);
        //体系主表
        List<Map<String,Object>> systemList = new ArrayList<>();
        StringBuffer systemsql = new StringBuffer();
        systemsql.append(" t.year='").append(lastyear)
                .append("' and t.province='").append(province).append("' ");
        systemList = arrangementDAO.getDatas(arrangementDAO.PERFSYSTEM_T_TABLE, systemsql.toString(), " order by ordernum");
        if(systemList == null || systemList.size()<= 0){
            systemsql.delete(0, wheresql.length());
            systemsql.append(" t.year=2016 and t.province='87' ");
            systemList= arrangementDAO.getDatas(arrangementDAO.PERFSYSTEM_T_TABLE, systemsql.toString(), " order by ordernum");
        }
        String syssql1 = "select ele_id from PERF_T_FRAMESYSTEM t where t.year= '"+CommonUtil.getYear()+"' and t.province = '"+SecureUtil.getUserSelectProvince()+"'";
        List<Map<String,Object>> sysalready = arrangementDAO.queryForList(syssql1);
        List<String> sysresultlist = new ArrayList<>();
        for (Map map:sysalready) {
            sysresultlist.add((String) map.get("ele_id"));
        }
        Iterator<Map<String,Object>> sysli = systemList.iterator();
        while (sysli.hasNext()) {
            Map<String, Object> map = sysli.next();
            map.put("update_time", StringUtil.getSysDBDate());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("mof_div_code", SecureUtil.getUserSelectProvince());
            map.put("fiscal_year", CommonUtil.getYear());
            if (sysresultlist.contains(map.get("ele_id"))) {
                sysli.remove();
            }
        }
        /*for (Map map :systemList) {
            map.put("update_time", StringUtil.getSysDBDate());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            map.put("mof_div_code", SecureUtil.getUserSelectProvince());
            map.put("fiscal_year", CommonUtil.getYear());
        }*/
        //保存数据
        arrangementDAO.saveAll(systemList, arrangementDAO.PERFSYSTEM_T_TABLE);
        List<String> cachenames = new ArrayList();
        cachenames.add("busfw.cache.ui.dataSetMapper");
        getCacheManager().refreshCache(cachenames);
    }

    /**
     * .获取最大的CODE
     * @param params --
     * @return --
     */
    public String getMaxcode(HashMap<String,Object> params) throws AppException {
        List<Map<String,Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String frametype = (String) params.get("frametype");
        String levelno = (String) params.get("levelno");
        String superid = (String) params.get("superid");
        String wheresql = "";
        if(levelno != null && !levelno.isEmpty()){
            wheresql += " and levelno ="+levelno;
        }
        if(superid != null && !superid.isEmpty()){
            wheresql += " and superid ='"+superid+"'";
        }
        List<Map<String, Object>> list = new ArrayList<>();
        String returncode = "";
        //根据ASCII处理,编码规则一级指标 1-9 A-Z
        int maxcode = 48;
        if(levelno != null && "1".equals(levelno)){
            list = arrangementDAO.getMaxcode(wheresql);
            list.addAll(datas);
            for (Map<String, Object> map : list ) {
                String code = (String) map.get("code");
                char[] codechar = code.toCharArray();
                int value = Integer.valueOf(codechar[0]);
                if(value > maxcode){
                    maxcode = value;
                }
            }
            if(maxcode == 57){
                maxcode = 65;
            }else{
                maxcode = maxcode + 1;
            }
            returncode = String.valueOf((char) maxcode);
        }
        if(levelno != null && "2".equals(levelno)){
            if(frametype != null &&  !frametype.isEmpty()){
                wheresql += " and frametype ='"+frametype+"'";
            }
            List<Map<String, Object>> framelist = new ArrayList<>();
            for (Map<String, Object> map : datas ) {
                if(superid != null && superid.equals(map.get("superid"))){
                    framelist.add(map);
                }
            }
            list = arrangementDAO.getMaxcode(wheresql);
            list.addAll(framelist);
            for (Map<String, Object> map : list ) {
                String code = (String) map.get("code");
                char[] codechar = code.toCharArray();
                int value = Integer.valueOf(codechar[1]);
                if(value > maxcode){
                    maxcode = value;
                }
            }
            if(maxcode == 57){
                maxcode = 65;
            }else{
                maxcode = maxcode + 1;
            }
            returncode = superid + String.valueOf((char) maxcode);
        }
        return  returncode;
    }
}
