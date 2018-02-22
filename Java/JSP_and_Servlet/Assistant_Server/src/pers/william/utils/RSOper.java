package pers.william.utils;


import java.sql.ResultSet;
import java.sql.SQLException;

public class RSOper {
	public static int getSize(ResultSet rs){
		int tem=0;
		try {
			while(rs.next()){
				tem++;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return tem;
	}
}
