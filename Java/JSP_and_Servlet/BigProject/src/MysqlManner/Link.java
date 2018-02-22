package MysqlManner;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class Link {
	private static String dbDriver="com.mysql.jdbc.Driver";   
    private static String url="jdbc:mysql://localhost:3306/library?"+"user=root&password=lsr521&useSSL=false&useUnicode=false&characterEncoding=UTF8";
	public static Connection getConn() {
		Connection conn=null;
		try {
			Class.forName(dbDriver);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		
		try {
			conn=DriverManager.getConnection(url);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conn;
		
		
	}
	
}
