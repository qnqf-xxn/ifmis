package gov.mof.fasp2.pmkpi.setting.indexlib.report;

import gov.mof.fasp2.buscommon.bill.utils.CommonUtil;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.busdic.dto.DicRangeDTO;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 14:53 2020/8/17  chongdayong
 */
public class IndexRpService extends PmkpiService {

    private IndexRpBO indexRpBO;

    @Resource(name = "pmkpi.setting.indexlib.report.IndexRpBOTx")
    public void setIndexRpBO(IndexRpBO indexRpBO) {
        this.indexRpBO = indexRpBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String menuid = request.getParameter("menuId");
        String isGx = PerfUtil.getSystemSet("IS_GUANGXI");
        String isHubei = PerfUtil.getSystemSet("IS_HUBEI");
        config.put("menuid", menuid);
        config.put("isGx",isGx); //判断是否为广西省份.
        config.put("isHubei",isHubei); //判断是否为湖北模式
        String upagency = CommonUtil.getCurrentUser().getUpagencyid();
        String agency = CommonUtil.getCurrentUser().getAgency();
        config.put("isupagency", (upagency == null || upagency.equals(agency)) ? "0" : "1");//是否是提级用户,部门整体单位填报时，部门是否可以填报进行判断，提级用户才可填报部门指标
        return config;
    }

    /**
     * 删除
     *
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String, Object> parms) {
        return indexRpBO.del(parms);
    }

    /**
     * 审核/送审/取消审核/退回
     *
     * @param params --
     * @return --
     */
    public Map<String, Object> wfAudit(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = indexRpBO.wfAudit(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code", e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<DicRangeDTO> getTreeData (HashMap<String, Object> params) throws AppException {
        return indexRpBO.getTreeData(params);
    }

    /**
     * 广西校验指标导入的密匙.
     * @param parms
     * @return
     */
    public boolean checkImpkey(HashMap<String, Object> parms) throws AppException {
        return indexRpBO.checkImpkey(parms);
    }

    /**
     * 删除项目
     *（删除左侧项目,同时项目下指标也一同删除）
     * @param parms --
     * @return
     */
    public Map<String, Object> delpro(HashMap<String, Object> parms) {
        return indexRpBO.delpro(parms);
    }
}
