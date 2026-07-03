begin

update bus_t_diccolumn t set t.datalength=9 where t.tablecode in('BUSFW_T_UITABLE','BUSFW_T_UICOLUMN','BUSFW_T_UIEDITFORM','BUSFW_T_UIQUERYFORM','BUSFW_T_UIFUNCTION','BUSFW_T_UITABPAGE') and t.datalength is null;
