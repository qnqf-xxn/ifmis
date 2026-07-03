package gov.mof.fasp2.pmkpi.perfcommon.file;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.annotation.Resource;
import java.util.*;
import java.util.stream.Collectors;

/**
 * @Description:
 * @Revision History:
 * @Revision 9:47 2020/8/24  chongdayong
 */
public class FileBO extends PmkpiBO {

	@Resource(name = "pmkpi.perfcommon.file.FileDAO")
	private FileDAO fileDAO = null;

	public void setFileDAO(FileDAO fileDAO) {
		this.fileDAO = fileDAO;
	}

	/**
	 * 保存附件信息
	 * @param billguid 单据guid
	 * @param fileguid 文件guid
	 * @param filetype -- 业务类型.
	 * @return 结果
	 * @throws AppException 异常
	 */
	public void saveFileData(String billguid, String fileguid, String filename, String filetype) throws AppException {
		this.fileDAO.saveFileData(billguid, fileguid, filename, filetype);
	}

	/**
	 * 保存附件信息多个
	 * @return 结果
	 * @throws AppException 异常
	 */
	public void saveFileDatas(HashMap<String, Object> params) throws AppException {
		String billguid = (String) params.get("guid");
		String filetype = (String) params.get("filetype");
		List<Map<String, Object>> filelist = fileDAO.getFileList(billguid,filetype);
		Set<String> existFileGuids = filelist.stream().map(map -> map.get("fileguid")).filter(Objects::nonNull).map(Object::toString)
				.collect(Collectors.toCollection(HashSet::new));
		String timestamp = PerfUtil.getServerTimeStamp();
		String userid = SecureUtil.getCurrentUser().getGuid();
		String username = SecureUtil.getCurrentUser().getName();
		String year = PerfUtil.getYear();
		String province = PerfUtil.getProvince();
		List<Map<String, Object>> fileobjlist = (List<Map<String, Object>>) params.get("fileobj");
		List sqlList = new ArrayList();
		for (Map<String, Object> fileobj : fileobjlist) {
			String fileguid = (String) fileobj.get("fileguid");
			if (existFileGuids.contains(fileguid)) { //已存在的附件跳过
				continue;
			}
			String filename = (String) fileobj.get("filename");
			StringBuilder vchsql = new StringBuilder();
			vchsql.append("insert into ").append(fileDAO.PMKPI_FILE_TABLE).append("(guid,billguid,fileguid,filename,creater,creatername,create_time,update_time, filetype,year,province) values ");
			vchsql.append("( '").append(StringUtil.createUUID()).append("','").append(billguid).append("','").append(fileguid).append("','").append(filename).append("','")
					.append(userid).append("','").append(username).append("','").append(timestamp).append("','").append(timestamp).append("','")
					.append(filetype).append("','").append(year).append("','").append(province).append("' )");
			sqlList.add(vchsql.toString());
		}
		this.fileDAO.batchSingleUpdate(sqlList);
	}

	/**
	 * 根据单据guid查询文件列表
	 * @return 分解数据
	 * @throws AppException 异常
	 */
	public List getFileList(HashMap params) throws AppException {
		String billid = (String) params.get("guid");
		String filetype = (String) params.get("filetype");
		String queryYear = (String)params.get("queryYear");//跨年查询查询年度
		String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
		if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
			fileDAO.setYearAndProvince(queryYear, queryProvince);
		}
		return fileDAO.getFileList(billid,filetype);
	}

	/**
	 * 删除附件信息
	 * @param fileguid 文件guid
	 * @throws AppException 异常
	 */
	public void deleteFile(String fileguid) throws AppException {
		fileDAO.deleteFile(fileguid);
	}

	/**
	 * 删除附件信息
	 * @param billguid 文件guid
	 * @throws AppException 异常
	 */
	public void deleteFileByBillguid(String billguid) throws AppException {
		fileDAO.deleteFileByBillguid(billguid);
	}

	public void deleteFileByBillguids(List<String> billguids)
			throws AppException
	{
		fileDAO.deleteFileByBillguids(billguids);
	}
	/**
	 * 更新附件信息
	 * @param billguid - 假billguid
	 * @param guids - guid数组
	 * @throws AppException
	 * @throws
	 */
	public void updateFileByBillguids(String billguid ,List<String> guids) throws AppException{
		fileDAO.updateFileByBillguids(billguid, guids);
	}

	/**
	 * 根据附件id查询附件信息
	 * @param fileguid
	 * @return
	 * @throws AppException
	 */
	public Map<String,Object> queryFileName(String fileguid) throws AppException {
		return fileDAO.queryFileName(fileguid);
	}

}
