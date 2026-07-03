package gov.mof.fasp2.pmkpi.perfprogram.goal;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: SelLastYearProBO
 * @Description: 复制上年目标-选择上年项目(选择本项目单位下的填报过上年年度绩效目标项目）保存本项目和上年项目的对应关系
 */

public class SelLastYearProBO extends PmkpiBO {
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
        String tablecode = (String) sqlmap.get("tablecode");
        String agency_code = (String) sqlmap.get("agency_code");
        Integer year = Integer.parseInt(CommonUtil.getYear()) -1;
        StringBuffer sql = new StringBuffer("select * from ");
        sql.append(tablecode).append(" t ");
        //存在上年年度绩效目标
        sql.append(" where exists(select 1 from pm_perf_goal_info a where t.pro_code = a.pro_code and t.province = a.province and a.yearflag = '0' and a.is_deleted = 2 and a.year = "+year+")");
        //本项目所属单位权限
        sql.append(" and t.agency_code ='").append(agency_code).append("'");
        return sql.toString();
    }

    /**
     * 保存方法
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> saveData(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        String pro_code = (String) params.get("pro_code");
        String pro_name = (String) params.get("pro_name");
        if (StringUtil.isEmpty(pro_name)) {
            Map<String, Object> promap = prjIndexDAO.getDataMap(prjIndexDAO.PMKPI_TABLE_ALLPROJECT_INFO, "t.pro_code='" + pro_code + "'");
            pro_name = (String) promap.get("pro_name");
        }
        // 处理本项目对应上年项目关系
        List<Map<String, Object>> selpros = (List<Map<String, Object>>) params.get("selpros");
        if(selpros!=null && selpros.size()>0){
            for (Map<String, Object> map : selpros) {
                map.put("guid",this.getCreateguid());
                map.put("last_pro_code",map.get("pro_code"));
                map.put("last_pro_name",map.get("pro_name"));
                map.put("pro_code",pro_code);
                map.put("pro_name",pro_name);
                map.put("province",CommonUtil.getProvince());
                map.put("year",CommonUtil.getYear());
            }
            prjIndexDAO.delDatas("v_perf_prolastyear", "pro_code ='"+pro_code+"'");
            prjIndexDAO.saveAll(selpros,"perf_t_prolastyear");
        }
        // 调用复制上年目标
        PrjIndexBO prjIndexBO = (PrjIndexBO) PerfServiceFactory.getBean("pmkpi.goal.PrjIndexBOTX");
        return prjIndexBO.copyGoal(params);
    }

    /**
     * 获取选中的项目用于回显
     * @param params
     * @return
     * @throws AppException
     */
    public List<Map<String, Object>> getSelData(Map<String, Object> params) throws AppException {
        String pro_code = (String) params.get("pro_code");
        List<Map<String, Object>> prolastyearlist = prjIndexDAO.getDatas("v_perf_prolastyear", "pro_code = '"+pro_code+"'",null);
        return prolastyearlist;
    }

    /**
     * 获取上年项目对应关系，包含预算关系和绩效自行勾选项目关系
     * @param params
     * @return
     * @throws AppException
     */
    public Map<String, Object> getLastProData(Map<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap();
        String pro_code = (String) params.get("pro_code");
        List<Map<String, Object>> bgtprolastyearlist = prjIndexDAO.getDatas("v_perf_bgtprolastyear", "pro_code = '"+pro_code+"'",null);
        List<Map<String, Object>> prolastyearlist = prjIndexDAO.getDatas("v_perf_prolastyear", "pro_code = '"+pro_code+"'",null);
        prolastyearlist.addAll(bgtprolastyearlist);
        backmap.put("prolastyearlist",prolastyearlist);
        return backmap;
    }
}
