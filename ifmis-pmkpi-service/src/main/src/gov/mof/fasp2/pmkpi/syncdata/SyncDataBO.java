package gov.mof.fasp2.pmkpi.syncdata;

import com.alibaba.fastjson.JSON;
import gov.mof.fasp2.buscommon.micro.MicroParamDTO;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.doubleprocess.otherapp.IBdmInterface;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;


public class SyncDataBO extends PmkpiBO {

    private PmkpiDAO pmkpiDAO;

    public PmkpiDAO getPmkpiDAO() {
        if(pmkpiDAO == null){
            pmkpiDAO = (PmkpiDAO) ServiceFactory.getBean("pmkpi.common.PmkpiDAO");
        }
        return pmkpiDAO;
    }
    /**
     * 同步预算数据到绩效
     * @param params
     * @return
     * @throws AppException
     */
    private Map<String, Object> queryBdmOfTabledata(Map<String, Object> params) throws AppException {
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        String tablecode = (String) params.get("tablecode");
        String savetable = (String) params.get("savetable");
        String pagecount = (String) params.get("pagecount");
        String wheresql = "";
        String delkey = "";
        String pkcolumn = "";
        String config = (String) params.get("config");//新增config配置项
        if(config!=null && !StringUtil.isEmpty(config)){
            Map<String, Object> configMap = JSON.parseObject(config);
            wheresql = (String)configMap.get("wheresql");
            delkey = (String)configMap.get("delkey");
            pkcolumn = (String)configMap.get("pkcolumn");
        }
        logger.info("==queryBdmOfTabledataCount 预算数据获取开始========");
        logger.info("==queryBdmOfTabledataCount 数据获取========province:"+province + ";year:"+year + ";tablecode:"+tablecode);
        //该接口存在表数据不存在，返回的result类型为false，需要做判断该种情况不抛异常
        IBdmInterface pmkpiinterface = ServiceFactory.getFeignClient(IBdmInterface.class);
        MicroParamDTO dto = pmkpiinterface.queryBdmOfTabledata(province,year,tablecode);
//        MicroParamDTO dto = new MicroParamDTO();
//        String wsql = "year=? and province=?";
//        int i = pmkpiDAO.getDataCount(tablecode, wsql, new String[]{year, province});
//        Map m = new HashMap();
//        m.put("result", true);
//        m.put("datacount", i+"");
//        dto.setMap(m);
        Map<String, Object> rsmap = dto.getMap();//获取数据量
        if(rsmap != null && !rsmap.isEmpty()){
            boolean success = (Boolean) rsmap.get("result");
            String num = (String) rsmap.get("datacount");
            logger.info("==queryBdmOfTabledataCount 数据获取========result:" + success + ";province:"+province + ";year:"+year + ";tablecode:"+tablecode+";datacount:" + num);
            if (success && !StringUtil.isEmpty(num)) {
                int datacount = Integer.parseInt(num);
                if (datacount > 0) {
                    if(!StringUtil.isNullOrEmpty(pkcolumn)){//存在新增的依据pkcolumn配置走新的增量逻辑
                        this.saveDataNew(params, Integer.parseInt(pagecount), datacount);
                    }else{
                        if(StringUtil.isEmpty(delkey)){//删除主键为空，直接按条件删除
                            //清除之前同步的该年度数据重新同步 新增删除处理拼接获取配置条件wheresql
                            getPmkpiDAO().delDatas(savetable,"year = '" + year + "' and province = '" + province + "'" + (StringUtil.isEmpty(wheresql)? "":" and " + wheresql));
                        }
                        this.saveData(params, Integer.parseInt(pagecount), datacount);
                    }
                }
                rsmap.put("success",true);
            } else if (!success && "0".equals(num)) {
                rsmap.put("success",true);
            } else {
                throw new AppException((String) rsmap.get("message"));
            }
        } else {
            logger.info("==queryBdmOfTabledataCount 数据获取失败========message:" + PerfUtil.parse2Json(rsmap));
            throw new AppException("同步预算数据失败！");
        }
        return rsmap;
    }

    private void saveData(Map<String, Object> params, Integer pagecount, Integer datacount) throws AppException {
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        String tablecode = (String) params.get("tablecode");
        String savetable = (String) params.get("savetable");
        String wheresql = "";
        String delkey = "";
        String config = (String) params.get("config");//新增config配置项
        if(config!=null && !StringUtil.isEmpty(config)){
            Map<String, Object> configMap = JSON.parseObject(config);
            wheresql = (String)configMap.get("wheresql");
            delkey = (String)configMap.get("delkey");
        }
        //一次性获取数据
        IBdmInterface pmkpiinterface = ServiceFactory.getFeignClient(IBdmInterface.class);
        MicroParamDTO dto = pmkpiinterface.getBdmOfTabledata(province, year, tablecode, datacount + "", "1");
//        MicroParamDTO dto = new MicroParamDTO();
//        Map m = new HashMap();
//        m.put("result", true);
//        String wsql = "year=? and province=?";
//        List<Map<String, Object>> list = pmkpiDAO.getDatas(tablecode, wsql, null, new String[]{year, province});
//        m.put("data", list);
//        dto.setMap(m);
        Map<String, Object> rsmap = dto.getMap();//获取数据
        if(rsmap != null && !rsmap.isEmpty() && (Boolean) rsmap.get("result")){
//            logger.info("==queryBdmOfTabledata 数据获取========result:"+rsmap.get("result"));
            List<Map<String, Object>> datalist = (List<Map<String, Object>>) rsmap.get("data");
            //处理数据
            if (datalist != null && datalist.size() > 0) {
                logger.info("==queryBdmOfTabledata 数据获取========province:"+province + ";year:"+year + ";tablecode:"+tablecode + ";pagecount:"+pagecount + ";datalist:" + datalist.size());
                try {
                    datalist = PerfUtil.lowMapKey(datalist);
                    int j = 0;
                    //保存数据到业务表
                    List<String> deldatalist = new ArrayList<>();
                    List<Map<String, Object>> saveList = new ArrayList<>();
                    List<String> cols = null;
                    for (int i = 0; i < datalist.size(); i++) {
                        Map<String, Object> tabledata = datalist.get(i);
                        if(!StringUtil.isEmpty(delkey)){//删除主键不为空，缓存要删除的数据
                            deldatalist.add((String) tabledata.get(delkey.toLowerCase()));
                        }
                        String newguid = StringUtil.createUUID();
                        tabledata.put("guid", newguid);
                        tabledata.put("create_time", PerfUtil.getServerTimeStamp());
                        tabledata.put("creater", "预算资金同步");
                        saveList.add(tabledata);
                        if (i == 0) {
                            cols = new ArrayList<>(tabledata.keySet());
                            cols.remove("rnum");
                            cols.remove("is_deleted");
                        }
                        j++;
                        if (j == pagecount || (datalist.size() - 1) == i) {
                            //先删除数据
                            if (deldatalist != null && deldatalist.size() > 0) {
                                String delsql = "year = '" + year + "' and province = '" + province + "' and " + pmkpiDAO.createInSql(delkey, deldatalist) + (StringUtil.isEmpty(wheresql) ? "" : " and " + wheresql);
                                getPmkpiDAO().delDatas(savetable, delsql);
                            }
                            getPmkpiDAO().saveAll(cols, saveList, savetable);
                            saveList = new ArrayList<>();
                            deldatalist = new ArrayList<>();
                            j = 0;
                        }
                    }
                    rsmap.put("success",true);
                    logger.info("同步预算数据成功========province:"+province + ";year:"+year + "数量" + datalist.size());
                }catch (Exception e){
                    rsmap.put("success",false);
                    rsmap.put("message",e.getMessage());
                    throw new AppException(e.getMessage());
                }
            }else {
                logger.info("同步预算数据失败======数量为0");
            }
        }else{
            logger.info("==queryBdmOfTabledata 数据获取失败========message:" + PerfUtil.parse2Json(rsmap));
            throw new AppException("同步预算数据失败！");
        }
    }

    /**
     * 新的增量更新方法
     * @param params
     * @param pagecount
     * @param datacount
     * @throws AppException
     */
    private void saveDataNew(Map<String, Object> params, Integer pagecount, Integer datacount) throws AppException {
        String year = (String) params.get("year");
        String province = (String) params.get("province");
        String tablecode = (String) params.get("tablecode");
        String savetable = (String) params.get("savetable");
        String pkcolumn = "guid";
        String config = (String) params.get("config");//新增config配置项
        if(config!=null && !StringUtil.isEmpty(config)){
            Map<String, Object> configMap = JSON.parseObject(config);
            if(!StringUtil.isNullOrEmpty(configMap.get("pkcolumn")))
                pkcolumn = (String)configMap.get("pkcolumn");
        }
        //一次性获取数据
        IBdmInterface pmkpiinterface = ServiceFactory.getFeignClient(IBdmInterface.class);
        MicroParamDTO dto = pmkpiinterface.getBdmOfTabledata(province, year, tablecode, datacount + "", "1");
        Map<String, Object> rsmap = dto.getMap();//获取数据
        String timestamp = PerfUtil.getServerTimeStamp();
        if(rsmap != null && !rsmap.isEmpty() && (Boolean) rsmap.get("result")){
            List<Map<String, Object>> datalist = (List<Map<String, Object>>) rsmap.get("data");
            //处理数据
            if (datalist != null && datalist.size() > 0) {
                logger.info("==queryBdmOfTabledata 数据获取========province:"+province + ";year:"+year + ";tablecode:"+tablecode + ";pagecount:"+pagecount + ";datalist:" + datalist.size());
                try {
                    datalist = PerfUtil.lowMapKey(datalist);
                    // 查询当前年度区划数据
                    List<Map<String, Object>> dbdatalist = getPmkpiDAO().getDatas(savetable,"year = '" + year + "' and province = '" + province + "'",null);
                    // 需要处理的列字段
                    List<String> cols = null;
                    // 初始化 新增、修改对象list
                    List<Map<String, Object>> saveList = new ArrayList<>();
                    List<Map<String, Object>> updateList = new ArrayList<>();
                    // 创建数据库数据的查找映射
                    Map<String, Map<String, Object>> dbDataMap = createGuidMap(dbdatalist,pkcolumn);
                    // 遍历新数据
                    for (int i = 0; i < datalist.size(); i++) {
                        Map<String, Object> newData = datalist.get(i);
                        String guid = (String)newData.get(pkcolumn);
                        if (dbDataMap.containsKey(guid)) {
                            // 数据在两边都存在，检查是否需要更新
                            Map<String, Object> existingData = dbDataMap.get(guid);
                            if (needUpdate(newData, existingData)) {
                                newData.put("create_time", timestamp);
                                newData.put("creater", "预算资金同步");
                                updateList.add(newData);
                            }
                        } else {
                            // 数据只在新数据中存在，需要保存
                            newData.put("create_time", timestamp);
                            newData.put("creater", "预算资金同步");
                            saveList.add(newData);
                        }
                        if (i == 0) {
                            cols = new ArrayList<>(newData.keySet());
                            cols.remove("rnum");
                        }
                    }
                    if(saveList.size()>0){
                        logger.info("同步预算数据========province:"+province + ";year:"+year + "新增数据数量" + saveList.size());
                        getPmkpiDAO().saveAll(cols, saveList, savetable);
                    }
                    if(updateList.size()>0){
                        logger.info("同步预算数据========province:"+province + ";year:"+year + "更新数据数量" + updateList.size());
                        getPmkpiDAO().updateAllByPK(cols, updateList, "guid", savetable);
                    }
                    rsmap.put("success",true);
                    logger.info("同步预算数据成功========province:"+province + ";year:"+year + "数量" + datalist.size());
                }catch (Exception e){
                    rsmap.put("success",false);
                    rsmap.put("message",e.getMessage());
                    throw new AppException(e.getMessage());
                }
            }else {
                logger.info("同步预算数据失败======数量为0");
            }
        }else{
            logger.info("==queryBdmOfTabledata 数据获取失败========message:" + PerfUtil.parse2Json(rsmap));
            throw new AppException("同步预算数据失败！");
        }
    }

    /**
     * 创建数据库数据的查找映射
     * @param dataList 数据集合
     * @param pkcolumn 主键字段
     * @return
     */
    private static Map<String, Map<String, Object>> createGuidMap(List<Map<String, Object>> dataList, String pkcolumn) {
        Map<String, Map<String, Object>> guidMap = new HashMap<>();
        for (Map<String, Object> data : dataList) {
            String guid = (String) data.get(pkcolumn);
            if (guid != null && !guid.trim().isEmpty()) {
                guidMap.put(guid, data);
            }
        }
        return guidMap;
    }

    /**
     * 检查是否需要更新
     * @param newData
     * @param existingData
     * @return
     */
    private static boolean needUpdate(Map<String, Object> newData, Map<String, Object> existingData) {
        Object newUpdateTime = newData.get("update_time");
        Object existingUpdateTime = existingData.get("update_time");
        // 比较update_time是否相同
        return !newUpdateTime.equals(existingUpdateTime);
    }

    /**
     * 获取同步任务配置数据
     * @param type 类型 0为手动按钮同步 1为自动定时任务同步
     * @return
     * @throws AppException
     */
    private List<Map<String, Object>> getSyncTaskData(int type) {
        List<Map<String, Object>> returnList = getPmkpiDAO().getDatas("perf_t_synctaskcfg"," status =1 and type = "+type,"order by ordernum");
        logger.info("++++++++++++获取type:"+type+"同步任务同步数量"+ returnList.size());
        return returnList;
    }

    public Map<String, Object> syncBdmDatas(int type) throws AppException {
        Map<String, Object> result =  new HashMap<>();
        result.put("success",true);
        int threadcount = 2;
        int timeout_minutes = 50;
        List<Map<String, Object>> syncCfg =  this.getSyncTaskData(type);
        if(syncCfg.size()>0){
            String config = (String) syncCfg.get(0).get("config");
            if(config!=null && !StringUtil.isEmpty(config)){
                Map<String, Object> configMap = JSON.parseObject(config);
                threadcount = configMap.get("threadcount") !=null ? (int) configMap.get("threadcount") : threadcount;
                timeout_minutes = configMap.get("timeout_minutes") !=null ? (int) configMap.get("timeout_minutes") : timeout_minutes;
            }
            // 分批次处理
            int batchSize = 5;
            ExecutorService executor = Executors.newFixedThreadPool(threadcount);
            for (int i = 0; i < syncCfg.size(); i += batchSize) {
                int end = Math.min(i + batchSize, syncCfg.size());
                List<Map<String, Object>> batchList = syncCfg.subList(i, end);
                executor.submit(() -> processBatch(batchList));
            }
            executor.shutdown();
            try {
                if (!executor.awaitTermination(timeout_minutes, TimeUnit.MINUTES)) {
                    result.put("success",false);
                    executor.shutdownNow();
                    logger.error("批处理超时，强制终止");
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();
                logger.error("批处理被中断", e);
                result.put("success",false);
            }
        }
        return result;
    }

    private Map<String, Object> processBatch(List<Map<String, Object>> batch) throws AppException, InterruptedException {
        Map<String, Object> batchResult = new HashMap<>();
        Thread.sleep(1000); // 模拟耗时操作
        batchResult.put("success", true);
        for (Map<String, Object> cfg : batch) {
            Map<String, Object> rsmap = this.queryBdmOfTabledata(cfg);
            if (rsmap != null && !(boolean) rsmap.get("success")) {
                batchResult.put("success", false);
            }
        }
        return batchResult;
    }

}
