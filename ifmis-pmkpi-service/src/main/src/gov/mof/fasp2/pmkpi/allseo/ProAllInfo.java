package gov.mof.fasp2.pmkpi.allseo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ProAllInfo extends PmkpiService {
    /**
     * 注入bo.
     */
    private ProSeoBO proSeoBO;

    public void setProSeoBO(ProSeoBO proSeoBO) {
        this.proSeoBO = proSeoBO;
    }

    @SuppressWarnings("unchecked")
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String pro_code = request.getParameter("pro_code");
        config.put("pro_code",pro_code); //项目编码
        config.put("proguid", request.getParameter("proguid"));
        return config;
    }
    
    /**
     * 查询表格的数据内容.
     * @param parms -- 参数
     * @return --
     */
    public Map<String, Object> datableQuery(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        try {
            backMap = proSeoBO.getData(parms);
            backMap.put("flg", "1");
            backMap.put("msg", "查询成功");
        } catch (AppException e) {
            backMap.put("flg", "0");
            backMap.put("msg", e.getMessageNoCode().replaceAll("-null", "查询失败"));
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 查询编辑区的数据内容.
     * @param parms--参数.
     * @return
     * @throws AppException --自定义异常.
     */
    public Map<String, Object> editQuery(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        try {
            backMap = proSeoBO.editquery(parms);
            backMap.put("flg", "1");
            backMap.put("msg", "查询成功");
        } catch (AppException e) {
            backMap.put("flg", "0");
            backMap.put("msg", e.getMessageNoCode().replaceAll("-null", "查询失败"));
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

    /**
     * 查询所有数据内容.
     * @param parms--参数.
     * @return
     * @throws AppException
     */
    public Map<String, Object> getAllData(HashMap<String,Object> parms) throws AppException {
        Map<String, Object> backMap = new HashMap<>();
        try {
            String pro_code = (String) parms.get("pro_code");
            String proguid = (String) parms.get("proguid");
            Map<String, Object> proNodes = proSeoBO.getProNodes(pro_code);
            List<Map<String, Object>> nodedatas = (List<Map<String, Object>>) proNodes.get("datas");
            if(nodedatas!=null && nodedatas.size()>0){
                for (Map<String, Object> node : nodedatas ) {
                    String nodeguid = (String) node.get("guid");
                    HashMap<String,Object> queryparms = new HashMap<>();
                    queryparms.put("guid",node.get("guid"));
                    queryparms.put("code",node.get("code"));
                    queryparms.put("pro_code",pro_code);
                    queryparms.put("proguid",proguid);
                    if(nodeguid.indexOf("editform") != -1){
                        backMap.put(nodeguid,editQuery(queryparms));
                    }else if(nodeguid.indexOf("datatable") != -1){
                        backMap.put(nodeguid,datableQuery(queryparms));
                    }
                }
            }
            backMap.put("flg", "1");
            backMap.put("msg", "查询成功");
        } catch (AppException e) {
            backMap.put("flg", "0");
            backMap.put("msg", e.getMessageNoCode().replaceAll("-null", "查询失败"));
            logger.error(e.getMessage(), e);
        }
        return backMap;
    }

}
