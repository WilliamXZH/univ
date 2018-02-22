package com.muke;

import MysqlManner.Link;
import MysqlManner.MannerUser;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginServlet extends HttpServlet{
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
		MannerUser mUser=new MannerUser();
		int i=0;	
		String username = request.getParameter("name");
		String password = request.getParameter("password");

		String piccode = (String) request.getSession().getAttribute("piccode");
		String checkcode = request.getParameter("checkcode");
		  
		checkcode = checkcode.toUpperCase();
		response.setContentType("text/html;charset=gbk");
		PrintWriter out = response.getWriter();
		login(username,password);
	}
	
	public int login(String name,String password){
		boolean b=true;
		int a = 0;
		Connection conn = null;
		String sql;
		try {
			conn = Link.getConn();
			Statement stmt = conn.createStatement();
			sql = "select * from user";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getString(1).equals(name)) {
					if (rs.getString(2).equals(password)) {
						System.out.println(name+"：登陆成功");
						System.out.println("1");
						b=false;
						a= 1;
					}
					else {
						System.out.println(name+"：密码错误");
						System.out.println("2");
						b=false;
						a= 2;
					}
				}
			}
			if (b) {
				System.out.println(name+"用户不存在");
				System.out.println("3");
				a= 3;

			}
			} catch (SQLException e) {
			System.out.println("MySQL操作错误");
			e.printStackTrace();
			} catch (Exception e) {
			e.printStackTrace();
			}finally {
				try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		return a;		
	}
	
}
