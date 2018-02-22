package connector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;

//import com.mysql.jdbc.Statement;

public class MyConn {
	private final String drive="com.microsoft.sqlserver.jdbc.SQLServerDriver";
	private final String url="jdbc:sqlserver://localhost:3306;DatabaseName=";
	private final String userName="";
	private final String userPassword="";
	Connection con=null;
	Statement stmt=null;
	
	public boolean creatConnection(){
		try{
			Class.forName(drive);
			con=DriverManager.getConnection(url,userName,userPassword);
			return true;
		}catch(Exception e){
			System.out.println("数据库连接失败:"+e.toString());
			return false;
		}
	}
}
