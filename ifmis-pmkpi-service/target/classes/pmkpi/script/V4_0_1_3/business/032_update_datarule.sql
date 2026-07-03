begin
update pmkpi_t_datarule t set t.wheresql ='exists (select * from pmkpi_t_uservagency agen where agen.agency = ruletable.agencyguid and agen.userguid = ''#curruser#'')' where t.guid = 'uservagency';

