package servlet;

import java.io.IOException;
import java.io.OutputStream;
import java.sql.Blob;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class getPicture
 */
@WebServlet("/getPicture")
public class getPicture extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public getPicture() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Blob b=(Blob) request.getSession().getAttribute("bookPicture") ;
      long size = 0;
	try {
		size = b.length();
	} catch (SQLException e) {
		
		e.printStackTrace();
	}
      byte[] bs = null;
	try {
		bs = b.getBytes(1, (int)size);
	} catch (SQLException e) {
		
		e.printStackTrace();
	}
      response.setContentType("image/jpeg");
      OutputStream uts = response.getOutputStream();
      uts.write(bs);
      uts.flush(); 
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
