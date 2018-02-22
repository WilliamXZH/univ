create or replace procedure five(code in bank.code%type,
  check_date in payfee.paydate%type) is
  max_id check_exception.id%type:=1;
  excep check_exception.exceptiontype%type;
  
  cursor cur_pb is
    select payfee.paymoney pm,payfee.bankserial pbs,
      bankrecord.payfee pf,bankrecord.bankserial bbs 
      from payfee full join bankrecord on payfee.id=bankrecord.id
     where payfee.bankcode=code and to_char(payfee.paydate)=to_char(check_date) order by payfee.id;
  pb cur_pb%rowtype;

begin
  select max(id) into max_id from check_exception;
  open cur_pb;
  
  if max_id is null then
    max_id:=0;
  end if;
  
  
  --dbms_output.put_line('�����쳣����ʼ�Բ���ϸ��'||cur_pb%rowcount);
  --while cur_pb%found loop
  loop 
   fetch cur_pb into pb;
   exit when cur_pb%notfound;
    
    max_id:=max_id+1;
    dbms_output.put_line(max_id||'_'||cur_pb%rowcount);
    if pb.pbs is null then
      excep:='ENS';--enterprise no serial
      insert into check_exception values(max_id,check_date,code,
      pb.bbs,code,pb.pf,excep);
    elsif pb.bbs is null then
      excep:='BNS';--bank no serial
      insert into check_exception values(max_id,check_date,code,
      pb.pbs,code,pb.pm,excep);
    elsif pb.pbs<>pb.bbs then
      excep:='NES';--not equal serial
      insert into check_exception values(max_id,check_date,code,
      pb.pbs,code,pb.pm,excep);
    elsif pb.pm<>pb.pf then
      excep:='NEP';--not equal payfee
      insert into check_exception values(max_id,check_date,code,
      pb.pbs,code,pb.pm,excep);
    else
      max_id:=max_id-1;
      excep:='NFE';--not found exception
    end if;
    
    dbms_output.put_line('�쳣�Բ�:'||max_id||'  '||check_date||'  '||code||'  '||
    pb.pm||'  '||pb.pbs||'  '||pb.pf||'  '||pb.bbs||'  '||excep);
    
  end loop;
  
  if pb.pm is null then
    dbms_output.put_line('���ڻ����д���');
  end if;
  
  commit;
end five;
/
