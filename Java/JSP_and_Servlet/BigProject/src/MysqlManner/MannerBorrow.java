package MysqlManner;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Vector;
import book_user.Borrow;

public class MannerBorrow {
	public int addBorrow(Borrow borrow){//添加一条借书记录到数据库中
		Connection connection=Link.getConn();
		String sql;
		sql="select * from borrow";
		try {
			Statement stmt = connection.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getString(3).equals(borrow.getUser())&&rs.getInt(1)==borrow.getBookId()) {
					return 1;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		sql = "insert into borrow(BookID,BookName,UserName,BorrowDate,ReturnDate) values(?,?,?,?,?)";
		try {
		PreparedStatement pStatement=connection.prepareStatement(sql);
		pStatement.setInt(1, borrow.getBookId());
		pStatement.setString(2, borrow.getName());
		pStatement.setString(3, borrow.getUser());
		pStatement.setDate(4, borrow.getBorrowDate());
		pStatement.setDate(5, borrow.getReturnDate());
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
	
	
	public int deleteBorrow(String user,int bookID){
		String sql = "delete from borrow where BookID="+bookID+" and UserName='"+user+"'";  
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
	
	
	public Vector<Borrow> findBorrow(String user){
		Vector<Borrow> vector=new Vector<Borrow>();
		Borrow borrow=null;
		Connection conn =Link.getConn();
		String sql="select * from borrow";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getString(3).equals(user)) {
					borrow=new Borrow(rs.getInt(1), rs.getString(2), rs.getString(3),rs.getDate(4),rs.getDate(5));
					vector.add(borrow);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vector;
		
	}
	
}
