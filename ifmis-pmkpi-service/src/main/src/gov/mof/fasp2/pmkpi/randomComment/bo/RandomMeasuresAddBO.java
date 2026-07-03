package gov.mof.fasp2.pmkpi.randomComment.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.randomComment.dao.RandomMeasuresAddDAO;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class RandomMeasuresAddBO extends PmkpiBO {

    private RandomMeasuresAddDAO randomMeasuresAddDAO;

    public void setRandomMeasuresAddDAO(RandomMeasuresAddDAO randomMeasuresAddDAO) {
        this.randomMeasuresAddDAO = randomMeasuresAddDAO;
    }

	public Map save(Map map) throws AppException {
		String id = map.get("guid")==null?"":map.get("guid").toString();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
		UserDTO user = SecureUtil.getCurrentUser();
		//单位id
		String useragencyguid = user.getUpagencyid()!=null ? user.getUpagencyid() : user.getAgency();
		String dept = map.get("agencyguid")==null ? useragencyguid : map.get("agencyguid").toString();
		String finintorg = "";
		String getDivsionSql = "select * from PMKPI_FASP_T_PUBAGENCY where guid='"+dept+"'";
		List divsions = randomMeasuresAddDAO.queryForList(getDivsionSql);
		if(null!=divsions&&divsions.size()>0){
			finintorg = (String)((Map)divsions.get(0)).get("finintorg");
		}
		String finintorgguid = map.get("finintorgguid")==null ? finintorg : map.get("finintorgguid").toString();
		
		if(StringUtil.isEmpty(id)){
			id = StringUtil.createUUID();
		}
		map.put("guid", id);
		map.put("measurescode", getMeasureCode(map.get("arrangement")!=null?map.get("arrangement").toString():null));
		map.put("createuid", user.getGuid());
		map.put("createuname", user.getName());
		map.put("createdate", formatter.format(new Date()));
		map.put("year", CommonUtil.getYear());
		map.put("distcode", user.getProvince());
		map.put("createyear", CommonUtil.getYear());//指标录入时间
		map.put("arealevel", getDefaultAreaLevel());//默认区域级别
		map.put("zblx", "2");//默认个性指标
		map.put("delstatus", "0");
		map.put("isaudit", "0");
		map.put("usestatus", "0");
		map.put("dist", getProvinceGuidbyCode(user.getProvince()));
		map.put("dept", dept);
		map.put("finintorgguid", finintorgguid);
	    //单位指标库状态入库标识为0未入库
		map.put("permtype", "0");
		randomMeasuresAddDAO.save(map, "PERF_T_RANDOMINDEX");
		return map;
	}   
	
	public String getDefaultAreaLevel(){
		String defaultAreaLevel="";
		List<Map> datas = randomMeasuresAddDAO.queryForList("select * from PMKPI_T_AREALEVEL where defaultValue='1'");
		if(datas!=null&&datas.size()>0){
			Map map = datas.get(0);
			defaultAreaLevel = (String)map.get("CODE");
		}
		return defaultAreaLevel;
	}
	
	
	public String getProvinceGuidbyCode(String code){
		String provinceGuid = "";
		List queryForList = randomMeasuresAddDAO.queryForList("select * from FASP_T_PUBADMDIV t where code = '"+code+"'");
		Map map = new HashMap();
		if(queryForList.size()>0){
			map = (Map) queryForList.get(0);
			provinceGuid = map.get("guid").toString();
		}
		return provinceGuid;
	}
	
	public String getMeasureCode(String parentid){
		String codesql = "SELECT PMKPI_S_BXSEQ.NEXTVAL FROM DUAL";
		int valcode = randomMeasuresAddDAO.queryForInt(codesql);
		String measureCode = "";
		UserDTO user = SecureUtil.getCurrentUser();
		String distcode = user.getProvince();
		measureCode = "BX" + distcode + getAngecyCode() + valcode;
		return measureCode;
	}
	
	public String getAngecyCode(){
		String code = "";
		UserDTO user = SecureUtil.getCurrentUser();
		List<Map> queryForList = randomMeasuresAddDAO.queryForList("SELECT DECODE(upagencyid,NULL,agency,upagencyid ) agencyid FROM fasp_t_causer where guid = '"+user.getGuid()+"'");
		if(queryForList!=null && queryForList.size()>0){
			String agencyid = (String)queryForList.get(0).get("agencyid");
			List<Map> list = randomMeasuresAddDAO.queryForList("SELECT substr(CODE, 0, 3) code FROM pmkpi_fasp_t_pubagency where guid = '"+ agencyid +"'");
			if(list!=null && list.size()>0){
				code = (String)list.get(0).get("code");
			}
		}
		return code;
	}
    
}
