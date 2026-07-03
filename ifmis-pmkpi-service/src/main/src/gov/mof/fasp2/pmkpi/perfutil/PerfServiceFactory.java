package gov.mof.fasp2.pmkpi.perfutil;

import gov.mof.fasp2.buscommon.fileimport.fileimport.dao.FileImportErrorDAO;
import gov.mof.fasp2.buscore.framework.cache.service.ICacheService;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.busdic.dataset.service.IDataSetService;
import gov.mof.fasp2.busdic.table.service.IDicTableQueryService;
import gov.mof.fasp2.busfw.ui.datatable.IDatatableUIconfig;
import gov.mof.fasp2.busfw.ui.editform.UIEditformCacheInit;
import gov.mof.fasp2.busfw.ui.queryform.IQueryformUIconfig;
import gov.mof.fasp2.busfw.ui.queryform.UIQueryformCacheInit;
import gov.mof.fasp2.busfw.ui.tabpage.UITabpageCacheInit;
import gov.mof.fasp2.busfw.ui.toolbutton.UIFunctionCacheInit;
import gov.mof.fasp2.datacommon.workflow.service.IWorkflowService;
import gov.mof.fasp2.pmkpi.common.PmkpiBO;
import gov.mof.fasp2.pmkpi.common.PmkpiDAO;
import gov.mof.fasp2.pmkpi.perfcommon.expdoc.ExpDocService;
import gov.mof.fasp2.pmkpi.perfmidsave.PerfMidsaveBO;
import gov.mof.fasp2.pmkpi.perfset.datarule.IPmkpiRightService;

public class PerfServiceFactory extends ServiceFactory {
    /**
     * 数据权限.
     * @return -- IPmkpiRightService.
     * @throws -- 异常.
     */
    public static IPmkpiRightService getPmkpiRightService() {
        return (IPmkpiRightService) ctx.getBean("pmkpi.datarule.rightservice");
    }

    /**
     * 公共dao.
     * @return -- IPmkpiRightService.
     * @throws -- 异常.
     */
    public static PmkpiDAO getPmkpiDAO() {
        return (PmkpiDAO) ctx.getBean("pmkpi.common.PmkpiDAO");
    }

    /**
     * 公共bo.
     * @return -- IPmkpiRightService.
     * @throws -- 异常.
     */
    public static PmkpiBO getPmkpiBO() {
        return (PmkpiBO) ctx.getBean("pmkpi.common.PmkpiBO");
    }

    /**
     * 缓存类，存放值为直接结果，取出后不用处理直接使用.
     * @return -- ICacheService.
     * @throws -- 异常.
     */
    public static ICacheService getICacheService() {
        return (ICacheService) ctx.getBean("pmkpi.common.cacheserver");
    }

    /**
     * 缓存类，存放数据类型为json.
     * @return -- ICacheService.
     * @throws -- 异常.
     */
    public static ICacheService getICacheServiceJson() {
        return (ICacheService) ctx.getBean("pmkpi.jsondata.cacheserver");
    }

    /**
     * 缓存获取dictable注册信息.
     * @return -- ICacheService.
     * @throws -- 异常.
     */
    public static IDicTableQueryService getIDicTableQueryService() {
        return (IDicTableQueryService) ctx.getBean("bus.dic.table.queryService");
    }

    /**
     * 缓存获取datatable注册信息
     * @return
     */
    public static IDatatableUIconfig getIDatatableUIconfig() {
        return (IDatatableUIconfig) ctx.getBean("busfw.uiconfig.datatable");
    }

    /**
     * 缓存获取queryform注册信息
     * @return
     */
    public static IQueryformUIconfig getIQueryformUIconfig() {
        return (IQueryformUIconfig) ctx.getBean("busfw.uiconfig.queryform");
    }

    /**
     * 缓存获取tabpage注册信息
     * @return
     */
    public static UITabpageCacheInit getUITabpageCacheInit() {
        return (UITabpageCacheInit) ctx.getBean("busfw.cacheinit.uicacheinit.uitabpage");
    }

    /**
     * 缓存获取queryform注册信息
     * @return
     */
    public static UIQueryformCacheInit getUIQueryformCacheInit() {
        return (UIQueryformCacheInit) ctx.getBean("busfw.cacheinit.uicacheinit.queryform");
    }

    /**
     * 缓存获取editform注册信息
     * @return
     */
    public static UIEditformCacheInit getUIEditformCacheInit() {
        return (UIEditformCacheInit) ctx.getBean("busfw.cacheinit.uicacheinit.editform");
    }

    /**
     * 缓存获取editform注册信息
     * @return
     */
    public static UIFunctionCacheInit getUIFunctionCacheInit() {
        return (UIFunctionCacheInit) ctx.getBean("busfw.cacheinit.uicacheinit.uifuntion");
    }

    /**
     * 缓存获取dicsource注册信息
     * @return
     */
    public static IDataSetService getIDataSetService() {
        return (IDataSetService) ctx.getBean("bus.dic.datasetmanagerange.service");
    }

    /**
     * 暂存类
     * @return
     */
    public static PerfMidsaveBO getPerfMidsaveBO() {
        return (PerfMidsaveBO) ctx.getBean("pmkpi.perfmidsave.PerfMidsaveBOTX");
    }

    /**
     * 导入报错信息存储
     * @return
     */
    public static FileImportErrorDAO getFileImportErrorDAO() {
        return (FileImportErrorDAO) ctx.getBean("buscommon.file.FileimportErrorDao");
    }

    /**
     * 工作流
     */
    public static IWorkflowService getIWorkflowService() {
        return (IWorkflowService) ctx.getBean("datacommon.wf.WorkflowService");
    }

    /**
     * 获取导出报告文件
     * @return
     */
    public static ExpDocService getExtDocService() {
        return (ExpDocService) ctx.getBean("pmkpi.perfcommon.expdoc.ExpDocService");
    }

}
