package gov.mof.fasp2.pmkpi.perfset.datarule;

import gov.mof.fasp2.buscore.framework.exception.AppException;


public interface IPmkpiRightService {
    /**
     * 获取页面的数据权限.
     * @param s -- 菜单
     * @param s1 -- 别名标识.
     * @return
     * @throws AppException -- 自定义异常.
     * @throws
     */
    public abstract String getPageDataRights(String s, String s1) throws AppException;
}
