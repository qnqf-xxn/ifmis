 
  i integer;
begin
  select count(*) into i from user_tables  t where t.TABLE_NAME='PMKPI_T_USERVAGENCY';
  if i=0 then
     execute immediate '
      create table PMKPI_T_USERVAGENCY
      (
        userguid VARCHAR2(40) not null,
        agency   VARCHAR2(40) not null,
        year     NUMBER(4) not null
      )';
  end if;

