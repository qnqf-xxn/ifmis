package gov.mof.fasp2.pmkpi.perfcommon.filelist;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UploadFileBO extends PmkpiBO {

    private UploadFileDAO uploadFileDAO;

    public void setUploadFileDAO(UploadFileDAO uploadFileDAO) {
        this.uploadFileDAO = uploadFileDAO;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String bustype = (String) sqlmap.get("bustype");
        String tablecode = (String)sqlmap.get("tablecode");
        String wheresql = (String)sqlmap.get("defquery");
        StringBuffer returnsql = new StringBuffer("select t.*,'' as supername from ");
        returnsql.append(tablecode).append(" t where 1=1 ");
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and ").append(wheresql);
        }
        if (bustype != null && !bustype.isEmpty()) {
            returnsql.append(" and t.bustype = '").append(bustype).append("'");
        }
        return returnsql.toString();
    }

    public List<Map<String, Object>> queryFiletype (HashMap<String, Object> params){
        String filebustype = (String) params.get("filebustype");
        String wheresql = (String)params.get("defquery");
        String billid = (String) params.get("mainguid");
        String subprovince = (String) params.get("subprovince");
        String taskyear = (String) params.get("taskyear");
        String taskprovince = (String) params.get("taskprovince");
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        StringBuffer returnsql = new StringBuffer();
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and ").append(wheresql);
        }
        if (filebustype != null && !filebustype.isEmpty()) {
            returnsql.append(" and t.bustype = '").append(filebustype).append("'");
        }else{
            returnsql.append(" and 1!=1 ");
        }
        //在getDatas中拼接sql时，会在前面加and，如果条件也是以and开头就会报错
        returnsql.insert(0," 1=1 ");
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            uploadFileDAO.setYearAndProvince(queryYear, queryProvince);
        }
        if (!StringUtil.isEmpty(taskyear) && !StringUtil.isEmpty(taskprovince)) {
            uploadFileDAO.setYearAndProvince(taskyear, taskprovince);
        }
        List<Map<String, Object>> data = uploadFileDAO.getDatas(returnsql.toString(), filebustype, subprovince, billid);
        for (Map<String, Object> map: data) {
            String levelno = PerfUtil.mapGetInt(map,"levelno") + "";
            if ("1".equals(levelno)) {
                map.put("supername",map.get("name"));
                map.put("name",null);
            }
        }
        return data;
    }
}
