package gov.mof.fasp2.pmkpi.util;

import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;

import java.io.*;
import java.util.Enumeration;
import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;

public class ZipUtils {

	/**
	 * 使用GBK编码可以避免压缩中文文件名乱码
	 */
	private static final String CHINESE_CHARSET = "GBK";

	/**
	 * 文件读取缓冲区大小
	 */
	private static final int CACHE_SIZE = 1024;

	private ZipUtils() {
		// 私用构造主法.因为此类是工具类.
	}

	public static void zip(File sourceFolder, File zipFilePath) throws Exception {
		zip(sourceFolder.getPath(), zipFilePath.getPath());
	}

	/**
	 * <p>
	 * 压缩文件
	 * </p>
	 * 
	 * @param sourceFolder
	 *            需压缩文件 或者 文件夹 路径
	 * @param zipFilePath
	 *            压缩文件输出路径
	 * @throws Exception
	 */
	public static void zip(String sourceFolder, String zipFilePath) throws Exception {
		OutputStream out = null;
		BufferedOutputStream bos = null;
		ZipOutputStream zos = null;
		try {
			out = new FileOutputStream(zipFilePath);
			bos = new BufferedOutputStream(out);
			zos = new org.apache.tools.zip.ZipOutputStream(bos);
			// 解决中文文件名乱码
			zos.setEncoding(CHINESE_CHARSET);
			File file = new File(sourceFolder);
			String basePath = null;
			if (file.isDirectory()) {
				basePath = file.getPath();
			} else {
				basePath = file.getParent();
			}
			zipFile(file, basePath, zos);
			zos.closeEntry();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (zos!=null){
				zos.close();
			}
			if (bos!=null){
				bos.close();
			}
			if (out!=null){
				out.close();
			}
		}
	}

	/**
	 * <p>
	 * 压缩文件
	 * </p>
	 * 
	 * @param sourceFolders
	 *            一组 压缩文件夹 或 文件
	 * @param zipFilePath
	 *            压缩文件输出路径
	 * @throws Exception
	 */
	public static void zip(String[] sourceFolders, String zipFilePath) throws Exception {
		OutputStream out = null;
		BufferedOutputStream bos = null;
		ZipOutputStream zos = null;
		try {
			out = new FileOutputStream(zipFilePath);
			bos = new BufferedOutputStream(out);
			zos = new org.apache.tools.zip.ZipOutputStream(bos);
			// 解决中文文件名乱码
			zos.setEncoding(CHINESE_CHARSET);
			for (int i = 0; i < sourceFolders.length; i++) {
				File file = new File(sourceFolders[i]);
				String basePath = null;
				basePath = file.getParent();
				zipFile(file, basePath, zos);
			}
			zos.closeEntry();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (zos!=null){
				zos.close();
			}
			if (bos!=null){
				bos.close();
			}
			if (out!=null){
				out.close();
			}
		}
	}

	/**
	 * <p>
	 * 递归压缩文件
	 * </p>
	 * 
	 * @param parentFile
	 * @param basePath
	 * @param zos
	 * @throws Exception
	 */
	private static void zipFile(File parentFile, String basePath, org.apache.tools.zip.ZipOutputStream zos) throws Exception {
		File[] files = new File[0];
		if (parentFile.isDirectory()) {
			files = parentFile.listFiles();
		} else {
			files = new File[1];
			files[0] = parentFile;
		}
		String pathName;
		InputStream is = null;
		BufferedInputStream bis = null;
		try {
			byte[] cache = new byte[CACHE_SIZE];
			for (File file : files) {
				if (file.isDirectory()) {
					basePath = basePath.replace('\\', '/');
					if (basePath.substring(basePath.length() - 1).equals("/")) {
						pathName = file.getPath().substring(basePath.length()) + "/";
					} else {
						pathName = file.getPath().substring(basePath.length() + 1) + "/";
					}
					zos.putNextEntry(new org.apache.tools.zip.ZipEntry(pathName));
					zipFile(file, basePath, zos);
				} else {
					pathName = file.getPath().substring(basePath.length());
					pathName = pathName.replace('\\', '/');
					if (pathName.substring(0, 1).equals("/")) {
						pathName = pathName.substring(1);
					}
					is = new FileInputStream(file);
					bis = new BufferedInputStream(is);
					zos.putNextEntry(new org.apache.tools.zip.ZipEntry(pathName));
					int nRead = 0;
					while ((nRead = bis.read(cache, 0, CACHE_SIZE)) != -1) {
						zos.write(cache, 0, nRead);
					}
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (bis!=null){
				bis.close();
			}
			if (is!=null){
				is.close();
			}
		}
	}

	/**
	 * 解压zip文件
	 * 
	 * @param zipFileName
	 *            待解压的zip文件路径，例如：c:\\a.zip
	 * 
	 * @param outputDirectory
	 *            解压目标文件夹,例如：c:\\a\
	 */
	public static void unZip(String zipFileName, String outputDirectory) throws Exception {
		ZipFile zipFile = new ZipFile(zipFileName);
		InputStream in = null;
		FileOutputStream out = null;
		try {
			Enumeration<?> e = zipFile.getEntries();
			org.apache.tools.zip.ZipEntry zipEntry = null;
			if (!new File(outputDirectory).exists()) {
				new File(outputDirectory).mkdirs();
			}
			createDirectory(outputDirectory, "");
			while (e.hasMoreElements()) {
				zipEntry = (org.apache.tools.zip.ZipEntry) e.nextElement();
				if (zipEntry.isDirectory()) {
					String name = zipEntry.getName();
					name = name.substring(0, name.length() - 1);
					File f = new File(outputDirectory + File.separator + name);
					f.mkdir();
				} else {
					String fileName = zipEntry.getName();
					fileName = fileName.replace('\\', '/');
					if (fileName.indexOf("/") != -1) {
						createDirectory(outputDirectory, fileName.substring(0, fileName.lastIndexOf("/")));
						fileName = fileName.substring(fileName.lastIndexOf("/") + 1, fileName.length());
					}
					File f = new File(outputDirectory + File.separator + zipEntry.getName());
					f.createNewFile();
					in = zipFile.getInputStream(zipEntry);
					out = new FileOutputStream(f);
					byte[] by = new byte[1024];
					int c;
					while ((c = in.read(by)) != -1) {
						out.write(by, 0, c);
					}
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (in!=null){
				in.close();
			}
			if (out!=null){
				out.close();
			}
			if (zipFile!=null){
				zipFile.close();
			}
		}
	}

	/**
	 * 创建目录
	 * 
	 * @author hezhao
	 * @Time 2017年7月28日 下午7:10:05
	 * @param directory
	 * @param subDirectory
	 */
	private static void createDirectory(String directory, String subDirectory) {
		String dir[];
		File fl = new File(directory);
		try {
			if (subDirectory == "" && fl.exists() != true) {
				fl.mkdir();
			} else if (subDirectory != "") {
				dir = subDirectory.replace('\\', '/').split("/");
				for (int i = 0; i < dir.length; i++) {
					File subFile = new File(directory + File.separator + dir[i]);
					if (subFile.exists() == false)
						subFile.mkdir();
					directory += File.separator + dir[i];
				}
			}
		} catch (Exception ex) {
		}

	}

	/**
	 * 无需解压直接读取Zip文件和文件内容
	 * 
	 * @author hezhao
	 * @Time 2017年7月28日 下午3:23:10
	 * @param file
	 *            文件
	 * @throws Exception
	 */
	public static void readZipFile(String file) throws Exception {
		java.util.zip.ZipFile zipFile = null;
		InputStream in = null;
		ZipInputStream zin = null;
		BufferedReader br = null;
		try {
			zipFile = new java.util.zip.ZipFile(file);
			in = new BufferedInputStream(new FileInputStream(file));
			zin = new ZipInputStream(in);
			ZipEntry ze;
			while ((ze = zin.getNextEntry()) != null) {
				if (ze.isDirectory()) {
				} else {
					long size = ze.getSize();
					if (size > 0) {
						br = new BufferedReader(new InputStreamReader(zipFile.getInputStream(ze)));
						String line;
						while ((line = br.readLine()) != null) {
						}

					}
				}
			}
			zin.closeEntry();
		} catch (Exception e){
			e.printStackTrace();
		} finally {
			if (in!=null){
				in.close();
			}
			if (zin!=null){
				zin.close();
			}
			if (br!=null){
				br.close();
			}
			if (zipFile!=null){
				zipFile.close();
			}
		}
	}

	// public static void main(String[] args) throws Exception {
	// try {
	// // readZipFile("D:\\new1\\文字.zip");
	//
	// // 压缩文件
	// // String sourceFolder = "D:/新建文本文档.txt";
	// // String zipFilePath = "D:/新建文本文档.zip";
	// // ZipUtil.zip(sourceFolder, zipFilePath);
	//
	// // 压缩文件夹
	// // String sourceFolder = "D:/fsc1";
	// // String zipFilePath = "D:/fsc1.zip";
	// // ZipUtil.zip(sourceFolder, zipFilePath);
	//
	// // 压缩一组文件
	// // String [] paths = {"D:/新建文本文档.txt","D:\\FastStoneCapturecn.zip","D:/new1"};
	// // zip(paths, "D:/abc.zip");
	//
	// // unZip("D:\\FastStoneCapturecn.zip", "D:/fsc2");
	// } catch (Exception e) {
	// e.printStackTrace();
	// }
	// }

	// public static void main(String[] args) throws Exception {
	// String zipFile = "D:\\home\\ppp\\pppsd\\fileupload\\2018\\12\\10\\110000002.zip";
	// ZipUtils.zip("D:\\home\\ppp\\pppsd\\fileupload\\2018\\12\\10\\f9e2c3c5a13649848060b4f0fcc0fe49", zipFile);
	// unZip(zipFile, new File(zipFile).getParent() + File.separator + new File(zipFile).getName().split("\\.")[0]);
	// }

}