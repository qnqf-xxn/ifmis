package gov.mof.fasp2.pmkpi.perfutil;

import com.fasterxml.jackson.databind.ObjectMapper;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import org.apache.http.Consts;
import org.apache.http.NameValuePair;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.*;
import org.apache.http.client.utils.URLEncodedUtils;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.impl.conn.PoolingHttpClientConnectionManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * HTTP 请求工具类（优化版）
 * 支持连接池、超时、多种请求类型
 */
public class PerfHttpUtils {
    private static final Logger logger = LoggerFactory.getLogger(PerfHttpUtils.class);
    private static final ObjectMapper objectMapper = new ObjectMapper();
    private static final CloseableHttpClient httpClient;

    static {
        // 连接池配置
        PoolingHttpClientConnectionManager cm = new PoolingHttpClientConnectionManager();
        cm.setMaxTotal(50);
        cm.setDefaultMaxPerRoute(20);

        // 超时配置
        RequestConfig config = RequestConfig.custom()
                .setConnectTimeout(5000)          // 连接超时
                .setSocketTimeout(30000)          // 读取超时
                .setConnectionRequestTimeout(5000)
                .build();

        httpClient = HttpClients.custom()
                .setConnectionManager(cm)
                .setDefaultRequestConfig(config)
                .build();

        logger.info("HttpUtils 初始化完成，连接池已启动");
    }

    // ---------- 原有方法（保持兼容） ----------
    public static String doGetForm(String url, Map<String, String> params) throws IOException, AppException {
        String fullUrl = buildUrlWithParams(url, params);
        HttpGet httpGet = new HttpGet(fullUrl);
        logger.info("GET请求url:" + fullUrl);
        if (params != null && !params.isEmpty()) {
            logger.info("参数：" + PerfUtil.parse2Json(params));
        }
        return execute(httpGet);
    }

    /**
     * 可指定参数是否拼接到URL
     */
    public static String doPostForm(String url, Map<String, Object> params, Map<String, String> urlParams) throws IOException, AppException {
        if (urlParams != null && !urlParams.isEmpty()) {
            url = buildUrlWithParams(url, urlParams);
        }
        HttpPost httpPost = new HttpPost(url);
        httpPost.setHeader("Content-Type", "application/json");
        if (params != null && !params.isEmpty()) {
            List<NameValuePair> nameValuePairs = new ArrayList<>();
            for (Map.Entry<String, Object> entry : params.entrySet()) {
                nameValuePairs.add(new BasicNameValuePair(entry.getKey(), PerfUtil.parse2Json(entry.getValue())));
            }
            httpPost.setEntity(new UrlEncodedFormEntity(nameValuePairs, Consts.UTF_8));
        }
        logger.info("POST请求 url:" + url + " 参数：" + PerfUtil.parse2Json(params));
        return execute(httpPost);
    }

    public static String doPostJson(String url, String jsonBody, Map<String, String> urlParams) throws IOException {
        if (urlParams != null && !urlParams.isEmpty()) {
            url = buildUrlWithParams(url, urlParams);
        }
        HttpPost httpPost = new HttpPost(url);
        httpPost.setHeader("Content-Type", "application/json");
        httpPost.setEntity(new StringEntity(jsonBody, Consts.UTF_8));
        logger.info("POST JSON请求 url:" + url + " 参数：" + jsonBody);
        return execute(httpPost);
    }

    public static String doPostMultipart(String url, File file, String fileName,
                                         String fieldName, Map<String, String> urlParams) throws IOException {
        if (urlParams != null && !urlParams.isEmpty()) {
            url = buildUrlWithParams(url, urlParams);
        }
        // 修正：将额外参数拼接到URL（原方法有误）
        HttpPost httpPost = new HttpPost(url);

        MultipartEntityBuilder builder = MultipartEntityBuilder.create();
        builder.setCharset(Consts.UTF_8);
        ContentType fileContentType = ContentType.MULTIPART_FORM_DATA;
        builder.addBinaryBody(fieldName, file, fileContentType, fileName);

        httpPost.setEntity(builder.build());
        logger.info("POST Multipart请求 url:" + url);
        return execute(httpPost);
    }

    // 在 PerfHttpUtils.java 中添加

    /**
     * 发送 DELETE 请求（参数拼接到URL）
     * @param url 基础URL
     * @param params 查询参数（会自动拼接到?后面）
     */
    public static String doDelete(String url, Map<String, String> params) throws IOException, AppException {
        if (params != null && !params.isEmpty()) {
            url = buildUrlWithParams(url, params);
        }
        // 2. 创建 HttpDelete 对象（Apache HttpClient 专属）
        HttpDelete httpDelete = new HttpDelete(url);
        // 3. 如果需要，可以设置请求头（例如认证Token）
         httpDelete.setHeader("Content-Type", "application/json");
        // 4. 日志记录
        logger.info("DELETE请求 url:" + url);
        if (params != null && !params.isEmpty()) {
            logger.info("参数：" + PerfUtil.parse2Json(params));
        }
        // 5. 执行请求（复用现有的execute方法，因为HttpDelete也继承自HttpRequestBase）
        return execute(httpDelete);
    }

    // ---------- 公共辅助方法 ----------
    /**
     * 将参数拼接到URL（自动处理?和&）
     */
    private static String buildUrlWithParams(String url, Map<String, String> params) {
        if (params == null || params.isEmpty()) {
            return url;
        }
        List<NameValuePair> nameValuePairs = new ArrayList<>();
        for (Map.Entry<String, String> entry : params.entrySet()) {
            nameValuePairs.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
        }
        String paramString = URLEncodedUtils.format(nameValuePairs, Consts.UTF_8);
        return url + (url.contains("?") ? "&" : "?") + paramString;
    }

    /**
     * 统一执行请求（支持GET和POST）
     */
    private static String execute(HttpRequestBase request) throws IOException {
        try (CloseableHttpResponse response = httpClient.execute(request)) {
            int statusCode = response.getStatusLine().getStatusCode();
            String responseBody = EntityUtils.toString(response.getEntity(), "UTF-8");
            if (statusCode < 200 || statusCode >= 300) {
                logger.warn("HTTP请求失败，状态码：{}，响应：{}", statusCode, responseBody);
            }
            return responseBody;
        }
    }
}