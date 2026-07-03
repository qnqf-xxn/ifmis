package gov.mof.fasp2.pmkpi.evaluation.financial.confirmnew;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscommon.fileimport.fileimport.component.FileUploadService;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscommon.fileimport.fileimport.dto.ImportErrorDTO;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.math.BigInteger;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ConfirmNewBO extends PmkpiBO {
    private ConfirmNewDAO confirmNewDAO;
    public void setConfirmNewDAO(ConfirmNewDAO confirmNewDAO){
        this.confirmNewDAO = confirmNewDAO;
    }

    /**
     * 编辑页查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        String pro_code = (String) params.get("projcode");
        String tablecode = (String) params.get("tablecode");
        List<Map<String, Object>> list = confirmNewDAO.getDatas(tablecode, "t.pro_code = '" + pro_code + "'", null);
        if (PerfUtil.getIsSx()) {
            StringBuffer sql = new StringBuffer("select t.*,t1.xmzje,t1.ysbzamt,t1.xdje from ").append(tablecode).append(" t left join v_perf_xmysbzamt t1 on t.pro_code = t1.pro_code and t.proguid = t1.proguid where t.pro_code = '" + pro_code + "'");
            list = confirmNewDAO.queryForList(sql.toString());
            for (Map<String, Object> map: list) {
                map.put("pro_total_amt", map.get("xmzje"));
                map.put("amt1", map.get("ysbzamt"));
            }
        }
        if (list == null || list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

    /**
     * 查询项目编码
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public String getProCode(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String tablecode = (String) params.get("tablecode");
        List<Map<String, Object>> list = confirmNewDAO.getByGuid(tablecode, proguid);
        if (list == null || list.size() == 0) {
            return null;
        }
        return (String) list.get(0).get("pro_code");
    }


    /**
     * 基础信息修改
     *
     * @param config --
     * @return
     * @throws AppException
     */
    public Map save(HashMap config) throws AppException {
        String guid = "";
        Map<String, Object> backMap = new HashMap<String, Object>();
        String tablecode = (String) config.get("tablecode");
        String agency = (String) config.get("saveAgency");
        String workflow = (String) config.get("workflow");
        String busguid = (String) config.get("busguid");
        String iswf = (String) config.get("iswf");
        String bustype = (String) config.get("bustype");
        Map<String, Object> infodata = (Map<String, Object>) config.get("infodata");
        if (iswf == null || "".equals(iswf)) {
            guid = (String) infodata.get("guid");
        } else {
            guid = (String) config.get("mainguid");
        }
        infodata.put("bustype", bustype);
        if (agency == null || agency.isEmpty()) {
            agency = (String) infodata.get("agencyguid");
        }
        //根据部门或单位查询处室id
//        String finintorgguid = getFinintorgguid(agency);
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> l = new ArrayList<Map<String, Object>>();
        l.add(infodata);
        if (null != guid && !guid.isEmpty()) {
            Map map = null;
            List<Map> datas = confirmNewDAO.getDataByGuid(tablecode, guid);
            if (datas != null && datas.size() > 0) {//修改
                map = datas.get(0);
                infodata.remove("year");
                infodata.remove("province");
                map.putAll(infodata);
                map.put("updatetime", PerfUtil.getServerTimeStamp());
//                map.put("finintorgguid", finintorgguid);//牵头处室-FININTORGGUID保存用户自己选的数据，不需要获取预算单位归口处室
                String wfis = (String) map.get("wfid");
                if (iswf != null && "true".equals(iswf) && (wfis == null || wfis.isEmpty())) {
                    l.clear();
                    l.add(map);
                    this.workflow("createnosave", workflow, "", tablecode, l);
                } else {
                    map.put("mainguid", config.get("mainguid"));
                    confirmNewDAO.update(map, tablecode);
                }
            } else {//新增
                String initOrderOn ="0";
                String newguid = this.getCreateguid();
                Map<String, Object> count = confirmNewDAO.getCount(tablecode);
                if (count.get("code") != null && count.get("code") !=""){
                    String code = count.get("code").toString();
                    int i = Integer.parseInt(code)+1;
                    String procode = Integer.toString(i);
                    infodata.put("pro_code",procode);
                    infodata.put("code",procode);
                }else {
                    infodata.put("pro_code",initOrderOn);
                    infodata.put("code",initOrderOn);
                }
                infodata.put("createtime", PerfUtil.getServerTimeStamp());
                infodata.put("updatetime", PerfUtil.getServerTimeStamp());
                infodata.put("creater", user.getGuid());
                infodata.put("province", user.getProvince());
                infodata.put("year", CommonUtil.getYear());
                infodata.put("agencyguid", agency);
//                infodata.put("finintorgguid", finintorgguid);//牵头处室-FININTORGGUID保存用户自己选的数据，不需要获取预算单位归口处室
                infodata.put("isadd", 1); //是否财政评价新增项目 1：是   0：否
                this.getBasMap(infodata, "add");
                //初始化有效状态
                infodata.put("status", "1");
                if (iswf != null && "true".equals(iswf)) {
                    infodata.put("guid", guid);
                    infodata.put("proguid", guid);//财政新增项目proguid赋值
                    this.workflow("create", workflow, "", tablecode, l);
                } else {
                    infodata.put("guid", newguid);
                    infodata.put("mainguid", config.get("mainguid"));
                    confirmNewDAO.save(infodata, tablecode);
                }
            }
            backMap.put("success", true);
        }
        return this.auditdefine(l, busguid, "perf", null);
    }



    /**
     * 根据部门或单位获取处室id
     * @param agency
     * @return
     */
    private String getFinintorgguid(String agency) {
        String wheresql = "";
        List<Map<String, Object>> data = null;
        wheresql = " t.guid = '" + agency + "'";
        data = confirmNewDAO.getDatas(PmkpiDAO.PMKPI_TABLE_T_AGENCY, wheresql,"order by code");
        String finintorgguid =null;
        if (data!=null && data.size()!=0){
            finintorgguid = (String) data.get(0).get("finintorg");
        }
        return finintorgguid;
    }

    /**
     * 编辑页查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object>
    getdeptData(HashMap<String, Object> params) throws AppException {
        String mainguid = (String) params.get("mainguid");
        String tablecode = (String) params.get("tablecode");
        List<Map<String, Object>> list = confirmNewDAO.getDatas(tablecode, "t.guid = '" + mainguid + "'", null);
        if (PerfUtil.getIsSx()) {
            StringBuffer sql = new StringBuffer("select t.*,t1.jb,t1.xm1 from ").append(tablecode).append(" t left join v_perf_bmysbzamt t1 on t.code = t1.code where t.guid = '" + mainguid + "'");
            list = confirmNewDAO.queryForList(sql.toString());
            for (Map<String, Object> map: list) {
                map.put("pro_total_amt", map.get("xm1"));
                map.put("projamt", map.get("jb"));
            }
        }
        if (list == null || list.size() == 0) {
            return null;
        }
        return list.get(0);
    }

    /**
     * 导入项目
     * @param impDatas
     * @param impCols
     * @param tablecode
     * @param resultList
     * @param busParams
     * @throws AppException
     */
    public void importProData(ArrayList impDatas, ArrayList impCols, String tablecode, ArrayList resultList, HashMap busParams) throws AppException {
        if (impDatas != null && impDatas.size() > 0) {
            //湖北校验标红必填
            if(PerfUtil.getIS_HUBEI()){
                this.checkReddenCollNull(impDatas, impCols);
            }
            if(PerfUtil.getIsNINGXIA()){
                this.checkProCode(impDatas);
            }
            //校验长度
            List<Map<String, Object>> errorlist = this.checkImpColLength(impDatas, impCols);
            if (errorlist.size() > 0) {
                throw new AppException("ANA-ERROR", "导入数据错误");
            } else {
                this.impData(impDatas, tablecode, busParams);
            }
        }
    }

    public void checkReddenCollNull(ArrayList impDatas, ArrayList impCols) throws AppException {
        //校验数据
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto = null;
        List errorlist = new ArrayList();
        for (Object indexMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) indexMap;
            Integer linenum = (Integer) data.get("linenum");
            //标红字段必填
            for (Object impCol : impCols) {
                HashMap<String, Object> colMap = (HashMap<String, Object>) impCol;
                String columncode = (String) colMap.get("columncode");
                String redden = (String) colMap.get("redden");
                String showname = StringUtil.isEmpty((String) colMap.get("showname")) ? (String) colMap.get("name") : (String) colMap.get("showname");
                columncode = columncode.toLowerCase();
                String value = (String) data.get(columncode);
                //标红，不能为空
                if ("checked".equals(redden) && StringUtil.isEmpty(value)) {
                    dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, showname+"必填！");
                    errordao.saveErrorMsg(dto);
                    errorlist.add(errordao);
                }
            }
        }
        if (errorlist.size() > 0){
            throw new AppException("ANA-ERROR", "导入数据不规范，请检查");
        }
    }


    public void checkProCode(List<Map<String, Object>> datas) throws AppException {
        ConfirmNewDAO confirmNewDAO = (ConfirmNewDAO) PerfServiceFactory.getBean("pmkpi.evaluation.financial.confirmnew.ConfirmNewDAO");
        List<Map<String, Object>> errorlist = new ArrayList<>();
        int j = 1;
        StringBuffer error = null;
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto = null;
        List<String> codes = new ArrayList<String>();
        for (Map data : datas) {
            error = new StringBuffer();
            ++j;
            String code = (String) data.get("code");
            if (PerfUtil.getIsNINGXIA()){
                if ((!StringUtil.isEmpty(code)) && codes.contains(code)) {
                    error.append("第"+j+"行项目编码重复！");
                }
                if (!StringUtil.isEmpty((String)data.get("code"))) {
                    String str = (String) data.get("code");
                    if(!str.isEmpty() && !str.matches("\\d+")){
                        error.append("第"+j+"行项目编码格式错误，请输入数字字符！");
                    }
                }
                if(!StringUtil.isEmpty((String)data.get("code"))){
                    List<Map<String, Object>> list = confirmNewDAO.getDatas("V_PERF_T_FINEVALUATION", "t.code = '" + data.get("code") + "'", null);
                    if(list.size() > 0){
                        error.append("第"+j+"行项目编码已存在，请重新填写！");
                    }
                }
                if(StringUtil.isEmpty((String)data.get("name"))){
                    error.append("第"+j+"行项目名称为必填！");
                }
                if(StringUtil.isEmpty((String)data.get("eval_amt"))){
                    error.append("第"+j+"行评价期资金为必填！");
                }
                if(StringUtil.isEmpty((String)data.get("eval_type"))){
                    error.append("第"+j+"行评价资金类型为必填！");
                }
                if(StringUtil.isEmpty((String)data.get("dept_code"))){
                    error.append("第"+j+"行主管部门为必填！");
                }
            }
            codes.add(code);
            if (!StringUtil.isEmpty(error.toString())) {
                dto = new ImportErrorDTO(FileUploadService.fileguids.get(), j, error.toString());
                errordao.saveErrorMsg(dto);
                errorlist.add(dto);
            }
        }
        if (errorlist.size() > 0){
            throw new AppException("ANA-ERROR", "导入数据不规范，请检查");
        }
    }

    public void impData( ArrayList impDatas, String tablecode, HashMap busParams) throws AppException {
        ConfirmNewDAO confirmNewDAO = (ConfirmNewDAO) PerfServiceFactory.getBean("pmkpi.evaluation.financial.confirmnew.ConfirmNewDAO");
        String workflow = (String) busParams.get("workflow");
        UserDTO user = SecureUtil.getCurrentUser();
        List<Map<String, Object>> dataList = new ArrayList<>();
        FileImportErrorDAO errordao = PerfServiceFactory.getFileImportErrorDAO();
        ImportErrorDTO dto = null;
        List errorlist = new ArrayList();
        Boolean isNINGXIA = (Boolean) busParams.get("isNINGXIA");
        BigInteger initOrderOn = BigInteger.ONE;
        Map<String, Object> count = confirmNewDAO.getCount(tablecode);
        if (count.get("code") != null && count.get("code") !="") {
            String code = count.get("code").toString();
            BigInteger bigInteger = new BigInteger(code);
            initOrderOn = bigInteger.add(BigInteger.ONE);
        }
        for (Object dataMap : impDatas) {
            HashMap<String, Object> data = (HashMap<String, Object>) dataMap;
            String newguid = this.getCreateguid();
            if(PerfUtil.getIS_HUBEI() && data.get("code") != null){//湖北则项目编码导入自行填写 其余地区若有项目编码则导入  没有则根据数据库中最大编码+1生成
                data.put("pro_code", data.get("code"));
            } else {
                if(StringUtil.isEmpty((String)data.get("code"))){
                    data.put("pro_code",initOrderOn);
                    data.put("code",initOrderOn);
                    initOrderOn = initOrderOn.add(BigInteger.ONE);
                } else {
                    data.put("pro_code", data.get("code"));
                }
//                String initOrderOn = "0";
//                Map<String, Object> count = confirmNewDAO.getCount(tablecode);
//                if (count.get("code") != null && count.get("code") != "") {
//                    String code = count.get("code").toString();
//                    int i = Integer.parseInt(code) + 1;
//                    String procode = Integer.toString(i);
//                    data.put("pro_code", procode);
//                    data.put("code", procode);
//                } else {
//                    data.put("pro_code", initOrderOn);
//                    data.put("code", initOrderOn);
//                }
            }
            if(isNINGXIA) {
                String dept_code = (String) data.get("dept_code");
                List<Map<String, Object>> list = confirmNewDAO.getDatas("fasp_t_pubdepartment", "t.guid = '" + dept_code + "'", null);
                if (list.size() > 0) {
                    data.put("finintorgguid", list.get(0).get("finintorgguid"));
                }
                data.put("agencyguid", dept_code);
            }
            data.put("createtime", PerfUtil.getServerTimeStamp());
            data.put("updatetime", PerfUtil.getServerTimeStamp());
            data.put("creater", user.getGuid());
            data.put("province", user.getProvince());
            data.put("year", CommonUtil.getYear());
            data.put("bustype", "program");
            data.put("isadd", 1); //是否财政评价新增项目 1：是   0：否
            this.getBasMap(data, "add");
            //初始化有效状态
            data.put("status", "1");
            data.put("guid", newguid);
            data.put("proguid", newguid);//财政新增项目proguid赋值
            dataList.add(data);
            if(!isNINGXIA){
                //校验项目编码唯一
                String querysql = "select t.code from v_perf_t_finevaluation t";
                List<Map<String, Object>> codeList = confirmNewDAO.queryForList(querysql);
                logger.debug("输出数据："+codeList.toString());
                Integer linenum = (Integer) data.get("linenum");
                String impcode = (String) data.get("code");
                //for (Object codes : codeList) {
                for (Map<String, Object> codeMap : codeList) {
                    //HashMap<String, Object> codeMap = (HashMap<String, Object>) codes;
                    if (impcode.equals(codeMap.get("code"))){
                        dto = new ImportErrorDTO(FileUploadService.fileguids.get(), linenum, "项目编码重复！");
                        errordao.saveErrorMsg(dto);
                        errorlist.add(errordao);
                        break;
                    }
                }
            }
        }
        if (errorlist.size() > 0){
            throw new AppException("ANA-ERROR", "导入数据不规范，请检查");
        }
        if (workflow != null) {
            this.workflow("create", workflow, "", tablecode, dataList);
        } else {
            confirmNewDAO.saveAll(dataList, tablecode);
        }
    }
}
