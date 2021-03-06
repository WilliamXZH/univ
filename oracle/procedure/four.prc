create or replace procedure four(bank_code in bank.code%type,
count_id number,money_total number,date_check date) is

  max_id checkresult.id%type:=1;
  type record_check is record
  (
    num_id number,
    total number(8,2)
  );
  check_result record_check;
begin
  select count(id),sum(paymoney) into check_result from payfee 
    where to_char(paydate)=to_char(date_check-1) and bankcode=bank_code;  
  if check_result.num_id=count_id and check_result.total=money_total then
    dbms_output.put_line('对账正常');
  else
    dbms_output.put_line('对账异常');
    five(bank_code,date_check-1);
  end if;
  
  select (max(id)+1) into max_id from checkresult;
  if max_id is null then
    max_id:=1;
  end if;
  
  dbms_output.put_line('对账结果:'||max_id||'  '||date_check||'  '||bank_code||
  '  '||check_result.num_id||'  '||check_result.total||'  '||
  count_id||'  '||money_total);
  insert into checkresult values(max_id,date_check,bank_code,
    check_result.num_id,check_result.total,count_id,money_total);
  commit;
exception
  when no_data_found then
    dbms_output.put_line('无数据');    

end four;
/
