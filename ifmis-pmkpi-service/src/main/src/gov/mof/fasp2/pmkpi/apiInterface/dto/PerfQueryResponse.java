
package gov.mof.fasp2.pmkpi.apiInterface.dto;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;

import java.util.List;

/**
 * @author: zxt
 * @create: 2026/6/1
 * @FileName: PerfQueryResponse
 * 绩效查询响应结果
 */
public class PerfQueryResponse<T> {
    private List<T> result;
    private String code;
    private boolean success;
    private String message;

    public static <T> PerfQueryResponse<T> success(List<T> data) {
        PerfQueryResponse<T> resp = new PerfQueryResponse<>();
        resp.setSuccess(true);
        resp.setCode("200");
        resp.setMessage("查询成功");
        resp.setResult(data);
        return resp;
    }

    public static <T> PerfQueryResponse<T> error(String code, String msg) {
        PerfQueryResponse<T> resp = new PerfQueryResponse<>();
        resp.setSuccess(false);
        resp.setCode(code);
        resp.setMessage(msg);
        return resp;
    }

    /**
     * 将对象转换为下划线命名的JSON字符串
     */
    public static String toSnakeCaseJson(Object object) throws Exception {
        ObjectMapper mapper = new ObjectMapper();
        // 设置属性命名策略为下划线命名
        mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
        return mapper.writeValueAsString(object);
    }

    // Getters and Setters
    public List<T> getResult() {
        return result;
    }

    public void setResult(List<T> result) {
        this.result = result;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
