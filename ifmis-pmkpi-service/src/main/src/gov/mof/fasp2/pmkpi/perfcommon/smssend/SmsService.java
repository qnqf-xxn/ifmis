package gov.mof.fasp2.pmkpi.perfcommon.smssend;

import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;
import org.springframework.http.*;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;
import java.util.stream.Collectors;

public class SmsService extends PmkpiService {

    private static final String CHARACTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
    private static final SecureRandom random = new SecureRandom();

    /**
     * 生成指定位数的随机字符串（仅包含a-zA-Z）
     * @param length 字符串长度
     * @return 随机字符串
     */
    public static String generateRandomString(int length) {
        if (length <= 0) {
            throw new IllegalArgumentException("长度必须大于0");
        }

        StringBuilder sb = new StringBuilder(length);

        for (int i = 0; i < length; i++) {
            int index = random.nextInt(CHARACTERS.length());
            sb.append(CHARACTERS.charAt(index));
        }

        return sb.toString();
    }

    /**
     * 生成6位随机字符串（a-zA-Z）
     * @return 6位随机字符串
     */
    public static String generate6DigitRandomString() {
        return generateRandomString(6);
    }

    /**
     * 数据枢纽平台签名方法
     * @param appId appId
     * @param accesskey accesskey
     * @param timestamp 时间戳
     * @param nonStr 随机字符串
     * @param args  参数对象
     * @return
     */
    public String sign(String appId, String accesskey, Long timestamp, String nonStr, Map<String, Object> args) {
        args.put("appid", appId);
        args.put("timestamp", timestamp);
        args.put("nonstr", nonStr);
        // 参数排序
        Map<String, Object> sortedMap = new LinkedHashMap<>();
        args.entrySet().stream().sorted(Map.Entry.comparingByKey())
                .forEachOrdered(x -> sortedMap.put(x.getKey(), x.getValue()));
        args = sortedMap;
        StringBuffer argStr = new StringBuffer();
        for(String key : args.keySet() ){
            argStr.append(key).append("=").append(args.get(key).toString()).append("&");
        }
        argStr = new StringBuffer(argStr.substring(0, argStr.length()-1));
        args.put("arg_str", argStr);
        args.put("app_key", accesskey);
        StringBuffer md5Str = new StringBuffer();
        md5Str.append(args.get("appid"));
        md5Str.append(args.get("timestamp").toString());
        md5Str.append(args.get("nonstr"));
        md5Str.append(args.get("arg_str"));
        md5Str.append(args.get("app_key"));
        byte[] digest = null;
        StringBuilder md5StrResp = new StringBuilder();
        try {
            MessageDigest md5 = MessageDigest.getInstance("md5");
            digest  = md5.digest(md5Str.toString().getBytes(StandardCharsets.UTF_8));
            for (byte t : digest) {
                String s = Integer.toHexString(t & 0xFF);
                if (s.length() == 1) {
                    // 注意此行，如果只有一位，在首位加0
                    s = "0" + s;
                }
                md5StrResp.append(s);
            }
        } catch (Exception e) {
            logger.error("签名异常", e);
        }
        return md5StrResp.toString();
    }

    /**
     * 短信数据类
     */
    class SmsData {
        private String userId;
        private String userCode;
        private String phoneNumber;
        private String message;

        // getters and setters
        public String getUserId() { return userId; }
        public void setUserId(String userId) { this.userId = userId; }

        public String getUserCode() { return userCode; }
        public void setUserCode(String userCode) { this.userCode = userCode; }

        public String getPhoneNumber() { return phoneNumber; }
        public void setPhoneNumber(String phoneNumber) { this.phoneNumber = phoneNumber; }

        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
    }

    /**
     * 短信配置类
     */
    class SmsConfig {
        private String appId;
        private String channel;
        private String url;
        private String accessKey;
        private String province;

        // getters and setters
        public String getAppId() { return appId; }
        public void setAppId(String appId) { this.appId = appId; }

        public String getChannel() { return channel; }
        public void setChannel(String channel) { this.channel = channel; }

        public String getUrl() { return url; }
        public void setUrl(String url) { this.url = url; }

        public String getAccessKey() { return accessKey; }
        public void setAccessKey(String accessKey) { this.accessKey = accessKey; }

        public String getProvince() { return province; }
        public void setProvince(String province) { this.province = province; }
    }

    private SmsConfig smsConfig;

    /**
     * 批量发送短信
     * @param sendDatas 短信数据列表
     * @return 发送结果
     */
    public void batchSendSms(List<SmsData> sendDatas) {
        RestTemplate restTemplate = new RestTemplate();
        // 参数验证
        if (sendDatas == null || sendDatas.isEmpty()) {
            logger.warn("短信数据列表为空");
        }
        // 过滤有效数据
        List<SmsData> validDatas = sendDatas.stream()
                .filter(this::isValidSmsData)
                .collect(Collectors.toList());
        if (validDatas.isEmpty()) {
            logger.warn("没有有效的短信数据");
        }
        logger.info("准备发送短信数量：{}", validDatas.size());
        try {
            // 构建请求
            HttpEntity<String> requestEntity = buildRequest(validDatas);
            // 发送请求
            String json = restTemplate.postForObject(smsConfig.getUrl(),requestEntity, String.class);
            Map<String, Object> jsonMap = PerfUtil.parseObj2Map(JSONObject.parse(json));
            logger.info("==============发送短信返回解析：：："+jsonMap.toString()+"===========");
            String code = (String)jsonMap.get("code");
            if("500".equals(code)){
                String message = (String) jsonMap.get("message");
                throw new AppException(message);
            }
        } catch (Exception e) {
            logger.error("短信发送失败", e);
        }
    }

    /**
     * 构建HTTP请求
     */
    private HttpEntity<String> buildRequest(List<SmsData> smsDatas) {
        // 生成签名参数
        long timestamp = System.currentTimeMillis();
        String nonstr = generate6DigitRandomString();
        String sign = sign(smsConfig.getAppId(),smsConfig.getAccessKey(),timestamp,nonstr,new HashMap<>());
        // 构建请求头
        HttpHeaders headers = new HttpHeaders();
        MediaType type = MediaType.parseMediaType("application/json; charset=UTF-8");
        headers.setContentType(type);
        headers.set("appid", smsConfig.getAppId());
        headers.set("nonstr", nonstr);
        headers.set("timestamp", String.valueOf(timestamp));
        headers.set("sign", sign);
        // 构建请求体
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("appid",smsConfig.getAppId());
        jsonObject.put("channel",smsConfig.getChannel());
        jsonObject.put("province",smsConfig.getProvince());
        jsonObject.put("smsSendType","1");//短信发送方式：0-单发、1-群发；默认0
        jsonObject.put("message",smsDatas.get(0).getMessage());// 批量短信消息一致
        jsonObject.put("userId",buildSmsDataStrs(smsDatas).get("userIds"));
        jsonObject.put("userCode",buildSmsDataStrs(smsDatas).get("userCodes"));
        String phonenumbers = buildSmsDataStrs(smsDatas).get("phoneNumbers");
        logger.info("==============发送短信手机号phonenumbers："+phonenumbers+"===========");
        jsonObject.put("phoneNumber",phonenumbers);
        HttpEntity<String> formEntity = new HttpEntity<String>(jsonObject.toString(), headers);
        return formEntity;

    }

    /**
     * 构建消息
     */
    private Map<String,String> buildSmsDataStrs(List<SmsData> smsDatas) {
        Map<String, String> resultMap = new HashMap<>();
        if (smsDatas == null || smsDatas.isEmpty()) {
            return resultMap;
        }
        List<String> phoneNumbers = smsDatas.stream()
                .map(SmsData::getPhoneNumber)
                .collect(Collectors.toList());
        List<String> userCodes = smsDatas.stream()
                .map(SmsData::getUserCode)
                .collect(Collectors.toList());
        List<String> userIds = smsDatas.stream()
                .map(SmsData::getUserId)
                .collect(Collectors.toList());
        resultMap.put("phoneNumbers", String.join(";", phoneNumbers));
        resultMap.put("userCodes", String.join(";", userCodes));
        resultMap.put("userIds", String.join(";", userIds));
        return resultMap;
    }

    /**
     * 验证短信数据
     */
    private boolean isValidSmsData(SmsData data) {
        return data != null &&
                data.getPhoneNumber() != null &&
                !data.getPhoneNumber().trim().isEmpty() &&
                data.getMessage() != null &&
                !data.getMessage().trim().isEmpty();
    }

    /**
     * 发送短信
     * @param senddatas 短信数据集 [{userId userCode phoneNumber message}]
     * @throws AppException
     */
    public void smsSend(List<Map<String, Object>> senddatas) throws AppException {
        logger.info("-----------发送短信数量："+senddatas.size());
        String province = SecureUtil.getUserSelectProvince().substring(0, 6);
        String smssendparams = PerfUtil.getSystemSet("smssendparams");
        logger.info("-----------发送短信,系统参数："+smssendparams);
        Map<String, Object> smssendparamsmap = PerfUtil.parseString2Map(smssendparams);
        String appid = (String) smssendparamsmap.get("appid");
        String channel = (String) smssendparamsmap.get("channel");
        String url = (String) smssendparamsmap.get("url");
        String accesskey = (String) smssendparamsmap.get("accesskey");
        int threadcount = Integer.parseInt((String) smssendparamsmap.get("threadcount"));
        smsConfig = new SmsConfig();
        smsConfig.setAppId(appid);
        smsConfig.setChannel(channel);
        smsConfig.setAccessKey(accesskey);
        smsConfig.setUrl(url);
        smsConfig.setProvince(province);
        senddatas = senddatas.stream().filter(map -> map != null && map.containsKey("phoneNumber") && map.get("phoneNumber") != null)
                .collect(Collectors.collectingAndThen(
                        Collectors.toMap(
                                map -> (String) map.get("phoneNumber"),
                                map -> map,
                                (existing, replacement) -> existing, // 保留第一个出现的元素
                                LinkedHashMap::new
                        ),
                        map -> new ArrayList<>(map.values())
                ));
        List<SmsData> smsDatas = new ArrayList<>();
        for (Map<String, Object> senddata: senddatas) {
            SmsData smsData = new SmsData();
            smsData.setUserId((String) senddata.get("userId"));
            smsData.setUserCode((String) senddata.get("userCode"));
            smsData.setPhoneNumber((String) senddata.get("phoneNumber"));
            smsData.setMessage((String) senddata.get("message"));
            smsDatas.add(smsData);
        }
        // 使用线程池并行处理批次
        ExecutorService executor = Executors.newFixedThreadPool(threadcount);
        // 分批处理每次最大1000
        for (int i = 0; i < smsDatas.size(); i += 1000) {
            int end = Math.min(i + 1000, smsDatas.size());
            List<SmsData> batchList = smsDatas.subList(i, end);
            // 提交批处理任务到线程池
            executor.submit(() -> batchSendSms(batchList));
        }
        // 关闭线程池并等待所有任务完成
        executor.shutdown();
        try {
            if (!executor.awaitTermination(10, TimeUnit.MINUTES)) {
                executor.shutdownNow();
                logger.error("批处理超时，强制终止");
            }
        } catch (InterruptedException e) {
            Thread.currentThread().interrupt();
            logger.error("批处理被中断", e);
        }
    }
}
