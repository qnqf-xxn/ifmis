begin
 update p#busfw_t_uicolumn t set t.type = 'f' where t.key = '/pmkpi/perfself/apply/edit/bdgpay' and t.columncode in ('SCORE','AMT5');
