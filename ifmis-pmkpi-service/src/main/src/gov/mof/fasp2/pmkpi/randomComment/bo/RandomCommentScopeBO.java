package gov.mof.fasp2.pmkpi.randomComment.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.randomComment.dao.RandomCommentScopeDAO;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RandomCommentScopeBO extends PmkpiBO {

    private RandomCommentScopeDAO randomCommentScopeDAO;

    public void setRandomCommentScopeDAO(RandomCommentScopeDAO randomCommentScopeDAO) {
        this.randomCommentScopeDAO = randomCommentScopeDAO;
    }

    /**
     *  列表的查询方法.
     * <p>Title: getVodSql</p>
     * <p>Description: </p>
     * @param params
     * @return
     * @throws AppException
     * @see gov.mof.fasp2.pmkpi.common.PmkpiBO#getVodSql(java.util.Map)
     */
    @Override
    public String getVodSql(Map params) throws AppException {
        List queryConfig = (List) params.get("queryConfig");
        String wheresql = (String) params.get("querySql"); //查询区封装的参数
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> data = null;
        String menuid = (String) params.get("menuid");
        String agency = (String) params.get("agency");
        String tablecode = (String) params.get("tablecode");
        String tabfilter = (String) params.get("tabfilter");
        String tablesql = (String) params.get("tablesql");
        String orderby = (String) params.get("orderby");
        String tabcode = (String) params.get("tabcode");
        String ctablecode = (String) params.get("ctablecode");
        String bustype = (String) params.get("bustype");
        String isleaf = (String) params.get("isleaf");

        if (tabcode != null && "create".equals(tabcode)) {
            tablecode = ctablecode;
        }
        String elementcode = PerfUtil.getSystemSet("agency_lefttree");
        logger.info("左侧树要素"+elementcode+"####");
        if (StringUtil.isEmpty(elementcode)){
            elementcode  = "PMKPIAGENCYALLPAY"; //没有配置默认单位
        }
        String datarule = this.getDataRuleByMenuguidNull(menuid, "t", null); //数据权限
        logger.info("---数据权限：" +menuid +"--"+ datarule);

        IDataSetService dss = PerfServiceFactory.getIDataSetService();
        if (!"2".equals(isleaf) && !"treeroot".equals(agency)) {
            datarule += " start with superguid='" + agency + "' connect by prior guid = superguid";
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            randomCommentScopeDAO.saveAll(eledatas, randomCommentScopeDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ((agency != null && "treeroot".equals(agency))) {
            datarule = " 1= 1" + datarule;
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql(elementcode,datarule);
            randomCommentScopeDAO.saveAll(eledatas, randomCommentScopeDAO.PMKPI_TABLE_TMP_AGENCY);
        }

        StringBuffer returnsql = new StringBuffer("select * from ");
        returnsql.append(tablecode).append(" t where t.bustype='" + bustype + "'");
        if ("toident".equals(tabfilter)) {
            returnsql.append(" and t.ISSCOPE='0' AND T.ISOBJECT IS NULL AND T.ISRANDOM IS NULL");
        } else if ("isident".equals(tabfilter)) {
            returnsql.append(" and t.ISSCOPE='1'");
        }
        if (queryConfig != null && queryConfig.size() > 0) {
            Map<String, String> queryParam = (Map<String, String>) queryConfig.get(0);
            String wfstatus = queryParam.get("wfstatus");
            String projname = queryParam.get("projname");
            String finintorgguid = queryParam.get("finintorgguid");
            String vcol2 = queryParam.get("vcol2");
            String adjuststatus = queryParam.get("adjuststatus");
            String amtmax = queryParam.get("amtmax");
            String amtmin = queryParam.get("amtmin");

            DecimalFormat formater = new DecimalFormat("0");
            formater.setRoundingMode(RoundingMode.HALF_UP);
            if (!StringUtil.isEmpty(wfstatus) && !"".equals(wfstatus)) {
                String[] split = wfstatus.split(",");
                String str = "";
                for (int i = 0; i < split.length; i++) {
                    if (str.length() == 0 && "".equals(str)) {
                        str = "(WFSTATUS = '" + split[i] + "')";
                    } else {
                        str = str + "or (WFSTATUS = '" + split[i] + "')";
                    }
                }
                returnsql.append(" and (" + str + ")");
            }
            if (!StringUtil.isEmpty(projname)) {
                returnsql.append(" and projname like '%" + projname + "%'");
            }
            if (!StringUtil.isEmpty(finintorgguid)) {
                returnsql.append(" and finintorgguid in ('" + finintorgguid.replaceAll("\\,", "','") + "')");
            }
            if (!StringUtil.isEmpty(vcol2)) {
                returnsql.append(" and vcol2 in ('" + vcol2.replaceAll("\\,", "','") + "')");
            }
            if (!StringUtil.isEmpty(adjuststatus)) {
                returnsql.append(" and adjuststatus in ('" + adjuststatus.replaceAll("\\,", "','") + "')");
            }
            if (!StringUtil.isEmpty(amtmax)) {
                if (isNumeric(amtmax)) {
                    returnsql.append(" and amt >= " + amtmax);
                }
            }
            if (!StringUtil.isEmpty(amtmin)) {
                if (isNumeric(amtmin)) {
                    returnsql.append(" and amt <= " + amtmin);
                }
            }
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            returnsql.append(" and ").append(tablesql);
        }
        if (isleaf != null && "1".equals(isleaf)) {
            returnsql.append(" and t.agencyguid = '").append(agency).append("'");
        } else {
            returnsql.append(" and exists(select 1 from ").append(randomCommentScopeDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (!StringUtil.isEmpty(orderby)) {
            returnsql.append(" ").append(orderby);
        }
        logger.error("抽评范围标识-----查询sql----------" + returnsql);
        return returnsql.toString();
    }

    /**
     * <p>左侧树</p >
     * @param
     * @author
     * @date 2022/10/27 16:06
     */
    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String lefttabtype = (String) params.get("lefttabtype");
        String tablecode = (String) params.get("tablecode");
        String menuId = (String) params.get("menuid");
        List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
        //根据权限查询单位
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        datarule += " and bustype='" + lefttabtype + "'";
        data = randomCommentScopeDAO.getLeftTree(tablecode, datarule);
        if (data.size() == 0) {
            Map<String, Object> map = new HashMap<>();
            map.put("guid","treeroot");
            map.put("code","00");
            map.put("name","全部");
            map.put("superid","0");
            map.put("levelno","1");
            map.put("isleaf","0");
            data.add(map);
        }
        return data;

    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> submitScope(HashMap<String, Object> config) throws AppException {
        List<Map<String, Object>> scopeList = new ArrayList<Map<String, Object>>();
        List<Map> strList = (List<Map>) config.get("list");
        String isscope = (String) config.get("isscope");
        String tablecode = (String) config.get("tablecode");
        logger.error("范围标识提交表：" + tablecode);
        logger.error("数据大小：" + strList.size());
        UserDTO user = SecureUtil.getCurrentUser();
        if (strList != null && strList.size() > 0) {
            for (int i = 0; i < strList.size(); i++) {
                Map strmap = strList.get(i);
                Map map = new HashMap<String, String>();
                String perfgoalguid = (String) strmap.get("perfgoalguid");
                String pro_code = (String) strmap.get("pro_code");
                String guid = StringUtil.createUUID();
                map.put("guid", guid);
                map.put("perfgoalguid", perfgoalguid);
                map.put("pro_code", pro_code);
                map.put("year", CommonUtil.getYear());
                map.put("province", user.getProvince());
                map.put("isscope", isscope);
                map.put("creater", SecureUtil.getCurrentUserID());
                map.put("createtime", PerfUtil.getServerTimeStamp());
                //map.put("lastupdatetime",CommonUtil.getCreateDate());
                //保存重点项目标识
                scopeList.add(map);
            }
        }
        if (scopeList != null && scopeList.size() > 0) {
            //此处走工作流
            //workflow("create","BC9E69FB8F45683DADA94276CA20F191","",tablecode,scopeList);
            randomCommentScopeDAO.saveAll(scopeList, tablecode);
        }
        return config;
    }

    @SuppressWarnings("unchecked")
    public Map<String, Object> delByGuids(HashMap<String, Object> config) throws AppException {
        List<Map<String, Object>> projList = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("datas");
        String tablecode = (String) config.get("tablecode");

        if (datas != null && datas.size() > 0) {
            for (int i = 0; i < datas.size(); i++) {
                Map strmap = datas.get(i);
                Map map = new HashMap<String, String>();
                String guid = (String) strmap.get("guid");
                map.put("guid", guid);
                map.put("isscope", null);
                projList.add(map);
                randomCommentScopeDAO.update("delete from " + tablecode + " where guid ='" + guid + "'");
            }
        }
        config.put("success", true);
        return config;
    }


}
