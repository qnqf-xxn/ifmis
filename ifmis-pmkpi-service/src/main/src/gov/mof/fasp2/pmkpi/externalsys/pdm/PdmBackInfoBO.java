package gov.mof.fasp2.pmkpi.externalsys.pdm;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.List;
import java.util.Map;

public class PdmBackInfoBO extends PmkpiBO {
    private PdmBackInfoDAO pdmBackInfoDAO;

    public void setPdmBackInfoDAO(PdmBackInfoDAO pdmBackInfoDAO) {
        this.pdmBackInfoDAO = pdmBackInfoDAO;
    }

    /**
     * 返回结果到基础库
     * @param data
     * @throws AppException
     */
    public void save(Map data) throws AppException {
        List<Map<String, Object>> proList = (List) data.get("proList");
        Map<String, Object> backMap = (Map<String, Object>) data.get("backMap");
        String province = StringUtil.isEmpty((String) data.get("province")) ? SecureUtil.getUserSelectProvince() : (String) data.get("province");
        String year = StringUtil.isEmpty((String) data.get("year")) ? SecureUtil.getYear() : (String) data.get("year");
        if (proList == null || proList.isEmpty() || backMap == null || backMap.isEmpty()) {
            logger.error("绩效接收MQ消息，项目库退回信息, 消息内容为空！不处理数据。");
            return;
        }
        for (Map<String, Object> map : proList) {
            map.putAll(backMap);
            map.put("guid", this.getCreateguid());
            map.put("province", province);
            map.put("year", year);
            map.put("createtime", PerfUtil.getServerTimeStamp());
            map.put("updatetime", PerfUtil.getServerTimeStamp());
            map.put("proguid", map.get("pro_id"));
            map.put("backtype", map.get("backType"));
        }
        pdmBackInfoDAO.saveAll(proList, pdmBackInfoDAO.PERF_TABLE_BACKINFO);
    }

}
