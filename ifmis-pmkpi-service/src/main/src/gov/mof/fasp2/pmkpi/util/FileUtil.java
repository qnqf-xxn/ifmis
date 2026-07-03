package gov.mof.fasp2.pmkpi.util;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.log.service.Logger;

import java.io.*;

/**
 * <p>文件工具类</p >
 *
 * @author hw
 * @date 2022/11/9 15:47
 */
public class FileUtil {
    protected static Logger logger = Logger.getLogger(FileUtil.class);


    /**
     * <p>删除文件夹</p >
     *
     * @param folderPath 文件夹完整绝对路径
     * @author hw
     * @date 2021/12/29 16:14
     */
    public static void delFolder(String folderPath) {
        logger.info("---清空临时文件夹-start-：" + folderPath);
        try {
            delAllFile(folderPath); //删除完里面所有内容
            String filePath = folderPath;
            java.io.File myFilePath = new java.io.File(filePath);
            myFilePath.delete(); //删除空文件夹
            logger.info("---清空临时文件夹-end-：" + folderPath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * <p>删除指定文件夹下所有文件</p >
     *
     * @param path 文件夹完整绝对路径
     * @author hw
     * @date 2021/12/29 16:14
     */
    public static boolean delAllFile(String path) {
        boolean flag = false;
        File file = new File(path);
        if (!file.exists()) {
            return flag;
        }
        if (!file.isDirectory()) {
            return flag;
        }
        String[] tempList = file.list();
        File temp = null;
        for (int i = 0; i < tempList.length; i++) {
            if (path.endsWith(File.separator)) {
                temp = new File(path + tempList[i]);
            } else {
                temp = new File(path + File.separator + tempList[i]);
            }
            if (temp.isFile()) {
                temp.delete();
            }
            if (temp.isDirectory()) {
                delAllFile(path + "/" + tempList[i]);//先删除文件夹里面的文件
                delFolder(path + "/" + tempList[i]);//再删除空文件夹
                flag = true;
            }
        }
        return flag;
    }

    /**
     * <p>将InputStream写入本地文件</p >
     *
     * @param destination 写入本地目录
     * @param input       输入流
     * @author hw
     * @date 2021/12/29 16:15
     */
    public static void writeToLocal(String destination, InputStream input) throws IOException {
        FileOutputStream downloadFile = null;
        int index;
        byte[] bytes = new byte[1024];
        try {
            //Linux的路径长度限制为4096字节，文件名长路限制为255字节。
            downloadFile = new FileOutputStream(destination);
            while ((index = input.read(bytes)) != -1) {
                downloadFile.write(bytes, 0, index);
                downloadFile.flush();
            }
        } catch (IOException e) {
            logger.error(e.getMessage(), e);
        } finally {
            if (input!=null){
                input.close();
            }
            if (downloadFile!=null){
                downloadFile.close();
            }
        }
    }

    /**
     * <p>重名文件名称加上时间戳</p >
     * 文件名.txt -->  文件名_20220120102049149.txt
     *
     * @param
     * @author hw
     * @date 2022/1/20 10:08
     */
    public static String renameStr(String fileName) {
        int suffixIndex = fileName.indexOf("."); // 获取后缀开始位置
        String prefix = fileName.substring(0, suffixIndex); //截取前缀
        String suffix = fileName.substring(suffixIndex); // 截取后缀
        StringBuffer rename = new StringBuffer(prefix); // 创建新名字
        rename.append("_").append(CommonUtil.getTimeStamp()).append(suffix); // 拼接新名字
        return rename.toString();
    }

    /**
     * <p>Linux文件名字节长度不得超过255的处理方法</p >
     *  ...   3字节
     * @author hw
     * @date 2022/7/5 10:29
     * @param
     */
    public static String getLinuxFilename(String filename) throws UnsupportedEncodingException {
        int length = 0;
        byte[] buff = filename.getBytes();
        length = buff.length;
        if (length >= 255) {
            logger.info("--截取前名称：" + filename);
            logger.info("--截取前字节长度：" + length);
            int suffixIndex = filename.lastIndexOf("."); // 获取后缀开始位置
            String suffixStr = "..." + filename.substring(suffixIndex); // 截取后缀
            byte[] filenameByte = new byte[246];
            /**
             * src：byte源数组
             * srcPos：截取源byte数组起始位置（0位置有效）
             * dest,：byte目的数组（截取后存放的数组）
             * destPos：截取后存放的数组起始位置（0位置有效）
             * length：截取的数据长度
             */
            System.arraycopy(buff, 0, filenameByte, 0, 246);
            filename = new String(filenameByte);
            filename = filename.substring(0, filename.length()-1);
            filename += suffixStr;
            logger.info("--截取后名称：" + filename);
            logger.info("--截取后字节长度：" + filename.getBytes().length);
        }
        return filename;
    }

}