create or replace procedure one(client_id in client.id%type) is
--declare
       --client_id client.id%type:=55;
       total_fee receivables.basicfee%type:=0;
       cursor cur_c is
       select * from client where id=client_id;
       cl cur_c%rowtype;
       
       cursor cur_d is
       select * from device natural join receivables where device.clientid=client_id;
       dr cur_d%rowtype;
begin
      dbms_output.put_line('---------------------------------------');
      open cur_c;  
      loop
        fetch cur_c into cl;
        exit when(cur_c%notfound);
        dbms_output.put_line('用户ID'||cl.id); 
        dbms_output.put_line('用户姓名'||cl.name);
        dbms_output.put_line('用户地址'||cl.address);
        dbms_output.put_line('----------------------------------------');
      end loop;
      close cur_c;
      
      if(cl.id is null)then
        dbms_output.put_line('输入错误！！请重新输入');
      else
        dbms_output.put_line('正在查询，请稍后...');     
        dbms_output.put_line('----------------------------------------');
      end if;
      
      open cur_d;
      loop
        fetch cur_d into dr;
        exit when(cur_d%notfound);
        dbms_output.put_line('设备ID：'||dr.deviceid);
        dbms_output.put_line('设备类型：'||dr.type);
        dbms_output.put_line('基本费用：'||dr.basicfee);
        dbms_output.put_line('是否欠费：'||dr.flag);
        dbms_output.put_line('欠费日期：'||dr.yearmonth);
        
        if(dr.type=01)then
          if(dr.flag=0)then total_fee:=total_fee+dr.basicfee*1.18;
          end if;
        else
          if(dr.flag=0)then total_fee:=total_fee+dr.basicfee*1.23;
          end if;
        end if;
        dbms_output.put_line('----------------------------------------');
      end loop;
      close cur_d;
      
      dbms_output.put_line('总费用为：'||total_fee);
      dbms_output.put_line('----------------------------------------');
end one;
/
