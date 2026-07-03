package gov.mof.fasp2.pmkpi.perfmidsave;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.Map;

public class PerfMidsaveService extends PmkpiService {

    private PerfMidsaveBO perfMidsaveBO;

    public void setPerfMidsaveBO(PerfMidsaveBO perfMidsaveBO) {
        this.perfMidsaveBO = perfMidsaveBO;
    }

    public Map<String, Object> getData(HashMap<String, Object> params) throws AppException {
        return perfMidsaveBO.getData(params);
    }

    public Map saveData(HashMap params) throws AppException {
        return  perfMidsaveBO.saveData(params);
    }
}
