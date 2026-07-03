i integer;
begin
  select count(1) into i from user_indexes t where t.TABLE_NAME='PERF_ENUM' and t.INDEX_NAME='ELEMENTCODE_INDEX';
  if i =0 then
		execute immediate 'create index ELEMENTCODE_INDEX on PERF_ENUM(ELEMENTCODE)';
  end if;	
	 select count(1) into i from user_indexes t where t.TABLE_NAME='PERF_T_AUDITITEMS' and t.INDEX_NAME='MAINGUID_INDEX';
  if i =0 then
		execute immediate 'create index MAINGUID_INDEX on PERF_T_AUDITITEMS(MAINGUID)';
  end if;
	select count(1) into i from user_indexes t where t.TABLE_NAME='PERF_T_AUDITITEMS' and t.INDEX_NAME='PROGUID_INDEX';
		if i =0 then
		execute immediate 'create index PROGUID_INDEX on PERF_T_AUDITITEMS(PROGUID)';
  end if;	
		select count(1) into i from user_indexes t where t.TABLE_NAME='PERF_T_AUDITITEMS' and t.INDEX_NAME='TEMPGUID_INDEX';
		if i =0 then
		execute immediate 'create index TEMPGUID_INDEX on PERF_T_AUDITITEMS(TEMPGUID)';
  end if;
	select count(1) into i from user_indexes t where t.TABLE_NAME='PERF_T_REVIEW' and t.INDEX_NAME='TYPE_INDEX';
		if i =0 then
		execute immediate 'create index TYPE_INDEX on PERF_T_REVIEW(TYPE)';
  end if;
	select count(1) into i from user_indexes t where t.TABLE_NAME='PERF_T_REVIEW' and t.INDEX_NAME='ISLAST_INDEX';
		if i =0 then
		execute immediate 'create index ISLAST_INDEX on PERF_T_REVIEW(ISLAST)';
  end if;
	select count(1) into i from user_indexes t where t.TABLE_NAME='PERF_T_REVIEW' and t.INDEX_NAME='ISCONFIRM_INDEX' ;
		if i =0 then
		execute immediate 'create index ISCONFIRM_INDEX on PERF_T_REVIEW(ISCONFIRM)';
  end if;
	select count(1) into i from user_indexes t where t.TABLE_NAME='PERF_T_EVALUATEAUDIT' and t.INDEX_NAME='AUDITTYPE_INDEX' ;
		if i =0 then
		execute immediate 'create index AUDITTYPE_INDEX on PERF_T_EVALUATEAUDIT(AUDITTYPE)';
  end if;
	select count(1) into i from user_indexes t where t.TABLE_NAME='PERF_T_EVALUATEAUDIT' and t.INDEX_NAME='BUSTYPE_INDEX' ;
		if i =0 then
		execute immediate 'create index BUSTYPE_INDEX on PERF_T_EVALUATEAUDIT(BUSTYPE)';
  end if;