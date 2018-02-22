create or replace procedure five_v2(bk_code bank.code%type,
  check_date check_exception.checkdate%type) is
  
  cursor cur_r is 
    select * from bankrecord where bankcode=bk_code;
  rc cur_r%rowtype;
  
  cursor cur_p is
    select * from payfee where bankcode=bk_code and 
      to_char(payfee.paydate)=to_char(check_date);
  pf cur_p%rowtype;
begin
  open cur_r;
  
  loop
    fetch cur_r into rc;
    exit when cur_r%notfound;
    
    open cur_p;
  
  end loop;  

end five_v2;
/
