package gov.mof.fasp2.pmkpi.perfcommon.file;

import com.jspsmart.upload.SmartUpload;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.fileupload.FileUploadComponent;
import gov.mof.fasp2.buscore.framework.fileupload.PdfUtil;
import gov.mof.fasp2.buscore.framework.fileupload.WordUtil;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.GlobalConfig;
import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.buscore.framework.util.PathUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.cloud.framework.start.util.Constrants;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.pdmodel.PDDocumentInformation;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.*;

public class HtmlFileUploadService extends FileUploadComponent {

	private static Logger logger = Logger.getLogger(HtmlFileUploadService.class);

	String SERVERIP = "severip";

	String HTTPPORT = "httpport";

	String CONTEXTPATH = "contextpath";

	/**
	 * 获得临时文件目录
	 *
	 * @return
	 */
	public static File getFudsTempFolder() {
		String warpath = PathUtil.getWarPath();
		File doc = new File(warpath + "/fudstemp");
		if (!doc.exists()) {
			doc.mkdirs();
		}
		return doc;
	}

	private String getTempFile() {
		return getTempFile(Calendar.getInstance().getTimeInMillis() + ".fudstemp");
	}

	private String getTempFile(String filename) {
		return getFudsTempFolder() + "/" + filename;
	}

	public byte[] upload() throws Exception {

		this.getRequest().setCharacterEncoding("utf-8"); // 设置编码
		StringBuilder guidresult = new StringBuilder();
		StringBuilder nameresult = new StringBuilder();
		StringBuffer str = new StringBuffer();
		str.append("<html xmlns='http://www.w3.org/1999/xhtml'>");
		str.append("<head>");
		str.append("<meta http-equiv='Content-Type' content='text/html; charset=utf-8'/>");
		str.append("<meta http-equiv='X-UA-Compatible' content='IE=Edge,chrome=1'>");
		str.append("</head>");
		str.append("<body>");
		str.append("<script>");
		str.append("window.onload =");
		str.append("function(){");
		int sucessnum = 0;
		int failednum = 0;

//		String filenames = SecUtil.getParameter(this.getRequest(), "filenames");
//		String filenames="abc";
//		String filenames = this.getRequest().getParameter("filenames");
//		System.out.println("filenames="+filenames);
		try {
//			// 高水平的API文件上传处理
//	        ServletFileUpload upload = new ServletFileUpload(factory);
//            List<FileItem> list = (List<FileItem>) upload.parseRequest(this.getRequest());
//            for (FileItem item : list) {
//				String savefilename = getTempFile();
////			System.out.println("上传文件"+upfilename);
//				FileOutputStream fos = new FileOutputStream(savefilename);
//				byte[] bufferOut = new byte[1024 * 8];
//				int bytes = 0;
//				InputStream is = item.getInputStream();
//				// 每次读8KB数据,并且将文件数据写入到输出流中
//				while ((bytes = is.read(bufferOut)) != -1) {
//					fos.write(bufferOut, 0, bytes);
//				}
//				fos.flush();
//				fos.close();
//				is.close();
//				String upfilename = "abc";
//				guidresult.append(saveByServlet(savefilename,upfilename) + gov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMA);
//				nameresult.append(upfilename + gov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMA);
//				filenum++;
//            }

//			this.getRequest().setCharacterEncoding("utf-8");
			SmartUpload su = init();
			beforeFileUploaded(su);
			if (su.getFiles().getCount() == 0) {
				throw new RuntimeException("没有选择上传文件");
			}
			// 以下文件禁止上传
			List<String> forbiddentype = Arrays.asList(
					"jspgov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMAjspxgov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMAexegov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMAphpgov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMAaspgov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMAjsgov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMAjargov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMAcmdgov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMAbatgov.mof.fasp2.cloud.framework.start.util.Constrants.STR_SPLIT_COMMAsh");
			int maxsize = Integer.parseInt(GlobalConfig.getConfigData("BUSCOMMON_UPLOAD_MAX_MB_PMKPI", "1000"));
			int maxNameSize = Integer.parseInt(GlobalConfig.getConfigData("BUSCOMMON_UPLOAD_FILENAME", "100"));

			for (int i = 0; i < su.getFiles().getCount(); i++) {
				com.jspsmart.upload.File f = su.getFiles().getFile(i); // 获取导入文件
				String upfilename = null;
				if (StringUtils.isEmpty(f.getFileName())) {
//					if(filenames!=null&&filenames.split("-----").length>i) {
//						upfilename=filenames.split("-----")[i];
//					}else
					continue;
				} else {
					upfilename = f.getFileName();
				}
				// 检查文件文件名长度
				if (upfilename.length() > maxNameSize) {
					guidresult.append("error,");
					nameresult.append("上传文件《" + upfilename + "》的文件名超过最大长度，最大长度为" + maxNameSize + "!");
					failednum++;
					continue;
				}

				String fileType = f.getFileExt() == null ? "" : f.getFileExt().toLowerCase();
				if (forbiddentype.contains(fileType)) {
					guidresult.append("error,");
					nameresult.append("不允许上传jsp,jspx,exe,php,asp,js,jar,cmd,bat,sh类型的文件,请检查！");
					failednum++;
					continue;
				}
				// 检查文件大小
				int size = f.getSize();
				if (size > maxsize * 1000 * 1000) {
					guidresult.append("error,");
					nameresult.append("上传文件《" + upfilename + "》大小超过" + maxsize + "MB,");
					failednum++;
					continue;
				}
				String savefilename = null;
				try {
					savefilename = getTempFile();
					f.saveAs(savefilename, SmartUpload.SAVE_PHYSICAL);
					logger.error("上传文件：" + upfilename + ",使用utf8转码后为" + new String(upfilename.getBytes(), "utf-8"));
					guidresult.append(saveToFuds(savefilename, upfilename)
							+ Constrants.STR_SPLIT_COMMA);
					nameresult.append(upfilename + Constrants.STR_SPLIT_COMMA);
					sucessnum++;
				} catch (Exception e) {
					e.printStackTrace();
					guidresult.append("error,");
					nameresult.append("上传文件《" + upfilename + "》失败" + e.getMessage());
					failednum++;
				} finally {
					if (savefilename != null) {
						File tmpFile = new File(savefilename);
						if (tmpFile.exists()) {
							tmpFile.delete();
						}
					}
				}
			}

			if (guidresult.length() > 0) {
				guidresult.deleteCharAt(guidresult.length() - 1);
			}
			if (nameresult.length() > 0) {
				if (nameresult.charAt(nameresult.length() - 1) == ',') {
					nameresult.deleteCharAt(nameresult.length() - 1);
				}
			}
			str.append("alert('");
			str.append("上传完毕");
			if (sucessnum > 0) {
				str.append("，成功上传" + sucessnum + "个文件");
			}

			if (failednum > 0) {
				str.append("，上传失败" + failednum + "个文件");
			}
			str.append("!");
			String backurl = "/" + SecureUtil.getApp() + "/common/filemanage/htmlupload.jsp?tokenid=" + SecureUtil.getKey40();
			if (this.getRequest().getParameter("authorization") != null) {
				backurl += "&authorization" + this.getRequest().getParameter("authorization");
			}
//			System.out.println("上传成功后返回的url=" + backurl);
			str.append("');\r\n" + "var guidresult='" + guidresult + "';\r\n" + "var nameresult='" + nameresult
					+ "';\r\n" + "window.parent.uploadsuccess(guidresult,nameresult);\r\n" + "window.location.href='"
					+ backurl + "'}");
		} catch (Exception e) {
			// e.printStackTrace();
			str.append("var errormsg=\"" + e.getMessage() + "\";\r\n");
			str.append("alert('上传失败:'+errormsg);\r\n");
			str.append("window.parent.uploaderror(errormsg);\r\n");
			str.append("window.history.back();}");
		}

		str.append("</script>");
		str.append("</body>");
		str.append("</html>");
		return str.toString().getBytes();
	}

	private String appid = "buscommon";

	public void setAppid(String appid) {
		this.appid = appid;
	}

	private static String BUSFUDSFILEUPLOADPATH_ID = "BUSFUDSFILEUPLOADPATH";

	public String saveByServlet(String tmpfile, String filename) throws Exception {
		return saveByServlet(new FileInputStream(tmpfile), filename);
	}

	public String saveByServlet(InputStream is, String filename) throws Exception {
		String fileUploadPath = GlobalConfig.getConfigData(BUSFUDSFILEUPLOADPATH_ID, "/fileUploadServlet");
		String uploadUrl = getfudsAddress() + fileUploadPath + "?appid=" + appid + "&userid="
				+ SecureUtil.getCurrentUserID() + "&tokenid=" + SecureUtil.getKey40();
		String result = uploadApi(uploadUrl, is, filename);
		if (result.length() != 32) {
			throw new Exception("上传到文件服务器失败：" + result);
		}
		return result;
	}

	public String uploadApi(String uploadUrl, String tmpfile, String filename) throws Exception {
		return uploadApi(uploadUrl, new FileInputStream(tmpfile), filename);
	}

	/**
	 * 文件上传rest接口
	 *
	 * @param uploadUrl
	 * @param is
	 * @param filename
	 * @return
	 * @throws Exception
	 */
	public String uploadApi(String uploadUrl, InputStream is, String filename) throws Exception {
		String result = "";

		try {

			// 换行符
			final String newLine = "\r\n";
			final String boundaryPrefix = "--";
			// 定义数据分隔线
			String BOUNDARY = "========7d4a6d158c9";
			// 服务器的域名
			URL url = new URL(uploadUrl);
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();
			// 设置为POST情
			conn.setRequestMethod("POST");
			// 发送POST请求必须设置如下两行
			conn.setDoOutput(true);
			conn.setDoInput(true);
			conn.setUseCaches(false);
			// 设置请求头参数
			conn.setRequestProperty("connection", "Keep-Alive");
			conn.setRequestProperty("Charset", Constrants.STR_ENCODE_UTF8);
			conn.setRequestProperty("Content-Type", "multipart/form-data; boundary=" + BOUNDARY);

			OutputStream out = new DataOutputStream(conn.getOutputStream());

			// 上传文件

			StringBuilder sb = new StringBuilder();
			sb.append(boundaryPrefix);
			sb.append(BOUNDARY);
			sb.append(newLine);
			// 文件参数,file参数名可以随意修改(根据你要上传的文件类型)

			sb.append("Content-Disposition: form-data;name=\"file\";filename=\"" + filename + "\"" + newLine);
			sb.append("Content-Type:application/octet-stream");
			// 参数头设置完以后需要两个换行，然后才是参数内容
			sb.append(newLine);
			sb.append(newLine);

			logger.info("调用文件服务器上传接口：{},filename={}", url, filename);
			// 将参数头的数据写入到输出流中
			out.write(sb.toString().getBytes());

			// 数据输入流,用于读取文件数据
			DataInputStream in = new DataInputStream(is);
			byte[] bufferOut = new byte[1024 * 8];
			int bytes = 0;
			// 每次读8KB数据,并且将文件数据写入到输出流中
			while ((bytes = in.read(bufferOut)) != -1) {
				out.write(bufferOut, 0, bytes);
			}
			// 最后添加换行
			// out.write(newLine.getBytes());
			in.close();

			// 定义最后数据分隔线，即--加上BOUNDARY再加上--。
			byte[] end_data = (newLine + boundaryPrefix + BOUNDARY + boundaryPrefix + newLine).getBytes();
			// 写上结尾标识
			out.write(end_data);
			out.flush();
			out.close();

			// 定义BufferedReader输入流来读取URL的响应

			BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = null;
			while ((line = reader.readLine()) != null) {
				result += line; // 这里读取的是上边url对应的上传文件接口的返回值，读取出来后，然后接着返回到前端，实现接口中调用接口的方式
			}
		} catch (Exception e) {
//			System.out.println("发送POST请求出现异常！" + e);
			e.printStackTrace();
			throw e;
		}
		return result;
	}

	private String getfudsAddress() {
		Map<String, String> fudsserverinfo = getFUDSServerInfo();
		if (fudsserverinfo.get(SERVERIP) == null) {
			fudsserverinfo.put(SERVERIP, this.getRequest().getServerName());
		}
		String fudsdownbasepath = GlobalConfig.getConfigData(BUSFUDSRESTBASEPATH_ID, "/fuds");

		String fudsrest = "http://" + fudsserverinfo.get(SERVERIP) + ":" + fudsserverinfo.get(HTTPPORT)
				+ fudsdownbasepath;

//		fudsrest = "http://" + "192.168.163.128" + ":" + "9999" + contextpath;
		logger.info("将使用的的文件服务器地址为：{}", fudsrest);
		return fudsrest;

	}

	private static String BUSFUDSSERVERTYPE_ID = "BUSFUDSSERVERTYPE";

	/**
	 * 将文件保存到文件服务器
	 *
	 * @param tmpfile
	 * @param filename
	 * @return
	 * @throws Exception
	 */
	public String saveToFuds(String tmpfile, String filename) throws Exception {
		return saveToFuds(new FileInputStream(tmpfile), filename);

	}

	public String saveToFuds(InputStream is, String filename) throws Exception {
		String uploadtype = GlobalConfig.getConfigData(BUSFUDSSERVERTYPE_ID, "rest");
		if ("servlet".equalsIgnoreCase(uploadtype)) {
			return saveByServlet(is, filename);
		} else if ("rest".equalsIgnoreCase(uploadtype)) {
			return saveByRest(is, filename);
		} else
			return saveByRest(is, filename);

	}

	public String saveByRest(InputStream is, String filename) throws Exception {
		String appid = SecureUtil.getApp();
		if (appid == null) {
			appid = "buscommon";
		}
		String uploadUrl = getfudsAddress() + "/" + appid + "/file/upload?appid=" + appid + "&userid="
				+ SecureUtil.getCurrentUserID() + "&tokenid=" + SecureUtil.getKey40();
		String result = uploadApi(uploadUrl, is, filename);

		Map<String, Object> resultmap = JsonUtils.jsonToMap(result);
		if (resultmap != null && resultmap.containsKey("status")
				&& "200".equalsIgnoreCase(resultmap.get("status").toString()) && resultmap.containsKey("data")) {
			return resultmap.get("data").toString();
		} else {
			throw new Exception("上传到文件服务器失败：" + result);
		}
	}

	public String saveByRest(String tmpfile, String filename) throws Exception {
		return saveByRest(new FileInputStream(tmpfile), filename);
	}

	/**
	 * 获取文件服务器中文件的信息
	 *
	 * @param fileguid
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getFileinfoByRest(String fileguid) throws Exception {
		String geturl = getfudsAddress() + "/" + fileguid + "/info";
		logger.info("getFileinfoByRest请求路径为{}", geturl);
		URL url = new URL(geturl);
		HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
		httpUrlConn.setDoOutput(false);
		httpUrlConn.setDoInput(true);
		httpUrlConn.setUseCaches(false);
		httpUrlConn.setRequestMethod("GET");
		httpUrlConn.setRequestProperty("Charset", Constrants.STR_ENCODE_UTF8);
		httpUrlConn.connect();
		String result = "";
		BufferedReader reader = new BufferedReader(new InputStreamReader(httpUrlConn.getInputStream()));
		String line = null;
		while ((line = reader.readLine()) != null) {
			result += line; // 这里读取的是上边url对应的上传文件接口的返回值，读取出来后，然后接着返回到前端，实现接口中调用接口的方式
		}
		logger.info("getFileinfoByRest请求结果为{}", result);
		Map<String, Object> resultmap = JsonUtils.jsonToMap(result);
		if (resultmap != null && resultmap.containsKey("data")) {
			return (Map<String, Object>) ((List) resultmap.get("data")).get(0);
		}
		throw new Exception("没有获取到文件信息");
	}

	public void previewMulti(HashMap params, HttpServletResponse response) throws Exception {
		List<String> fileguids = (List<String>) params.get("fileguids");
		// 合并后的pdf文件
		List<String> tmpPdfFiles = new ArrayList<>();
		try {
			// 下载并转为pdf
			for (int i = 0; i < fileguids.size(); i++) {
				String fileguid = fileguids.get(i);
				Map<String, Object> fileinfo = getFileinfoByRest(fileguid);
				String originName = fileinfo.get("fileName").toString();
				String originFile = downFile2DiskByRest(fileguid, null);
				String tmpPdfFile = getTempFile(System.nanoTime() + ".pdf");
				// 原始文件转为pdf
				if (PdfUtil.convert2pdf(originFile, originName, tmpPdfFile)) {
					tmpPdfFiles.add(tmpPdfFile);
				}
				Thread.currentThread().sleep(1000);
			}
		} catch (Exception e) {
			e.printStackTrace();
			previewError("预览附件报错:" + e.getMessage(), response);
		}
		if (tmpPdfFiles.size() > 0) {
			// 合并pdf
			String totalPdf = PdfUtil.multiFile2pdf(tmpPdfFiles);
			String showname = tmpPdfFiles.size() + "个文件的合并预览";
			previewPdf(response, totalPdf, showname);
		} else {
			previewError("无法预览附件，只支持图片，pdf，word，excel，txt类型文件预览", response);
		}
	}

	private void previewError(String msg, HttpServletResponse response) throws IOException {
		// 输出错误提示
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");
		StringBuilder sb = new StringBuilder();
		sb.append("<html>");
		sb.append("<script>");
		sb.append("alert('");
		sb.append("无法预览附件，只支持图片，pdf，word，excel，txt类型文件预览");
		sb.append("');");
		sb.append("window.close();");
		sb.append("</script>");
		sb.append("</html>");
		response.getWriter().write(sb.toString());
		response.getWriter().flush();
	}

	/**
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public void previewFile(HashMap<String, String> params, HttpServletResponse response) throws Exception {
		String fileguid = params.get("fileguid");
		String downname = params.get("downname");
		previewFile(fileguid, downname, response);
	}

	/**
	 * 预览文件接口
	 *
	 * @param fileguid
	 * @param downname
	 * @return
	 * @throws Exception
	 */
	public void previewFile(String fileguid, String downname, HttpServletResponse response) throws Exception {
		try {
			if (StringUtils.isEmpty(downname)) {
				Map<String, Object> fileinfo = getFileinfoByRest(fileguid);
				if (fileinfo != null) {
					downname = fileinfo.get("fileName").toString();
					logger.info("预览文件名为：{}", downname);
					if (StringUtil.isEmpty(downname)) {
						throw new Exception("文件服务器上没有该文件");
					}
				}
			}
		} catch (Exception e1) {
			logger.error("获取文件名失败");
			throw e1;
		}
		String filename = downFile2DiskByRest(fileguid, downname);
		try {
			if (downname.toLowerCase().endsWith(".pdf")) {
				previewPdf(response, filename, downname);

			} else if (downname.toLowerCase().endsWith(".jpg") || downname.toLowerCase().endsWith(".gif")
					|| downname.toLowerCase().endsWith(".png") || downname.toLowerCase().endsWith(".ico")
					|| downname.toLowerCase().endsWith(".bmp") || downname.toLowerCase().endsWith(".jpeg")) {
				String fileType = downname.substring(downname.lastIndexOf(".") + 1);
				response.setContentType("image/" + fileType);
				response.setHeader("Content-Disposition",
						"inline;fileName=" + downname + ";fileName*=UTF-8''" + downname);
				OutputStream outputStream = response.getOutputStream();
				InputStream is = new FileInputStream(new File(filename));
				IOUtils.write(IOUtils.toByteArray(is), outputStream);
				is.close();
			} else if (downname.toLowerCase().endsWith(".txt")) {
				response.setContentType("text/plain");
				response.setHeader("Content-Disposition",
						"inline;fileName=" + downname + ";fileName*=UTF-8''" + downname);
				OutputStream outputStream = response.getOutputStream();
				InputStream is = new FileInputStream(new File(filename));
				IOUtils.write(IOUtils.toByteArray(is), outputStream);
				is.close();
				response.flushBuffer();
			} else if (downname.toLowerCase().endsWith(".xlsx") || downname.toLowerCase().endsWith(".xls")) {
				String pdffile = filename + ".pdf";
				PdfUtil.excel2pdf(filename, pdffile);

				previewPdf(response, pdffile, downname);
			} else if (downname.toLowerCase().endsWith(".doc") || downname.toLowerCase().endsWith(".docx")) {
				String pdffile = filename + ".pdf";
				WordUtil.word2Pdf(filename, pdffile);

				previewPdf(response, pdffile, downname);
			} else {
				throw new Exception("文件" + downname + "不支持预览,只支持图片、pdf,word,excel,txt文件预览！");
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	private void previewPdf(HttpServletResponse response, String pdffile, String pdfshowname) throws Exception {
		response.setHeader("Content-Type", "application/" + "pdf");
		PDDocument pdd = PDDocument.load(new File(pdffile));
		response.setHeader("Content-Disposition",
				"inline;fileName=" + encode(pdfshowname) + ";fileName*=UTF-8''" + encode(pdfshowname));
		PDDocumentInformation information = pdd.getDocumentInformation();
		information.setTitle(pdfshowname);
//		OutputStreamWapper outputStreamWapper = new OutputStreamWapper(response.getOutputStream());
//		pdd.save(outputStreamWapper);
		pdd.save(response.getOutputStream());
		response.flushBuffer();
	}

	/**
	 * URL encode推荐方法
	 *
	 * @param value
	 * @return
	 */
	public static String encode(String value) {
		String encoded = "";
		try {
			encoded = URLEncoder.encode(value, "UTF-8");
		} catch (UnsupportedEncodingException ignore) {
		}
		StringBuffer buf = new StringBuffer(encoded.length());
		char focus;
		for (int i = 0; i < encoded.length(); i++) {
			focus = encoded.charAt(i);
			if (focus == '*') {
				buf.append("%2A");
			} else if (focus == '+') {
				buf.append("%20");
			} else if (focus == '%' && (i + 1) < encoded.length() && encoded.charAt(i + 1) == '7'
					&& encoded.charAt(i + 2) == 'E') {
				buf.append('~');
				i += 2;
			} else {
				buf.append(focus);
			}
		}
		return buf.toString();
	}

	/**
	 * 下载文件接口
	 *
	 * @param fileguid
	 * @param downname
	 * @return
	 * @throws Exception
	 */
	public InputStream downFile(String fileguid, String downname) throws Exception {

		String uploadtype = GlobalConfig.getConfigData(BUSFUDSSERVERTYPE_ID, "rest");
		if ("servlet".equalsIgnoreCase(uploadtype)) {
			return downFileByServlet(fileguid, downname);
		} else if ("rest".equalsIgnoreCase(uploadtype)) {
			return downFileByRest(fileguid, downname);
		} else
			return downFileByRest(fileguid, downname);
	}

	/**
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public InputStream downFile(HashMap<String, String> params) throws Exception {
		String fileguid = params.get("fileguid");
		String downname = params.get("downname");
		return downFile(fileguid, downname);
	}

	private static String BUSFUDSFILEDOWNPATH_ID = "BUSFUDSFILEDOWNPATH";

	public InputStream downFileByServlet(HashMap<String, String> params) throws Exception {
		String fileguid = params.get("fileguid");
		String downname = params.get("downname");
		return downFileByServlet(fileguid, downname);
	}

	/**
	 * 以servlet方式下载文件
	 *
	 * @param fileguid
	 * @param downname
	 * @return
	 * @throws Exception
	 */
	public InputStream downFileByServlet(String fileguid, String downname) throws Exception {
		InputStream inputStream = null;
		FileOutputStream fos = null;
		try {

			String filDownloadPath = GlobalConfig.getConfigData(BUSFUDSFILEDOWNPATH_ID, "/fileDownloadServlet");
			String downloadUrl = getfudsAddress() + filDownloadPath + "?FUDSfileGuid=" + fileguid + "&tokenid="
					+ SecureUtil.getKey40();
			URL url = new URL(downloadUrl);
			HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
			httpUrlConn.setDoOutput(false);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			httpUrlConn.setRequestMethod("GET");
			httpUrlConn.connect();
			try {
				if (StringUtils.isEmpty(downname)) {
					Map<String, Object> fileinfo = getFileinfoByRest(fileguid);
					if (fileinfo != null) {
						downname = fileinfo.get("fileName").toString();
					}
				}
			} catch (Exception e1) {
				logger.error("获取文件名失败");
				String Disposition = httpUrlConn.getHeaderField("Content-Disposition");
				if (Disposition != null && Disposition.indexOf("=") > 0) {
					// 原始提取的文件名
					String rawFileName = Disposition.substring(Disposition.indexOf("=") + 1, Disposition.length());
					try {
						downname = new String(rawFileName.getBytes("ISO-8859-1"), "gbk");
					} catch (UnsupportedEncodingException e) {
						downname = rawFileName;
					}
				}
				if (downname == null)
					downname = "未知文件";
			}

			// ========== 修复开始：文件名安全校验和路径规范化 ==========
			// 1. 对文件名进行安全校验，移除路径遍历字符
			downname = this.sanitizeFileName(downname);

			// 2. 获取安全的临时文件目录
			File safeTempDir = getFudsTempFolder();

			// 3. 使用安全的文件名构建路径，并验证最终路径是否仍在允许的目录内
			File targetFile = new File(safeTempDir, downname);
			String canonicalTargetPath = targetFile.getCanonicalPath();
			String canonicalTempDirPath = safeTempDir.getCanonicalPath();

			// 4. 路径遍历防护：确保规范化后的路径仍然在临时目录下
			if (!canonicalTargetPath.startsWith(canonicalTempDirPath + File.separator)
					&& !canonicalTargetPath.equals(canonicalTempDirPath)) {
				logger.error("检测到路径遍历攻击尝试！原始文件名: {}, 解析后路径: {}", downname, canonicalTargetPath);
				throw new SecurityException("非法的文件路径");
			}
			// ========== 修复结束 ==========

			this.getResponse().addHeader("Content-Disposition",
					"attachment; filename=" + new String(downname.getBytes("gbk"), "ISO-8859-1"));
			this.getResponse().setContentType("application/octet-stream");
			inputStream = httpUrlConn.getInputStream();

			// 使用经过安全校验的文件名
			String filename = targetFile.getAbsolutePath();
			fos = new FileOutputStream(filename);
			int i = 0;
			byte[] b = new byte[1024];
			i = inputStream.read(b);
			while (i > 0) {
				fos.write(b, 0, i);
				i = inputStream.read(b);
			}
			// 释放资源
			fos.flush();
			httpUrlConn.disconnect();
			return new FileInputStream(filename);

		} catch (Exception e) {
			logger.error("下载文件出错：", e);
			throw e;
		} finally {
			if (inputStream != null) {
				inputStream.close();
			}
			if (fos != null) {
				fos.close();
			}
		}
	}

	/**
	 * 文件名安全过滤方法
	 * 移除路径遍历字符、非法字符，确保文件名安全
	 *
	 * @param fileName 原始文件名
	 * @return 安全处理后的文件名
	 */
	private String sanitizeFileName(String fileName) {
		if (StringUtils.isEmpty(fileName)) {
			return "unknown_file_" + System.currentTimeMillis();
		}

		// 1. 替换路径遍历字符
		String safeName = fileName;
		// 移除 .. 路径遍历
		safeName = safeName.replace("..", "");
		// 移除 . 开头的隐藏文件
		if (safeName.startsWith(".")) {
			safeName = safeName.substring(1);
		}

		// 2. 移除或替换所有操作系统路径分隔符
		safeName = safeName.replace("/", "_");
		safeName = safeName.replace("\\", "_");
		safeName = safeName.replace(":", "_");

		// 3. 移除可能用于注入的特殊字符
		safeName = safeName.replaceAll("[\\?*%<>|\\\"']", "_");

		// 4. 移除空字符和换行符
		safeName = safeName.replaceAll("[\\x00-\\x1f]", "");

		// 5. 限制文件名长度（防止过长文件名导致的问题）
		int maxFileNameLength = 255;
		if (safeName.length() > maxFileNameLength) {
			String extension = "";
			int lastDotIndex = safeName.lastIndexOf(".");
			if (lastDotIndex > 0 && lastDotIndex < safeName.length() - 1) {
				extension = safeName.substring(lastDotIndex);
				safeName = safeName.substring(0, maxFileNameLength - extension.length() - 1);
			} else {
				safeName = safeName.substring(0, maxFileNameLength);
			}
			safeName = safeName + extension;
		}

		// 6. 如果最终结果为空，生成一个随机文件名
		if (StringUtils.isEmpty(safeName) || safeName.trim().isEmpty()) {
			safeName = "safe_file_" + System.currentTimeMillis();
		}

		logger.debug("文件名安全过滤: 原始={}, 过滤后={}", fileName, safeName);
		return safeName;
	}

	private static String BUSFUDSRESTBASEPATH_ID = "BUSFUDSRESTBASEPATH";

	/**
	 * 使用rest接口下载文件
	 *
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public InputStream downFileByRest(HashMap<String, String> params) throws Exception {
		String fileguid = params.get("fileguid");
		String downname = params.get("downname");
		return downFileByRest(fileguid, downname);
	}

	public String getFileName(String fileguid) {
		String fileName = null;
		try {
			fileName = getFileinfoByRest(fileguid).get("fileName").toString();
		} catch (Throwable e1) {
			logger.error("获取fuds文件名失败");
			throw new RuntimeException("获取fuds文件名失败");
		}
		return fileName;
	}

	/**
	 * @param fileguid 文件guid
	 * @param downname 下载文件名，如果为空，则以文件服务器中的名字为准
	 * @return
	 * @throws Exception
	 */
	public String downFile2DiskByRest(String fileguid, String downname) throws Exception {
		InputStream inputStream = null;
		FileOutputStream fos = null;
		try {
			// "http://127.0.0.1:9003/buscommon/v1/file/downloadfile";//http://192.168.22.122:19508/fuds/file/F83112C49ED8C17BB569A03CBF55F76A/download?tokenid=B4E9C32BADB81AC1E0530100007F5914Q1AM6Vdt
			String downloadUrl = getfudsAddress() + "/file/" + fileguid + "/download?tokenid=" + SecureUtil.getKey40();
			URL url = new URL(downloadUrl);
			HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
			httpUrlConn.setDoOutput(false);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			httpUrlConn.setRequestMethod("GET");
			httpUrlConn.connect();
			inputStream = httpUrlConn.getInputStream();
			String filename = getTempFile(
//					fileguid + "-----" + downname + "" + Calendar.getInstance().getTimeInMillis());
					fileguid + "-----" + Calendar.getInstance().getTimeInMillis());
			fos = new FileOutputStream(filename);
			int i = 0;
			int contentLength = 0;
			byte[] b = new byte[1024];
			i = inputStream.read(b);
			contentLength += i;
			while (i > 0) {
				fos.write(b, 0, i);
				i = inputStream.read(b);
				contentLength += i;
			}
//			this.getResponse().addHeader("Content-Length",String.valueOf(contentLength));
//			this.getResponse().addHeader("contentlength",String.valueOf(contentLength));
			fos.flush();
			// 释放资源
			httpUrlConn.disconnect();
			return filename;

		} catch (Exception e) {
			logger.error("下载文件出错：" + e);
			throw e;
		} finally {
			if (inputStream != null) {
				inputStream.close();
			}
			if (fos != null) {
				fos.close();
			}
		}
	}
	public InputStream downFileByRest(String fileguid, String downname) throws Exception {
		return downFileByRest(fileguid, downname, true);
	}

	/**
	 * @param fileguid 文件guid
	 * @param downname 下载文件名，如果为空，则以文件服务器中的名字为准
	 * @return
	 * @throws Exception
	 */
	public InputStream downFileByRest(String fileguid, String downname,boolean writeHeader) throws Exception {
		Map<String, Object> fileinfo = getFileinfoByRest(fileguid);
		if (fileinfo == null || fileinfo.size() == 0) {
			throw new Exception("从文件服务器获取guid=" + fileguid + "的文件信息为空");
		}
		String filesizeStr = fileinfo.get("fileSize").toString();
		if ("0".equals(filesizeStr)) {
			throw new Exception("从文件服务器获取guid=" + fileguid + "的文件大小为0");
		}
		if (StringUtils.isEmpty(downname) || "null".equals(downname)) {
			downname = fileinfo.get("fileName").toString();
		}

		String filename = URLEncoder.encode(downname,
				Constrants.STR_ENCODE_UTF8);
		filename = filename.replace("+","%20");
		if(writeHeader) {
			this.getResponse().addHeader("Content-Disposition", "attachment; filename=" + filename);
			this.getResponse().addHeader("filename", filename);
			logger.info("下载的文件名为{}",filename);
			this.getResponse().setContentType("application/octet-stream");
		}

		InputStream inputStream = null;
		OutputStream fos = null;
		try {
			// "http://127.0.0.1:9003/buscommon/v1/file/downloadfile";//http://192.168.22.122:19508/fuds/file/F83112C49ED8C17BB569A03CBF55F76A/download?tokenid=B4E9C32BADB81AC1E0530100007F5914Q1AM6Vdt
			String downloadUrl = getfudsAddress() + "/file/" + fileguid + "/download?tokenid=" + SecureUtil.getKey40();
			URL url = new URL(downloadUrl);
			HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
			httpUrlConn.setDoOutput(false);
			httpUrlConn.setDoInput(true);
			httpUrlConn.setUseCaches(false);
			httpUrlConn.setRequestMethod("GET");
			httpUrlConn.connect();
			inputStream = httpUrlConn.getInputStream();
			fos = new ByteArrayOutputStream();
			int i = 0;
			byte[] b = new byte[1024];
			i = inputStream.read(b);
			while (i > 0) {
				fos.write(b, 0, i);
				i = inputStream.read(b);
			}

			fos.flush();
			// 释放资源
			httpUrlConn.disconnect();
			byte[] body = ((ByteArrayOutputStream) fos).toByteArray();
			int contentLength = body.length;
			if(writeHeader) {
				this.getResponse().addHeader("Content-Length", String.valueOf(contentLength));
				this.getResponse().addHeader("contentlength", String.valueOf(contentLength));
			}
			return new ByteArrayInputStream(body);

		} catch (Exception e) {
			logger.error("下载文件出错：", e);
			throw e;
		} finally {
			if (inputStream != null) {
				inputStream.close();
			}
			if (fos != null) {
				fos.close();
			}
		}
		// return new FileInputStream(downFile2DiskByRest(fileguid, downname));
	}

	private static final String GLOBAL_CONFIG_FUDS_SERVER_HTTP_IP = "FUDSSERVERHTTPIP";
	private static final String GLOBAL_CONFIG_FUDS_SERVER_HTTP_PORT = "FUDSSERVERHTTPPORT";
	private static final String GLOBAL_CONFIG_FUDS_SERVER_HTTP_CONTEXT = "FUDSSERVERHTTPCONTEXT";

	public Map<String, String> getFUDSServerInfo() {

		Map<String, String> server = null;
		String httpport = null;
		try {
			if (GlobalConfig.getConfig("BUS" + GLOBAL_CONFIG_FUDS_SERVER_HTTP_PORT).size() > 0) {
				httpport = GlobalConfig.getConfigData("BUS" + GLOBAL_CONFIG_FUDS_SERVER_HTTP_PORT);
			} else {
				httpport = GlobalConfig.getConfigData(GLOBAL_CONFIG_FUDS_SERVER_HTTP_PORT);
			}
		} catch (Exception e) {
		}
		// httpport="7001";
		if (httpport == null)
			httpport = "";
		// 如果系统参数中配置了fuds服务器的http请求端口，则不使用远程查询

		server = new HashMap<String, String>();
		server.put(HTTPPORT, httpport);
		String httpip = null;
		try {
			if (GlobalConfig.getConfig("BUS" + GLOBAL_CONFIG_FUDS_SERVER_HTTP_IP).size() > 0) {
				httpip = GlobalConfig.getConfigData("BUS" + GLOBAL_CONFIG_FUDS_SERVER_HTTP_IP);
			} else {
				httpip = GlobalConfig.getConfigData(GLOBAL_CONFIG_FUDS_SERVER_HTTP_IP);
			}

		} catch (Exception e) {
		}
		// httpip="127.0.0.1";
		if (httpip != null) {
			// 如果系统参数中配置了fuds服务器的http请求ip，则使用此ip
			server.put(SERVERIP, httpip);
		} else {
			// 如果没有配置，则使用当前请求的ip
//            server.put(SERVERIP, this.getRequest().getServerName());
		}
		String httpcontext = null;
		try {
			if (GlobalConfig.getConfig("BUS" + GLOBAL_CONFIG_FUDS_SERVER_HTTP_CONTEXT).size() > 0) {
				httpcontext = GlobalConfig.getConfigData("BUS" + GLOBAL_CONFIG_FUDS_SERVER_HTTP_CONTEXT);
			} else {
				httpcontext = GlobalConfig.getConfigData(GLOBAL_CONFIG_FUDS_SERVER_HTTP_CONTEXT);
			}

		} catch (Exception e) {
		}
		if (httpcontext != null) {
			// 如果系统参数中配置了fuds服务器的http context，则为使用此context
			server.put(CONTEXTPATH, httpcontext);
		} else {
			// 如果没有配置，则为空
			server.put(CONTEXTPATH, "");
		}

		// userid暂时先用zk
		UserDTO user = SecureUtil.getCurrentUser();
		String userguid = null;
		if (user != null && user.getGuid() != null) {
			userguid = user.getGuid();
			server.put("currentuserid", userguid);
			// throw new AppException(FUDSException.C10770006, FUDSException.M10770006);
		} else {
			server.put("currentuserid", Constrants.STR_NULL);
		}
		return server;
	}

	public boolean deleteFile(String fileguid) throws Exception {
		String uploadtype = GlobalConfig.getConfigData(BUSFUDSSERVERTYPE_ID, "rest");
		if ("servlet".equalsIgnoreCase(uploadtype)) {
			throw new Exception("不支持servlet方式删除文件服务器文件，请检查参数" + BUSFUDSSERVERTYPE_ID + ",设置为rest");
		} else if ("rest".equalsIgnoreCase(uploadtype)) {
			return deleteFileByRest(fileguid);
		} else
			return deleteFileByRest(fileguid);

	}

	public boolean deleteFileByRest(String fileguid) throws Exception {
		String delurl = getfudsAddress() + "/del/" + fileguid + "?tokenid=" + SecureUtil.getKey40();
		URL url = new URL(delurl);
		HttpURLConnection httpUrlConn = (HttpURLConnection) url.openConnection();
		httpUrlConn.setDoOutput(false);
		httpUrlConn.setDoInput(true);
		httpUrlConn.setUseCaches(false);
		httpUrlConn.setRequestMethod("GET");
		httpUrlConn.setRequestProperty("Charset", Constrants.STR_ENCODE_UTF8);
		httpUrlConn.connect();
		String result = "";
		BufferedReader reader = new BufferedReader(new InputStreamReader(httpUrlConn.getInputStream()));
		String line = null;
		while ((line = reader.readLine()) != null) {
			result += line; // 这里读取的是上边url对应的上传文件接口的返回值，读取出来后，然后接着返回到前端，实现接口中调用接口的方式
		}
		if (result != null) {
			return true;
		}
		return false;
	}
}
