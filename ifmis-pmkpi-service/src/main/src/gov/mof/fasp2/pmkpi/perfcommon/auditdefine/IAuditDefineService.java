package gov.mof.fasp2.pmkpi.perfcommon.auditdefine;

import gov.mof.fasp2.buscore.framework.exception.AppException;

import java.util.List;
import java.util.Map;

public abstract interface IAuditDefineService {
    /**
     *  审核定义规则校验特殊
     * @param list --数据
     * @param busguid --业务类型唯一标识
     * @param wheresql--条件
     * @return
     * @throws AppException
     * @throws
     */
    public Map checkAuditDefinenewspec(List list, String busguid , String wheresql, Map params) throws AppException;

    /**
     * 审核定义规则校验特殊 多数据
     * @param list --数据
     * @param busguid --业务类型唯一标识
     * @param action--动作 back-退回/sendaudit-送审 /cancelsendaudit-取消送审/audit-审核/cancelaudit-取消审核 /save-保存update-修改delete-删除
     * @param wheresql--条件
     * @param guidcode--主键字段 用于把list数据主键做条件增加到 审核定义执行语句中
     * @return
     * @throws AppException
     * @throws
     */
    public Map checkAuditDefinenewspec(List list,String busguid ,String action,String wheresql,String guidcode) throws AppException;

}
