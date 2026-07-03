package gov.mof.fasp2.pmkpi.evaluation.financial.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.fileupload.HtmlFileUploadService;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.evaluation.financial.proconfirm.ProConfirmDAO;
import gov.mof.fasp2.pmkpi.util.FileUtil;
import gov.mof.fasp2.pmkpi.util.ZipUtils;

import java.io.File;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class FinancialQueryBO extends PmkpiBO {
    protected static Logger logger = Logger.getLogger(FinancialQueryBO.class);
    //    private String REPORT_URL;
//    private String REPORT_PORT;
    private HtmlFileUploadService htmlFileUploadService;

    public HtmlFileUploadService getHtmlFileUploadService() {
        if(htmlFileUploadService == null){
            htmlFileUploadService = (HtmlFileUploadService) ServiceFactory.getBean("buscore.fudsclient.htmluploadservice");
        }
        return htmlFileUploadService;
    }

    private FinancialQueryDAO financialQueryDAO;

    public void setFinancialQueryDAO(FinancialQueryDAO financialQueryDAO) {
        this.financialQueryDAO = financialQueryDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql"); //查询区封装的参数
        //String menuid = (String)sqlmap.get("menuid");
        String isleaf = (String) sqlmap.get("isleaf"); //节点是否为末级
        String saveAgency = (String) sqlmap.get("saveAgency"); //节点id.
        //String tablecode = (String)sqlmap.get("tablecode");
        String tabfilter = (String) sqlmap.get("tabfilter"); //页签过滤sql
        String tablesql = (String) sqlmap.get("tablesql"); //表格配置的sql
        //String orderby = (String) sqlmap.get("orderby"); //排序
        String workflow = (String) sqlmap.get("workflow"); //工作流
        String tabcode = (String) sqlmap.get("tabcode"); //页签
        String type = (String) sqlmap.get("type"); //项目调整选择项目
        String lefttabtype = (String) sqlmap.get("lefttabtype");
        String leftmenuid = (String) sqlmap.get("leftmenuid");
        String columncode = "agencyguid";
        StringBuffer returnsql = new StringBuffer();
        returnsql.append("select t.*,NVL(a.SELFSCORE,'0') as SELFSCORE from ").append(ProConfirmDAO.PERF_TABLE_PROCONFIRM).append(" t left join (select sum(SELFSCORE) as SELFSCORE, mainguid from V_PERF_T_DEPTSCORE where isdeptadd = '1' group by mainguid) a on a.mainguid = t.guid  where t.bustype='").append(lefttabtype).append("' ");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", null); //数据权限
        if (!StringUtils.isEmpty(wheresql)) {
            returnsql.append(" and (").append(wheresql).append(")");
        }
        if (!StringUtils.isEmpty(tablesql)) {
            returnsql.append(" and ").append(tablesql);
        }
        if (!StringUtils.isEmpty(tabfilter)) {
            returnsql.append(" and ").append(tabfilter);
        }
        if (StringUtils.isEmpty(type)) {
            String wfsql = this.getWfSql(tabcode, workflow);
            if (!StringUtils.isEmpty(wfsql)) {
                returnsql.append(" and (").append(wfsql).append(") ");
            }
        }
        String leftTreeWheresql = this.getLeftTreeWheresql(isleaf, columncode, saveAgency, financialQueryDAO.PMKPI_TABLE_T_AGENCY);
        returnsql.append(leftTreeWheresql);
        returnsql.append(datarule);
        return returnsql.toString();
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String bustype = (String) params.get("bustype");
        String leftmenuid = (String) params.get("leftmenuid");
        String datarule = this.getDataRuleByMenuguidNull(leftmenuid, "t", "1=1");
        //根据权限查询单位
        datarule += " and bustype='" + bustype + "' ";
        return financialQueryDAO.getLeftTree(financialQueryDAO.PERF_TABLE_PROCONFIRM, datarule);
    }

    /**
     * <p>批量导出附件</p >
     *
     * @param
     * @author hw
     * @date 2021/12/29 16:12
     */
    public HashMap batchExp2(HashMap config) throws Exception {
        HashMap<String, Object> resultMap = new HashMap<>();
        logger.info("---批量导出绩效指标附件 start ...");
        List<HashMap> list = (List<HashMap>) config.get("list");
        String bustype = config.get("bustype").toString();
        String filetype = bustype + "deptscore";
        String warPath = this.getClass().getClassLoader().getResource("").getPath(); //文件下载路径
        warPath = warPath.substring(0, warPath.indexOf("ifmis-pmkpi-service"));
        String dateStr1 = new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()); //时间-目录名称
        String filetypename; //项目类型-一级目录名称
        if ("programevaluatescoredeptscore".equals(filetype)) {
            filetypename = "项目支出";
        } else {
            filetypename = "部门整体";
        }
        logger.info("---warPath:" + warPath);
        for (HashMap map1 : list) {
            String mainguid = (String) map1.get("guid");
            String proname = (String) map1.get("name");
            String prcode = (String) map1.get("code");
            //一二级目录创建
            File createFileDir = new File(warPath + "pmkpitmp" + File.separator + dateStr1 + File.separator + filetypename + File.separator + proname + "_" + prcode);
            createFileDir.mkdirs();
            StringBuffer sql = new StringBuffer(); //查询项目下所有附件（包含模板和新增评分的附件）
            sql.append("select * from v_perf_file where billguid in (select guid || '").append(mainguid).append("'")
                    .append(" as billguid  from v_perf_t_evaluatetemp where bustype = '").append(bustype).append("'")
                    .append(" union all select guid || mainguid as billguid from v_perf_t_deptscore where mainguid = '")
                    .append(mainguid).append("' and isdeptadd = '1') and filetype = '").append(filetype).append("'");
            logger.info("---获取一个项目的所有附件sql：" + sql.toString());
            List<Map> fileInfoList = financialQueryDAO.queryForList(sql.toString()); // 获取一个项目的所有附件
            if (fileInfoList != null && !fileInfoList.isEmpty()) {
                logger.info("----落地目录：" + createFileDir.getAbsolutePath());
                getAllAttachments(fileInfoList, createFileDir.getAbsolutePath(), warPath + "pmkpitmp");
                logger.info("----落地完成----");
            }
        }
        String zipDir = warPath + "pmkpitmp" + File.separator + dateStr1;
        File zipFileDir = new File(zipDir);
        File zipFile = new File(zipDir + ".zip");
        logger.info("---压缩文件路径：" + zipFile.getAbsolutePath());
        if (zipFileDir != null && zipFileDir.isDirectory() && zipFileDir.list().length > 0) {
            ZipUtils.zip(zipFileDir, zipFile);
            logger.info("---批量导出绩效指标附件 end ...");
            resultMap.put("zipFile", zipFile);
            resultMap.put("tmpDir", warPath + "pmkpitmp");
            return resultMap;
        } else {
            logger.info("---批量导出绩效指标附件 end-null ...");
            return null;
        }
    }

    /**
     * <p>落地附件</p >
     *
     * @param
     * @author hw
     * @date 2021/12/29 16:14
     */
    private void getAllAttachments(List<Map> fileInfoList, String tempDir, String delDir) throws Exception {
        try {
            Map<String, Integer> countMap = new HashMap<>();
            for (Map map1 : fileInfoList) {
                String filename1 = (String) map1.get("filename");
                Integer i = 1; //定义一个计数器，用来记录重复数据的个数
                if (countMap.get(filename1) != null) {
                    i = countMap.get(filename1) + 1;
                }
                countMap.put(filename1, i);
            }
            for (Map map : fileInfoList) {
                String filename = (String) map.get("filename");
                Integer count = countMap.get(filename);
                if (count > 1) {
                    filename = FileUtil.renameStr(filename); // 重名文件重命名
                }
                InputStream inputStream = getHtmlFileUploadService().downFile((String) map.get("fileguid"), null);
                filename = FileUtil.getLinuxFilename(filename);
                FileUtil.writeToLocal(tempDir + File.separator + filename, inputStream);
            }
        } catch (AppException e) {
            FileUtil.delFolder(delDir);
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }
    }

}
