package gov.mof.fasp2.pmkpi.rectification.controller;

import freemarker.template.Template;
import freemarker.template.TemplateException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.DocumentEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.Map;

@RestController
@RequestMapping("/pmkpi/ueditor/export")
public class UeditorExpService {

    private final static Logger logger = Logger.getLogger(UeditorExpService.class);

    /**
     * Ueditor导出world.
     */
    @ResponseBody
    @RequestMapping(value = "expdoc", produces = {"text/html;charset=utf-8"})
    public String UeditorExpdoc(@RequestParam("content") String content, HttpServletRequest request, HttpServletResponse response) throws PerfAppException, IOException {
        ServletOutputStream ostream = null;
        POIFSFileSystem poifs = null;
        ByteArrayInputStream bais = null;
        try {
            //word内容
            //String content = content;
            byte b[] = content.getBytes("utf-8");  //这里是必须要设置编码的，不然导出中文就会乱码。
            bais = new ByteArrayInputStream(b);//将字节数组包装到流中
            /* 关键地方、成word格式 */
            poifs = new POIFSFileSystem();
            DirectoryEntry directory = poifs.getRoot();
            DocumentEntry documentEntry = directory.createDocument("WordDocument", bais);
            //输出文件
            request.setCharacterEncoding("utf-8");
            response.setContentType("application/msword");//导出word格式
            response.addHeader("Content-Disposition", "attachment;filename=" +
                    new String("aaaaa".getBytes("GB2312"), "iso8859-1") + ".doc");
            ostream = response.getOutputStream();
            poifs.writeFilesystem(ostream);
            return "成功";
        } catch (Exception e) {
            e.printStackTrace();
            return "失败";
        } finally {
            try {
                if (bais != null) {
                    bais.close();
                }
                if (ostream != null) {
                    ostream.close();
                }
                if (poifs != null) {
                    poifs.close();
                }
            } catch (Exception ex) {

            }
        }
    }

    private byte[] getByteData(Template t, Map<String, Object> dataMap) throws IOException, TemplateException {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        OutputStreamWriter osWriter = new OutputStreamWriter(bos, "UTF-8");
        Writer writer = new BufferedWriter(osWriter);
        t.process(dataMap, writer);
        byte[] aaa = bos.toByteArray();
        osWriter.close();
        writer.close();
        bos.close();
        return aaa;
    }
}
