package com.freshO2O.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;
/*
 * 
 *数据库连接方式
 * 
 */
public class DBUtil {
	private static String DRIVER="com.mysql.jdbc.Driver";
	private static String URL="jdbc:mysql://localhost:3306/guiMei";
	private static String USER="root";
	private static String PWD="admin";
	private static Connection conn=null;
	private static PreparedStatement ps=null;
	private static ResultSet res=null;
	
	public static void getconn(){
		try {
			Class.forName(DRIVER);
			conn=DriverManager.getConnection(URL,USER,PWD);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public static int Update(String sql,Object obj[]){
		int k=0;
		getconn();
		try {
			ps=conn.prepareStatement(sql);
			
			if(obj!=null){
				for(int i=0;i<obj.length;i++){
					ps.setObject(i+1, obj[i]);
				}
			}
			k=ps.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally{
			close();
		}
		return k;
	}
	
	public static ResultSet query(String sql,Object obj[]){
		getconn();
		System.out.println("conn : "+conn);
		try {
			ps=conn.prepareStatement(sql);
			if(obj!=null){
				for(int i=0;i<obj.length;i++){
					ps.setObject(i+1, obj[i]);
				}
			}
			
			res=ps.executeQuery();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return res;
	}
	
	public static void close(){
		try {
			if(res!=null){
				res.close();
			}
			if(ps!=null){
				ps.close();
			}
			if(conn!=null){
				conn.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	
	
	

}
