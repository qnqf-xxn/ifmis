package gov.mof.fasp2.pmkpi.filter;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.busfw.ui.AbstractUIComponentService;
import gov.mof.fasp2.busfw.ui.IUIComponentConfigFilter;
import gov.mof.fasp2.busfw.ui.dto.TabpageDTO;
import gov.mof.fasp2.busfw.ui.dto.UIconfigDTO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class MergeTabFilter implements IUIComponentConfigFilter {

    /**
     * .
     * <p>
     * Title: Config权限过滤器
     */
    @Override
    public Map doFilter(HttpServletRequest request, HttpServletResponse response, Map config,
                        AbstractUIComponentService component) throws AppException {
        List<TabpageDTO> uidto = (List<TabpageDTO>) config.get("data");
        if (uidto.size() > 0) {
            UIconfigDTO uiInfo = uidto.get(0);
            if (uiInfo instanceof TabpageDTO) {
                this.doTabPageFilter(request, config, uidto);
            }
        }
        return config;
    }

    /**
     *
     * @Description: tabpage UI权限
     * @param request
     * @param config
     * @param uidto
     * @throws AppException
     */
    @SuppressWarnings({"rawtypes", "unchecked" })
    private void doTabPageFilter(HttpServletRequest request, Map config, List<TabpageDTO> uidto) throws AppException {
        String showtab = request.getParameter("showtab"); ////页签显示 1总+年2总3年
        //String isbefore = request.getParameter("isbefore");//1事前显示，0事前不显示
        String isbefore = (String) config.get("isbefore");
        String ProCat = request.getParameter("ProCat"); //项目类别 1 人员类 3共用经费 4 运转类其他 5 特定目标类
        //String ISXZZD = request.getParameter("ISXZZD"); //
        String ISXZZD = (String) config.get("isbefore");
        if (StringUtil.isEmpty(isbefore)){ isbefore = "0"; }
        if ("1".equals(ProCat) || "21".equals(ProCat) || "3".equals(ProCat) || "0".equals(ISXZZD)){
            isbefore = "0";
        }
        List<TabpageDTO> backList = new ArrayList<TabpageDTO>();
        for (int j = 0; j < uidto.size(); j++) {
            TabpageDTO tabinfo = uidto.get(j);
            String tabcode = tabinfo.getCode();
            if(tabcode.equals("total") && showtab != null && "3".equals(showtab)){
                continue;
            } else if(tabcode.equals("year") && showtab != null && "2".equals(showtab)){
                continue;
            }
            //处理事前
            if ("before".equals(tabcode) && "0".equals(isbefore)){
                continue;
            }
            backList.add(tabinfo);
        }
        config.put("data", backList);
    }

}