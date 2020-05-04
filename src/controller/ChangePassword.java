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
 * Servlet implementation class ChangePassword
 */
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePassword() {
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
		
		String oldPassword=request.getParameter("oldPassword");
		String newPassword=request.getParameter("newPassword");
		String confirmNewPassword=request.getParameter("confirmNewPassword");
		
		HttpSession session = request.getSession();

		int user_id = (int) session.getAttribute("id");
		try {
			Connection con=ConnectionProvider.getConnection();
			PreparedStatement ps = con.prepareStatement("select * from users where id=?");
			
			ps.setInt(1, user_id);
			ResultSet rs=ps.executeQuery();
			
			String oldPass="";
			if(rs.next())
			{
				oldPass=rs.getString(5);
			}
			
			if(oldPass.equals(oldPassword))
			{
				if(newPassword.length()<8)
				{
					session.setAttribute("msg", "Password length must be of atleast 8 charcters.");
					session.setAttribute("class", "alert-danger");
					response.sendRedirect(request.getContextPath() + "/user/changepassword.jsp");
				}
				else if(newPassword.equals(confirmNewPassword) )
				{
					ps=con.prepareStatement("update users set password = ? where id = ? ");
					ps.setString(1, confirmNewPassword);
					ps.setInt(2, user_id);
					
					ps.executeUpdate();
					
					session.setAttribute("msg", "Password changed successfully.");
					session.setAttribute("class", "alert-success");
					response.sendRedirect(request.getContextPath() + "/user/changepassword.jsp");
				}
				else
				{
					session.setAttribute("msg", "New password do not match.");
					session.setAttribute("class", "alert-danger");
					response.sendRedirect(request.getContextPath() + "/user/changepassword.jsp");
				}
			}
			else
			{
				session.setAttribute("msg", "Old password is incorrect.");
				session.setAttribute("class", "alert-danger");
				response.sendRedirect(request.getContextPath() + "/user/changepassword.jsp");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
