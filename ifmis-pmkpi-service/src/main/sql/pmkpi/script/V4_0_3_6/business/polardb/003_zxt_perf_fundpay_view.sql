
CREATE OR REPLACE PACKAGE bgt_330000.perf_fundpay_view
IS
    v_procode  varchar2(40);
    v_agencyguid varchar2(40);
    v_month number(2);
  FUNCTION set_procode(procodes character varying) RETURN character varying;
  FUNCTION get_procode() RETURN character varying;
  FUNCTION set_agencyguid(agencyguids character varying) RETURN character varying;
  FUNCTION get_agencyguid() RETURN character varying;
  FUNCTION set_month(months character varying) RETURN character varying;
  FUNCTION get_month() RETURN character varying;
  
END perf_fundpay_view;

CREATE OR REPLACE PACKAGE BODY bgt_330000.perf_fundpay_view
IS
    /*v_procode character varying(40);
    v_agencyguid character varying(40);
    v_month numeric(2,0);*/
  FUNCTION set_procode(procodes character varying) RETURN character varying IS
    begin
      v_procode := procodes;
      return v_procode;
    end;
  FUNCTION get_procode() RETURN character varying IS
    begin
       return v_procode;
      end;
  FUNCTION set_agencyguid(agencyguids character varying) RETURN character varying IS
    begin
      v_agencyguid := agencyguids;
      return v_agencyguid;
    end;
  FUNCTION get_agencyguid() RETURN character varying IS
    begin
       return v_agencyguid;
      end;
  FUNCTION set_month(months character varying) RETURN character varying IS
    begin
      v_month := months;
      return v_month;
    end;
  FUNCTION get_month() RETURN character varying IS
    begin
       return v_month;
      end;

END perf_fundpay_view;




