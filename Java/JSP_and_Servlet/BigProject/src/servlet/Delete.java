package servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import MysqlManner.MannerAppointment;
import MysqlManner.MannerBookMenu;

/**
 * Servlet implementation class Delete
 */
@WebServlet("/Delete")
public class Delete extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Delete() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		String user=request.getParameter("user");
		int bookid=Integer.parseInt(request.getParameter("bookID"));
		String bookname=request.getParameter("bookname");
		MannerAppointment mannerAppointment=new MannerAppointment();
		mannerAppointment.deleteAppointment(user, bookid);
		MannerBookMenu mannerBookMenu=new MannerBookMenu();
		mannerBookMenu.returnBook(mannerBookMenu.Search(bookname));
		response.setHeader("refresh","0;url=appoiment.jsp"); 

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
