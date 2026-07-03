
package gov.mof.fasp2.pmkpi.perfcommon.expdoc;

import gov.mof.fasp2.pmkpi.appexception.PerfAppException;

import java.util.List;
import java.util.Map;

public interface IExpDocABO {
    /**
     * 构造要导出的数据
     * @param param 业务传递参数
     * @param templateMap 模板信息
     * @return
     * @throws PerfAppException
     */
    @SuppressWarnings("rawtypes")
    public List<Map<String, Object>> genExpData(Map param, Map templateMap)throws PerfAppException;
}
