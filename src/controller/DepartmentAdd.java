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
 * Servlet implementation class DepartmentAdd
 */
public class DepartmentAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public DepartmentAdd() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		try{  
			Connection con=ConnectionProvider.getConnection() ;  
			PreparedStatement ps=con.prepareStatement("select nvl(max(id),0) from departments");

			ResultSet rs=ps.executeQuery();
			int max=0;
			if(rs.next())
			{
				max=rs.getInt(1);
				max++;
			}

			ps=con.prepareStatement("Insert into departments values(?,?)");
			ps.setInt(1, max);
			ps.setString(2, request.getParameter("name"));

			ps.executeUpdate();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		HttpSession session = request.getSession();
		session.setAttribute("msg", "Department added successfully.");
		session.setAttribute("class", "alert-success");
		response.sendRedirect(request.getContextPath() + "/admin/department/add.jsp");
	}

}