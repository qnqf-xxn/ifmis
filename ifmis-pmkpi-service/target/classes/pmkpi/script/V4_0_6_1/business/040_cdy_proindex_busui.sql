begin

update p#busfw_t_uicolumn t set t.coltype=6 where t.key in('/pmkpi/program/prjindex/recomindex') and t.columncode in('ISSTANDPUSH','COMPUTETYPE','INDEXSTANDARDS');
