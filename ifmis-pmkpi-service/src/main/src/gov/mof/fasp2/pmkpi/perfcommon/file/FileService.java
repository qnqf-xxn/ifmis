package gov.mof.fasp2.pmkpi.perfcommon.file;

import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 11:25 2020/8/25  chongdayong
 */
@PageComponent(
		serviceid = "pmkpifileManageService",
		viewid = "pmkpifileManageService",
		id = "pmkpifileManageService",
		jsObjectName = "Ext.lt.pmkpi.fileManageService")
public class FileService extends PmkpiService {
	/**
	 * 注入bo.
	 */
	@Resource(name = "pmkpi.perfcommon.file.FileBOTX")
	FileBO fileBO = null;

	public void setFileBO(FileBO fileBO) {
		this.fileBO = fileBO;
	}

	/**
	 * 组件初始化框架调用.
	 * <p>Title: loadComponent</p>
	 * <p>Description: </p>
	 * @param request
	 * @param response
	 * @param config
	 * @return
	 * @throws Exception
	 * @see gov.mof.fasp2.buscore.framework.component.AbstractComponentService#loadComponent(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.util.Map)
	 */
	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		super.loadComponent(request, response, config);
		String billguid = request.getParameter("mainguid");
		String filetype = request.getParameter("filetype");
		String viewtype = request.getParameter("viewtype");
		if (!StringUtil.isEmpty(billguid)) {
			config.put("billguid", billguid);
		}
		if (!StringUtil.isEmpty(filetype)) {
			config.put("filetype", filetype);
		}
		config.put("curuserid", SecureUtil.getCurrentUserID());
		config.put("viewtype", viewtype);
		return config;
	}

	/**
	 * 根据单据guid查询文件列表
	 * @param params -- 参数.
	 * @return 分解数据
	 * @throws AppException 异常
	 */
	public List getFileList(HashMap<String,Object> params) throws AppException {
		List list = fileBO.getFileList(params);
		return list;
	}

	/**
	 * 保存附件信息
	 * @param  params --参数
	 * @return 结果
	 * @throws AppException 异常
	 */
	public String saveFileData(HashMap<String,Object> params) throws AppException
	{
		String guid = (String) params.get("guid");
		String fileguid = (String) params.get("fileGuid");
		String filename = (String) params.get("fileName");
		String filetype = (String) params.get("filetype");
		fileBO.saveFileData(guid, fileguid, filename, filetype);
		return "保存成功";
	}

	/**
	 * 保存附件信息多个
	 * @param  params --参数
	 * @return 结果
	 * @throws AppException 异常
	 */
	public String saveFileDatas(HashMap<String,Object> params) throws AppException
	{
		fileBO.saveFileDatas(params);
		return "保存成功";
	}

	/**
	 * 删除附件信息
	 * @param params 文件guid
	 * @return 结果
	 * @throws AppException 异常
	 */
	public String deleteFile(HashMap<String, Object> params) throws AppException
	{
		String fileguid = (String) params.get("guid");
		fileBO.deleteFile(fileguid);
		return "删除成功";
	}

	/**
	 * 根据文件guid查询文件信息
	 * @param params -- 参数.
	 * @return 分解数据
	 * @throws AppException 异常
	 */
	public Map<String,Object> queryFileName(HashMap<String,Object> params) throws AppException {
		String fileguid = (String) params.get("guid");
		return fileBO.queryFileName(fileguid);
	}

}
