package gov.mof.fasp2.pmkpi.setting.assessment;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class AssessmentSetBO extends PmkpiBO {

    private AssessmentSetDAO assessmentSetDAO;

    public void setAssessmentSetDAO(AssessmentSetDAO assessmentSetDAO) {
        this.assessmentSetDAO = assessmentSetDAO;
    }

    /**
     * 编辑页查询数据方法
     *
     * @param params --
     * @return
     * @throws AppException
     */
    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backMap = new HashMap<String, Object>();
        //页面类型
        String orderby = (String) params.get("orderby");
        String wheresql = "";
        String tablecode = (String) params.get("tablecode");
        String tablesql = (String) params.get("tablesql");
        if (tablesql != null && !tablesql.isEmpty()) {
            wheresql += tablesql;
        }
        List<Map<String, Object>> data = assessmentSetDAO.getDatas(tablecode, wheresql, orderby);
        backMap.put("data", data);
        return backMap;
    }

    /**
     * 列表保存.
     *
     * @param params --
     * @return --
     */
    public void save(HashMap<String, Object> params) throws AppException {
        //表名
        String tablecode = (String) params.get("tablecode");
        //全部数据
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        //删除数据
        List<Map<String, Object>> deldatas = (List<Map<String, Object>>) params.get("deldatas");

        List<Map<String, Object>> addlist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> uplist = new ArrayList<Map<String, Object>>();
        List<Map<String, Object>> dellist = new ArrayList<Map<String, Object>>();
        int i = 1;
        for (Map<String, Object> map : datas) {
            String rowtype = (String) map.get("rowtype");
            String name = (String) map.get("name");
            map.put("ordernum", i++);
            if (rowtype != null && "add".equals(rowtype)) {
                map.put("createtime", StringUtil.getSysDBDate());
                map.put("updatetime", StringUtil.getSysDBDate());
                map.put("creater", SecureUtil.getCurrentUser().getGuid());
                map.put("province", SecureUtil.getUserSelectProvince());
                map.put("year", CommonUtil.getYear());
                addlist.add(map);
            } else {
                uplist.add(map);
            }
            if(name != null && ("总得分".equals(name) || "评分等级".equals(name))){
                map.put("superid", "");
            }
        }

        for (Map<String, Object> map : deldatas) {
            Integer levelno = (Integer) map.get("levelno");
            if (levelno != null && levelno == 1) {
                dellist.add(map);
            }
        }

        if (addlist.size() > 0) {
            assessmentSetDAO.saveAll(addlist, tablecode);
        }
        if (uplist.size() > 0) {
            assessmentSetDAO.updateAllByPK(uplist, "guid", tablecode);
        }
        if (deldatas.size() > 0) {
            assessmentSetDAO.saveAll(deldatas, assessmentSetDAO.PMKPI_TABLE_TMP_AGENCY);
            String delsql = " exists(select 1 from " + assessmentSetDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.guid)";
            assessmentSetDAO.delDatas(tablecode, delsql);
            assessmentSetDAO.delDatas(assessmentSetDAO.PMKPI_TABLE_TMP_AGENCY, "1=1");
            //删除一级指标下所有二级指标
            assessmentSetDAO.saveAll(dellist, assessmentSetDAO.PMKPI_TABLE_TMP_AGENCY);
            delsql = " exists(select 1 from " + assessmentSetDAO.PMKPI_TABLE_TMP_AGENCY + " a where a.guid=t.superid)";
            assessmentSetDAO.delDatas(tablecode, delsql);
        }
    }
}
