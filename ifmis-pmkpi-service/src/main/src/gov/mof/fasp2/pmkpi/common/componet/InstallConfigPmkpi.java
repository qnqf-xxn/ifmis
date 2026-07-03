package gov.mof.fasp2.pmkpi.common.componet;

import javax.sql.DataSource;

import com.longtu.framework.install.InstallConfig;

/**
 * @author Administrator
 *
 */
public class InstallConfigPmkpi implements InstallConfig {

	/* (non-Javadoc)
	 * @see com.longtu.framework.install.InstallConfig#expandPartition()
	 */
	@Override
	public void expandPartition() {
		// TODO Auto-generated method stub
	}

	/* (non-Javadoc)
	 * @see com.longtu.framework.install.InstallConfig#getAppid()
	 */
	@Override
	public String getAppid() {
		// TODO Auto-generated method stub
		return "pmkpi";
	}

	/* (non-Javadoc)
	 * @see com.longtu.framework.install.InstallConfig#getInstallScriptURI()
	 */
	@Override
	public String getInstallScriptURI() {
		// TODO Auto-generated method stub
		return "pmkpi.script";
	}

	/* (non-Javadoc)
	 * @see com.longtu.framework.install.InstallConfig#getInstallVersion()
	 */
	@Override
	public String getInstallVersion() {
		// TODO Auto-generated method stub
		return "V1_0_0_1";
	}

	/* (non-Javadoc)
	 * @see com.longtu.framework.install.InstallConfig#getSpecial()
	 */
	@Override
	public String getSpecial() {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.longtu.framework.install.InstallConfig#getTagDataSource(java.lang.String)
	 */
	@Override
	public DataSource getTagDataSource(String arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	/* (non-Javadoc)
	 * @see com.longtu.framework.install.InstallConfig#needReboot()
	 */
	@Override
	public boolean needReboot() {
		// TODO Auto-generated method stub
		return false;
	}

}