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
 * Servlet implementation class Login
 */
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			Connection con = ConnectionProvider.getConnection();
			PreparedStatement ps=con.prepareStatement("select * from users where email=? and password=?");
			ps.setString(1, request.getParameter("email"));
			ps.setString(2, request.getParameter("password"));
			ResultSet rs=ps.executeQuery();
			
			HttpSession session = request.getSession();
			
			if(rs.next()) {
				session.setAttribute("email", request.getParameter("email"));
				session.setAttribute("id", rs.getInt(1));
				session.setAttribute("name", rs.getString(3));
				session.setAttribute("usertype", rs.getInt(6));
				if(rs.getInt(6) == 0) {
					response.sendRedirect("employee/home.jsp");
				} else if (rs.getInt(6) == 1) {
					response.sendRedirect("technician/home.jsp");
				} else if (rs.getInt(6) == 2) {
					response.sendRedirect("admin/home.jsp");
				}
			} else {
				session.setAttribute("msg", "Invalid email or password");
				session.setAttribute("class", "alert-danger");
				response.sendRedirect("index.jsp");
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
