package gov.mof.fasp2.pmkpi.deptoverallmerit.tab;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
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
public class DeptScoreBO extends PmkpiBO {
    private DeptScoreDAO deptScoreDAO;

    public void setDeptScoreDAO(DeptScoreDAO deptScoreDAO) {
        this.deptScoreDAO = deptScoreDAO;
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
        String tablecode = (String)params.get("tablecode");
        String bustype = (String)params.get("bustype");
        String viewtype = (String)params.get("viewtype");
        String querytype = (String)params.get("querytype");
        String menuid = (String)params.get("menuid");
        String agency = (String)params.get("agency");
        UserDTO user = SecureUtil.getCurrentUser();
        String finintorgguid = null;
        if(user.getUsertype()==1){
        	finintorgguid = user.getDivision();
        }else{
        	//部门用户看全表
        	viewtype = "editquery";
        }
        // 判断数据是否在本业务处室下
        int count = deptScoreDAO.queryForInt("select count(1) count from pmkpi_fasp_t_pubagency t where t.guid ='"+agency+"' and t.finintorgguid ='"+ finintorgguid +"'");
        String wheresql = " t.projguid = '" + mainguid + "'";
        String tmpsql ="";
        //处室打分模式
        if("audit".equals(viewtype) || ("query".equals(viewtype) && !"allquery".equals(querytype))){
        	wheresql +=" and ( ";
        	//综合处处室标识范围
        	if(finintorgguid!=null){
        		wheresql +=" (t.finintorgguid ='"+ finintorgguid +"' and t.iscom = '1') ";
        	}else{
        		wheresql +=" 1!=1 ";
        	}
        	//业务处室权限范围
        	if(count>0){
        		wheresql +=" or t.iscom = '2'";
        	}
        	wheresql +=" ) ";
        }
        if("query".equals(viewtype) && "allquery".equals(querytype)){
        	tablecode = "perf_v_deptevalsecoresub";
        }
        String code = "";
        String wheresql1 = " t.menuid = '"+menuid+"' and t.bustype = '"+bustype+"' ";
        List<Map<String, Object>> datas = deptScoreDAO.getDatas("PERF_T_RANDOMQUALITY_MENU", wheresql1, null);
        if(datas.size() > 0){
        	Map<String, Object> map = datas.get(0);
        	code = (String) map.get("code");
        	wheresql +=" and t.code = '"+code+"'";
        	tmpsql +=" t.code = '"+code+"'";
        }else{
        	wheresql +=" and 1!=1 ";
        	tmpsql +=" 1!=1 ";
        }
        logger.debug("wheresql----------"+wheresql);
        List<Map<String, Object>>  data = deptScoreDAO.getDatas(tablecode, wheresql, "order by ordernum");
        if(data.size()<1){
        	logger.debug("tmpsql----------"+tmpsql);
        	data = deptScoreDAO.getDatas("perf_v_deptevalsecoretmp", tmpsql, "order by ordernum");
        	for (Map<String, Object> map : data) {
//        		map.put("guid", this.getCreateguid());
        		map.put("projguid", mainguid);
        		map.put("scroe", "");
        		map.put("buckle","");
        		map.put("sscroe", "");
        		map.put("sbuckle", "");
        		map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
        	}
        }
        backMap.put("data", data);
        return backMap;
    }
    
    /**
     * 保存.
     * @param params --
     * @return --
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
    	 //表名
        //String tablecode = (String) params.get("tablecode");
        String busguid = (String) params.get("busguid");
        String mainguid = (String) params.get("mainguid");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        int i = 1;
        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        for (Map<String, Object> map : datas) {
        	Map<String, Object> m = new HashMap<String, Object>();
        	m.putAll(map);
            m.put("guid", map.get("tguid")!=null ? map.get("tguid") : this.getCreateguid());
            m.put("ordernum", i++);
            m.put("vcol1", "0");
            m.put("scroe", map.get("scroe")!=null ? map.get("scroe").toString() : "");
            m.put("buckle", map.get("buckle")!=null ? ((String)map.get("buckle")).replace("<br>", "") : "");
            m.put("updatetime", StringUtil.getSysDBDate());
            addlist.add(m);
        }
        for (Map<String, Object> map : datas) {
        	Map<String, Object> mm = new HashMap<String, Object>();
        	mm.putAll(map);
        	mm.put("guid", map.get("sguid")!=null ? map.get("sguid") : this.getCreateguid());
        	mm.put("scroe", map.get("sscroe")!=null ? map.get("sscroe").toString() : "");
        	mm.put("buckle", map.get("sbuckle")!=null ? ((String)map.get("sbuckle")).replace("<br>", "") : "");
        	mm.put("ordernum", i++);
        	mm.put("vcol1", "1");
        	mm.put("updatetime", StringUtil.getSysDBDate());
        	addlist.add(mm);
        }	
        deptScoreDAO.saveAll(addlist, deptScoreDAO.PMKPI_TABLE_TMP_AGENCY);
        //删除数据
        String delsql = " t.projguid = '" + mainguid + "'";
        delsql +=" and exists(select * from "+ deptScoreDAO.PMKPI_TABLE_TMP_AGENCY+" a where a.guid =t.guid)";
        
        deptScoreDAO.delDatas("PERF_T_RANDOMQUALITY_SCORE", delsql);
        //插入数据
//        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
//        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
//        int i = 1;
//        for (Map<String, Object> map : datas) {
//        	Map<String, Object> m = new HashMap<String, Object>();
//        	m.putAll(map);
//            m.put("ordernum", i++);
//            m.put("vcol1", "0");
//            m.put("updatetime", StringUtil.getSysDBDate());
//            addlist.add(m);
//        }
//        for (Map<String, Object> map : datas) {
//        	Map<String, Object> n = new HashMap<String, Object>();
//        	n.putAll(map);
//        	n.put("guid", map.get("sguid"));
//        	n.put("scroe", map.get("sscroe"));
//        	n.put("buckle", map.get("sbuckle"));
//        	n.put("ordernum", i++);
//        	n.put("vcol1", "1");
//        	n.put("updatetime", StringUtil.getSysDBDate());
//        	addlist.add(n);
//        }
        if (addlist.size() > 0) {
        	deptScoreDAO.saveAll(addlist, "PERF_T_RANDOMQUALITY_SCORE");
        }
        return this.auditdefine(datas, busguid,"perf", null);
    }

}
