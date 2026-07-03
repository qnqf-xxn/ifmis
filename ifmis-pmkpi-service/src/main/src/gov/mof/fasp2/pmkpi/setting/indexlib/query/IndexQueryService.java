package gov.mof.fasp2.pmkpi.setting.indexlib.query;

import gov.mof.fasp2.buscore.framework.exception.AppException;
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
 * @Revision 14:53 2020/8/17  chongdayong
 */
public class IndexQueryService extends PmkpiService {
    private IndexQueryBO indexQueryBO;

    public void setIndexQueryBO(IndexQueryBO indexQueryBO) {
        this.indexQueryBO = indexQueryBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);

    }

    /**
     * 左侧树数据
     * @param params
     * @return
     * @throws AppException
     */
    public List<DicRangeDTO> getTreeData (HashMap<String, Object> params) throws AppException {
        return indexQueryBO.getTreeData(params);
    }
}
