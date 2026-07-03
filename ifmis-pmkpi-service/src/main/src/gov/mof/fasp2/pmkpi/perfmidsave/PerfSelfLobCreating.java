package gov.mof.fasp2.pmkpi.perfmidsave;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.support.AbstractLobCreatingPreparedStatementCallback;
import org.springframework.jdbc.support.lob.LobCreator;
import org.springframework.jdbc.support.lob.LobHandler;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Map;

/**
 * 用于有大字段保存的情况
 */
public class PerfSelfLobCreating extends AbstractLobCreatingPreparedStatementCallback {

    /**
     * 参数
     */
    private Map<Integer,String> paramMap;
    /**
     * 大字段
     */
    private String clobData;
    /**
     * 大字段存的位置
     */
    private Integer  clobInt;


    public PerfSelfLobCreating(LobHandler lobHandler){
        super(lobHandler);
    }

    public void setClobData(String clobData) {
        this.clobData = clobData;
    }

    public void setClobInt(Integer clobInt) {
        this.clobInt = clobInt;
    }


    public void setParamMap(Map paramMap) {
        this.paramMap = paramMap;
    }


    @Override
    public void setValues(PreparedStatement ps,
                          LobCreator lobCreator) throws SQLException,
            DataAccessException {
        for(Integer key:paramMap.keySet()){
            ps.setString(key,paramMap.get(key));
        }
        lobCreator.setClobAsString(ps, clobInt, clobData);
    }
}
