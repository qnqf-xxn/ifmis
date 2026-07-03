begin
execute immediate '
CREATE OR REPLACE VIEW PMKPI_T_WFSTATUS AS
select * from fasp_t_pubwfstatus t';
