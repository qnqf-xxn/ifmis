
package gov.mof.fasp2.pmkpi.perfprogram.fundCalIndex;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2020-1-6 上午10:41:23
 * @ClassName: PrjIndexBO
 * @Description: Description of this class
 */

public class FundCalIndexBO extends PmkpiBO {
    /**
     * fundCalIndexDAO.
     */
    private FundCalIndexDAO fundCalIndexDAO;

    /**
     * 注入dao.
     *
     * @param fundCalIndexDAO --prjIndexDAO.
     * @throws
     */
    public void setFundCalIndexDAO(FundCalIndexDAO fundCalIndexDAO) {
        this.fundCalIndexDAO = fundCalIndexDAO;
    }


    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        StringBuffer sql = new StringBuffer();
        return sql.toString();
    }
    public Map<String, Object> findYearIndexs(Map<String, Object> params) throws AppException {
        String procode = (String) params.get("procode");
        List<Map<String, Object>> indexs = fundCalIndexDAO.findIndexs(procode, "v_perf_T_fundcalindexview");
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        yearsMap.put("index", indexs);
        return yearsMap;
    }

    public void saveCalIndex(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("projguid");
        String showtab = (String) params.get("showtab"); //页签显示 1总+年2总3年
        String procode = (String) params.get("procode"); //项目编码
        logger.debug("--------proguid-----"+proguid+"----");
        logger.debug("--------showtab-----"+showtab+"----");
        logger.debug("--------procode-----"+procode+"----");

        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        Map<String, Object> tabcomps = (Map<String, Object>) params.get("datas"); //多页签的数据
        logger.debug("--------tabcomps-----"+tabcomps+"----");

        List<Map<String, Object>> yearList = (List<Map<String, Object>>) tabcomps.get("#year");
        logger.debug("--------yearList-----"+yearList+"----");

        if(yearList!=null&&yearList.size()>0){
            for (Map tempMap : yearList) {
                if(!StringUtil.isEmpty((String) tempMap.get("guid"))){
                    Map<String, Object> addMap = new HashMap();
                    addMap.put("guid", StringUtil.createUUID());
                    addMap.put("indexguid",tempMap.get("guid"));
                    addMap.put("fundguid",tempMap.get("fundguid"));
                    addMap.put("procode",tempMap.get("procode"));
                    addMap.put("year",tempMap.get("year"));
                    addMap.put("province",tempMap.get("province"));
                    addMap.put("createtime", PerfUtil.getServerTimeStamp());
                    addMap.put("updatetime", PerfUtil.getServerTimeStamp());
                    addMap.put("is_deleted","2");
                    indexList.add(addMap);
                }
            }
            fundCalIndexDAO.delDatas("perf_T_fundcalindex","procode = "+procode+"");
            if(indexList.size() > 0){
                fundCalIndexDAO.saveAll(indexList,"perf_T_fundcalindex");
            }
        }
    }


}
