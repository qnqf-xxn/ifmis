package gov.mof.fasp2.pmkpi.perfcommon.filelist;

import gov.mof.fasp2.pmkpi.common.PmkpiService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UploadFileService extends PmkpiService {

    private UploadFileBO uploadFileBO;

    public void setUploadFileBO(UploadFileBO uploadFileBO) {
        this.uploadFileBO = uploadFileBO;
    }

    public Map<String,Object> queryFiletype (HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        List<Map<String, Object>> data = uploadFileBO.queryFiletype(params);
        rs.put("data", data);
        rs.put("success", true);
        return rs;

    }
}
