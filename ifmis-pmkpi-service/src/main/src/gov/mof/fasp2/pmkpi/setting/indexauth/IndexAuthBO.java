package gov.mof.fasp2.pmkpi.setting.indexauth;

import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.daosupport.RecordSet;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.dto.DataSetDTO;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busfw.ui.datatable.DatatableMapperUtil;
import gov.mof.fasp2.cloud.framework.security.util.EncryptUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfprogram.prjindex.PrjIndexDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @Description:
 * @Revision History:
 * @Revision 14:53 2022/7/7
 */
public class IndexAuthBO extends PmkpiBO {
    private IndexAuthDAO indexAuthDAO;

    public void setIndexAuthDAO(IndexAuthDAO indexAuthDAO) {
        this.indexAuthDAO = indexAuthDAO;
    }

    /**
     * 保存数据.
     * @param params --
     * @return --
     */
    public void save(HashMap<String, Object> params) throws AppException {
        String tablecode = (String) params.get("tablecode");
        String authtype = (String) params.get("authtype");
        List<Map<String, Object>> dataList = (List<Map<String, Object>>) params.get("datas");
        String loginprovince = SecureUtil.getUserSelectProvince();
        String wheresql = "";
        if (authtype != null && !"".equals(authtype)) {
            wheresql += " selecttype = '" + authtype + "'";
            if("01".equals(authtype)){
                wheresql += " and  authcode like '" + loginprovince.substring(0,2) + "_______'";
            }else if("02".equals(authtype)){
                wheresql += " and  authcode like '" + loginprovince.substring(0,4) + "_____'";
            }
        }
        indexAuthDAO.delDatas(tablecode, wheresql);
        indexAuthDAO.saveAll(dataList, tablecode);
        //分库，需调用接口处理下级区划数据
        Boolean flag = PerfUtil.getIsHbei();
        if(flag){
            List<String> indexurls = new ArrayList<>();
            if (CollectionUtils.isNotEmpty(dataList)) {
                //过滤配置了url并且授权开启的数据接口
                indexurls = dataList.stream().filter(m -> (m.get("indexurl")!=null & !"".equals(m.get("indexurl")) & "1".equals(m.get("status")))).map(d -> (String) d.get("indexurl")).distinct().collect(Collectors.toList());
                for (String url : indexurls) {
                    List<Map<String, Object>> pushList = new ArrayList<>();
                    for(int i=0;i<dataList.size();i++){
                        Map m = dataList.get(i);
                        String indexurl = (String) m.get("indexurl");
                        if(indexurl!=null && indexurl.equals(url)){
                            pushList.add(m);
                        }
                    }
                    //根据每个url调用接口
                    ThreadPoolTaskExecutor taskExecutor = (ThreadPoolTaskExecutor) ServiceFactory.getBean("asyncServiceExecutor");
                    taskExecutor.execute(() -> {
                        HashMap<String, Object> p = new HashMap<>();
                        p.put("url",url);
                        p.put("authtype",authtype);
                        p.put("datalist",pushList);
                        try {
                            saveIndexAuthToNext(p);
                        } catch (AppException e) {
                            logger.error(e);
                            e.printStackTrace();
                        }
                    });
                }
            }
        }
    }

    /**
     * 河北分库模式调用接口重置授权信息
     * @param params
     * @throws AppException
     */
    public void saveIndexAuthToNext(HashMap<String, Object> params) throws AppException {
        String url = (String) params.get("url");
        String authtype = (String) params.get("authtype");
        url +="/pmkpi/indexauth/saveIndexAuth?authtype="+authtype;
        List<Map<String,Object>> datalist = (List<Map<String, Object>>) params.get("datalist");
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        MediaType type = MediaType.parseMediaType("application/json; charset=UTF-8");
        headers.setContentType(type);
        headers.add("Accept", MediaType.APPLICATION_JSON.toString());
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("authtype",authtype);
        jsonObject.put("datalist",datalist);
        HttpEntity<String> formEntity = new HttpEntity<String>(jsonObject.toString(), headers);
        logger.info("==============调用授权同步接口开始"+formEntity.toString()+"===========");
        String json = restTemplate.postForObject(url,formEntity, String.class);
        logger.info("==============调用授权同步接口返回"+json+"===========");
        Map<String, Object> jsonMap = PerfUtil.parseObj2Map(JSONObject.parse(json));
        logger.info("==============调用授权同步接口返回解析：：："+jsonMap.toString()+"===========");
        Boolean returnkey = (Boolean) jsonMap.get("returnkey");
        if (!returnkey){
            String message = (String) jsonMap.get("returnval");
            throw new AppException(message);
        }
    }

    /**
     * 河北分库模式根据授权类型重置授权信息
     * @param authtype
     * @param datalist
     * @throws AppException
     */
    public void saveIndexAuth(String authtype,List<Map<String,Object>> datalist) throws AppException {
        String wheresql = " selecttype = '" + authtype + "'";
        indexAuthDAO.delDatas("PERF_T_INDEXAUTH", wheresql);
        indexAuthDAO.saveAll(datalist, "PERF_T_INDEXAUTH");
    }

    /**
     * 查询
     * @param params
     * @return
     */
    public List<Map<String, Object>> getData(HashMap<String, Object> params) throws AppException {
        List<Map<String, Object>> returnList = null;
        String tablecode = (String) params.get("tablecode");
        String authtype = (String) params.get("authtype");
        String tmptype = "00";
        String loginprovince = SecureUtil.getUserSelectProvince();
        String wheresql = "";
        if (authtype != null && !"".equals(authtype)) {
            if("01".equals(authtype)){
                wheresql += " authcode like '" + loginprovince.substring(0,2) + "_______' and authcode !='"+loginprovince+"'";
            }else if("02".equals(authtype)){
                wheresql += " authcode like '" + loginprovince.substring(0,4) + "_____' and authcode !='"+loginprovince+"'";
            }
        }
        //查询业务数据
        returnList = indexAuthDAO.getDatas(tablecode, wheresql+ " and selecttype = '" + authtype + "'", "order by ordernum");
        if(returnList.size()<1){
            //查询模板带入各区划默认数据
            returnList = indexAuthDAO.getDatas("v_perf_indexauthtmp", wheresql+ "  and selecttype = '" + tmptype + "'", "order by authcode");
            if (authtype != null && !"".equals(authtype)) {
                for(int i=0;i<returnList.size();i++){
                    Map m = returnList.get(i);
                    m.put("guid",this.getCreateguid());
                    m.put("ordernum",i+1);
                    m.put("selecttype",authtype);
                    m.put("remark","01".equals(authtype) ? "省级指标" : "市级指标");
                }
            }
            indexAuthDAO.saveAll(returnList, tablecode);
        }
        return returnList;
    }

    /**
     * 更改授权状态
     * @param params
     * @throws AppException
     */
    public void isopenandsown(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //是否启用
        String status = (String) params.get("status");
        if (datas.size() > 0) {
            for (Map<String, Object> map : datas) {
                map.put("status", status);
            }
            indexAuthDAO.updateAllByPK(datas, "guid", tablecode);
        }
    }

    public Map<String, Object> getHBAuthData(HashMap params) throws AppException {
        Map<String,Object> returnmap = null;
        String selectedAuth = (String) params.get("selectedAuth");
        String authmethod = (String) params.get("authmethod");
        String province = CommonUtil.getProvince();
        String year = SecureUtil.getYear();
        String tprovince = province.substring(0,2)+"0000000";//省级区划
        String sprovince = province.substring(0,4)+"00000";//市级区划
        String wheresql = "";
        if(selectedAuth!=null && "01".equals(selectedAuth)){//省级
            wheresql =" code = '"+tprovince+"'";
        }else if(selectedAuth!=null && "02".equals(selectedAuth)){//市级
            wheresql =" code = '"+sprovince+"'";
        }
        List<Map<String, Object>> returnList = indexAuthDAO.getDatas("PERF_T_INDEXAUTHURL", wheresql, "order by code");
        if(returnList!=null && returnList.size()>0){ // 获取省或市级的服务器ip端口
            String url  = (String) (returnList.get(0).get("url"));
            url +="/pmkpi/indexauth/"+authmethod;
            RestTemplate restTemplate = new RestTemplate();
            HttpHeaders headers = new HttpHeaders();
            MediaType type = MediaType.parseMediaType("application/json; charset=UTF-8");
            headers.setContentType(type);
            headers.add("Accept", MediaType.APPLICATION_JSON.toString());
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("authtype",selectedAuth);
            jsonObject.put("authcode",province);
            jsonObject.put("year",year);
            jsonObject.put("queryparams",params);
            HttpEntity<String> formEntity = new HttpEntity<String>(jsonObject.toString(), headers);
            logger.info("==============调用共享指标库获取数据口开始"+formEntity.toString()+"===========");
            String json = restTemplate.postForObject(url,formEntity, String.class);
            logger.info("==============调用共享指标库获取数据接口返回"+json+"===========");
            Map<String, Object> jsonMap = PerfUtil.parseObj2Map(JSONObject.parse(json));
            Boolean returnkey = (Boolean) jsonMap.get("returnkey");
            if (returnkey){
                returnmap = (Map<String,Object>) jsonMap.get("returnval");
            }else{
                String message = (String) jsonMap.get("returnval");
                throw new AppException(message);
            }
        }
        return returnmap;
    }


    /**
     * 查询推荐指标共享指标库指标左侧树（调用接口）
     * @param params
     * @throws
     */
    public Map<String, Object> getHBAuthIndexTree(HashMap params) throws AppException {
        params.put("authmethod","getAuthLefttree");
        Map<String, Object> m = getHBAuthData(params);
        try {
            m.put("datalist",JsonUtils.ListToRecordSet((List) m.get("datalist")));
        } catch (IOException e) {
            m = new HashMap<>();
            logger.error(e.getMessage(), e);
        }
        return m;
    }

    /**
     * 查询推荐指标共享指标库指标（调用接口）
     * @param params
     * @throws
     */
    public Map<String, Object> getHBAuthIndex(HashMap params) throws AppException {
        String key = (String) params.get("key");
        params.put("authmethod","getAuthIndexByPage");
        Map<String, Object> m = getHBAuthData(params);
        List datalist = (List) m.get("datalist");
        RecordSet rs = new RecordSet();
        if (datalist != null && datalist.size() > 0) {
            rs.addAll(datalist);
        }
        Map<String, Object> mapperdata = DatatableMapperUtil.getMapperDataByKey(datalist, key);
        mapperdata.put("datalist",rs);
        m.put("mapperdata", mapperdata);
        m.put("datalist",rs);
        return m;
    }

    /**
     * 获取授权指标库左侧树类型
     * @param paramMap
     * @return
     */
    public Map<String, Object> getAuthLefttree(Map<String, Object> paramMap) throws AppException {
        String authtype = (String) paramMap.get("authtype");
        String authcode = (String) paramMap.get("authcode");
        String year = (String) paramMap.get("year");
        String tprovince = authcode.substring(0,2)+"0000000";//省级区划
        String sprovince = authcode.substring(0,4)+"00000";//市级区划
        String targetprovince = authcode;
        if("01".equals(authtype)){
            targetprovince = tprovince;
        }else if("02".equals(authtype)){
            targetprovince = sprovince;
        }
        String authTreeString = null;
        List<Map<String, Object>> returnList = indexAuthDAO.getDatas("PERF_T_INDEXAUTH", " authcode = '" + authcode + "' and selecttype = '" + authtype + "' and status = 1 ", "order by ordernum");
        if(returnList!=null && returnList.size()>0){
            authTreeString = (String) (returnList.get(0).get("lefttree"));
        }
        String tablecode = "v_perf_t_indexauth";
        Map<String, Object>  queryparams = (Map<String, Object> ) paramMap.get("queryparams");
        String tabfilter = (String) queryparams.get("tabfilter");//页签配置的过滤
        String condition = (String) queryparams.get("condition");//过滤条件
        List listdept = new ArrayList();
        PrjIndexDAO prjIndexDAO = (PrjIndexDAO) PerfServiceFactory.getBean("pmkpi.prjindex.PrjIndexDAO");
        if(authTreeString!=null){
            //拼接授权的左侧树条件
            condition = " and (t.code in ("+authTreeString+") and levelno =1) or exists (select a.code from "+tablecode+" a where a.guid = t.guid " +
                    "start with superguid in (select guid from "+tablecode+" where code in ("+authTreeString+") and levelno =1 )connect by prior guid = superguid)";
            condition += " and PERF_AUTHPROVINCE_VIEW.set_province('"+ targetprovince +"') = '"+ targetprovince +"' and PERF_AUTHPROVINCE_VIEW.set_year('"+ year +"') = '"+ year +"'";
            if(authTreeString.contains("03")){
                //授权包含03部门
                listdept = prjIndexDAO.finAuthDeptTreeData(targetprovince,year);
            }
        }
        if (!StringUtil.isEmpty(tabfilter)) {
            condition += tabfilter;
        }
        List<Map<String, Object>> list = prjIndexDAO.finTreeData(tablecode, condition);
        list.addAll(listdept);
        HashMap map = new HashMap();
        map.put("datalist", list);
        return map;
    }

    public String getAuthIndexQueryString(Map<String, Object> paramMap) throws AppException {
        String authtype = (String) paramMap.get("authtype");
        String authcode = (String) paramMap.get("authcode");
        String year = (String) paramMap.get("year");
//        String selectnode = (String) paramMap.get("selectnode");
        //查询语句
        Map<String, Object>  queryparams = (Map<String, Object> ) paramMap.get("queryparams");
        String key = (String) queryparams.get("key");
        Map pageobj = (Map) queryparams.get("pageobj");
        Map queryMap = (Map) pageobj.get("queryMap");
        String whereSql = "";
        if(queryMap!=null){
            whereSql = (String) queryMap.get("whereSql");
        }
        StringBuffer qsql = new StringBuffer();
        qsql.append(" select * from BAS_PERF_INDICATOR p where is_deleted = 2 ");
        String tprovince = authcode.substring(0,2)+"0000000";//省级区划
        String sprovince = authcode.substring(0,4)+"00000";//市级区划
        String targetprovince = authcode;
        if("01".equals(authtype)){
            qsql.append(" and province = '"+tprovince+"'");
            targetprovince = tprovince;
        }else if("02".equals(authtype)){
            qsql.append(" and province = '"+sprovince+"'");
            targetprovince = sprovince;
        }
        if(queryparams!=null){//处理查询参数
            String guid = (String) queryparams.get("guid"); //推荐指标中,左侧树选中节点
            String iscommon = (String) queryparams.get("iscommon");
            String mogamisuperid = (String) queryparams.get("mogamisuperid");
            String filer = (String) queryparams.get("filter");
            int isleaf = PerfUtil.mapGetInt(queryparams, "isleaf");//是否末级节点
            if (StringUtils.isNotBlank(iscommon) && "1".equals(iscommon)) {
                qsql.append(" and p.is_common_ind = '1'");
                if (StringUtils.isNotBlank(guid) && !"idexcomcls".equals(guid)) {
                    qsql.append(" and p.projtype= '").append(guid).append("'");
                }
            } else { //个性或者部门.
                if (guid.startsWith("indexdept")) {
                    guid = guid.substring(9);
                }
                IDataSetService dss = PerfServiceFactory.getIDataSetService();
                qsql.append(" and nvl(p.is_common_ind,'0') <> '1'");
                if (isleaf == 1) {
                    qsql.append(" and p.industrycategory= '").append(guid).append("'");
                }else if (!"indexcomfunc".equals(guid) && !"indexdept".equals(guid)){
                    DataSetDTO ds = dss.getDataSetByElementCode("INDEXCOMFUNCAUTH");
                    String dissql = (String) ds.get("datasource");
                    String dsquerysql = "select * from ( "+dissql+" ) where PERF_AUTHPROVINCE_VIEW.set_province('"+ targetprovince +"') = '"+ targetprovince +"' and PERF_AUTHPROVINCE_VIEW.set_year('"+ year +"') = '"+ year +"' ";
                    List<Map<String, Object>> list = indexAuthDAO.getElementDatas(guid, dsquerysql);
                    indexAuthDAO.saveAll(list, "PERF_TMP_GUIDS");
                    qsql.append(" and  exists ( select 1 from PERF_TMP_GUIDS a where a.guid =p.industrycategory) ");
                }
                if (mogamisuperid != null && mogamisuperid.equals("indexdept")) {// 部门指标
                    qsql.append(" and exists(select 1 from pmkpi_fasp_t_pubagency m  where ");
                    qsql.append(" m.guid=p.agency_code) ");
                    qsql.append(" and p.wfstatus = '011' ");
                } else {
                    qsql.append(" and p.agencyguid is null");
                }
            }
            if (!StringUtil.isEmpty(filer)) {
                qsql.append("  and (").append(filer).append(") ");
            }
            if (!StringUtil.isEmpty(whereSql)) {
                qsql.append("  and (").append(whereSql).append(") ");
            }
        }
        return qsql.toString();
    }

    /**
     * 查询分页条件
     * @param paramMap
     * @return
     * @throws AppException
     */
    public Map queryPageData(Map<String, Object> paramMap,Map<String, Object> m) throws AppException {
        Map<String, Object>  queryparams = (Map<String, Object> ) paramMap.get("queryparams");
        String key = (String) queryparams.get("key");
        boolean isGotoPage = "true".equals(queryparams.get("gotopage"));
        Map pageobj = (Map) queryparams.get("pageobj");
        if (queryparams == null || queryparams.isEmpty()) {
            m.put("pageobj", pageobj);
            return m;
        }
        // 分页时用原有SQL
        String oldsql = (String) pageobj.get("querysql");
        String sql = null;
        if (oldsql != null) {
            try {
                oldsql = oldsql.replaceAll("<br>","");
                sql = EncryptUtil.decrypt(oldsql);
            } catch (Exception e) {
                sql = null;
            }
        }
        if (!isGotoPage ||sql == null) {
            long st = System.currentTimeMillis();
            //增加参数，给业务系统判定当前查询是 queryPageData 不是 queryData
            queryparams.put("bus_pageCountQuery", true);
            sql = getAuthIndexQueryString(paramMap);
            long usetime = (System.currentTimeMillis() - st);
            if (usetime > 500) {
                logger.warn("列表分页状态查询——组装SQL语句时间：" + usetime + "ms");
            }
            try {
                if (queryparams.get("wheresql") != null) {
                    String whereSql = (String) queryparams.remove("wheresql");
                    sql = "select * from (" + sql + ") dt WHERE " + whereSql;
                    pageobj.put("wheresql", EncryptUtil.encrypt(whereSql));
                }
                pageobj.put("querysql", EncryptUtil.encrypt(sql));
            } catch (Exception e) {
                logger.debug("sql转base64错误。");
            }
            if (oldsql != null && !oldsql.equals(pageobj.get("querysql"))) { // 有新的条件或页签。
                pageobj.put("totalrows", "0");
                pageobj.put("currpage", "1");
            }
        }
        int rows = 0;
        try {
            rows = Integer.parseInt(pageobj.get("rows").toString());
        } catch (Exception e) {
            rows = 0;
        }
        int totalrows = 0;
        try {
            totalrows = Integer.parseInt(String.valueOf(pageobj.get("totalrows")));
            // 兼容业务主动指定总条数处理
            if(!StringUtil.isNullOrEmpty((String) queryparams.get("totalrows"))){
                totalrows = Integer.parseInt((String) queryparams.get("totalrows"));
                pageobj.put("totalrows", totalrows);
            }
        } catch (Exception e) {
            totalrows = 0;
        }
        if (totalrows == 0) {
            StringBuffer sb = new StringBuffer();
            String sumcols = (String) pageobj.get("sumcols");
            sb.append("SELECT count(1) as count");
            if (sumcols != null && sumcols.trim().length() > 0) {
                StringTokenizer st = new StringTokenizer(sumcols, ",");
                while (st.hasMoreElements()) {
                    String col = st.nextToken();
                    sb.append(", nvl(SUM(" + col + "),0) as " + col);
                }
            }
            sb.append(" FROM (" + sql + ") tpage");
            long startTime = System.currentTimeMillis();
            List l = indexAuthDAO.queryForList(sb.toString());
            long usetime = (System.currentTimeMillis() - startTime);
            if (usetime > 500) {
                logger.warn("列表分页状态查询——执行语句时间：" + usetime + "ms, 执行语句：" + sb.toString());
            }
            if (l != null && l.size() != 0) {
                Map row = (Map) l.get(0);
                totalrows = Integer.parseInt(row.get("count").toString());
                pageobj.put("totalrows", totalrows);
                if (rows > 0 && pageobj.get("currpage") != null) {
                    int currpage = 1;
                    try {
                        currpage = Integer.parseInt(pageobj.get("currpage") + "");
                    } catch (Exception ex) {currpage = 1;}
                    if (currpage > 1) {
                        if (totalrows <= ((currpage - 1) * rows)) {
                            pageobj.put("currpage", "1");
                        }
                    }
                }
                if (sumcols != null && sumcols.trim().length() > 0) {
                    Map sumobj = new HashMap();
                    StringTokenizer st = new StringTokenizer(sumcols, ",");
                    while (st.hasMoreElements()) {
                        String col = st.nextToken();
                        sumobj.put(col, row.get(col));
                    }
                    sumobj.put("_count", totalrows);
                    m.put("sumobj", sumobj);
                }
            }
        }
        m.put("pageobj", pageobj);
        return m;
    }

    /**
     * 获取授权指标库指标
     * @param paramMap
     * @return
     */
    public Map<String, Object> getAuthIndexByPage(Map<String, Object> paramMap) throws AppException {
        Map<String, Object> m = new HashMap<String, Object>();
        Map<String, Object>  queryparams = (Map<String, Object> ) paramMap.get("queryparams");
        String key = (String) queryparams.get("key");
        //分页
        queryPageData(paramMap,m);
        Map pageobj = (Map) m.get("pageobj");

        String sql = getAuthIndexQueryString(paramMap);
        logger.info("指标推荐查询列表sql："+sql);

        List<Map<String, Object>> datalist = new ArrayList();
        List l = indexAuthDAO.queryForList("select count(1) as count from (" + sql + ")");
        int totalrows = 0;
        if (l != null && l.size() != 0) {
            totalrows = Integer.parseInt(((Map) l.get(0)).get("count").toString());
        }
        pageobj.put("totalrows", totalrows);
        String whereSql = "1=1";

        // 获取分页数据
        if (null != pageobj.get("rows") && Integer.parseInt(pageobj.get("rows").toString()) > 0) {
            StringBuffer sb = new StringBuffer();
            sb.append("SELECT * FROM (SELECT dt.*,ROWNUM RN FROM( ");
            sb.append(sql);
            sb.append(" ) dt WHERE ROWNUM <= ");
            sb.append(Integer.parseInt(pageobj.get("rows").toString()) * Integer.parseInt(pageobj.get("currpage").toString()));
            if(whereSql == null){
                sb.append( " ) WHERE RN >=  ");
            }else{
                sb.append(" and " + whereSql + " ) WHERE RN >=  ");
            }
            sb.append(Integer.parseInt(pageobj.get("rows").toString()) * (Integer.parseInt(pageobj.get("currpage").toString()) - 1) + 1);
            datalist = indexAuthDAO.queryForList(sb.toString());
        } else {
            String querysql = null;
            if(whereSql == null){
                querysql = "select * from (" + sql + ") ";
            }else{
                querysql = "select * from (" + sql + ") where " + whereSql;
            }
            datalist = indexAuthDAO.queryForList(querysql);
        }
        m.put("datalist", datalist);
        m.put("pageobj", pageobj);
        return m;
    }


    /**
     * 获取当前区划年度的项目的指标体系.
     * @return list -- 项目的指标体系
     */
    public List<Map<String, Object>> getFrame(String province,String year) throws AppException {
        indexAuthDAO.setYearAndProvince(year,province);
        String sql = "select " +
                "t.guid as ind_id," +
                "t.code as perf_ind_code," +
                "t.name as perf_ind_name," +
                "1 as is_common_ind," +
                "t.name as value_desc," +
                "null as agency_code," +
                "t.province as mof_div_code," +
                "t.year  as fiscal_year," +
                "t.year||'0101' as start_date," +
                "t.year||'1231' as end_date," +
                "decode(t.superid,'0',null,'#',null,t.superid) as parent_id," +
                "t.levelno as level_no," +
                "0 as is_leaf," +
                "t.is_enabled as is_enabled," +
                "t.update_time as update_time," +
                "t.is_deleted as is_deleted," +
                "t.create_time as create_time," +
                "t.guid as biz_key" +
                " from v_perf_t_frame t where t.frametype = 'PM001' order by t.ordernum";
        return indexAuthDAO.queryForList(sql);
    }

    /**
     * 获取当前区划项目的财政指标.
     * @return list -- 项目的财政指标
     */
    public List<Map<String, Object>> getFincalIndicator(String province, String year) throws AppException {
        indexAuthDAO.setYearAndProvince(year,province);
        String sql = "select " +
                "ind_id," +
                "perf_ind_code," +
                "perf_ind_name," +
                "is_common_ind," +
                "value_desc," +
                "agency_code," +
                "mof_div_code," +
                "fiscal_year," +
                "t.year||'0101' as start_date," +
                "'20991231' as end_date," +
                "decode(t.parent_id,'0',null,'#',null,t.parent_id) as parent_id," +
                "level_no," +
                "1 as is_leaf," +
                "t.is_enabled as is_enabled," +
                "t.update_time as update_time," +
                "t.is_deleted as is_deleted," +
                "t.create_time as create_time," +
                "t.guid as biz_key" +
                " from v_bas_perf_indicator t where t.framesystem='PM001' and t.agencyguid is null order by t.perf_ind_code";
        return indexAuthDAO.queryForList(sql);
    }

    /**
     * 获取当前区划专项债券绩效的财政指标.
     * @return list -- 项目的财政指标
     */
    public List<Map<String, Object>> getFincalGDIndicator(String province, String year) throws AppException {
        indexAuthDAO.setYearAndProvince(year,province);
        String sql = "select " +
                "indicator_id," +
                "perf_ind_code," +
                "perf_ind_name," +
                "is_common_ind," +
                "value_desc," +
                "agency_code," +
                "mof_div_code," +
                "fiscal_year," +
                "t.year||'0101' as start_date," +
                "'20991231' as end_date," +
                "decode(t.parent_id,'0',null,'#',null,t.parent_id) as parent_id," +
                "level_no," +
                "1 as is_last_inst" +
                "1 as is_leaf," +
                "t.is_enabled as is_enabled," +
                "t.update_time as update_time," +
                "t.is_deleted as is_deleted," +
                "t.create_time as create_time," +
                "t.guid as biz_key," +
                "t.ind_type_code,"+
                "t.ind_type_name,"+
                "t.full_value,"+
                "t.unit"+
                " from V_GD_PERF_INDICATOR t where  t.agencyguid is null order by t.perf_ind_code";
        return indexAuthDAO.queryForList(sql);
    }

    /**
     * 获取当前区划项目的部门指标.
     * @param agencyCode -- 单位编码.
     * @return list -- 项目的财政指标.
     */
    public List<Map<String, Object>> getDepIndicator(String province, String year,String agencyCode) throws AppException {
        indexAuthDAO.setYearAndProvince(year,province);
        String sql = "select " +
                "ind_id," +
                "perf_ind_code," +
                "perf_ind_name," +
                "is_common_ind," +
                "value_desc," +
                "agency_code," +
                "mof_div_code," +
                "fiscal_year," +
                "t.year||'0101' as start_date," +
                "'20991231' as end_date," +
                "decode(t.parent_id,'0',null,'#',null,t.parent_id) as parent_id," +
                "level_no," +
                "1 as is_leaf," +
                "t.is_enabled as is_enabled," +
                "t.update_time as update_time," +
                "t.is_deleted as is_deleted," +
                "t.create_time as create_time," +
                "t.guid as biz_key" +
                " from v_bas_perf_indicator t where t.framesystem='PM001' and t.agencyguid like '" + agencyCode + "%' and t.wfstatus = '011' order by t.perf_ind_code";
        return indexAuthDAO.queryForList(sql);
    }

    /**
     * 获取当前区划项目的部门专项债券绩效指标.
     * @param agencyCode -- 单位编码.
     * @return list -- 项目的财政指标.
     */
    public List<Map<String, Object>> getDepGDIndicator(String province, String year,String agencyCode) throws AppException {
        indexAuthDAO.setYearAndProvince(year,province);
        String sql = "select " +
                "indicator_id," +
                "perf_ind_code," +
                "perf_ind_name," +
                "is_common_ind," +
                "value_desc," +
                "agency_code," +
                "mof_div_code," +
                "fiscal_year," +
                "t.year||'0101' as start_date," +
                "'20991231' as end_date," +
                "decode(t.parent_id,'0',null,'#',null,t.parent_id) as parent_id," +
                "level_no," +
                "1 as is_last_inst" +
                "1 as is_leaf," +
                "t.is_enabled as is_enabled," +
                "t.update_time as update_time," +
                "t.is_deleted as is_deleted," +
                "t.create_time as create_time," +
                "t.guid as biz_key," +
                "t.ind_type_code,"+
                "t.ind_type_name,"+
                "t.full_value,"+
                "t.unit"+
                " from V_GD_PERF_INDICATOR t where t.agencyguid like '" + agencyCode + "%' and t.wfstatus = '011' order by t.perf_ind_code";
        return indexAuthDAO.queryForList(sql);
    }


    /**
     * 湖北模式债务项目保存绩效信息
     * @param param
     * @throws AppException
     */
    public Map savegoalindex(Map<String,Object> param) throws AppException {
        Map<String, Object> backMap = new HashMap();
        String province = (String) param.get("province");
        String year = (String) param.get("year");
        String isagency = param.get("isagency") + "";
        String appid = (String) param.get("appid");
        logger.info("isagency:" + isagency + "----------appid:" + appid);
        List<Map<String,Object>> goallist = (List<Map<String, Object>>) param.get("pm_perf_goal_info");
        List<Map<String,Object>> indexlist = (List<Map<String, Object>>) param.get("pm_perf_indicator");
        List<Map<String,Object>> assessmentlist = (List<Map<String, Object>>) param.get("perf_t_assessment");
        List<Map<String,Object>> beforeviewlist = (List<Map<String, Object>>) param.get("perf_t_beforeview");
        Map goalguidmap = new HashMap();
        String goaltablecode = "pm_perf_goal_info";
        String indextablecode = "pm_perf_indicator";
        String assessmentTablecode = "perf_t_assessment";
        String beforeviewTablecode = "perf_t_beforeview";
        List<String> delgoalproguids = new ArrayList<>();
        List<String> delindproguids = new ArrayList<>();
        List<String> delassproguids = new ArrayList<>();
        List<String> delbeforeproguids = new ArrayList<>();
        String versionname = "债务";
        String yearflag = PerfConstant.PMKPI_ONE;
        String perf_obj_type_code = PerfConstant.PMKPI_ONE;
        String perf_obj_type_name = PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME;
        if ("bdm".equals(appid)) {
            yearflag = "0";
            perf_obj_type_code = PerfConstant.PMKPI_TOW;
            perf_obj_type_name = PerfConstant.PMKPI_PERF_OBJ_TYPE_NAME_YEAR;
        }
        if ("1".equals(isagency)) {
            versionname = "单位";
        }
        boolean isproguidnull = false;
        //处理目标数据
        if (goallist != null && goallist.size() > 0) {
            logger.info("--------savegoalindex 接收项目绩效接口 goallist.size :"+goallist.size()+"-------------");
            if ("1".equals(isagency)) {
                goallist = PerfUtil.lowMapKey(goallist);
            }
            //同一批次时间一致
            String time = PerfUtil.getServerTimeStamp();
            for (Map map : goallist) {
                String guid = (String) map.get("kpi_per_id");
                String proguid = (String) (StringUtil.isEmpty((String) map.get("proguid")) ? map.get("mainguid") : map.get("proguid"));
                if(guid == null || guid.length() == 0 || "".equals(guid)){
                    guid = StringUtil.createUUID();
                }
                if(StringUtil.isEmpty(proguid)){
                    isproguidnull = true;
                }
                map.put("guid", guid);
                map.put("kpi_per_id", guid);
                map.put("agencyguid",map.get("agency_code"));
                map.put("mainguid",proguid);
                map.put("createtime",time);
                map.put("updatetime",time);
                map.put("create_time",time);
                map.put("update_time",time);
                map.put("creater",SecureUtil.getCurrentUserID());
                map.put("province",province);
                map.put("year",year);
                map.put("mof_div_code",province); //财政区划代码
                map.put("mof_div_name", CommonUtil.getProvinceNameByCode(province)); //财政区划名称
                map.put("version", "rcdtwh");
                map.put("version_name","日常动态维护版本_" + versionname);
                map.put("is_deleted", StringUtil.isNullOrEmpty(map.get("is_deleted")+"") ? 2 : map.get("is_deleted"));  //是否删除
                if (!"1".equals(isagency)) {
                    map.put("is_last_inst","1"); //是否终审
                }
                map.put("versiontype","0"); //0 日常动态 1 编制 2 批复，3执行
                map.put("is_backup","2");  //1 版本记录 2 日常动态
                map.put("yearflag", yearflag);
                map.put("perf_obj_type_code", perf_obj_type_code);
                map.put("perf_obj_type_name", perf_obj_type_name);
                goalguidmap.put(proguid + perf_obj_type_code + province, guid);
                //封装proguid
                delgoalproguids.add(proguid);
            }
            backMap.putAll(this.checkColLength(goallist, PerfConstant.PMKPI_VPM_GOAL_INFO));
            backMap.putAll(indexAuthDAO.checkTacleColsIsNull(goaltablecode, goallist));
        }
        //处理指标数据
        if (indexlist != null && indexlist.size() > 0) {
            logger.info("--------savegoalindex 接收项目绩效接口 indexlist.size :"+indexlist.size()+"-------------");
            if ("1".equals(isagency)) {
                indexlist = PerfUtil.lowMapKey(indexlist);
            }
            String goalguid= "";
            String time = PerfUtil.getServerTimeStamp();
            Set<String> keys = goalguidmap.keySet();
            for (Map map : indexlist) {
                String guid = (String) map.get("kpi_id");
                String proguid = (String) (StringUtil.isEmpty((String) map.get("proguid")) ? map.get("mainguid") : map.get("proguid"));
                if(guid == null || guid.length() == 0 || "".equals(guid)){
                    guid = StringUtil.createUUID();
                }
                if(StringUtil.isEmpty(proguid)){
                    isproguidnull = true;
                }
                map.put("guid", guid);
                map.put("kpi_id", guid);
                map.put("findex",map.get("lv1_perf_ind_code"));
                map.put("sindex",map.get("lv2_perf_ind_code"));
                map.put("code",map.get("lv3_perf_ind_code"));
                map.put("superid",map.get("lv2_perf_ind_code"));
                map.put("levelno","3");
                map.put("name",map.get("lv3_perf_ind_name"));
                map.put("indexval",map.get("kpi_val"));
                map.put("agencyguid",map.get("agency_code"));
                map.put("mainguid",proguid);
                map.put("createtime",time);
                map.put("updatetime",time);
                map.put("create_time",time);
                map.put("update_time",time);
                map.put("creater",SecureUtil.getCurrentUserID());
                map.put("province",province);
                map.put("year",year);
                map.put("mof_div_code",province);
                map.put("mof_div_name", CommonUtil.getProvinceNameByCode(province)); //财政区划名称
                map.put("version", "rcdtwh");
                map.put("version_name","日常动态维护版本_" + versionname);
                map.put("is_deleted", StringUtil.isNullOrEmpty(map.get("is_deleted")+"") ? 2 : map.get("is_deleted"));  //是否删除
                if (!"1".equals(isagency)) {
                    map.put("is_last_inst","1"); //是否终审
                }
                map.put("versiontype","0"); //0 日常动态 1 编制 2 批复，3执行
                map.put("is_backup","2");  //1 版本记录 2 日常动态
                map.put("yearflag", yearflag);
                map.put("perf_obj_type_code", perf_obj_type_code);
                map.put("perf_obj_type_name", perf_obj_type_name);
                //根据项目id、类型代码(1总体 2年度)、区划对比目标和指标数据，获取目标表和指标表的对应关系，指标表goalguid = 目标表的guid
                String indexkey = proguid + perf_obj_type_code + province;
                for (String key : keys) {
                    if (key.equals(indexkey)){
                        goalguid = (String) map.get(key);
                        break;
                    }
                }
                map.put("goalguid",goalguid);  //目标guid
                delindproguids.add(proguid);
            }
            backMap.putAll(this.checkColLength(indexlist, PerfConstant.PMKPI_VPM_INDICATOR));
            backMap.putAll(indexAuthDAO.checkTacleColsIsNull(indextablecode, indexlist));
        }
        if (assessmentlist != null && assessmentlist.size() > 0) {
            logger.info("--------savegoalindex 接收项目绩效接口 assessmentlist.size :"+assessmentlist.size()+"-------------");
            if ("1".equals(isagency)) {
                assessmentlist = PerfUtil.lowMapKey(assessmentlist);
            }
            String time = PerfUtil.getServerTimeStamp();
            for (Map map : assessmentlist) {
                String guid = (String) map.get("guid");
                String proguid = (String) (StringUtil.isEmpty((String) map.get("proguid")) ? map.get("mainguid") : map.get("proguid"));
                if(StringUtil.isNullOrEmpty(guid)){
                    guid = StringUtil.createUUID();
                }
                if(StringUtil.isEmpty(proguid)){
                    isproguidnull = true;
                }
                map.put("guid", guid);
                map.put("mainguid", proguid);
                map.put("createtime", time);
                map.put("updatetime", time);
                map.put("creater", SecureUtil.getCurrentUserID());
                map.put("province", province);
                map.put("year", year);
                map.put("is_deleted", StringUtil.isNullOrEmpty(map.get("is_deleted")+"") ? 2 : map.get("is_deleted"));  //是否删除
                map.put("is_last_inst", 1); //是否终审
                delassproguids.add(proguid);
            }
            backMap.putAll(this.checkColLength(assessmentlist, assessmentTablecode));
            backMap.putAll(indexAuthDAO.checkTacleColsIsNull(assessmentTablecode, assessmentlist));
        }
        if (beforeviewlist != null && beforeviewlist.size() > 0) {
            logger.info("--------savegoalindex 接收项目绩效接口 beforeviewlist.size :"+beforeviewlist.size()+"-------------");
            if ("1".equals(isagency)) {
                beforeviewlist = PerfUtil.lowMapKey(beforeviewlist);
            }
            String time = PerfUtil.getServerTimeStamp();
            for (Map map : beforeviewlist) {
                String guid = (String) map.get("guid");
                String proguid = (String) (StringUtil.isEmpty((String) map.get("proguid")) ? map.get("mainguid") : map.get("proguid"));
                if(StringUtil.isNullOrEmpty(guid)){
                    guid = StringUtil.createUUID();
                }
                if(StringUtil.isEmpty(proguid)){
                    isproguidnull = true;
                }
                map.put("guid", guid);
                map.put("mainguid", proguid);
                map.put("createtime", time);
                map.put("updatetime", time);
                map.put("creater", SecureUtil.getCurrentUserID());
                map.put("province", province);
                map.put("year", year);
                map.put("is_deleted", StringUtil.isNullOrEmpty(map.get("is_deleted")+"") ? 2 : map.get("is_deleted"));  //是否删除
                map.put("is_last_inst", 1); //是否终审
                delbeforeproguids.add(proguid);
            }
            backMap.putAll(this.checkColLength(beforeviewlist, beforeviewTablecode));
            backMap.putAll(indexAuthDAO.checkTacleColsIsNull(beforeviewTablecode, beforeviewlist));
        }
        if (!backMap.isEmpty()) {
            List<Map<String, Object>> redata = (List) backMap.get("redata");
            for (Map map : redata) {
                String remark = (String) map.get("remark");
                backMap.put("message",remark);
            }
            return backMap;
        }
        if(isproguidnull){
            backMap.put("result",false);
            backMap.put("message","保存失败:接收的项目id存在空值");
            return backMap;
        }
        String wheresql = "yearflag = '" + yearflag + "' and province='" + province + "'";
        if ("bdm".equals(appid)) {
            wheresql += " and year='" + year + "'";
        }
        if (goallist != null && goallist.size()>0) {
            delgoalproguids = delgoalproguids.stream().distinct().collect(Collectors.toList());
            String upsql = " kpi_per_id = sys_guid()";
            indexAuthDAO.updateAllByColumn("mainguid", delgoalproguids, goaltablecode, upsql, wheresql);
            upsql = " guid = kpi_per_id,is_deleted = 1";
            indexAuthDAO.updateAllByColumn("mainguid", delgoalproguids, goaltablecode, upsql, wheresql);
            logger.info("-----新增目标数据：" + goallist);
            indexAuthDAO.saveAll(goallist, goaltablecode);
        }
        if (indexlist != null && indexlist.size()>0) {
            delindproguids = delindproguids.stream().distinct().collect(Collectors.toList());
            String upsql = " kpi_id = sys_guid()";
            indexAuthDAO.updateAllByColumn("mainguid", delindproguids, indextablecode, upsql, wheresql);
            upsql = " guid = kpi_id,is_deleted = 1";
            indexAuthDAO.updateAllByColumn("mainguid", delindproguids, indextablecode, upsql, wheresql);
            logger.info("-----新增指标数据：" + indexlist);
            indexAuthDAO.saveAll(indexlist, indextablecode);
        }
        if (assessmentlist != null && assessmentlist.size()>0) {
            delassproguids = delassproguids.stream().distinct().collect(Collectors.toList());
            String upsql = " guid = sys_guid(),is_deleted = 1";
            indexAuthDAO.updateAllByColumn("mainguid", delassproguids, assessmentTablecode, upsql,null);
            logger.info("-----新增事前绩效数据：" + assessmentlist);
            indexAuthDAO.saveAll(assessmentlist, assessmentTablecode);
        }
        if (beforeviewlist != null && beforeviewlist.size()>0) {
            delbeforeproguids = delbeforeproguids.stream().distinct().collect(Collectors.toList());
            String upsql = " guid = sys_guid(),is_deleted = 1";
            indexAuthDAO.updateAllByColumn("mainguid", delbeforeproguids, beforeviewTablecode, upsql,null);
            logger.info("-----新增事前绩效报告数据：" + beforeviewlist);
            indexAuthDAO.saveAll(beforeviewlist, beforeviewTablecode);
        }
        backMap.put("result",true);
        backMap.put("message","保存成功");
        return backMap;
    }

    public void setData(Map<String, Object> params){
        params.put("creater", SecureUtil.getCurrentUserID());
        params.put("createtime", PerfUtil.getServerTimeStamp());
        params.put("updatetime",PerfUtil.getServerTimeStamp());
        params.put("create_time", PerfUtil.getServerTimeStamp());
        this.getBasMap(params, "add");
    }

    /**
     * 查询绩效数据接口
     * @param param
     * @throws AppException
     */
    public Map getGoaAndIindex(Map<String,Object> param) throws AppException {
        Map<String, Object> backMap = new HashMap();
        String province = (String) param.get("province");
        String year = (String) param.get("year");
        String appid = (String) param.get("appid");
        List<String> proList = (List<String>) param.get("proList");
        StringBuffer wheresql = new StringBuffer();
        String goaltablecode = "pm_perf_goal_info";
        String indextablecode = "pm_perf_indicator";
        String assesstablecode = "perf_t_assessment";
        String beforetablecode = "perf_t_beforeview";
        if (proList != null && proList.size() > 0) {
            String col = "mainguid";
            if ("bdm".equals(appid)) {
                col = "pro_code";
            }
            wheresql.append(indexAuthDAO.createInSql(col, proList));
            wheresql.append(" and is_deleted=2 ");
            if ("pdm".equals(appid)) {
                List<Map<String, Object>> assessList = indexAuthDAO.getDatas(assesstablecode, wheresql.toString(), null);
                backMap.put(assesstablecode, PerfUtil.upperMapKey(assessList));
                List<Map<String, Object>> beforeList = indexAuthDAO.getDatas(beforetablecode, wheresql.toString(), null);
                backMap.put(beforetablecode, PerfUtil.upperMapKey(beforeList));
            }
            String yearflag = PerfConstant.PMKPI_ONE;
            String[] strs = null;
            wheresql.append(" and is_backup=2 and yearflag=? and province=? ");
            if ("bdm".equals(appid)) {
                yearflag = "0";
                wheresql.append(" and year=? ");
                strs = new String[]{yearflag, province, year};
            } else {
                strs = new String[]{yearflag, province};
            }
            List<Map<String, Object>> goalList = indexAuthDAO.getDatas(goaltablecode, wheresql.toString(), null, strs);
            List<Map<String, Object>> indexList = indexAuthDAO.getDatas(indextablecode, wheresql.toString(), null, strs);
            backMap.put(goaltablecode, PerfUtil.upperMapKey(goalList));
            backMap.put(indextablecode, PerfUtil.upperMapKey(indexList));
            backMap.put("result", true);
            backMap.put("message", "查询成功");
        } else {
            backMap.put("result", false);
            backMap.put("message", "项目信息为空！");
        }
        return backMap;
    }


}
