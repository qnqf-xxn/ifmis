begin

delete from perf_t_imptemp t where t.temptype in('hfbmztzpj');
insert into v_perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('0E1C11AC213B5A0BE0630A64A8C0F794', 'hfbmztzpj', 'bgtget', 8, 'name', 'completion', 'amt1', 'amt3', 'amt5', 'amt4', 'amt6', 'bgtget', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into v_perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('0E1C11AC213C5A0BE0630A64A8C0F794', 'hfbmztzpj', 'desc1', 13, 'yeargoal', 'allyeargoal', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');

insert into v_perf_t_imptemp (GUID, TEMPTYPE, DATATYPE, NUM, C1, C2, C3, C4, C5, C6, C7, C8, C9, C10, C11, C12, C13, C14, C15, C16, C17, C18, C19, C20, C21, C22, C23, C24, C25, YEAR, PROVINCE)
values ('0E1C11AC213D5A0BE0630A64A8C0F794', 'hfbmztzpj', 'index', 15, 'findex', 'sindex', 'name', 'yearindexval', 'actualvalue', 'actualweight', 'score', 'kpi_remark', null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, '2016', '87');
