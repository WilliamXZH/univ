package pers.william.database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import pers.william.service.OrderContainer;
import pers.william.service.OrderItem;
import pers.william.utils.NumOper;
import pers.william.utils.RSOper;

public class ServiceOper {

	private static Statement stmt=MySQLDB.getStmt();
	
	public static String getState(String user){
		int state[]=new int[5];		
		String sql="select * from orderitem where order_user=\""+user+"\";";
		for(int i=0;i<5;i++)state[i]=0;
		
		try{
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				int flag=rs.getInt(2);
				if(flag>0&&flag<=5){
					state[flag-1]++;
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return "states#"+state[0]+"_"+state[1]+"_"+state[2]+"_"+state[3]+"_"+state[4];
	}
	
	public static String queryOrder(String user,String minstate,String maxstate){
		
		OrderContainer ois=new OrderContainer();
		String sql="select * from orderitem where order_user=\""+user+"\";";
		try{
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				int state=rs.getInt(2);
				if(state>=Integer.parseInt(minstate)&&state<=Integer.parseInt(maxstate)){
					String tmp=rs.getInt(1)+"_"+rs.getInt(2)+"_"+rs.getDouble(3)+"_"+
							rs.getString(4)+"_"+rs.getString(5)+"_"+rs.getString(6)+
							"_"+rs.getString(7)+"_"+rs.getInt(8);
					ois.addOrder(tmp);
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		if(ois.size()==0){			
			return "NoOrders#";
		}else{
			return "Orders#"+ois.toString();
		}
	}
	
	public static String addOrder(String order){
		int id;
		String querysql="select * from orderitem";
		
		OrderItem oi=new OrderItem(order);
		try {
			while(true){
				int tem=0;
				ResultSet rs;
				rs = stmt.executeQuery(querysql);
				id=NumOper.getRandomId();
				while(rs.next()){
					if(rs.getInt(1)!=id){
						tem++;
					}else{
						break;
					}
				}					
				if(tem>=RSOper.getSize(stmt.executeQuery(querysql))){
					break;
				}
			}	
		String updatesql="insert into orderitem value ("+id+","+oi.getFlag()+
				","+oi.getCost()+",\""+oi.getCompany()+
				"\",\""+oi.getUser()+"\",\""+oi.getServiceType()
				+"\",\""+oi.getMesaage()+"\","+oi.getIsCryp()+");";
		System.out.println("insert order:"+updatesql);
			return "succeed:"+stmt.execute(updatesql);			
		} catch (SQLException e) {
			System.out.println("Some exception occured.");
			e.printStackTrace();
		}
		return "failed";
	}
}
