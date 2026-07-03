package gov.mof.fasp2.pmkpi.deptoverallmerit.tab;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.ca.user.util.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 16:45 2020/8/24  chongdayong
 */
public class WorkContentBO extends PmkpiBO {
    private WorkContentDAO workContentDAO;

    public void setWorkContentDAO(WorkContentDAO workContentDAO) {
        this.workContentDAO = workContentDAO;
    }

    /**
     * 查询数据方法
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //String projguid = (String)params.get("projguid");
        String mainguid = (String)params.get("mainguid");
        String contenttype = (String)params.get("contenttype");
//        String tablecode = (String)params.get("tablecode");
        String wheresql = "";
        if(contenttype != null){
            wheresql = " t.mainguid = '" + mainguid + "' and t.contenttype = '"+ contenttype +"'";
        } else {
            wheresql = " t.mainguid = '" + mainguid + "'";
        }
        List<Map<String, Object>>  data = workContentDAO.getDatas("perf_t_wordcontent", wheresql, "order by guid");
        backMap.put("data", data);
        return backMap;
    }
    
    /**
     * 保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
		UserDTO user = SecureUtil.getCurrentUser();
    	//表名
        String busguid = (String) params.get("busguid");
        //全部数据
        Map<String, Object> datas = (Map<String, Object>) params.get("datas");
        String mainguid = (String) params.get("mainguid");
        String content = (String) params.get("content");
        String contenttype = (String) params.get("contenttype");
        String guid = (String) datas.get("guid");
        Map map = new HashMap();
        List<Map> updatas = workContentDAO.getByGuid("PERF_T_WORDCONTENT", guid);
		if (updatas != null && updatas.size() > 0) {//修改
			map = updatas.get(0);
//			map.putAll(datas);
			map.put("content", content);
			map.put("updatetime", StringUtil.getSysDBDate());
			workContentDAO.update(map, "PERF_T_WORDCONTENT");
		} else {
			map.put("guid", StringUtil.createUUID());
			map.put("status", 0);
			map.put("content", content);
			map.put("mainguid", mainguid);
			map.put("contenttype", contenttype);
			map.put("createtime", StringUtil.getSysDBDate());
			map.put("updatetime", StringUtil.getSysDBDate());
			map.put("province", SecureUtil.getUserSelectProvince());
			map.put("year", CommonUtil.getYear());
			map.put("creater", user.getGuid());
			workContentDAO.save(map, "PERF_T_WORDCONTENT");
		}
        List<Map<String, Object>> list = new ArrayList<Map<String,Object>>();
        list.add(datas);
        return this.auditdefine(list, busguid,"perf", null);
    }

}
