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
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Login() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html;charset=utf-8");
		request.setCharacterEncoding("utf-8");
		PrintWriter printWriter=response.getWriter();
		String name=request.getParameter("UserName");
		String password=request.getParameter("Password");
		System.out.println("账户名"+name);
		boolean b=true;
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
						printWriter.println(name+"：登陆成功");
						System.out.println("1");
						b=false;
					}
					else {
						printWriter.println(name+"：密码错误");
						System.out.println("2");

						b=false;
					}
				}
			}
			if (b) {
				printWriter.println(name+"用户不存在");
				System.out.println("3");


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
					e.printStackTrace();
				}
			}		
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
