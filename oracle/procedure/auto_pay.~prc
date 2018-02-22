create or replace procedure auto_pay(device_id device.deviceid%type) is

  main_fee receivables.basicfee%type;
  to_payfee receivables.basicfee%type;
  days_count number;
  last_days number;
  
  cursor cur_d is
    select * from device natural join receivables 
    where deviceid=device_id and flag='0' order by yearmonth;
  dr cur_d%rowtype;
  
  no_device_exception exception;
begin
  
  select balance into main_fee from device where deviceid=device_id;
  open cur_d;
  
  if main_fee is null then
    raise no_device_exception;
  end if;
  
  
  dbms_output.put_line('设备余额'||main_fee);
  --while cur_d%found loop
  loop
    exit when cur_d%notfound;
    fetch cur_d into dr;
    
    days_count:=to_number(sysdate-to_date(dr.yearmonth,'yyyymm'));
    if trunc(sysdate,'year')>to_date(dr.yearmonth,'yyyymm') then
      last_days:=trunc(sysdate,'year')-to_date(dr.yearmonth,'yyyymm');
    else 
      last_days:=365;
    end if;

    dbms_output.put_line(days_count);
    
    if dr.type='01' then 
      to_payfee:=dr.basicfee*1.18+dr.basicfee*0.001*days_count;
    else 
      to_payfee:=dr.basicfee*1.23;
      if days_count<last_days then
        to_payfee:=to_payfee+dr.basicfee*0.002*days_count;
      else
        to_payfee:=to_payfee+dr.basicfee*0.003*(days_count-last_days)+
          dr.basicfee*0.002*last_days;
      end if;
    end if;
    
    if main_fee<to_payfee then
      dbms_output.put_line('金额不足：'||
      dr.yearmonth||'  '||to_payfee||'  '||main_fee);
      exit;
    else    
      main_fee:=main_fee-to_payfee;
      dbms_output.put_line('缴费成功：'||
        dr.yearmonth||'  '||to_payfee||'  '||main_fee);
      update receivables set flag=1 
        where deviceid=device_id and yearmonth=dr.yearmonth;
    end if;
  end loop;
  close cur_d;
   
  update device set balance=main_fee where deviceid=device_id;
  commit;
  dbms_output.put_line('还剩'||main_fee||'元已存到设备余额里');
exception
  when no_device_exception then
    dbms_output.put_line('无此设备编号');

end auto_pay;
/
