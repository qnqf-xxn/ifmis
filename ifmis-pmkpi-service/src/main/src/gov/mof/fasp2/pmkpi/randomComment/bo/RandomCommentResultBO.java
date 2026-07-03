package gov.mof.fasp2.pmkpi.randomComment.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfself.dao.PerfSelfApplyDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.randomComment.dao.RandomCommentResultDAO;
import gov.mof.fasp2.pmkpi.setting.indexlib.report.IndexRpBO;

import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RandomCommentResultBO extends PmkpiBO {

    private RandomCommentResultDAO randomCommentResultDAO;

    public void setRandomCommentResultDAO(RandomCommentResultDAO randomCommentResultDAO) {
        this.randomCommentResultDAO = randomCommentResultDAO;
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
        Map<String, Object> backMap = new HashMap<String, Object>();
        List<Map<String, Object>> data = null;
        List queryConfig = (List) params.get("queryConfig");
        String menuid = (String)params.get("menuid");
        String agency = (String)params.get("agency");
        String tablecode = (String)params.get("tablecode");
        String tabfilter = (String) params.get("tabfilter");
        String tablesql = (String) params.get("tablesql");
        String orderby = (String) params.get("orderby");
        String tabcode = (String) params.get("tabcode");
        String ctablecode = (String) params.get("ctablecode");
        String isleaf = (String)params.get("isleaf");
        String bustype = (String) params.get("bustype");

        if (!StringUtil.isEmpty(tabcode) && "create".equals(tabcode)) {
            tablecode = ctablecode;
        }
        if (!"1".equals(isleaf) && !"treeroot".equals(agency)) {
            // 数据权限
            String datarule = this.getDicDSDataListByWheresql("t", menuid, "dept".equals(bustype) ? "PMKPIDEPT" : "PMKPIAGENCYALLPAY");
            if (!"treeroot".equals(agency)) {
                datarule += " and isleaf=1 start with superguid='" + agency + "' connect by prior guid = superguid";
            }
            IDataSetService dss = PerfServiceFactory.getIDataSetService();
            List<DicRangeDTO> eledatas = dss.getRangesByWhereSql("PMKPIAGENCYALLPAY",datarule);
            randomCommentResultDAO.saveAll(eledatas, randomCommentResultDAO.PMKPI_TABLE_TMP_AGENCY);
        } else if ("treeroot".equals(agency)) {
//        	String sysvalue = this.getSystem("perf_performanceLefttree");
            List<Map<String, Object>> treeData =  this.getLeftTree(menuid, "dept".equals(bustype) ? "PMKPIDEPT" : "PMKPIAGENCYALLPAY");
            randomCommentResultDAO.saveAll(treeData, randomCommentResultDAO.PMKPI_TABLE_TMP_AGENCY);
        }
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        sql.append(" where t.ISSCOPE='0' "); 
        sql.append(" and ((T.ISOBJECT='1') or (T.ISRANDOM='1' and t.meachguid is not null)) ");
        //sql.append(" and T.ISRANDOM='1' ");
        sql.append(" and t.bustype='"+bustype+"'");
        //sql.append(" and PROKIND = '01'");
        if(queryConfig != null&&queryConfig.size() > 0) {
            Map<String ,String> queryParam = (Map<String, String>) queryConfig.get(0);
            String wfstatus = queryParam.get("wfstatus");
            String projname = queryParam.get("projname");
            String finintorgguid = queryParam.get("finintorgguid");
            String vcol2 = queryParam.get("vcol2");
            String amtmax = queryParam.get("amtmax");
            String amtmin = queryParam.get("amtmin");
            DecimalFormat formater = new DecimalFormat("0");
            formater.setRoundingMode(RoundingMode.HALF_UP);
            if(!StringUtil.isEmpty(wfstatus)){
                String[] split = wfstatus.split(",");
                String str = "";
                for (int i = 0; i < split.length; i++) {
                    if(str.length() == 0 && "".equals(str)){
                        str = "(WFSTATUS = '"+split[i]+"')";
                    } else {
                        str = str + "or (WFSTATUS = '"+split[i]+"')";
                    }
                }
                sql.append(" and ("+str+")");
            }
            if(!StringUtil.isEmpty(projname)){
                sql.append(" and projname like '%"+projname+"%'");
            }
            if(!StringUtil.isEmpty(finintorgguid)){
                sql.append(" and finintorgguid in ('"+finintorgguid.replaceAll("\\,", "','")+"')");
            }
            if(!StringUtil.isEmpty(vcol2)){
                sql.append(" and vcol2 in ('"+vcol2.replaceAll("\\,", "','")+"')");
            }
            if(!StringUtil.isEmpty(amtmax)){
                if(isNumeric(amtmax)){
                    sql.append(" and amt >= "+amtmax);
                }
            }
            if(!StringUtil.isEmpty(amtmin)){
                if(isNumeric(amtmin)){
                    sql.append(" and amt <= "+amtmin);
                }
            }
        }
        if (!StringUtil.isEmpty(tablesql)){
            sql.append(" and ").append(tablesql);
        }
        if (!"treeroot".equals(agency) && "1".equals(isleaf)) {
            sql.append(" and t.agencyguid='").append(agency).append("'");
        } else if ("0".equals(isleaf)) {
            sql.append(" and exists(select * from ").append(randomCommentResultDAO.PMKPI_TABLE_TMP_AGENCY)
                    .append(" a where a.guid =t.agencyguid)");
        }
        if (!StringUtil.isEmpty(tabfilter)){
            sql.append(" and ").append(tabfilter);
        }
        if (!StringUtil.isEmpty(orderby)) {
            sql.append(" ").append(orderby);
        }
		logger.error("抽评结果上传列表-----查询sql----------" + sql);
        return sql.toString();
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
        String leftmenuid = (String) params.get("leftmenuid");
        String menuId = (String) params.get("menuid");
        List<Map<String, Object>> data = new ArrayList<Map<String, Object>>();
        //根据权限查询单位
        String datarule = this.getDataRuleByMenuguidNull(menuId, "t", "1=1");
        datarule += " and bustype='" + lefttabtype + "'";
        data = randomCommentResultDAO.getLeftTree(tablecode, datarule);
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

	/**
     * 自评提交
     * @param params --
     * @return --
     */
    public Map<String, Object> submit(HashMap<String, Object> params) throws AppException {
    	List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
    	List<Map<String, Object>> projList = new ArrayList<Map<String,Object>>();
    	String actioncode = (String) params.get("actioncode");
    	String tablecode = (String) params.get("tablecode");
    	String guidstr ="";
        StringBuilder resultStr = new StringBuilder();
    	if(datas!=null && datas.size() > 0){
			for(int i=0;i<datas.size();i++){
				Map strmap = datas.get(i);
 				Map map = new HashMap<String,String>();
 				map.putAll(strmap);
				if("cancelsubmit".equals(actioncode)){
	    			map.put("issubmit","0");
	    		}else{
	    			map.put("issubmit","1");
	    		}
				projList.add(map);
//				guidstr+="'"+strmap.get("guid")+"',";
                resultStr.append(guidstr).append("'").append(strmap.get("guid")).append("',");
			}
            String result = resultStr.toString();
            guidstr=result.substring(0, result.length()-1);
			if(projList!=null && projList.size() > 0){
				randomCommentResultDAO.updateAllByPK(projList, "guid", tablecode);
			}
		}
    	String busguid ="";
    	if("submit".equals(actioncode)){
    		busguid = (String) params.get("busguid");
    	}
    	String sql ="update pmkpi_t_perm_valueset_adj t set t.permtype ='1' where exists(select guid from V_perf_t_randomindex where mainguid in (" + guidstr + ") and levelno ='3' and permtype = '0' and guid =t.guid)";
    	if("submit".equals(actioncode)){
			randomCommentResultDAO.execute(sql);
		}
    	return this.auditdefine(datas, busguid, actioncode, null);
    }

    /**
     * 批量导入评价结果
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importRandomResult(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            RandomCommentResultBO randomCommentResultBO = (RandomCommentResultBO) PerfServiceFactory.getBean("pmkpi.randomcomment.RandomCommentResultBOTX");
            randomCommentResultBO.importResultDatas(impDatas, impCols, tablecode, resultList, busParams);
        }
    }

    public void importResultDatas(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        //校验数据
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto = null;
        List errorlist = new ArrayList();
        List addList = new ArrayList();
        StringBuffer delsql = new StringBuffer(" delete from v_perf_t_randomproblem where mainguid in(");
        for (Object obj : impDatas) {
            Map<String, Object> map = (Map<String, Object>) obj;
            String pro_code = (String) map.get("pro_code");
            String agency_code = (String) map.get("agency_code");
            String wheresql = "pro_code ='" + pro_code + "' and agency_code ='" + agency_code + "'";
            Map<String, Object> data = this.getDataMap("V_PERF_T_RANDOMCOMMENT_PROJ",wheresql);
            String timestamps = PerfUtil.getServerTimeStamp();
            String province = CommonUtil.getProvince();
            String year = CommonUtil.getYear();
            //导入时根据单位编码+项目编码匹配抽评项目，未匹配的不处理，重复导入直接覆盖
            if(data.isEmpty()){
                continue;
            }else{
                String selfguid = (String) data.get("selfguid");
                map.put("guid",this.getCreateguid());
                map.put("mainguid",selfguid);
                map.put("selfguid",selfguid);
                map.put("createtime", timestamps);
                map.put("updatetime", timestamps);
                map.put("province", province);
                map.put("year", year);
                addList.add(map);
                delsql.append("'").append(selfguid).append("',");
            }
        }
        if (addList.size() > 0) {
            delsql.deleteCharAt(delsql.length() - 1);
        } else {
            delsql.append("''");
        }
        delsql.append(")");
        if (addList.size()>0) {
            randomCommentResultDAO.execute(delsql.toString());
            logger.debug("-----删除已存在评价结果：" +delsql.toString());
            logger.debug("-----导入评价结果：" +addList.toString());
            randomCommentResultDAO.saveAll(addList, "v_perf_t_randomproblem");
        }
    }
}
