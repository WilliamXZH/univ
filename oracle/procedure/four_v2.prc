create or replace procedure four_v2(bk_code in bank.code%type,
  bk_count checkresult.banktotalcount%type,
  bk_total checkresult.banktotalmoney%type,
  ck_date checkresult.checkdate%type) is
  
  ck_id checkresult.id%type;
  
  ep_count checkresult.ourtotalcount%type;
  ep_total checkresult.ourtotalmoney%type;
  
  /*cursor cur_p is
    select * from payfee 
      where to_char(paydate)=to_char(ck_date) and bankcode=bk_code;
  pf cur_p%rowtype;*/
  
  cursor cur_d is
    select * from device where
    deviceid in (select deviceid from payfee 
    where to_char(payfee.paydate)=to_char(ck_date) and bankcode=bk_code);
  dvs cur_d%rowtype;
    
  
begin
  select count(id),sum(to_number(paymoney)) into ep_count,ep_total
    from payfee where bankcode=bk_code and to_char(paydate)=to_char(ck_date);  
  
  if ep_count=bk_count and ep_total=bk_total then
    dbms_output.put_line('对账正常');
  else
    dbms_output.put_line('对账异常，准备对查明细：');
    five(bk_code,ck_date);
  end if;
  
  open cur_d;
  loop
    fetch cur_d into dvs;
    exit when cur_d%notfound;
    
    dbms_output.put_line('----------------------------------------');
    auto_pay(dvs.deviceid);
    dbms_output.put_line('----------------------------------------');
    --cursor cur_r is
    --  select * from receivables where deviceid=dvs.deviceid and flag='0' ;
  
  end loop;

  select max(id)+1 into ck_id from checkresult;
  if ck_id is null then
    ck_id:=1;
  end if;
  
    dbms_output.put_line('对账结果:'||ck_id||'  '||ck_date||'  '||bk_code||
  '  '||bk_count||'  '||bk_total||'  '||
  ep_count||'  '||ep_total);
  insert into checkresult values(ck_id,ck_date,bk_code,
    bk_count,bk_total,ep_count,ep_total);
  commit;
--exception
  
end four_v2;
/
