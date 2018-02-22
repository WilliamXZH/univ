package servlet;

import java.io.IOException;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import MysqlManner.MannerAppointment;
import MysqlManner.MannerBookMenu;
import book_user.Appointment;
import book_user.BookMenu;

/**
 * Servlet implementation class Appoiment
 */
@WebServlet("/Appoiment")
public class Appoiment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Appoiment() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=utf-8");
		Date x=new Date();
		java.sql.Date AppointmentDate=new java.sql.Date(x.getTime());
		java.sql.Date BeforeDate=new  java.sql.Date(x.getTime()+(long)24*60*60*1000);
		String bookname=request.getParameter("Name");
		System.out.println(bookname);
 
		MannerBookMenu mBookMenu=new MannerBookMenu();
		MannerAppointment mannerAppointment=new MannerAppointment();
		BookMenu bMenu=mBookMenu.Search(bookname);
		Appointment appointment=new Appointment(bMenu.getId(), bMenu.getName(), (String)request.getSession().getAttribute("name"), AppointmentDate, BeforeDate);
		int i=mannerAppointment.addAppointment(appointment);
		if (i==3) {
			mBookMenu.deleteBook(bMenu);
			response.setHeader("refresh","0;url=appoiment.jsp"); 

		}
		else if(i==1){
			response.getWriter().println("操作失败您已经预约过此书...");
			response.setHeader("refresh","2;url=personindex.jsp"); 

		}else if(i==2) {
			response.getWriter().println("操作失败您已经借阅过此书...");
			response.setHeader("refresh","2;url=personindex.jsp"); 
		}
		

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
