package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MysqlManner.Link;

@WebServlet("/Regist")
public class Regist extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public Regist() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter printWriter=response.getWriter();
		String name=request.getParameter("UserName");
		String password=request.getParameter("Password");
		System.out.println(name);
		Connection conn=Link.getConn();
		boolean b=true;
		String sql;
		try {
			Statement stmt = conn.createStatement();
			sql = "select * from User";
			ResultSet rs = stmt.executeQuery(sql);
			while (rs.next()) {
				if (rs.getString(1).equals(name)) {
					
					b=false;
					break;
				}
			}
			if (b) {
				sql = "insert into user(UserName,UserPassword) values('"+name+"','"+password+"')";
				stmt.executeUpdate(sql);
				printWriter.println(name+"注册成功");
			}
			else{
				printWriter.println("注册失败:该用户名已注册");
			}
			sql = "select * from user";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
			System.out.println(rs.getString(1) + "\t" + rs.getString(2));
			}
			} catch (SQLException e) {
			e.printStackTrace();
			} catch (Exception e) {
			e.printStackTrace();
			}finally {
				try {
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}	
	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
