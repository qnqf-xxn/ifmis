package gov.mof.fasp2.pmkpi.randomComment.bo;

import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.DbTypeUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.randomComment.dao.RandomChooseMeasuresAddDAO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RandomChooseMeasuresAddBO extends PmkpiBO {

    private RandomChooseMeasuresAddDAO randomChooseMeasuresAddDAO;

    public void setRandomChooseMeasuresAddDAO(RandomChooseMeasuresAddDAO randomChooseMeasuresAddDAO) {
        this.randomChooseMeasuresAddDAO = randomChooseMeasuresAddDAO;
    }

    public Map<String, Object> getDatas(HashMap<String, Object> sqlmap) throws AppException {
    	StringBuffer sb = new StringBuffer();
		String keyguid = (String)sqlmap.get("keyguid");
		String arrangement = (String) sqlmap.get("arrangement");
		UserDTO user = SecureUtil.getCurrentUser();

		String dept=user.getUpagencyid()!=null ? user.getUpagencyid() : user.getAgency();
		String projsql = "select * from V_PERF_PROJECT_INFO where guid = '"+keyguid+"' ";
		List projlist = randomChooseMeasuresAddDAO.queryForList(projsql);
    	if(projlist!=null && projlist.size() > 0){
			Map strmap = (Map)projlist.get(0);
			dept = (String)strmap.get("agencyguid");
    	}
        //处理性能加载慢问题，先获取单位的的父级 ，然后获取父级下的所有单位.
        String supagency = "";
        List<DicRangeDTO> rangeDTOList =  PerfServiceFactory.getIDataSetService().getRangesByWhereSql("BUDGETATEGORY", " guid = '"+dept+"'");
        if(rangeDTOList.size()>=1){
            DicRangeDTO rDto = rangeDTOList.get(0);
            supagency = rDto.getSuperguid();
        }
        sb.append(" select * from (");
        //更新 部门指标库（本单位所属部门下所有单位已入库指标） ，在选择指标可展示 -20200529hz  入库标识 permtype   清理标识 cleanstatus
        sb.append(" SELECT * FROM v_bas_perf_indicator t ");
        if(!"edb".equals(DbTypeUtil.getCurrentDBType())){
            sb.append(" and exists(select 1 from pmkpi_fasp_t_pubagency a where a.superid = '"+supagency+"' and t.AGENCYGUID = a.guid)");
        }else{
            sb.append(" and AGENCYGUID = any(array(select a.guid from pmkpi_fasp_t_pubagency a where a.superid = '"+supagency+"')) ");
        }
        sb.append("  and permtype = '1' and (cleanstatus is null or cleanstatus = '0')");
        sb.append(") where 1 = 1 ");

		if (!org.apache.commons.lang.StringUtils.isEmpty(arrangement)) {
            sb.append(" and SINDEX = '"+arrangement+"'");
		}
        sb.append(" ORDER BY ORDERNUM ");
		
		logger.error("--------------sql : " + sb.toString());
        List<Map<String, Object>> data = randomChooseMeasuresAddDAO.queryForList(sb.toString());
    	Map<String, Object> backMap = new HashMap<String, Object>();
        if(data.size() > 0){
        	backMap.put("data", data);
        }
        return backMap;
    }
    
}
