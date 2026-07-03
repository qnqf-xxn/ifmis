package gov.mof.fasp2.pmkpi.perfprogram.report;

import gov.mof.fasp2.buscore.framework.daosupport.appexception.DaoAppException;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busdic.table.dto.DicTableDTO;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfServiceFactory;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TlpProgramDAO extends PmkpiDAO {
    /**
     * 批量处理数据，根据表的某个字段删除。
     * @param columnname -- 表字段
     * @param guid --- 字段值集集合
     * @param tabcode -- 注册表
     * @param upsql --修改字段
     * @param wheresql --条件语句
     * @return
     * @throws AppException
     */
    public Map<String, Object> getUpsql(String columnname, Collection<String> guid, String tabcode, String upsql, String wheresql) throws AppException {
        if (tabcode == null) {
            throw new AppException(DaoAppException.C11000200, DaoAppException.M11000200);
        }
        String tablename = this.getTableName(tabcode);
        StringBuilder vchsql = new StringBuilder();
        vchsql.append("update ").append(tablename).append(" t set ");
        vchsql.append(upsql);
        IDicTableQueryService dicQueryService = PerfServiceFactory.getIDicTableQueryService();
        String time = PerfUtil.getServerTimeStamp();
        DicTableDTO dicTableDTO = dicQueryService.getDicTable(tabcode.toLowerCase());
        List coll = (List) dicTableDTO.getListCol();
        int i = 0;
        for (Object obj : coll) {
            Map map = (Map) obj;
            if ("UPDATE_TIME".equals(map.get("columncode"))) {
                vchsql.append(", t.update_time=?");
                i++;
            }
            if ("UPDATETIME".equals(map.get("columncode"))) {
                vchsql.append(", t.updatetime=?");
                i++;
            }
        }
        String[] str = new String[i];
        for (int j = 0; j < i; j++) {
            str[j] = time;
        }
        StringBuffer wsql = new StringBuffer();
        if (!StringUtil.isEmpty(columnname) && guid != null && guid.size() > 0) {
            wsql.append(this.createInSql(columnname, guid)).append(" and ");
        }
        if (!StringUtil.isEmpty(wheresql)) {
            wsql.append(wheresql).append(" and ");
        }
        if (!StringUtil.isEmpty(wsql.toString())) {
            vchsql.append(" where ").append(wsql.delete(wsql.length() - 4, wsql.length()));
        }
        Map<String, Object> backMap = new HashMap<>();
        backMap.put("upsql", vchsql.toString());
        backMap.put("strs", str);
        return backMap;
    }
}
