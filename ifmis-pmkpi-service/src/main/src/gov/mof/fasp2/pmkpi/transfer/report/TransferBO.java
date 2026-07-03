package gov.mof.fasp2.pmkpi.transfer.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.perfutil.PerfConstant;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


public class TransferBO extends PmkpiBO {

    private TransferDAO transferDAO;

    public void setTransferDAO(TransferDAO transferDAO) {
        this.transferDAO = transferDAO;
    }

    public void saveTransfer(List<Map<String, Object>> proList, String oldYear, String province) throws AppException {
        List<Map<String, Object>> savePros = new ArrayList<>();
        List<Map<String, Object>> saveGoals = new ArrayList<>();
        List<Map<String, Object>> saveIndexs = new ArrayList<>();
        Map<String, Object> busMap = new HashMap<>();
        StringBuffer transferSql = new StringBuffer();
        for (int i=0; i < proList.size(); i++) {
            Map<String, Object> map = proList.get(i);
            String proCode = (String) map.get("pro_code"); //项目code
            String busId = (String) map.get("busid"); //预算业务主键
            busMap.put(busId + "#-#" + proCode, proCode);
            transferSql.append("(pro_code='").append(proCode).append("' and busid='").append(busId).append("')");
            if (i != (proList.size() - 1)) {
                transferSql.append(" or ");
            }
        }
        List procodes = busMap.values().stream().distinct().collect(Collectors.toList());
        String wheresql = transferDAO.createInSql("pro_code", procodes);
        //查询项目表项目
        List<Map<String, Object>> proDatas = transferDAO.getDatas(transferDAO.PMKPI_TABLE_PROJECT_INFO, wheresql, null);
        //校验传递的项目编码与本地查询的项目编码不存在的情况，则抛除异常，返给预算系统，那边进行阻断。
        List curprocodes = new ArrayList();
        proDatas.forEach(x ->{
            curprocodes.add(x.get("pro_code"));
        });
        List temppros = (List) procodes.stream().filter(item -> !curprocodes.contains(item)).collect(Collectors.toList());
        if (temppros.size() > 0) {
            throw new AppException("结转涉及项目无效，请检查！"+temppros.toString());
        }
        if (proDatas.size() > 0) {
            //查询到的项目，根据项目编码进行判断，储到结转项目表，同一项目编码，busid不同，所以同一项目编码会存在多条数据，根据busid进行区分
            List<String> procodeList = new ArrayList<>();//项目表项目编码集合
            for (Map<String, Object> projectMap : proDatas) {
                String pro_code = (String) projectMap.get("pro_code");
                procodeList.add(pro_code);
                for (String key : busMap.keySet()) {
                    String procode = (String) busMap.get(key);
                    if (procode.equals(pro_code)) {
                        String busid = key.split("#-#")[0];
                        this.setPro(projectMap, busid, "add");
                        savePros.add(new HashMap<>(projectMap));
                    }
                }
            }
            //删除绩效结转项目表项目，根据项目编码+busid
            transferDAO.delDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_PROJECT, transferSql.toString());
            transferDAO.delDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_GOAL, wheresql);
            transferDAO.delDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_INDICATOR, wheresql);
            //查询结转年度目标，不存在，查询上一年度的绩效年度目标，存放到结转目标表
            List<Map<String, Object>> transGoals = transferDAO.getDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_GOAL, wheresql, null);
            //不存在结转目标的项目编码
            List<String> unprocode = new ArrayList<>();
            for (String procode : procodeList) {
                boolean isprocode = false;
                for (Map<String, Object> transGoal : transGoals) {
                    String pro_code = (String) transGoal.get("pro_code");
                    if (pro_code.equals(procode)) {
                        isprocode = true;
                    }
                }
                if (!isprocode) {
                    unprocode.add(procode);
                }
            }
            String pmSql = " and t.is_deleted = 2 and t.yearflag = '0' and is_backup=2 and t.year ='" + oldYear + "' and t.province = '" + province + "'";
            if (unprocode.size() > 0) {
                String wsql = transferDAO.createInSql(" pro_code", unprocode) + pmSql;
                List<Map<String, Object>> goals = transferDAO.getDatas("PM_PERF_GOAL_INFO", wsql, null);
                if (goals.size() > 0) {
                    this.setGoalAndIndex(goals, null, "add");
                    saveGoals.addAll(goals);
                }
            }
            //查询结转指标，不存在，查询上一年度的绩效年度指标，存放到结转指标表
            List<Map<String, Object>> transIndexs = transferDAO.getDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_INDICATOR, wheresql, null);
            //结转项目不存在绩效指标的项目编码
            unprocode = new ArrayList<>();
            for (String procode : procodeList) {
                boolean isprocode = false;
                for (Map<String, Object> transIndex : transIndexs) {
                    String pro_code = (String) transIndex.get("pro_code");
                    if (pro_code.equals(procode)) {
                        isprocode = true;
                    }
                }
                if (!isprocode) {
                    unprocode.add(procode);
                }
            }
            if (unprocode.size() > 0) {
                String wsql = transferDAO.createInSql(" pro_code", unprocode) + pmSql;
                List<Map<String, Object>> indexs = transferDAO.getDatas("PM_PERF_INDICATOR", wsql, null);
                if (indexs.size() > 0) {
                    this.setGoalAndIndex(indexs, null, "add");
                    saveIndexs.addAll(indexs);
                }
            }
            if (savePros.size() > 0) {
                transferDAO.saveAll(savePros, transferDAO.PMKPI_TABLE_T_TRANSFER_PROJECT);
            }
            if (saveGoals.size() > 0) {
                transferDAO.saveAll(saveGoals, transferDAO.PMKPI_TABLE_T_TRANSFER_GOAL);
            }
            if (saveIndexs.size() > 0) {
                transferDAO.setIndexDatas(saveIndexs, "PM001", false);
                transferDAO.saveAll(saveIndexs, transferDAO.PMKPI_TABLE_T_TRANSFER_INDICATOR);
            }
        }
    }

    /**
     *  终审:
     *  需要给规范表的项目绩效目标，指标放入终审数据（注意保持kpi_id不变，update_time更新日期）
     *  如果本身存在当前年度绩效数据，则不存放规范表，同时要记录一下是否是结转项目来源。
     */
    public void auditPerf(List<Map<String, Object>> proList) throws AppException {
        List<Map<String, Object>> updatePros = new ArrayList<>();
        List<Map<String, Object>> saveGoals = new ArrayList<>();
        List<Map<String, Object>> saveIndexs = new ArrayList<>();
        StringBuffer transferSql = new StringBuffer();
        for (int i=0; i < proList.size(); i++) {
            Map<String, Object> map = proList.get(i);
            String proCode = (String) map.get("pro_code"); //项目code
            String busId = (String) map.get("busid"); //预算业务主键
            transferSql.append(" (pro_code='").append(proCode).append("' and busid='").append(busId).append("') ");
            if (i != (proList.size() - 1)) {
                transferSql.append(" or ");
            }
        }
        //查询进行终审操作的结转项目，根据项目编码+busid
        List<Map<String, Object>> transDatas = transferDAO.getDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_PROJECT, transferSql.toString(), null);
        if (transDatas.size() > 0) {
            Map<String, Object> transMap = new HashMap<>();
            //进行终审操作的结转项目，同一项目编码，busid不同
            List<String> procodeList = new ArrayList<>();
            for (Map<String, Object> projectMap : transDatas) {
                String pro_code = (String) projectMap.get("pro_code");
                this.setPro(projectMap, null, "audit");
                updatePros.add(projectMap);
                String transGuid = (String) projectMap.get("guid");
                transMap.put(pro_code, transGuid);
                if (!procodeList.contains(pro_code)) {
                    procodeList.add(pro_code);
                }
            }
            //2、查询绩效年度目标，如果不存在判断结转表里是否存在，存在，新增到申报表
            String pmSql = transferDAO.createInSql("pro_code", procodeList) + " and t.yearflag = 0 ";
            List<Map<String, Object>> pmGoals = transferDAO.getDatas(PerfConstant.PMKPI_VPM_GOAL_INFO, pmSql, null);
            //获取不存在年度目标的项目编码
            List<String> unprocode = new ArrayList<>();
            String wheresql = "";
            for (String procode : procodeList) {
                boolean isprocode = false;
                for (Map<String, Object> pmgoal : pmGoals) {
                    String pro_code = (String) pmgoal.get("pro_code");
                    if (pro_code.equals(procode)) {
                        isprocode = true;
                    }
                }
                if (!isprocode) {
                    unprocode.add(procode);
                }
            }
            if (unprocode.size() > 0) {
                wheresql = transferDAO.createInSql("pro_code", unprocode);
                List<Map<String, Object>> transGoals = transferDAO.getDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_GOAL, wheresql, null);
                if (transGoals.size() > 0) {
                    this.setGoalAndIndex(transGoals, transMap, "audit");
                    saveGoals.addAll(transGoals);
                }
            }
            //3、查询绩效年度指标，如果不存在判断结转指标表是否存在，存在新增到申报表
            List<Map<String, Object>> pmIndexs = transferDAO.getDatas(PerfConstant.PMKPI_VPM_INDICATOR, pmSql, null);
            //获取不存在年度指标的项目编码
            unprocode = new ArrayList<>();
            for (String procode : procodeList) {
                boolean isprocode = false;
                for (Map<String, Object> pmindex : pmIndexs) {
                    String pro_code = (String) pmindex.get("pro_code");
                    if (pro_code.equals(procode)) {
                        isprocode = true;
                    }
                }
                if (!isprocode) {
                    if (!isprocode) {
                        unprocode.add(procode);
                    }
                }
            }
            if (unprocode.size() > 0) {
                wheresql = transferDAO.createInSql("pro_code", unprocode);
                List<Map<String, Object>> transIndexs = transferDAO.getDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_INDICATOR, wheresql, null);
                if (transIndexs.size() > 0) {
                    this.setGoalAndIndex(transIndexs, transMap, "audit");
                    saveIndexs.addAll(transIndexs);
                }
            }
            if (updatePros != null && !updatePros.isEmpty()) {
                transferDAO.updateAll(updatePros, transferDAO.PMKPI_TABLE_T_TRANSFER_PROJECT); // 结转项目终审
            }
            if (saveGoals != null && !saveGoals.isEmpty()) {
                transferDAO.saveAll(saveGoals, PerfConstant.PMKPI_VPM_GOAL_INFO);
            }
            if (saveIndexs != null && !saveIndexs.isEmpty()) {
                transferDAO.setIndexDatas(saveIndexs, "PM001", false);
                transferDAO.saveAll(saveIndexs, PerfConstant.PMKPI_VPM_INDICATOR);
            }
        }
    }

    /**
     *  取消终审:
     *  先判断结转项目关联表（PERF_TRANSFER_PROJECT） 是否还存在终审，
     *  同一项目编码下存在不同的busid，如果存在同一项目编码下，有终审状态011的数据，则不处理（规范表pm_pert_**）绩效目标、指标数
     *  如果不存在，则需要查询规范表中的结转插入的数据，删除掉，同时更新一下update_time
     *  因为对于一个项目结转资金可以分多次过来在结转功能中申报绩效。
     */
    public void calcelAudit(List<Map<String, Object>> proList) throws AppException {
        List<Map<String, Object>> updatePros = new ArrayList<>();
        List<Map<String, Object>> updateGoals = new ArrayList<>();
        List<Map<String, Object>> updateIndexs = new ArrayList<>();
        List<String> procodes = new ArrayList<>();
        String transferSql = "";
        Map<String, Object> busMap = new HashMap<>();//记录哪些结转项目进行取消终审操作
        for (int i=0; i < proList.size(); i++) {
            Map<String, Object> map = proList.get(i);
            String proCode = (String) map.get("pro_code"); //项目code
            String busId = (String) map.get("busid"); //预算业务主键
            if (!procodes.contains(proCode)) {
                procodes.add(proCode);
            }
            busMap.put(busId + "#-#" + proCode, proCode);
        }
        transferSql = transferDAO.createInSql("pro_code", procodes);
        //1、根据接口传过来的项目编码，查询这个编码下所有的结转项目
        List<Map<String, Object>> transDatas = transferDAO.getDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_PROJECT, transferSql.toString(), null);
        if (transDatas.size() > 0) {
            List<String> procodeList = new ArrayList<>();//已终审项目编码
            List<String> uncode = new ArrayList<>();//需要处理指标、目标的项目编码
            //存在结转项目，根据结转项目，对取消审核的结转项目进行处理，过滤出，需要处理绩效年度目标、指标的项目编码
            for (Map<String, Object> transMap : transDatas) {
                String busid = (String) transMap.get("busid");
                String pro_code = (String) transMap.get("pro_code");
                //是否是取消的结转项目
                if (busMap.containsKey(busid + "#-#" + pro_code)) {
                    this.setPro(transMap, null, "calcel");
                    updatePros.add(transMap);
                }
                String wfstatus = (String) transMap.get("wfstatus");
                if ("011".equals(wfstatus)) {
                    if (!procodeList.contains(pro_code)) {
                        procodeList.add(pro_code);
                    }
                }
                if (!uncode.contains(pro_code)) {
                    uncode.add(pro_code);
                }
            }
            uncode.removeAll(procodeList);
            if (uncode.size() > 0) {
                //根据结转项目编码查询是否存在年度目标数据，存在，进行删除操作
                String pmSql = transferDAO.createInSql("pro_code", uncode) + " and t.yearflag = 0 and t.transguid is not null";
                List<Map<String, Object>> pmGoals = transferDAO.getDatas(PerfConstant.PMKPI_VPM_GOAL_INFO, pmSql, null);
                if (pmGoals.size() > 0) {
                    this.setGoalAndIndex(pmGoals, null, "calcel");
                    updateGoals.addAll(pmGoals);
                }
                //根据结转项目编码查询是否存在年度指标数据，存在，进行删除操作
                List<Map<String, Object>> pmIndexs = transferDAO.getDatas(PerfConstant.PMKPI_VPM_INDICATOR, pmSql, null);
                if (pmIndexs.size() > 0) {
                    this.setGoalAndIndex(pmIndexs, null, "calcel");
                    updateIndexs.addAll(pmIndexs);
                }
                if (updateGoals != null && !updateGoals.isEmpty()) {
                    transferDAO.updateAll(updateGoals, PerfConstant.PMKPI_VPM_GOAL_INFO);
                }
                if (updateIndexs != null && !updateIndexs.isEmpty()) {
                    transferDAO.updateAll(updateIndexs, PerfConstant.PMKPI_VPM_INDICATOR);
                }
            }
            if (updatePros != null && !updatePros.isEmpty()) {
                transferDAO.updateAll(updatePros, transferDAO.PMKPI_TABLE_T_TRANSFER_PROJECT);
            }
        }
    }


    public void setPro(Map<String, Object> map, String busId, String type) {
        if ("add".equals(type)) {
            map.put("guid", this.getCreateguid());
            map.put("busid", busId);
            map.put("wfstatus", "000");
            map.put("create_time", PerfUtil.getServerTimeStamp());
            map.put("createtime", PerfUtil.getServerTimeStamp());
        } else if ("audit".equals(type)) {
            map.put("wfstatus", "011");
        } else if ("calcel".equals(type)) {
            map.put("wfstatus", "000");
        }
        map.put("update_time", PerfUtil.getServerTimeStamp());
        map.put("updatetime", PerfUtil.getServerTimeStamp());
    }

    public void setGoalAndIndex(List<Map<String, Object>> list, Map transMap, String type) {
        if ("add".equals(type)) {
            for (Map<String, Object> map : list) {
                map.put("guid", this.getCreateguid());
                map.put("yearflag", "0");
                map.put("is_last_inst", 2);
                map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_JZRCDTWH);
                this.getBasMap(map, "add");
            }
        } else if ("audit".equals(type)) {
            for (Map<String, Object> map : list) {
                String pro_code = (String) map.get("pro_code");
                map.put("guid", this.getCreateguid());
                map.put("transguid", transMap.get(pro_code)); // 结转来源
                map.put("yearflag", "0"); // 结转来源
                map.put("is_last_inst", 1);
                map.put("version_name", PerfConstant.PMKPI_VERSION_NAME_JZRCDTWH);
                this.getBasMap(map, "add");
            }
        } else if ("calcel".equals(type)) {
            for (Map<String, Object> map : list) {
                map.put("is_deleted", "1"); // 删除
                map.put("update_time", PerfUtil.getServerTimeStamp());
                map.put("updatetime", PerfUtil.getServerTimeStamp());
            }
        }
    }

    /**
     * 查询各年度数据.
     *
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws --           异常.
     */
    public Map<String, Object> getAllGoal(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String showtab = (String) params.get("showtab"); ////页签显示 1总+年2总3年
        String procode = (String) params.get("procode");
        String year = (String) params.get("year");
        String[] tempfilter = new String[2];
        Map<String, Object> yearsMap = new HashMap<String, Object>();
        String yearflag = "0";
        if ("1".equals(showtab)) {
            tempfilter = new String[]{"1", "0"};
        } else if ("2".equals(showtab)) {
            tempfilter = new String[]{"1"};
        } else {
            tempfilter = new String[]{"0"};
        }
        List<Map<String, Object>> goals = null;
        goals = transferDAO.getGoalsByFilter(proguid, procode, tempfilter, year);
        if (goals != null && goals.size() > 0) {
            for (Map<String, Object> map : goals) {
                yearflag = (String) map.get("yearflag");
                this.getBasMap(map, "add");
                params.put("yearflag", yearflag);
                if (yearflag != null && !"0".equals(yearflag)) {
                    yearsMap.put("#total", map);
                } else {
                    yearsMap.put("#year", map);
                }
            }
        }
        return yearsMap;
    }

    /**
     * 查询各年度指标数据.
     *
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws --           异常.
     */
    public Map<String, Object> findAllIndex(Map<String, Object> params) throws AppException {
        String proguid = (String) params.get("proguid");
        String showtab = (String) params.get("showtab"); ////页签显示 1总+年2总3年
        String procode = (String) params.get("procode");
        String year = (String) params.get("year");
        String[] tempfilter = new String[2];
        if (showtab != null && "1".equals(showtab)) {
            tempfilter = new String[]{"1", "0"};
        } else if (showtab != null && "2".equals(showtab)) {
            tempfilter = new String[]{"1"};
        } else {
            tempfilter = new String[]{"0"};
        }
        Map<String, Object> resultmap = transferDAO.findIndexList(proguid, procode, tempfilter, year);
        return resultmap;
    }

    /**
     * 最终保存方法.
     *
     * @param params -- 参数集合.
     * @return 审核定义结果.
     * @throws AppException -- 异常.
     */
    public Map<String, Object> saveGoal(HashMap<String, Object> params) throws AppException {
        String busguid = (String) params.get("busguid");
        String showtab = (String) params.get("showtab");
        String projguid = (String) params.get("projguid");
        String saveAgency = (String) params.get("saveAgency");
        String procode = (String) params.get("procode");
        String tablecode = transferDAO.PMKPI_TABLE_T_TRANSFER_GOAL;
        Map<String, Object> goaldata = (Map<String, Object>) params.get("goaldata"); //多页签的数据
        List<Map<String, Object>> goallist = new ArrayList<>(); //目标集合
        if ("1".equals(showtab)) {
            Map<String, Object> yearmap = (Map<String, Object>) goaldata.get("#year");
            String guid = (String) yearmap.get("guid");
            if (guid == null || guid.length() == 0 || "".equals(guid)) {//一般guid不会为空 结转上年年度肯定有数据（？？）
                guid = this.getCreateguid();
                yearmap.put("guid", guid);
            }
            //根据guid获取目标
            Map<String, Object> data = transferDAO.getDataMap(tablecode, "guid=?", new String[]{guid});
            String kpi_target = (String) yearmap.get("kpi_target");
            if (kpi_target == null || kpi_target.isEmpty()) {
                yearmap.put("kpi_target", "无目标");
            }
            if (!data.isEmpty()) {
                //修改
                data.put("kpi_target", kpi_target);
                data.put("updatetime", PerfUtil.getServerTimeStamp());
                data.put("update_time", PerfUtil.getServerTimeStamp());
                goallist.add(data);
                transferDAO.update(data, tablecode);
            } else {
                //先删除结转表内现存数据
                String wheresql = " t.pro_code = '" + procode + "'";
                transferDAO.delDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_GOAL, wheresql);
                //新增
                yearmap.put("pro_code", procode);
                yearmap.put("agencyguid", saveAgency);
                yearmap.put("yearflag", "0");
                yearmap.put("goalname", "年度目标1");
                yearmap.put("mainguid", projguid);
                this.getBasMap(yearmap, "add");
                goallist.add(yearmap);
                transferDAO.save(yearmap, tablecode);
            }

        }
        return this.auditdefine(goallist, busguid, "perf", null);
    }

    /**
     * 查询项目上年度指标数据.
     *
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws --           异常.
     */
    public List<Map<String, Object>> lastYearIndex(Map<String, Object> params) throws AppException {
        StringBuffer sql = new StringBuffer();
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode");
        sql.append(" select p.*,'' as obligate1 from pm_perf_indicator p where yearflag = '0' and is_deleted=2 and is_backup =2");
        sql.append(" and province = '").append(SecureUtil.getUserSelectProvince()).append("' ");
        sql.append(" and year = '").append(SecureUtil.getUserSelectYear() - 1).append("'");
        sql.append(" and pro_code = '").append(procode).append("'");
        if (PerfUtil.getProgramIsyear()) {
            sql.append(" and is_adj = 2");
        }
        List<Map<String, Object>> resultlist = transferDAO.queryForList(sql.toString());
        return resultlist;
    }

    /**
     * 查询项目上年度目标数据.
     *
     * @param params -- 参数集合.
     * @return yearsMap.
     * @throws AppException -- 异常.
     * @throws --           异常.
     */
    public List<Map<String, Object>> lastYearGoal(Map<String, Object> params) throws AppException {
        StringBuffer sql = new StringBuffer();
        String proguid = (String) params.get("proguid");
        String procode = (String) params.get("procode");
        sql.append(" select p.* from pm_perf_goal_info p where yearflag = '0' and is_deleted=2 and is_backup=2 ");
        sql.append(" and province = '").append(SecureUtil.getUserSelectProvince()).append("' ");
        sql.append(" and year = '").append(SecureUtil.getUserSelectYear() - 1).append("'");
        sql.append(" and pro_code = '").append(procode).append("'");
        if (PerfUtil.getProgramIsyear()) {
            sql.append(" is_adj = 2");
        }
        List<Map<String, Object>> resultlist = transferDAO.queryForList(sql.toString());
        return resultlist;
    }


    /**
     * 结转指标保存
     *
     * @param params -- 参数.
     * @return
     * @throws AppException -- 自定义异常.
     */
    public Map<String, Object> saveIndex(HashMap<String, Object> params) throws AppException {
        String proguid = (String) params.get("projguid");
        String busguid = (String) params.get("busguid");
        String procode = (String) params.get("procode"); //项目编码
        String saveAgency = (String) params.get("saveAgency");
        List<Map<String, Object>> indexList = new ArrayList<Map<String, Object>>(); //指标集合
        Map<String, Object> tabcomps = (Map<String, Object>) params.get("datas"); //多页签的数据
        List<Map<String, Object>> yearList = (List<Map<String, Object>>) tabcomps.get("#year");
        if (yearList != null && yearList.size() > 0) {
            for (Map tempMap : yearList) {
                String levelno = PerfUtil.mapGetInt(tempMap, "levelno") + "";
                String rowtype = (String) tempMap.get("rowtype");
                if ("3".equals(levelno) && "add".equals(rowtype)) {
                    tempMap.put("guid", this.getCreateguid());
                    tempMap.put("create_time", PerfUtil.getServerTimeStamp());
                    tempMap.put("createtime", PerfUtil.getServerTimeStamp());
                    tempMap.put("update_time", PerfUtil.getServerTimeStamp());
                    tempMap.put("updatetime", PerfUtil.getServerTimeStamp());
                    tempMap.put("year", CommonUtil.getYear());
                    tempMap.put("mainguid", proguid);
                    tempMap.put("pro_code", procode);
                    tempMap.put("yearflag", "0");
                    tempMap.put("fiscal_year", CommonUtil.getYear());
                    if (tempMap.get("agency_code") == null) {
                        tempMap.put("agency_code", saveAgency);
                    }
                    indexList.add(tempMap);
                }
            }
        }
        if (indexList.size() > 0) {
            //先删除结转表内现存数据
            String wheresql = " t.pro_code = '" + procode + "'";
            transferDAO.delDatas(transferDAO.PMKPI_TABLE_T_TRANSFER_INDICATOR, wheresql);
            //再重新新增
            transferDAO.saveAll(indexList, transferDAO.PMKPI_TABLE_T_TRANSFER_INDICATOR);
        }
        return this.auditdefine(indexList, busguid, "perf", null);
    }

}
