package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.ConnectionProvider;

/**
 * Servlet implementation class ArticleEdit
 */
public class ArticleEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArticleEdit() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		try {
			//Connection con = new MyDBConnection().openConnection();
			

			Connection con=ConnectionProvider.getConnection();
			PreparedStatement ps=con.prepareStatement("update articles set title = ? ,content = ? where id = ?");
			
			ps.setString(1, request.getParameter("title"));
			ps.setString(2, request.getParameter("content"));
			ps.setInt(3, Integer.parseInt(request.getParameter("id")));
			
			ps.executeUpdate();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		HttpSession session = request.getSession();
		session.setAttribute("msg", "Article updated successfully.");
		session.setAttribute("class", "alert-success");
		response.sendRedirect(request.getContextPath() + "/admin/article/show.jsp");
	}

}
