package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.ConnectionProvider;

/**
 * Servlet implementation class FaqAdd
 */
public class FaqAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String question=request.getParameter("question");
		String answer=request.getParameter("answer");
		

		try {
			Connection con=ConnectionProvider.getConnection();
			PreparedStatement ps=con.prepareStatement("select nvl(max(id),0) from faq");
			ResultSet rs=ps.executeQuery();
			
			int max=0;
			if(rs.next())
			{
				max=rs.getInt(1);
				max++;
			}
			
			ps=con.prepareStatement("insert into faq values(?,?,?,?,sysdate)");
			ps.setInt(1, max);
			ps.setString(2, question);
			ps.setString(3, answer);
			
			HttpSession session = request.getSession();
			int user_id = (int) session.getAttribute("id");
			
			ps.setInt(4, user_id);
			
			ps.executeUpdate();
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("msg", "FAQ added successfully.");
		session.setAttribute("class", "alert-success");
		response.sendRedirect(request.getContextPath() + "/admin/faq/add.jsp");
	}

}
