package pers.william.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class OracleDB{
	
	public Connection getConn(){

		String driverName="oracle.jdbc.driver.OracleDriver";
		//String url="jdbc:oracle:thin:@localhost:1521:XE";
		String url="jdbc:oracle:thin:@localhost:49768:XE";
		
		String user="sys as sysdba";
		String password="123456";
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		Connection conn=null;
		
		try{
			Class.forName(driverName);
			conn=DriverManager.getConnection(url,user,password);
			System.out.println(conn);
			System.out.println(conn.isReadOnly());
			System.out.println(conn.isClosed());
			
			return conn;
//			String sql="select username from dba_users;";
//			
//			pstmt=conn.prepareStatement(sql);
//			pstmt.setString(1,"root");
//			rs=pstmt.executeQuery();
//			
//			if(rs.next()){
//				System.out.println("查询到名为【"+rs.getString("username")+
//						"】的信息，其密码为："+rs.getString("password"));
//			}else{
//				System.out.println("未查询到用户名为【"+rs.getString("user_id")+"】的信息");
//			}
			
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e){
			e.printStackTrace();
		}finally{
			try{
				if(rs!=null){
					rs.close();
				}
				if(pstmt!=null){
					pstmt.close();
				}
				if(conn!=null){
					conn.close();
				}
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		return null;
	}
}
