package gov.mof.fasp2.pmkpi.dataexport.dto;

import gov.mof.fasp2.buscore.framework.dto.fasp.FaspDTO;


public class ExportTempdetailDTO extends FaspDTO {

	private static final long serialVersionUID = 1L;
	/**
	 * 主键
	 */
	private String guid;
	/**
	 * 字段ID
	 */
	private String columnid;
	/**
	 * 模板ID
	 */
	private String tempid;
	/**
	 * 顺序号
	 */
	private Integer ordernum;

	public String getGuid() {
		return guid;
	}
	public void setGuid(String guid) {
		 this.put("guid", guid);
	}
	public String getColumnid() {
		return columnid;
	}
	public void setColumnid(String columnid) {
		 this.put("columnid", columnid);
	}
	public String getTempid() {
		return tempid;
	}
	public void setTempid(String tempid) {
		 this.put("tempid", tempid);
	}
	public Integer getOrdernum() {
		return ordernum;
	}
	public void setOrdernum(Integer ordernum) {
		 this.put("ordernum", ordernum);
	}

}