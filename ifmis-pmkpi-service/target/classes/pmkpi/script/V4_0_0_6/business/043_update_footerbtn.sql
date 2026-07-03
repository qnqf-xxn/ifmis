begin
update Bus_t_Pageconsole t set t.config = '{main:[tabpage,editform,mxdatatable],footer:[toolbutton]}' where t.url = '/pmkpi/program/report/edit';