package gov.mof.fasp2.pmkpi.rectification.bo;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationAddProjDAO;
import gov.mof.fasp2.pmkpi.rectification.dao.RectificationFileDAO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class RectificationFileBO extends PmkpiBO {

    private RectificationFileDAO rectificationFileDAO;

    public void setRectificationFileDAO(RectificationFileDAO rectificationFileDAO) {
        this.rectificationFileDAO = rectificationFileDAO;
    }

    public String getVodSql(Map sqlmap) throws AppException {
        String bustype = (String) sqlmap.get("bustype");
        String tablecode = (String)sqlmap.get("tablecode");
        String wheresql = (String)sqlmap.get("defquery");
        StringBuffer returnsql = new StringBuffer("select t.*,'' as supername from ");
        returnsql.append(tablecode).append(" t where 1=1 ");
        if (wheresql != null && !wheresql.isEmpty()) {
            returnsql.append(" and ").append(wheresql);
        }
        if (bustype != null && !bustype.isEmpty()) {
            returnsql.append(" and t.bustype = '").append(bustype).append("'");
        }
        return returnsql.toString();
    }

    public Map<String, Object> queryEdit (HashMap<String, Object> params){
        String mainguid = (String) params.get("mainguid");
        String queryYear = (String) params.get("queryYear");
        String queryProvince = (String) params.get("queryProvince");
        String rectype = (String) params.get("rectype");
        String checkguid = (String) params.get("checkguid");
        String viewtype = (String) params.get("viewtype");
        String bustype = (String) params.get("bustype");
        Map<String, Object> data = new HashMap<>();
        if(mainguid != null && !mainguid.isEmpty()) {
            data = this.getDataByGuid(mainguid, queryYear , queryProvince);
        }
        //宁夏逻辑
        if (PerfUtil.getIsNINGXIA() && "1".equals(bustype) && data.isEmpty() && !StringUtil.isEmpty(checkguid) && !"query".equals(viewtype)) {
            String str = (String) params.get(rectype);
            if (!StringUtil.isEmpty(str)) {
                String[] strs = str.split("-");
                String tablecode = strs[0];
                String col = strs[1];
                String wheresql = " guid=? ";
                if ("rectifytrace".equals(rectype)) {
                    wheresql = " mainguid=? ";
                }
                Map<String, Object> map = this.getDataMap(tablecode, wheresql, new String[]{checkguid});
                if (!map.isEmpty()) {
                    data.put("rectifydesc", map.get(col));
                }
            }
        }
        return data;
    }

    public List<Map<String, Object>> queryFiletype (HashMap<String, Object> params){
        String filebustype = (String) params.get("filebustype");
        String tablecode = (String)params.get("tablecode");
        String billid = (String) params.get("mainguid");
        String queryYear = (String)params.get("queryYear");//跨年查询查询年度
        String queryProvince = (String)params.get("queryProvince");//跨年查询查询区划
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            rectificationFileDAO.setYearAndProvince(queryYear, queryProvince);
        }
        StringBuffer returnsql = new StringBuffer();
        //在getDatas中拼接sql时，会在前面加and，如果条件也是以and开头就会报错
        returnsql.append("(select a.*,'' as supername from ").append(tablecode).append(" a where");
        if (filebustype != null && !filebustype.isEmpty()) {
            returnsql.append(" a.bustype = '").append(filebustype).append("'");
        }else{
            returnsql.append(" 1!=1 ");
        }
        returnsql.append(")");
        List<Map<String, Object>> data = rectificationFileDAO.getDatas(returnsql.toString(), billid);
        for (Map<String, Object> map: data) {
            String levelno = PerfUtil.mapGetInt(map,"levelno") + "";
            if ("1".equals(levelno)) {
                map.put("supername",map.get("name"));
                map.put("name",null);
            }
        }
        return data;
    }

    /**
     * 保存
     *
     * @param params
     * @return
     */
    public Map<String, Object> save(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String rectype = (String) params.get("rectype"); ////业务阶段  1：绩效监控   2：绩效自评  3：部门评价  4：财政评价
        String viewtype = (String) params.get("viewtype");
        String mainguid = (String) params.get("mainguid");
        String bustype = (String) params.get("bustype");
        String type = (String) params.get("type");
        String workflow = (String) params.get("workflow");
        Map<String, Object> editmapInit = (HashMap<String, Object>) params.get("rectifycontent");
        List<Map<String, Object>> rectifys  = (List<Map<String, Object>>) params.get("rectifysData"); //选择项目列表整改数据集合
        List<Map<String, Object>> addList = new ArrayList<>();
        List<Map<String, Object>> updateList = new ArrayList<>();
        String wheresql = "";
        StringBuffer bufferproguid = new StringBuffer();
        StringBuffer buffercode = new StringBuffer();
        Map imptemp = new HashMap();
        int len = rectifys.size();
        for (int i = 0; i < len; i++) {
            imptemp = rectifys.get(i);
            if (i != 0) {
                bufferproguid.append(",");
                buffercode.append(",");
            }
            String projguid = (String) imptemp.get("proguid");
            if (StringUtil.isEmpty(projguid)) {
                projguid = (String) imptemp.get("projguid");
            }
            bufferproguid.append("'").append(projguid).append("'");
            buffercode.append("'").append(imptemp.get("pro_code")).append("'");
        }
        if (PerfUtil.getIsHbei() || "3".equals(bustype)) {
            wheresql = " guid in (" + bufferproguid.toString() + ") ";
        }else{
            wheresql = " pro_code in (" + buffercode.toString() + ") ";
        }
        if (viewtype != null && "rectify".equals(viewtype)) {
            String sql = "'t.wfstatus<>'011' and ";
            if (PerfUtil.getIsHbei() || "3".equals(bustype)) {
                sql += " proguid in (" + bufferproguid.toString() + ") ";
            }else{
                sql += " pro_code in (" + buffercode.toString() + ") ";
            }
            List<Map<String, Object>> data = rectificationFileDAO.getDatas(RectificationAddProjDAO.PERF_T_RECTIFY, sql, null);
            if (data.size() > 0) {
                throw new AppException("提示", "已经存在整改数据！！！");
            }
        }
        List<Map<String, Object>> prolist = new ArrayList<>();//查询项目或部门基本信息用于整改新增数据组装
        if (bustype != null && "1".equals(bustype)) { //项目
            prolist = rectificationFileDAO.getDatas("V_PERF_PROJECT_INFO", wheresql, null);
        } else if (bustype != null && "3".equals(bustype)) { //部门整体
            prolist = rectificationFileDAO.getDatas("V_PERF_T_DEPTPERFDECLARE", wheresql, null);
        }
        Map<String, Object> map = new HashMap<>();
        if (!StringUtil.isEmpty(mainguid)) {
            map = getDataByGuid(mainguid, null, null);
        }
        for (Map<String, Object> rectify : rectifys) {
            String isfinadd = "";
            Object isadd = rectify.get("isadd"); //是否财政评价新增项目
            if (isadd != null) {
                isfinadd = isadd.toString();
            }
            String proguid = StringUtil.isEmpty((String) rectify.get("proguid")) ?
                    (String) rectify.get("projguid") : (String) rectify.get("proguid");
            String pro_code = (String) rectify.get("pro_code");
            Map promap = new HashMap(); //项目或部门整体详情
            for (Map<String, Object> pro : prolist) {
                if ((PerfUtil.getIsHbei() || "3".equals(bustype)) && proguid.equals(pro.get("guid"))) {
                    promap = pro;
                } else if (!PerfUtil.getIsHbei() && "1".equals(bustype) && pro_code.equals(pro.get("pro_code"))) {
                    promap = pro;
                }
            }
            UserDTO user = SecureUtil.getCurrentUser();
            String guidNew = StringUtil.createUUID();
            if (!map.isEmpty()) {//修改
                map.putAll(editmapInit);
                map.put("updateuid", user.getGuid());
                map.put("updateuname", user.getName());
                map.put("updatetime", StringUtil.getSysDBDate());
                updateList.add(map);
            } else {  //新增
                Map<String, Object> editmap = new HashMap<>();
                editmap.putAll(editmapInit);
                if (rectifys.size() == 1) {
                    editmap.put("guid", mainguid);
                } else {
                    editmap.put("guid", this.getCreateguid());
                }
                editmap.put("state", "0");
                editmap.put("createuid", user.getGuid());
                editmap.put("createuname", user.getName());
                editmap.put("createtime", PerfUtil.getServerTimeStamp());
                editmap.put("delstatus", "0");
                editmap.put("province", user.getProvince());
                editmap.put("year", CommonUtil.getYear());
                editmap.put("proguid", proguid);
                editmap.put("mainguid", guidNew);
                editmap.put("creater", user.getGuid());
                editmap.put("bustype", bustype);
                editmap.put("rectype", rectype);

                editmap.put("isrectify", 1);  //是否发起整改  1是  0否
                editmap.put("rectifyend", 0); //是否完成整改  1是  0否

                editmap.put("taskname", rectify.get("taskname"));
                editmap.put("taskstage", rectify.get("taskstage"));
                editmap.put("taskguid", rectify.get("taskguid"));
                editmap.put("type", type);
                editmap.put("status", "1");
                editmap.put("SXSTATE", 0);
                if (bustype != null && "1".equals(bustype)) { //项目
                    editmap.put("pro_code", pro_code);
                    editmap.put("agencyguid", StringUtil.isEmpty((String) rectify.get("agencyguid")) ? promap.get("agency_code") : rectify.get("agencyguid"));
                    editmap.put("agency_code", editmap.get("agencyguid"));
                    if (("rectifyfinancialeval".equals(rectype) || "rectifydepteval".equals(rectype)) && "1".equals(isfinadd)) {//财政评价新增项目字段处理
                        editmap.put("projname", rectify.get("name"));
                        editmap.put("finintorgguid", rectify.get("finintorgguid"));
                        editmap.put("pro_lev", "1");
                        editmap.put("isadd", 1);
                        editmap.put("manage_dept_code", rectify.get("manage_dept_code"));
                        editmap.put("manage_mof_dep_code", rectify.get("manage_mof_dep_code"));
                        editmap.put("mof_dep_code", rectify.get("mof_dep_code"));
                        editmap.put("dept_code", rectify.get("dept_code"));
                    } else { //其他类型从项目视图获取字段
                        editmap.put("projname", promap.get("pro_name"));
                        editmap.put("finintorgguid", promap.get("mof_dep_code"));
                        editmap.put("pro_lev", promap.get("pro_lev"));
                        editmap.put("isadd", 0);
                        editmap.put("manage_dept_code", promap.get("manage_dept_code"));
                        editmap.put("manage_mof_dep_code", promap.get("manage_mof_dep_code"));
                        editmap.put("mof_dep_code", promap.get("mof_dep_code"));
                        editmap.put("dept_code", promap.get("dept_code"));
                    }
                } else if (bustype != null && "3".equals(bustype)) { //部门整体
                    editmap.put("agencyguid", promap.get("agencyguid"));
                    editmap.put("pro_code", promap.get("code"));
                    editmap.put("projname", promap.get("name"));
                    editmap.put("finintorgguid", promap.get("finintorgguid"));
                    editmap.put("manage_dept_code", promap.get("manage_dept_code"));
                    editmap.put("manage_mof_dep_code", promap.get("manage_mof_dep_code"));
                    editmap.put("mof_dep_code", promap.get("mof_dep_code"));
                    editmap.put("dept_code", promap.get("dept_code"));
                    editmap.put("agency_code", promap.get("agencyguid"));
                    editmap.put("isadd", 0);
                }
                editmap.put("isfinal", "2");
                addList.add(editmap);

            }
        }
        if (updateList != null && !updateList.isEmpty()) {
            logger.info("---updateList:" + updateList.toString());
            rectificationFileDAO.updateAll(updateList, RectificationAddProjDAO.PERF_T_RECTIFY);
            backMap.put("datas", updateList);
            backMap.put("success", true);
        }
        if (addList != null && !addList.isEmpty()) {
            logger.info("---addList:" + addList.toString());
            this.workflow("create", workflow, "", RectificationAddProjDAO.PERF_T_RECTIFY, addList);
            backMap.put("datas",addList);
            backMap.put("success", true);
        }
        return backMap;
    }

    /**
     * 根据guid查询
     * @param mainguid  主单guid
     * @return
     */
    public Map<String, Object> getDataByGuid(String mainguid, String queryYear, String queryProvince) {
        if (!StringUtil.isEmpty(queryYear) && !StringUtil.isEmpty(queryProvince)) {
            rectificationFileDAO.setYearAndProvince(queryYear, queryProvince);
        }
        String wheresql = " t.guid=? ";
        return this.getDataMap(RectificationAddProjDAO.PERF_T_RECTIFY, wheresql, new String[]{mainguid});
    }
}
