/**
 * 
 */
package gov.mof.fasp2.pmkpi.perfprogram.checkindex;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.log.service.Logger;

/**
 * @ClassName: CheckIndex
 * @Description: 校验保存的指标.
 * @author fph
 * @date 2020-12-7 下午10:36:13
 */
public class CheckIndex {

	private final static Logger logger = Logger.getLogger(CheckIndex.class);
	/**
	 * 校验指标.
	 * @param indexList 指标list
	 * @return
	 */
	public Map<String, Object> CheckIndex(List<Map<String, Object>> indexList){
		Map<String, Object> remp = new HashMap<String, Object>();
		List<Map<String, Object>> tipList = new ArrayList<Map<String, Object>>();
		String tips ="";
		logger.error("------------校验指标开始-------------");
		if(indexList != null && indexList.size() > 0){
			logger.error("------------校验指标prjguid: "+ indexList.get(0).get("mainguid")+" -------------");
			for (Map<String, Object> map : indexList) {
				int ordernum = (Integer) map.get("ordernum");//序号
				String name = (String) map.get("name");//三级指标
				String indexval = (String) map.get("indexval");//指标值
				String computesign = (String) map.get("computesign");//计算符号
				String meterunit = (String) map.get("meterunit");//单位
				if (StringUtil.isEmpty(name)) {
					Map<String, Object> tipMap = new HashMap<String, Object>();
					tips = "第"+ ordernum + "行三级指标不能为空！";
					tipMap.put("remark", tips);
					tipList.add(tipMap);
				}else {
					int length = name.length(); 
					if(length > 80){
						Map<String, Object> tipMap = new HashMap<String, Object>();
						tips = "第"+ ordernum + "行三级指标长度不能多于40个字！";
						tipMap.put("remark", tips);
						tipList.add(tipMap);
					}
				}
				if (StringUtil.isEmpty(indexval)) {
					Map<String, Object> tipMap = new HashMap<String, Object>();
					tips = "第"+ ordernum + "行指标值不能为空！";
					tipMap.put("remark", tips);
					tipList.add(tipMap);
				}
				if (StringUtil.isEmpty(computesign)) {
					Map<String, Object> tipMap = new HashMap<String, Object>();
					tips = "第"+ ordernum + "行计算符号不能为空！";
					tipMap.put("remark", tips);
					tipList.add(tipMap);
				}else {
					if (!"6".equals(computesign)) {
						if (meterunit == null || meterunit.isEmpty()) {
							Map<String, Object> tipMap = new HashMap<String, Object>();
							tips = "第"+ ordernum + "行单位不能为空！";
							tipMap.put("remark", tips);
							tipList.add(tipMap);
						}
					}
				}
				/*if(tipMap.isEmpty() && tipMap == null){
					remp.put("redata", tipList);//remark
				}*/
			}
			if(tipList != null && tipList.size()>0){
				remp.put("success", false);
				remp.put("redata", tipList);
			}else {
				remp.put("success", true);
			}
		}else {
			remp.put("success", true);
		}
		
		logger.error("------------校验指标结束-------------");
		return remp;
	}
}
