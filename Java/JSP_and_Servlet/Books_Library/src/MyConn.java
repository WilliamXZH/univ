import java.sql.*;
public class MyConn {
	private final String driver="com.mysql.jdbc.Driver";
	private final String url="jdbc:mysql://localhost:3306/test";
	private final String userName="root";
	private final String userPassword="123456";
	Connection con=null;
	Statement stmt=null;
	public boolean creatConnection(){
		try{
			Class.forName(driver);
			con=DriverManager.getConnection(url, userName,userPassword);
			stmt=con.createStatement();
			return true;
		}catch(Exception e){
			System.out.println("数据库连接失败:"+e.toString());
			e.getStackTrace();
			return false;
		}
	}
	public static void main(String[] args){
		MyConn mycon=new MyConn();
		System.out.println(mycon.creatConnection());
		System.out.println("aslqjwlenz");
	}
}
