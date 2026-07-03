package gov.mof.fasp2.pmkpi.prorevision.editinfo;

import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

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
        String proguid = (String) params.get("proguid");
        String tablecode = (String) params.get("tablecode");
        String procode = (String) params.get("procode");
        List<Map<String, Object>> list = new ArrayList<>();
        if(PerfUtil.getIsHbei()){
            list = editInfoProDAO.getByGuid(tablecode, proguid);
        }else {
            String wheresql = " t.pro_code = '"+procode+"'";
            list = editInfoProDAO.getDatas(tablecode,wheresql,null);
        }
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
        List<Map<String, Object>> list = editInfoProDAO.getDatas(editInfoProDAO.TABLE_REVISION, " guid='"+mainguid+"'", "order by updatetime");
        if (list != null && list.size()>0){
            return list.get(0);
        }
        return new HashMap<String, Object>();
    }

}
