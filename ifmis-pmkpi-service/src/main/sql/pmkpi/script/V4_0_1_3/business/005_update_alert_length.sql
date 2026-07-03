
 num NUMBER;
 BEGIN 
 --BAS_PERF_INDICATORÐÂÔö×Ö¶Î
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BAS_PERF_INDICATOR') and column_name = upper('FINDEX');
   IF num > 0 THEN execute immediate 'alter table BAS_PERF_INDICATOR MODIFY FINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table BAS_PERF_INDICATOR add FINDEX varchar2(300)';
  END IF;  	 		
  	  
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BAS_PERF_INDICATOR') and column_name = upper('SINDEX');
   IF num > 0 THEN execute immediate 'alter table BAS_PERF_INDICATOR MODIFY SINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table BAS_PERF_INDICATOR add SINDEX varchar2(300)';
  END IF;  
  
  SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BAS_PERF_INDICATOR') and column_name = upper('TARGETVALUE');
   IF num > 0 THEN execute immediate 'alter table BAS_PERF_INDICATOR MODIFY TARGETVALUE varchar2(1000)';
  ELSE 
 execute immediate 'alter table BAS_PERF_INDICATOR add TARGETVALUE varchar2(1000)';
  END IF;  
  
SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BAS_PERF_INDICATOR') and column_name = upper('BIZ_KEY');
 IF num > 0 THEN execute immediate 'alter table BAS_PERF_INDICATOR MODIFY BIZ_KEY varchar2(38)';
  ELSE 
 execute immediate 'alter table BAS_PERF_INDICATOR add BIZ_KEY varchar2(38)';
  END IF;  
  
  SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BAS_PERF_INDICATOR') and column_name = upper('CODE');
   IF num > 0 THEN execute immediate 'alter table BAS_PERF_INDICATOR MODIFY CODE varchar2(300)';
  ELSE 
 execute immediate 'alter table BAS_PERF_INDICATOR add CODE varchar2(300)';
  END IF;  
      
  SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BAS_PERF_INDICATOR') and column_name = upper('NAME');
   IF num > 0 THEN execute immediate 'alter table BAS_PERF_INDICATOR MODIFY NAME varchar2(1000)';
  ELSE 
 execute immediate 'alter table BAS_PERF_INDICATOR add NAME varchar2(1000)';
  END IF;  
  
  SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BAS_PERF_INDICATOR') and column_name = upper('PERF_IND_CODE');
   IF num > 0 THEN execute immediate 'alter table BAS_PERF_INDICATOR MODIFY PERF_IND_CODE varchar2(300)';
  ELSE 
 execute immediate 'alter table BAS_PERF_INDICATOR add PERF_IND_CODE varchar2(300)';
  END IF;
    
    
    SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BAS_PERF_INDICATOR') and column_name = upper('PERF_IND_NAME');
   IF num > 0 THEN execute immediate 'alter table BAS_PERF_INDICATOR MODIFY PERF_IND_NAME varchar2(1000)';
  ELSE 
 execute immediate 'alter table BAS_PERF_INDICATOR add PERF_IND_NAME varchar2(1000)';
  END IF;  
    
    
    --PM_PERF_INDICATOR
          SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('NAME');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY NAME varchar2(1000)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add NAME varchar2(10000)';
  END IF; 
  
           SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('CODE');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY CODE varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add CODE varchar2(300)';
  END IF; 
  
       SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('KPI_LV1');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY KPI_LV1 varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add KPI_LV1 varchar2(300)';
  END IF;  

   SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('KPI_LV2');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY KPI_LV2 varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add KPI_LV2 varchar2(300)';
  END IF; 
  	 
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('KPI_LV3');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY KPI_LV3 varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add KPI_LV3 varchar2(300)';
  END IF;  	
  
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('FINDEX');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY FINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add FINDEX varchar2(300)';
  END IF;  	 		
  	  
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('SINDEX');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY SINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add SINDEX varchar2(300)';
  END IF;  
  
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('TINDEX');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY TINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add TINDEX varchar2(300)';
  END IF;  
	
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('KPI_VAL');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY KPI_VAL varchar2(1000)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add KPI_VAL varchar2(1000)';
  END IF; 
  
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('INDEXVAL');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY INDEXVAL varchar2(1000)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add INDEXVAL varchar2(1000)';
  END IF;  	
  
  SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('TARGETVALUE');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY TARGETVALUE varchar2(1000)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add TARGETVALUE varchar2(1000)';
  END IF;  
  
SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('AGENCY_CODE');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY AGENCY_CODE varchar2(21)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR add AGENCY_CODE varchar2(21)';
  END IF; 
 
 SELECT COUNT(1)  INTO num from user_tab_cols  where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('BUSI_TYPE_CODE');
        IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR MODIFY BUSI_TYPE_CODE varchar2(6)';
									execute immediate 'alter table  PM_PERF_INDICATOR modify BUSI_TYPE_CODE null';
						            execute immediate 'alter table  PM_PERF_INDICATOR modify BUSI_TYPE_CODE not null';    
    ELSE
		execute immediate 'alter table PM_PERF_INDICATOR add BUSI_TYPE_CODE varchar2(6)';
		execute immediate 'update PM_PERF_INDICATOR  set BUSI_TYPE_CODE =''2''';
		execute immediate 'alter table  PM_PERF_INDICATOR modify BUSI_TYPE_CODE not null';      
    END IF;  	
    
 SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR')  and column_name = upper('BUSI_TYPE');
	IF num > 0 THEN execute immediate 'update PM_PERF_INDICATOR b set BUSI_TYPE_CODE = (select b2.BUSI_TYPE from PM_PERF_INDICATOR b2 where b.guid = b2.guid  and rownum=1) where  b.BUSI_TYPE is not null';
					execute immediate 'alter table PM_PERF_INDICATOR drop (BUSI_TYPE)';
 END IF;   
     
	--	PM_PERF_INDICATOR_TEMP
	 SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('CODE');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY CODE varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add CODE varchar2(300)';
  END IF;  
   SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('NAME');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY NAME varchar2(1000)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add NAME varchar2(1000)';
  END IF; 
 SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('KPI_LV1');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY KPI_LV1 varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add KPI_LV1 varchar2(300)';
  END IF;  

   SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('KPI_LV2');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY KPI_LV2 varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add KPI_LV2 varchar2(300)';
  END IF; 
  	 
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('KPI_LV3');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY KPI_LV3 varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add KPI_LV3 varchar2(300)';
  END IF;  	
  
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('FINDEX');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY FINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add FINDEX varchar2(300)';
  END IF;  	 		
  	  
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('SINDEX');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY SINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add SINDEX varchar2(300)';
  END IF;  
  
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('TINDEX');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY TINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add TINDEX varchar2(300)';
  END IF;  
	
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('KPI_VAL');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY KPI_VAL varchar2(1000)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add KPI_VAL varchar2(1000)';
  END IF; 
  
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('INDEXVAL');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY INDEXVAL varchar2(1000)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add INDEXVAL varchar2(1000)';
  END IF;  	
  
    SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('TARGETVALUE');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY TARGETVALUE varchar2(1000)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add TARGETVALUE varchar2(1000)';
  END IF;  
  
SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('AGENCY_CODE');
   IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY AGENCY_CODE varchar2(21)';
  ELSE 
 execute immediate 'alter table PM_PERF_INDICATOR_TEMP add AGENCY_CODE varchar2(21)';
  END IF; 
  
   SELECT COUNT(1)  INTO num from user_tab_cols  where table_name = upper('PM_PERF_INDICATOR_TEMP') and column_name = upper('BUSI_TYPE_CODE');
        IF num > 0 THEN execute immediate 'alter table PM_PERF_INDICATOR_TEMP MODIFY BUSI_TYPE_CODE varchar2(6)';
    ELSE
    execute immediate 'alter table PM_PERF_INDICATOR_TEMP add BUSI_TYPE_CODE varchar2(6)';
    END IF;  	
  
 SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_INDICATOR_TEMP')  and column_name = upper('BUSI_TYPE');
	IF num > 0 THEN execute immediate 'update PM_PERF_INDICATOR_TEMP b set BUSI_TYPE_CODE = (select b2.BUSI_TYPE from PM_PERF_INDICATOR_TEMP b2 where b.guid = b2.guid and rownum=1) where  b.BUSI_TYPE is not null';
					execute immediate 'alter table PM_PERF_INDICATOR_TEMP drop (BUSI_TYPE)';
 END IF;   
     
  -- PM_PERF_GOAL_INFO
  SELECT COUNT(1)  INTO num from user_tab_cols  where table_name = upper('PM_PERF_GOAL_INFO') and column_name = upper('AGENCY_CODE');
        IF num > 0 THEN execute immediate 'alter table PM_PERF_GOAL_INFO MODIFY AGENCY_CODE varchar2(21)';
    ELSE
    execute immediate 'alter table PM_PERF_GOAL_INFO add 	AGENCY_CODE varchar2(21)';
    END IF;  
    
SELECT COUNT(1)  INTO num from user_tab_cols  where table_name = upper('PM_PERF_GOAL_INFO') and column_name = upper('BUSI_TYPE_CODE');
        IF num > 0 THEN execute immediate 'alter table PM_PERF_GOAL_INFO MODIFY BUSI_TYPE_CODE varchar2(6)';
    ELSE
    execute immediate 'alter table PM_PERF_GOAL_INFO add BUSI_TYPE_CODE varchar2(6)';
    END IF;  	
  
 SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_GOAL_INFO')  and column_name = upper('BUSI_TYPE');
	IF num > 0 THEN execute immediate 'update PM_PERF_GOAL_INFO b set BUSI_TYPE_CODE = (select b2.BUSI_TYPE from PM_PERF_GOAL_INFO b2 where b.guid = b2.guid  and rownum=1) where b.BUSI_TYPE is not null';
					execute immediate 'alter table PM_PERF_GOAL_INFO drop (BUSI_TYPE)';          
 END IF;   
	

  --PM_PERF_GOAL_TEMP
    SELECT COUNT(1)  INTO num from user_tab_cols  where table_name = upper('PM_PERF_GOAL_TEMP') and column_name = upper('AGENCY_CODE');
        IF num > 0 THEN execute immediate 'alter table PM_PERF_GOAL_TEMP MODIFY AGENCY_CODE varchar2(21)';
    ELSE
    execute immediate 'alter table PM_PERF_GOAL_TEMP add AGENCY_CODE varchar2(21)';
    END IF;  
       SELECT COUNT(1)  INTO num from user_tab_cols  where table_name = upper('PM_PERF_GOAL_TEMP') and column_name = upper('BUSI_TYPE_CODE');
        IF num > 0 THEN execute immediate 'alter table PM_PERF_GOAL_TEMP MODIFY BUSI_TYPE_CODE varchar2(6)';
    ELSE
    execute immediate 'alter table PM_PERF_GOAL_TEMP add BUSI_TYPE_CODE varchar2(6)';
    END IF;  	
  
 SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PM_PERF_GOAL_TEMP')  and column_name = upper('BUSI_TYPE');
	IF num > 0 THEN execute immediate 'update PM_PERF_GOAL_TEMP b set BUSI_TYPE_CODE = (select b2.BUSI_TYPE from PM_PERF_GOAL_TEMP b2 where b.guid = b2.guid  and rownum=1) where b.BUSI_TYPE is not null';
					execute immediate 'alter table PM_PERF_GOAL_TEMP drop (BUSI_TYPE)';           
 END IF;   
 
    
    --BGT_PERF_GOAL_INFO
        SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_GOAL_INFO') and column_name = upper('ADJ_BATCH_NO');
        IF num > 0 THEN execute immediate 'alter table BGT_PERF_GOAL_INFO MODIFY ADJ_BATCH_NO varchar2(6)';
    ELSE
    execute immediate 'alter table BGT_PERF_GOAL_INFO add ADJ_BATCH_NO varchar2(6)';
    END IF;  		
		 
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_GOAL_INFO') and column_name = upper('BUSI_TYPE_CODE');
        IF num > 0 THEN execute immediate 'alter table BGT_PERF_GOAL_INFO MODIFY BUSI_TYPE_CODE varchar2(6)';  
												execute immediate 'alter table  BGT_PERF_GOAL_INFO modify BUSI_TYPE_CODE  null';     
												execute immediate 'alter table  BGT_PERF_GOAL_INFO modify BUSI_TYPE_CODE not null';      
    ELSE
		execute immediate 'alter table BGT_PERF_GOAL_INFO add BUSI_TYPE_CODE varchar2(6)';
		execute immediate 'update BGT_PERF_GOAL_INFO  set BUSI_TYPE_CODE =''2''';
		execute immediate 'alter table  BGT_PERF_GOAL_INFO modify BUSI_TYPE_CODE not null';
    END IF; 
    
   -- BGT_PERF_INDICATOR
    SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('KPI_LV1');
   IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY KPI_LV1 varchar2(300)';
  ELSE 
 execute immediate 'alter table BGT_PERF_INDICATOR add KPI_LV1 varchar2(300)';
  END IF;  

   SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('KPI_LV2');
   IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY KPI_LV2 varchar2(300)';
  ELSE 
 execute immediate 'alter table BGT_PERF_INDICATOR add KPI_LV2 varchar2(300)';
  END IF; 
  	 
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('KPI_LV3');
   IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY KPI_LV3 varchar2(300)';
  ELSE 
 execute immediate 'alter table BGT_PERF_INDICATOR add KPI_LV3 varchar2(300)';
  END IF;  	
  
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('FINDEX');
   IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY FINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table BGT_PERF_INDICATOR add FINDEX varchar2(300)';
  END IF;  	 		
  	  
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('SINDEX');
   IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY SINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table BGT_PERF_INDICATOR add SINDEX varchar2(300)';
  END IF;  
  
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('TINDEX');
   IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY TINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table BGT_PERF_INDICATOR add TINDEX varchar2(300)';
  END IF;  
	
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('KPI_VAL');
   IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY KPI_VAL varchar2(1000)';
  ELSE 
 execute immediate 'alter table BGT_PERF_INDICATOR add KPI_VAL varchar2(1000)';
  END IF;
 
  
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('INDEXVAL');
   IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY INDEXVAL varchar2(1000)';
  ELSE 
 execute immediate 'alter table BGT_PERF_INDICATOR add INDEXVAL varchar2(1000)';	 
 END IF;
 
  SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('TARGETVALUE');
   IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY TARGETVALUE varchar2(1000)';
  ELSE 
 execute immediate 'alter table BGT_PERF_INDICATOR add TARGETVALUE varchar2(1000)';
  END IF;  
  
   SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR') and column_name = upper('ADJ_BATCH_NO');
        IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY ADJ_BATCH_NO varchar2(6)';
    ELSE
    execute immediate 'alter table BGT_PERF_INDICATOR add ADJ_BATCH_NO varchar2(6)';
    END IF;  
		
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('BGT_PERF_INDICATOR')  and column_name = upper('BUSI_TYPE_CODE');
        IF num > 0 THEN execute immediate 'alter table BGT_PERF_INDICATOR MODIFY BUSI_TYPE_CODE varchar2(6)';
												execute immediate 'alter table  BGT_PERF_INDICATOR modify BUSI_TYPE_CODE  null'; 
												execute immediate 'alter table  BGT_PERF_INDICATOR modify BUSI_TYPE_CODE not null'; 
    ELSE
		execute immediate 'alter table BGT_PERF_INDICATOR add BUSI_TYPE_CODE varchar2(6)';
		execute immediate 'update BGT_PERF_INDICATOR  set BUSI_TYPE_CODE =''2''';
		execute immediate 'alter table  BGT_PERF_INDICATOR modify BUSI_TYPE_CODE not null';    
    END IF;      

 --PERF_T_ADJUSTGOAL
 	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTGOAL')  and column_name = upper('BUSI_TYPE_CODE');
        IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTGOAL MODIFY BUSI_TYPE_CODE varchar2(6)';
										ELSE
										execute immediate 'alter table PERF_T_ADJUSTGOAL add BUSI_TYPE_CODE varchar2(6)';
										END IF;   
										  
     
     SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTGOAL') and column_name = upper('AGENCY_CODE');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTGOAL MODIFY AGENCY_CODE varchar2(21)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTGOAL add AGENCY_CODE varchar2(21)';
  END IF; 
     
     --PERF_T_ADJUSTINDEX
      SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('CODE');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY CODE varchar2(300)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add CODE varchar2(300)';
  END IF;  
   SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('NAME');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY NAME varchar2(1000)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add NAME varchar2(1000)';
  END IF; 
 SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('KPI_LV1');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY KPI_LV1 varchar2(300)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add KPI_LV1 varchar2(300)';
  END IF;  

   SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('KPI_LV2');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY KPI_LV2 varchar2(300)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add KPI_LV2 varchar2(300)';
  END IF; 
  	 
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('KPI_LV3');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY KPI_LV3 varchar2(300)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add KPI_LV3 varchar2(300)';
  END IF;  	
  
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('FINDEX');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY FINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add FINDEX varchar2(300)';
  END IF;  	 		
  	  
  	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('SINDEX');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY SINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add SINDEX varchar2(300)';
  END IF;  
  
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('TINDEX');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY TINDEX varchar2(300)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add TINDEX varchar2(300)';
  END IF;  
	
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('KPI_VAL');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY KPI_VAL varchar2(1000)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add KPI_VAL varchar2(1000)';
  END IF; 
  
	SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('INDEXVAL');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY INDEXVAL varchar2(1000)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add INDEXVAL varchar2(1000)';
  END IF;  	
  
    SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('TARGETVALUE');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY TARGETVALUE varchar2(1000)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add TARGETVALUE varchar2(1000)';
  END IF;  
  
SELECT COUNT(1) INTO num from user_tab_cols where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('AGENCY_CODE');
   IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY AGENCY_CODE varchar2(21)';
  ELSE 
 execute immediate 'alter table PERF_T_ADJUSTINDEX add AGENCY_CODE varchar2(21)';
  END IF; 
  
   SELECT COUNT(1)  INTO num from user_tab_cols  where table_name = upper('PERF_T_ADJUSTINDEX') and column_name = upper('BUSI_TYPE_CODE');
        IF num > 0 THEN execute immediate 'alter table PERF_T_ADJUSTINDEX MODIFY BUSI_TYPE_CODE varchar2(6)';
				ELSE
				execute immediate 'alter table PERF_T_ADJUSTINDEX add BUSI_TYPE_CODE varchar2(6)';
				END IF;  
				
	 SELECT COUNT(1)  INTO num from user_tab_cols  where table_name = upper('PM_PERF_INDICATOR') and column_name = upper('BUSI_TYPE_CODE');	
	   IF num > 0 THEN execute immediate 'UPDATE PM_PERF_INDICATOR SET BUSI_TYPE_CODE = CASE WHEN YEARFLAG = 1 THEN 1 ELSE 2 END';  
		END IF; 
