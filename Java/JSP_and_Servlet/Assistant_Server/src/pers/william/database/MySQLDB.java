package pers.william.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class MySQLDB {
		private static Connection conn=null;
		private static Statement stmt=null;
		
		private static String dbDriver="com.mysql.jdbc.Driver";   
	    private static String url="jdbc:mysql://localhost:3306/assistant?"
		+"user=root&password=123456&useSSL=false&useUnicode=false&characterEncoding=UTF8";
		
	    public static Connection getConn() {
			if(conn==null){
				synchronized(MySQLDB.class){
					if(conn==null){
						try {
							Class.forName(dbDriver);
							conn=DriverManager.getConnection(url);
							System.out.println("Connect database successful!");
						} catch (SQLException e) {
							e.printStackTrace();
						}catch (ClassNotFoundException e) {
							e.printStackTrace();
						}catch(Exception e){
							e.printStackTrace();
						}
					}
				}
			}
			return conn;
		}
	    public static Statement getStmt() {
			if(conn==null){
				synchronized(MySQLDB.class){
					if(conn==null){
						try {
							stmt=getConn().createStatement();
							System.out.println("Create Statement successful!");
						} catch (SQLException e) {
							e.printStackTrace();
						}catch(Exception e){
							e.printStackTrace();
						}
					}
				}
			}
			return stmt;
		}

}
