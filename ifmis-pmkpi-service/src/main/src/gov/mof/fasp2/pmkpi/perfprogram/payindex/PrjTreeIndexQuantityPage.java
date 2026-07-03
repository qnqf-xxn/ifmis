package gov.mof.fasp2.pmkpi.perfprogram.payindex;

import gov.mof.fasp2.pmkpi.common.PmkpiPage;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

public class PrjTreeIndexQuantityPage extends PmkpiPage {

    public Map<String, Object> index(HttpServletRequest request, HttpServletResponse response,
            Map<String, Object> config) throws Exception {
        return config;
    }
}
