create or replace procedure three(device_id device.deviceid%type,
money receivables.basicfee%type,serial payfee.bankserial%type) is
  null_exception exception;
  max_id payfee.id%type:=1;
  new_serial payfee.bankserial%type;
  total receivables.basicfee%type:=money;
  
  payfee_rec payfee%rowtype;
  
  cursor cur_r is
  select * from device natural join receivables 
    where deviceid=device_id order by yearmonth desc;
  dr cur_r%rowtype;
begin
  
  select max(id)+1 into max_id from payfee;
  select * into payfee_rec from payfee where bankserial=serial;
  if payfee_rec.id is null or payfee_rec.paymoney<>money then
    raise null_exception;
  end if;
  
  dbms_output.put_line('----------------------------------------');
  dbms_output.put_line('ԭ��ˮ����Ϣ��');
  dbms_output.put_line('��ˮ���'||payfee_rec.id);
  dbms_output.put_line('�豸���'||payfee_rec.deviceid);
  dbms_output.put_line('�ɷѽ��'||payfee_rec.paymoney);  
  dbms_output.put_line('�ɷ�����'||payfee_rec.paydate);
  dbms_output.put_line('���д���'||payfee_rec.bankcode);
  dbms_output.put_line('�ɷ�����'||payfee_rec.type);
  dbms_output.put_line('������ˮ'||payfee_rec.bankserial);
  dbms_output.put_line('----------------------------------------');
  
  open cur_r;
  while cur_r %found loop
    fetch cur_r into dr;
    
    if total>0 then
      if dr.type='01' then 
        total:=total-dr.basicfee*1.18;
      else total:=total-dr.basicfee*1.23;
      end if;
    else exit;
    end if;
    
    update receivables set flag=0 where yearmonth=dr.yearmonth and deviceid=dr.deviceid;
    
  end loop;
  close cur_r;
  
  max_id:=max_id+1;
  dbms_output.put_line(max_id);
  new_serial:= 'ZS'||to_char(sysdate,'yyyymmdd')||'00'||to_char(max_id+1);   
  --dbms_output.put_line(serial);   
  
  insert into payfee values (max_id,
  device_id,
  to_char(-money,'9999.99')
  ,sysdate,'90','2002', new_serial);
  
  update device set balance=balance-total where clientid=dr.deviceid;
  
  dbms_output.put_line('�����ɹ�');
  commit;
exception
  --when null_exception then
  when no_data_found then
    dbms_output.put_line('����ʧ��:����ˮ��Ϣ�����ڣ�');
  
end three;
/
