package pers.william.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import pers.william.users.Member;
import pers.william.users.User;
import pers.william.utils.NumOper;
import pers.william.utils.RSOper;

public class UserOper {

	public static int USER_ADMIN=1;
	public static int USER_COMP=2;
	public static int USER_MEMB=3;
	public static int USER_VISIT=4;
	private static Connection conn=MySQLDB.getConn();
	
	public static String login(String name,String pwd){
		String sql="select * from user;";
		try{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			
			while(rs.next()){
				if(name.equals(
						rs.getString(3))&&pwd.equals(rs.getString(4))){
					
					/* To be removed. */
					ResultSet rs2=stmt.executeQuery("select * from user where name="+name);
					String info=rs2.getInt(1)+"_"+rs.getInt(2)+"_"
							+rs2.getString(3)+"_"+rs2.getString(4);
					
					return "succeed#"+info;
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		return "failed#name or password is error";
	}
	public static int getType(String name){
		String sql="select * from user where user_name="+name+";";
		try{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			
			while(rs.next()){
				if(name.equals(rs.getString(3))){
					return rs.getInt(2);
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}	
		return -1;
		
	}
	public static boolean testName(String name){
		String sql="select * from user;";
		try{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			
			while(rs.next()){
				if(name.equals(rs.getString(3))){
					return false;
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
			return false;
		}		
		return false;
	}
	public static String register(String regist){
		User user=new Member(regist.split("_")[0],regist.split("_")[1]
				,regist.split("_")[2],regist.split("_")[4]);
		
		if(testName(regist.split("_")[0])){
			addUser(user);
			return "succeed#"+regist;
		}
		return "failed#";		
	}
	
	public static boolean addUser(User user){
		int id;
		String sql="select * from user;";
		
		try{
			Statement stmt=conn.createStatement();
			ResultSet rs=stmt.executeQuery(sql);
			
			while(true){
				int tem=0;
				id=NumOper.getRandomId();
				
				while(rs.next()){
					if(rs.getInt(1)!=id){
						tem++;
					}else{
						break;
					}
				}
				if(tem>=RSOper.getSize(stmt.executeQuery(sql))){
					user.setId(id);
					break;
				}
			}
			
			String sql_tem="insert into user value("+id+","+user.getType()
			+",\""+user.getName()+"\",\""+user.getPassword()+"\");";
			
			/* modify to different user */
			if(USER_MEMB==user.getType()){
				addMember((Member)user);
			}
			
			return stmt.execute(sql_tem);
		}catch(SQLException e){
			e.printStackTrace();
		}
		return false;
	}
	public static void addMember(Member mem){
		
	}
	
	public boolean removeUser(int id){
		//String sql="select * from user;";
		
		try{
			Statement stmt=conn.createStatement();
			
			return stmt.execute("delete from user where user_id="+id+";");
			//ResultSet rs=stmt.executeQuery(sql);
			
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		return false;
	}
}
