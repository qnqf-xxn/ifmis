package gov.mof.fasp2.pmkpi.perfcommon.aisupportaudit;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import org.apache.commons.collections.CollectionUtils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.*;
import java.util.function.Function;

public class AIStreamUtil extends PmkpiBO {

    /**
     * 翻译处理指标字段提示词
     * @param targetIndexList
     * @param signsMap
     * @return
     */
    public static List<Map<String, Object>> packageIndexList(List<Map<String, Object>> targetIndexList, Map<Object, Object> signsMap){
        List<Map<String, Object>> resultList = new ArrayList<>();
        for (int j = 0; j < targetIndexList.size(); j++) {
            Map<String, Object> indexMap = targetIndexList.get(j);
            Map<String, Object> aipromptmapindex = new HashMap<>();
            aipromptmapindex.put("一级指标",indexMap.get("lv1_perf_ind_name"));
            aipromptmapindex.put("二级指标",indexMap.get("lv2_perf_ind_name"));
            aipromptmapindex.put("三级指标",indexMap.get("lv3_perf_ind_name"));
            aipromptmapindex.put("计算符号",signsMap.get(indexMap.get("computesign")));
            aipromptmapindex.put("指标值",indexMap.get("indexval"));
            aipromptmapindex.put("计量单位",indexMap.get("meterunit"));
            resultList.add(aipromptmapindex);
        }
        return resultList;
    }

    // 辅助类和简化方法
    public static class StreamResult {
        StringBuilder beforeThink = new StringBuilder();
        StringBuilder afterThink = new StringBuilder();
        String dialogID;
        boolean isAfterThink;
        int lastPosition;
    }

    /**
     * 执行流式ai请求
     * @param url
     * @param apiKey
     * @param prompt
     * @param dialogId
     * @param api_code
     * @return
     * @throws Exception
     */
    public static StreamResult executeStreamRequest(String url, String file_id, String apiKey, String prompt, String dialogId, int timeout_ms, String api_code) throws Exception {
        ExecutorService executor = Executors.newSingleThreadExecutor();
        Future<StreamResult> future = executor.submit(() -> {
            HttpURLConnection conn = null;
            StreamResult result = new StreamResult();
            StringBuilder buffer = new StringBuilder();
            try {
                // 创建连接
                conn = (HttpURLConnection) new URL(url).openConnection();
                conn.setRequestMethod("POST");
                conn.setRequestProperty("Content-Type", "application/json");
                conn.setRequestProperty("accept", "application/json, text/plain, */*");
                conn.setDoOutput(true);
                conn.setConnectTimeout(5000);
                conn.setReadTimeout(timeout_ms);
                // 发送请求体
                JSONObject requestBody = new JSONObject();
                requestBody.put("api_code", api_code);
                requestBody.put("api_key", apiKey);
                requestBody.put("message", prompt);
                requestBody.put("dialogID", dialogId);
                requestBody.put("file_id", file_id);
                try (OutputStream os = conn.getOutputStream()) {
                    os.write(requestBody.toString().getBytes(StandardCharsets.UTF_8));
                }
                // 流式读取响应
                try (BufferedReader reader = new BufferedReader(
                        new InputStreamReader(conn.getInputStream()))) {
                    String line;
                    while ((line = reader.readLine()) != null) {
                        buffer.append(line).append("\n");
                        processBuffer(buffer, result);
                    }
                }
            } finally {
                if (conn != null) conn.disconnect();
            }
            return result;
        });
        try {
            return future.get(timeout_ms, TimeUnit.MILLISECONDS);
        } catch (TimeoutException e) {
            future.cancel(true);
            throw new RuntimeException("资源不足，请稍后重试！", e);
        } finally {
            executor.shutdown();
        }
    }

    /**
     * 解析流结果
     * @param buffer
     * @param result
     */
    private static void processBuffer(StringBuilder buffer, StreamResult result) {
        int position = result.lastPosition;
        String newData = buffer.substring(position);
        result.lastPosition = buffer.length(); // 更新最后读取位置
        String[] lines = newData.split("\n");
        for (String line : lines) {
            if (!line.startsWith("data:")) continue;
            try {
                String jsonStr = line.substring(5)
                        .replace("<think>", "")
                        .trim();
                // 解析JSON
                Map<String, Object> data = JSON.parseObject(jsonStr);
                if (data.get("dialogID") != null) {
                    result.dialogID = (String) data.get("dialogID");
                }
                if (data.get("answer") != null) {
                    String answer = (String)data.get("answer");
                    result.afterThink.append(answer);
                }
            } catch (Exception e) {
                System.err.println("解析失败: " + e.getMessage());
            }
        }
    }


    /**
     * 通用方法1：取多层Map（Map<String, List<Map<String, Object>>>）中第一个元素的指定Key值
     * @param sourceMap 源Map（比如goalGroupMap、yearBgtGroupMap）
     * @param proCode 项目编码
     * @param key 要取的Key（比如"kpi_target"、"yearbgtamt"）
     * @param converter 可选的值转换器（比如拼接"元"），不需要传null
     * @return 取值成功返回Optional包装的值，失败返回空
     */
    public static Optional<String> safeGetFirstGroupValue(
            Map<String, List<Map<String, Object>>> sourceMap,
            String proCode,
            String key,
            Function<Object, String> converter) {
        // 全链路前置判空，任何一层为空直接返回空
        if (sourceMap == null || StringUtils.isEmpty(proCode) || StringUtils.isEmpty(key)) {
            return Optional.empty();
        }
        // 取proCode对应的List
        List<Map<String, Object>> groupList = sourceMap.get(proCode);
        if (CollectionUtils.isEmpty(groupList)) {
            return Optional.empty();
        }
        // 取第0个元素
        Map<String, Object> firstGroup = groupList.get(0);
        if (firstGroup == null || !firstGroup.containsKey(key)) {
            return Optional.empty();
        }
        Object value = firstGroup.get(key);
        if (value == null) {
            return Optional.empty();
        }
        // 有转换器就做转换，没有直接返回toString
        String strValue = value.toString();
        return converter == null ? Optional.of(strValue) : Optional.of(converter.apply(value));
    }

    // 重载方法：不需要转换器的时候不用传第四个参数，调用更简洁
    public static Optional<String> safeGetFirstGroupValue(
            Map<String, List<Map<String, Object>>> sourceMap,
            String proCode,
            String key) {
        return safeGetFirstGroupValue(sourceMap, proCode, key, null);
    }

    /**
     * 通用方法2：取多层Map的整个List，做二次加工（比如调用packageIndexList）
     * @param sourceMap 源Map（比如indexGroupMap、totalIndexGroupMap）
     * @param proCode 项目编码
     * @param processor 二次处理函数，接收List返回处理后的结果
     * @return 处理成功返回Optional包装的结果，失败返回空
     */
    public static <T> Optional<T> safeProcessGroupList(
            Map<String, List<Map<String, Object>>> sourceMap,
            String proCode,
            Function<List<Map<String, Object>>, T> processor) {
        // 前置判空
        if (sourceMap == null || StringUtils.isEmpty(proCode) || processor == null) {
            return Optional.empty();
        }
        // 取proCode对应的List
        List<Map<String, Object>> groupList = sourceMap.get(proCode);
        if (CollectionUtils.isEmpty(groupList)) {
            return Optional.empty();
        }
        try {
            T result = processor.apply(groupList);
            // 如果二次处理结果是null也返回空，避免put空值
            return Optional.ofNullable(result);
        } catch (Exception e) {
            return Optional.empty();
        }
    }

    public static String processFileTxt(String file_id, int timeout_ms,String url, String apiKey, String api_code) throws Exception {
        StreamResult sresult = executeStreamRequest(url, file_id, apiKey, "请解析文件", "", timeout_ms, api_code);
        String fileTxt = sresult.afterThink.toString();
        return fileTxt;
    }

}
