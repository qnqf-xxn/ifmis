package gov.mof.fasp2.pmkpi.common.cache;

import gov.mof.fasp2.buscore.framework.cache.service.ICacheInit;
import gov.mof.fasp2.buscore.framework.cache.service.ICacheService;

public class PmkpiJsonCache implements ICacheInit {
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
