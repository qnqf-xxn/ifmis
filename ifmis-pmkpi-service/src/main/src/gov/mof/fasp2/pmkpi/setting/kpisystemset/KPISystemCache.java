package gov.mof.fasp2.pmkpi.setting.kpisystemset;


import gov.mof.fasp2.buscore.framework.cache.service.ICacheInit;
import gov.mof.fasp2.buscore.framework.cache.service.ICacheService;

public class KPISystemCache implements ICacheInit {

	
	private ICacheService cacher = null;
	
	public ICacheService getCacher() {
		return cacher;
	}

	public void setCacher(ICacheService cacher) {
		this.cacher = cacher;
	}

	@Override
	public void initCache(ICacheService cacher) {
		setCacher(cacher);
	}
}
