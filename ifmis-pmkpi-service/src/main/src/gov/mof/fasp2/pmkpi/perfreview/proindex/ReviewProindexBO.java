package gov.mof.fasp2.pmkpi.perfreview.proindex;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReviewProindexBO extends PmkpiBO {
    private ReviewProindexDAO reviewProindexDAO;

    public void setReviewProindexDAO(ReviewProindexDAO reviewProindexDAO) {
        this.reviewProindexDAO = reviewProindexDAO;
    }

    /**
     * 查询指标.
     * @param params
     * @return
     */
    public List<Map<String, Object>> findIndex(HashMap<String, Object> params){
        String mainguid = (String) params.get("proguid");
        String tabtype = (String) params.get("tabtype");
        String bustype = (String) params.get("bustype");
        String procode = (String) params.get("procode");
        String tablecode = "";
        String indexsql = "";
        List<Map<String, Object>> tempdatas = null;
        if ("dept".equals(bustype)) {
            indexsql = " t.mainguid = '" + mainguid + "'";
            tablecode = "V_BGT_PERF_INDICATOR";
            String wheresql = " and frametype='DEPT' ";
            tempdatas = reviewProindexDAO.getTempdatas(wheresql);
        }else{
            indexsql = "";
            if ("year".equals(tabtype)) {
                tablecode = "v_pm_perf_indicator";
                indexsql += " t.pro_code = '" + procode + "' and nvl(yearflag,'0') = '0'";
            } else if ("total".equals(tabtype)) {
                tablecode = "pm_perf_indicator";
                indexsql += " t.mainguid = '" + mainguid + "' and nvl(yearflag,'0') = '1' and is_backup=2 and is_deleted = 2";
            }
            String wheresql = " and frametype='PM001' ";
            tempdatas = reviewProindexDAO.getTempdatas(wheresql);
        }
        String orderby = " order by ordernum";
        List<Map<String, Object>> collist = reviewProindexDAO.getCol(tablecode);
        List<Map<String, Object>> indexs = reviewProindexDAO.getDatas(tablecode, indexsql, orderby);
        Map<String, Object> sumMap = new HashMap<String, Object>();
        List<Map<String, Object>> backdata = new ArrayList<Map<String, Object>>(); //返回的表格数据.
        List<Map<String, Object>> tempList = new ArrayList();
        String sindex = "";
        String findex = "";
        for (Map<String, Object> map : indexs) {
            map.put("levelno", "3");
            map.put("isleaf", "1");
            sindex = (String) map.get("sindex");
            map.put("superid", sindex);
            tempList.add(map);
        }
        for (Map<String, Object> map : tempdatas) {
            for (Map<String, Object> colmap : collist) {
                String col = (String) colmap.get("columncode");
                String value = map.get(col) + "";
                if (!StringUtil.isEmpty(value) && "null".equals(value)) {
                    map.put(col, null);
                }
            }
            map.put("_isleaf", "0");
            String levelno = map.get("levelno") + "";
            if (!StringUtil.isEmpty(levelno) && !"null".equals(levelno) && "2".equals(levelno)) {
                sindex = (String) map.get("guid");
                map.put("weight",sumMap.get(sindex));
            } else if (!StringUtil.isEmpty(levelno) && !"null".equals(levelno) && "1".equals(levelno)) {
                findex = (String) map.get("guid");
                map.put("weight",sumMap.get(findex));
            }
            backdata.add(map);
        }
        backdata.addAll(tempList);
        return backdata;
    }

    /**
     * 查询评审信息.
     * @return
     */
    public List<Map<String, Object>> findReview(String mainguid){
        return PerfUtil.lowMapKey(reviewProindexDAO.getDatas(mainguid));
    }

    /**
     * 获取评审主表
     * @return
     */
    public List<Map<String, Object>> findauditmain(String mainguid){
        return PerfUtil.lowMapKey(reviewProindexDAO.findauditmain(mainguid));
    }

    /**
     * 保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map savedatas(HashMap config) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        String guid = (String) config.get("proguid");
        String saveAgency = (String) config.get("saveAgency");
        String mainguid = (String) config.get("mainguid");
        Map<String, Object> editdata = (Map<String, Object>) config.get("editdata");
        List<Map<String, Object>> reviewdata = (List<Map<String, Object>>) config.get("reviewdatas");
        //当前登录用户
        UserDTO user = SecureUtil.getCurrentUser();
        //保存意见
        String delsql = " t.mainguid = '"+mainguid+"' ";
        reviewProindexDAO.delDatas(PmkpiDAO.PMKPI_TABLE_T_AUDITMAIN, delsql);
        editdata.put("agencyguid", saveAgency);
        editdata.put("proguid", guid);
        editdata.put("mainguid", mainguid);
        editdata.put("guid", this.getCreateguid());
        editdata.put("createtime", PerfUtil.getServerTimeStamp());
        editdata.put("updatetime", PerfUtil.getServerTimeStamp());
        editdata.put("userguid", user.getGuid());
        editdata.put("province", SecureUtil.getUserSelectProvince());
        editdata.put("year", SecureUtil.getUserSelectYear());
        reviewProindexDAO.save(editdata, PmkpiDAO.PMKPI_TABLE_T_AUDITMAIN);
        //保存评审表格数据
        for (Map map : reviewdata) {
            map.put("tempguid",map.get("guid"));
            map.put("proguid", guid);
            map.put("mainguid", mainguid);
            map.put("guid", this.getCreateguid());
            map.put("province", SecureUtil.getUserSelectProvince());
            map.put("year", SecureUtil.getUserSelectYear());
            map.put("userguid", user.getGuid());
            map.put("province", user.getProvince());
            map.put("year", CommonUtil.getYear());
            map.put("agencyguid", saveAgency);
        }
        reviewProindexDAO.delDatas(PmkpiDAO.PMKPI_TABLE_T_AUDITITEMS, delsql);
        reviewProindexDAO.saveAll(reviewdata, PmkpiDAO.PMKPI_TABLE_T_AUDITITEMS);
        return backMap;
    }

}
