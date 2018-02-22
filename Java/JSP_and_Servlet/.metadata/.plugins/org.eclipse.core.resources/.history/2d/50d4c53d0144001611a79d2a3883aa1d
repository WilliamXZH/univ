package MysqlManner;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;
import java.util.Vector;

import book_user.BookMenu;

public class MannerBookMenu {
	public MannerBookMenu(){
		String sql;
		Connection conn =Link.getConn();
		String bookname;
		sql="select * from appointment";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				Date x=new Date();
				java.sql.Date Today=new java.sql.Date(x.getTime());
				java.sql.Date BeforeDate=rs.getDate(5);
				if (BeforeDate.compareTo(Today)<0) {
					bookname=rs.getString(2);
					sql = "delete from appointment where BookID="+rs.getInt(1)+" and User='"+rs.getString(3)+"'";  
				    try  
				    {  
				        stmt = conn.createStatement();  
				        stmt.executeUpdate(sql);  
				    }  
				    catch (SQLException e)  
				    {  
				        e.printStackTrace();  
				    }
				    returnBook(Search(bookname));
				}
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	public BookMenu Search(String book_name){
		BookMenu bookMenu=null;
		Connection conn =Link.getConn();
		String sql="select * from book_menu";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getString(2).equals(book_name)) {
					bookMenu=new BookMenu(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6),rs.getString(7));
					bookMenu.setPicture(rs.getInt(8));
					break;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bookMenu;
		
	}
	public Vector<BookMenu> SSearch(String book_name){
		BookMenu bookMenu=null;
		Connection conn =Link.getConn();
		Vector<BookMenu> vector=new Vector<BookMenu>();
		String sql="select * from book_menu WHERE Name LIKE '%"+book_name+"%'";
		try {
			
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
					bookMenu=new BookMenu(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6),rs.getString(7));
					bookMenu.setPicture(rs.getInt(8));
					vector.add(bookMenu);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return vector;
		
	}
	
	public boolean deleteBook(BookMenu bMenu) {//从仓库减掉某一种书籍
		Connection conn =Link.getConn();
		String sql="update book_menu set Lefte=?,Lende=? where BookID="+bMenu.getId();
		try {
			PreparedStatement preparedStatement=conn.prepareStatement(sql);
			bMenu.setLeft(bMenu.getLeft()-1);
			bMenu.setLend(bMenu.getLend()+1);
			preparedStatement.setInt(1,bMenu.getLeft());
			preparedStatement.setInt(2,bMenu.getLend());
			if (preparedStatement.executeUpdate()!=0) {
				return true;
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
		
	}
	public BookMenu borrowBook(int BookID){
		BookMenu bookMenu=null;
		Connection conn =Link.getConn();
		String sql="select * from book_menu";
		try {
			Statement stmt = conn.createStatement();
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getInt(1)==BookID) {
					bookMenu=new BookMenu(rs.getInt(1), rs.getString(2), rs.getInt(3), rs.getInt(4), rs.getInt(5), rs.getString(6),rs.getString(7));
					break;
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return bookMenu;
		
		
		
		
		
	}
	
	
	public boolean returnBook(BookMenu bMenu) {//还书
		Connection conn =Link.getConn();
		String sql="update book_menu set Lefte=?,Lende=? where BookID="+bMenu.getId();
		try {
			PreparedStatement preparedStatement=conn.prepareStatement(sql);
			bMenu.setLeft(bMenu.getLeft()+1);
			bMenu.setLend(bMenu.getLend()-1);
			preparedStatement.setInt(1,bMenu.getLeft());
			preparedStatement.setInt(2,bMenu.getLend());
			if (preparedStatement.executeUpdate()!=0) {
				return true;
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}
	
	
	
	
	
}




