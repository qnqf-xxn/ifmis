package gov.mof.fasp2.pmkpi.setting.casepage.info;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CaseInfoBO extends PmkpiBO {
    private CaseInfoDAO caseInfoDAO;

    public void setCaseInfoDAO(CaseInfoDAO caseInfoDAO) {
        this.caseInfoDAO = caseInfoDAO;
    }

    /**
     * 基本信息
     * @return
     */
    public Map<String, Object> getMaininfo(HashMap<String, Object> params) {
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        String bustype = (String) params.get("bustype");
        String wheresql = " guid='" + mainguid + "' and bustype='" + bustype + "'";
        return caseInfoDAO.getDataMap(tablecode, wheresql);
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) throws AppException {
        String busguid = (String) config.get("busguid");
        String workflow = (String) config.get("workflow");
        String tablecode = (String) config.get("tablecode");
        String mainguid = (String) config.get("mainguid");
        String bustype = (String) config.get("bustype");
        String saveAgency = (String) config.get("saveAgency");
        String finintorgguid = (String) config.get("finintorgguid");
        String casetype = (String) config.get("casetype");
        Map<String, Object> infoMap = this.getMaininfo(config);
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        String guid = (String) infodata.get("guid");
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        if (StringUtil.isEmpty(guid)) {
            UserDTO user = SecureUtil.getCurrentUser();
            infodata.put("guid", mainguid);
            infodata.put("bustype", bustype);
            infodata.put("status", 1);
            infodata.put("is_deleted", 2);
            infodata.put("createtime", PerfUtil.getServerTimeStamp());
            infodata.put("updatetime", PerfUtil.getServerTimeStamp());
            infodata.put("creater", user.getGuid());
            infodata.put("province", user.getProvince());
            infodata.put("year", CommonUtil.getYear());
            infodata.put("agencyguid", saveAgency);
            infodata.put("finintorgguid", finintorgguid);
            infodata.put("isadjust", "0");
            infodata.put("casetype", casetype);
            l.add(infodata);
            this.workflow("create", workflow, "", tablecode, l);
        } else {
            infoMap.putAll(infodata);
            caseInfoDAO.update(infoMap, tablecode);
            l.add(infoMap);
        }
        String name = (String) infodata.get("name");
        String wheresql = "name=? and agencyguid=?";
        int count = caseInfoDAO.getDataCount(tablecode, wheresql, new String[]{name, saveAgency});
        if (count > 1) {
            throw new AppException("error", "已存在同名称案例，修改后再保存！");
        }
        return this.auditdefine(l, busguid,"perf", null);
    }
}
