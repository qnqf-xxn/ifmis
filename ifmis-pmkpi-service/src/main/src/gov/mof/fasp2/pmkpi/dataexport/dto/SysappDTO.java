package gov.mof.fasp2.pmkpi.dataexport.dto;

import gov.mof.fasp2.buscore.framework.dto.fasp.FaspDTO;

public class SysappDTO extends FaspDTO  {

	private static final long serialVersionUID = 1L;
	private String appid;
	private String appname;
	private String status;
	private String developer;
	public String getAppid() {
		return appid;
	}
	public void setAppid(String appid) {
		this.put("appid", appid);
	}
	public String getAppname() {
		return appname;
	}
	public void setAppname(String appname) {
		this.put("appname", appname);
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.put("status", status);
	}
	public String getDeveloper() {
		return developer;
	}
	public void setDeveloper(String developer) {
		this.put("developer", developer);
	}
	
}