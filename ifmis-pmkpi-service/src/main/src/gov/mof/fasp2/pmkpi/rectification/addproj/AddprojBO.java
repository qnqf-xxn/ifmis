package gov.mof.fasp2.pmkpi.rectification.addproj;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.table.appexception.DicTableAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class AddprojBO extends PmkpiBO {
    private AddprojDAO addprojDAO;

    public void setAddprojDAO(AddprojDAO addprojDAO) {
        this.addprojDAO = addprojDAO;
    }

    /**
     * 编辑页查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String orderby = (String) params.get("orderby");
        String wheresql = "";
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        String tablesql = (String) params.get("tablesql");
        wheresql = " t.mainguid = '" + mainguid + "'";
        if (tablesql != null && !tablesql.isEmpty()) {
            wheresql += tablesql;
        }
        List<Map<String, Object>> data = addprojDAO.getDatas(tablecode, wheresql, orderby);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 编辑区查询
     *
     * @param params
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String mainguid = (String) params.get("mainguid");
        String saveAgency = (String) params.get("saveAgency");
        String tablecode = (String) params.get("tablecode");
        String iswf = (String) params.get("iswf");
        Map<String, Object> map = this.getDataByGuid(tablecode, mainguid, iswf);
        if (map.isEmpty()) {
            List<Map<String, Object>> agencyList = this.getAgencyData(saveAgency);
            if (null != agencyList && agencyList.size() != 0) {
                String name = (String) agencyList.get(0).get("name");
                String code = (String) agencyList.get(0).get("code");
                map.put("name", name);
                map.put("code", code);
            }
            map.put("guid", mainguid);
        }
        backMap.put("editdata", map);
        return backMap;
    }

    /**
     * 根据guid查询数据
     *
     * @param guid
     * @return
     * @throws AppException
     * @throws DicTableAppException
     */
    public Map getDataByGuid(String tablecode, String guid, String iswf){
        List list = new ArrayList();
        if (iswf != null && "true".equals(iswf)) {
            list = addprojDAO.getDataByGuid(tablecode, guid);
        } else {
            list = addprojDAO.getDataByMainguid(tablecode, guid);
        }
        Map map = new HashMap();
        if (list.size() > 0) {
            map = (Map) list.get(0);
        }
        return map;
    }

}
