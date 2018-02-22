create or replace procedure two_v2(dvsid in device.deviceid%type,
  money in payfee.paymoney%type,
  res out varchar2) is
  pay_id payfee.id%type;
  bkcode payfee.bankcode%type;
  serial payfee.bankserial%type;
  
  not_found_exception exception;
  
  cursor cur_d is
  select * from device where deviceid=dvsid;
  dvs cur_d%rowtype;
  
begin
  open cur_d;
  --fetch...
  --while cur_d%found loop
  loop
    fetch cur_d into dvs;
    exit when cur_d%notfound;
    dbms_output.put_line('�豸��ţ�'||dvs.deviceid);
    dbms_output.put_line('�豸������'||dvs.clientid);
    dbms_output.put_line('�豸���ͣ�'||dvs.type);
    dbms_output.put_line('�豸��'||dvs.balance);
  end loop;
  close cur_d;
  
  if dvs.deviceid is null then
    dbms_output.put_line(dvsid||'_'||dvs.deviceid);
    raise not_found_exception;
  end if;
  
  
  select max(id)+1 into pay_id from payfee;
  if pay_id is null then 
    pay_id:=1;
  end if;
  
  --select distinct bankcode into bkcode from payfee 
  --  where deviceid=dvsid and rownum<2 order by id desc;
  if bkcode is null then
    select bank.code into bkcode from bank where bank.name='��������';
  end if;
  
  serial:='ZS'||to_char(sysdate,'yyyymmdd')||lpad(to_char(pay_id),'6','0');
  
  update device set balance=balance+to_number(money) where deviceid=dvsid;
  
  insert into bankrecord values(pay_id,money,bkcode,serial);
  
  insert into payfee values(pay_id,dvsid,money,sysdate,bkcode,'2001',serial);
  dbms_output.put_line('�ɷ���Ϣ:'||pay_id||'_'||dvsid||'_'||money||'_'||sysdate||'_'
    ||bkcode||'_'||'2001'||'_'||serial);
    
    
  open cur_d;
  loop
    fetch cur_d into dvs;
    exit when cur_d%notfound;
    dbms_output.put_line('�豸��ţ�'||dvs.deviceid);
    dbms_output.put_line('�豸������'||dvs.clientid);
    dbms_output.put_line('�豸���ͣ�'||dvs.type);
    dbms_output.put_line('�豸��'||dvs.balance);
  end loop;
  close cur_d;
  res:='�ɹ�';
  commit;
exception
  when not_found_exception then
    dbms_output.put_line('������󣬱���豸������');
  res:='ʧ��';
end two_v2;
/
