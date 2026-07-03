package gov.mof.fasp2.pmkpi.common.pendingtask;


import java.util.List;

/**
 "return_msg": "查询成功",
 "return_code": "0000",
 "count_all": "5",
 "type_data":
 */
public class ResultUtil {
    /**
     * 返回成功
     * @param data
     * @return
     */
    public static ResultDTO success(List<PendingTaskDTO> data, String count_all) {
        ResultDTO resultDTO = new ResultDTO();
        resultDTO.setReturn_code("0000");
        resultDTO.setReturn_msg("查询成功");
        resultDTO.setCount_all(count_all);
        resultDTO.setType_data(data);
        return resultDTO;
    }

    /**
     * 返回失败
     * @param return_msg
     * @return
     */
    public static ResultDTO error(String return_msg) {
        ResultDTO resultDTO = new ResultDTO();
        resultDTO.setReturn_code("0001");
        resultDTO.setReturn_msg(return_msg);
        return resultDTO;
    }
}
