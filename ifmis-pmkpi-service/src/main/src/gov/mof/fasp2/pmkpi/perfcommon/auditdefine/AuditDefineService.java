package gov.mof.fasp2.pmkpi.perfcommon.auditdefine;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 审核定义
 */
public class AuditDefineService extends PmkpiService implements IAuditDefineService {
    private AuditDefineBO auditDefineBO;

    public void setAuditDefineBO(AuditDefineBO auditDefineBO) {
        this.auditDefineBO = auditDefineBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
//        String errorDatas = request.getParameter("errorDatas");//审核定义错误信息
//        //指标信息json转成Map
//        String str = URLDecoder.decode(errorDatas, "utf-8");
//        String formatJson= StringEscapeUtils.unescapeJavaScript(str);
//        List datas = PerfUtil.parseString2List(formatJson.substring(1,formatJson.length()-1));
//        config.put("errorDatas", datas);
        return config;
    }

    @Override
    public Map checkAuditDefinenewspec(List buslist, String busguid, String wheresql, Map params) throws AppException {
        List list = auditDefineBO.getBusauditdefine(busguid); // 获取缓存中的业务定义与审核定义的关系
        Map map = new HashMap();
        Map remap = new HashMap();
        if (params != null && !params.isEmpty()) {
            remap = params;
        }
        List relist = new ArrayList();
        String errmsg ="Y";
        String errtype = "tips";
        remap.put("redata",relist);
        remap.put("success", true);
        if (list.size() > 0) {
            for (int i = 0; i < list.size(); i++) {
                map = (Map) list.get(i);
                if("force".equals((String)map.get("errtype"))){
                    errtype = (String)map.get("errtype");
                }
                // 根据此业务类型取到的审核定义中，符合调用动作和调用方式以及报警级别的继续校验
                Map  map1 = this.checkAuditDefinenew(null, buslist, map.get("auditdefine").toString(), wheresql, busguid, map);
                boolean  status = (Boolean) map1.get("success");
                errmsg = (String)remap.get("errmsg")==null?"":(String)remap.get("errmsg");
                if(!status){
                    remap.put("success", status);
                    relist.addAll((List)map1.get("redata"));
                    errmsg ="/" +(String)map1.get("errstr");
                }
            }
        }
        remap.put("msg", errmsg);
        remap.put("errmsg", errmsg);
        remap.put("errtype", errtype);
        boolean  success = (Boolean) remap.get("success");
        if(!success && "force".equals(errtype)){
            throw new PerfAppException("checkAuditDefine", errtype, remap);
        }
        return remap;
    }

    /**
     * 审核定义规则校验
     * @param auditcode 审核定义规则序号（序号和id保持一致，并不允许重复）
     * @param wheresql --数据权限
     * @param fwbus--业务类型唯一标识
     * @throws AppException
     * @throws
     */
    public Map checkAuditDefinenew(String guidcode, List list, String auditcode, String wheresql, String fwbus, Map definemap) throws AppException {
        //获取request
        Map map = new HashMap();
        map.put("success", true);//默认成功状态
        if (auditcode == null || auditcode.isEmpty()) {
            map.put("success", false);
            map.put("errstr", "审核定义规则不存在，请检查！");
            return map;
        }
        if (wheresql == null|| wheresql.isEmpty()  ) {
            wheresql = " 1=1 ";
        }
        auditDefineBO.checkAuditDefinenew(guidcode,list,map, auditcode, wheresql, fwbus,definemap);
        return map;
    }

    @Override
    public Map checkAuditDefinenewspec(List list, String busguid, String action, String wheresql, String guidcode) throws AppException {
        return null;
    }
}
