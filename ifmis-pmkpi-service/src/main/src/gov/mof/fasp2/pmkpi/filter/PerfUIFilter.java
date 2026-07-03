package gov.mof.fasp2.pmkpi.filter;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.buscore.framework.util.StringUtils;
import gov.mof.fasp2.busfw.ui.AbstractUIComponentService;
import gov.mof.fasp2.busfw.ui.IUIComponentConfigFilter;
import gov.mof.fasp2.busfw.ui.dto.DataColumnsDTO;
import gov.mof.fasp2.busfw.ui.dto.DatatableDTO;
import gov.mof.fasp2.busfw.ui.dto.TabpageDTO;
import gov.mof.fasp2.busfw.ui.dto.UIconfigDTO;
import gov.mof.fasp2.pmkpi.perfutil.PerfUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class PerfUIFilter implements IUIComponentConfigFilter {

    /**
     * .
     * <p>
     * Title: Config权限过滤器
     */
    @Override
    public Map doFilter(HttpServletRequest request, HttpServletResponse response, Map config,
                        AbstractUIComponentService component) throws AppException {
        String hidetab = request.getParameter("hidetab");
        String projectkind = request.getParameter("projectkind");
        config.put("projectkind", projectkind);
        List uidto = (List) config.get("data");
        if (uidto.size() > 0) {
            UIconfigDTO uiInfo = (UIconfigDTO) uidto.get(0);
            if (!StringUtils.isNullOrEmpty(hidetab)) {
                if (uiInfo instanceof TabpageDTO) {
                    this.doTabPageFilter(hidetab, config, uidto);
                }
            } else {
                if (uiInfo instanceof TabpageDTO) {
                    this.doTabPageFilter(request, config, uidto);
                }
            }
            if (uiInfo instanceof DatatableDTO) {
                DatatableDTO uiconfig = (DatatableDTO) uiInfo;
                this.doDataTableFilter(request, uiconfig);
            }
            //给页签排序重新赋值
            if (uiInfo instanceof TabpageDTO) {
                this.doTabOrdernumFilter(uidto);
            }
        }
        return config;
    }

    /**
     *
     * @Description: tabpage UI权限
     * @param hidetab
     * @param config
     * @param uidto
     * @throws AppException
     */
    @SuppressWarnings({"rawtypes", "unchecked" })
    private void doTabPageFilter(String hidetab, Map config, List<TabpageDTO> uidto) {
        List<TabpageDTO> tablist = new ArrayList<>();
        String projectkind = (String) config.get("projectkind");
        String[] hidetabs = hidetab.split(",");
        String sysprokind = StringUtil.isNullOrEmpty(PerfUtil.getTraprojectkind()) ? "00" : PerfUtil.getTraprojectkind();
        for (int j = 0; j < uidto.size(); j++) {
            TabpageDTO tabinfo = uidto.get(j);
            String tabcode = tabinfo.getCode().trim();
            for (int i=0; i<hidetabs.length;i++) {
                if (tabcode.equals(hidetabs[i])) {
                    tablist.add(tabinfo);
                }
            }
            if ((StringUtil.isNullOrEmpty(projectkind) || !projectkind.startsWith(sysprokind))
                    && ("traindex".equals(tabcode) || "fundmanag".equals(tabcode))) {
                tablist.add(tabinfo);
            }
        }
        uidto.removeAll(tablist);
        for (int k = 0; k < uidto.size(); k++) {
            TabpageDTO tabinfo = uidto.get(k);
            tabinfo.put("ordernum", k+1);
        }
        config.put("data", uidto);
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
    private void doTabPageFilter(HttpServletRequest request, Map config, List<TabpageDTO> uidto) {
        String showtab = request.getParameter("showtab");
        String totalname = (String) config.get("totalname");
        String projectkind = (String) config.get("projectkind");
        List<TabpageDTO> tablist = new ArrayList<>();
        String sysprokind = StringUtil.isNullOrEmpty(PerfUtil.getTraprojectkind()) ? "00" : PerfUtil.getTraprojectkind();
        for (int j = 0; j < uidto.size(); j++) {
            TabpageDTO tabinfo = uidto.get(j);
            String tabcode = tabinfo.getCode().trim();
            if ("total".equals(tabcode) && "3".equals(showtab)) {
                tablist.add(tabinfo);
            } else if("year".equals(tabcode) && "2".equals(showtab)) {
                tablist.add(tabinfo);
            }
            if (tabcode.equals("total") && !StringUtils.isNullOrEmpty(totalname)) {
                tabinfo.put("name", totalname);
            }
            if ((StringUtil.isNullOrEmpty(projectkind) || !projectkind.startsWith(sysprokind))
                    && ("traindex".equals(tabcode) || "fundmanag".equals(tabcode))) {
                tablist.add(tabinfo);
            }
        }
        uidto.removeAll(tablist);
        config.put("data", uidto);
    }

    /**
     *
     * @Description: datatable UI权限
     * @param request
     * @param uiconfig
     * @throws AppException
     */
    @SuppressWarnings({"rawtypes", "unchecked" })
    private void doDataTableFilter(HttpServletRequest request, DatatableDTO uiconfig) {
        String showtab = request.getParameter("showtab");
        List<DataColumnsDTO> coList = uiconfig.getCols();
            for (int j = 0; j < coList.size(); j++) {
                DataColumnsDTO col = coList.get(j);
                String colcode = col.getColcode();
                if (!StringUtil.isEmpty(colcode) && "zqindexval".equals(colcode)) {
                    if (showtab != null && "3".equals(showtab)) {//年度
                        col.put("isvisiable", 1);
                        col.put("display", true);
                    } else if(showtab != null && "2".equals(showtab)) {//实施期
                        col.put("isvisiable", 0);
                        col.put("display", false);
                    }
                }
            }
    }

    /**
     *
     * @Description: tabpage UI权限
     * @param uidto
     * @throws AppException
     */
    @SuppressWarnings({"rawtypes", "unchecked" })
    private void doTabOrdernumFilter(List<TabpageDTO> uidto) {
        int i = 1;
        for (int j = 0; j < uidto.size(); j++) {
            TabpageDTO tabinfo = uidto.get(j);
            if (tabinfo.getIsvisiable() == 1) {
                tabinfo.setOrdernum(i);
                i++;
            }
        }
    }
}