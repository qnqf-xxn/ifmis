package gov.mof.fasp2.pmkpi.perfcommon.expdoc;

import gov.mof.fasp2.buscore.framework.component.AbstractComponentService;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author zdy
 *
 */
public class ExpDocBO extends AbstractComponentService implements IExpDocABO {

    public ExpDocDAO expDocDAO;

    @SuppressWarnings("rawtypes")
    @Override
    public List<Map<String, Object>> genExpData(Map param, Map templateMap) {
        List<Map<String, Object>> subList = (List<Map<String, Object>>) param.get("subdata");
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        boolean rcp = param.get("rcp") == null? false : (boolean) param.get("rcp");
        List<String> guids = (List<String>) param.get("guids");
        Map subMap = null;
        String expType = String.valueOf(templateMap.get("exptype"));
        float f2 = new Float( 1+guids.size());
        for (int i = 0; i < guids.size(); i++) {
            float f1 = new Float(i + 1);
            String guid = guids.get(i);
            String expfilename = String.valueOf(templateMap.get("expfilename"));
            subMap = this.genBusExpData(subList, guid);
            String agencycodename = (String) subMap.get("agencycodename");
            String month = (String) subMap.get("month");
            String code = (String) subMap.get("code");
            String name = (String) subMap.get("name");
            if (agencycodename != null) {
                expfilename = expfilename.replace("#agency#", agencycodename);
            } else {
                expfilename = expfilename.replace("#agency#", "");
            }
            if (month != null) {
                expfilename = expfilename.replace("#month#", month);
            } else {
                expfilename = expfilename.replace("#month#", "");
            }
            if (code != null) {
                expfilename = expfilename.replace("#code#", code);
            } else {
                expfilename = expfilename.replace("#code#", "");
            }
            if (name != null) {
                expfilename = expfilename.replace("#name#", name);
            } else {
                expfilename = expfilename.replace("#name#", "");
            }
            if (expfilename.contains("#systime#")) {
                expfilename = expfilename.replace("#systime#", "");
                subMap.put("expfilename", expfilename + "." + expType);
            } else {
                subMap.put("expfilename", expfilename +"_"+ PerfUtil.getServerTimeStamp() + i+ "." + expType);
            }
            if (rcp) {
                this.getConsole().setProcess((f1/f2)*0.8);
                this.getConsole().println("当前进度: 正在处理第" + (i + 1) + "条数据!");
            }
            subMap.put("busguid", guid);
            list.add(subMap);
        }
        return list;
    }
    /**
     * 获取模板数据.
     *
     * @param subList --subList
     * @param busguid --busguid
     * @return --
     * @throws PerfAppException --
     */
    public Map<String, Object> genBusExpData(List<Map<String, Object>> subList, String busguid) {
        Map<String, Object> dataMap = new HashMap<String, Object>();
        int i=0;
        for (Map<String, Object> cfg : subList) {
            String datakey = String.valueOf(cfg.get("datakey"));
            String wheresql = null == cfg.get("wheresql") ? "" : String.valueOf(cfg.get("wheresql"));
            String tablecode = String.valueOf(cfg.get("tablecode"));
            String querytype = String.valueOf(cfg.get("querytype"));
            List<Map<String, Object>> dataList = expDocDAO.getData(tablecode, busguid, querytype, wheresql);
            if (i == 0) {
                if (dataList!=null && dataList.size() > 0) {
                    Map<String, Object> map = dataList.get(0);
                    dataMap.put("agencycodename", map.get("agencycodename"));
                    dataMap.put("month", map.get("month"));
                    dataMap.put("code", map.get("code"));
                    dataMap.put("name", map.get("name"));
                }
            }
            i++;
            dataMap.put(datakey, dataList);
        }
        return dataMap;
    }


    public void setExpDocDAO(ExpDocDAO expDocDAO) {
        this.expDocDAO = expDocDAO;
    }

}
