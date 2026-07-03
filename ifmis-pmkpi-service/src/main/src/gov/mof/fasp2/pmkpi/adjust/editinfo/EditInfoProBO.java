package gov.mof.fasp2.pmkpi.adjust.editinfo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class EditInfoProBO extends PmkpiBO {
    private EditInfoProDAO editInfoProDAO;

    public void setEditInfoProDAO(EditInfoProDAO editInfoProDAO) {
        this.editInfoProDAO = editInfoProDAO;
    }

    /**
     * 查询项目信息
     * @param params --项目guid
     * @return
     */
    public Map<String, Object> getEditInfo(HashMap<String, Object> params) {
        //String prolev = (String) params.get("prolev");
        String proguid = (String) params.get("proguid");
        String tablecode = (String) params.get("tablecode");
        String procode = (String) params.get("procode");
        String bustype = (String) params.get("bustype");
        String queryYear = (String) params.get("queryYear");
        String queryProvince = (String) params.get("queryProvince");
        if (!StringUtil.isNullOrEmpty(queryYear) && !StringUtil.isNullOrEmpty(queryProvince)) {
            this.setYearAndProvince(queryYear, queryProvince);
        }
        List<Map<String, Object>> list = editInfoProDAO.getByGuid(tablecode, proguid, procode, bustype);
        if (list == null || list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

    /**
     * 获取调整/监审基本信息
     * @return
     */
    public Map<String, Object> getMaininfo(HashMap<String, Object> params) {
        String mainguid = (String) params.get("mainguid");
        String queryYear = (String) params.get("queryYear");
        String queryProvince = (String) params.get("queryProvince");
        if (!StringUtil.isNullOrEmpty(queryYear) && !StringUtil.isNullOrEmpty(queryProvince)) {
            this.setYearAndProvince(queryYear, queryProvince);
        }
        List<Map<String, Object>> list = editInfoProDAO.getDatas(editInfoProDAO.TABLE_ADJUST, " guid='"+mainguid+"'", "order by updatetime");
        if (list != null && list.size()>0){
            return list.get(0);
        }
        return new HashMap<String, Object>();
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) throws AppException {
        Map<String,Object> backMap = new HashMap<String, Object>();
        String busguid = (String) config.get("busguid");
        String mainguid = (String) config.get("mainguid");
        String procode = (String) config.get("procode");
        String bustype = (String) config.get("bustype");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        infodata.put("guid",mainguid);
        if ("dept".equals(bustype)){ //湖北添加部门整体绩效可调整基本信息
            List<String> cols = new ArrayList<String>(infodata.keySet());
            cols.remove("proguid");
            editInfoProDAO.update(cols, infodata, editInfoProDAO.TABLE_ADJUST);
        }
        List l = new ArrayList();
        l.add(infodata);
        return this.auditdefine(l, busguid,"perf", null);
    }

}
