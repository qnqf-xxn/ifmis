package gov.mof.fasp2.pmkpi.setting.index;

import gov.mof.fasp2.buscore.framework.exception.AppException;
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
public class IndexService extends PmkpiService {
    private IndexBO indexBO;

    public void setIndexBO(IndexBO indexBO) {
        this.indexBO = indexBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    /**
     * 查询
     * @param params
     * @return
     */
    public List<Map<String, Object>> getData(HashMap<String, Object> params) throws AppException {
        return indexBO.getData(params);
    }

    /**
     * 删除
     * @param parms --
     * @return
     */
    public Map<String, Object> del(HashMap<String,Object> parms){
        return indexBO.del(parms);
    }
}
