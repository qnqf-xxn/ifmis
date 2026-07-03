i number;
begin

select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_INDEXAUTHURL';
if i=0 then
    execute immediate '
    create table perf_t_indexauthurl (
	  code   VARCHAR2(40) not null,
	  url   VARCHAR2(2000)
	)
    ';
end if;


select count(*) into i from user_tables where TABLE_NAME = 'PERF_T_INDEXAUTH';
if i=0 then
    execute immediate '
    create table PERF_T_INDEXAUTH
	(
	  guid       VARCHAR2(40) not null,
	  authcode   VARCHAR2(40) not null,
	  authname   VARCHAR2(2000),
	  selecttype VARCHAR2(100),
	  lefttree   VARCHAR2(100),
	  indexurl   VARCHAR2(2000),
	  remark     VARCHAR2(2000),
	  ordernum   NUMBER(5) not null,
	  status     NUMBER(1)
	)
    ';
    execute immediate 'alter table PERF_T_INDEXAUTH add constraint PK_PERF_T_INDEXAUTH primary key (GUID)';
end if;


execute immediate '
create or replace view v_perf_indexauthtmp as
select t.guid as guid,t.code as authcode,t.name as authname,''00'' as selecttype,''01,02,03'' as lefttree,p.url as indexurl,0 as status
from V_ELE_VD08001 t left join perf_t_indexauthurl p on t.code = p.code
where t.isleaf = 1
order by t.code
';

execute immediate '
CREATE OR REPLACE VIEW V_PERF_T_INDEXAUTH AS
SELECT
       ''idexcomcls'' guid,
       ''01'' code,
       ''共性'' name,
       ''#'' superguid,
       ''#'' superid,
       1 levelno,
       0 isleaf,
       1 status,
       ''1'' is_common_ind,
       ''109900000'' as province
FROM dual
 union all
 select guid,
       code,
       name,
       ''idexcomcls'' superguid,
       ''idexcomcls'' superid,
       2 levelno,
       1 isleaf,
       1 status,
       ''1'' is_common_ind,
       province
 from perf_enum where elementcode = ''IDEXCOMCLS'' and status=1 and province =PERF_AUTHPROVINCE_VIEW.get_province
 union all
  SELECT
         ''indexcomfunc'' guid,
         ''02'' code,
         ''个性'' name,
         ''#'' superguid,
         ''#'' superid,
         1 levelno,
         0 isleaf,
         1 status,
         ''0'' is_common_ind,
         ''109900000'' as province
  FROM dual
 union all
 select t.ele_code as guid,
       t.ele_code as code,
       t.ele_name as name,
       case
          when nvl((b.ele_code), ''#'') <> ''#'' then
            nvl(b.ele_code, ''#'')
          else
            ''indexcomfunc''
       end superguid,
       case
          when nvl(b.ele_code, ''#'') <> ''#'' then
            nvl(b.ele_code, ''#'')
          else
            ''indexcomfunc''
       end SUPERID,
       nvl(t.level_no,0)+1 as levelno,
       case
         when t.is_leaf = 0 and nvl(t.parent_id, ''#'') <> ''#'' then
          1
         else
          t.is_leaf
       end isleaf,
       t.is_enabled as status,
       ''0'' is_common_ind,
       t.mof_div_code as province
  from ELE_VD10004 t
  left join ELE_VD10004 b
    on t.parent_id = b.ele_id
 where t.is_enabled = 1
   and t.level_no in (1, 2)
   and (t.mof_div_code = ''109900000'' or t.mof_div_code =PERF_AUTHPROVINCE_VIEW.get_province)
   and (t.fiscal_year =PERF_AUTHPROVINCE_VIEW.get_year)
 ';  