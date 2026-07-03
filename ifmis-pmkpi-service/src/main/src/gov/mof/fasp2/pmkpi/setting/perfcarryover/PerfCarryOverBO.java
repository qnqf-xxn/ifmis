package gov.mof.fasp2.pmkpi.setting.perfcarryover;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PerfCarryOverBO extends PmkpiBO {

    private PerfCarryOverDAO perfCarryOverDAO;

    public void setPerfCarryOverDAO(PerfCarryOverDAO perfCarryOverDAO) {
        this.perfCarryOverDAO = perfCarryOverDAO;
    }

    @Override
    public String getVodSql(Map params) throws AppException {
        String tablesql = (String)params.get("tablesql");
        String wheresql = (String)params.get("querySql");
        String tablecode = (String) params.get("tablecode");
        String tabcode = (String) params.get("tabcode");
        String tabfilter = (String) params.get("tabfilter");
        String lefttabtype = (String) params.get("lefttabtype");
        String isleaf = (String) params.get("isleaf");
        String agency = (String) params.get("agency");
        StringBuffer sql = new StringBuffer("select * from ");
        if(!StringUtil.isNullOrEmpty(tabcode) && "uncarryover".equals(tabcode)){///未结转
            tablecode = perfCarryOverDAO.PMKPI_TABLE_PROJECTSOURCE;
        } else if(!StringUtil.isNullOrEmpty(tabcode) && "caarryovered".equals(tabcode)){///已结转
            tablecode = perfCarryOverDAO.PMKPI_TABLE_CARRYOVERTABLE;
        }
        sql.append(tablecode).append(" t where");
        sql.append(" bustype = '").append(lefttabtype).append("' ");
        if (wheresql != null && !wheresql.isEmpty()) {
            sql.append(" and (").append(wheresql).append(")");
        }
        if (tablesql != null && !tablesql.isEmpty()) {
            sql.append(" and (").append(tablesql).append(")");
        }
        if (tabfilter != null && !tabfilter.isEmpty()) {
            sql.append(" and (").append(tabfilter).append(")");
        }
        String columncode = "agencyguid";
        sql.append(this.getLeftTreeWheresql(isleaf, columncode, agency, perfCarryOverDAO.PMKPI_TABLE_T_AGENCY));
        return sql.toString();
    }

    public List<Map<String, Object>> getTreeData(HashMap<String, Object> params) throws AppException {
        String tablecode = "";
        String tabcode = (String) params.get("tabcode");
        String lefttabtype = (String) params.get("lefttabtype");
        //根据权限查询单位
        String wheresql = " bustype='" + lefttabtype + "' ";
        if(!StringUtil.isNullOrEmpty(tabcode) && "uncarryover".equals(tabcode)){///未结转
            tablecode = perfCarryOverDAO.PMKPI_TABLE_PROJECTSOURCE;
        } else if(!StringUtil.isNullOrEmpty(tabcode) && "caarryovered".equals(tabcode)){///已结转
            tablecode = perfCarryOverDAO.PMKPI_TABLE_CARRYOVERTABLE;
        }
        return perfCarryOverDAO.getLeftTree(tablecode, wheresql);
    }

    /**
     * 结转/取消结转
     * @param params --
     * @return --
     */
    public Map<String, Object> carryover(HashMap<String, Object> params) throws AppException {
        Map<String, Object> backmap = new HashMap<String, Object>();
        List<Map<String, Object>> datas = (List<Map<String, Object>>) params.get("datas");
        String lefttabtype = (String) params.get("lefttabtype");
        String actioncode = (String) params.get("actioncode");
        datas.forEach(m -> m.put("guid",m.get("pro_code")));
        perfCarryOverDAO.saveAll(datas, perfCarryOverDAO.PMKPI_TABLE_TMP_GUIDS);
        String prosql = " exists(select 1 from " + perfCarryOverDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code)";
        String year = String.valueOf(SecureUtil.getUserSelectYear());
        String lastyear = String.valueOf(SecureUtil.getUserSelectYear()-1);
        List<Map<String, Object>> carrylist = perfCarryOverDAO.getDatas(perfCarryOverDAO.PMKPI_TABLE_CARRYOVERTABLE, prosql,null);
        if("carryover".equals(actioncode)){//结转 更新本年度绩效已有数据为删除，复制上年度绩效插入新增
            // 先判断是否存在已结转数据避免异常操作
            if(carrylist.size() > 0){
                backmap.put("success",false);
                backmap.put("error","所选项目包含已结转项目，请刷新页面确认！");
                return backmap;
            }
            // 先确认存在上年目标指标数据范围 部标2.0待增加条件 and is_backup=2 and sub_mof_div_code is null
            String carrysql = prosql
                    + " and exists(select 1 from " + perfCarryOverDAO.PMKPI_TABLE_PM_GOAL + " t1 where t1.yearflag = '0' and t1.is_deleted = 2 and t1.is_backup=2 and t1.sub_mof_div_code is null and t1.year = "+lastyear+" and t1.pro_code=t.pro_code and t1.province = t.province)"
                    + " and exists(select 1 from " + perfCarryOverDAO.PMKPI_TABLE_PM_INDICATOR + " t2 where t2.yearflag = '0' and t2.is_deleted = 2 and t2.is_backup=2 and t2.sub_mof_div_code is null and t2.year = "+lastyear+" and t2.pro_code=t.pro_code and t2.province = t.province)";
            List<Map<String, Object>> waitcarrylist = perfCarryOverDAO.getDatas(perfCarryOverDAO.PMKPI_TABLE_PROJECTSOURCE, carrysql,null);
            logger.info("++++++++++++绩效结转，待【结转】的项目数量："+ waitcarrylist.size());
            if(waitcarrylist.size() == 0 || datas.size()>waitcarrylist.size()){
                backmap.put("success",false);
                backmap.put("error","所选项目上年未填报年度绩效目标或指标无法结转，请确认！");
            }else{
                backmap.put("success",true);
            }
            // 范围为空则直接返回
            if(waitcarrylist.size() == 0 ){
                return backmap;
            }
            waitcarrylist.forEach(m -> m.put("guid",m.get("pro_code")));
            perfCarryOverDAO.delDatas(perfCarryOverDAO.PMKPI_TABLE_TMP_GUIDS, null);
            perfCarryOverDAO.saveAll(waitcarrylist, perfCarryOverDAO.PMKPI_TABLE_TMP_GUIDS);
            // 查询本年度结转数据更新删除 部标2.0待增加条件 and is_backup=2 and sub_mof_div_code is null
            String delsql = " exists(select 1 from " + perfCarryOverDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code) and t.yearflag = '0' and t.is_deleted = 2 and t.is_backup=2 and t.sub_mof_div_code is null and t.year = "+year+" ";
            perfCarryOverDAO.updateIsDeleteDatas(perfCarryOverDAO.PMKPI_TABLE_PM_GOAL, delsql);
            perfCarryOverDAO.updateIsDeleteDatas(perfCarryOverDAO.PMKPI_TABLE_PM_INDICATOR, delsql);
            // 根据waitcarrylist范围处理上年目标指标保存到本年度 部标2.0待增加条件 and is_backup=2 and sub_mof_div_code is null
            String waitcarrysql = " exists(select 1 from " + perfCarryOverDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code) and t.yearflag = '0' and t.is_deleted = 2 and t.is_backup=2 and t.sub_mof_div_code is null and t.year = "+lastyear+" ";
            List<Map<String, Object>> lastgoallist = perfCarryOverDAO.getDatas(perfCarryOverDAO.PMKPI_TABLE_PM_GOAL, waitcarrysql,null);
            List<Map<String, Object>> lastindexlist = perfCarryOverDAO.getDatas(perfCarryOverDAO.PMKPI_TABLE_PM_INDICATOR, waitcarrysql,null);
            for (Map<String, Object> goal : lastgoallist) {
                String newguid = this.getCreateguid();
                goal.put("guid", newguid);
                goal.put("is_last_inst", 1);
                goal.put("version", "jxsnjz");
                goal.put("version_name", "日常动态维护版本_绩效上年结转");
                this.getBasMap(goal, "add");
            }
            for (Map<String, Object> index : lastindexlist) {
                String newguid = this.getCreateguid();
                index.put("guid", newguid);
                index.put("is_last_inst", 1);
                index.put("version", "jxsnjz");
                index.put("version_name", "日常动态维护版本_绩效上年结转");
                this.getBasMap(index, "add");
            }
            perfCarryOverDAO.saveAll(lastgoallist, perfCarryOverDAO.PMKPI_TABLE_PM_GOAL);
            perfCarryOverDAO.saveAll(lastindexlist, perfCarryOverDAO.PMKPI_TABLE_PM_INDICATOR);
            // 保存结转记录
            waitcarrylist.forEach(m -> {this.getBasMap(m, "add");m.put("bustype",lefttabtype);m.put("isreport_nowyear",1);});
            perfCarryOverDAO.saveAll(waitcarrylist, perfCarryOverDAO.PMKPI_TABLE_CARRYOVERTABLE);
        }else if("cancelcarryover".equals(actioncode)){//取消结转 更新本年度绩效为删除 业务需求不需要还原之前填报的数据
            // 先校验范围避免异常操作
            if(datas.size() != carrylist.size()){
                backmap.put("success",false);
                backmap.put("error","所选项目包含未结转项目，请刷新页面确认！");
                return backmap;
            }else{
                backmap.put("success",true);
            }
            logger.info("++++++++++++绩效结转，待【取消结转】的已结转项目数量："+ carrylist.size());
            // 查询本年度结转数据更新删除 部标2.0待增加条件 and is_backup=2 and sub_mof_div_code is null
            String carryedsql = " exists(select 1 from " + perfCarryOverDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code) and t.yearflag = '0' and t.is_deleted = 2 and t.year = "+year+" and t.version = 'jxsnjz' ";
            perfCarryOverDAO.updateIsDeleteDatas(perfCarryOverDAO.PMKPI_TABLE_PM_GOAL, carryedsql);
            perfCarryOverDAO.updateIsDeleteDatas(perfCarryOverDAO.PMKPI_TABLE_PM_INDICATOR, carryedsql);
            // 更新结转表删除
            carryedsql = " exists(select 1 from " + perfCarryOverDAO.PMKPI_TABLE_TMP_GUIDS + " a where a.guid=t.pro_code) ";
            perfCarryOverDAO.updateIsDeleteDatas(perfCarryOverDAO.PMKPI_TABLE_CARRYOVERTABLE, carryedsql);
        }
        return backmap;
    }

}
