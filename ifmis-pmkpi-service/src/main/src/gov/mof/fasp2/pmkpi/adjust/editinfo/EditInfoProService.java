package gov.mof.fasp2.pmkpi.adjust.editinfo;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class EditInfoProService extends PmkpiService {
    private EditInfoProBO editInfoProBO;

    public void setEditInfoProBO(EditInfoProBO editInfoProBO) {
        this.editInfoProBO = editInfoProBO;
    }

    @Override
    public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
        super.loadComponent(request, response, config);
        String prolev = request.getParameter("prolev"); //项目一二三级
        String mainguid = request.getParameter("mainguid"); //主键
        String proguid = request.getParameter("proguid"); //调整项目guid
        String viewtype = request.getParameter("viewtype"); //页面状态，修改/查看
        String busguid = request.getParameter("busguid"); //审核定义的guid
        String workflow = request.getParameter("workflow"); //审核定义的guid
        String procode = request.getParameter("procode");
        String bustype = request.getParameter("bustype");
        config.put("prolev",prolev);
        config.put("mainguid",mainguid);
        config.put("proguid",proguid);
        config.put("viewtype",viewtype);
        config.put("busguid",busguid);
        config.put("workflow",workflow);
        config.put("procode", procode);
        config.put("bustype", bustype);
        return config;
    }

    /**
     * 获取主单基本信息
     * @return
     */
    public Map<String, Object> getMaininfo(HashMap<String, Object> params){
        return editInfoProBO.getMaininfo(params);
    }

    /**
     * 查询项目信息
     * @param params --
     * @return
     */
    public Map<String, Object> getEditInfo(HashMap<String, Object> params) {
        return editInfoProBO.getEditInfo(params);
    }

    /**
     * 保存
     * @param params
     * @return
     */
    public Map<String, Object> save(HashMap<String, Object> params){
        Map<String, Object> rs = new HashMap<String, Object>();
        try {
            rs = editInfoProBO.save(params);
        } catch (PerfAppException e) {
            rs = e.getRemap();
            rs.put("code",e.getCode());
        } catch (AppException e) {
            e.printStackTrace();
        }
        return rs;
    }

}
