package gov.mof.fasp2.pmkpi.setting.casepage.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

public class CaseQueryService extends PmkpiService {
    private CaseQueryBO caseQueryBO;

    public void setCaseQueryBO(CaseQueryBO caseQueryBO) {
        this.caseQueryBO = caseQueryBO;
    }

    public Map<String, Object> getTreeData (HashMap<String, Object> params) throws AppException {
        return caseQueryBO.getTreeData(params);
    }
}
