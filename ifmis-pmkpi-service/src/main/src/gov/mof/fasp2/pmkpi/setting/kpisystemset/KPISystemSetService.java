package gov.mof.fasp2.pmkpi.setting.kpisystemset;

import gov.mof.fasp2.buscore.framework.exception.AppException;
import gov.mof.fasp2.buscore.framework.util.ServiceFactory;
import gov.mof.fasp2.buscore.framework.util.StringUtil;
import gov.mof.fasp2.pmkpi.appexception.PerfAppException;
import gov.mof.fasp2.pmkpi.common.PmkpiService;
import gov.mof.fasp2.pmkpi.syncdata.SyncDataBO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class KPISystemSetService extends PmkpiService {

	private KPISystemSetBO kpiSystemSetBO;

	public void setKpiSystemSetBO(KPISystemSetBO kpiSystemSetBO) {
		this.kpiSystemSetBO = kpiSystemSetBO;
	}

	@Override
	public Map loadComponent(HttpServletRequest request, HttpServletResponse response, Map config) throws Exception {
		super.loadComponent(request, response, config);
		String guid = request.getParameter("guid");
		if (!StringUtil.isEmpty(guid)) {
			String tablecode = request.getParameter("tablecode");
			String wheresql = " guid ='" + guid + "'";
			config.put("infoedit", kpiSystemSetBO.getDataMap(tablecode, wheresql));
			config.put("guid", guid);
			config.put("tablecode", tablecode);
		}
		return config;
	}

	/**
	 * 保存.
	 * @param params 参数.
	 * @return
	 * @throws Exception 
	 */
	public Map<String, Object> saveSystem(HashMap<String, Object> params) throws Exception{
		Map<String, Object> remp = new HashMap<String, Object>();
		try {
			kpiSystemSetBO.saveSystem(params);
            remp.put("success", true);
        } catch (PerfAppException e) {
            remp = e.getRemap();
            remp.put("code",e.getCode());
        } catch (AppException e) {
            logger.error(e.getMessage(), e);
        }
		return remp;
	}
	
	/**
	 * 获取guid. 
	 * @return guid.
	 * @throws AppException
	 */
	public String getGuid() throws AppException{
		return kpiSystemSetBO.getCreateguid();
	}

	/**
	 * 保存.
	 * @param params 参数.
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> syncBdmData(HashMap<String, Object> params) throws Exception{
		Map<String, Object> remp = new HashMap<String, Object>();
		SyncDataBO syncDataBO = (SyncDataBO) ServiceFactory.getBean("pmkpi.syncdata.SyncDataBOTX");
		try {
			//同步处理
			syncDataBO.syncBdmDatas(0);
			remp.put("success", true);
		} catch (PerfAppException e) {
			remp = e.getRemap();
			remp.put("code",e.getCode());
		} catch (AppException e) {
			logger.error(e.getMessage(), e);
		}
		return remp;
	}
}
