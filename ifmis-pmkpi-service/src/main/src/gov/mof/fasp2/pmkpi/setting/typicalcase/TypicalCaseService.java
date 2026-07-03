package gov.mof.fasp2.pmkpi.setting.typicalcase;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:45 2020/8/18  chongdayong
 */
public class TypicalCaseService extends PmkpiService {
    private TypicalCaseBO typicalCaseBO;

    public void setTypicalCaseBO(TypicalCaseBO typicalCaseBO) {
        this.typicalCaseBO = typicalCaseBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String mainguid = request.getParameter("mainguid");
        String casetype = request.getParameter("casetype");
        String viewtype = request.getParameter("viewtype");
        String code = request.getParameter("code");
        config.put("code",code);
        config.put("mainguid",mainguid);
        config.put("casetype",casetype);
        config.put("viewtype",viewtype);
        String taskyear = request.getParameter("taskyear");
        if(StringUtils.isEmpty(taskyear))
            taskyear = CommonUtil.getYear();
        config.put("taskyear", taskyear);
        String taskprovince = request.getParameter("taskprovince");
        if(StringUtils.isEmpty(taskprovince))
            taskprovince = CommonUtil.getProvince();
        config.put("taskprovince",taskprovince);
        return config;
    }

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> editquery(HashMap<String,Object> parms) throws AppException {
        return typicalCaseBO.editquery(parms);
    }

    /**
     * 保存数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> infosave(HashMap<String,Object> parms) throws AppException {
        return typicalCaseBO.infosave(parms);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return typicalCaseBO.del(parms);
    }

    public List<DicRangeDTO> getTreeData (HashMap<String, Object> params) throws AppException {
        return typicalCaseBO.getTreeData(params);
    }

    /**
     * 授权/取消
     * @param parms --
     */
    public void auth(HashMap<String,Object> parms) throws AppException {
        typicalCaseBO.auth(parms);
    }
}
