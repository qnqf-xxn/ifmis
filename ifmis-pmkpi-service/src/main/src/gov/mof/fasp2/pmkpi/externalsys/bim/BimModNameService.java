package gov.mof.fasp2.pmkpi.externalsys.bim;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 基础库更新要素名称，绩效处理业务数据
 */
public class BimModNameService extends PmkpiService {
    private BimModNameBO bimModNameBO;

    public void setBimModNameBO(BimModNameBO bimModNameBO) {
        this.bimModNameBO = bimModNameBO;
    }

    public void modAgencyName(Map data) throws AppException {
        logger.info("绩效接收MQ消息，基础库更新单位名称，绩效处理开始，msg:" + data);
        List<Map<String, Object>> msgList = (List) data.get("msg");
        if (msgList.size() == 0) {
            logger.error("绩效接收MQ消息，基础库更新单位名称, 消息内容为空！不处理数据。");
            return;
        }
        List resultList = new ArrayList();
        for (Map msg : msgList) {
            Map res = new HashMap();
            res.put("msgid", msg.get("msgid"));
            res.put("newname", msg.get("newagencyname"));
            res.put("province", msg.get("province"));
            res.put("year", msg.get("year"));
            res.put("msgdata", PerfUtil.parse2Json(msg));
            try {
                res.put("status", bimModNameBO.modAgencyName(msg));
            } catch (Exception e) {
                e.printStackTrace();
                res.put("status", Integer.valueOf(3));
                res.put("remark", e.getMessage());
            }
            resultList.add(res);
        }
        bimModNameBO.result(resultList);
        logger.info("绩效接收MQ消息，基础库更新单位名称，绩效处理结束");
    }

}
