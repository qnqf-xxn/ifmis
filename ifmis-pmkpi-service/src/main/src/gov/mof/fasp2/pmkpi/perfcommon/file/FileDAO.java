package gov.mof.fasp2.pmkpi.perfcommon.file;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.sec.syncuserinfo.SecureUtil;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @Description:
 * @Revision History:
 * @Revision 9:47 2020/8/24  chongdayong
 */
public class FileDAO extends PmkpiDAO {
    /**
     * 上传附件表.
     */
    public static final String PMKPI_FILE_TABLE = "V_PERF_FILE";

    /**
     * 根据单据guid查询文件列表.
     *
     * @param billguid 单据guid.
     * @param filetype 类型.
     * @return 分解数据
     * @throws AppException 异常
     */
    public List getFileList(String billguid, String filetype) throws AppException {
        StringBuilder currentLevel = new StringBuilder("SELECT t.* FROM " + PMKPI_FILE_TABLE + " t WHERE t.BILLGUID='" + billguid + "'");
        if (!StringUtil.isEmpty(filetype)) {
            currentLevel.append(" and t.filetype = '");
            currentLevel.append(filetype).append("'");
        }
        logger.debug("pmkpi-getFileList:" + currentLevel.toString());
        return this.queryForList(currentLevel.toString());
    }

    /**
     * 删除附件信息
     *
     * @param fileguid 文件guid
     * @throws AppException 异常
     */
    public void deleteFile(String fileguid) throws AppException {
        String str = "select * from " + PMKPI_FILE_TABLE + " where fileguid=?";
        List list = this.queryForList(str, new Object[]{fileguid});
        if (list.size() > 0) {
            String s = "delete from " + PMKPI_FILE_TABLE + " where fileguid = ?";
            this.update(s, new String[]{fileguid});
        }
    }

    /**
     * 删除附件信息
     *
     * @param billguid --业务单据.
     * @throws AppException 异常
     */
    public void deleteFileByBillguid(String billguid) throws AppException {
        String str = "select * from " + PMKPI_FILE_TABLE + " where billguid=?";
        List list = this.queryForList(str, new Object[]{billguid});
        if (list.size() > 0) {
            String s;
            s = "delete from " + PMKPI_FILE_TABLE + " where billguid = ?";
            this.update(s, new String[]{billguid});
        }
    }

    /**
     * 删除guids.
     *
     * @param billguids
     * @throws AppException
     */
    public void deleteFileByBillguids(List<String> billguids) throws AppException {
        if (billguids != null && !billguids.isEmpty()) {
            this.getJdbcTemplate().execute("delete from " + PMKPI_FILE_TABLE + " where "
                    + parseInSql("billguid", billguids));
        }
    }

    /**
     * 保存附件信息
     *
     * @param billguid 单据guid.
     * @param fileguid 文件guid.
     * @param filetype -- 附件类型.
     * @throws AppException 异常
     */
    public void saveFileData(String billguid, String fileguid, String filename, String filetype) throws AppException {
        String s = "insert into " + PMKPI_FILE_TABLE
                + "(guid,billguid,fileguid,filename,creater,creatername,create_time,update_time, filetype,year,province) "
                + "values(?,?,?,?,?,?,?,?,?,?,?)";
        this.update(s, new Object[]{StringUtil.createUUID(), billguid, fileguid, filename
                , SecureUtil.getCurrentUser().getGuid()
                , SecureUtil.getCurrentUser().getName()
                , PerfUtil.getServerTimeStamp(), PerfUtil.getServerTimeStamp()
                , filetype, PerfUtil.getYear(), PerfUtil.getProvince()});
    }

    /**
     * 更新附件信息
     *
     * @param billguid - 假billguid
     * @param guids    - guid数组
     * @throws AppException
     * @throws
     */
    public void updateFileByBillguids(String billguid, List<String> guids) throws AppException {
        if (guids.size() == 0) {
            return;
        }
        if (guids.size() == 1) {// 单个
            String updateSql = "update " + PMKPI_FILE_TABLE
                    + " t set t.billguid = ?   where t.billguid = ? ";
            this.update(updateSql, new Object[]{guids.get(0), billguid});
        } else {// 批量
            String sql = "select * from " + PMKPI_FILE_TABLE + " t where t.billguid = ?";
            List<Map<String, Object>> list = this.queryForList(sql, new Object[]{billguid});
            if (list.size() != 0) {
                Map<String, Object> map = list.get(0);
                List<String> sqls = new ArrayList<String>();
                String delSql = "delete from " + PMKPI_FILE_TABLE + " t where t.billguid = '" + billguid + "'";
                sqls.add(delSql);
                for (String guid : guids) {
                    StringBuffer sqlStr = new StringBuffer();
                    sqlStr.append("insert into " + PMKPI_FILE_TABLE);
                    sqlStr.append("(guid,billguid,fileguid,filename,creater,creatername,create_time,update_time,filetype,year,province) values('" + StringUtil.createUUID() + "','");
                    sqlStr.append(guid + "','" + map.get("fileguid") + "','" + map.get("filename") + "','");
                    sqlStr.append(SecureUtil.getCurrentUserID() + "','" + SecureUtil.getCurrentUser().getName() + "','" + PerfUtil.getServerTimeStamp() + "','" + PerfUtil.getServerTimeStamp() + "','" + map.get("filetype"));
                    sqlStr.append("','" + PerfUtil.getYear() + "','" + PerfUtil.getProvince() + "')");
                    sqls.add(sqlStr.toString());
                }
                this.batchUpdate(sqls);
            }
        }
    }

    public Map<String, Object> queryFileName(String fileguid) {
        StringBuilder currentLevel = new StringBuilder("SELECT t.* FROM " + PMKPI_FILE_TABLE + " t WHERE t.fileguid= ? ");
        logger.debug("pmkpi-queryFileName:" + currentLevel.toString());
        return this.getDataMap(currentLevel.toString(),null,new String[]{fileguid});
    }
}
