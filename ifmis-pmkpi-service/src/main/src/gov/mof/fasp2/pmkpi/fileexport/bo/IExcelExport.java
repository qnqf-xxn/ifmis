package gov.mof.fasp2.pmkpi.fileexport.bo;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface IExcelExport {

	/**
	 * @Description:下载数据
	 * @param code
	 *            编码
	 * @throws Exception
	 *             异常
	 */
	public void down(String code) throws Exception;

	/**
	 * @Description: 下载数据
	 * @param code
	 *            编码
	 * @param w
	 *            查询条件
	 * @throws Exception
	 *             异常
	 */
	public void down(String code, HashMap w) throws Exception;

	public List<Map> loadData(int page, Map config);
	
	public String getFileName(Map config);
}
