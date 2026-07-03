package gov.mof.fasp2.pmkpi.perfcommon.fileexp;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.fileupload.HtmlFileUploadService;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

public class FileExpBO extends PmkpiBO {

    private PmkpiDAO pmkpiDAO;

    public PmkpiDAO getPmkpiDAO() {
        if(pmkpiDAO == null){
            pmkpiDAO = (PmkpiDAO) ServiceFactory.getBean("pmkpi.common.PmkpiDAO");
        }
        return pmkpiDAO;
    }

    private HtmlFileUploadService htmlFileUploadService;

    public HtmlFileUploadService getHtmlFileUploadService() {
        if(htmlFileUploadService == null){
            htmlFileUploadService = (HtmlFileUploadService) ServiceFactory.getBean("buscore.fudsclient.htmluploadservice");
        }
        return htmlFileUploadService;
    }
    /**
     * 批量导出附件
     * @param config
     * @return
     */
    public List<Map<String, Object>> indexFileExp(HashMap config) throws Exception {
        String fileexptype = (String) config.get("fileexptype"); // trace 监控，self 自评 finevaluation 财政评价
        HashMap<String, Object> resultMap = null;
        List<Map<String, Object>> resultList = new ArrayList();
        String filter = (String) config.get("filter");
        logger.info("---批量导出绩效指标附件 类型："+fileexptype+" start ...");
        List<HashMap> list = (List<HashMap>) config.get("list");
        String filetype = (String) config.get("bustype");
        for (HashMap map1 : list) {
            String mainguid = (String) map1.get("guid");
            String proname = (String) map1.get("name");
            String prcode = (String) map1.get("code");
            String agency = (String) map1.get("agency");
            String proguid = (String) map1.get("proguid");
            String taskstage = "";
            if("trace".equals(fileexptype)) {//监控
                taskstage = (String) map1.get("taskstage");
            }
            String filetypename = "";
            String otherfiletype = "";
            String frametype = "";
            List<Map<String, Object>> fileInfoList = null;
            if ("protracetraceindexfile".equals(filetype)) {//拼接一级文件夹名称 和 确定通用附件类型
                filetypename = "["+prcode+"]"+agency+"-"+proname+" 监控附件"; //[项目编码]单位名称-项目名称 监控附件
                otherfiletype = "traceproreport";
                frametype = "PM001";
            } else if("depttracetraceindexfile".equals(filetype)){
                filetypename = "["+agency+"]"+proname+" 监控附件"; //[部门编码]部门名称 监控附件
                otherfiletype = "tracedeptreport";
                frametype = "DEPT";
            } else if ("programselfindexfile".equals(filetype) || "transprogramselfindexfile".equals(filetype) || "parentprogramselfindexfile".equals(filetype)) {
                filetypename = "["+prcode+"]"+agency+"-"+proname+" 自评附件"; //[项目编码]单位名称-项目名称 自评附件
                otherfiletype = "perfselfapplyedit";
                frametype = "PM001";
            } else if("deptselfindexfile".equals(filetype)){
                filetypename = "["+agency+"]"+proname+" 自评附件"; //[部门编码]部门名称 自评附件
                otherfiletype = "perfselfapplydeptedit";
                frametype = "DEPT";
            } else if("programevaluation".equals(filetype)){
                filetypename = "["+prcode+"]" + agency + "-" + proname; //[项目编码]部门名称 自评附件
            } else if ("programfinevalindexfile".equals(filetype)) {
//                filetypename = "["+prcode+"]"+agency+"-"+proname+" 财政评价附件"; //[项目编码]单位名称-项目名称 财政评价附件
                filetypename = agency+"-"+proname+" 财政评价附件"; //20240413 修改去掉项目编码 单位名称-项目名称 财政评价附件
                otherfiletype = "finevaproresult";
                frametype = "PM001";
            } else if ("deptfinevalindexfile".equals(filetype)) {
                filetypename = "["+agency+"]"+proname+" 财政评价附件"; //[部门编码]部门名称 财政评价附件
                otherfiletype = "finevadeptproresult";
                frametype = "DEPT";
            } else if ("programdeptevaluationfile".equals(filetype)) {
                filetypename = "["+prcode+"]"+agency+"-"+proname+" 部门评价附件"; //[项目编码]单位名称-项目名称 财政评价附件
                otherfiletype = "deptevaproresult";
                frametype = "PM001";
            } else if ("deptdeptevaluationfile".equals(filetype)) {
                filetypename = "["+prcode+"]"+proname+" 部门评价附件"; //[部门编码]部门名称 财政评价附件
                otherfiletype = "deptevadeptresult";
                frametype = "DEPT";
            } else if ("appraisalfile".equals(filetype)) {
                filetypename = agency + "-" + proname; //[部门编码]部门名称 绩效考核附件
            } else if("problemtaskfeedback".equals(filetype)){
                filetypename = "["+proname+"]" + agency; //[任务名称]部门名称 任务附件
                otherfiletype = "problemtaskfeedback";
            } else if ("subprovinceworkevalfile".equals(filetype)) {
                filetypename = "["+proname+"] 下级财政绩效管理工作考核附件"; //[名称] 下级财政绩效管理工作考核附件
                otherfiletype = "subprovinceworkeval";
            } else if("deptworkevalfile".equals(filetype)){
                filetypename = "["+prcode+"]"+proname+" 部门整体绩效管理工作考核附件"; //[部门编码]部门名称 部门整体绩效管理工作考核附件
                otherfiletype = "deptworkeval";
            } else if("deptperfevalTJ_file".equals(filetype)){
                filetypename = "["+agency+"]"+proname+" 部门绩效评价情况附件"; //[部门编码-部门名称] 评价项目名称 部门绩效评价情况附件
                otherfiletype = "deptperfevalTJ_file";
            }
            StringBuffer sql = new StringBuffer(); //查询项目下所有附件
            if ("trace".equals(fileexptype)) {//监控附件查询
                sql.append("select (select f.name from v_perf_t_frame f where f.guid = b.SINDEX and f.frametype='").append(frametype).append("') as sindexname,b.name,a.* from v_perf_file a left join v_perf_t_proindextrace b on a.billguid = (b.guid || b.mainguid) where b.mainguid = '").append(mainguid).append("'")
                        .append(" and a.filetype = '").append(filetype).append("'");//指标附件
                sql.append("union all select '' as sindexname,'上传附件' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype in (select guid from perf_filetype where bustype = '").append(otherfiletype).append("' )");//其他附件
            } else if("self".equals(fileexptype)) {//自评附件查询
                sql.append("select (select f.name from (select guid,name from v_perf_t_frame where frametype='").append(frametype).append("' union all select guid,name from v_perf_t_selfframe) f where f.guid = b.SINDEX) as sindexname,b.name,a.* from v_perf_file a left join v_perf_t_selfperfindex b on a.billguid = (b.guid || b.mainguid) where b.mainguid = '").append(mainguid).append("'")
                        .append(" and a.filetype = '").append(filetype).append("'");//指标附件
                sql.append("union all select '' as sindexname,'上传附件' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype in (select guid from perf_filetype where bustype = '").append(otherfiletype).append("' )");//其他附件
            } else if ("evaluation".equals(fileexptype)) {
                //DE9176-事前绩效评估报告（单位）
                //DE9177-事前绩效评估报告（财政）
                sql.append("select t2.name as name, t.filecontent as fileguid,t.filename from pm_filecontents t ")
                .append("left join v_pm_attachment t1 on t1.guid = t.attachguid ")
                .append("left join v_pm_t_dicattachtype t2 on t2.guid = t1.attachtype ")
                .append("where t1.proguid = '").append(proguid).append("'");
                if (!StringUtil.isEmpty(filter)) {
                    sql.append(" and t2.guid in(").append(filter).append(")");
                }
//                sql.append("select '上传附件' as name,a.* from v_perf_file a where a.billguid = '").append(proguid).append("'");
            } else if("finevaluation".equals(fileexptype)) {//财政评价附件查询
                sql.append("select '' as sindexname,'上传附件' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype in (select guid from perf_filetype where bustype = '").append("finevapro").append("' )");//项目附件-项目支出
                sql.append("union all select '' as sindexname,'上传附件' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype in (select guid from perf_filetype where bustype = '").append("finevadeptpro").append("' )");//项目附件-部门整体
                sql.append("union all select '' as sindexname,'评价成果' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype in (select guid from perf_filetype where bustype = '").append(otherfiletype).append("' )");//评价成果
                if("programfinevalindexfile".equals(filetype)){//指标附件--项目支出
                    sql.append("union all select '' as sindexname,'指标附件' as name,a.* from v_perf_file a where a.billguid in ( select guid || '").append(mainguid).append("' as billguid")
                            .append(" from v_perf_t_evaluatetemp where bustype = 'programevaluatescore' union all select guid || mainguid as billguid from v_perf_t_deptscore where mainguid = '").append(mainguid)
                            .append("' and isdeptadd = '1') and filetype = 'programevaluatescoredeptscore'");
                }else if("deptfinevalindexfile".equals(filetype)) {//指标附件--部门整体
                    sql.append("union all select '' as sindexname,'指标附件' as name,a.* from v_perf_file a where a.billguid in ( select guid || '").append(mainguid).append("' as billguid")
                            .append(" from v_perf_t_evaluatetemp where bustype = 'deptevaluatescore' union all select guid || mainguid as billguid from v_perf_t_deptscore where mainguid = '").append(mainguid)
                            .append("' and isdeptadd = '1') and filetype = 'deptevaluatescoredeptscore'");
                }
            } else if("deptevaluation".equals(fileexptype)) {//部门评价附件查询
                sql.append("select '' as sindexname,'评价成果(处室)' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype in (select guid from perf_filetype where bustype = '").append("findeptevaproresult").append("' )");//评价成果(处室)
                sql.append("union all select '' as sindexname,'评价成果' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype in (select guid from perf_filetype where bustype = '").append(otherfiletype).append("' )");//评价成果
                sql.append("union all select '' as sindexname,'上传附件' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype in (select guid from perf_filetype where bustype = '").append("deptevadept").append("' )");//评价成果
            } else if ("appraisal".equals(fileexptype)) {//绩效考核
                sql.append("select '' as sindexname, a.name,t.* from v_perf_file t");
                sql.append(" left join perf_filetype a on t.filetype = a.guid and a.bustype='appraisalfile'");
                sql.append(" where t.billguid = '").append(mainguid).append("' order by a.ordernum,t.update_time");
            } else if("problemtaskfeedback".equals(fileexptype)) {//任务附件查询
                sql.append("select '' as sindexname,'上传附件' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype in (select guid from perf_filetype where bustype = '").append(otherfiletype).append("' )");//其他附件
            } else if ("subprovinceworkevalfile".equals(filetype) || "deptworkevalfile".equals(filetype)) {//绩效管理工作考核附件
                sql.append("select '上传附件' as name,a.* from perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype in (select guid from perf_filetype where bustype = '").append(otherfiletype).append("' )");//其他附件
            } else if ("deptperfevalTJ_file".equals(fileexptype)) {//部门绩效评价情况附件
                sql.append("select '' as sindexname,'报告' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype = '").append(otherfiletype).append("1' ");//附件1 报告
                sql.append("union all select '' as sindexname,'指标体系评分表' as name,a.* from v_perf_file a where a.billguid = '").append(mainguid).append("'")
                        .append(" and a.filetype = '").append(otherfiletype).append("2' ");//附件2 指标体系评分表
            }
            if (sql.length() > 0) {
                logger.info("---获取一个项目的所有附件sql：" + sql);
                fileInfoList = getPmkpiDAO().queryForList(sql.toString()); // 获取一个项目的所有附件
            }
            logger.info("---获取一个项目的所有附件数量：" + fileInfoList.size());
            if (fileInfoList != null && !fileInfoList.isEmpty()) {//有附件
                List<String> indexnames = fileInfoList.stream().filter(m -> (!StringUtil.isEmpty((String) m.get("name")))).map(d -> (String) d.get("name")).distinct().collect(Collectors.toList());
                for (String indexname : indexnames) {//处理每个指标生成二级文件夹名称并下载对应附件
                    String secondfilename = "";
                    String taskname = "";
                    if(taskstage!=null && !"".equals(taskstage)){
                        taskname = "[" +taskstage + "] ";
                    }
                    List<Map> indexfileList = new ArrayList<>();
                    for (Map filemap : fileInfoList) {
                        String sindexname = (String)filemap.get("sindexname");
                        String name = (String)filemap.get("name");
                        if(name != null && name.equals(indexname)){
                            secondfilename = taskname + (!StringUtil.isEmpty(sindexname)? "指标附件/" + sindexname + "_" + name : name);
                            filemap.put("expname", secondfilename);
                            indexfileList.add(filemap);
                        }
                    }
                    resultMap = new HashMap<>();
                    List fileList = this.getAllAttachments(indexfileList, filetypename);
                    resultMap.put("fileList", fileList);
                    resultList.add(resultMap);
                }
            } else {//无附件，建立一级文件夹
                resultMap = new HashMap<>();
                List fileList = new ArrayList();
                Map<String, Object> dataMap = new HashMap<>();
                dataMap.put("fileName", filetypename + "/");
                fileList.add(dataMap);
                resultMap.put("fileList", fileList);
                resultList.add(resultMap);
            }
        }
        return resultList;
    }

    /**
     * 落地附件
     * @param fileInfoList
     */
    private List getAllAttachments(List<Map> fileInfoList, String filetypename) throws Exception {
        List list = new ArrayList();
        try {
            Map<String, Object> fileNameMap = new HashMap<>();
            Map<String, Object> dataMap = null;
            String filename = "";
            for (Map map : fileInfoList) {
                dataMap = new HashMap<>();
                String fileguid = (String) map.get("fileguid");
                String expname = (String) map.get("expname");
                try {
                    filename = getHtmlFileUploadService().getFileinfoByRest(fileguid).get("fileName").toString();
                    InputStream inputStream = getHtmlFileUploadService().downFileByRest(fileguid, null, false);
                    dataMap.put("inputStream", inputStream);
                } catch (Throwable e1) {
                    logger.error("获取fuds文件名失败");
                    if (StringUtil.isEmpty(filename))
                        filename = (String) map.get("filename");
                }
                if (!fileNameMap.isEmpty() && fileNameMap.containsKey(filename)) {
                    filename = this.renameStr(filename); // 重名文件重命名
                }
                filename = this.getLinuxFilename(filename);
                dataMap.put("fileName", filetypename + "/" + (StringUtil.isEmpty(expname) ? "" : expname) + "/" + filename);
                list.add(dataMap);
                fileNameMap.put(filename, filename);
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
        return list;
    }

    /**
     * <p>重名文件名称加上时间戳</p >
     * 文件名.txt -->  文件名_20220120102049149.txt
     *
     * @param
     * @author hw
     * @date 2022/1/20 10:08
     */
    public String renameStr(String fileName) {
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
    public String getLinuxFilename(String filename) throws UnsupportedEncodingException {
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
