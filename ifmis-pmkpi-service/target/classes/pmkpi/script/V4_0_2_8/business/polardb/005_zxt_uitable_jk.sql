BEGIN

update p#busfw_t_uitable set DEFQUERY = ' t.pro_code in (select t.PRO_code from v_pm_annual_expplan_info t where t.BUSI_TYPE=''3'') and t.pro_cat_code not in (''1'',''21'') ' where key ='/pmkpi/program/trace/manage/prolist';