package controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import util.ConnectionProvider;

/**
 * Servlet implementation class ComplaintAdd
 */
public class ComplaintAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplaintAdd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession();
		try {

			Connection con=ConnectionProvider.getConnection();
			PreparedStatement ps=con.prepareStatement("select nvl(max(id),0) from complaints");
			
			ResultSet rs=ps.executeQuery();
			int max=0;
			
			if(rs.next())
			{
				max=rs.getInt(1);
				max++;
			}
			
			ps=con.prepareStatement("insert into complaints(id,title,description,dept_id,category_id,user_id,open,status) values(?,?,?,?,?,?,sysdate,0)");
			
			ps.setInt(1, max);
			ps.setString(2, request.getParameter("title"));
			ps.setString(3, request.getParameter("description"));
			ps.setString(4, request.getParameter("departments"));
			ps.setString(5, request.getParameter("categories"));
			ps.setInt(6, (int)session.getAttribute("id"));

			ps.executeUpdate();
					
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		session.setAttribute("msg", "Complaint added successfully.");
		session.setAttribute("class", "alert-success");
		response.sendRedirect(request.getContextPath() + "/employee/complaint/show.jsp");
	}

}
