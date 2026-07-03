package gov.mof.fasp2.pmkpi.common.pendingtask;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.log.service.Logger;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.busportal.pendingtask.PendingTaskProtalDTO;
import io.swagger.annotations.ApiParam;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * 对外提供待办消息
 */
@Controller
@RequestMapping(value = "/pmkpi/quickdo")
public class PmkpiPendingController {

    //日志
    protected static Logger logger = Logger.getLogger(PmkpiPendingController.class);

    private PmkpiPendingBO pmkpiPendingBO;

    public PmkpiPendingBO getPmkpiPendingBO() {
        if(pmkpiPendingBO == null){
            pmkpiPendingBO = (PmkpiPendingBO) ServiceFactory.getBean("pmkpi.PmkpiPendingBO");
        }
        return pmkpiPendingBO;
    }


    /**
     * 通过接口返回代办数据
     * @param tokenid
     * @return
     */
    @RequestMapping(value = "/v1/quickdosync", method = RequestMethod.GET, produces = "application/json; charset=utf-8")
    @ResponseBody
    public ResultDTO getpmkpiPendingTask(@ApiParam(value = "用户认证信息") @RequestParam(required = false) String tokenid) throws AppException {
        logger.info("---绩效待办查询 start---");
        long st = System.currentTimeMillis();
        String errormsg = "";
        List<PendingTaskDTO> datas = new ArrayList<>();
        try {
            List<PendingTaskProtalDTO> pendlist = getPmkpiPendingBO().getPendingTask();
            for (PendingTaskProtalDTO pendingTaskProtalDTO : pendlist) {
                List childPendingTaskChild = (List) pendingTaskProtalDTO.getChildPendingTask();
                String name = pendingTaskProtalDTO.getName();
                int orderno = pendingTaskProtalDTO.getOrderno();
                String menuGuid = pendingTaskProtalDTO.getMenuGuid();
                for (Object o : childPendingTaskChild) {
                    PendingTaskProtalDTO omap = (PendingTaskProtalDTO) o;
                    String linkUrl = omap.getLinkUrl();
                    String menuurl = linkUrl + "&tokenid=" + tokenid;
                    String count = omap.getCount();

                    PendingElement element = new PendingElement();
                    element.setMenuurl(menuurl);
                    element.setButton3url(menuurl);
                    element.setTitle(name);
                    element.setId(menuGuid);
                    element.setTodocount(count);
                    PendingTaskDTO pendingTaskDTO = new PendingTaskDTO();
                    pendingTaskDTO.setData(Arrays.asList(element));
                    pendingTaskDTO.setOrdernum(orderno);
                    datas.add(pendingTaskDTO);
                }
            }
        } catch (Exception e) {
            errormsg = "失败" + e.getMessage();
            logger.error(e.getMessage(), e);
        }
        if (StringUtils.isBlank(errormsg)) {
            String count_all = datas.size() + "";
            if (datas.size()==0){
                PendingTaskDTO pendingTaskDTO = new PendingTaskDTO();
                pendingTaskDTO.setData(new ArrayList());
                pendingTaskDTO.setOrdernum(0);
                datas.add(pendingTaskDTO);
            }
            long usetime = (System.currentTimeMillis() - st);
            logger.info("绩效代办查询时间：" + usetime + "ms");
            logger.info("---绩效待办查询 end---");
            return ResultUtil.success(datas, count_all);
        } else {
            return ResultUtil.error(errormsg);
        }
    }


}
