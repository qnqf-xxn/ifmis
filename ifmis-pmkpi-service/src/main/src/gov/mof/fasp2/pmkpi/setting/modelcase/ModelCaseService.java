package gov.mof.fasp2.pmkpi.setting.modelcase;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 20:45 2020/8/18  chongdayong
 */
public class ModelCaseService extends PmkpiService {
    private ModelCaseBO modelCaseBO;

    public void setModelCaseBO(ModelCaseBO modelCaseBO) {
        this.modelCaseBO = modelCaseBO;
    }

    /**
     * 列表保存.
     * @param params --
     * @return --
     */
    /*public Map<String, Object> save(HashMap<String, Object> params) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            modelCaseBO.tablesave(params);
            rs.put("success", true);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }*/

    /**
     * 查询数据.
     * @param parms --
     * @return --
     */
    public Map<String, Object> getDatas(HashMap<String,Object> parms) throws AppException {
        return modelCaseBO.getData(parms);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return modelCaseBO.del(parms);
    }
}
