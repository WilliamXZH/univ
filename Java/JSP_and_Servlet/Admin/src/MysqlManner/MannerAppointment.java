package MysqlManner;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import book_user.Appointment;
public class MannerAppointment {
	public MannerAppointment(){
		
	}
	public int addAppointment(Appointment appointment){//添加一条预约到数据库中
		Connection connection=Link.getConn();
		String sql;
		sql="select * from appointment";
		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getString(3).equals(appointment.getUser())&&rs.getInt(1)==appointment.getId()) {
					return 1;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		sql="select * from borrow";
		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getString(3).equals(appointment.getUser())&&rs.getInt(1)==appointment.getId()) {
					return 2;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		sql = "insert into appointment(BookID,BookName,User,AppointmentDate,BeforeDate) values(?,?,?,?,?)";
		try {
		PreparedStatement pStatement=connection.prepareStatement(sql);
		pStatement.setInt(1, appointment.getId());
		pStatement.setString(2, appointment.getName());
		pStatement.setString(3, appointment.getUser());
		pStatement.setDate(4, appointment.getAppointmentDate());
		pStatement.setDate(5, appointment.getBeforeDate());
		if (pStatement.executeUpdate()==1) {
			return 3;
		}
		return 1;

		
	} catch (SQLException e) {
		e.printStackTrace();
	}
	System.out.println("3");
	return 1;
	}
	
	
	public int deleteAppointment(String user,int bookID){
		String sql = "delete from appointment where BookID="+bookID+" and User='"+user+"'";  
	    int i=0;  
	    Connection conn = Link.getConn();  
	    try  
	    {  
	        Statement stmt = conn.createStatement();  
	        i = stmt.executeUpdate(sql);  
	    }  
	    catch (SQLException e)  
	    {  
	        e.printStackTrace();  
	    }  
	    return i; 
	}
	
	
	public Vector<Appointment> findAppointment(String user){
		Vector<Appointment> vector=new Vector<Appointment>();
		Appointment appointment2=null;
		Connection conn =Link.getConn();
		String sql="select * from appointment";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getString(3).equals(user)) {
					appointment2=new Appointment(rs.getInt(1), rs.getString(2), rs.getString(3),rs.getDate(4),rs.getDate(5));
					vector.add(appointment2);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vector;
		
	}
	
	

	
}
