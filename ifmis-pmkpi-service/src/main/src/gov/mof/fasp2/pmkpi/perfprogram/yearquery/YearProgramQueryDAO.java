package gov.mof.fasp2.pmkpi.perfprogram.yearquery;

import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class YearProgramQueryDAO extends PmkpiDAO {

    public List<Map<String, Object>> getLeftTree(String tablecode, String datarule) {
        if (!StringUtil.isEmpty(datarule)){
            StringBuffer sql = new StringBuffer();
            sql.append(" select distinct t.guid,t.code,t.name,t.superguid,t.superid,t.isleaf,t.levelno,t.agencyguid from ");
            sql.append(PMKPI_TABLE_T_AGENCY);
            sql.append(" t start with ");
            sql.append(" (" + datarule + ")");
            sql.append(" connect by prior t.superguid = t.guid");
            sql.append(" order by code ");
            return this.queryForList(sql.toString());
        } else {
            return new ArrayList<>();
        }
    }

}
