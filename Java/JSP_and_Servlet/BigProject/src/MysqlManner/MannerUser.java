package MysqlManner;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


public class MannerUser{

	public int login(String name,String password){
		boolean b=true;
		int a = 0;
		Connection conn = null;
		String sql;
		try {
			conn = Link.getConn();
			Statement stmt = conn.createStatement();
			sql = "select * from user";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getString(1).equals(name)) {
					if (rs.getString(2).equals(password)) {
						System.out.println(name+"：登陆成功");
						System.out.println("1");
						b=false;
						a= 1;
					}
					else {
						System.out.println(name+"：密码错误");
						System.out.println("2");
						b=false;
						a= 2;
					}
				}
			}
			if (b) {
				System.out.println(name+"用户不存在");
				System.out.println("3");
				a= 3;

			}
			} catch (SQLException e) {
			System.out.println("MySQL操作错误");
			e.printStackTrace();
			} catch (Exception e) {
			e.printStackTrace();
			}finally {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		return a;		
	}
	
	public int Regist(String name,String password) {
		Connection conn=Link.getConn();
		boolean b=true;
		int i=0;
		String sql;
		try {
			Statement stmt = conn.createStatement();
			sql = "select * from User";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getString(1).equals(name)) {
					
					b=false;
					break;
				}
			}
			if (b) {
				sql = "insert into user(UserName,UserPassword) values('"+name+"','"+password+"')";
				stmt.executeUpdate(sql);
				i=1;
				
			}
			else{
				i =2;
			}
			} catch (Exception e) {
			e.printStackTrace();
			}finally {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}	
		
		return i;
		
	}

	
}
