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

import util.ConnectionProvider;

/**
 * Servlet implementation class ComplaintAssign
 */
public class ComplaintAssign extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ComplaintAssign() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		int id=Integer.parseInt(request.getParameter("complaintId"));
		int technicianId=Integer.parseInt(request.getParameter("technicianId"));
		int priority=Integer.parseInt(request.getParameter("priority"));
		
	
		try {
			Connection con=ConnectionProvider.getConnection();
			PreparedStatement ps=con.prepareStatement("select * from complaints where id=? ");
			ps.setInt(1, id);
			
			ResultSet rs=ps.executeQuery();
			
			if(rs.next())
			{
				ps=con.prepareStatement("update complaints set TECHNICIAN_ID=? , PRIORITY=? where id=?");
				ps.setInt(1, technicianId);
				ps.setInt(2, priority);
				ps.setInt(3, id);
				
				ps.executeUpdate();
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HttpSession session = request.getSession();

		session.setAttribute("msg", "Complaint assigned successfully.");
		session.setAttribute("class", "alert-success");
		response.sendRedirect(request.getContextPath() + "/admin/complaint/unassigned.jsp");
	}

}
