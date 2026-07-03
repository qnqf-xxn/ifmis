package gov.mof.fasp2.pmkpi.dataexport.dto;

import gov.mof.fasp2.buscore.framework.dto.fasp.FaspDTO;

/**
 * @Title: ExportTemplateDTO.java
 * @Copyright (C) 2015 龙图软件
 * @Description: FW_T_EXPORTTEMPLATE表
 * @Revision History: 
 * @Revision 1.0 2015-8-4 康金顺
 */

public class ExportTemplateDTO extends FaspDTO {

	private static final long serialVersionUID = 1L;
	/**
	 * 主键
	 */
	private String guid;
	/**
	 * 模板编码
	 */
	private String code;
	/**
	 * 模板名称
	 */
	private String name;
	/**
	 * 分隔符号
	 */
	private String sign;
	/**
	 * 文件格式
	 */
	private String type;
	/**
	 * 是否加密
	 */
	private String encryption;
	/**
	 * 加密算法
	 */
	private String enalgorithm;
	/**
	 * 是否导出标题
	 */
	private String title;
	/**
	 * 数据源
	 */
	private String datasource;
	/**
	 * 导出条件
	 */
	private String condition;
	/**
	 * 导出结果集类
	 */
	private String resultset;
	/**
	 * FW_T_SYSAPP表的APPID
	 */
	private String appid;


	public String getGuid() {
		return guid;
	}



	public void setGuid(String guid) {
		this.put("guid", guid);
	}



	public String getCode() {
		return code;
	}



	public void setCode(String code) {
		this.put("code", code);
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.put("name", name);
	}



	public String getSign() {
		return sign;
	}



	public void setSign(String sign) {
		this.put("sign", sign);
	}



	public String getType() {
		return type;
	}



	public void setType(String type) {
		this.put("type", type);
	}



	public String getEncryption() {
		return encryption;
	}



	public void setEncryption(String encryption) {
		this.put("encryption", encryption);
	}





	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.put("title", title);
	}





	public String getEnalgorithm() {
		return enalgorithm;
	}



	public void setEnalgorithm(String enalgorithm) {
		this.put("enalgorithm", enalgorithm);
	}



	public String getDatasource() {
		return datasource;
	}



	public void setDatasource(String datasource) {
		this.put("datasource", datasource);
	}



	public String getCondition() {
		return condition;
	}



	public void setCondition(String condition) {
		this.put("condition", condition);
	}



	public String getResultset() {
		return resultset;
	}



	public void setResultset(String resultset) {
		this.put("resultset", resultset);
	}



	public String getAppid() {
		return appid;
	}



	public void setAppid(String appid) {
		this.put("appid", appid);
	}




}