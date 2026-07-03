package gov.mof.fasp2.pmkpi.rectification.info;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProgramInfoBO extends PmkpiBO {

    private ProgramInfoDAO programInfoDAO;

    public void setProgramInfoDAO(ProgramInfoDAO programInfoDAO) {
        this.programInfoDAO = programInfoDAO;
    }

    /**
     * 查询项目信息
     * @param params
     * @return
     */
    public Map<String,Object> queryProdata (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        String proguid = (String) params.get("proguid");
        String bustype = (String) params.get("bustype");
        String pro_code = (String) params.get("pro_code");  //项目编码
        String tablecode = (String) params.get("tablecode");
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            programInfoDAO.setYearAndProvince(queryYear, queryProvince);
        }
        StringBuffer wheresql = new StringBuffer();
        if (PerfUtil.getIsHbei() || "3".equals(bustype)) {
            wheresql.append(" guid = '"+proguid+"'");
        }else{
            wheresql.append("pro_code = '"+pro_code+"'");
        }
        List<Map<String, Object>> list = programInfoDAO.getDatas(tablecode, wheresql.toString(), null);
        rs.put("datas", list);
        rs.put("success", true);
        return rs;
    }
}
