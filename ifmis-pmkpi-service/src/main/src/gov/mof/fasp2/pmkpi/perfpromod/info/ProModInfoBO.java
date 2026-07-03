package gov.mof.fasp2.pmkpi.perfpromod.info;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 17:42 2020/9/9  chongdayong
 */

public class ProModInfoBO extends PmkpiBO {

    private ProModInfoDAO proModInfoDAO;

    public void setProModInfoDAO(ProModInfoDAO proModInfoDAO) {
        this.proModInfoDAO = proModInfoDAO;
    }
    
    /**
     * 查询项目信息
     * @param proguid --项目guid
     * @param prolev --项目级次
     * @return
     */
    public Map<String, Object> getProgramInfo(String proguid, String prolev) {
        String tablecode = "v_perf_project_info";
        if (prolev != null && "1".equals(prolev)) {
            tablecode = "perf_t_flprogram";
        } else if (prolev != null && "2".equals(prolev)) {
            tablecode = "perf_t_slprogram";
        }
        return proModInfoDAO.getProgramInfo(tablecode, proguid);
    }

    /**
     * 获取调整/监审基本信息
     * @return
     */
    public Map<String, Object> getAdjustinfo(HashMap<String, Object> params) {
        String tablecode = (String) params.get("tablecode");
        String mainguid = (String) params.get("mainguid");
        List<Map<String, Object>> list = proModInfoDAO.getDatas(tablecode, " guid='"+mainguid+"'", null);
        if (list != null && list.size()>0){
            return list.get(0);
        }
        return null;
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) throws AppException {
        String tablecode = (String) config.get("tablecode");
        String busguid = (String) config.get("busguid");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        infodata.put("updatetime", StringUtil.getSysDBDate());
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        proModInfoDAO.update(infodata, tablecode);
        return this.auditdefine(l, busguid,"perf", null);
    }
}
