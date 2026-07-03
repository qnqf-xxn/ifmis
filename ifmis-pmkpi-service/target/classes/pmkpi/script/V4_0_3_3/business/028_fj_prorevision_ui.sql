begin

update p#busfw_t_uicolumn set isvisiable=0 where key ='/pmkpi/prorevision/report/list' and columncode in ('AGENCY_CODE','AGENCY_NAME');

update p#busfw_t_uicolumn set issource=0 where key ='/pmkpi/prorevision/report/list' and columncode ='PRO_CODE';
