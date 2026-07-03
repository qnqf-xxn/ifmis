begin
delete FROM Bus_t_Pagecomponent t where t.id = 'pmkpi_file';
delete FROM Bus_t_Pageconsole t where t.url = '/pmkpi/file/index';
delete FROM Bus_t_Pageconsolecomconfig t where t.url = '/pmkpi/file/index';