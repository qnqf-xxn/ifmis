package gov.mof.fasp2.pmkpi.randomComment.tab;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RandomQualityEditBO extends PmkpiBO {

    private RandomQualityEditDAO randomQualityEditDAO;

    public void setRandomQualityEditDAO(RandomQualityEditDAO randomQualityEditDAO) {
        this.randomQualityEditDAO = randomQualityEditDAO;
    }


    public Map<String, Object> getDatas(HashMap<String, Object> params) throws AppException {
        String mainguid = (String)params.get("mainguid");
        String procode = (String)params.get("procode");
        String tablecode = (String)params.get("tablecode");
        String bustype = (String)params.get("bustype");
        String tabcode = (String)params.get("tabcode");
        String tabcode1 = (String)params.get("tabcode1");
        String menuid = (String)params.get("menuid");
        String code = "";
    	Map<String, Object> backMap = new HashMap<String, Object>();
    	List<Map<String, Object>>  data = new ArrayList();
    	// 先查配置的模板
    	String wheresql1 = " t.menuid = '"+menuid+"' and t.bustype = '"+bustype+"' ";
        List<Map<String, Object>> datas = randomQualityEditDAO.getDataList(tabcode1, wheresql1);
        if(datas.size() > 0){
        	// 查询是否保存过模板数据
        	Map<String, Object> map = datas.get(0);
        	code = (String) map.get("code");
        	String wheresql = " t.code = '"+code+"' and t.bustype = '"+bustype+"' and t.pro_code = '"+procode+"'";
    	    data = randomQualityEditDAO.getDatas(tablecode, wheresql, "order by ordernum");
    	    if(data.size() <= 0){
    	    	// 未保存 则取空模板
            	//String wheresq2 = " t.code = '"+code+"' and t.bustype = '"+bustype+"'";
                String wheresq2 = " t.code = '"+code+"'";
                data = randomQualityEditDAO.getDatas(tabcode, wheresq2, "order by ordernum");
    	    }
        }
        backMap.put("data", data);
        return backMap;
    }

    public Map<String, Object> saveQual(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        String mainguid = (String) params.get("mainguid");
        String procode = (String) params.get("procode");
        String busguid = (String) params.get("busguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        //String delsql = " t.projguid = '"+mainguid+"'";
        String delsql = " t.pro_code = '"+procode+"'";
        randomQualityEditDAO.delDatas(tablecode, delsql);
        for (Map<String, Object> map : datas) {
            map.put("mainguid", (String)map.get("guid"));
            map.put("pro_code", procode);
            map.put("projguid", mainguid);
            map.put("score", (String)map.get("score")==null||((String) map.get("score")).length() == 0? "0" : (String)map.get("score"));
            map.put("buckle", map.get("buckle")!=null ? ((String)map.get("buckle")).replace("<br>", "") : "");
            map.put("bustype", map.get("bustype"));
            map.put("ststus", 0);
            map.put("createtime", StringUtil.getSysDBDate());
            map.put("updatetime", StringUtil.getSysDBDate());
            map.put("creater", SecureUtil.getCurrentUser().getGuid());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", CommonUtil.getYear());
            addlist.add(map);
        }
        if (addlist.size() > 0) {
            randomQualityEditDAO.saveAll(addlist, tablecode);
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }

}
