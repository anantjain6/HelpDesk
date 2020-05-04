package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.ConnectionProvider;

/**
 * Servlet implementation class RatingAdd
 */
public class RatingAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RatingAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		try {

			Connection con=ConnectionProvider.getConnection();
			PreparedStatement ps=con.prepareStatement("insert into ratings values(?,?,?)");
			
			ps.setInt(1, (int) session.getAttribute("id"));
			ps.setInt(2, Integer.parseInt(request.getParameter("articleId")));
			ps.setInt(3, Integer.parseInt(request.getParameter("rating")));
			
			ps.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		session.setAttribute("msg", "Article rated successfully.");
		session.setAttribute("class", "alert-success");
		response.sendRedirect(request.getHeader("Referer"));
		
	}

}
