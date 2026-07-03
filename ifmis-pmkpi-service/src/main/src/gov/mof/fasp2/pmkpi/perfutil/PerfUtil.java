package gov.mof.fasp2.pmkpi.perfutil;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.ca.user.dto.UserDTO;
import gov.mof.fasp2.buscore.ca.user.service.IUserService;
import gov.mof.fasp2.buscore.framework.cache.service.ICacheService;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.rpcfw.mapper.ObjectWriter;
import gov.mof.fasp2.buscore.framework.util.JsonUtils;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.UserInfo;
import gov.mof.fasp2.buscore.sec.syncuserinfo.manager.IUserSyncManager;
import gov.mof.fasp2.busdic.table.service.ISetPackagesService;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


public class PerfUtil {

    private static ICacheService iCacheService;

    private static ICacheService getICacheService() {
        if (iCacheService == null) {
            iCacheService = PerfServiceFactory.getICacheService();
        }
        return iCacheService;
    }

    private static ICacheService iCacheServiceJson;

    private static ICacheService getICacheServiceJson() {
        if (iCacheServiceJson == null) {
            iCacheServiceJson = PerfServiceFactory.getICacheServiceJson();
        }
        return iCacheServiceJson;
    }

    public static final List NODATA = Collections.unmodifiableList(new ArrayList<>());

    public static Object parseString2Object(String cfg) throws AppException {
        if (StringUtil.isEmpty(cfg)) {
            return null;
        } else {
            ObjectWriter writer = new ObjectWriter();
            Object object = null;
            try {
                object = writer.getObjectWithOutStructure(cfg.trim());
            } catch (Exception e) {
                throw new AppException("PerfUtil.parseString2Object参数|" + cfg + "|不是一个JSON串");
            }
            return object;
        }
    }

    /**
     * 将Json串cfg转为Map
     *
     * @Description:
     * @param cfg
     * @return
     * @throws AppException
     */
    public static Map parseString2Map(String cfg) throws AppException {
        Object object = PerfUtil.parseString2Object(cfg);
        if (object instanceof Map) {
            return (Map) object;
        } else {
            return new HashMap();
        }
    }
    /**
     * @Description: object 转为 JSON
     * @param object
     * @return
     * @throws AppException
     */
    public static String parse2Json(Object object) throws AppException {
        String jsonString = "";
        try {
            jsonString = JsonUtils.ObjectToJson(object);
        } catch (IOException e) {
            throw new AppException("PerfUtil.parse2Json参数|" + object + "|不能转化为JSON");
        }
        return jsonString;
    }

    public static Map parseObj2Map(Object object) throws AppException {
        if (object instanceof Map) {
            return (Map) object;
        } else {
            return new HashMap();
        }
    }
    /**
     * 将Json串cfg转为List
     * @Description:
     * @param cfg
     * @return
     * @throws AppException
     */
    public static List parseString2List(String cfg) throws AppException {
        Object object = PerfUtil.parseString2Object(cfg);
        if (object instanceof List) {
            return (List) object;
        } else {
            return new ArrayList();
        }
    }

    /**
     * 获取多个系统参数返回.
     * @param codes --，隔开的参数拼接.
     * @return
     * @throws
     */
    public static Map getSystemSets(String codes) {
        codes = codes + ",1";
        Object[] code = codes.split(",");
        StringBuffer sql = new StringBuffer("select t.paramcode,t.paramvalue from v_perf_t_systemset t where t.paramcode in (");
        for (int i = 0; i < code.length - 1; i++) {
            sql.append("?,");
        }
        sql.append("?) and t.status = 1");
        List list = CommonUtil.getFasp2DaoSupport().queryForList(sql.toString(), code);
        Map res = new HashMap();
        for (int i = 0; i < list.size(); i++) {
            Map m = (Map) list.get(i);
            res.put(m.get("paramcode"), m.get("paramvalue"));
        }
        return res;
    }

    /**
     * 获取系统参数.
     * @param code -- 获取系统参数.
     * @return
     * @throws
     */
    public static String getSystemSet(String code) {
        String cacheKey = PmkpiDAO.PMKPI_CACHE_SYSTEM + code;
        if (getICacheService() != null && getICacheService().get(cacheKey) != null) {
            String cacheConfig = CommonUtil.parseString(getICacheService().get(cacheKey));
            if ("[]".equals(cacheConfig) || "{}".equals(cacheConfig)) {
                cacheConfig = null;
            }
            return cacheConfig;
        } else {
            String mdata = CommonUtil.parseString(getSystemSets(code).get(code));
            try {
                getICacheService().put(cacheKey, StringUtil.isEmpty(mdata) ? parse2Json(NODATA) : mdata);
            } catch (AppException e) {
                e.printStackTrace();
            }
            return mdata;
        }
    }

    /**
     * @Description:刷新当前code的cache.
     * @param code -- 参数
     * @param isRemove 是否删除此缓存。
     * @throws
     */
    public static void reflashSystemSetCache(String code, boolean isRemove) {
        String cacheKey = PmkpiDAO.PMKPI_CACHE_SYSTEM + code;
        if (isRemove) {
            getICacheService().put2Sync(cacheKey, NODATA);
        } else {
            String mdata = CommonUtil.parseString(getSystemSets(code).get(code));
            getICacheService().put2Sync(cacheKey, mdata);
        }
    }
    /**
     * 获取年度和区划的参数.
     * @param t  -- 别名.
     * @return sql.
     * @throws
     */
    public static String yearProvinceSql(String t) {
        Integer year = SecureUtil.getUserSelectYear();
        String province = SecureUtil.getUserSelectProvince();
        StringBuffer sql = new StringBuffer(" and ");
        sql.append(t).append(".").append("year = '").append(year).append("' and ").append(t).append(".");
        sql.append("province = '").append(province).append("'");
        return sql.toString();
    }

    /**
     * 获取时间--
     * @return
     */
    public static String getServerTimeStamp() {
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss");
        return format.format(new Date());
    }

    /**
     * 根据年 月 获取对应的月份 天数
     */

    public static String getDaysByYearMonthDate(String year, String month) {
        Calendar a = Calendar.getInstance();
        a.set(Calendar.YEAR, Integer.parseInt(year));
        a.set(Calendar.MONTH, Integer.parseInt(month) - 1);
        a.set(Calendar.DATE, 1);
        a.roll(Calendar.DATE, -1);
        int maxDate = a.get(Calendar.DATE);
        if (month.length() == 1) {
            month = "0"+month;
        }
        String date = year + month + maxDate;
        return date;
    }

    /**
     * 根据年 月 获取对应的月份
     */

    public static String getDaysByYearMonth(String year, String month) {
        Calendar a = Calendar.getInstance();
        a.set(Calendar.YEAR, Integer.parseInt(year));
        a.set(Calendar.MONTH, Integer.parseInt(month) - 1);
        a.set(Calendar.DATE, 1);
        a.roll(Calendar.DATE, -1);
//        int maxDate = a.get(Calendar.DATE);
        if (month.length() == 1) {
            month = "0"+month;
        }
        String date = year + month;
        return date;
    }


    /**
     * 获取时间--
     * @return
     */
    public static String getServerTimeStamp(String pattren) {
        SimpleDateFormat format = new SimpleDateFormat(pattren);
        return format.format(new Date());
    }

    /**
     * LIST中mapkey转小写.
     * @param list
     * @return
     */
    public static List lowMapKey(List list){
        if (list==null||list.size() == 0) {
            return  list;
        }
        List resultList = new ArrayList();
        for(int i=0;i<list.size();i++){
            Map<String, Object> hashMap = new HashMap();
            Map<?,?> map = (Map)list.get(i);
            for (Map.Entry<?, ?> entry : map.entrySet()) {
                hashMap.put(entry.getKey().toString().toLowerCase(), entry.getValue());
            }
            resultList.add(hashMap);
        }
        return resultList;
    }

    /**
     * map的key转为小写.
     * @param orgMap
     * @return
     */
    public static Map<String, Object> transformUpperCase(Map<String, Object> orgMap) {
        Map<String, Object> resultMap = new HashMap<>();
        if (orgMap == null || orgMap.isEmpty()) {
            return resultMap;
        }
        Set<String> keySet = orgMap.keySet();
        for (String key : keySet) {
            String newKey = key.toLowerCase();
            resultMap.put(newKey, orgMap.get(key));
        }
        return resultMap;
    }

    /**
     * LIST中mapkey转小写.
     * @param list
     * @return
     */
    public static List upperMapKey(List list){
        if (list==null||list.size() == 0) {
            return  list;
        }
        List resultList = new ArrayList();
        for(int i=0;i<list.size();i++){
            Map<String, Object> hashMap = new HashMap();
            Map<?,?> map = (Map)list.get(i);
            for (Map.Entry<?, ?> entry : map.entrySet()) {
                hashMap.put(entry.getKey().toString().toUpperCase(), entry.getValue());
            }
            resultList.add(hashMap);
        }
        return resultList;
    }

    /**
     * 获取登陆人.
     * @return 登陆人
     */
    public static UserDTO getuser() {
        return SecureUtil.getCurrentUser();
    }

    /**
     * 获取登陆人id.
     * @return 登陆人id
     */
    public static String getuserid() {
        UserDTO userDto = (UserDTO) SecureUtil.getCurrentUser();
        return userDto.getGuid();
    }

    /**
     * 获取登陆年度.
     * @return 登陆年度
     */
    public static String getYear() {
        return SecureUtil.getUserSelectYear()+"";
    }

    /**
     * 获取登陆财政.
     * @return 登陆财政编码
     */
    public static String getProvince() {
        return SecureUtil.getUserSelectProvince()+"";
    }

    /**
     * 克隆复制.
     * @param listmapobj -- 复制对象.
     * @return
     */
    public static Object cloneListAndMap(Object listmapobj)
    {
        if ((listmapobj instanceof List)) {
            List oldlist = (List)listmapobj;
            List newlist = new ArrayList();
            for (int i = 0; i < oldlist.size(); i++) {
                newlist.add(cloneListAndMap(oldlist.get(i)));
            }
            return newlist;
        }
        if ((listmapobj instanceof Map)) {
            Map oldmap = (Map)listmapobj;
            Map newmap = new HashMap();
            Iterator iterator = oldmap.entrySet().iterator();
            Map.Entry me = null;
            while (iterator.hasNext())
            {
                me = (Map.Entry)iterator.next();
                newmap.put(cloneListAndMap(me.getKey()), cloneListAndMap(me.getValue()));
            }
            return newmap;
        }
        return listmapobj;
    }

    /**
     * 字符数字转换.
     * @param map -- map.
     * @param col -- 字段.
     * @return int.
     * @throws
     */
    public static int mapGetInt(Map<String, Object> map, String col) {
        Object o = map.get(col);
        if (o == null) {
            return 0;
        }
        String i = o.toString().trim();
        if (StringUtil.isEmpty(i)) {
            return 0;
        };
        return Integer.parseInt(i);
    }
    /**
     * 判断是汉字还是字符.
     * @param str -- 字符串.
     * @return
     * @throws
     */
    public static boolean judgeChinese(String str) {
        if (str == null || str.isEmpty()) {
            return true;
        }
        return str.getBytes().length == str.length();
    }

    /**
     * @Title: ToSBC
     * @Description: 半角转全角
     * @author LiuTianYang
     * @param input
     * @return
     * @throws
     */
    public static String ToSBC(String input) {
        char c[] = input.toCharArray();
        for (int i = 0; i < c.length; i++) {
            if (c[i] == '/'
                    || (c[i] <= '\172' && c[i] >= '\141')
                    || (c[i] <= '\132' && c[i] >= '\101')
                    || (c[i] <= '\60' && c[i] >= '\71')) {
                continue;
            }
            if (c[i] == ' ') {
                c[i] = '\u3000';
                continue;
            }
            if (c[i] == '\n') {
                c[i] = '\u0000';
                continue;
            }
            if (c[i] < '\177') {
                c[i] = (char) (c[i] + 65248);
            }
        }
        return new String(c);
    }

    /**
     * 是否河北模式
     * @return
     */
    public static boolean getIsHbei(){
        String IS_HBEI = PerfUtil.getSystemSet("IS_HBEI");//是否河北模式;
        if (IS_HBEI != null && "1".equals(IS_HBEI)) {
            return true;
        }
        return false;
    }

    /**
     * 是否湖北模式
     * @return
     */
    public static boolean getIS_HUBEI(){
        String IS_HUBEI = PerfUtil.getSystemSet("IS_HUBEI");//是否湖北模式;
        if (IS_HUBEI != null && "1".equals(IS_HUBEI)) {
            return true;
        }
        return false;
    }

    /**
     * 是否天津模式
     * @return
     */
    public static boolean getIsTianJin(){
        String IS_TIANJIN = PerfUtil.getSystemSet("IS_TIANJIN");//是否天津模式;
        if (IS_TIANJIN != null && "1".equals(IS_TIANJIN)) {
            return true;
        }
        return false;
    }

    /**
     * <p>是否广西模式</p >
     * true-是；false-不是；
     * @author hw
     * @date 2022/3/30 9:57
     * @param
     */
    public static boolean getIsGuangXi(){
        String isGuangxi = PerfUtil.getSystemSet("IS_GUANGXI");//是否广西模式;
        if (isGuangxi != null && "1".equals(isGuangxi)) {
            return true;
        }
        return false;
    }

    /**
     * <p>是否浙江模式</p >
     * true-是；false-不是；
     * @param
     */
    public static boolean getIsZJ(){
        String isZJ = PerfUtil.getSystemSet("isZJ");
        if (isZJ != null && "1".equals(isZJ)) {
            return true;
        }
        return false;
    }

    /**
     * <p>是否安徽模式</p >
     * true-是；false-不是；
     * @param
     */
    public static boolean get_ISANHUI(){
        String isAH = PerfUtil.getSystemSet("IS_ANHUI");
        if (isAH != null && "1".equals(isAH)) {
            return true;
        }
        return false;
    }

    /**
     * 是否宁夏模式
     * @return
     */
    public static boolean getIsNINGXIA() {
        String IS_NINGXIA = PerfUtil.getSystemSet("IS_NINGXIA");//是否天津模式;
        if (IS_NINGXIA != null && "1".equals(IS_NINGXIA)) {
            return true;
        }
        return false;
    }

    /**
     * <p>是否演示系统</p >
     * true-是；false-不是；
     * @param
     */
    public static boolean get_ISYANSHI(){
        String isYANSHI = PerfUtil.getSystemSet("IS_YANSHI");
        if (isYANSHI != null && "1".equals(isYANSHI)) {
            return true;
        }
        return false;
    }

    /**
     * 判断是否为空(忽略前导空白和尾部空白)
     *
     * @param obj
     * @return
     */
    public static boolean isTrimNull(Object obj) {
        if (null != obj) {
            return isNull(obj.toString().trim());
        } else {
            return true;
        }
    }

    /**
     * 判断是否为空
     *
     * @param obj
     * @return
     */
    public static boolean isNull(Object obj) {
        if (null != obj && !"".equals(obj)) {
            return false;
        } else {
            return true;
        }
    }

    /**
     * 使用 Map按key进行排序
     * @param map
     * @return
     */
    public static Map<Integer, Object> sortMapByKey(Map<Integer, Object> map) {
        if (map == null || map.isEmpty()) {
            return null;
        }
        Map<Integer, Object> sortMap = new TreeMap<Integer, Object>(
                new PerfUtil.MapKeyComparator());
        sortMap.putAll(map);
        return sortMap;
    }

    static class MapKeyComparator implements Comparator<Integer>{
        public int compare(Integer str1, Integer str2) {
            return str1.compareTo(str2);
        }
    }

    /**
     * <p>是否山西模式</p >
     * true-是；false-不是；
     * @author hw
     * @date 2022/4/2 11:15
     * @param
     */
    public static boolean getIsSx(){
        String isSx = PerfUtil.getSystemSet("isSX");//是否山西模式
        if (isSx != null && "1".equals(isSx)) {
            return true;
        }
        return false;
    }

    /**
     * 两数相除
     * @param a
     * @param b
     * @param num 小数位
     * @return
     */
    public static float delTwoNum(float a,float b, int num) {
        BigDecimal c = new BigDecimal(a + "");
        BigDecimal d = new BigDecimal(b + "");
        BigDecimal e = c.divide(d, num, BigDecimal.ROUND_HALF_UP);
        return Float.parseFloat(e.toString());
    }

    /**
     * 两数相乘
     * @param a
     * @param b
     * @return
     */
    public static float rideTwoNum(float a,float b){
        BigDecimal c = new BigDecimal(a + "");
        BigDecimal d = new BigDecimal(b + "");
        BigDecimal e = c.multiply(d);
        return e.floatValue();
    }

    /**
     * 两数相加
     * @param a
     * @param b
     * @return
     */
    public static BigDecimal addTwoNum(BigDecimal a,BigDecimal b) {
        BigDecimal e = a.add(b);
        return e;
    }

    /**
     * 两数相減
     * @param a
     * @param b
     * @return
     */
    public static BigDecimal substrTwoNum(BigDecimal a,BigDecimal b) {
        BigDecimal e = a.subtract(b);
        return e;
    }

    /**
     * 两数相除
     * @param a
     * @param b
     * @param num 小数位
     * @return
     */
    public static BigDecimal delTwoNum(BigDecimal a,BigDecimal b, int num) {
        return a.divide(b, num, BigDecimal.ROUND_HALF_DOWN);
    }

    /**
     * 两数相乘
     * @param a
     * @param b
     * @return
     */
    public static BigDecimal rideTwoNum(BigDecimal a,BigDecimal b){
        BigDecimal e = a.multiply(b);
        return e;
    }

    /**
     * 是否校验三级指标名称重复
     * @return
     */
    public static boolean getIsuCheckIndexName(){
        String isCheckIndexName = PerfUtil.getSystemSet("ISCHECKINDEXNAME"); //是否校验三级指标名称重复
        if (isCheckIndexName != null && "1".equals(isCheckIndexName)) {
            return true;
        }
        return false;
    }

    /**
     * <p>项目录入是否填报年度绩效目标、指标</p >
     */
    public static boolean getProgramIsyear(){
        String isyear = PerfUtil.getSystemSet("PROGRAMINPUTPERFISYEAR");//项目录入是否填报年度绩效目标、指标
        if (isyear != null && "1".equals(isyear)) {
            return true;
        }
        return false;
    }

    /**
     * <p>项目申报，调整终审，绩效指标进入部门指标库</p >
     */
    public static boolean getProendTolib(){
        String istemp = PerfUtil.getSystemSet("proendtolib");//项目录入是否填报年度绩效目标、指标
        if (istemp != null && "1".equals(istemp)) {
            return true;
        }
        return false;
    }

    /**
     * 是否江西
     */
    public static boolean get_IsJiangXi(){
        String isyear = PerfUtil.getSystemSet("IS_JIANGXI");
        if (isyear != null && "1".equals(isyear)) {
            return true;
        }
        return false;
    }

    /**
     * 指标新增方式， 默认为行级新增
     * @return
     */
    public static boolean getIndexIsAddRow(){
        String isaddrow = PerfUtil.getSystemSet("INDEXISADDROW");
        if (isaddrow != null && "1".equals(isaddrow)) {
            return true;
        }
        return false;
    }

    /**
     * list<map>排序
     * 入参：数据，排序规则desc倒叙，空或asc正叙，排序字段key
     */
    public static List listMapSort(List list, final String orderd, final String key){
        if (list != null && list.size() > 0) {
            Collections.sort(list, new Comparator<Map>() {
                public int compare(Map o1, Map o2) {
                    String str1 = o1.get(key) + "";
                    String str2 = o2.get(key) + "";
                    if (StringUtil.isNullOrEmpty(str1)) {
                        str1 = "";
                    }
                    if (StringUtil.isNullOrEmpty(str2)) {
                        str2 = "";
                    }
                    if("desc".equals(orderd)){
                        return (str2).compareTo(str1);
                    } else {
                        return (str1).compareTo(str2);
                    }
                }
            });
        }
        return list;
    }

    /**
     * 获取缓存数据.
     * @param cacheKey --缓存key
     * @return
     */
    public static String getCacheData(String cacheKey) {
        if (getICacheService() != null && getICacheService().get(cacheKey) != null) {
            String cacheConfig = CommonUtil.parseString(getICacheService().get(cacheKey));
            return cacheConfig;
        }
        return null;
    }

    /**
     * @Description:刷新当前缓存key的cache.
     * 用于数据不变，各个节点每个节点加载自己的缓存。
     * @param cacheKey --缓存key
     * @param value --缓存值
     * @param isRemove 是否删除此缓存。
     * @throws
     */
    public static void reflashCacheData(String cacheKey, String value, boolean isRemove) {
        if (isRemove) {
            getICacheService().remove(cacheKey);
        } else {
            String mdata = CommonUtil.parseString(value.replaceAll("<br>"," ").replaceAll("\\\n", " "));
            getICacheService().put(cacheKey, mdata);
        }
    }

    /**
     * @Description:刷新当前缓存key的cache. put2Sync -- 用于数据库变化数据后，各个节点同步刷新缓存。如数据不变不能用此方法。
     * @param cacheKey --缓存key
     * @param value --缓存值
     * @param isRemove 是否删除此缓存。
     * @throws
     */
    public static void reflashSynCacheData(String cacheKey, String value, boolean isRemove) {
        if (isRemove) {
            getICacheService().remove2Sync(cacheKey);
        } else {
            String mdata = CommonUtil.parseString(value.replaceAll("<br>"," ").replaceAll("\\\n", " "));
            getICacheService().put2Sync(cacheKey, mdata);
        }
    }


    /**
     * 获取缓存数据.
     * @param cacheKey --缓存key
     * @return
     */
    public static String getCacheJSONData(String cacheKey) {
        if (getICacheServiceJson() != null && getICacheServiceJson().get(cacheKey) != null) {
            String cacheConfig = CommonUtil.parseString(getICacheServiceJson().get(cacheKey));
            return cacheConfig;
        }
        return null;
    }

    /**
     * @Description:刷新当前缓存key的cache.
     * 用于数据不变，各个节点每个节点加载自己的缓存。
     * @param cacheKey --缓存key
     * @param value --缓存值
     * @param isRemove 是否删除此缓存。
     * @throws
     */
    public static void reflashCacheJSONData(String cacheKey, String value, boolean isRemove) {
        if (isRemove) {
            getICacheServiceJson().remove(cacheKey);
        } else {
            String mdata = CommonUtil.parseString(value.replaceAll("<br>"," ").replaceAll("\\\n", " "));
            getICacheServiceJson().put(cacheKey, mdata);
        }
    }

    /**
     * @Description:刷新当前缓存key的cache. put2Sync -- 用于数据库变化数据后，各个节点同步刷新缓存。如数据不变不能用此方法。
     * @param cacheKey --缓存key
     * @param value --缓存值
     * @param isRemove 是否删除此缓存。
     * @throws
     */
    public static void reflashSynCacheJSONData(String cacheKey, String value, boolean isRemove) {
        if (isRemove) {
            getICacheServiceJson().remove2Sync(cacheKey);
        } else {
            String mdata = CommonUtil.parseString(value.replaceAll("<br>"," ").replaceAll("\\\n", " "));
            getICacheServiceJson().put2Sync(cacheKey, mdata);
        }
    }

    /**
     * 获取数据源数据集合.
     * @return
     */
    public static List getSourceData(String elementcode, String wheresql) throws AppException {
        return PerfServiceFactory.getIDataSetService().getAllRangesByWhereSql(elementcode, wheresql);
    }

    /**
     * <p>监控任务下达，同一项目一般、重点是否单独生成数据
     * 1同阶段不同任务下发一笔监控项目 2同阶段不同任务下发两笔监控项目</p >
     */
    public static boolean getDismodel(){
        String isdismodel= PerfUtil.getSystemSet("dismodel");
        if (isdismodel != null && "2".equals(isdismodel)) {
            return true;
        }
        return false;
    }

    /**
     * 一般监控是否标记重点项目，默认关闭参数，0-否 1-是
     * 注意：开启该参数时，请隐藏重点项目监控任务布置菜单
     */
    public static boolean getTraceManageKeynote(){
        String istracemanagekeynote = PerfUtil.getSystemSet("ISTRACEMANAGEKEYNOTE");
        if (istracemanagekeynote != null && "1".equals(istracemanagekeynote)) {
            return true;
        }
        return false;
    }

    /**
     * 缓存中空值存放为空对象，对空对象进行判断
     * @param str
     * @return
     */
    public static boolean cacheIsEmpty(String str) {
        if (!StringUtil.isEmpty(str)) {
            if ("[]".equals(str) || "{}".equals(str)) {
                return true;
            } else {
                return false;
            }
        }
        return true;
    }

    /**
     * 是否为数字、且为小数
     * @param strNum
     * @return
     */
    public static boolean isNumeric(String strNum) {
        if (StringUtil.isEmpty(strNum)) {
            return false;
        }
        return strNum.matches("-?\\d+(\\.\\d+)?");
    }

    /**
     * <p>转移支付项目类型</p >
     */
    public static String getTraprojectkind(){
        return PerfUtil.getSystemSet("TRAPROJECTKIND");
    }


    /**
     * <p>是否校验字段内空格</p >
     * true-是；false-不是；
     * @param
     */
    public static boolean get_isCheckSpace(){
        String isCheckSpace = PerfUtil.getSystemSet("isCheckSpace");
        if (isCheckSpace != null && "1".equals(isCheckSpace)) {
            return true;
        }
        return false;
    }

    /**
     * <p>是否显示AI模型思考过程</p >
     * true-是；false-不是；
     * @param
     */
    public static boolean get_isShowAIThink(){
        String isShowAIThink = PerfUtil.getSystemSet("isShowAIThink");
        if (isShowAIThink != null && "1".equals(isShowAIThink)) {
            return true;
        }
        return false;
    }


    /**
     * <p>山西数据交互中心服务ip</p >
     * true-是；false-不是；
     * @param
     */
    public static String getDatacommunicationBase_IP() throws AppException {
        String config = PerfUtil.getSystemSet("DATACOMMUNICATION_BASE");
        if (StringUtil.isEmpty(config)) {
            return "";
        }
        Map<String, Object> params = parseString2Map(config);
        return (String) params.get("ip");
    }

    /**
     * <p>山西数据交互中心新增/修改/删除url</p >
     * true-是；false-不是；
     * @param
     */
    public static String getDatacommunicationBase_URL() throws AppException {
        String config = PerfUtil.getSystemSet("DATACOMMUNICATION_BASE");
        if (StringUtil.isEmpty(config)) {
            return "";
        }
        Map<String, Object> params = parseString2Map(config);
        return (String) params.get("url");
    }


    /**
     * <p> 替换英文符号为中文符号</p >
     * "/,>,<,;,&,',\",%,#,:,\\?,\\[,\\]";
     * 替换为
     * "／,》,《,；,＆,‘,“,％,＃,：,？,【,】" ;
     * @param
     */
    public static String replaceSymbols(String input) {
        if (input == null || input.isEmpty()) {
            return "";
        }
        return input
                .replaceAll("/", "／")
                .replaceAll(">", "》")
                .replaceAll("<", "《")
                .replaceAll(";", "；")
                .replaceAll("&", "＆")
                .replaceAll("'", "‘")
                .replaceAll("\"", "“")
                .replaceAll("%", "％")
                .replaceAll("#", "＃")
                .replaceAll(":", "：")
                .replaceAll("\\?", "？")
                .replaceAll("\\[", "【")
                .replaceAll("\\]", "】");
    }

    /**
     * 替换字符串忽略大小写
     * @param input
     * @param regex
     * @param replacement
     * @return
     */
    public static String replaceAllIgnoreCase(String input, String regex, String replacement) {
        Pattern pattern = Pattern.compile(regex, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(input);
        return matcher.replaceAll(replacement);
    }

    /**
     * 模拟登陆
     * @param province  区划
     * @param year      年度
     * @param userid    用户id
     * @return          tokenid
     * @throws Exception
     */
    public static String simulateLogIn(String province, String year, String userid) throws Exception {
        String tokenid = "";
        IUserService userService = (IUserService) PerfServiceFactory.getBean("buscore.ca.user.service");
        UserDTO udto = userService.queryUserDTO(userid);
        if (null == udto || udto.isEmpty()) {
            throw new Exception("用户无效：" + userid);
        }
        String password = udto.getPassword();
        String code = udto.getCode();
        IUserSyncManager sync = (IUserSyncManager) PerfServiceFactory.getBean("buscore.ca.UserSyncManager");
        Integer intYear = new Integer(year);
        UserDTO dto = userService.login(code, password, intYear, null);
        tokenid = sync.doLogin(dto, intYear, province);
        ISetPackagesService sps = (ISetPackagesService) PerfServiceFactory.getBean("bus.dic.table.setpackagesservice");
        sps.setPartitionConditions(year, province);
        if (SecureUtil.getUserSelectYear() == null) {
            UserInfo userInfo = sync.getUser(tokenid);
            SecureUtil.setUserInfo(userInfo, tokenid);
        }
        sync.refreshSession(tokenid);
        return tokenid;
    }

    /**
     * list key转大写，默认value为空给空字符串
     * @param list
     * @return
     */
    public static List upperMapKeyAndDefNullStr(List list){
        if (list==null||list.size() == 0) {
            return  list;
        }
        List resultList = new ArrayList();
        for(int i=0;i<list.size();i++){
            Map<String, Object> hashMap = new HashMap();
            Map<?,?> map = (Map)list.get(i);
            for (Map.Entry<?, ?> entry : map.entrySet()) {
                hashMap.put(entry.getKey().toString().toUpperCase(), entry.getValue()!=null ? (entry.getValue()+"") : "");
            }
            resultList.add(hashMap);
        }
        return resultList;
    }
}
