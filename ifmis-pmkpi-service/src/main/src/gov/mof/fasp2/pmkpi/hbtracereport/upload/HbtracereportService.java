package gov.mof.fasp2.pmkpi.hbtracereport.upload;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

public class HbtracereportService extends PmkpiService {
    private HbtracereportBO hbtracereportBO;

    public void setHbtracereportBO(HbtracereportBO hbtracereportBO) {
        this.hbtracereportBO = hbtracereportBO;
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> delDatas(HashMap<String,Object> parms){
        return hbtracereportBO.delDatas(parms);
    }

    /**
     * 编辑区查询
     * @return
     */
    public Map<String, Object> editquery(HashMap<String, Object> params) throws AppException {
        return hbtracereportBO.editquery(params);
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map infosave(HashMap config) {
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = hbtracereportBO.infosave(config);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
        return rs;
    }

    /**
     * 编辑区保存
     * @param config --
     * @return
     * @throws AppException
     */
    public Map issave(HashMap config) {
        Map<String, Object> rs = hbtracereportBO.issave(config);
        return rs;
    }
}
