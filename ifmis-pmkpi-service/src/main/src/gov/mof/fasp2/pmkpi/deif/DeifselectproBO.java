package gov.mof.fasp2.pmkpi.deif;

import gov.mof.fasp2.buscore.framework.dto.fasp.FaspDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.table.dto.DicTableDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.datacommon.deif.base.IJsonDataService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfcommon.file.FileBO;
import gov.mof.fasp2.pmkpi.perfprogram.goal.PrjIndexDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: DeifselectproBO
 */

public class DeifselectproBO extends PmkpiBO implements IJsonDataService {
    /**
     * prjIndexDAO.
     */
    private PrjIndexDAO prjIndexDAO;
    /**
     * 注入dao.
     * @param prjIndexDAO --prjIndexDAO.
     * @throws
     */
    public void setPrjIndexDAO(PrjIndexDAO prjIndexDAO) {
        this.prjIndexDAO = prjIndexDAO;
    }

    @Override
    public String getVodSql(Map sqlmap) throws AppException {
        String wheresql = (String) sqlmap.get("querySql");
        String defquery = (String) sqlmap.get("defquery");
        String bustype = (String) sqlmap.get("bustype");
        String tablecode = (String) sqlmap.get("tablecode");
        String basewheresql = " t.province ='"+ SecureUtil.getUserSelectProvince()+"' ";
        if(!StringUtil.isNullOrEmpty(bustype) && "pmkpi100".equals(bustype)) {//提取绩效自评项目范围
            tablecode = "PERF_V_SELFEVALTASK";
            basewheresql = " t.bustype ='program' ";
        }else if(!StringUtil.isNullOrEmpty(bustype) && "pmkpi120".equals(bustype)){//提取绩效自评批复数据
            tablecode = "PERF_V_SELFEVALTASK";
            basewheresql = " t.bustype ='program' ";
        }
        StringBuffer sql = new StringBuffer("select * from ").append(tablecode).append(" t ");
        sql.append("where ").append(basewheresql);
        if (!StringUtil.isEmpty(defquery)){
            sql.append(" and (").append(defquery).append(")");
        }
        if (!StringUtil.isEmpty(wheresql)){
            sql.append(" and (").append(wheresql).append(")");
        }
        return sql.toString();
    }


    /**
     * 业务实现方法
     * 当前实现类是否运行json处理逻辑
     * 。应用场景1. bo类实现此接口后，Tx代理类和原类都会执行，通过判断是Tx代理类才执行，即serviceBeanId是Tx结尾的才处理
     *
     * @param serviceBeanId 实现接口的类beanId
     * @param busType       接入或者提取菜单类型
     * @param appId         业务系统appid
     * @param dd            数据方向 1.接入菜单   2.提取菜单
     * @return
     */
    @Override
    public boolean isInvokeService(String serviceBeanId, String busType, String appId, String dd) {
        if(serviceBeanId.contains("TX")){
            return true;
        }else{
            return false;
        }
    }

    /**
     * 处理表数据导入接口
     *
     * @param impJsonTableCode        导入表code
     * @param impJsonTableRow         导入表数据行
     * @param jsonResultDto           jsonresult中间表DEIF_JSONRESULT待保存数据，业务可根据情况更改字段值例如status errormsg等字段
     * @param impJsonTableCollectRows 按表名收集的数据集 格式:{tab1:[],tab2:[]} (仅当是主子表导入时，才存储的有子表数据，单表可业务自行存储需要的数据行到此参数中)
     * @param isLastTableRow          是否是表impJsonTableCode的最后一条数据
     * @param isLastTable             是否导入文件中最后一张表
     * @throws Exception
     */
    @Override
    public void processImpJsonTableData(String impJsonTableCode, Map impJsonTableRow, FaspDTO jsonResultDto, Map<String, List<Map>> impJsonTableCollectRows, boolean isLastTableRow, boolean isLastTable) throws Exception {
        if("PERF_T_SELFEVALTASK".equals(impJsonTableCode)){
            String guid = (String) impJsonTableRow.get("guid");
            String updatetime = (String) impJsonTableRow.get("updatetime");//自评主表，如果没更新过就不做导入处理
            int dataCount = prjIndexDAO.getDataCount(impJsonTableCode,"guid = ? and updatetime = ? ",new String[]{guid,updatetime});
            if(dataCount == 1){
                impJsonTableRow = new HashMap();
            }else{
                impJsonTableRow.put("bgtget",impJsonTableRow.get("bgtget")==null ? 0 : impJsonTableRow.get("bgtget"));
                impJsonTableRow.put("perfgoalguid",impJsonTableRow.get("projguid"));
                impJsonTableRow.put("month","12");
            }
        }else if("PERF_T_SELFPROFUND".equals(impJsonTableCode)){
            if(PerfUtil.getIsGuangXi()){//广西-资金只有"其他资金"类型，其他类型走取数
                String name = (String) impJsonTableRow.get("name");
                if(!StringUtil.isNullOrEmpty(name) && !"其他资金".equals(name)){
                    impJsonTableRow = new HashMap();
                }else if(!StringUtil.isNullOrEmpty(name) && "其他资金".equals(name)){
                    this.saveSelfFundsOthers(impJsonTableRow);
                }
            }
        }else if("PERF_T_SELFPERFINDEX".equals(impJsonTableCode)){
            String levelno = (String) impJsonTableRow.get("levelno");
            if(!StringUtil.isNullOrEmpty(levelno) && !"3".equals(levelno)){//只处理三级指标保存
                impJsonTableRow = new HashMap();
            }
        }else if("PERF_T_SELFPERFDESC".equals(impJsonTableCode)){

        }else if("ATTACHMENT".equals(impJsonTableCode)){//附件
            String filetype = "";
            String bustype = (String) jsonResultDto.get("bustype");
            if(!StringUtil.isNullOrEmpty(bustype) && "pmkpi110".equals(bustype)) {//接入绩效自评填报数据-项目指标附件
                filetype = "programselfindexfile";
            }
            String billguid = (String) impJsonTableRow.get("billguid");
            String fileguid = (String) impJsonTableRow.get("file_id");
            String filename = (String) impJsonTableRow.get("file_name");
            if(!StringUtil.isNullOrEmpty(filetype)){
                FileBO fileBO = (FileBO) PerfServiceFactory.getBean("pmkpi.perfcommon.file.FileBOTX");
                fileBO.deleteFile(fileguid);
                fileBO.saveFileData(billguid,fileguid,filename,filetype);
            }
        }
        if(!impJsonTableRow.isEmpty() && !"ATTACHMENT".equals(impJsonTableCode)){
            //导入数据校验
            this.checkImportDatas(impJsonTableCode,impJsonTableRow,jsonResultDto);
            //导入数据DB处理 标识creater
            impJsonTableRow.put("creater","单位端数据导入");
            String guid = (String) impJsonTableRow.get("guid");
            if(!StringUtil.isNullOrEmpty(guid)){
                int dataCount = prjIndexDAO.getDataCount(impJsonTableCode,"guid = ? ",new String[]{guid});
                if(dataCount>0){//存在对应主键数据，更新该数据
                    prjIndexDAO.update(impJsonTableRow, impJsonTableCode);
                }else{//不存在对应主键数据，新增数据
                    prjIndexDAO.save(impJsonTableRow, impJsonTableCode);
                }
            }else {
                jsonResultDto.put("errormsg","导入异常："+impJsonTableCode+"缺少GUID！");
            }
        }
    }

    /**
     * 校验导入数据
     * @param impJsonTableCode        导入表code
     * @param impJsonTableRow         导入表数据行
     * @param jsonResultDto           jsonresult中间表DEIF_JSONRESULT待保存数据，业务可根据情况更改字段值例如status errormsg等字段
     * @return
     * @throws AppException
     */
    public void checkImportDatas(String impJsonTableCode, Map impJsonTableRow, FaspDTO jsonResultDto) throws AppException {
        String guid = (String) impJsonTableRow.get("guid");
        String bustype = (String) jsonResultDto.get("bustype");
        if(!StringUtil.isNullOrEmpty(bustype) && "pmkpi110".equals(bustype)) {//接入绩效自评填报数据
            String mainguid = (String) impJsonTableRow.get("mainguid");
            if("PERF_T_SELFEVALTASK".equals(impJsonTableCode)){
                mainguid = (String) impJsonTableRow.get("guid");
            }
            //填报待送审数据可导入
            int dataCount = prjIndexDAO.getDataCount("PERF_T_SELFEVALTASK"," guid = ? "+ PerfUtil.yearProvinceSql("t"),new String[]{mainguid});
            if(dataCount == 0){
                jsonResultDto.put("errormsg","表【"+impJsonTableCode+"】数据导入失败，自评主键为【"+mainguid+"】的自评数据未下发！");
            }
            int wfdataCount = prjIndexDAO.getDataCount("PERF_T_SELFEVALTASK","(wfstatus = '000' or wfstatus is null) and guid = ? "+ PerfUtil.yearProvinceSql("t"),new String[]{mainguid});
            if(wfdataCount == 0){
                jsonResultDto.put("errormsg","表【"+impJsonTableCode+"】数据导入失败，自评主键为【"+mainguid+"】的自评数据已送审或审核无法导入！");
            }
        }
        //通用NULL校验
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        DicTableDTO dicTableDTO = dicQueryService.getDicTable(impJsonTableCode.toLowerCase());
        List<Map<String, Object>> cols = (List) dicTableDTO.getListCol();
        for (Map colsmap : cols) {
            String nullable = colsmap.get("nullable") + "";
            if (!"1".equals(nullable)) {
                String colname = (String) colsmap.get("columncode");
                colname = colname.toLowerCase();
                String context = String.valueOf(impJsonTableRow.get(colname)).trim();
                if (StringUtil.isEmpty(context) || "null".equals(context)) {
                    jsonResultDto.put("errormsg","表【"+impJsonTableCode+"】数据导入失败，主键为"+guid+"的数据:【"+colname+"】字段不能为空，请确认数据！");
                }
            }
        }
    }

    /**
     * 保存自评除了“其他资金”都重新取数
     * @param impJsonTableRow “其他资金”行数据
     */
    public void saveSelfFundsOthers(Map impJsonTableRow) throws AppException {
        String mainguid = (String) impJsonTableRow.get("mainguid");
        String procode = (String) impJsonTableRow.get("pro_code");
        String proguid = (String) impJsonTableRow.get("proguid");
        String agencyguid = (String) impJsonTableRow.get("agencyguid");
        prjIndexDAO.setProfundParams(procode, proguid, agencyguid, "12");
        List<Map<String, Object>> datalist = prjIndexDAO.getDatas("V_PERF_SELFBDGPAY_PROJECT", null, " order by ordernum");
        List<Map<String, Object>> savelist = new ArrayList<>();
        if(datalist.size()>0){
            for (Map<String, Object> data : datalist) {
                String name = (String) data.get("name");
                if(!StringUtil.isNullOrEmpty(name) && !"其他资金".equals(name)){
                    data.put("guid", this.getCreateguid());
                    data.put("mainguid",mainguid);
                    data.put("agencyguid", agencyguid);
                    data.put("pro_code", procode);
                    data.put("mof_div_code",data.get("province"));
                    data.put("fiscal_year",data.get("year"));
                    data.put("create_time", PerfUtil.getServerTimeStamp());
                    data.put("update_time", PerfUtil.getServerTimeStamp());
                    data.put("creater","单位端数据导入");
                    data.put("is_deleted", 2);
                    savelist.add(data);
                }
            }
            prjIndexDAO.delDatas("V_PERF_T_SELFPROFUND", " mainguid='" + mainguid + "'");
            prjIndexDAO.saveAll(savelist,"PERF_T_SELFPROFUND");
        }
    }

    /**
     * Tx代理类导入json
     * @param impFile
     * @param impParams
     * @throws Exception
     */
    public void impJsonDatasTx(MultipartFile impFile, Map impParams) throws Exception {
        this.impJsonDatas(impFile,impParams);
    }

    /**
     * 获取导出配置
     * @param config 包含bustype- 1.pmkpi100 提取绩效自评项目范围；2.pmkpi120 提取绩效自评批复数据
     * @return
     */
    public Map<String, Map<String, Object>> getDeifselectproBO(HashMap config) throws AppException {
        Map<String, Map<String, Object>> expTabsInfo = new HashMap<>();
        String bustype = (String) config.get("bustype");
        String expfilename = "提取绩效数据";
        List<Map<String, Object>> datas = (List<Map<String, Object>>) config.get("data");
        if(datas.size()==0){
            String querysql = getVodSql(config);
            datas = prjIndexDAO.queryForList(querysql);
        }
        List<String> maingList = new ArrayList<>();
        for (Map<String, Object> data : datas) {
            maingList.add((String) data.get("guid"));
        }
        String datasql = prjIndexDAO.createInSql("guid", maingList);
        String maindatasql = prjIndexDAO.createInSql("mainguid", maingList);
        if(!StringUtil.isNullOrEmpty(bustype) && "pmkpi100".equals(bustype)){//提取绩效自评项目范围
            expfilename = "提取绩效自评项目范围";
            Map<String, Object> args1 = new HashMap<>();
            args1.put("qry","select * from V_PERF_T_SELFEVALTASK t where "+ datasql);
            args1.put("qryargs","[]");
            expTabsInfo.put("PERF_T_SELFEVALTASK",args1);
        }else if(!StringUtil.isNullOrEmpty(bustype) && "pmkpi120".equals(bustype)){//提取绩效自评批复数据
            expfilename = "提取绩效自评批复数据";
            Map<String, Object> args1 = new HashMap<>();
            args1.put("qry","select * from V_PERF_T_SELFEVALTASK t where "+ datasql);
            args1.put("qryargs","[]");
            expTabsInfo.put("PERF_T_SELFEVALTASK",args1);
            Map<String, Object> args2 = new HashMap<>();
            args2.put("qry","select * from V_PERF_T_SELFPROFUND t where "+ maindatasql);
            args2.put("qryargs","[]");
            expTabsInfo.put("PERF_T_SELFPROFUND",args2);
            Map<String, Object> args3 = new HashMap<>();
            args3.put("qry","select * from V_PERF_T_SELFPERFINDEX t where "+ maindatasql);
            args3.put("qryargs","[]");
            expTabsInfo.put("PERF_T_SELFPERFINDEX",args3);
            Map<String, Object> args4 = new HashMap<>();
            args4.put("qry","select * from V_PERF_T_SELFPERFDESC t where "+ maindatasql);
            args4.put("qryargs","[]");
            expTabsInfo.put("PERF_T_SELFPERFDESC",args4);
            Map<String, Object> args5 = new HashMap<>();
            //自评指标附件 billguid 为 指标GUID||自评主表GUID 财政端GUID32位、单位端GUID40位
            //business_id 自评guid businessdetailid 指标guid
            args5.put("qry","select t.*,case when length(billguid)= 64 then substr(billguid,0,32) when length(billguid)= 80 then substr(billguid,0,40) else '' end as businessdetailid," +
                    "case when length(billguid)= 64 then substr(billguid,33,64) when length(billguid)= 80 then substr(billguid,41,80) else billguid end as business_id," +
                    "t.fileguid as file_id,t.filename as file_name from V_PERF_FILE t where filetype = 'programselfindexfile' and billguid in (select guid||mainguid as billguid from V_PERF_T_SELFPERFINDEX where "+ maindatasql+")");
            args5.put("qryargs","[]");
            expTabsInfo.put("ATTACHMENT",args5);
        }
        config.put("expfilename",expfilename);
        return expTabsInfo;
    }

}
