
package gov.mof.fasp2.pmkpi.componentAllot;
import gov.mof.fasp2.buscore.framework.annotation.PageComponent;
import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @ClassName: PrjIndexService
 * @Description: Description of this class
 * @author <a href="mailto:gaoming@bjinfor.cn">GM</a>于 2022-1-19 上午10:41:56
 */
@PageComponent(serviceid = "pmkpiPerfDataAllotService",
        viewid = "pmkpiPerfDataAllotService",
        jsLib = "/pmkpi/setting/component/dataallotservice.js",
        jsObjectName = "Ext.lt.drtemplate.AllotIndex")
public class PerfDataAllotService extends PmkpiService {
    /**
     * perfComponentRuleBO.
     */
    private PerfComponentRuleBO perfComponentRuleBO;

    @Resource(name="pmkpi.componentAllot.PerfComponentRuleBOTX")
    public void setPerfComponentRuleBO(PerfComponentRuleBO perfComponentRuleBO) {
        this.perfComponentRuleBO = perfComponentRuleBO;
    }

    /**
     * Description: 传递名称，实现页面动态标题
     * </p>
     * @param request
     * @param response
     * @param config
     * @return
     * @throws Exception
     */
    @SuppressWarnings({ "rawtypes", "unchecked" })
    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        return super.loadComponent(request, response, config);
    }

    /**
     * 获取角色树
     * @param roletype 角色类型
     * @return
     * @throws AppException
     */
    public List getRoleTree(String roletype) throws AppException {
        return perfComponentRuleBO.getRoleTree(roletype);
    }

    /**
     * 根据产品标识和账套查询数据权限信息和系统菜单
     * @param params
     * @param
     * @return
     * @throws AppException
     */
    public Map getRightMenuByRoleId(HashMap<String, Object>  params) throws AppException {
        return perfComponentRuleBO.getRightMenuByRoleId(params);
    }



    /**
     * 下拉框数据
     * @return
     * @throws AppException
     */
    public Map<String, Object> getOptionDatas(HashMap<String, Object> params) throws AppException {
        return perfComponentRuleBO.getOptionDatas(params);
    }



    /**
     * 根据菜单选择按钮展示数据
     * @return
     * @throws AppException
     */
    public Map getOperation(HashMap<String, Object>  params) throws AppException {
        return perfComponentRuleBO.getOperation(params);
    }



    /**
     * @Description:保存菜单和操作组件的对应关系
     * @throws AppException
     */
    public void save(HashMap<String, Object>  params) throws AppException {
        perfComponentRuleBO.save(params);
    }

    /**
     * @Description:保存菜单和操作组件的对应关系
     * @throws AppException
     */
    public void clearsave(HashMap<String, Object>  params) throws AppException {
        perfComponentRuleBO.clearsave(params);
    }

    /**
     * 查询已经有组件权限的菜单
     * @param roleid
     * @return
     */
    public List<Map<String, Object>> getDataRult(String roleid){
        return perfComponentRuleBO.getDataRult(roleid);
    }

}
