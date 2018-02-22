package pers.william.database;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class NewsOper {

	private static Statement stmt=MySQLDB.getStmt();
	
	public static String getNews(String keyword){
		String news="";
		
		String sql="select * from news;";
		
		try{
			ResultSet rs=stmt.executeQuery(sql);
			
			while(rs.next()){
				if(rs.getString(2).contains(keyword)||rs.getString(4).contains(keyword)){
					news+="#"+rs.getInt(1)+"_"+rs.getString(2)+"_"
				+rs.getString(3)+"_"+rs.getString(4)+"_"+rs.getInt(5)+"_"+rs.getInt(6)
				+"_"+rs.getInt(7)+"_"+rs.getInt(8);
				}
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		
		if("".equals(news))news="NoResult";
		else news="Result"+news;
		return news;
	}
	public static String getComments(int id){
		String comments="";
		
		String sql="select * from comments where news_id="+id+";";
		try{
			ResultSet rs=stmt.executeQuery(sql);
			while(rs.next()){
				comments+="#"+rs.getInt(1)+"_"+rs.getInt(2)+"_"
			+rs.getInt(3)+"_"+rs.getString(4);
			}
		}catch(SQLException e){
			e.printStackTrace();
		}
		if("".equals(comments)) comments="NoComment#√ª”–∆¿¬€”¥~";
		else comments="Comments"+comments;
		return comments;
	}
	
}
